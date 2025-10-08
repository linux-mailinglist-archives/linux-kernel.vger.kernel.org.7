Return-Path: <linux-kernel+bounces-845347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC98BC4881
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0BD24EC7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A3B2EC0B5;
	Wed,  8 Oct 2025 11:19:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2861D95A3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922371; cv=none; b=Fp9gHu3eTlJul0+HcOQaL+q2/cF/me3WXPMjhLOTX8HtPhYhc7QxTIQEU/vmvKPA/gVss81gDpXOEE5wVse3jAKfcdPDWa9tgEi6xSbrn+bIyK+SjGT95tclP0EbLspM4nqt4Ez1lFmVUcdzIiMNZdv7PzYc77H0PoMPFc50DEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922371; c=relaxed/simple;
	bh=yqm9uziGZRLVLkTR7mGhsq0j/8l9Hgkqke8/vTtrqvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9ut5ilp/9nieJpvbDBmHQnZOC1fddvCdBkmpQzp90Uh8VMjVdEQGnj4gBHoxx1igsdx9zCn+acOXh+sd7j2I3pkB77jiaCklma7gxJqi1nUURPqMwIpb/eY8LmpxNiSYhajte/gnTXp78TIVBnER/vv5rqd0UFVMdX2j5M1y6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE0222FC;
	Wed,  8 Oct 2025 04:19:21 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DF243F66E;
	Wed,  8 Oct 2025 04:19:27 -0700 (PDT)
Date: Wed, 8 Oct 2025 12:19:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Li Mengchen <mengchenli64@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kgdb: Ensure atomic single-step execution
Message-ID: <aOZIusaX-fpeLAz4@J2N7QTR9R3>
References: <1756972043-12854-1-git-send-email-mengchenli64@gmail.com>
 <aNPiUbdRhaRklebF@J2N7QTR9R3>
 <CAEkTZs2x4RzUbYWXO=B1ZGtxycbryNT4YbROH2k_k+0L_B6Erg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkTZs2x4RzUbYWXO=B1ZGtxycbryNT4YbROH2k_k+0L_B6Erg@mail.gmail.com>

On Wed, Oct 08, 2025 at 09:01:22AM +0800, Li Mengchen wrote:
> I am writing to address a persistent issue in the community’s code
> related to single-step tracing, which has remained unresolved for over
> a decade. The code I have provided has been extensively tested and
> proven to work across multiple hardware platforms and kernel versions,
> from 3.10 to the latest releases. Its correctness and effectiveness
> are not up for debate.

There is no debate; it is a statement of fact that those changes are
incomplete (e.g. failing to address other asynchronous exceptions),
incorrect (e.g. erroneously *unmasking* interrupts in some cases), and
contain unjustified changes which are themselves incorrect (e.g. using
task_pt_regs(), which *never* contains kernel register state).

I appreciate that those changes may be sufficient in the scenarios that
you have tested, but as I have already commented (with examples), there
are real scenarios where those changes make matters worse.

I agree that there are some longstanding issues here, but (as-is) the
changes you have proposed are not a suitable solution.

Mark.

