Return-Path: <linux-kernel+bounces-784651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32FB33F21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D9D1A824ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041F91991D2;
	Mon, 25 Aug 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SiTK9h48"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF931EA80;
	Mon, 25 Aug 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124154; cv=none; b=pbsdaEhABxFGNYizSrKXgkmU6+Rt4xbsdZQ3XE9wgjE60YvxHhxF/X1AFYxjm+aeCpdannwisqzvdo45hLZnGjZmuDEMsXTf4JQrQDibMvWvxwm7doCenwI5yFgPnwdVMkQ4HM3RceSn01JEwKvlTF5tFdGdkplQBElO5nvhoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124154; c=relaxed/simple;
	bh=r1U17WJMlurUl4uRvTX5DZlKiRuoBMu2MYV3lfiL9Zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyYr2dC5LYP212CWGBFvHBmqD0sMcdR/EW7fvcKR7Ef5MDdFhrDN43YY40PSEUg8qG8pFC3J64zvaNSPtu5vnJw7uPp6GvVcPf/BoCeS6h6jQAHOD5D2owTuPJ3Eg14EDM1A2HzwWR2ljd/IhBQ51HSdLLN4zCmICFv17GxH4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SiTK9h48; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 341CD40ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756124151; bh=C4FVjoqZYCy4iJrUlUKji+FuD2rkKct8Ps3MSXBCIpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SiTK9h48WbW9/M2FF/gb0kJhn7No5Xvh4ixoUv0WMXsYcyRCqIWosDzztH7SOkh0V
	 AV4evwKfNhn7L6dMQQ776NqzhgC/n//z+hKUpaWXWJOSo8mk7vEgOXBnPah9IfHmJR
	 Z5Ecb1o/KExXMshEF4YtswyGpw85O2ekgjI89u+juGfN2GHDNzPbPTGhHd/qglLDMY
	 zYrk/tzmI5d053tCdk7QnHNabi5tt2vuuqDPs2ZOmpv2PFNtxmQ+SY/HZtcHyiyWQa
	 8iucdjUiv0dtkJCSr7rJCaPG67NHQDLGMo0lwEQ8wJ4tPJ5tpzieWeo/X6wX9N4W4r
	 0y8gtFs0Wp0xQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 341CD40ADA;
	Mon, 25 Aug 2025 12:15:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
In-Reply-To: <20250825140719.18ba8459@foz.lan>
References: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
 <f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
 <fa7rreuvodpe673lwcwlj6kddkpnmkoxlz4y5mythgntkmveey@m5fqvtsuel6l>
 <87sehjdlz5.fsf@trenco.lwn.net> <20250825140719.18ba8459@foz.lan>
Date: Mon, 25 Aug 2025 06:15:49 -0600
Message-ID: <87ldn7d2bu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Fri, 22 Aug 2025 16:34:38 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>> Can we try to get a handle on that and, if it's truly needed, document
>> why?  I will confess that I'm confused by it:
>> 
>> > \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}  
>> 
>> As I understand it, the arguments are {options}{package}, right?  so I'm
>> not sure how this would work...?
>
> Heh, you're right: the argument is reversed. Also, I repeated the
> tests here, and were unable to reproduce the issue I had with xindy.

Just to get the credit where it is due, it's Akira who first pointed
this out.

> So, let's just drop it. If we needed, we can re-add, reverting the
> parameter order there. Patch is at:
>
> 	https://lore.kernel.org/linux-doc/83068bc31839e7095f1f408e49658362d467797e.1756123459.git.mchehab+huawei@kernel.org/T/#u

OK I'll get there.

Thanks,

jon

