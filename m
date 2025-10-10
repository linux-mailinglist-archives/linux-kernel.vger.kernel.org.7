Return-Path: <linux-kernel+bounces-848054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA9BCC5C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347304FB2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD5826A0DB;
	Fri, 10 Oct 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hwj+0uhn"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79028258CFA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088778; cv=none; b=C4vauC0UEKoeJHXQf+kk4HlO6r/p0x5zUp6OInBHR/0N3JY9vlIVn8a/zlEUNlSPz0MA/mjO15zeX+Kt2GhaxS16rERJFwKait8LdNKsrY0G++xoy+AHW7dK+6bR4WeULKhuoey2HlWgIuWNUU1H1OF63wyQXNsWPEYMp+MRLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088778; c=relaxed/simple;
	bh=6mprBf9rHm8t7EC0WKhRFNgUz+XHrcRxygL5v/apfQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GZOM/m59Bp0qdcFByP/RfH8YVspD2e4mwdc6xH4Bo6zNYArOuOA1UzYuMymB2RFyyFzmfCGmoSQUFiDrcKwQMSqqo8vp5qD7nh+KGGGjSNdelGGEaHki/j8Bou7pbzVUoHCFdDN/67VTJGc1bJskWvBSi4ALh8lty+4404LjhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hwj+0uhn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so1788263b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760088776; x=1760693576; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhN24A5UCW1ooWw6ilGbTrMsyp8dpaTZlf+HDDnFDSk=;
        b=hwj+0uhnqFZen5RcA6FAvmGrtlpUZN53g3sD6rDpLuEt79/zQvLqZF8dscFxzSx42H
         Iq/IJ/wr6YuhlAXUAIE2ozl1a2ycoULBpGbxMnOmAJnw0Ye1cTiqq9Q2SgkTMkBCUf7x
         0Da7XhiTe8SrP8+4v0lNfei3wN8lolP+t5/13YuVsJGMw4B9K/OQPKElnKjB8zdgpzsU
         aoBYRyfGFXt4j7cQnMVphINOtEZtkfIjbb5KY8AqYoPdNRRnlyD1h8ldeVzvWNiHpRrA
         lBDQfRGQuCQEPBUvxGtiEdLPSTMbTRbyryZ7C+GY81PfF/GBsgOv8HxhapcF7nrDrhRP
         H9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088776; x=1760693576;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhN24A5UCW1ooWw6ilGbTrMsyp8dpaTZlf+HDDnFDSk=;
        b=VqK3tW2bCTigBbAgAdZ6HkAhhSTv+zAu5kwzj7HW1YDNBJORvboGyY2TYJE8GXlj2J
         VGCgrpy6kVNiC6yTVKPu+ChYVyrLRocqP2ghEVn03VQJCmO2HpCb3VbSXL/lQ6cohjK1
         F11Cu456azJ4xg0X7usA1r7X2J9gOg46+iYaBhTq6aKpUsoWrCfy5CwsgKl6L3xcIUic
         fw0ypYQ4n5i01y1KYnDaFRgMUA9fXzta1u5RA1hAUYPB1+DfqExhSKxnM1aGzv0DoZg5
         mFyGll/Qa5juLWOvkVbbYAkLdSGHydJ9/CecuygfGAyE/Oz2qRfy0MUtqvHYqA6VyTaS
         CRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVFu2Fe9ci77dfV0iaNCCpEduot3ZsAbtDbBuutS5Q9TL1LZN+7dpjqZtGz2jsQ+Nj3X9vyJ5K4DG6f+AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDO+34fwGapSknIzHaM032+sSmLDYdDaCxHinGmtT+5ndI99Cx
	NCGphXiSbpIMjoJIhJ5lppUGOXcAEAZYmvFhw5/FHAwzx8PCUB77IovxACC0Q4DZH3c=
X-Gm-Gg: ASbGncsEyKXYM9k5FZtZ2EVIkY1oLYfTutx3sdg0u+EZuJ/Aix8QwNsgxY3sEoFi8sg
	0yZWvybx/hUDk3Ni99QH29eImWaqf9I64amIubxquwd7mySmdiXUUzPkKIP8nIx1nLgoUxulit1
	wUVcIuME6IfKgznvZaH/FS/L2O4j62RG0XUQrwXlIHHM/S91v0gQxJUJqzz8rDn4mhs4a04KwDM
	fALLDb8/b9nNi3V0fGqo71Nkp+SUnjp4AM5D3rkzeEkjR0eNRZzZL+e5kegxd5AJwfTbrt9qAsQ
	aYmE5+ofQHSpGHAoqT6KutcM+G94EATajM0FMfk810NLxBV8+Z21NequyNbVOlZzlyQzYC0X2vb
	aCle6HV2TCpZ8Dej+IpBqDLo1UAZLb5hGR6oGCpePQ6yFL2QQI+5iAI1S5kKZgrv8iIv+7bAPne
	lXGqx7GjnwqtJIZ3yB54XuIufJSFlC
X-Google-Smtp-Source: AGHT+IGToyfnFp6Nx9gf8NmRJnd4O/Y3pam9cbiDX+UZWPa17SsaNbTO7MXGaHWms2MZ1He/ASjT8A==
X-Received: by 2002:a05:6a20:3d8c:b0:2b4:41d9:b068 with SMTP id adf61e73a8af0-32da8462f7emr12905134637.37.1760088775650;
        Fri, 10 Oct 2025 02:32:55 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2d51sm2308775b3a.65.2025.10.10.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:32:55 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com
Cc: guojinhui.liam@bytedance.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: Print the error code when PCI sysfs or procfs creation fails
Date: Fri, 10 Oct 2025 17:30:23 +0800
Message-Id: <20251010093023.2569-3-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
References: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

pci_bus_add_device() ignores the return values of
pci_create_sysfs_dev_files() and pci_proc_attach_device(), so any
sysfs/procfs creation errors are silently lost. To make PCI
bring-up failures easier to diagnose, log the errno returned by
pci_create_sysfs_dev_files() and pci_proc_attach_device() in
pci_bus_add_device().

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..395a1c7bb4c7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -344,6 +344,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
 	struct platform_device *pdev;
+	int ret;
 
 	/*
 	 * Can not put in pci_device_add yet because resources
@@ -353,8 +354,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_fixup_device(pci_fixup_final, dev);
 	if (pci_is_bridge(dev))
 		of_pci_make_dev_node(dev);
-	pci_create_sysfs_dev_files(dev);
-	pci_proc_attach_device(dev);
+	ret = pci_create_sysfs_dev_files(dev);
+	if (ret)
+		pci_err(dev, "created sysfs files error %d\n", ret);
+	ret = pci_proc_attach_device(dev);
+	if (ret)
+		pci_err(dev, "created procfs files error %d\n", ret);
 	pci_bridge_d3_update(dev);
 
 	/*
-- 
2.20.1


