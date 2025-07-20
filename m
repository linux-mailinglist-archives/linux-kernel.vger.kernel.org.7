Return-Path: <linux-kernel+bounces-738011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E888DB0B319
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6FC189947A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B972616;
	Sun, 20 Jul 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSFJAdw4"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D702F4A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752975711; cv=none; b=pkECmtCUQ9KN5/pYXdFy0zTm/OxHtz3TaLR9kAX5AAqVrn5aOSdS/Vpoj+wud5rX4vdMFZh6drk27A3mMVQa7pZZ7i8QJXypth4zkAuC+YZwj1J/X6td/b1ealPOrjRysXtNIl0TLDC7S0hg/brIqapSfXv9aopkTFRMcrzX1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752975711; c=relaxed/simple;
	bh=FUyNxVyQMozaiKJCHhpEhXBcAi8pbUh2SUFuTPiB0pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfL/zTlkxMhiriDveDsXHpFIh6/VzrvlyAf7JENY0NWz/AXNh8xjryOBYw47hd2eg7H264p3m+4yvqMYlO4Z8rFX0KIGunsSR/gzHn3l6cu1g5X0S7P5Cawtc5pcSOg65T4WXCCYOziACIeEbmmh/6s8XrjKYj0WPYdL+kDHJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSFJAdw4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7196cb401d4so6106347b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752975709; x=1753580509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMC3+sLRk9jiIijHLdbLYkb4xL9MfhQMsl2S0WLRVaA=;
        b=MSFJAdw4ViNB6LCHAg/l0NH0o8+Czkg96ivNbFEziGif1/kHEvTT9isXBYWr8ina4D
         yRzr7rCT/++dCaR41ZAaE1pQffYcIlyT1b5P/sUvJwhwyU9QO3vZK62Qm/Pd2ko1FkR2
         eKIUdP72RFmbWpDjEMB7CE4lpnFZ6uziKkVDgut/eUDsyssaF6ac4Cw5TVCW80hsdGkg
         0TvNp5S9ugQPsska9fE5XXWZeJkpTMv1bFtM2kfTJ5ljdXM/q9T9BPf+a8exZPnugblo
         pvdjNm4y35jnOyGQTi1Mz1ds68UDcvv3gmPi/NozgdQB6CnEaf6FisX8e3K620wlViWJ
         IQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752975709; x=1753580509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMC3+sLRk9jiIijHLdbLYkb4xL9MfhQMsl2S0WLRVaA=;
        b=pKJiMfwOeCNpk/0fSIFeqrNoIF6J7vJL65fYCHTpg/WaUqD/GJH06IiioNS3cxmQ7f
         z2lWnD02SInsVoQ5FqTA+bKsFCHwISGYBSBed9nmt7LMJv8osrpzCkHbUBF1Ud+fHsnh
         jRR77DvZ3XtSRbJAEZLY0UfopUtFFn8c/sdETDlgB1MryyEiuTVqRhPPnjKfTmZvvnX1
         d2ieWf3nvl7U4W3BtYTHsjJ716nh8e3ul7Oc3lVs44l5QaAmDfAJsurmtC677PnQac83
         HE13jznI+ZbsOYupX/zCpBoNQPWnBT4QDVUgaDWe+M3c7yEyThDg2PDvqFmU9Beoh2LJ
         vFfw==
X-Forwarded-Encrypted: i=1; AJvYcCWxH7IX7n2YVD6gfgQnbWeXePEE52MuAza9L8Xfaw/oSgP+UT0HNLcSJpzE3An8KfETXKWqMtro7XzKTVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kHQb8B4zBdMQegaMc8W5FJBwQaaMdww3V5vyYJH3hKewyniY
	kASpqpXdmqlm4QvvsF772lI9XfJcGfiR/9xXbazUIdaKZjhfN69oM4di1DcKyA==
X-Gm-Gg: ASbGncsmFLplnho92wsKgrhBL+RTpfWpWwPKyrqGYU/9JqD1S/SC+1NLkfLzAQjZMJ7
	seoVLx3gz6r2abtBxRHS3OHyc7bdUu0XFIjfg/i+1oe1WmuVKaLpnfwNiPDARRrRtCqsnEKVrv8
	durJ4D1q+9NgLdlc8jNol+NF1FxjDtOlTB/4Flmp7xyFLrb8m+aj2JrdCqVbE7dxr8gjJWxpLJe
	H3U2WkaOYdm8I6TQ7ui9lrGwp6BUuqHTUovU1fJDj+Vxa6o4T1cjvV1loJY36CsL+jyjXZysTgv
	wFlaOCzSe8xOHrSRBSDNTKYGa0BSBp1HK1nMN2kgVYvEJXIWdQL1qc1FIJxp96tBvAVU6OpSyyA
	9rzmmnAtFJaI8aA3m4Nhzh5zWx2l477sG68Jq4H63s5AI6HGBZGaFr0D/Ww==
X-Google-Smtp-Source: AGHT+IGcYn4dEY6fOHsN4NopTIlPwOISnDxf6Z6XyPq1kyWgKZj/qw0f2bC//DOaLbqTe3EsDNyUhQ==
X-Received: by 2002:a05:690c:7105:b0:710:e4c4:a938 with SMTP id 00721157ae682-71837466654mr185526537b3.38.1752975708760;
        Sat, 19 Jul 2025 18:41:48 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310a968sm11450537b3.2.2025.07.19.18.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:41:48 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	"Xin Li (Intel)" <xin@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] bitmap: introduce bitmap_weight_from()
Date: Sat, 19 Jul 2025 21:41:43 -0400
Message-ID: <20250720014146.432316-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Introduce bitmap_weight_from() and use it in topo_unit_count()

Yury Norov (2):
  bitmap: introduce bitmap_weight_from()
  x86: topology: simplify topo_unit_count()

 arch/x86/kernel/cpu/topology.c |  9 ++-------
 include/linux/bitmap.h         | 11 +++++++++++
 lib/bitmap.c                   | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.43.0


