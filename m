Return-Path: <linux-kernel+bounces-771397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5CAB28674
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3ECAA5C39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F85236A70;
	Fri, 15 Aug 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="d467waA6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD431A317D;
	Fri, 15 Aug 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286309; cv=none; b=axdc/6iz2+KCPeo60cQ9suVuN4/YAIsi5oPs0dElcJTQ0a0jiTvFijRkzbR+gzv7I9au2I3d9xvQVc/2+BeNprow6n8lRDbVOkkHWil16kzNBchONmGrhyFkPvEWlPZCVw2TFijzcr6l75BZlE9N7uvzgP5qBKynbMrJLcB52S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286309; c=relaxed/simple;
	bh=b0UVwRc9cc22D51mdHrR0YFUZ9B/PwS6AYr9N5t5WcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yz2nQD/YIXWKQQYHAnMOHqcnbC1cq5EfWgA4NfSN15HcUsbS4VUyrRCcinSwZVLD9DLKl6Si8ur3WdIXd48vUw8nwnhpHKh0r4WQ2zOOcEuXCuI38UrIPFda9zCzcPSl8W8FEqAxYunvFVSvcMJrA+7jHjy2x81d14yx8fURMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=d467waA6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE3EB40AD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755286306; bh=kAjB3uHTsSIgD3/BTLSqoSTkF9t7gtXVyuuOWiasw4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d467waA6rahVgMt+h/8Qtt50YDqQRNtLICTwqYnCLsItM1l0spN1MTmGstWWVRY5F
	 r2limmQS2W3RU6P8WfxT0tVaJDDk6cP5/H8Jbuslq6gb9R7DqmOCMZslchfyia5FYi
	 MtjzXVH7ic2KezuNfMls6DIqlQNx4q4AYG4aDdCQb3EOvLRXyrXaJILADiSQLJdjWo
	 BoIcjAQBztL5zVVr2zmqx/eBlvmYXY55HW7kB1ZHIEbydmNHtDSdoAKX43d5Aq55r4
	 V8lM/uRkTBSCDJ/RaG4E8+sd9E4YE1HhcNyLrrlNQ3TMrH0W0N4tHkpVeSE217rSDn
	 oUIHRcTD66OLw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BE3EB40AD7;
	Fri, 15 Aug 2025 19:31:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
In-Reply-To: <20250815171342.3006f30a@sal.lan>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-8-corbet@lwn.net> <20250814013600.5aec0521@foz.lan>
 <871ppehcod.fsf@trenco.lwn.net> <20250814080539.2218eb4e@foz.lan>
 <87wm76f1t5.fsf@trenco.lwn.net> <20250815071829.3d5163fc@foz.lan>
 <87sehsen9g.fsf@trenco.lwn.net> <20250815171342.3006f30a@sal.lan>
Date: Fri, 15 Aug 2025 13:31:45 -0600
Message-ID: <87ms80crfi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> I'm not sure we need the common/docs intermediate directory.
>> 
>> Meanwhile, I had a related, possibly unpopular idea...  Start with
>> .../tools/python/kernel and put a basic __init__.py file there;
>> everything else would go into that directory or before.  The imports
>> would then read something like:
>> 
>>   from kernel import abi_parser
>
> Not against something similar to it, but IMO "kernel" is a bad
> name as it sounds something that runs in kernel stace or for Kernel
> build. It could be, instead:
>
> 	from lib import abi_parser

Part of my purpose was to make it clear that the import was coming from
our own library - to distinguish it from all of the other imports that
these programs have.  "Kernel" seems good to me, but we could call it
"kernel_lib" or some such if we really want.  "lib" seems too generic.

> Yet, I guess it may still need to add something at PATH, depending from
> where current working dir the script was called (but tests required).

That seems hard to avoid, yes.

Of course, we could require that all kernel tools run in a special
virtualenv :)

> Btw, nothing prevents moving extensions from Documentation/sphinx
> into tools/sphinx_extensions. We just need to add the path insert
> at conf.py.

I feel less of a need to do that; it seems that the Sphinx-specific
stuff can stay where it is.  Though I guess I wouldn't scream too loud
if people really wanted to do that move.

Thanks,

jon

