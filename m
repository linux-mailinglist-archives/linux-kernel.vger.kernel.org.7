Return-Path: <linux-kernel+bounces-817387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE6B58192
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A85205ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2E23D7DA;
	Mon, 15 Sep 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="hPs/bBAP"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1E236457
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952330; cv=none; b=acJFTvlwc/LMjW036CxOA5QkLAqQdsHqxz9dLXECQcjjmXanH9p5AvlPiGZoIkYoFpTFfdlXsUIqzGsn0ef9x/3pvDuArIAxRGiL77yx1709JFlpK6ZsX71FwaL1GiITe3K5WdSltMrxzygm5uv4rKh9R5yztFe6scCmzHflfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952330; c=relaxed/simple;
	bh=xCBYprqnCAui1Y9yA5Rnh0XOuIx2VMNSekAkTzQdC7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ig+gDHsweRf4mYGqAUeLHUqhKOf4drJeB2oMbLjRasT/uNv+mADa+OPUHrc5bW39eSME/TUPP/OVL6mmvSjYKcOjcYVGSCgiCvMpGBpZC0rI7D6nShyE3pcgt4H+fPinIjdwxol3rqWKfkAi6dnW7VjlAGTYovyzfMhWCDd5kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=hPs/bBAP; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757952328;
	bh=xCBYprqnCAui1Y9yA5Rnh0XOuIx2VMNSekAkTzQdC7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hPs/bBAPCaFLuPghdzk/XRSqW4i98Gy4h1H2qJpa6/WGYR2SuKBpJUqS9B3uEJvnZ
	 KN/xyyYMZ2cxsYBoUF8SvMz8KwELep19ZNSb74hFeUEUCTNT+4mEfv9Ay9P/IYuLz3
	 1p2Jmqnlt4TNrYRTt7gaUrruy0V2uVqOlKxDb8Ks=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7B5E84034A; Mon, 15 Sep 2025 09:05:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7A8F840345;
	Mon, 15 Sep 2025 09:05:28 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:05:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active
 on local CPU
In-Reply-To: <aLcfvIfFb6xD-NXp@arm.com>
Message-ID: <783f9164-f92e-4a94-cc6f-ad75c83b273b@gentwo.org>
References: <20250829153510.2401161-1-ryan.roberts@arm.com> <aLcfvIfFb6xD-NXp@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Sep 2025, Catalin Marinas wrote:

> Christoph Lameter (Ampere) also followed with some refactoring in this
> area to allow a boot-configurable way to do TLBI via IS ops or IPI:
>
> https://lore.kernel.org/linux-arm-kernel/20231207035703.158053467@gentwo.org/
>
> (for some reason, the patches did not make it to the list, I have them
> in my inbox if you are interested)

The patchset is available from kernel.org. Sorry about the mailing list
problems at that time.

https://git.kernel.org/pub/scm/linux/kernel/git/christoph/linux.git/log/?h=tlb

