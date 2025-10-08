Return-Path: <linux-kernel+bounces-845208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A9BC3E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 687DF4E02F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655532F3618;
	Wed,  8 Oct 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGC93WON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E32EB851
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913009; cv=none; b=qL2KVIuIVkDK0KRmhKLXnRJfUF3BSPt2RolbMfaNoVd3GgW28ZhlnfHEXl7PWcq8eXNRTeumfU/Uilua7b0o7wpkGBicAP6oKsrxvkgP6MVBavoQljTe0ZYBYn1iII87N3LpbAzNZGjVqUw3CuRtR1h12mi4UFN3sc6/XaMUFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913009; c=relaxed/simple;
	bh=8OIe0p1Hm72TWcZ007AOZ5v4Wu/FbHR/ip6j0BQUFzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmiqN6LBzS5UH8m0smCgPo9T7olooFaOwSekDIeHuIQ96Nr3coLgPpHhLgtg974mdHuuO6GJmDthTy4GVrR+UGvqe2G8Oo//yU5yUw/7ghthTxJm06SS9KDlR/5vzLfkyRoxkDZqUPP0AxfzCOarlfMhevUz+2UiRNl9bqgsPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGC93WON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1F0C4CEF9;
	Wed,  8 Oct 2025 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759913009;
	bh=8OIe0p1Hm72TWcZ007AOZ5v4Wu/FbHR/ip6j0BQUFzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGC93WONLn2hBON0l0RHXZ0oOiPOzZXazbIFXUy3uzdG0uLQYRXZvHQkSBb8FBgGt
	 eA+xBTRVHfzDMB0xssKDbYwjQ6B/9sF74n4fYbfaTI9arfSxuk72+PdeD1/cPSMvMb
	 FYB4a8dU0+8I16AMgfMhXkUgGz16aAPN4M2WrGJJ+I1KSnuDv1+VnBIP37vPmh1xdi
	 GVhgE3RUOnYrdZpF3QfbSUcSThVlb3CLTYyf2SXUu80LNYOyu3oQhoemzfp6Q1nSn6
	 m5DFa0/pjzXrSOtH6Xv+2fQiII94sM/164+ouIDVI9yA9kjqIsOJDQuLoaUqv6Gqyx
	 jB9wcsgEsgsUA==
Date: Wed, 8 Oct 2025 09:43:24 +0100
From: Will Deacon <will@kernel.org>
To: Li Mengchen <mengchenli64@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kgdb: Ensure atomic single-step execution
Message-ID: <aOYkLOz9enrTaVVk@willie-the-truck>
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
>    I am writing to address a persistent issue in the community’s code related
>    to single-step tracing, which has remained unresolved for over a decade.
>    The code I have provided has been extensively tested and proven to work
>    across multiple hardware platforms and kernel versions, from 3.10 to the
>    latest releases. Its correctness and effectiveness are not up for debate.

Ha! You're joking, right?

If you're not willing to discuss the details of your patch then I guess
I can just delete it instead. If you change your mind, please respond
to Mark's comments, thanks.

Will

