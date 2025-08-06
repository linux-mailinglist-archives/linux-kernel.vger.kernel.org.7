Return-Path: <linux-kernel+bounces-757202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245FEB1BF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A1B621508
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF621DEFD2;
	Wed,  6 Aug 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwI2TAbr"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4138D;
	Wed,  6 Aug 2025 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450002; cv=none; b=P6BNwQK/qfsTENpCebCQWtoC6u+oZvs6k59BpeHbpGYfQRYwhW4/LlSc7cZppV6XvNGNrZBwY0SLITeqT3HsIs+wJSc5DNZ6NSMW+YygTH0sdmr8nMJbBAsj2ABLS/xbBBY7oef6MKzq44QHacFvgKJVyNZ5QPI9X62l7hzFhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450002; c=relaxed/simple;
	bh=iJJYePiwyIYJmHvhyQzhCFkAnj2RwrOAZLJsQBcGBRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEQP19v/MDwdYKY1rKf6PxQknAkTcICsxI2PY0PjSrcKhClizrsp+LHnyYpn/QyLzgrOuSsdX5LeOT92LT2dWhsS6l/myYrriE3O1gRDmh7IWvQ7k+S1jAIHbdgApFxFDjcYaumM1S4h5bjg16YZ9YNu3y6Lk+Lj6d1VhMB69lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwI2TAbr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b421b70f986so4999734a12.1;
        Tue, 05 Aug 2025 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754449999; x=1755054799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REkGJRy1cW5+Dxc3FwN5T9CLPowsuiAQuLNYSLevuFw=;
        b=JwI2TAbrLT7v2HbyhtuEAVgZykazCibwoi3K4jXsEqG2TKUWY6bSfRYpmgsuWduEBq
         CbtMke1UeJue/DuQoBavkCtItEgUP0EXoIPjK6Z1rovonpFMRSBn8fn5FYNz82N1t89o
         irQnWuYW6qV4DBoUtDIIpbEBtP8vH11vGRH6Jy/M+uP1jenZjQEpfpqgmD/WItiLH6VN
         T6rxTrnqsiKLpAIU2Kt/B3m9GOQD+XwbOX4AdCKu/nzh1626opl8oFd9F5XqbpGlDp4e
         /783dWXwewyPznzyy1bVf66cOZZI7+YmiH0nAiz/E1EY95FPpwl9pVZwVJCDmCjn1i4m
         kQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449999; x=1755054799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REkGJRy1cW5+Dxc3FwN5T9CLPowsuiAQuLNYSLevuFw=;
        b=HSY0xi6pgv/djdFGTrbTzvuqCAS5qHNVFOZj9JTW5pCfijj0XaNzkbEr8b4APVoYRs
         8JctENLF1MQUkmSBY+QGVmDmXjZE+/Kya3bHIo/uq/gMtY6oeSrpIFkzvZgK4ZIj+lAr
         yRfYm+jKa5+jhscf2kXehpZMPPtdIaPNxXcsfFQ08Z9GmHHsJCF1FK/SG9DS+jbmGZ/J
         BPv2ZflifVUkmE9n3t4a1kJMi/VGMau/yWmyFuxkKV8vz6aIgoJ7Tq54ZB0wHkz7bVHf
         eCGHsPjIoK+LqB65DbloDoNwb3bpL6wMoXbgMhiC3uruX8vbpW7/YFSS9OTa2U6/qpbx
         AoAg==
X-Forwarded-Encrypted: i=1; AJvYcCV2l0fH1pPVr3nOLKD959cmZ5BLmCS3rUjTfFDpuQxfCFr2bN4ska/A/6Rk4gSB926sK7ddNj5uotwnhQN7@vger.kernel.org, AJvYcCXU+93DnOLJRBmyUAXpuf3Kk6m09tD95VXHISKnFnSEZbniX73O0TYSHSji9bmwf1IyXS0Ei0hD95g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDsEjx7ByCVVyShZkSRltgiW7ZVl2jcs+W1FKiVsPlZGkeDqY
	SWlC3vWUIvk7h3jgedqcM2tcOLbiRhSTWE4ZQCs45gF/ypKq8tvQwHj5
X-Gm-Gg: ASbGncvKI2mU9BbGuRbA6yPnK0WtqqvqfcAUf4Rn7JbnPAkypQaH+UDiyq6C/U0Sgsj
	VGbeWTWKSF6VdykOaYcCxATBWp2mG17dy5GTOan0HS2pmTDJs/LDTA8bKJaMi7KAJegy5b7DD35
	ZlzdpZxyU1vBgbw6zEQmvn0THEPR3E/5kd2AGdxS6hlsR4/zkTrs/1vwV5LCwMgP49Sy7GOIHYH
	j+xz8AGYG+7vE0xopxQ2cIvNrgijEdeRGe5EZgWqI2qZkuVQVKngqef5u8CcHHJ7nfs7D1xwsAB
	seki6eSQIf8A323WJ4BaTKMzIqboiKRnKt8pEa3K2qNTbRryGT+0F3z4YpJXzyQqCtARRPnUYZX
	xZpIzZMkGIZN7KtswOt+NUUOBSzU+QBKzLK5HecpFhebqYAZSHw6NE/sO4F7sDAFzna/0nCWeht
	r9R7Q=
X-Google-Smtp-Source: AGHT+IGaTXpA5hA2CiVJWac66rRc5I/dNGJmG87ByeHAwCrIskiCA3Fmv8AeJLSswZvykucje/kZrA==
X-Received: by 2002:a17:902:dac3:b0:234:9375:e07c with SMTP id d9443c01a7336-2429f45eae8mr24291945ad.46.1754449999259;
        Tue, 05 Aug 2025 20:13:19 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaf855sm146435895ad.168.2025.08.05.20.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 20:13:18 -0700 (PDT)
Message-ID: <b4c81d64-b605-4b0a-9d99-fec55a1e0514@gmail.com>
Date: Wed, 6 Aug 2025 12:13:15 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Translate sphinx-pre-install to Python
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Sai Vishnu M <saivishnu725@gmail.com>,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
 <d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
 <87bjpu69q3.fsf@trenco.lwn.net>
 <9148ae7f-7954-421e-b5dc-366651f0bc48@gmail.com>
 <20250731135107.6c2b32c2@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250731135107.6c2b32c2@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 31 Jul 2025 13:51:07 +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 8 Jul 2025 23:56:01 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> I've been ignoring sphinx-pre-install all these years, but the impressive
>> test results presented in this cover-letter made me test it.
> 
> I'm now working to fix PDF generation, assuming that all packages from
> sphinx-pre-install are installed.
> 
> I'm placing the patches on my scratch tree at:
> 	https://github.com/mchehab/linux/tree/my-docs-next
> 
> It contains several branches merged there in sequence:
> 	- elder_python_v1: makes kernel-doc run with elder kernels (2 patches);
> 	- netlink_v10: patches adding an yaml parser for netlink (14 patches);
> 	- sphinx-pre-install-v4: current version of this series (39 patches);
> 	- pdfdocs: specific fixes for PDF doc generation (11 patches);
> 	- sphinx-build-wrapper: a new script with a large cleanup at docs Makefile
> 	  (7 patches)

Sorry, but I've not looked into those branches.

[...]

> So, at least for me, it seems that the changes will be fixing
> lots of existing issues.
> 
> Btw, one of the problem with PDFs is that the existing logic
> doesn't really report success/failures for each PDF target.
> That's why I ended writing a wrapper (sphinx-build-wrapper) with
> checks the results. As a side effect, docs Makefile is now in
> sane state.

I might be interested in seeing the docs Makefile updates.

> 
> Thanks,
> Mauro
> 
> ---

[...]

> Summary
> =======
>   PASSED - AlmaLinux release 9.6 (Sage Margay) (7 tests)
>   PASSED - Amazon Linux release 2023 (Amazon Linux) (7 tests)
>   PASSED - Arch Linux (7 tests)
>   PASSED - CentOS Stream release 9 (7 tests)
>   PARTIAL - Debian GNU/Linux 12 (7 tests)
>   PARTIAL - Devuan GNU/Linux 5 (7 tests)
>   PASSED - Fedora release 42 (Adams) (7 tests)
>   PARTIAL - Gentoo Base System release 2.17 (7 tests)
>   PASSED - Kali GNU/Linux 2025.2 (7 tests)
>   PASSED - Mageia 9 (7 tests)
>   PARTIAL - Linux Mint 22 (7 tests)
>   PARTIAL - openEuler release 25.03 (7 tests)
>   PARTIAL - OpenMandriva Lx 4.0 (7 tests)
>   PASSED - openSUSE Leap 15.6 (7 tests)
>   PASSED - openSUSE Tumbleweed (7 tests)
>   PASSED - Oracle Linux Server release 9.6 (7 tests)
>   FAILED - Red Hat Enterprise Linux release 8.10 (Ootpa) (7 tests)
>   FAILED - rockylinux8 (1 tests)
>   PASSED - Rocky Linux release 9.6 (Blue Onyx) (7 tests)
>   FAILED - Springdale Open Enterprise Linux release 9.2 (Parma) (7 tests)
>   PASSED - Ubuntu 24.04.2 LTS (7 tests)
>   PASSED - Ubuntu 25.04 (7 tests)

Here is a summary I have made based on my own tests against limited list of
distros.  I'm still ignoring sphinx_pre_install.

-----------------------------------------------------------------------
* TL;DR

Setting up a tool for SVG --> PDF conversion and CJK fonts properly for
"make latexdocs" and "make pdfdocs" is sometimes tricky.

Summary table as of 2025/08/02 WRT distro packages installed as they are:

[legends]
    pdf & img:  pdfdocs with ImageMagick + rsvg-convert; w/o CJK fonts
    pdf & ink:  pdfdocs with Inkscape; w/o CJK fonts
    pdf & cjk:  pdfdocs with either ImageMagick or Inkscape; with CJK fonts

========================================================================
                                                    pdf
                                            ----------------- 
distro               python3 sphinx    html   img   ink   cjk   notes
===================  ======= =======  ===== ===== ===== =====  =========
debian:bullseye      3.9.2   3.4.3     PASS  FAIL  PASS  PASS   [*0]
debian:bookworm      3.11.2  5.3.0     PASS  FAIL  PASS  PASS   [*0]
debian:trixie        3.13.5  8.1.3     PASS  FAIL  PASS  PASS   [*6]

ubuntu:jammy         3.10.6  4.3.2     PASS  FAIL  PASS  PASS   [*0]
ubuntu:noble         3.12.3  7.2.6     PASS  FAIL  PASS  PASS   [*6]
ubuntu:plucky        3.13.3  8.1.3     PASS  FAIL  PASS  PASS   [*6]

almalinux:9          3.9.21  3.4.3     PASS  PASS  PASS  PASS
almalinux:10         3.12.9  7.2.6     PASS  PASS  ---   FAIL   [*1]

fedora:42            3.13.5  8.1.3     PASS  PASS  PASS  PASS   [*2]

opensuse/leap:15.6   3.11.9  7.2.6     PASS  PASS  FAIL  FAIL   [*3]

mageia:9             3.10.11 6.1.3     PASS  PASS  PASS  PASS   [*4]

opensuse/tumbleweed  3.13.5  8.2.3     PASS  PASS  PASS  FAIL   [*5]
archlinux            3.13.5  8.2.3     PASS  PASS  PASS  PASS
===================  ======= =======  ===== ===== ===== =====  ==========

"FAIL" means several situations, most of which can be worked around by
manual intervention after installing distro packages:

 (1) error/warning in "make latexdocs"
     (1-a) due to some issues in distro package that is not up-to-date

     (1-b) convert(1) of ImageMagick doesn't generate PDFs with the warning:
        WARNING: Warning msg from convert(1): convert: attempt to perform an
	operation not allowed by the security policy `PDF' ...

     (1-c) Incompatibility of newly added SVG figures with avalable
           SVG --> PDF converters:

        (1-c1) covert(1) + rsvg-convert(1)
	(1-c2) inkscape(1)

 (2) error in "make pdfdocs"
     (2-a) (1-b) or (1-c) can cause "LaTeX Warning: Float too large for page
           by <huge>pt" and ends up in the fatal error of xelatex:

             "! TeX capacity exceeded, sorry [main memory size=5000000]"

     (2-b) (1-b) or (1-c) can cause xelatex to error-exit without leaving
           any hint in the .log file.

 (3) CJK pages can't be rendered
     (3-a) due to missing *static* Noto CJK fonts in distro packages

Notes
=====

[*0]  ImageMagick is not allowed to generate PDFs in Debian and its
      derivative releases prior to ubuntu:noble.

[*1]  An issue in cairo prevents a DOT diagram in a CJK page to be converted
      into PDF ("dot -Tpdf" crash; known issue with cairo-1.18.2-2.el10).
      Inkscape is not in EPEL 10.  Use of flatpak is recommended for GUI apps,
      but flatpak apps don't see font setups of hosts by default.
      Serif shape Static Noto CJK fonts are not provided as distro packages.

[*2]  Due to a xelatex & fontspec limitation, if you have variable Noto CJK
      fonts installed, they need to be deny-listed for building PDF docs
      with CJK fonts.

[*3]  Sphinx 7.2.6 is provided as python311-Sphinx.
      Inkscape 1.0.1 crashes against figures drawn with Inkscape 1.4.x.
      Noto CJK fonts are not provided as distro packages.

[*4]  When Inkscape is available, their parallel runs under Gnome desktop
      can cause emergency saves of SVG files.  This issue can be worked
      around by, e.g., building under a text-only session or a non-Gnome
      desktop.

[*5]  Static Noto CJK fonts are not provided as distro packages.
      Even if they are manually installed from Google fonts manually,
      deny-listing distro-provided variable ones is required for CJK pages.

[*6]  convert(1) + rsvg_convert(1) doesn't work well with some SVG files
      under recent debian and its derivatives.  Incomplete list of examples:

      - Documentation/gpu/pipe_and_queue_abstraction.svg:
          convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCompliance/1057.
          convert: non-conforming drawing primitive definition `fill' @ error/draw.c/RenderMVGContent/4456.

      - Documentation/userspace-api/media/v4l/selection.svg:
          convert: unrecognized color `dt' @ warning/color.c/GetColorCompliance/1064.
          convert: non-conforming drawing primitive definition `fill' @ error/draw.c/RenderMVGContent/4548.
          convert: unrecognized color `w' @ warning/color.c/GetColorCompliance/1064.
          convert: unrecognized color `dt' @ warning/color.c/GetColorCompliance/1064.
          convert: unrecognized color `w' @ warning/color.c/GetColorCompliance/1064.

[about almalinux:8]
      There is a package python3.11, but there is no accompanying package
      for virtualenv in official EL 8 repos. It might be possible to install
      python3.11 as well as accompanying pip and pyyaml, and install modern
      Sphinx by non-venv pip. This might be feasible, e.g., in containerized
      setups.
      On top of almalinux:8, as far as I could test, xelatex & fontspec
      can't discover fonts by its names such as "DejaVu Sans".
-----------------------------------------------------------------------

Thanks, Akira


