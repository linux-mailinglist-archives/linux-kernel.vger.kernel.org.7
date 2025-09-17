Return-Path: <linux-kernel+bounces-821108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C6B80706
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015C33ADBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82AE32E726;
	Wed, 17 Sep 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DpPsVx+S"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6002F49EB;
	Wed, 17 Sep 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121872; cv=none; b=szj12TX+s8yNRGZM6Rn93821EMl49uM/ksrzv9Jrt89/ywmUvUKYq49qfQaHz1fJf+3wwpvc8Gn8hZQpBgz3amJZ91DMaqHmdLifPiocSGRJulw86kEvHLfI4SFrM13nm7VPnRUVr8UfvBcdYhIpJ/cmV3E62AMTKkAGDuQsjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121872; c=relaxed/simple;
	bh=Zr9ly5vUCTSEt2ECzSEbT3wV+t5UqSaNiO+FAr4ESxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YngckJ7H1CYkr4DMNvZLdzkOt4By/Glexy6G4vLN9heSGVDK1Y6Fd1VE2pAUlkP4hqYeGYMzd4WooN6TUoEUZ1gWJJa0ImceHcWw3CbSCF1b/SMxx6J5uZcq8dIhJFUUoyttPa/tzCzMjWeb+GZVduPi1fuxP7hYBboBjyhR/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DpPsVx+S; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BA2A240AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758121862; bh=6l5JXS0ooZIaiqsm0blDM5iBQJ72/GZBEez8roRV8F0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DpPsVx+SyU+34gLPGZe4OEi6BJlJL/auCV9k+1gg7M+XYd1RpIzzZ0LGE5U3J+wdk
	 mFu3a+AzU/cAA/NSnVo/re3RXF+45mC+12D0HJngTaDNq2Jao3EXf8BD83MdpgXxQI
	 wi5zntCePzTNZC+7AUQNnsnAuflCSD7MGcsN/ckCa/rb+Q8HzlRqyPXDPmogeywgG+
	 PVbXyCjBisNzPq666fzi23jBY4ANy+r9DwXR4QITn1OeSBjjjP7CV6+gVntkCTHVDA
	 pjrSfwgiO5Q4SsvOsDomSZyCw+ENK0z4CyuUq3G4WDOCYSmb3aCyJhG003Aq6kp5DQ
	 LpkztrmZYKIEg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BA2A240AFB;
	Wed, 17 Sep 2025 15:11:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, mchehab+huawei@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jani Nikula
 <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v6 10/21] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
References: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
 <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
Date: Wed, 17 Sep 2025 09:11:01 -0600
Message-ID: <875xdhazcq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Wait!  In the cover-letter, you said:
>
>     It should be noticed that it is out of the scope of this series
>     to change the implementation. Surely the process can be improved,
>     but first let's consolidate and document everything on a single
>     place.
>
> Removing current restriction on SPHINXDIRS does look inconsistent with
> your own words to me.
>
> So, I guess I have to NAK 06/21 as well.

Is there an actual problem with this change that we need to know about?
I am not quite understanding the objection here.

Thanks,

jon

