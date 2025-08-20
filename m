Return-Path: <linux-kernel+bounces-777593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF7B2DB56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA63A2ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846B2E4254;
	Wed, 20 Aug 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHKeSNJw"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AFF2E339C;
	Wed, 20 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690070; cv=none; b=I0312ChLHW2s8EKU+vqYpRO1A/UV0gPdU+hzN9FBoWvwcvbvbyLrxvOfqlm+jwpuVilChqZYm1QOKxCPAtXya+1ceKt2pAExk3i3Gpsmh0PKF0HOBu7aby4CA1tdgnXd2Frq97LhkWe5wcFVnJVPfrGl4A9idyNhirKUEqq/OQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690070; c=relaxed/simple;
	bh=FDKhP3oxNBolrhoIi7sDu3T3WCzQhnuinOYCpr/GBYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J39tP34jDlo1I2aO7TkgHuTkSpoVLBToM4R0EU4RXDQ13xvBTBJ5Vi1vyiZudGDJ7HCY1vx6WglehqfdyPQYijbNjwWwXQ7mT3Mms/NGcFT27eczMwWYzAXNXZpRfk8BlmdaFnmGQgrM0qkHL7PZCYfqd0Tq+oFq21qKQyRJeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHKeSNJw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-324e7600bf0so233647a91.0;
        Wed, 20 Aug 2025 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690068; x=1756294868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U217s/MxPIk/owGwkXwnp+FTymNWb/H2aQ0TsKxnoM=;
        b=CHKeSNJwZhAtnOaiYg4wt7KgcCbu/S6PHrxJZG0VHuUs+ULFEVDphrMiFQE3+KwZQZ
         xZz48BTWNqlrbuy2lLNSasQNWgoUhh92UAXoYDoKDB5tqVaqJqK3DPKHSpINjDtaBIyH
         QnU0MrhQ0EWzlweFq1NuvL1sv5wob6Nc9UMQB64hseSBcHsbCRsTpLJ46GSfqfaIVDwf
         RZbLEoIZMTEtsaju+O90RfyW8jWV5s0ryDbPUaUjUtjCb1TGbEUuhLZ8+OhkFdKCwkuG
         8n8mF7EnUFK3NIO9dMZBYVAd+ng6+ooe4AVTQTHOJ91pAbph4pwdfGMR07i62DBhIPSQ
         PvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690068; x=1756294868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U217s/MxPIk/owGwkXwnp+FTymNWb/H2aQ0TsKxnoM=;
        b=HgZH3YHssBVJXx6pQuxVnOTXllioqJo6c7JidrQCQW5YjfsWZj7hovz2Qtct0sRCVp
         wOiEi1Oty0etWsruu4XJBL8xxuWD/omHYqk1veQAxFKkwhtNtaUdGIycWwlPoWcJgqca
         nPj9hzccrBIg7P66BFKRwu+iRqHHc3YmE811byt0cB+mC5whfJIa+8xMDDtlrSmiaFLG
         lyx2RnjY9F5oCYw+Wof0CG3pYdwfBKOhdF4WrE94F7SjkUbVceXPJwKjRU6dJe+VbK/N
         oQ/4X3gN/Z0du1Qd0EG926Kf6EF2yyjDN1ypetSCFsy6H25+Ud5pIdlsKrUx3DYZu8oG
         2Qew==
X-Forwarded-Encrypted: i=1; AJvYcCUAAI3qLILQ0Vhvfe7kNVPFLs+wps0aSomFWS/dEHSiLKkqAgRPrwf2ca1ItZanz+xZANRJDzZS8ugchfpj@vger.kernel.org, AJvYcCUKdGZVTWle0qYaNXnnKw1KD9YyW0oE4J7aeX8WLzRt3m4OfITOM2B4vPOZSdbN4EzF1i+/Eca5sU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdjhu40mGn3hyjiO1CQeRz+lAx9GqdsU+xTOCCmhlqMr5xGAh
	dmdEKrJh8KxZeJwl7fu2TBIQ+5+xM5B+WFOeAty03YJ5M6juLkn0QsEb
X-Gm-Gg: ASbGncusV8GpakbiOja5HkguiZkzj/rtQlxYVjkNUgoN9sjA3M74HGCsn/gtobtbk9Q
	ew9qwWqi7nEvmLQp5jwKH5BttEcMETX58C7pbws2aBgi6Bk8MISvsthmqc/SAY4Enw2F2fDaCjE
	Fcf4AXJKrfWDj9shMT7ZgFKRuPDc4GS5VhMq0lysS8gOUN4S0qccKBR1z2QrDn3q9lBaOg/ia0N
	+o6y3OttEp/MwdI4qXlndYT9SI2T/KAzQGotGdMVBzBzmCkp0sdeTlPBi1G4QNApAZQ9yNHViku
	a+yCigiormdQggRp8skXu4oWbYqGJef72oe84tDxrGMi+pbLwbX0zGtvmsHOo9fWN5BTBYGIO5Z
	hQRn+zwsuXafrHJG6RClTSWaVi40QJYXoPRRtHpn6noOV6JgDTQGfI2s9OBELOZSCuqJr
X-Google-Smtp-Source: AGHT+IFE+TwDcVQnwid3nVBw3dlreFydpUOjG7o6PH9Co3GXVed7LdFgfmI9MvrwEejQtMpjkkurhw==
X-Received: by 2002:a17:90a:dfc7:b0:31f:ad:aa1b with SMTP id 98e67ed59e1d1-324e131b2b4mr3373520a91.3.1755690068302;
        Wed, 20 Aug 2025 04:41:08 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e26259a9sm2124073a91.18.2025.08.20.04.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 04:41:07 -0700 (PDT)
Message-ID: <3990f1c5-2108-44fe-913f-97ae3bb1ff42@gmail.com>
Date: Wed, 20 Aug 2025 20:41:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <87y0rg7e35.fsf@trenco.lwn.net>
 <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
 <20250819030239.41a2e97f@foz.lan>
 <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
 <20250819153200.3c2b2ff6@foz.lan>
 <08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
 <20250820091530.068c4b62@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250820091530.068c4b62@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 20 Aug 2025 09:15:30 +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 20 Aug 2025 08:54:52 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Tue, 19 Aug 2025 15:32:00 +0200, Mauro Carvalho Chehab wrote:

[...]

>> I've just built a container "FROM ubuntu:plucky", which has inkscape
>> instead of imagemagick + rsvg-convert.
> 
> I don't think that inkscape x imagemagick/rsvg-convert itself has
> anyhting to do with the problems I detected, as they're related to
> font issues (still, I got an issue on one of my builds on kfigure
> write file: encoding is missing at open, which may cause errors).

OK, so you have spent a lot of time to paper over the ImageMagick issue
used as an SVG --> PDF converter.

I have simply given up using ImageMagick and been using inkscape instead.

I can reliably reproduce the warnings and build errors (see below) without
inkscape installed, instead with imagemagick + rsvg-convert installed,
under a ubuntu:plucky based container.

When I run: "make cleandocs; make SPHINXDIRS=gpu latexdocs",
    
     [**NOTE**] SPHINXDIRS=peci is not affected by this issue!

kfigure.py emits warnings like this:

-----------------------------------------------------------------------------------
WARNING: Error #1 when calling: /usr/bin/convert /linux/Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg /linux/Documentation/output/gpu/latex/pipe_and_queue_abstraction.pdf
WARNING: Warning msg from convert(1): convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCompliance/1064.
convert: non-conforming drawing primitive definition `fill' @ error/draw.c/RenderMVGContent/4548.
-----------------------------------------------------------------------------------

Nevertheless, "make SPHINXDIRS=gpu pdfdocs" continues building gpu.pdf,
but ends up in this error in the middle of xelatex run.

-----------------------------------------------------------------------------------
------------
Run number 1 of rule 'xelatex'
------------
------------
Running 'xelatex --no-pdf -interaction=batchmode -no-shell-escape -no-pdf -recorder  "gpu.tex"'
------------
This is XeTeX, Version 3.141592653-2.6-0.999996 (TeX Live 2025/dev/Debian) (preloaded format=xelatex)
entering extended mode
Latexmk: Getting log file 'gpu.log'
Latexmk: Examining 'gpu.fls'
Latexmk: Examining 'gpu.log'
Latexmk: Index file 'gpu.idx' was written
Latexmk: References changed.
Latexmk: Missing input file 'gpu.toc' (or dependence on it) from following:
  No file gpu.toc.
Latexmk: Missing input file 'gpu.ind' (or dependence on it) from following:
  No file gpu.ind.
Latexmk: References changed.
Latexmk: References changed.
Latexmk: Log file says output to 'gpu.xdv'
Have index file 'gpu.idx', gpu.ind gpu
Latexmk: Errors, so I did not complete making targets
Collected error summary (may duplicate other messages):
  xelatex: Command for 'xelatex' gave return code 1
      Refer to 'gpu.log' and/or above output for details

Latexmk: Sometimes, the -f option can be used to get latexmk
  to try to force complete processing.
  But normally, you will need to correct the file(s) that caused the
  error, and then rerun latexmk.
  In some cases, it is best to clean out generated files before rerunning
  latexmk after you've corrected the files.
make[3]: *** [Makefile:29: gpu.pdf] Error 12
make[2]: *** [Documentation/Makefile:148: pdfdocs] Error 1
make[1]: *** [/linux/Makefile:1806: pdfdocs] Error 2
make: *** [Makefile:248: __sub-make] Error 2
-----------------------------------------------------------------------------------

I think this is (mostly) the same as the issue you have been trying hard
to track down.

Lastly, I'm afraid but I have to tell you that I see the same error on my
test branch which has both of your series applied.

From "./scripts/sphinx-build-wrapper pdfdocs --sphinxdirs gpu":

-----------------------------------------------------------------------------------
------------
Run number 1 of rule 'xelatex'
------------
------------
Running 'xelatex --no-pdf  -no-pdf -interaction=batchmode -no-shell-escape -recorder  "/linux/Documentation/output/gpu/latex/gpu.tex"'
------------
This is XeTeX, Version 3.141592653-2.6-0.999996 (TeX Live 2025/dev/Debian) (preloaded format=xelatex)
entering extended mode
Latexmk: Getting log file 'gpu.log'
Latexmk: Examining 'gpu.fls'
Latexmk: Examining 'gpu.log'
Latexmk: Index file 'gpu.idx' was written
Latexmk: References changed.
Latexmk: Missing input file 'gpu.toc' (or dependence on it) from following:
  No file gpu.toc.
Latexmk: Missing input file 'gpu.ind' (or dependence on it) from following:
  No file gpu.ind.
Latexmk: References changed.
Latexmk: References changed.
Latexmk: Log file says output to 'gpu.xdv'
Have index file 'gpu.idx', gpu.ind gpu
Latexmk: Errors, so I did not complete making targets
Collected error summary (may duplicate other messages):
  xelatex: Command for 'xelatex' gave return code 1
      Refer to 'gpu.log' and/or above output for details

Latexmk: Sometimes, the -f option can be used to get latexmk
  to try to force complete processing.
  But normally, you will need to correct the file(s) that caused the
  error, and then rerun latexmk.
  In some cases, it is best to clean out generated files before rerunning
  latexmk after you've corrected the files.

Summary
=======
gpu: FAILED

PDF build failed: not all PDF files were created.
-----------------------------------------------------------------------------------

Please test yourself with SPHINXDIRS=gpu and see what happens under your
test environment.

Thanks,
Akira


