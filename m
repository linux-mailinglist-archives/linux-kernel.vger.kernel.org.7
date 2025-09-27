Return-Path: <linux-kernel+bounces-834850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F2BA5A37
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB42A28AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA222BEC52;
	Sat, 27 Sep 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEtbOpIa"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B01165F16
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758958134; cv=none; b=jVCbxLAjl9zXsMEwaDKgHUYY4nfNfEAJFdLpBbHStNH3+/j3uogASnB2HRbHikmjkNn+FyTadErA7tmqciLDlUnQdghEEClnOhDCi27KxDGb7j/rtK+/pS4eAB1vEREg5pDEsmmkvFxNwforiKIJLVT81+BryqxxfbbncxnHRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758958134; c=relaxed/simple;
	bh=ws6xOthopswVWueNlcODedeBAn7z4k/3lJ3AIjx7Pvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKmN/gIJdRhGE0Fka53X0nPnBKaxHlcKeoWkFIEctqvnr34oWcPXwfLM/oUGoS9LZKnRcwE9J/z6QwPUhA2rSgKiOfWQ474z/gHP2K9AraIs/OgcfLHzbevR8JKR9kEBs4Qi3xDfpe6UHV90FeYuT/Lobl5XjhCTEixYs3EQXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEtbOpIa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e47cca387so2605925e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758958131; x=1759562931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUF4AT79yZ/1kgypLqGgmkelfJrwmvBHPVvrxZ6wlWo=;
        b=WEtbOpIasBDeUX1KxBla7JPT+sKpR2RT8DYQooaKVsS9YHbTOgsJD8XRhPQcKYP7QY
         Z9YvWTBWql0AXZkfPf2A6a3s6zUfu0Kow1yxUnrFeckB6MoTeWY9h+wFcYT4wWiStp2b
         ADRFXDly4bLhkyP6x8+KUHiImMJuE7Kwf+UP+IJBhZBHq5NqTUdX1RyXpVDZWR1DHHsf
         YCimSn95LhE7VxrMOMpVmw0Hn3X+57LO+ANgyz0UrkCXwZGvefSQsHfYOV+vgdNqwsWT
         qFKmwhr2ZQuoC6McHa+juIbxgx7IXXgdSVtzBMUhsrPoDboea3RY8RlxCJjwULVSEI0A
         5Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758958131; x=1759562931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUF4AT79yZ/1kgypLqGgmkelfJrwmvBHPVvrxZ6wlWo=;
        b=CsZMyaPJg6gzMvKBbhLx5BbKGCWrpzT6ynEcra1H1k4/9ZWiqTzo5JlMAtQt+dweqL
         seBODX8QlvarsVTfTCoCtC7DrC4zISrAaWV2grYff7MlnfhAAZTAyGQ5EuFHyLpV/g6I
         yJP1GV+x4YhLlL4KeAR9gar6oIGgG/WmesU13QGcCFH38qLExv/LnR2t0dxtB2KK/7YB
         sACgkaggKzxszxxEjHfOEYtxdvl+p1IIR2rayYxaoS2WEPxCY6mromg+MxhKdyVhq24S
         gIw1mm7hB2LrTAL4ZopUWU37VVO+fSOvLRqiyqmJyqvZV41p32SFGmooczrCne9wBfNE
         UexQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU92Zz9Pg1K+WeUBpg8irA7pAPocznAn9UysXG6etw5YONMj/W1InDXA8GJH9muTgjIoAsJcVx3IzZk3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQDMBDiMpAjYl2s+wFUDqR9JLC8h7Rx7DPsuWbRCCBfV7Fe15
	19GBzXvXeUi78SwPPjc4ARdXtgOhLHQUbbgkTAlcRzoTbvdBn3qAk4m4
X-Gm-Gg: ASbGncuJgt5O/PcmPrfBNvgKORH0i2V376kNXK32EAtUMN9HB1475xM0sHNsdpHuvbH
	HpgoxBq1Q5QXxBltc93vB7t+uQpNxVeVhPcy5LP1Y4E3dDOECVJ3ay7/D5UenlqdabSpLNslcgV
	UayMHdLogQnl+Uv7mJiygZNy/6uenZ7ysZFr/Q6/KNg+cMwtYfPlZcIGQr5YbbNWcUMRBM2fMhw
	TBBwefwIz+n132cs7AwycELLD3AepmhyJe+wmYs+AdCkEmMShWWX+NzDMrAZaWALAmVR8jslzXP
	LYd7czsfGdgWTvPVKr6IZ0ZIpfIapaqMsn8Y7o0mqgHcT1xXc0P0NJW31x9UWUQityYfSZZqCmi
	hhNa5NLuNEWI4TDxgdaBwsWtBoDwg10uO/ne1bZGc3S4SQSYRTkxlMI0LY+fQaRFMnHnLTjm37a
	A5
X-Google-Smtp-Source: AGHT+IHs7ZcfbMRLMn987bC07Y3CP3fXnKcHfcSNzdjHsjvCZVyVGzddO2NeFAa+7uLn15UHmZSsmA==
X-Received: by 2002:a05:6000:26c9:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-40e481be731mr8950415f8f.26.1758958131217;
        Sat, 27 Sep 2025 00:28:51 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6921bcfsm10353127f8f.43.2025.09.27.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 00:28:50 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>,
	syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com
Subject: [PATCH] hpfs: Initialize memory in `hfs_find_init`
Date: Sat, 27 Sep 2025 09:28:04 +0200
Message-ID: <20250927072804.583940-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid the use of uninit-value in `hfsplys_strcasecmp` and `case_fold`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 fs/hfsplus/bfind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..75f1c029c2ed 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-- 
2.50.1


