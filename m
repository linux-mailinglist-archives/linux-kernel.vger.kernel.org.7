Return-Path: <linux-kernel+bounces-842224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D50BB9433
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60AA64E1127
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157031DF75C;
	Sun,  5 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSpiZXbI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6C374EA
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759646141; cv=none; b=BeY5aLQeCKXZUY4Q13lFSui5wBGPzGZyZT/reEI4HX2ensRicE2zCcKt5X4bQpGk+QsCDjc7zhkRQWIEad6qhqk5ouoU4NSqi2sAXGNGf2sicxD1msSsBJY/fccAgCYk0zRLqubsDiMtHdWzrd+EQzJ465P8CKe7Nz0/T31JWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759646141; c=relaxed/simple;
	bh=5VrhzHDMjjWSE91exTxL2AaN739vo05Zspz0TxMnduE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dADN9AcXH/KfN2GPzEgK3fkC0j5MAn/2pA6bh1gecCQDoH0Og5QBgiqO9vxrAKrC5HnpGXTeZ8gvV7n7J5O74bAaY8VBcuZvXMFT6EKKMyJDAQZGPnTPEzzL0lO+yQb5k33IJfawPA89t2nIhM/NZTOq8qYeIVmro+dyQYHChuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSpiZXbI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e504975dbso21976525e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759646138; x=1760250938; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rcSyZ+WMtwF2hZaJMeBS9ckws0AkW9s6+ei9+CY7Kk=;
        b=lSpiZXbIP9QfYuPlIgFNMUXG/LObHjgBXjAZtUE93s7vVICxfMA3NwhJ1uHEgymQiG
         gRMY88qIOePszKTWF0hsgvmo/KakQU1Tu1GPTp/YKI4WbdewNF+AbSAIct89Vfb4NZUg
         MuO0kM3/3UikIrI8oy4J8ui4smjw624PuWDHaJMK1t04HxfQPzhTUU5a5ZMNwe6UlklI
         d6RNAJy0jzGX49i3OwsXJmk0Xsfr2MqASkzGAdOlprJEhnre/z4V6f74J3K3TXP9szKp
         pET7skjKU67PYWfiQjlul1+rvvemlIeA9DF/p63L/ylL6OOFnB/H8Hz3gNoRVCJIw9zV
         tzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759646138; x=1760250938;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rcSyZ+WMtwF2hZaJMeBS9ckws0AkW9s6+ei9+CY7Kk=;
        b=DESv6D4ZZjerGOx7rtgrdtl+CEo2cT8dPvv6oX/0yJiy7R2DwoNuT2zxK0vwSsy+fY
         irrRkbYVXONzmxuwT3Yhax4iNEnsB1U9jOGwhQQZZmegVzwRUzLLvrCNm7eeEhIdstWH
         PokDQfAG4/VpUb143zJIwE4ItssFBGunf6KxDkvOnAWGHWef/fuBsgKtBVeTY+K3/ZD1
         HVVffsT6rr1RUdZ3OQMTmUB9zbDJaYUj821AqLzMR/MFcAVZSYP0vb5JGaqHJBLy15S7
         IId+CUOMc8e9feh7WdWY7qu442zboVpBCcSwWVOt6t2FKh44kHpoyGxG08JXsUHKhLU1
         6hrg==
X-Forwarded-Encrypted: i=1; AJvYcCWLP6u94+3o2p/WgXw8YcUS4wwFWDxTsTzlzZ1huxPsZDR6EogqGBnQ94qiSaEJsOp/MwuA2QpfsiHqfkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXni8oiAUEIpsvY0YaFHELd8HGKt05osh3m+5ZWgnLlsgXSSez
	FQYw+0l02KRniC/hm2qq4AA6B8HLmfcVump0E3Ivqh6tMXJbdrK+dd1B
X-Gm-Gg: ASbGncuPZzItjqlWtwB+hsu9goQigksDVIfY6KnvZqNWfbuQ5eZLYRjpxfO7T0KZgnr
	gIaCBxlwfIG78Cxr79dRbB6Dkadm5f7QVpaTjl70y3K5o1AQbuoh19l4yvC572/9VHvV46Z3901
	t2ju40vTDpVYDA81AZ20HfEKVJJFO9vPfC7P5SaMOzo/KwWQ7zSTUGlP9/MQaqJTOxbbfl1n2CF
	pQ1TzkqsHJnDST0jW7lL7RxwayMj/NzNZIJCk99q4drQQfAcN4I7VeFxDMmob8CB9u46bk/Kl5V
	Oy2h0trRMNJUbl9rQTrNNd56Dhqsa7VcVAzmfWC4MXmGWdqkBwjfxBhipGPjTHSvxP5kpzoVR1u
	srf9VtTnhg1cEaxkBtDJvqdfWjv1peIK1Ma8n7fZmx4B5pRvBjQVn+xZrV2oemaBKEQ4g9Er0S0
	IOzLuCimlOxSyBYtIj7qfp
X-Google-Smtp-Source: AGHT+IG4EpN5GFt0hdbvyfHbROf8lY/f3eM4VfEv5SVIfYealuYiXMFchpEPZEsQb1Hc940YbQdTxA==
X-Received: by 2002:a05:600c:8b16:b0:45f:29ed:2cff with SMTP id 5b1f17b1804b1-46e711725fdmr53349985e9.35.1759646137650;
        Sat, 04 Oct 2025 23:35:37 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b7e37sm197232645e9.1.2025.10.04.23.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 23:35:35 -0700 (PDT)
Date: Sun, 5 Oct 2025 07:35:34 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.18
Message-ID: <aOIRtnhTn3Gt8yr5@antec>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please consider for pull,

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 8c30b0018f9d93391573e091960d257fd9de120a:

  openrisc: Add jump label support (2025-09-11 11:27:59 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.18

I picked up one series from Chen Miao, our Google Summer
of Code contributor:

 - Added OpenRISC support for static keys

----------------------------------------------------------------
chenmiao (4):
      openrisc: Add text patching API support
      openrisc: Add R_OR1K_32_PCREL relocation type module support
      openrisc: Regenerate defconfigs.
      openrisc: Add jump label support

 .../features/core/jump-labels/arch-support.txt     |  2 +-
 arch/openrisc/Kconfig                              |  2 +
 arch/openrisc/configs/or1ksim_defconfig            | 19 ++----
 arch/openrisc/configs/virt_defconfig               |  2 +-
 arch/openrisc/include/asm/Kbuild                   |  1 -
 arch/openrisc/include/asm/fixmap.h                 |  1 +
 arch/openrisc/include/asm/insn-def.h               | 15 ++++
 arch/openrisc/include/asm/jump_label.h             | 72 ++++++++++++++++++++
 arch/openrisc/include/asm/text-patching.h          | 13 ++++
 arch/openrisc/kernel/Makefile                      |  2 +
 arch/openrisc/kernel/jump_label.c                  | 51 ++++++++++++++
 arch/openrisc/kernel/module.c                      |  4 ++
 arch/openrisc/kernel/patching.c                    | 79 ++++++++++++++++++++++
 arch/openrisc/kernel/setup.c                       |  2 +
 arch/openrisc/mm/init.c                            |  6 +-
 15 files changed, 255 insertions(+), 16 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/jump_label.c
 create mode 100644 arch/openrisc/kernel/patching.c

