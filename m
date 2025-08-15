Return-Path: <linux-kernel+bounces-770412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8BB27A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809071733FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B592D0635;
	Fri, 15 Aug 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgLblVfQ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D02BE64F;
	Fri, 15 Aug 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244609; cv=none; b=LCMjF8uFMmPiKXnoaRTnRhBs3i/1QxRHX+FGs5MaC0leavvNtRR2URcjD6cTFPOy5EYk8H+4mFcOlhKbnUIBlcryuM8lB9j+zLGmIUd7Kx24wEeHGNE1IBWDIaHw67EoWupxHmR35Tcg767/JBjDNSQxCbqGy0jorBoEyIWKL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244609; c=relaxed/simple;
	bh=oiW7TuWfQe9Z1HQMPOLyGiMF8f38lxC9MCTawN7ptP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWKxloOZ2YH2SMNAUQG7pBJZvEfowM6xR/Am2SNy0ysYW0bTg6MAowg0/McQb/7UbVGF4jjaEpRt2h7mzYHt/4rQkHC7MmE4bp/mq9D1MOcU15i3+dUNsMUnzDA2Cbcn7qAsT8tLsWMa1m4pGkZH3k6AlfglpyhjQCeo+3h3TY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgLblVfQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so1078084b3a.2;
        Fri, 15 Aug 2025 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755244607; x=1755849407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMTg+nOkj+dnHJbIiU5pkF76kd2wHW96OO62FUl4QQU=;
        b=JgLblVfQtJy/0YMredR0fgF5LTDNzuDG3dZmjI+FMsiObZN6o/iX6UAEio5liOIwdJ
         BCYk6OZU4+8bmuLzam69pmZQJkfEpmh2v7g3hzEAAX2KURvH+3G8mCnqs+xyRwOkn5Tw
         Po9XSFws0iNGrvYW8laGBvqhheE8mxnPOdTLE0tptM92K/orwP6GqJsOozdRpY2Tj7gm
         cKqXJk2fPEWPAuYKMdJiwk7df5u76nWWpKC35tSOdYsK4P34s+T3QlALEekMMqV5DfrV
         ClkUju9G/X27NnSDBsA8JRmeoWxKEZfquYd9VtPf51BXPiKWwBQNMRWeREB+ee9F44Op
         eojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244607; x=1755849407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMTg+nOkj+dnHJbIiU5pkF76kd2wHW96OO62FUl4QQU=;
        b=gAthQvaS1lzX7fCh26N5YR5T9gDOE/psY9/ADwj6HghKnrJumlz5Ww3SPoKWY2zPH6
         trjsOFil9wtz5TF2ypjRQglTRqFnoLR7/Qjk9DWOTG/sqkci6b38u1oObdekhrR0GxpH
         F3cupQsIldbOgQcY/ZAyjedRIptEpEzjomUIw733pINn9aSxYuIaQB5V5GPaCk3LeD/o
         mImHzkOCg6O7F6ypa9O1KET995znHw91CQOTmQJxhd1Epf2Mlglydkap5V37eqeWMv3R
         drdbu8Y4Tb7EPVZpkMbbYnOMysjldOpobgoJF/u92HAuS74axJRtpv7meWgN8tpiVi/U
         EMHA==
X-Forwarded-Encrypted: i=1; AJvYcCVBDxY4igmV7B+bTe317V113B/64R+PDoV4p+aqx+Z7Vzy/aHyLhQaqDAKaUds48UfJZkpz4G45Qqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2fTJ+1hAONyu1dgqqm8cEH+ADLjAxNS5KHPI6VIWtCc6EEK5
	nFekmBIWO+Mps1Mi8hw9uuTl1tJnWnAVXNo9isEOpI0A5dBt3plufWzy
X-Gm-Gg: ASbGncujM7tgF+BOmseZNe5rc+AzMItcboMW8VcK4H2zrAyOTr2lKB354JNqc+WWhJj
	fbttFogDSPEOUXE6lkB8mC4X+Jn9o4U196wLMrfQoYP+Q1bLV+y1Cx4tQsrT2EupmU5AHi17ini
	JhxpLqWlQV1wnayIviZdBvdJkDIrMd2G6fzlPltl1bpq0ErJpFA5O2B1cf9Asnc24+q2y6IAp2X
	+ZWsP7vodUDJT1ksodxPuQf70mTICOI3rAwm2ibDcz0fE4GveP/p3Nh/aPcrje1IZOPoqqZsYj7
	QCl8xKIuGg3Z2jo7uWpRkcnlkwKAqFm5lynrwGzQjOXk21J2Vvvo2ZB/HXljO78L0QaAV9eVsbn
	8qEswDvOp6SpHWM8ew2a48fEnRTqFjQ2q
X-Google-Smtp-Source: AGHT+IFnhmNbusWTe/NOS4pC1bhuI319agqnjyX52xFJvTnt58N0geNwlNtco1oTbthm6m7oN0gKbQ==
X-Received: by 2002:a05:6a00:228c:b0:76e:1f87:222e with SMTP id d2e1a72fcca58-76e446ab211mr1706302b3a.3.1755244607021;
        Fri, 15 Aug 2025 00:56:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452b6b48sm590217b3a.52.2025.08.15.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 00:56:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 01D924278709; Fri, 15 Aug 2025 14:56:40 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Device Mapper <dm-devel@lists.linux.dev>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] Documentation fixes for dm-pcache
Date: Fri, 15 Aug 2025 14:56:13 +0700
Message-ID: <20250815075622.23953-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=bagasdotme@gmail.com; h=from:subject; bh=oiW7TuWfQe9Z1HQMPOLyGiMF8f38lxC9MCTawN7ptP0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnznq83ueyr1ftSQOqt3pKUn/7RbddSDTu/venUPTsnt 33+U50VHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI1DSG/6XzBBm9phecKmGf 9GlDXu+5M3dvO9lzcwhP6HJ6czZS/RLDf+87wjdfmXAWc0h8+RPS9FJLi+/6hoOLpkXzlEju5Gz KYgcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are docs fixes for dm-pcache as reported in linux-next ([1], [2]).

Enjoy!

[1]: https://lore.kernel.org/linux-next/20250815130543.3112144e@canb.auug.org.au/
[2]: https://lore.kernel.org/linux-next/20250815131115.45518c74@canb.auug.org.au/

Bagas Sanjaya (3):
  dm-pcache: Remove unnecessary line breaks
  dm-pcache: Use bullet list for data_crc constructor argument
  Documentation: device-mapper: Add dm-pcache docs to toctree index

 .../admin-guide/device-mapper/dm-pcache.rst       | 15 ++++-----------
 Documentation/admin-guide/device-mapper/index.rst |  1 +
 2 files changed, 5 insertions(+), 11 deletions(-)


base-commit: 6fb8fbbaf147fe4153177320ee354c457605800a
-- 
An old man doll... just what I always wanted! - Clara


