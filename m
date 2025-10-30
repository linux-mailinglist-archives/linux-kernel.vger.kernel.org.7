Return-Path: <linux-kernel+bounces-878051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C42C1FA97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33418188D523
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33B3546F0;
	Thu, 30 Oct 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+gFiaHP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F6350D42
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821745; cv=none; b=qQ+VhTsgz0QRrt3Wmi6lAYNo+OLJTC3yztJtwUApDjV2OrC5StDT9EcqwfdIKifreYoq0WIXm6lsbgP3zF8LvYIZwPJLkwxWGUdkHMi6G8085nvew/h2nzT6vGS04V01wbbZSws9VTEVLOMtFn2oE41u9vuoXYrLOB9v3DrD+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821745; c=relaxed/simple;
	bh=Hs4hTUzQ6BSYyYqkQGWYwzMV6aX4ms6lWAYNhzovJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5DwgTqvoj0U7R1E8WDLXFnj5agNNsrUCISj3954GWHrofzAbgSxaHzmG90YqsfvyiOE+et27Ev6w9hm6G/q/uOyImkJ2vnih7lg3sQZsmiKOkycffFyfU2uYXLJ5K7K/tFC6L52JhzyrvmvaIMdQAdlvvtgQrkB80/36CkrTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+gFiaHP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso1311299b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821743; x=1762426543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdbZeLQdr2GndyflsV+Dqob/8hVKHQK+9QLhrbLboBM=;
        b=g+gFiaHPw4ahn+0h8Iwm3zpWIWdT3gdRf/eblhYcybAyuZq0sG4rZXdJK6qKutEoz/
         6UFh0yXg6rtBySDNXkaY3fIuUHrZ83hz2MKcwgft7AVe0hmB+gy79GJG3ZPEbhjd2hn5
         GedunSi0FE+HNpW528a5B/2Cynpsvx+pRmHEL8npyHfHO1EsgvlNtCZAgGyLp2a7wmzV
         MfLeankB+/4YWLjtvaMRByDt0CnNaXAS1AJ8kdINY07LfMxXw/5EfkDzEX+mH2zAp/2+
         EB++Q+Aq5YkSilFd/z3Y0M6Yukw5SkgBwC+PsjKB/A8jX3Atzso+lHkeKSRhkUQYe7SD
         vF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821743; x=1762426543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdbZeLQdr2GndyflsV+Dqob/8hVKHQK+9QLhrbLboBM=;
        b=DEK0mWXi9b7fKB/y3hWOWj7ZTsrAkcKycGuTHhmwXeFFY3iyh4Mynn0rbxpoaKNPX+
         QSTYFfclIMKOqL25MhDKNCh9DggockCgiyWVVcrdH8/DNHiGnAODrkcgNPcDywsoOKgj
         R0rpn3cu7TJdngB6C6/V2eX1D0i5ml8XH0vWyWKIoF3kOxaQ+VP28VTVfuuNJX6YPDqZ
         HziZZwDupa1vJt524OzL93TgnJd7wfanblVkuBjASvwV69qVtFx4uDqbtmui7Ikthgr+
         rGUr4iUh5ABreDx3QW9IIYqFEIdulLNcMYbB8G4VppYVI4n6QtXJ9GnHBJVHYpZXiU5B
         lfrA==
X-Forwarded-Encrypted: i=1; AJvYcCXLJLoUi5A1HvSRixqh0Fm06u2zuFFZi9MzHh5mYAgYB0MAOHLJ184uJ0uTYMMipdQ0BrNUzO/KayXRCdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiCGAM9UqTr9bf/O9bnR8xjU9B29hWS8WMPXDxQqmCxEEwURu
	DsEbl7ADFEbZu/F+LBKoNsXd0WwpQ/wfk6aTJU05kvMXsit1BO/F0kMy
X-Gm-Gg: ASbGncvL0TVWMwUTT+0fgvk3OZ14gIGL0vMWwF9ozf8X49jlY/4uK6orJM7tjH2r5yH
	qP97/CObbrGndL6Wj8swZyHsWRwb+L4qKvkWKXfH6iNO2UXv8NfWctT1tCfrXSmtBEUXTUu+UHn
	cT8i5D/CccK0r5c+6IObh/JsiuKPnRFEqxb1YN1I8FU7JipuyAZh74vw9GC04sHDIE7GZ3D4pxW
	BLucLqeAnRPfYFQgPRuAW8l36ZCLRd9Fp9A1YXZagMaNRHsIh5bLvVFpY0bt0rMKwSUWi2lcNCJ
	iuDZW5lN5GhyrZFRXBWGBn3LZU0IGEHK8z+f7hvKtFVtsJ95U24j0GQc2gpKBGb6FZ1rTk4m2fF
	xRlXlZCzDRzqfID+k9lOh6G9Ht60JSjxes2gD5fRtxebz5jQ0rLuqggzx9zKg4HHnYRyWwf9kVg
	mLpjT4
X-Google-Smtp-Source: AGHT+IHFHTgPiy6LdfKjy1W3MoUmDrMxQLVFdcBtTtfjMOw7wO5m5u9VK5UDUVwyvZbo3B6KYA7cnw==
X-Received: by 2002:a17:902:d2d1:b0:274:746c:b09 with SMTP id d9443c01a7336-294deef46f6mr82782085ad.55.1761821743235;
        Thu, 30 Oct 2025 03:55:43 -0700 (PDT)
Received: from gmail.com ([152.57.106.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3b64sm187367135ad.3.2025.10.30.03.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:55:42 -0700 (PDT)
From: hariconscious@gmail.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ASoC: soc-core: check ops & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereference error
Date: Thu, 30 Oct 2025 16:23:14 +0530
Message-ID: <20251030105313.32199-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Smatch reported an issue that "ops" could be null (see
line 174) where later "ops" is dereferenced to extract
the dai fmts, also auto_selectable_formats can also be
null.

Add a proper null check before accessing both the ptrs
to ensure a safe execution.

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
Hi,

Smatch flagged a null-pointer check in the function "snd_soc_dai_get_fmt". 
But the same validation is already performed in the earlier function call
"snd_soc_dai_get_fmt_max_priority" before calling into "snd_soc_dai_get_fmt".
While Smatch flags this, seeing it as a false positive, redundant null check 
added to make "snd_soc_dai_get_fmt" safe for independent reuse (if).

one way:
redundancy can also be removed in the line no.174

another way:
to have a null check considering independent functions

Please let me know.

Thanks.

 sound/soc/soc-dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index f231b4174b5f..a1e05307067d 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -177,8 +177,9 @@ u64 snd_soc_dai_get_fmt(const struct snd_soc_dai *dai, int priority)
 	if (max < until)
 		until = max;
 
-	for (i = 0; i < until; i++)
-		fmt |= ops->auto_selectable_formats[i];
+	if (ops && ops->auto_selectable_formats)
+		for (i = 0; i < until; i++)
+			fmt |= ops->auto_selectable_formats[i];
 
 	return fmt;
 }

base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
-- 
2.43.0


