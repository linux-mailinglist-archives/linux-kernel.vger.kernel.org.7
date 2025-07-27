Return-Path: <linux-kernel+bounces-747208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8BB130F8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAF31781F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE45221567;
	Sun, 27 Jul 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PuEmoe0c"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44329EADC
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638008; cv=none; b=Yy+xSbNL05Sg45oTTVG4c2fGDlFXE8K7aV6By6nuvS/M6tQ3uXZjyqgJXhQwLCZqdd8FwrdbkKuuaHsnuBT+ERCoVqux0/o9Es0hlnK7LIUIDZ/ibv4Q4/Qm9DdPP1OWE4iidRWSPRq6p9UnxpWP6NgX48B3EP1+WRVI+KXxhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638008; c=relaxed/simple;
	bh=HeWFhWARDDSo7OBCk+ie/Wy96a9ghaPf6RUL7+HYQwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoyCan2E/DNNkJ5IMe4yF/6u5IWMW8wdrXsm5AFvidpj9OaMummJsga239VoauZDPvS02Raxfs7g+d2dLQGeaJRUJR5t+IFtDhCXe/Hd8AW98c9ITkB6RvmhhLoDpOB2z01Vp+GyTtspUqAfeYrvh1KMYAKx/GI+svon8vTgzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PuEmoe0c; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso2881063a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638005; x=1754242805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LS23ubGPWgljW/O2InkVofzyPwGDMqbidiBz0qrKrLk=;
        b=PuEmoe0cu4VcT7oNaJjs9Fp7IIKaRw+RYxP3M9k5UtuOG40EPBXzu9Cpw37fMfeEkB
         QWXNz+6GJBPYGjGHs/H/TVeXbOs9GO03qe5AoIMep+pOlJVIAW0Iqu8Qp6SV43IWNNdp
         7nBryPHP0JNxBvA8oh3Ar8JTremDV0Gh7FM1HT1Gsi+YvTYYleAfDl5pcU3gJ7qftNU4
         +G7wGBAP10EjiiXvRUFegbtEDPh/oLIEMIo49emy1zduVsHN5bOWXiq3xAl0l8qyyIa8
         6xtPgW50Piy/pvUTqtLU0UfatPTXUY9SK5A8whwrI3i6fgr21rQFH2UhjRyDJIre1SIf
         qVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638005; x=1754242805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LS23ubGPWgljW/O2InkVofzyPwGDMqbidiBz0qrKrLk=;
        b=Wf9TF8SGgit8hPavaCOAWLAcrV7U+U7zKLYqSwS/jCOQV13/2O9GxyQribylXjl9jI
         6NQJ8zEvhpQx+KfytZGC/HfC8hpUf+6nRMQoFWKRrAxBfo8EkdqNdV6sdlKv0LrHxNmw
         aAfcEOBEXihb9EOSm1+lirla4wZFeMipky3nOm8Rcgxx8wimjx0lls6Y89hjH7NnvIBK
         IuRVODxzwwUygY0jzajvk9VhR9XpNw6KNWJFXiVvAfroWRv7nBtKgkZemTQ9yIgyQKx2
         nrED1xHz/QMcnSi8qYz6MJgehq3oDnWx9qTyNrL6Ixgu/rmFkGNclMY/CsEn5UAZ/lPr
         NTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIKS5y8bXSdlflJ1YiCrmvvnAEdxuHXALfaWE9PV50PRHqGKk4ai5HW3ffSZ758LTF4fEqCBJB3zWSfBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkiNm2lwL9/DJAkRgU84aWmJ7LdC62h7VfFUTHDexbZrJ45HY
	LnC5hURAVYwcVAFvt20XBVskLWa2NcXNprBO5I498L5G65odHVS5Pu5V3t9k0P4WnF8=
X-Gm-Gg: ASbGncvGvlW8ZZs37a+tcpfMbkxiypWLuBNUofgqlpUOjXk0H13dkRnzOri1gJgjy3g
	QU4JliU28M+vILfoBE0qNpyebh7iXNGcWKY1PBCRbBE4AI641H3HP+p/153bAnwrZwxybLHZWr7
	hgfSVzbQGZNdnAmywiwpqvTymvYNqCFPbenYnjoFGsfUgsWQR+36sWnewhifb9ZP49tn1JcCHoQ
	Lzp6bKtW/TgBx8WsqpFB0b2JoSARFWdSBnv6zoOqx6KlCyH3QU9ePQ4x9HAQVgwium57ni0qG83
	bl0e4QckNdkWP0WNLyK0ogjbQIXsTXpHJ45Jvo+XdXOd0mZQEhwDwkY8x554jKzafI3t85Ewaxp
	EF8fzyHo=
X-Google-Smtp-Source: AGHT+IGO1oq9IdEAlEt5/esto5f6vZRRYoJ7wmisC7FH0HIEyeSwOgI87SEWn1JY8r3di9EVph9OdQ==
X-Received: by 2002:a17:90b:2b86:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-31e77a008a9mr11323342a91.23.1753638005462;
        Sun, 27 Jul 2025 10:40:05 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:04 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 0/3] Optimize wbt and update its comments and doc
Date: Mon, 28 Jul 2025 01:39:56 +0800
Message-Id: <20250727173959.160835-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Some minor optimizations and updates of comments and doc for wbt.

v3:
Fix a typo: change 'cur_win_nsec' to 'curr_win_nsec'.

v2:
Patch #1: Pick up Jan and Kuai's Reviewed-by tag.
Patch #2: Pick up Jan's Reviewed-by tag.
Patch #3: Take Jan and Kuai's advice. Change the name to
'curr_win_nsec'.

Tang Yizhou (3):
  blk-wbt: Optimize wbt_done() for non-throttled writes
  blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
  blk-wbt: doc: Update the doc of the wbt_lat_usec interface

 Documentation/ABI/stable/sysfs-block |  2 +-
 block/blk-wbt.c                      | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.1


