Return-Path: <linux-kernel+bounces-782763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4EB32512
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0872C4E187F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A9728A73A;
	Fri, 22 Aug 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s9je1zNh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399520B80D;
	Fri, 22 Aug 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902087; cv=none; b=F0IBRYAUF9/hNeNgvFkKOuOiGkdZxwA0ZoCSqdCKMqs5RzanAxtRfYqYJDVHx3IH8PBTdJwTCDIALpufNQGUh/e5ujfpTgryFUFvamFXmi3dgn0hpeg1Basdm0QWnuXwCVrK97sUyM37nVh3H25RPGHoXALqN2Wyl09lftbPRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902087; c=relaxed/simple;
	bh=QI2/E/bFFxEqQoEs1yOnb71CU1HNTGZ/wOCYxlTlpEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DFwxUbKWx7Di/vqigqq7VfozT1LhVjnMcRXJLv5BHsfEI+G0m/u3o0cuEKTFE2fww/zzJcfZ2AqRrvP+FWfM1k7FX/dg99/68oyu+bwkWYxsu8PBgWA4tohKhM8FCNmVpm6jzDACyO8oXqH0fLlXTMMKkzc+jVNPUbDHOydX++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s9je1zNh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D41D140ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755902079; bh=t8rPWkDB3SHf2JcvGH2JzmaQJM58cY0fUG8mM4lekc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s9je1zNhN/lu7OKtuQZpTfU1eYoZn9c+URZwl0YOS8CqhUUbcYa00wihJDmRUWG/E
	 Cr7FGztnRkYfLKPaD5k5Guyju69tOUH68nA7GMOUmN0a9W8UvyDWk1IJOsaYhQbm9Q
	 4+lPjKjDTdm8MjGx/jBfm8/5prYqLvLPbwR8wowHqNRJHw2GxjQXZLirUayUByCyBN
	 S/YtOFFIcRmBnVnpRh9tgkQNvKVyRIDN9fCi+It0irHFkGj2Bsll+BocLtGGmTjmcf
	 MYDYT5HzH83Wz/lA5yNGO4RDr/SQcOsrf3+eJD6fa2/1WYBhqz7DyUH+Hz2fh1khAS
	 QhJi1UkFd6LSw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D41D140ADA;
	Fri, 22 Aug 2025 22:34:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>
Cc: mchehab+huawei@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
In-Reply-To: <fa7rreuvodpe673lwcwlj6kddkpnmkoxlz4y5mythgntkmveey@m5fqvtsuel6l>
References: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
 <f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
 <fa7rreuvodpe673lwcwlj6kddkpnmkoxlz4y5mythgntkmveey@m5fqvtsuel6l>
Date: Fri, 22 Aug 2025 16:34:38 -0600
Message-ID: <87sehjdlz5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> On Fri, Aug 22, 2025 at 09:01:03PM +0900, Akira Yokosawa wrote:

>> > 3) I got a corner case on one of the distros was using xindy to produce
>> >    indexes. This ended causing the build logic to incorretly try to use
>> >    T1 fontenc, which is not UTF-8 compatible.
>> > 
>> >    This patch adds:
>> > 
>> >         \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
>> > 
>> >    to cover such case. It should be noticed that, as the config doesn't
>> >    have \usepackage{xindy}, this will be used only if latexmk ends
>> >    using xindy.
>> 
>> But I can't see how this macro (executed by XeTeX engine) would have any
>> effect on xindy (command) invoked from latexmk.
>> 
>> Can you elaborate on your theory of how it works?
>> And which distro runs xindy?
>
> I can't remember on what distro I saw the issue, but I got it during
> my builds, where, instead of running makeindex, it tried to run xindy,
> with failed because of utf-8 fonts.
>
> My theory is that, on one of the ditros, there is a /etc/latexmk
> or similar containing instructions to use xindy instead of makeindex.
>
> In any case, this rule is harmless on setups that use makeindex:
> it only affect setups where there is a latexmk or .latexmk file
> setting xindy as the default index builder: if this is used, 
> xindy will use utf-8 fonts instead of Type 1.

Can we try to get a handle on that and, if it's truly needed, document
why?  I will confess that I'm confused by it:

> \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}

As I understand it, the arguments are {options}{package}, right?  so I'm
not sure how this would work...?

Thanks,

jon  (who will be traveling and slow to respond for a bit)

