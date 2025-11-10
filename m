Return-Path: <linux-kernel+bounces-893476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79962C47858
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4973B0F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33758266B67;
	Mon, 10 Nov 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRobEWLC"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299922FDEA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787872; cv=none; b=L1PQMjfWF6daRVndlhseClQMqK0wMfXX0Nf7+B8yeoORU1mg7UJEPxHLfTZfPEZgd2c68vD0orQgtHfk6y4/XEGbTLC3wEP8/bUaGBCTYOT3BlykcF/XBsY4YB8pyokrMSHyNEDhpEEhCrVaBq7rKb0La8P+wP8Tmnyx/7nWk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787872; c=relaxed/simple;
	bh=ngcsiD/ajXiiBpABsVazTz+tJLwYwSvVxHi2KUe+7xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UwKCuAyVd3U1NYOKiO40Vmj+YiEtdrbqX7M4XFTseNYJy6Kh8H8o5qOQBg3ot1lbM+k+DtmSHIqQs08ncsJ3GtPt+mPv6XOgWRphVtYcne13ynsEjoxom5enap6z6ZcigrCMPcg/Z4dBWBZSiWid7pmoxB3YOzBN79e6VvQvMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRobEWLC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98983bae8eso1645606a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762787870; x=1763392670; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=proAMupxnU1cqn8ppHXktvWmCFOk0d+KB4vZ0hwkHKs=;
        b=BRobEWLCJRfhuDOYGUKALEazHMIJFkWEYJgBqcXpsd8mrOgqkXeo+tbLEJlRaJgEbz
         jvdI+pMH7NvExqPrc+fFUIy+Y87ivqBViWbln7Brepiz6cebZAJERJk80PTxmxh7dIIK
         Nd99w4kKir9A+PkCsyJr4xZjM1kbkpj822j5EqOLrwi9QkaH9gsEFsA75RdRyyOPJly4
         foJbYam7tKkUdt7SbIJbonkrD2pZO6MY2wAmCiu89j9T65QA4SzxjXH7TNNdKBVYHjWz
         EVX0HmQrnRNQMxL+n49ow8wAbUOqcAQzK6GZ8d8BovUEmuJHYlQh5q3ro7/OC++5Yyt0
         POAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787870; x=1763392670;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=proAMupxnU1cqn8ppHXktvWmCFOk0d+KB4vZ0hwkHKs=;
        b=Wf4/ZmTt0XDsSQG4NarN/eK/mXU4E/B7BlmOBOun89NLKc7c0LEU7PRIWg8DQBf13F
         EHu2Uhk8GOX3jkZTonMq5DIjJJmBa8P9o7g++h565v+PX166YJVq5FngGlpEtsR3Ejpo
         c9Lsb8CHqaP77ahPGbhszHrY7UFJNzoYS4AKCWBMufFw9L5gDiKRIqvZQBwdV6zXry3j
         XzAzzrgEXhlMA9nvzumdCFGIW2+nU4sohaFnqFMosgqGR2F2G95Hu3MBxkEXlD5c+JRq
         Q+pZlwWDovWpk39AuDE5gfBQ3yhHvVjTXl/bWhJIKjWv+y80o6OrKCc/hby5pTwFJqk6
         ZaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlJAA4kTTxVABWrqtUQmaXAOT4wHplFpMlGLPry7UbadSBG2XJlNNJiBGO/4vB5/Nbh9xt8XeCSZ4t11Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8k6MlY7g96Fhit0iuLhi45Z8cMEe+9jLoS3pBSmBa84+SVcW
	HwzD7BhGLXsBmlW5hREBn0q1M7TtrMFtjQPpgvTuNnA4R7CSW8e0uc1Z
X-Gm-Gg: ASbGncsiYC5g35H5/nhIrvAjiOx4eUNKvv7y5McqQwt2CGz6TUQpqoVl7wiyL6wmWG7
	5G7x88qFkq3fVLxrXcLFAvMbvc7GtT6Qr3fUnZtAJaTtcTdLIBVmvEd3hg+9lsXEiYCbg4ei9If
	fsr9FyvIOu28vMDBuTH2iWiXUtW4RFdvoGNcLOuBJxpb6bHNxvgG9IajGAIkHLgqGRAHL2BbmGw
	ZHWJvA+2sLrmef7NLRLVrF0BvRpKpNGvOMu90YRwmD3XUuiEGJ8rYGOQbZ7sIsnQRY65WzBZ6J7
	qGANV6QDNScPHrDm2KIX7aMkRadRq966/RMN9yT9s2JsQUJkGpG36t3GhHwoirVRsyguau0HKNU
	z+ku4LQHZCe7Yc0azaGSUDE3Lnqf7OY+6sdKuYzso/69yOlIECxbBhKnUvSWv9nKoBTBpew27kD
	DLsqqJp9E8OQ==
X-Google-Smtp-Source: AGHT+IFColOTEFc+YKuJfWoz7iYZVyQkHiGnmwgGT/THEbSZlWqrZVd6iPqWGf0bCjSVP6LSnEfm3g==
X-Received: by 2002:a17:902:dace:b0:297:e59c:63cc with SMTP id d9443c01a7336-297e59c644dmr114215475ad.35.1762787870219;
        Mon, 10 Nov 2025 07:17:50 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm147976145ad.24.2025.11.10.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:17:49 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 10 Nov 2025 20:47:30 +0530
Subject: [PATCH v2] tee: fix uninitialized pointers with free attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAkCEmkC/5WNQQ6CMBBFr2Jm7RhaaUJceQ/DopYPTALFtLVRC
 Xe3cgN3//3FeytFBEGky2GlgCxRFl9AHw/kRusHsHSFSVfaKFUZtiOQ+enFSxI7yQcd9wFgm1L
 gVEaltUJt4IzVVDyPgF5ee+PWFh4lpiW892RWv/cfe1asWEMBTd2c785ch9nKdHLLTO22bV9A+
 ZMd0gAAAA==
X-Change-ID: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=ngcsiD/ajXiiBpABsVazTz+tJLwYwSvVxHi2KUe+7xI=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKFmMTyPKQjFeOe379RKLJCf2GU64vwyMLnUfwcPRkvp
 i2R17PrKGVhEONikBVTZGEUlfLT2yQ1Ie5w0jeYOaxMIEMYuDgFYCIqMxj+is02uvih40zJtqz9
 X4yntCVqKjb2i1pu0bqkrdmyy+OQKCPDgeg1WYmx74ScDp3h2WN48kMOh/jCRfwdxfJ/djJyp3/
 lAgA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

tee doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v2:
- initializing variables to NULL at the declaration
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com
---
 drivers/tee/qcomtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index ac134452cc9cfd384c28d41547545f2c5748d86c..65f9140d4e1f8909d072004fd24730543e320d74 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -645,7 +645,7 @@ static void qcomtee_get_version(struct tee_device *teedev,
 static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 					  u32 *version)
 {
-	struct qcomtee_object_invoke_ctx *oic __free(kfree);
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
 	int result;

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


