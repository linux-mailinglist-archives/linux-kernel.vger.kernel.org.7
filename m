Return-Path: <linux-kernel+bounces-826088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C3B8D7D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A581D178555
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3B1E8836;
	Sun, 21 Sep 2025 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpocAxWm"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E121E260D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444220; cv=none; b=ciTrVsQBD/r9KQAsOUeH5detv3UGj0fzQ6a8udQAFv0FHPsN65ZDLQ/Q/9bV+m28+obPPM4J6c4jmi7r/6cvpp2FKfHFVVcdZaM/rtCOdDmGCDZEutiQRnwEeYn+kiFWERW4YHNDD9Y+Mlbw6G695k8BRZiPktN1yHEZHKKiGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444220; c=relaxed/simple;
	bh=UjN52QhzqZyfjm57PydUQ+he7++5mFgxAuApM6NaDqQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qNa/N+cb8vV9P6p7tSOpAYcko590ouEAr6cfx6TKIqlH6qRYAnpukQC1Po/NbETnNAAvrO7NmWhA5p5xzgPs8NFjCHp2ozir/1grZ4aAA5IYTOLRb6nai/0VxIBciFpeNoUy48of24yuqM84TdCW2NRh9hDINHvQKjnPFDxYra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpocAxWm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f1a79d7e5so1093465b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758444218; x=1759049018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qhuxGkdlbYwQtUxo9AAy8/gz7UCzFi3umGZgoVwppwU=;
        b=DpocAxWmxlXp4e3TwzawQD1HZjkJi5pS+uoCiOESqubnDUX+cA1jHNyQGrxhAeets5
         OywjNWx+Q/B4VmrdOjWDfLObQ+VB0bkhggZjaFE8cu5O/qa7JRQyVLBj+PobBL3JPrGP
         q6E0a/MSiJuruPyjw3WjvI3Wo5f31xR9wtbnuoHZC7OMIEe1Q32hKfZ8DGrCpxAKA5Lc
         F6rRMb5oHPIj1WeUNwXceki7nLdxauRiZMTeZy1y2m2T9QGK5ryYM4VaB0ugL3ckPvM1
         PyS1/XnF+Xymy+JAdOfcw+q9XmbbFoOVrL8Me2i1hqpQluVn4vWygU5bMlLrg0bot0yR
         /d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758444218; x=1759049018;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhuxGkdlbYwQtUxo9AAy8/gz7UCzFi3umGZgoVwppwU=;
        b=N0trpVcmIGs5boyFVWU0GGqjO+PP2lnkzXUzs2F0aXTCcuLanT4wTmNCvemM8SNaxF
         O1U/QGX3JNjqD3qZMgUuQUm4AaCQVf3KRWKR9RW8n94mKo59hJ+aumeBfcGWdatxRLlY
         qduLNKrQUc/3I/LD+DWtDrtuLv9M7otKClEdPEj35UNWiwIzX0z3eUYZudFQUyFkYLlA
         hHRGEriYt4mVMbWqvhf5UsZBXpRAuzgZaVpEkyIqze7w/EABWL79AWvPps4B3wu2MFyt
         8IFOza7rHwwios+/hg3xoBG4qUAji8FmUjdtEPB/f8LCT+MTPfx2ATEfGLhDgSBCBirr
         xrSg==
X-Forwarded-Encrypted: i=1; AJvYcCXcIuJDYorLoKAIJMGjmlrdSNnQ58YYVxqqKrODv9l4z6VEDTW0gjr2OEldgYyt8XgFdsnDyXzBIDkw8/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC42wEw/py/2GFi7FW/jCnzqxp5UahcTRXuj+2C28P/GSBkVDZ
	9ix3MZ40t2j2xLBA5hN0SJESBgZGzL5NHz3IFJcWJ5Rh7ZKh5fbz6pBO
X-Gm-Gg: ASbGncvkVdj//GGzxs0T+9VnoZrKSDvKsZ3hTLUzA/PPHSLREtXxY7XzPbHNX9bCECz
	bwMCXW/O6jve8jrrJo5RqvviguS8CxQFDNLea1PXGHvIU8zk1OPJLNwAyawuucydeAZmHBHXinp
	0Z3/pzLRR9007+6lQi3m5zqWDCp8Cf+oXlPtzerCUmE6nOceFS2QMzVbAqSK6K+MpXhiceOtA0H
	tIVcEkDirff0Jfpe2otxXhSOHgRqCXNCuLgfiLQCNoamtdWMREni6xJda+bqJojYCJ0CNb9vYo7
	ZKZLjEvXCCwwsBMWU3sUFPBrwaR2p7G4sxlj88n7ydYx437QM8LMym1BX81I3eWPC+6u+IqyOBQ
	yK8IksND+KcIkFLdKpbBkSQ70X0YI5gKCkM5LhttOkg+OIA/s3SK7JrKe6ucFDMJGofog
X-Google-Smtp-Source: AGHT+IFqCRKRtItqhHVLVKIhfbYwcAdS9aUI+YCtSIJZLyIniucuWcyztE1Fb64OCQV1kf2LRvwPVg==
X-Received: by 2002:a05:6a20:2445:b0:254:84f8:b280 with SMTP id adf61e73a8af0-292748080d1mr12116002637.49.1758444218470;
        Sun, 21 Sep 2025 01:43:38 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552882b177sm5004313a12.11.2025.09.21.01.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 01:43:38 -0700 (PDT)
Message-ID: <54d1f3b1-ba8c-458b-92d6-9d8880952e06@gmail.com>
Date: Sun, 21 Sep 2025 17:43:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: linux-next: Tree for Sep 19 (make htmldocs problem)
To: rdunlap@infradead.org
Cc: broonie@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>, Jonathan Corbet <corbet@lwn.net>
References: <883df949-0281-4a39-8745-bcdcce3a5594@infradead.org>
Content-Language: en-US
In-Reply-To: <883df949-0281-4a39-8745-bcdcce3a5594@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Randy,

On Sat, 20 Sep 2025 17:17:56 -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/19/25 8:05 AM, Mark Brown wrote:
> 
> With today's linux-next, when I do 'make O=DOC1 htmldocs', I get:
> 
> make[1]: Entering directory '/home/rdunlap/lnx/repo/linux-next/DOC1'
> ../Documentation/Makefile:71: warning: overriding recipe for target 'pdfdocs'
> ../Documentation/Makefile:62: warning: ignoring old recipe for target 'pdfdocs'
>   File "/usr/bin/sphinx-build", line 1
>     ELF
> SyntaxError: source code cannot contain null bytes
> make[1]: Leaving directory '/home/rdunlap/lnx/repo/linux-next/DOC1'
> 
> where the "ELF" line contains some binary bytes that are not shown
> via copy/paste. Here they are in hex in case that might help:
> 
> 7f 45 4c 46 02 01 01 0a              .ELF....
> 

Hmm, my /usr/bin/sphinx-build (under Ubuntu 24.04) is a python script.

Running "file /usr/bin/sphinx-build" says:

    /usr/bin/sphinx-build: Python script, ASCII text executable

Randy, how did you install the sphinx-build?  And which distro are you
on?

> 
> I don't see what is causing this, so I am using the previous day's
> linux-next for Documentation testing etc...

Another question ...

Does going back to a past linux-next make sphinx-build work again?

If that's the case ..., I'm not sure, but it might be related to
Mauro's sphinx-build-wrapper, which is now in docs-next (not in docs-mw
for v6.18 at the moment).

Randy, what happens if you revert the latter part of Mauro's series, namely,

  819667bc3ccd ("tools/docs: sphinx-build-wrapper: add a wrapper for sphinx-build")
  2e1760999e58 ("docs: parallel-wrapper.sh: remove script")

  ... up to ...

  42180ada39da ("tools/docs: sphinx-build-wrapper: add support to run inside venv")

on top of next-20250919 ?

Regards,
Akira

> 
> Any ideas/suggestions appreciated.
> 
> -- 
> ~Randy
>


