Return-Path: <linux-kernel+bounces-874447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8CEC165B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42791A60FED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F834F24A;
	Tue, 28 Oct 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="U9rJbZYk"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50034D92D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674205; cv=none; b=JD7mvW043ixox4AjQXjG6S9X1LWB6Xo2a1Wo9Refu7XfN78mIfFc4dmpmOOjEUFvNVAohfgDCqpEJRt0AJvHjbfmjpkWPAwvwATnzsA23w5AKJzdLCfKseVPCgzg+eYFR95DrsVXx4961yVZ05hfTs2DuBkDbkwNcOaKG315muI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674205; c=relaxed/simple;
	bh=C0BR6PL+GP8YMCwVuMw9JlDJh3keCCAtAr1J/nEK8K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBBnq0TFUg5f5uMFboM9NTR/B9kCLo6frY8oL3nSqemo1mbHuaGyVguEtGA46jNrFtMPtvg63qGrFmbgpA0GHl1lq9+oYjUs5T+XZImPvZd995g2U+gpskhlkhVDWYntpRX113TDoSSxsEpyFchI8gqF52CTaRtCOs0Dk7+nR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=U9rJbZYk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so5011198b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761674202; x=1762279002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfRvHziFqkZObFlV8twnHWKmYqDLFJYI9I8WICLUIrI=;
        b=U9rJbZYk795ou/MWfByzOO2Na55crzr/3X3jfjhnsPqJcXvUh/EcHZTbJi9VMIv2K+
         9IpCEsIS5NIxTp3Zef9OV+LA3qDlKPkQy+YRoeXnABj1gp71tQCQ/pTfza/zevOdn+NJ
         0Dm4+iQb9Zvwcf0JYzQa27ziIrJtWVlX0nDk9IA7FoiCt8gYK9XRpfrY8JALKaNmdcxr
         6qQgl/f3jyyGCW5xBAgW4w7QlsznDApdZGcr+bP43G1oE8++Pu2e+Pw9UpPribJQFFPV
         N+Dz57JvUYP1qhAgP+TO12qW6g1tPjcvyosdKu0QOKZfYwtuE0FS76pzU+0kVJjudJjB
         gWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674202; x=1762279002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfRvHziFqkZObFlV8twnHWKmYqDLFJYI9I8WICLUIrI=;
        b=ZMtCwe73N9VUT9F1TY7+XjIjSLV9c4H/0eOT3zUJMku09hsC8pMaDqLpyd03PJBCX/
         kJbk7NHn4Cj3gwVq3IEYrKx057bfqiJOIydx9Qg3liVS1Pc5b0f77/Butm2ES0KwyZ2u
         MsXWvyh56gX1ReVordU68hXhtUcL2FpwqJATouQGl3/qxbHuMOsbkRNLNe4FEn7n68Oy
         G26Uf2vgoSFYMxPImRPFTDdOosGtzTRpB3rZomcxKX9VRE2kmYMT7WLH0izfyiMKNk/V
         Gg+hrOgABD4Xo9Z35y1Wws7H4v5RMJ/5w9gedgKcxFXJ4RpbolJeEJ7eT5EvHhmoGu/o
         qNAg==
X-Forwarded-Encrypted: i=1; AJvYcCVPnqujFVgn5UPdb/AAhYiwquE+0d9PCCYLb+nWVsWthNEeE/zNqEsXBURZtWQcADOsxIL2gJEKD553WMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9H0GcxSkj75qPxHNErlo83p/25w+VTK3yNs82EIrtvDSl+orv
	X1UdrFQo8PFVMF7j51+43v9A82knU4Wq/t+m40XexiFLHjwL/HcCbpraoioQclZCy0Qy3+ZXXDO
	G3/P+AMA=
X-Gm-Gg: ASbGncu7t3B+u44kJcGegUr0iaWaPiHMoLJPvyIR3JEN28cItHJE+zepUONBxWCi+9x
	NfgVxNdPUUiHqQbrSqIIv5OwMW5vo8x0KwsXi2R0uB5T5a0SlWVvsoc/bDOyQUET/5q9LYfIpI5
	HhzkaxMesLTIg1+OhkDCRNBQf5CF1sAGkE0U1mNNzRbkiXeBfYk1tFKEGSsnbrV3iwVyaP3fyjh
	ISJmBT2RYuUn/cIL5M/tcw6uiGcW5TsvGcPY6Mslzbppr4GJxG5v3xrSHgNjtaKJ69f7yICTwSf
	lHKEO5gMOcMUZ8yXb1R3t2JjD5vN1MO2n8uT7puoU6GM+LktslzKhoXPqHuvapGaYSv5lrU/gel
	Kt9nxVcUvsiX1l9icyFnB/wlpnFoBmRcuGfn4jAql0ueaHSW0zY3nv2elt/tIfdCmLFBo/9laB/
	KbxOSommtQDmmH
X-Google-Smtp-Source: AGHT+IG8Yf1TJEydayMTVhRw5T6v7lmUN7tOxdDOQ5l8aU63IZjsHtT7xhhADx1jgM6h7hMeNYGC1w==
X-Received: by 2002:a17:90a:da86:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-34027bd07d9mr5254117a91.19.1761674202321;
        Tue, 28 Oct 2025 10:56:42 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed7e9660sm12829033a91.10.2025.10.28.10.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:56:41 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: marcel@holtmann.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
Date: Tue, 28 Oct 2025 23:26:30 +0530
Message-ID: <20251028175632.146460-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for ptr using kvmalloc() is not freed on the last
error path. Fix that by freeing it on that error path.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 6abd962502e3..1d4a7887abcc 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -625,8 +625,10 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 		len += entry->len;
 	}
 
-	if (!len)
+	if (!len) {
+		kvfree(ptr);
 		return -EPERM;
+	}
 
 	*_buf = ptr;
 	return len;
-- 
2.43.0


