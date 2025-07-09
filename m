Return-Path: <linux-kernel+bounces-723925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B0FAFEC79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366C3640DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65B298996;
	Wed,  9 Jul 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="edPuFj6j"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017C228C86
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072458; cv=none; b=UbYPMUPcQKphhVzPEMAImzJFlCjzGUzgbLTtdIoy1Mx2Wg5p0g14qTTOw8OM4e4Q47De1koYuJydYADtI1YEOpSA2JcpTfnsHQv3jIQBOB0oNTxbjQNtDzLU+T+uI9cVVUspMmktvLQFbFYo6d2Wp7yf7mQLkKxk7MGsMcJpfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072458; c=relaxed/simple;
	bh=q33ce8+frqKgGaRpVRO1z08J/7tP+j9aTiTDexbSRLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGZp1FELOtEgf30Uudz6zU9i2//Yx7wlKFs5wLyb6QVlVJiJJMNvsGi7HA5GrgtZtW54KhgWwGCT3A6YMG3qwDy7jeTAf37nHvCHABjhfUQJ8t7QwzQTuu/I8RlJyvsRGm3cOJoJzp4o94Pi88aBLZOk6yFS+wzEn82YxRz19rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=edPuFj6j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso22445f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752072456; x=1752677256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NtH0feHwwUczaaFj41kCVHxJaG2GKZc+XLPiyiigkw=;
        b=edPuFj6jJg/2IGwu8uMXKqZtKJbnOxl+5C7jzkYK8z8FN/NboDPBDjDf+7OiR2qEZF
         O37UcZesOkkJpKoZy+6+Ipan7jYIFmMMAae5HUoMtbZbZIw5aNSY0u+7mCDxY0gFjNM7
         5zHcbcZqr+J4yX+GGZFVA9hc0UIj6dCDAc3xN7G9sWvwyySv6hspk614jisM9ceh1cGL
         ThiKc3OiT4wcF2dLDj6JMDvlQKs12/NRRPO5On2U4IvA9wvhvhRyKT+NQJUe6B/svSp0
         1GgtJwT3feFH4MoJAfDoxi2Ed/7H20WeSAjHEBqUC5jI8aoTW2l59JwaxwR/Er2neUiE
         oLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072456; x=1752677256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NtH0feHwwUczaaFj41kCVHxJaG2GKZc+XLPiyiigkw=;
        b=UI91PYXtMBK5hxbpWsVutFvDQsKdd7SrSbUPoa8Me5fvfMIunaOjuHruKG0+Va0avk
         VbhDNmr+uwRZ5CtuzKXW6stiVBbLAX7nerBq0s73Nwvk00VHfeEWZIXdnnWFnLAiezZn
         ZQIImi8VEYadH/9VhJCs2kFYwH0iqlYV9NNaQw5Cy9sNhkkVU+AGBbY0BpwhthXhd+7r
         b7XAe9EjJsgb/ByrwQv+job22hABkUmDobSdx6zPKaX03XRIzKKlzs6Wo+Ck+AX2+sS+
         qt66yQRvXtsgw3Mp0/ICmyQlW67W1FPcOpGvN9looXZfg49g5xf0biteUI433xT0Dyy/
         DE3w==
X-Forwarded-Encrypted: i=1; AJvYcCUqKLGUBIosM3NWT1/AAEsaGe+R/w+sznsnNkrEDsQ47BuAz5zOqtX4T2NmMAaYzXLZWg1zI0yzwKbP4fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXah3pB5IYGHAoPFmbYK+EEPTdMrWaYsnVECyuGDRVMfc4AC0
	iNYHLQvhe6m0xj0WIbHjKXenDqjVnHZeh0cKERSWrSltM6enXOcjg52UtQO485hFXXskhoQcrxx
	QUaVcbYA=
X-Gm-Gg: ASbGnct41FY62f0KfzutXNSpc659FYjhITY+T3XomEo7C0dSAChDalzhmJ3m6y68bZP
	rSil/K1kX65A4uIr87b5mkcl+wfB6BMQAzAaRikDvGt5MsEGgMyOcLtlQwUkrJmGvnSYvA3/XS4
	nV2fOUlbMPu2lbP9DLRKBH/8WpKBLcYzM8y1+yxRL2ZC9Aybb7y7HW7enY9F0e3K+9dCu/d1oBI
	0DeAvq1C14SkoHOrVbRpQZBJKLrSbxcInzJ85lrZoshkyXyq33rHZyeVwSgEFpydDJKArH1SPKZ
	2bI3wzVBLRXFcjayMmtSFt8QGcKgu+zbXADx6iI/Io1qMZFvxdbtdo4Otj9FQcs=
X-Google-Smtp-Source: AGHT+IEUE8tMaPDZZaKY17LAPbD4MKLwoSLGBEVWhrKQhzPLWiq+YuKvyeMKc71elZ017y0Pb2Lzbg==
X-Received: by 2002:a05:6000:705:b0:3b3:9c75:a4fb with SMTP id ffacd0b85a97d-3b5e4522093mr2562948f8f.33.1752072455658;
        Wed, 09 Jul 2025 07:47:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c90esm16243899f8f.91.2025.07.09.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:47:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
Date: Wed,  9 Jul 2025 16:47:28 +0200
Message-ID: <20250709144728.43313-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
can get notified about proposed changes to it. Add a sub-entry that adds
the mailing list to the list of addresses returned by get_maintainer.pl.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- add remaining QCA files (Dmitry)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efba8922744a3..d018923ddd3eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20464,6 +20464,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
+QUALCOMM BLUETOOTH DRIVER
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/bluetooth/btqca.[ch]
+F:	drivers/bluetooth/btqcomsmd.c
+F:	drivers/bluetooth/hci_qca.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
-- 
2.48.1


