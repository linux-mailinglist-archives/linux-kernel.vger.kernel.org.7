Return-Path: <linux-kernel+bounces-878157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF884C1FE80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA944E9D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7A52EBBA1;
	Thu, 30 Oct 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A480YYkO"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845B288C24
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825651; cv=none; b=m6ZpqSyXljj8nTlxCkVR1/qwaVdS7259d5zJXSd/DZW20Zg6qXI+cgA6WaOBwV81h2OF8H7l3Nl766VNGPPxSj0ntLWdhrj/PklWfZjAF7UwLmoc/OjoxwB2Ms+hHlRxkTHcF6oXgiV7V50jo/+7jHD1tJyYt2nI2rixZUnM4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825651; c=relaxed/simple;
	bh=zpgUWHbcI6SKcOIwr4Gnz30m88XYXRu3QZxYPm5BmH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAJU24QO3DZouPqsNwm+lOdPW4uR51FrQpMmFT8as8HITjZN0BVRhBl4UrToTUUhb/cA0vButttqjHkhXZO/h6/4CdaVBfKRBn+AdNgboEFLJzQboJ8ieBr7gzzCCuEydaVDHC0L388iZuPjmwgw+NiZf/ay8Zak25Ql+kS7mJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A480YYkO; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ecf03363c9so6395091cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825649; x=1762430449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtWAAMAoXF3mVzTdX9b9UyiqMNyjWp+Z6GwyMgj9vzc=;
        b=A480YYkOD4y5hbbfGVMOHZIDYNIemjo5zySItYbhuL8LvHahzaXEs0Ecm+57Od14xK
         mi+Kd8JScRwGzf6E2cEaSUtgvq585v1pQSRGbRlrWTrb+24nhqIwD2fI6eIEolO3+RX3
         P4pKYzqJFQX7tK/1ZqTPhV48YMqx2iB2ezbeA752w/B+hch7ZHrV8NB7q3D+XhyvZBeK
         LIca6E4xwSklQlCLSYHk5xpfqgXIzc2rikzQpLFNvdYYBBNKt3OWE1T6+jwHWLGTcbTh
         Fx+XSEMvIk8vZJwV9nHssyVmmM7pbYbfPWwcC9kmP22dqwo/NKkHUxOT2eJebtK5bRKt
         mMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825649; x=1762430449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtWAAMAoXF3mVzTdX9b9UyiqMNyjWp+Z6GwyMgj9vzc=;
        b=MTqx7r6gww2Yygd3tnfPSPx4kPENJJcFpKFPzV9NtrbZJqo5okCLmpsm0am98fg50L
         hSQaSbM6lX6QyKU+KX0vg3GW3fwjgyASEKT4oYc7XDwyPpSlnctb/elZ/h5pNgnaVcbs
         FhsCSsYwkEf/JJ7d/1M99i0Jbr+M9azDtgVQVXV31rBI3benIITapFHbR3QyH2MlCjHO
         pqq7jsd2aGRVrD3s0BP3aEACdeRXQHmVo143gvkrZfs02+RBrbcR+Guf6fo2cejI4fj4
         BbTkTRrNsZviWRc5G+w26VQ5EY6sXE4Er07eWLWchazONCnUR4vAfW5CEbDygEqpcni1
         d2+w==
X-Forwarded-Encrypted: i=1; AJvYcCUohmz1zqQ29Au7FKXQavS/qeR9BVuy0HoqtH/oK9Ew1HKGxCZQ1Tc82P4P30AzmTyYayeWJ+3VYnq57FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfxfFEeIVoXKtqE/JYfTuvbTCTI+iXGS+C8KhQUxMQiJfwCIX
	7vIscU/7U6TrGObhts0+tmxbfeee9xiwdgQOv/nE9jM7++btJE0oKGLQ
X-Gm-Gg: ASbGncu+pqW9crfVpqbnm28Y8aVgC2+A7auLRN+4gxJuDahMzEUHn7SIUPQR0M5ZJqy
	TIfIKWDWGlVn0G016YQxm2Rlu477buGSxAmpMt72Ct1n/2nfTEkoNGA6VkeCHD8qnX75M5thwgA
	Oib17J9J46ySNuwuZhHIYp2+6ebNLL9yHOZo077URTqq/enY9AfsHs7h9IhaMEAf1WiLgnsFL0k
	74Zqe3qTEVPq5TatposA12PFGXpyvorp3JB9un56ZcymN3FWNNxlx2UVumpVFe5YN16ag9UjIAB
	N0ILqfJOHkLa5VXooiVBSaugq/HXR/eGlpRzkCB82Msn0h1ZrD9en7Q8jgW+YfD/BSVzQUzOS17
	jIlaFkI+sX1v74x67EXcTaOgglYMDRkZg8xYfxEIfqnJNemUoZwCw/1A752j6+AQCJ3OZrbAf57
	cCGatjpGSBB+WZt4nYwNLKt0vtjnmxyLu13pcwydQgDGI=
X-Google-Smtp-Source: AGHT+IFlbjLGh2yXtTJY++gi8eBgJttXASqGWclErvG3cd9ct9V9S4MLu0iQzxsRFSReCudGnfD1iQ==
X-Received: by 2002:ac8:7f10:0:b0:4eb:a3ba:591a with SMTP id d75a77b69052e-4ed223e0cdfmr38062331cf.83.1761825648524;
        Thu, 30 Oct 2025 05:00:48 -0700 (PDT)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3851aa6sm110370571cf.28.2025.10.30.05.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:00:48 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: vivek.balachandhar@gmail.com
Subject: [PATCH] misc: bh1770glc: use pm_runtime_resume_and_get() in power_state_store
Date: Thu, 30 Oct 2025 12:00:22 +0000
Message-Id: <20251030120022.239951-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() may increment the runtime PM usage count even if the
resume fails, which requires an explicit pm_runtime_put_noidle() to balance
it. This driver ignored the return value, risking a usage-count leak on
resume failure.

Replace it with pm_runtime_resume_and_get(), which returns 0 on success and
a negative errno on failure, and only increments the usage count on success.
This simplifies the error path and avoids possible leaks. Also check for
errors explicitly with `if (ret < 0)`.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/misc/bh1770glc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 0c052b05ab6a..45f8fc69a711 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -640,7 +640,9 @@ static ssize_t bh1770_power_state_store(struct device *dev,
 
 	mutex_lock(&chip->mutex);
 	if (value) {
-		pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			goto leave;
 
 		ret = bh1770_lux_rate(chip, chip->lux_rate_index);
 		if (ret < 0) {
-- 
2.34.1


