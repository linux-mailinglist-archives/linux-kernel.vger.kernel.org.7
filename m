Return-Path: <linux-kernel+bounces-853786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD2BDC980
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2209434D064
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90030277E;
	Wed, 15 Oct 2025 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQMy/0jU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27450302742
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505832; cv=none; b=Xs858NyUJiqhe/r19yM0V+BzhXk4Z7vjUFbO7ckO6IiCkXKWElFABNuLJy2YP7manQHylSvjhcbCN/hQBoRFZhO/j69UiSItAHYBgqcgHLlocl5NBL19QGJeibE+w0uCTk02rwB7Ueu5Xq+h7Gr2SUg6L6t5SRF35V9AygPrmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505832; c=relaxed/simple;
	bh=Y8W6GMzQJCTy0WdazAXCGfrxQoa7TUygfSxQG7gH54Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AlBk5vdNRobdZ0896ZA965HRpNB8BONZEKZ35+i8GoMhf/my6j/9cONzUbVEN5wv92WOQQvll/aKBd3984ou+JAGFjuiaPsxDhhQNeMQcKG90okCXJ/IAiXUKiG47nRWjBF5r8WJectU9Z2anlZzybmqNpuX0YHvCWloZYur6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQMy/0jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4334C4CEFE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760505831;
	bh=Y8W6GMzQJCTy0WdazAXCGfrxQoa7TUygfSxQG7gH54Q=;
	h=From:Date:Subject:To:From;
	b=pQMy/0jUq03RPNP6Ap4Hr7HszrgXpTj9Pq6kDYmHU/T17j9GygoY/ti4WLmLreNbP
	 h1tpMJRASCkRPoT6F24sWhCkFnhoY+pOPKi36ES5mJc7adIMXuW1Sl+mb8K9i86UaG
	 PDCgqtElqyzCANYEQMEK6oGUG0WMN7GwAJIdQLmgYpj4d+qhqffjB33h4W6JjHcPYZ
	 flY9wGCHE6yX/KqH33lKxZ3n20TMPc6Oe4rhqEpYu0QWv/rkvqJQv4vuwKJ/IrubF7
	 SZ46nmJymV+gT5vOPuBdZMv46wNYVuys/uqPqBVg8NRM3rm5N2obaiEy0hQSoE+dlG
	 EQ98L+/SI1IxQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso241240566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:23:51 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyb1TAjo/mcF97k/+iHJPu+y8WELzPBVzOEaKaEs1yhtKB6poZz
	ENYD3VdwftZLcAhkyePEIdONtrq0qGSul3tNtEzrm7J9JccJUuPie42Y7u9nMPvw+2LnNeOyVIY
	9Tf5GnSwTm99QrUFsSUoawMGkbQIDAMg=
X-Google-Smtp-Source: AGHT+IEUPHiSWgq5faqpmwL8xJofNXM/lE4J2CeNTMOWn1cghhM0lpXSpaWufPEH6LZhD2zU5fD2fAcuJbGez70kiuw=
X-Received: by 2002:a17:907:7f93:b0:b04:b446:355 with SMTP id
 a640c23a62f3a-b50aca01315mr2812821166b.59.1760505829916; Tue, 14 Oct 2025
 22:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Oct 2025 14:23:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8OsoXbJTybYwFTvUe+utUyi9Lw3SMdObgCA82S-b-mQA@mail.gmail.com>
X-Gm-Features: AS18NWDtNB4XBKJsk9bsIWtu3RKLDyGHNNp0REg0bc-1G4yzVEhvLrBLs_i9XO4
Message-ID: <CAKYAXd8OsoXbJTybYwFTvUe+utUyi9Lw3SMdObgCA82S-b-mQA@mail.gmail.com>
Subject: [ANNOUNCE] exfatprogs-1.3.0 version released
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Goldwyn Rodrigues <rgoldwyn@suse.com>, 
	Nicolas Boos <nicolas.boos@wanadoo.fr>, sedat.dilek@gmail.com, 
	Hyunchul Lee <hyc.lee@gmail.com>, Luca Stefani <luca.stefani.ge1@gmail.com>, 
	Matthieu CASTET <castet.matthieu@free.fr>, Sven Hoexter <sven@stormbind.net>, 
	Ethan Sommer <e5ten.arch@gmail.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, 
	Eric Sandeen <sandeen@sandeen.net>, 3394797836@qq.com
Content-Type: text/plain; charset="UTF-8"

Hi folks,

In this release, a new tool, defrag.exfat, has been added to perform
defragmentation on exFAT volumes, featuring the following command-line options:

  - defrag.exfat    /dev/sdX: Perform defragmentation with "fsck warning"
  - defrag.exfat -f /dev/sdX: Force defragmentation (skip fsck warning)
  - defrag.exfat -a /dev/sdX: Assess current fragmentation status

Additionally, the quick format time of mkfs has been significantly improved:
in the worst-case scenario of a 2TB partition with a 512B cluster size,
the time was reduced from 3 minutes to just 9 seconds.

Any feedback is welcome!:)

NEW FEATURES :
 * defrag.exfat: add a tool to defragment an exFAT
   filesystem or assess its fragmentation status.
   See a man page.

CHANGES :
 * mkfs.exfat: minimize zero-out initialization work
   in quick format mode to reduce I/O time.
 * fsck.exfat: set the entry after an unused entry as unused.

BUG FIXES :
 * mkfs.exfat: fix incorrect FAT byte length calculation.
 * mkfs.exfat: avoid setting physical sector size into sector_size field.
 * fsck.exfat: fix a memory leaks in an error path.

The git tree is at:
      https://github.com/exfatprogs/exfatprogs

The tarballs can be found at:
      https://github.com/exfatprogs/exfatprogs/releases/download/1.3.0/exfatprogs-1.3.0.tar.gz

