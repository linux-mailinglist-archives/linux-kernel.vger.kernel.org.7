Return-Path: <linux-kernel+bounces-814354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E09CB552CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE53C1D621E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75B320A13;
	Fri, 12 Sep 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6l0e4hO"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AA32038E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689830; cv=none; b=kC6yzxVnTXCaBs3gi1Htb4lTaEB8QfzcgI2OFHFZYA6f/0e0z6+li8WkMtd1T2UVyqSsniML1HadJnyImcrvYZyOuJkDZD+gBkL8GwSyAfAOUL9jRuQGKkxQ+OKI6bJ3XrvxXbn8O9U6dScu2V/js08HMkj62XJCWIEUfG/P8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689830; c=relaxed/simple;
	bh=UKnrnaITdDqPZ68aThZkj5EHl6fWFAOsgR33B94Eji4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwLs89RNBq/PqWGwfi2wfH23Mf0V8GZkB1pLJR4lEPWZODvGuA21ArrxgchOIV8d7kV9AbaEO6mpyDTpoLv93ouLW1dSCq8/in8etjLWbvdN+fqRCDECU69Jd29x7tCUS7glBnKL65JGJzUdrLovauHhZNq+HLw4kTZxnnPkgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6l0e4hO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72267c05111so15218027b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689827; x=1758294627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4llYgtc09L9A5EYyW7VZ9K8LmFJt/10Sl5wTfADcVo=;
        b=p6l0e4hOTJp1G8KL22RFNd3021RY+ntedu0Lzqm9lcXYV8vd/Rq9UchDOZNDdUtqWs
         /vZHnWD0519FCS5psjAV9EUBs6a2Zf8/20nZ7lOMj99SY+Hak+yZ5A6d64MHXcrx3UMI
         Sz4J0ddstSHH7cJNbtWh7mdbAF+9Il4tvtnN/PgmQBp6iSyxb350GVPeifG3v4Mh8R3/
         dZJxvOz+fboFSQt6+cDTTyMym7CYVjItnXAhl9JAJY/yggXqvbU5yyemW6KwTO1PE9jM
         SkNd4AgCifUcd4tiair+kbtxku52cT1X7GYGj+txrDWb056Vd+eGxWEGsnXjBJ1qa7/X
         s/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689827; x=1758294627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4llYgtc09L9A5EYyW7VZ9K8LmFJt/10Sl5wTfADcVo=;
        b=g33bb4xZiVCKWDATpIEeGK2uXEMnxrqP7sRa/4yyscC+2eAS/QS2h81chV+8JWipFq
         Oim3gc/+NDBl8H9PetFeDr4O8vCBvFPTUcXqZPGV/7KZbo/9EI35KPzBSpyAc6wzkK/I
         uzDAn+1KeOLoDRKDRuTKIhydCSfYnyxBDxzMuMYAK3w6fPh2HaRmCtmB0oskO2Wq1YJM
         LPE9ah+WUnMSz+sytM2sUREGhY2y7eSf34SP3b5L2gvpF1OE+olggBlhvcOa6vgFx9Dr
         mqlUcuuflS+OFLHy8jdMqKMujYOz3LPWIrTs0xIPNbtVTPHZ7vv8aTGDc66ymNYkx9Hm
         Q6FA==
X-Forwarded-Encrypted: i=1; AJvYcCVOcBh5gC10BHuT1l/uQZmCTaKdX9SHTMZViZG/yNPVzmeIypncehpwS19E8/xJs3t1TBA3SqGvKl7HArA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6v8jsPEvc11UIYXGOTvU1W0axK1m07EGb5YTUfr6cEcYXv9Mu
	prC+JFNoxQcNGWoAWEPbwAuIgUxFay91DVUpNe82H7GIXN7aJeE28arufT8NYRJYeXA=
X-Gm-Gg: ASbGncsreWJ0cMpJGwNJd+IO1sJhjO2+uUp8bD621mfvD91fKr8FTTAlYvDF5UwgkUx
	8gNNui//rA7+39umaneot/oPukz5Zrs5UKVKIO0WhR26LjDIcEGSpnVddY+INg598ss+YO/4/q6
	l4uzvd6LfzuAESQ8/rpkpTikxyXH9dl2EL3Pf92V327cBNrL/dhncN58A0E5WNX/uWuqr+dTE/H
	kxKSTsuf+lpvoggNRqkCx2Z6BDiH0YaNuVpkV7RYxV5pK2dviim3WAj85Nv6X3LdT6G+EJ8RRBE
	l3MJ2dajTS0r3u0WNYSd7WSzX6gLouq0CW4m+5pT9xDGXx0o9it0wSXMrt4XxK6hB5Juzg9l54n
	T5j2qWZBj73KQ2WtR+qEagg77QeCXuI5s8g==
X-Google-Smtp-Source: AGHT+IELEo3IIrw2/QnWmoSL7oBay1esdy/6RcSnsiIQj9jdk3byMst9Z0k97wU9qaWUWBvFOqWfkQ==
X-Received: by 2002:a05:690c:6406:b0:727:c325:c5dc with SMTP id 00721157ae682-73064a12b20mr30549157b3.29.1757689826814;
        Fri, 12 Sep 2025 08:10:26 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:26 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 07/16] soc: qcom: smem: Add minidump device
Date: Fri, 12 Sep 2025 18:08:46 +0300
Message-ID: <20250912150855.2901211-8-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a minidump platform device.
Minidump can collect various memory snippets using dedicated firmware.
To know which snippets to collect, each snippet must be registered
by the kernel into a specific shared memory table which is controlled
by the qcom smem driver.
To instantiate the minidump platform driver, register its data using
platform_device_register_data.
Later on, the minidump driver will probe and register itself into
kmemdump as a backend.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4..03315722d71a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -270,6 +270,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @mdinfo:	minidump device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -280,6 +281,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *mdinfo;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1236,12 +1238,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->mdinfo = platform_device_register_data(&pdev->dev, "qcom-minidump",
+						     PLATFORM_DEVID_AUTO, NULL,
+						     0);
+	if (IS_ERR(smem->mdinfo))
+		dev_err(&pdev->dev, "failed to register platform md device\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
+	if (!IS_ERR(__smem->mdinfo))
+		platform_device_unregister(__smem->mdinfo);
 
 	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
-- 
2.43.0


