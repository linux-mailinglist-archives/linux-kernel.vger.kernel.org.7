Return-Path: <linux-kernel+bounces-726864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE7B01227
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78EA641E45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BE71A23B6;
	Fri, 11 Jul 2025 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0diEgnt"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06AA933;
	Fri, 11 Jul 2025 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208145; cv=none; b=IayeAJJV4bqt6WU+S++My0cp1M2+V9a8pwv33WC6CrOQhnFAOVOl6fRWCVy3JJaANhLRA08j3XnEmoNO2tQ46G/LUZBB0BdH7j0bilbhmAn/XQNOaPZjSFWVaw8McWixtaToaMXCxdZRZjwTn6lRhwLmGJ+WXV9NoZ/Br7aOKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208145; c=relaxed/simple;
	bh=XjMkPaDLUEXmnWYWJFJpunnRj1nYjQOU+Vs80ZT9Ncc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjQnmWC2EWZ5kGDqPyXkiaAnuuxoq7zv0qInq+xgG2GtPUxkfBVt9Zisnkw9cv5/fDCXmZUNb5UENbGKCqCSPEvgETDQZsJ9UikLPK4otFB72KcBqhGmGgkTvZnIcY3HoFaM8egJKwfYH6lhumSWwDDrM0GaIvB0kUnkiV74pS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0diEgnt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b52bf417cso1222506b3a.0;
        Thu, 10 Jul 2025 21:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752208143; x=1752812943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TWupXdIrDPQsYywPixImzAtxDIdN4drh546kbi5oAY=;
        b=B0diEgntU6QqEEyZTem17vxuhfpo8PMVZ0iInaSB//SnTuN4XXQWo18OnqCCpsQDf+
         U/ZNOd6XUH10Ghq/J4QFAcPUR7VJ0OIpocoshwS8jg/Sip6B3nPSFKHaYijlia8gVCXA
         nyLVBD41mMgInHfw41m9jhfDwQh7Kqe4qbfw7vQG0ZpkRlOMap2h+6/0IzLo4K+9ILp1
         v2mjYjyfTlf0d1UmQbp7/o8p8ak+6ezfzWLyQeA5nDAx25LAI5vMTEADvShoS//TyFkf
         DB6ZCB562SXgRn4VcVaaM3w5y89zAKVQ2lcGPTKqsWaYWqmHqVJt31lWBe7DAZKPl+q7
         emPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752208143; x=1752812943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TWupXdIrDPQsYywPixImzAtxDIdN4drh546kbi5oAY=;
        b=qkJ/EEGk8cCX78GbHLXW66jreVfDHjaNbtEIJBzMZRNYR1lHqNcMm8A0P4ld/ctF6G
         9aPunkZuGzmce4ev+ASqpUt1feI1xa7rN6tdQGui4F4pazP5BORWnBHAXb8wLyTF+AvD
         NV1+A9Qzz9V9SHKT3I14Qn2tfYS+JB0r4ACR+Rbggu39qENaOZNJDRKZQogy5RenlTXJ
         Dg6XCrNDKDQt6B6KnBPdAdFEyIwkwEhRgyWhl+sAZ9yCsTVlCGqHud3nSoV3bn1wvJGM
         jieZ7Lo+J0xEQdrkj96hvz27tv/BkWuHAPmUDGRXM4+7bQNjNL7WVz7l1fsIyJI/Ke6j
         25rw==
X-Forwarded-Encrypted: i=1; AJvYcCVjoH2hQM8VAysDsB5pOtfOtwa4/8NgsV3wCYMDaI0r0XHQ+f9YsiR4gv/HP1GAU/JdowSzAm24BUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEmyn/DU9u42oQGDdWWGXchmnEzgkIaHUrzero5DoeLMAKF0k
	9DDxL8bN06orI6g7h2Jri4q4TL1fjPAWRypfqQzcRab1VX48TymAIYOq
X-Gm-Gg: ASbGnctjYDp4Zhn451tvWe6ul+X742ExeVN1uN8SUhnB8Isaalqi0GxgKs8MLn6QghL
	DqmJ/9Ahh/lU3D1ailjvywGEZul1oSweUDeOixzodBy+YSm4nVRhAReciXfdJN0Tv+8ZVp+zvB1
	ekb6eZ2mRA/uJZZ+Jxf9fcHRUG1DFtmc/caO95qjIG1e55/mvs9GrHJ5XSFgop7lQq7phnApXR8
	eQiKED55qYbudvB7JAly/DLQ+h08qSuAmdzG6eEmDVAUk4s9wJe8QlbUpW3A4nfTrrBJisfSnWx
	kc0jKE/nY55AuZuF5hnVMM3FkAYoSy/1apV4w4u5EFqfP1pLEDQ714h8XfbPA7gDX24eUFrc59K
	JmyYAJhFkug0gumAs22xniRjX478wk7OVqWzinuO5432SPVMI/7Aff2GoMAyleTorjlk9
X-Google-Smtp-Source: AGHT+IHFYb1vxmkDULuNKIS7QoSFl+2tfuF/PYECCNbNlltvEkGcZPW7zxcSpdAQxm7TMxfIBFedcQ==
X-Received: by 2002:a05:6a20:3c90:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-2311e04b20dmr3081872637.1.1752208143577;
        Thu, 10 Jul 2025 21:29:03 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe731effsm3426618a12.77.2025.07.10.21.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 21:29:02 -0700 (PDT)
Message-ID: <92ff26c0-6952-4f7e-965e-2f020adb859b@gmail.com>
Date: Fri, 11 Jul 2025 13:29:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Thrash up the parser/output interface
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250710233142.246524-1-corbet@lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 17:31:30 -0600, Jonathan Corbet wrote:
[...]

> Changes since v1:
> - Coding-style tweaks requested by Mauro
> - Drop the reworking of output-text accumulation for now
> - Add a warning for prehistoric Python versions

Serious review of python code is beyond my background, but I did a test
on this against opensuse/leap:15.6's python3-Sphinx_4_2_0, which comes with
python 3.6.15.

Running "./scripts/kernel-doc.py -none include/linux/rcupdate.h" emits this:

------------------------------------------------------------------------
Traceback (most recent call last):
  File "./scripts/kernel-doc.py", line 315, in <module>
    main()
  File "./scripts/kernel-doc.py", line 286, in main
    kfiles.parse(args.files, export_file=args.export_file)
  File "/linux/scripts/lib/kdoc/kdoc_files.py", line 222, in parse
    self.parse_file(fname)
  File "/linux/scripts/lib/kdoc/kdoc_files.py", line 119, in parse_file
    doc = KernelDoc(self.config, fname)
  File "/linux/scripts/lib/kdoc/kdoc_parser.py", line 247, in __init__
    self.emit_message(0,
AttributeError: 'KernelDoc' object has no attribute 'emit_message'
------------------------------------------------------------------------

This error appeared in 12/12.  No errors with python3 >=3.9.

I'm not sure but asking compatibility with python <3.9 increases
maintainers/testers' burden.  Obsoleting <3.9 all together would
make everyone's life easier, wouldn't it?

    Thanks, Akira


