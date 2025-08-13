Return-Path: <linux-kernel+bounces-767046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD8FB24E60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC05A45C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736728AAE0;
	Wed, 13 Aug 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="o0BrNSLE"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE506286880;
	Wed, 13 Aug 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099968; cv=none; b=gnXQ6oGcPCDwsjuwBVJ60eTllBiiQD6SrpcnEQev/9BSdrFGIf307Swquh/Hy09FEEK6izQ/hGziH1nfHVThygjld+Bm6lJD8wBvqZxmaU4MhebAGG1Y29uohs8ngXg+HXW/7eOa2jmLXWeFGgAeiN+DuzP3h+1oFvCHLsoKzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099968; c=relaxed/simple;
	bh=d/C33EXjm/6+qKvNtNHtl+L5YWt8TzZvu5f1CMf0/nU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/GRAjEbb8IYiGlYAbAwQyRUYjsKxD8D3SBdbolYIdASVenN4ybFxtKirvS/LXkdsBnKiR7K8Mox45ew5UWJbqMnceCW5eMprf+MFzp35iV+Drc5joLNLxY9hOKmlP//Bu3tw0CuPwB81kAgJqxxggz42VRUfuHRv2v3lCorU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=o0BrNSLE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1DF8640AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755099965; bh=rXQ8Sky/uRqEscPkUKF1TfXzZUMT2wiirGFi1ETcn+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o0BrNSLEIxslHuvbdfiKlMaitG4LDri7uzLX2IH69l3c29Mv3uCHFY/St+H/1lWZR
	 uWJw8Ufv+LoHQIVpHFqwlJgctLZc6IWCRj5ddUQRsoD7mh3D277j/Evs4ZCWBKVSVn
	 vqlUa4PdL2Xp8dEtCv/MCC7Bbh/Fm4Vu9PA1GgJjDyPJDyAjF3QNsgzJgz12VSyqv7
	 K8V8/PsJeOdVmFaX5fa41LH7DsUc7Da6qDSOZHJ5SxlvbXGvBk/W8RHhyTlVxCVky3
	 6bV5WgteN3RoUjfctpYCtPMhnSlmYisrNwnofPOuLMVQIFMx1VHd+lY1LmyrbjjPw9
	 Hx9waM3tFuwWQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1DF8640AD5;
	Wed, 13 Aug 2025 15:46:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 3/7] docs: kdoc: clean up the create_parameter_list()
 "first arg" logic
In-Reply-To: <20250813011746.6779c0f1@foz.lan>
References: <20250812195748.124402-1-corbet@lwn.net>
 <20250812195748.124402-4-corbet@lwn.net> <20250813011746.6779c0f1@foz.lan>
Date: Wed, 13 Aug 2025 09:46:04 -0600
Message-ID: <87o6sjb4xv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> +                #
>> +                # args[0] has a string of "type a".  If "a" includes an [array]
>> +                # declaration, we want to not be fooled by any white space inside
>> +                # the brackets, so detect and handle that case specially.
>> +                #
>> +                r = KernRe(r'^([^[\]]*\s+)' r'((?:.*?\[.*\].*)|(?:.*?))$')
>
> Same comment as patch 6/7... concats in the middle of the like IMO makes it
> harder to read. Better to place them on separate lines:
>
> 	r = KernRe(r'^([^[\]]*\s+)'
> 		   r'((?:.*?\[.*\].*)|(?:.*?))$')

So I went to do this, and realized that the second chunk of the regex is
really just a complex way of saying "(.*)$" - so I'll make it just that,
at which point splitting up the string seems a bit excessive.

Thanks,

jon

