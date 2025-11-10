Return-Path: <linux-kernel+bounces-893759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9939AC4847A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDF4F6AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3E2957CD;
	Mon, 10 Nov 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="cf8A7hS+"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EE2957B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794975; cv=none; b=nlwAy3+c7CYwIRloNZdVtoSL17mQVjpGX/9dgnB8TjQYFESLFyDG8J2p1cqoitvCmjxALemFCOBHz3pePzL0ZykQrpdh7CkPFv8vQ8BKcVDIIqf/vLzy+641Plu7pD1nKmNlr33YlbNQ0BmIIfZPCVF4MyKhjzVDEN5Dthx2QSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794975; c=relaxed/simple;
	bh=bbQpKVYp7X3/PiJvnTi8GcsVaQwcsDS13rMuUKdQLgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fmzmh0mg1IhLmpXEeZMiwLcJv1QIhLLpwr0OZ2tlRlKENJ6tZkr9xfZLhPzpOgp/qKuTZ36X8nGyumeDkWcfeqqxmW+NJo+LI55n3bjc7jGE8+kvakPAAMikC1aPn2oPlNNx4dVVeVFz4oy8/YJwKOvCSPUi2ciQ0Ylm6cI9uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=cf8A7hS+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3410c86070dso2159011a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1762794971; x=1763399771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OevTstuzEDUvJLGaVqEbCkP6tz6C+EDWu87XVAJ0E1w=;
        b=cf8A7hS+eUFfL82Z243ySaJOw1LbvaS+mTXowmEYnDcP0znHkJd9xummsvzXQLS6PI
         QIzXoIyHTVlchGLVU4sao8J0vl8JXnjiM6staGyJ7QFlAO6QnnL6zi+zjSgQXgX2i/Ca
         f3H1jUclEnw1DKGNekFyKWvRLQaR3oF7zNKWyENR1zUidunx5sjfaGjt4+wv06P3Vurs
         hVXanbyk6jGy0TyuzWwa03ahJnmQftWlFDUWFYaquJCgf7GEFp27y4O/t/lP2q1u1IyP
         SIXYQCSmE0oYaq8uw77Ccz9UAD112vC1JaZBAGao/uLy/AYtr//aeMR/RJnEP4Z6iqHX
         qqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762794971; x=1763399771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OevTstuzEDUvJLGaVqEbCkP6tz6C+EDWu87XVAJ0E1w=;
        b=HvGIYl1bdMrWzssypN11TgcMjU78v8E1UER+DM6srhAWxMnRsAgtvlCn56Qc4QUvVQ
         bifeL/zC6/ApE/+BTug4Wo2FtTEcuyvnfkidktMfadRhsuPyVcYEgrssSSFx0lUe6Lq/
         E6MMbYmPmkT75kVpy34gfq3MaRK/CRErOXWdiecIqQ07KaWcxHrxsJLWzoOfpdXk5PLG
         tii2nAJoeBcxscxtjWwjjYqvsamRwHQAB7Bv7hVVEZScObV5yhLO7Yni1FCOp1p/seFo
         NeWCqOwI/tSPWzlr/l5ufWb2wXRcOQH7s+T4sMbCwKFd1gPxLbVVSFy235yufhh+go5p
         PQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtQ4mvLtH5/vnImjBXi6JcIEfejSUrzbgAAG7DC3r5vXo16tzknz9aByqANw+grT1Xv8vOZjwOA1Qz7is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRc77RwLHFodLVESiMptUTpi6cb8TkEVbaEZ76+pg4q6ZaNp+D
	7g/KXADclhKAZ9qEAAdqax7hvCZ68P7H5e3HYowGAn55el5hGwsqq7CdtpbOD52DYiY=
X-Gm-Gg: ASbGncu5nUjIkKngzFK/TQwT+bEF1PN0di6dciwoQyl9D81Jyd2g4a5Hw6LmKkycapa
	wQym0wIIHTTTMDjIFtiXIoTx3ryix5300Jwr9IWnBzfWLTHpA6vPob3ejVg5Bwr1HC7lbgldqAy
	Yi7rUUYnvwx80GAebkq7wKnApg188c6+L7+5LsZ5YdGA2BC3NNIC9kRm871XUW78TffEEY6B0uk
	Uqsy8dvexU0T25T++cdMT2ioEXRZ/JBAPovPMMWGjpJ1NVoR0Zp7JMAZ5RnXCheOPTys+bNXYE7
	5T/oIP4RDqJMbvGqzIKZRdH2coZQilISZekvrRuY6GSbftAGvH6dR8g2w2zAbf2v7ztiGTCRjIO
	T8/KzWNdz6hKfogqhxv7I9O/7H1Pt1CGTyThYKx318BTFR7/CrZyBrHlwzp4fE1uieXNTXHqogq
	t55xtVNs2LDJQfZsT0C4W98D/6
X-Google-Smtp-Source: AGHT+IEB2oBIa5nzIY4RXeZf3q6fmMvbRvpS0LMepjfTmdjnn56m//cKySPgfNyCyPbgC3K4kj+Fxw==
X-Received: by 2002:a17:90b:3b84:b0:343:66e2:5fa8 with SMTP id 98e67ed59e1d1-3436cbf608emr10357651a91.21.1762794971385;
        Mon, 10 Nov 2025 09:16:11 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bb0b958af47sm7011717a12.22.2025.11.10.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:16:10 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: roderick.colenbrander@sony.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: playstation: Fix memory leak in dualshock4_get_calibration_data()
Date: Mon, 10 Nov 2025 22:45:50 +0530
Message-ID: <20251110171552.95466-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for buf is not freed in the error paths when
ps_get_report() fails. Free buf before jumping to transfer_failed label

Fixes: 947992c7fa9e ("HID: playstation: DS4: Fix calibration workaround for clone devices")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Found using static analysis.

 drivers/hid/hid-playstation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 63f6eb9030d1..128aa6abd10b 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1942,6 +1942,7 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 					 "Failed to retrieve DualShock4 calibration info: %d\n",
 					 ret);
 				ret = -EILSEQ;
+				kfree(buf);
 				goto transfer_failed;
 			} else {
 				break;
@@ -1959,6 +1960,7 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
 
 		if (ret) {
 			hid_warn(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
+			kfree(buf);
 			goto transfer_failed;
 		}
 	}
-- 
2.43.0


