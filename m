Return-Path: <linux-kernel+bounces-849776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE7DBD0DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAE4E27CA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7E25F98A;
	Sun, 12 Oct 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEEDdF8d"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE88EEB3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760312912; cv=none; b=ZEBSuUpx7QDQt4EE7zh8bW7nvpo2cb+14lXDCKalKOznNoygHCenQghA48Vj8y2ooP2ulFHHzfmPVTTHmGDcuafhUQCKP/IlRPO7lOXLmhUiyvFbZG1Lqx69+BEJRGyfq+IPHPgbVQK944g7l/NMRqweZxHMZ9GYyM171bqy2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760312912; c=relaxed/simple;
	bh=8C2X/Lq+9ZBSyrFGqC9YPxndgx0WnFha1YtD6VDWv94=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lrAme0zdBL6HHe7yWufznQiV/708cBB6uqypWOptPTtg2hK1lqu1uVa9r8dm0xj548Nci90g4+m8z1YLZB1KBl8Tv1hjfCr/8iB+WziM8b8AVxvmlYbhqzwq2ts4QY08cJxpU0J1G22qvm8VUTHxjCBfT3GdqF8xKI4EtgNMoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEEDdF8d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so51038365ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760312911; x=1760917711; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2jIlflgmlxnDQrVFEKxQn+c4HPdq+KR0o+bCwjiQcE=;
        b=LEEDdF8dC3zLqXpS80nSr21Lj7h9IuWt1rzjJ0j4Ci7pIwhfIGmHDvSvx5diDOfAfI
         lopwXCmHO19LWPBC7Nfz9DDvY3UpIVG2Cnt+cOiAH0AnGM2E3fgvHu45nOFD9ww01HkT
         DJLhVzctmagMbDwxm3oA99TPVD/kx7N0XUO4VhxuFTEE7TX1eeICN4p01iYviSlz/GL2
         6rmMJI+L6qfTtTJkP/VSf7iBYb7dwzsBLnTs0AVzRQudUdEf3h2+1dZ8Wl2ejUwVBv6a
         0XNp4zM2TFA9ih2QXNAgAGnVfoBE13S5mGnZzN2fWfsQZPsssidxHeBvICJHUu8ZLS/m
         ZgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760312911; x=1760917711;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2jIlflgmlxnDQrVFEKxQn+c4HPdq+KR0o+bCwjiQcE=;
        b=Vf/Pw4PSpOTUpvR9exLkk82FtmLIX3oQXtzyJ+KZ8jiCihqM1rU/+VF2drTjKqNZ/U
         6/Vc3aih+S5OQDsPNyhtikfkgc/YBkgUYElLnPJ5W7GhOUtfvTbxAPi4JeV2DDO3T0J7
         Q6agnrP85RxdB/mk9j3tT/F2fShxkhZaX70uMXEDWSfZXCTgiaOZdly/b23NIHY5KotV
         jGLHe1LhDUWBZ9FH4BpfaS5GkAl3ank+a4uwlKI8Ws509fz1CfONPIrqhk6iZ9MwL8ov
         hGaXxO9l9nx9HavO3SodoEql9VJApjwHxxQsEfhV2yBTORr84eglUTGLLluM1RZLCRsT
         DPuA==
X-Gm-Message-State: AOJu0YwHr1+Jpr4UwwapRq4zVCgkoKTUgknQVrYjpUgHyT7z0tE/NktI
	S2jV5zM71xmNTYkUj4iGEldZXESc9cOwHQH/7z0uKyzRvDTQkYumizMPaDA+Rqh8c3S1eRsuIy8
	pJAMT/Ij/Sf81aMxjEKYzhnX9UOVlQEX7QccL
X-Gm-Gg: ASbGncvDYWTS+7n71q1op/3WpxGtN7Rn37Dv88HxrlHN2DA+Jgb1Xx3Z6GE8VeV1bV6
	EJGwHm+s0srMRrYnQ49RdY37wQAPuNX/EWUCYtWFwKc+FhLydapY0wi7HyiaoQQGFftAvZcFxKs
	N2KMN/6xiQ2fdV/PBAgU34QIFPlbIcNTOOPfHjPOlNN2tMrMQ1+YtdneT/DRwqlNTwWm1LIIhSP
	mhPC/ejfU69wcBXylog9AjS
X-Google-Smtp-Source: AGHT+IHJdPKa5F/z3E2KdoNR8O8hfe7Yx7RBBmIo51IWeIhlcwSEJ4pcwqHz8Q4FcdHuKG+z2CskDp/jZUFiejQibQM=
X-Received: by 2002:a17:903:1984:b0:26a:8171:dafa with SMTP id
 d9443c01a7336-2902723fc6bmr258818955ad.21.1760312910673; Sun, 12 Oct 2025
 16:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Oct 2025 01:47:54 +0200
X-Gm-Features: AS18NWDs5fdEaQeP_2RTyLUoEPfuCmiMY8h5no-Srmx5NieBoEWY8m5PlS2h6A4
Message-ID: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
Subject: Building a allyesconfig kernel fails because macros are being redefined
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My current git HEAD is at  3a8660878839faadb4f1a6dd72c3179c1df56787

If I do :
    make mrproper
    make allyesconfig
    make -j 33
it eventually fails with :

...
 INSTALL libsubcmd_headers
 CALL    scripts/checksyscalls.sh
 CC [U]  samples/vfs/test-statx
 CC [U]  samples/watch_queue/watch_test
In file included from samples/vfs/test-statx.c:23:
usr/include/linux/fcntl.h:160:9: error: =E2=80=98AT_RENAME_NOREPLACE=E2=80=
=99
redefined [-Werror]
 160 | #define AT_RENAME_NOREPLACE     0x0001
     |         ^~~~~~~~~~~~~~~~~~~
In file included from samples/vfs/test-statx.c:13:
/usr/include/stdio.h:171:10: note: this is the location of the
previous definition
 171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
     |          ^~~~~~~~~~~~~~~~~~~
usr/include/linux/fcntl.h:161:9: error: =E2=80=98AT_RENAME_EXCHANGE=E2=80=
=99 redefined [-Werror]
 161 | #define AT_RENAME_EXCHANGE      0x0002
     |         ^~~~~~~~~~~~~~~~~~
/usr/include/stdio.h:173:10: note: this is the location of the
previous definition
 173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
     |          ^~~~~~~~~~~~~~~~~~
usr/include/linux/fcntl.h:162:9: error: =E2=80=98AT_RENAME_WHITEOUT=E2=80=
=99 redefined [-Werror]
 162 | #define AT_RENAME_WHITEOUT      0x0004
     |         ^~~~~~~~~~~~~~~~~~
/usr/include/stdio.h:175:10: note: this is the location of the
previous definition
 175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
     |          ^~~~~~~~~~~~~~~~~~
In file included from usr/include/linux/watch_queue.h:6,
                from samples/watch_queue/watch_test.c:19:
usr/include/linux/fcntl.h:160:9: error: =E2=80=98AT_RENAME_NOREPLACE=E2=80=
=99
redefined [-Werror]
 160 | #define AT_RENAME_NOREPLACE     0x0001
     |         ^~~~~~~~~~~~~~~~~~~
In file included from samples/watch_queue/watch_test.c:11:
/usr/include/stdio.h:171:10: note: this is the location of the
previous definition
 171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
     |          ^~~~~~~~~~~~~~~~~~~
usr/include/linux/fcntl.h:161:9: error: =E2=80=98AT_RENAME_EXCHANGE=E2=80=
=99 redefined [-Werror]
 161 | #define AT_RENAME_EXCHANGE      0x0002
     |         ^~~~~~~~~~~~~~~~~~
/usr/include/stdio.h:173:10: note: this is the location of the
previous definition
 173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
     |          ^~~~~~~~~~~~~~~~~~
usr/include/linux/fcntl.h:162:9: error: =E2=80=98AT_RENAME_WHITEOUT=E2=80=
=99 redefined [-Werror]
 162 | #define AT_RENAME_WHITEOUT      0x0004
     |         ^~~~~~~~~~~~~~~~~~
/usr/include/stdio.h:175:10: note: this is the location of the
previous definition
 175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
     |          ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.userprogs:29:
samples/watch_queue/watch_test] Error 1
make[3]: *** [scripts/Makefile.build:556: samples/watch_queue] Error 2
make[3]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.userprogs:29: samples/vfs/test-statx] Error =
1
make[3]: *** [scripts/Makefile.build:556: samples/vfs] Error 2
make[2]: *** [scripts/Makefile.build:556: samples] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/jj/src/linux/Makefile:2010: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

I haven't looked into fixing it (yet), just wanted to let you all know :-)

Kind regards
Jesper Juhl

