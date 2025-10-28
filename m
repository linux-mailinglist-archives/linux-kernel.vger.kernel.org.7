Return-Path: <linux-kernel+bounces-874886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA9C174F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6492B3A8410
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38E35029F;
	Tue, 28 Oct 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MJGbioDv"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE236A610;
	Tue, 28 Oct 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693329; cv=none; b=NeVH41Huu4vQPNqAx7TDPEoxz8Hz2vYfr5NMO9Y8mB4PU/yCAHkgsvjImIdoE+5qZWk4STxxXhU1v/LgQOXQrp1UXLbyM9IGTOc2hSTFKE1rEq/BPJUPJYfAT/iah0KRMIqwmfjHl0UX/B1pWd0/CP15+Xdlbg6ctrZxGU9c5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693329; c=relaxed/simple;
	bh=AwYDtIxHcXrf/8CQgv/HaO4YTCDcemflbhRCVLo+HL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESblH1Kziy2MbOpuhNnk0Sft9K5Dn+Vhoo569sQpKoHTOXFs6i1+KkTm64UAnojGMhov5XShzYq32bNFPDM4IGgt0AvhZq3os129BuSZ3r+UXx9bOsoPV5iY4SxTxkc8/yHsumbpgn1Vhnjq6YtOuaRyTkejWuer4S5aB9QcCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MJGbioDv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 76ADB406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761693327; bh=jDPre00EzNNyitF7AcExWzKBL+ieSUg7wcEq6rmy1EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MJGbioDviQJHMNQD35BLQNc7246iq5RboictT5Uvz8kP1FTd1A3yHrLb3I0risJDb
	 RQO8tD9l1gf+6CTdQwcxd7rud4Zhn6cttxdg65FZFNvp4Sp7aepYp6vYQI+/8/d2mE
	 ngy6QNONpcMidVQXIIFNgH4+hhD/KyEmjNSelpuY2x2t+BDykAf0reXNi372uZOorE
	 5h3mxqPhL9bueIgVBt7ISJxgW4A9SK4CZwudAAQteBNwVvfANeHQotiTsqkhcPABxm
	 2r9yA92iftEMT3s+SxWyfyxma8f0/ry7J0a4rWpsUz8aKrMdg3JM0FvELmvx/5OfNH
	 x8ymXU4GJigVQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 76ADB406FB;
	Tue, 28 Oct 2025 23:15:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Jani
 Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
In-Reply-To: <874irkp97o.fsf@trenco.lwn.net>
References: <20251024200834.20644-1-corbet@lwn.net>
 <d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
 <20251026073405.0672c9dd@sal.lan> <874irkp97o.fsf@trenco.lwn.net>
Date: Tue, 28 Oct 2025 17:15:26 -0600
Message-ID: <87h5visjn5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

>> 3. change the core of the logic to be something like:
>> 
>> 	# kerneldoc_bin = env.config.kerneldoc_bin
>> 	kerneldoc_bin = os.environ.get("KERNELDOC")
>> 
>> 	if not kerneldoc_bin:
>> 	   out_style = RestFormat()
>> 	   kfiles = KernelFiles(out_style=out_style, logger=logger)
>> 	else:
>> 	    print(f"Generating C documentation by running {kerneldoc_bin} binary")
>> 
>>    this would still allow using KERNELDOC to point to a binary
>>    that will handle C files executed as a separate process.
>
> This seems like an obvious improvement, and one that, perhaps, should go
> in ahead of my current series in the perhaps vain hope that we're
> finally getting to the end of the list of things I can find to break...
>
> I can send a patch around in the next couple of days if you don't beat
> me to it.

So I have that change working just fine ... only one problem.

For this to work, we have to take out the definition of KERNELDOC in the
top-level Makefile, otherwise we'll never go the import path.  But there
are a few other Makefiles, mostly in the DRM area, that need that
definition.  So I have the docs build working, but I've broken other
things, and I think people are getting tired of me breaking things.

Possible solutions:

- Add a new FORCE_KDOC environment variable that is used instead of
  KERNELDOC to set the program to run in the docs build.

- Keep the current logic that special-cases setting KERNELDOC to
  scripts/kernel-doc.py and really runs in the imported mode in that
  case.

- Go into retirement and let it be somebody else's problem

Anybody have any other great ideas?

Thanks,

jon

