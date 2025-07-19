Return-Path: <linux-kernel+bounces-737597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838FB0AE2E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80130584BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265981E7660;
	Sat, 19 Jul 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1tKOJmQ"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3429D05
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752906822; cv=none; b=niHR30m/CCVWHZk38D242Z3/eC2h5CsQ2mphYtpTX4XCGeThMda5VoELW1nlv9uJmTKZAE/YV5O1sTUiFUIj2XjKLPYGBnduxXXMogaMB+Ex/IQh1iKVM8n9U2jh0yAHxhDpltDmj/E9pA5+rKCymGBKf5WN6B0YO3yQeq6AZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752906822; c=relaxed/simple;
	bh=OAtt2g27/BkKyyqZ3w3XNQhcB6vgiV1M52ZNoCVxf8s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eJzhvoJnJq2j2pip4DxU6dkgyUJ5hjmq8EroCfTfDlmBBorl15PvEWFU6LVZuTpW7DCrgi+Um6VnqzJ5C7d8yhqC0x1gt9GLrAPiF0bwxZXeYOhc5EWMFOic16fiqNlGqU5YAjV3bQs7UKUM4/raRkzsyPue6SSv4ioJZrcsTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1tKOJmQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so20039561cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752906820; x=1753511620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXaJ24zAIJTmkWcz3v1aCR8t8NRrBr0nO+ngi72VLwM=;
        b=T1tKOJmQnwbtoRhHAvej0GYSAssNmP/e6ASZT/p6dFVPWnHNKy28hHTXLL0GptdkTL
         QdFBlvUHoXOPnKFAm5ORtbpsZZDPR5KmzAGZEK0gYDWmqJDU3/823S0NKRPU5Ve4MCX8
         +uCP4O2gJLSbXMv4PQAQOnWVRhjv+pAnIaCJeIDI2NdwpLE/9R1LFDRq8aAzhTn2m7CC
         RJU9Hbp/Oo4BQMz1NwIG2WLsvk01+G7xDqOkCTh1uzEIhZQ28QUF0AqGH3Edzy1DGbfX
         ELhLkpFmTON7AqfjbVksH3agK0k1Job6UJVvsTkZFhmFupgTK3rBtSw0dSRU3K94vY10
         S3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752906820; x=1753511620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXaJ24zAIJTmkWcz3v1aCR8t8NRrBr0nO+ngi72VLwM=;
        b=QNSzhbCxW5lZ00Rw62RT8lUYGBeaUNP6cSppVLqitY9dpV2GPcfOrgWIqdI8P/0ezG
         lC8DYNB2xrv9hbYo9KcxiZRvkbBIvp6a9400cw2QARHaz6Qmzs+vrbUz4hz+ruv2Sqs+
         Yz4kgbvs+CZeG51kkHu+USdLK6Ee+OtNXG3hQwrrGZNFsjOQ6SpxDNgxRWwT7XNUFdwP
         FJlOKKC2Wzp6JeoqSzCVdwIn4nxHuIM7oNhZicf+00rm1gKZZyamlHZ/AV14okOOBer/
         AeAqjJiHUlUPi3FWjAS8oPw3+OfBjajdDI6UDYvl7fkhHqL0jUXVz2EUBGajexV2d09P
         D2ow==
X-Forwarded-Encrypted: i=1; AJvYcCXPwUczLT3FdYeoFwYqB544yLE6V2gCTmqveuiIvHoJLC+7rn+jDNSpIFrO72gUiCtgX0uPDDWLA754CL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2WiNmP6Jg4Ymox3qIv2df6YMlP/6LQZBnt1Fj5G2SdctVWFp
	qia2uAWo4XJ8d6crX7dbbDbgwwJL8DPYLvwJZCBZZkBmfgPSuYtS945g
X-Gm-Gg: ASbGncvVasqhNIla/EXzgmkjRs5Lxi9rRk2UuEshUQ2xCYWT0o5cB1hoiIVoYe3VfDT
	YaWJtRpbtTD32MkNreI0wtfUukuJ276ggCOglr3QCqQwS57u5zrX3Zt8SV8rSVQP/y/MoOIAwO1
	UnBSC/QS4erbUI89xoTA+GJeayRzUlE+xZ33FHYwoXSRHuu8hRYgLxaHcsQfXmgVs0YKtOXflBV
	tIU6QqRJY/Pl6dY7LS1+RNjqiZv1Vv/w3r7LLCeqN93jIFpnWcXO8nPW28sd4x+WBWtpxKjZNuO
	VM/r+Fh2MT1NyCQ93WM1x0XHPkg0D+zJnueu85wcjmJaUNpLU0i+Cjd3iD8qOPPctyAxRzcOB7J
	Oz24oIE6WMK/fUQ==
X-Google-Smtp-Source: AGHT+IGHoRLM3yEIflabiLxKe+ERpQynr0njQZYhILbGU4PETBCHd82wLaFifZLAnKxnQcMa1CzZjQ==
X-Received: by 2002:ac8:5753:0:b0:4a7:7b5c:90a5 with SMTP id d75a77b69052e-4ab93c50799mr232155751cf.7.1752906819928;
        Fri, 18 Jul 2025 23:33:39 -0700 (PDT)
Received: from pc ([196.235.158.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb499fea2sm16217111cf.22.2025.07.18.23.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 23:33:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 07:33:36 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Min Ma <min.ma@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] accel/amdxdna: Delete pci_free_irq_vectors()
Message-ID: <aHs8QAfUlFeNp7qL@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The device is managed so pci_free_irq_vectors() is called automatically
no need to do it manually.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index c6cf7068d23c..3474a8d4e560 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -520,14 +520,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	if (!ndev->psp_hdl) {
 		XDNA_ERR(xdna, "failed to create psp");
 		ret = -ENOMEM;
-		goto free_irq;
+		goto release_fw;
 	}
 	xdna->dev_handle = ndev;
 
 	ret = aie2_hw_start(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "start npu failed, ret %d", ret);
-		goto free_irq;
+		goto release_fw;
 	}
 
 	ret = aie2_mgmt_fw_query(ndev);
@@ -578,8 +578,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	aie2_error_async_events_free(ndev);
 stop_hw:
 	aie2_hw_stop(xdna);
-free_irq:
-	pci_free_irq_vectors(pdev);
 release_fw:
 	release_firmware(fw);
 
@@ -588,12 +586,10 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 static void aie2_fini(struct amdxdna_dev *xdna)
 {
-	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 
 	aie2_hw_stop(xdna);
 	aie2_error_async_events_free(ndev);
-	pci_free_irq_vectors(pdev);
 }
 
 static int aie2_get_aie_status(struct amdxdna_client *client,
-- 
2.43.0


