Return-Path: <linux-kernel+bounces-848601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F10BCE246
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E4A3ADB00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76F20DD72;
	Fri, 10 Oct 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcun/mwR"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670A86331
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118390; cv=none; b=dtebkth4HYVh5y8Wp8S56IEETPCMxxQfdLu5dix4IirsLMAJpfp913ZgKi9whHPGb8/3nj8uh6I2Hv3IfVndfD1B94t1nkM8XuQehF5iklE3MKHvORY5ck0SJye4C62w2ElKGdpB4PIyXxp3q7Br7PqRR6LjltKBB2WJBHndvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118390; c=relaxed/simple;
	bh=eeBH9js9yZifP+83s8d7mMmQ9oxVME4Da/JyScf/Ub0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TtBTUEphMTqa5NEvFrSV0hbd0Qg++Sv2TCsDYY97nT0DnkzkF+YeCBxTq/ti2HnKhkerhkTzffeGUl4LLLvMPbA0X/nTrdm7m2PSWrnBy8QJbn4y7rF98E5XxhSbV0PPYdbY7JiIFaYCCA7eyIwXrpCMq2p98ONJBHSFHR+iVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcun/mwR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so3055016a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118389; x=1760723189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+v2LXmYVIoRn/hgAmq+CTJPSpbC6ESSwB+GSt5X9Sg=;
        b=Gcun/mwRHjoJ5EH1RbjapGUMxJ3SQhyc5ggX0G5inALA1BZmKS3mASwA1z04ygI9Aj
         rNVV7QAoEKJLrELxcf9FrLX+7c07c6TL3pjjLF+xYQODnLnOt+AgaoHwL7okVO6bmOW5
         o1pq0aXqGMdSwB9B2AMa8vuQjXJvpvF2U2QgOZNMaZGmhLK6H8lJ+uJvzKFU4HPuQ08j
         ErArnOWY944k75+DKshU5S7m4zykUOTaVG4MPbPGo144bjEupIhpyZIuAqKVJwmDX5ix
         6dKlBDipQtPG2DxGqEaeFYpAUhu2C6eJbc+4S9+TpQuZ0cwbLvq19VNSUCg8bbfSSnuH
         d/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118389; x=1760723189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+v2LXmYVIoRn/hgAmq+CTJPSpbC6ESSwB+GSt5X9Sg=;
        b=Ne5XMeMDL8QXMANgagWZWunQGJ0wZqhBMZfF7EUZZ7MSluy+UEasPCUpbSRrAyvsNI
         9JMdg5cqXVz8GyELUy/irvN+fL7Emt3rjRQOFUf5ap/u8OVwOT91OurbKaV4frCkSGcu
         Nzn5vWrs3BSv0+37FG4XK2gnIJLqjfG/d/U+MW99AvWa2IOUUJqztA6Q2PrdhtvIYHxA
         5SiPuE0ZTXD99HwzojSHfEpj8wCTDioZBndbvVWLCq8z3j+xC5iGeokdqHBUafDj5XVQ
         /vmbSl5NQuqxJZ9j5q1dnmbeG3WoJhcZDMTDKjnbG45HD4k/xlOo1hZX+BXfi7TVcR+C
         f0JQ==
X-Gm-Message-State: AOJu0YzO3cTb43/B8HNn//qFb5kRVm27vc3uoml8zBapp9dj7jnT3M0t
	bNJTF4oKUeQVU/Wa2HvW6+sne2ej4gzK+6EqvTwFT511kAJieL1WGu6G
X-Gm-Gg: ASbGncvykSHlMMpaAmnqSRyPz4OhqMMToWE075oOh3GPp7NJJiT/+1DHfMG4NGyGlax
	h5sTvVqdUrmGydd1MGSSCutEamDL65zxXQItH4BWuxWcRCe4P0mcWIFbBBhDv1IxebpiijG5Gnb
	2ZcTKoKXpnHdedpKEMpuLfp/meTGxmAwwFGXxdy+cgRitGn7MVVdit6hrtaUNqBut+kkIOf9dB2
	u6KQjteOSVkN4beJ9rCtmfl6ozIp1rpsxgOGDVh7wgx4hzdik4usxImu2VnYo/t69e93dXmlDAO
	8/0gbL2g1iF9ctPqGzjve8uKnYultFD4itI18a6d/yYV1wTmvGHjUZvyGCtkb7JcNm+lL5mrf8g
	8FLksNESXZueB0vHA/vBlG9HuHNYLb3UOERHFela4mPB0AOKd5zxy+mVs7vYQO8y4qqRQ/Ytjk8
	NamULs6LVb1A==
X-Google-Smtp-Source: AGHT+IFZ5hRHhPP/Eg0/Jq2+4DYR1nB6XEhpkuQdZ0UoNcUtw/UYGqw8Q7rVxqdQ+Tsl+/QeKS1Nvg==
X-Received: by 2002:a17:90b:3890:b0:338:3156:fc44 with SMTP id 98e67ed59e1d1-33b513758bbmr18612054a91.18.1760118388317;
        Fri, 10 Oct 2025 10:46:28 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a200:bbd0:4f7d:10ff:4cc5:8c1d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5295ab65sm5909867a91.1.2025.10.10.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:46:27 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] xtensa updates for v6.18
Date: Fri, 10 Oct 2025 10:46:14 -0700
Message-Id: <20251010174614.3953574-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull the following updates for the Xtensa architecture.

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20251010

for you to fetch changes up to 4c8bad3ed035ab85ad9b0d247154be43a53ef84d:

  xtensa: use HZ_PER_MHZ in platform_calibrate_ccount (2025-09-15 08:37:28 -0700)

----------------------------------------------------------------
Xtensa updates for v6.18

- minor cleanups

----------------------------------------------------------------
Miaoqian Lin (1):
      xtensa: simdisk: add input size check in proc_write_simdisk

Thorsten Blum (1):
      xtensa: use HZ_PER_MHZ in platform_calibrate_ccount

 arch/xtensa/kernel/platform.c       | 5 +++--
 arch/xtensa/platforms/iss/simdisk.c | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
Thanks.
-- Max

