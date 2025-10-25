Return-Path: <linux-kernel+bounces-870061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36070C09D27
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8163F425856
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989093168FC;
	Sat, 25 Oct 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYD/Vwxh"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527773164A8
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410475; cv=none; b=p4yIMItgr53EfYq5BbXrI+44Xv2sxbvAXZ0wCFBJ5bZW0juV+rgxcZun6DjyW9fz8QiA4AJti2pYIQuzAeSYXzdUH1KPvCWBlJOKb+/Pt+lQjjspVdV3ttWXrQfhfwyU7Aamng+r2H9U2UDp+hIaoGBPL7rVMoMimBvk8R7Be5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410475; c=relaxed/simple;
	bh=+b2D4vP+c+kh3wd/DS3NcNXJ9L+1kZpJcsBrgvelyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz1RtZVlZgDp8oDLNpfxlpkbJIFfbeRrLdr3sqp3tOqQbQF6q723K5nVGOsIS9fQUXFidBaEdRYJmwAVOcUEMYsX5iF0Gnqv5ZfVFDQ2Q/cvezm7iTQ0IRuT38BpQZcKpWghckKgX5dlwX8eeEW0uOIFmvySCVOCoRRe10RC59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYD/Vwxh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-879b99b7ca8so35251466d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410473; x=1762015273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGBaOZhD7YMIGtASkoY94KR31YSs6yG4R1SCYeYD08=;
        b=nYD/Vwxh5DzzjbOSCUe+NVazQ4qdcD3uJBk8V5wd1q4aa315MUnT1QIBHVkuUE/gli
         8+cQ2CkvHs5ffMaCnkxhYr3eIhPvVgZ5vS54ReR/BF6e1M2mIQiO+XLTctvIkfBuw5gS
         4jjugNJurf8YLw4Dlf1QsA1f6SGvBjNcrRA5GpIlUGyYTRBZZTEfnzuYA3S61NsgGCUq
         5w9BjX1yMmRoNTmMHYeIDX4myaXdGB9airko2oNP/iDUfTW6yvTyOUTp62cZCbveWCpg
         Zp/fWF52HX0HrMAaHBJJ09T5vRO7BwkXa7D8gdReiOhdWwyoNZmJPPtYOMC1raxObkxY
         /DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410473; x=1762015273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSGBaOZhD7YMIGtASkoY94KR31YSs6yG4R1SCYeYD08=;
        b=PAxETfzpd6XgXuDDIx2F9rEHunXERPJJYo/B+fzVF9eXHhsbX9Bvzx+HF7eETZkBqM
         DdcZuxwKsu+S0mxwYrCvYWEJlxXtPimlZNA+vMtv4Y9kEwC8Dj541Lip1Ztwz/j2pR1V
         fg+IH+X+qNqUw/QJKxN5HSqAAotctUaeMOk4XsmOS3HgxMqUCPKjJ+M4ZIHPMF9tFzu3
         xKqAgsVDub99UId3kn6LSjm/hMFfSwD7tGy/1jOzuYrduLqQ7PZm9U0FpN/7yg8zVbqm
         /RnZarEUWjBcjpY/GygWYxWq1d5mzeKauJtxXIvxCtNVvhNSkNYPz2W4PRN6VksTsAe0
         RgVA==
X-Forwarded-Encrypted: i=1; AJvYcCUdOTkN562CknjFohSxfGMyrodbFLZ66naxHpEyZyulF/I4EErpw40RJYOuxPcuYZkqttzHwF61vYLJqhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KAz0VdVGjsdT2PdKCy84CEDTaCSkH39DCBH784YKarvhsqpm
	TeMEEsiHZQDXbh0SHyFTVOmd6ypuF+36pz75r2t9e0uU8zWmUP6QwEa8
X-Gm-Gg: ASbGncuuwTJbUrjUUJC+Kl84kMl8JomgLSEBt9PXdRrOooGRjOK8SOkCwE92crvqbSO
	Pc2pzcXDqBIdoe6s1UXtsjF6etqFBOx8LD5A+oCvDBIdVFva0uiH6Hbg9y2MDgix4MamdDk2gEB
	zsNXBLy1ILRkLG5mgo5OumlLQBFczTSYQTxFdzvGu3TT/Up4lp09d4dCZR6558Fyf1/3F1kPqkB
	kBsZkbB3MtXFhbluX5+9eI/x9YhE4GTHzS/yNx50ZdKQgIZfmf9wJ4etrXbOvIJKd+gZpGcHx8s
	e8ZhSNOU7gcj/MU43cL8H1L2k8y6UvNy9I80G7vcQOJjXormN5iSQSjARScE+Tsl11kPSG/MfF5
	GqR9SlTlMlBiGlw7JWZ2utwL6LLBdXxpDd2WP8kbheH2xNdRANzcsV69OnkEEcU3qDqTSPYeiuU
	8bB5BM2bA=
X-Google-Smtp-Source: AGHT+IET2ieKd7HClaxmc2UuGKPF0U/OBuKh4tSzjlCkAHwEFQ6XG5lTAKnqA569CDimliHjdRoa4A==
X-Received: by 2002:a05:6214:da9:b0:87c:20ae:68d2 with SMTP id 6a1803df08f44-87fb636016dmr79581736d6.1.1761410473001;
        Sat, 25 Oct 2025 09:41:13 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49783eesm16403966d6.44.2025.10.25.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:12 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 16/21] kcsan: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:15 -0400
Message-ID: <20251025164023.308884-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. Use BITS(low, high) and
FIRST_BITS() where appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/kcsan/encoding.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 170a2bb22f53..3a4cb7b354e3 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -44,8 +44,8 @@
 
 /* Bitmasks for the encoded watchpoint access information. */
 #define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
-#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)
-#define WATCHPOINT_ADDR_MASK	GENMASK(WATCHPOINT_ADDR_BITS-1, 0)
+#define WATCHPOINT_ADDR_MASK	FIRST_BITS(WATCHPOINT_ADDR_BITS)
+#define WATCHPOINT_SIZE_MASK	BITS(WATCHPOINT_ADDR_BITS, BITS_PER_LONG-2)
 static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
 static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
 
-- 
2.43.0


