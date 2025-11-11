Return-Path: <linux-kernel+bounces-894813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC3C4C255
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50DFB4F0C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E034402B;
	Tue, 11 Nov 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTJttBhV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0929DB6A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846848; cv=none; b=D2zZG/cFIr1F9IMI0p1PVRKDnpG7unEGK7Py3nFdJFC336PuJvhxqoP26Dij217klW2Ol+rn8kdrg7prDZ36xBv4hTM4cYEIK/LIkY+0hmEjwLxBtgfFDCVRsBxMrGkxb+rti5DhwVZ8KYHj3QYGPhFmg706B+4KofMX4dD5mks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846848; c=relaxed/simple;
	bh=XtgfiS73Oq56/NIEh5jlvNGkjGIQVY+8R4LCTYlLcfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXX0hQLgrz+KkgIJQBgz14n/OmSiNjt9spqdbU8DZHzq3pNFTCRQ1gfLlexu5QyBLXePkuZQYumYvEi9frfROpqnkscF5uHUiXe1abV+vhNm45hqF8wC/AegJ6XHDUGqXsb66K210269G8lLTOAPpYKYRTdIo5iKZTqEi1zZKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTJttBhV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so5771187a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762846845; x=1763451645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QFcLuCsO6k9uV5YbLmGsjcsxbuMsiAYEOoeaHjkZMM=;
        b=MTJttBhVBnpmdFWEdw1vx0EkSr3t0Kp2dTjtqmY6NHkw/Q8/bZD1ZmsSkS4pRHNRW9
         TC+efTQgLvFYb+LdouZ7Xlo8Jmm6cAo8WgQjHib8XkV4ZruEp9I413tLwQnnYOacqgty
         3FYK7lu9F6iVEzg1+MS2JQVmE8WVo5BWzGaA3ixlGRN0dPjPt+hJ7vzy8cLsRCw4/y43
         IEL6NdWht+WL6BAChjEHhPK/GhDMfnrmJYuC1oPI344jEz6cTVwoJcOnN01gPs6G5S86
         aB5VcQcFWwdzzgqEHuX4QMGAwixxM3RWs0qO/2Z6+sZR477RLOo9VKjGJXY3gErip1oP
         nMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846845; x=1763451645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0QFcLuCsO6k9uV5YbLmGsjcsxbuMsiAYEOoeaHjkZMM=;
        b=M/TnxQDv/lmgi7TSPnbrdCqzXyEcevIng1l97DhVihGCfpW5I3Uu6IjC/7wr/TLdT+
         JQuLYi9j9HcM6ZTZoQQpP2wLjIcl2grF919HLAKT5jjawTHpm02TxZ23357OYxMeGxta
         iFl8MoogTkssHN34u60L/AOdSsmi6gcx4BywwR/21YLn6NMNa/jpK+YlfnVP2hv0DKCI
         p1np9vP0LODspZyqdur1MQgpvK/kCuBMr6flGb0en8rGPZzk2FdFKXtUF/u8WruYP1tP
         cpoEJKUsCtK+Borkq1CXeGxiGxt7flUjgQkArlxZYc7cMT3He81NRNzqF1rUEtEjZ2f+
         xlcg==
X-Forwarded-Encrypted: i=1; AJvYcCXPw/yv37Zzocl+DgN48cfP1lErAGozaHnrH8E3vIy+jwExR5voJSlysCJQsguuchx1X2akuhTTvYjmVtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkOJFGjslFl0pABbLiY6btf6sR5M+9Y0yjWKc/APJds5xxq3pC
	3ww/ld8OHdTv0HWFI7p8Acs+1eIEKiYOOsSF1wJTVf4KXOxjAT6Z74An
X-Gm-Gg: ASbGnctGZbFuDRPSGJSpAwIlKnyslaUm41sNZ8QyuyAKQWbM8xJqb8jlQ8TQB+SvOw2
	kjHn1epLrf1wgkEz5pyfbsccu4vPZGdRxIA1w5WAdNYtkjpv6e7txQLuezMcsxNl3H+3K2mN8GE
	NtiAXx2hm3XnZwhQlvEc0eV70oQGF/AXQOU1yt+bcY2TRuX7X6V5QlBHTWtf9xoAKtjcM7COl/6
	M6jSYETh5XBYihBhWdgT6qJSaoOx3puaVvzzbZyI6CBiq6RPEeIH7kH1tLhUmxO56DsBDHcaztK
	UgSNguRCXeh4U1rNWDiwoFMcPdn7SxdxZOTUHSBH2RV6JLeYXSgfdwffBD06auOzjRoiKh+RFVj
	Q1Qu+cIlHjAJRilwGDbbqGHqnJWGQ7x7TZoi7rHF4fkOoRPub1hgwKoVQZzKSMnYzP7XCzNBnMS
	pzGiH03iBxSK0cR+yq5w7nLYEFO0QtXw==
X-Google-Smtp-Source: AGHT+IFsG230m+akXtjCSydiKag2W5CWTYX2lJUYU0U9SSVOTcS0xW8oMrbPNnDVR5zbMl8JRfzg+Q==
X-Received: by 2002:a05:6402:27cf:b0:641:27d8:ec72 with SMTP id 4fb4d7f45d1cf-6415e102ee9mr8558099a12.4.1762846844642;
        Mon, 10 Nov 2025 23:40:44 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm13060667a12.2.2025.11.10.23.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:40:44 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 11 Nov 2025 08:40:10 +0100
Subject: [PATCH 1/2] soc: qcom: mdt_loader: merge __qcom_mdt_load() and
 qcom_mdt_load_no_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-mdt-loader-cleanup-v1-1-71afee094dce@gmail.com>
References: <20251111-mdt-loader-cleanup-v1-0-71afee094dce@gmail.com>
In-Reply-To: <20251111-mdt-loader-cleanup-v1-0-71afee094dce@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The qcom_mdt_load_no_init() function is just a simple wrapper around
of __qcom_mdt_load(). Since commit 0daf35da397b ("soc: qcom: mdt_loader:
Remove pas id parameter") both functions are using the same type of
parameters and providing the same functionality.

Keeping two functions for the same purpose is superfluous, so rename
the __qcom_mdt_load() function to qcom_mdt_load_no_init() and remove
the wrapper.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/soc/qcom/mdt_loader.c | 46 ++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index a5c80d4fcc36630359963141cb44dbf1695090d4..a68a22d174200f5f3bfced6678e5bffa0016ca14 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -332,10 +332,22 @@ static bool qcom_mdt_bins_are_split(const struct firmware *fw)
 	return false;
 }
 
-static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
-			   const char *fw_name, void *mem_region,
-			   phys_addr_t mem_phys, size_t mem_size,
-			   phys_addr_t *reloc_base)
+/**
+ * qcom_mdt_load_no_init() - load the firmware which header is loaded as fw
+ * @dev:	device handle to associate resources with
+ * @fw:		firmware object for the mdt file
+ * @fw_name:	name of the firmware, for construction of segment file names
+ * @mem_region:	allocated memory region to load firmware into
+ * @mem_phys:	physical address of allocated memory region
+ * @mem_size:	size of the allocated memory region
+ * @reloc_base:	adjusted physical address after relocation
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
+			  const char *fw_name, void *mem_region,
+			  phys_addr_t mem_phys, size_t mem_size,
+			  phys_addr_t *reloc_base)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
@@ -435,6 +447,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
 
 /**
  * qcom_mdt_load() - load the firmware which header is loaded as fw
@@ -460,31 +473,10 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (ret)
 		return ret;
 
-	return __qcom_mdt_load(dev, fw, firmware, mem_region, mem_phys,
-			       mem_size, reloc_base);
+	return qcom_mdt_load_no_init(dev, fw, firmware, mem_region, mem_phys,
+				     mem_size, reloc_base);
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load);
 
-/**
- * qcom_mdt_load_no_init() - load the firmware which header is loaded as fw
- * @dev:	device handle to associate resources with
- * @fw:		firmware object for the mdt file
- * @firmware:	name of the firmware, for construction of segment file names
- * @mem_region:	allocated memory region to load firmware into
- * @mem_phys:	physical address of allocated memory region
- * @mem_size:	size of the allocated memory region
- * @reloc_base:	adjusted physical address after relocation
- *
- * Returns 0 on success, negative errno otherwise.
- */
-int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
-			  const char *firmware, void *mem_region, phys_addr_t mem_phys,
-			  size_t mem_size, phys_addr_t *reloc_base)
-{
-	return __qcom_mdt_load(dev, fw, firmware, mem_region, mem_phys,
-			       mem_size, reloc_base);
-}
-EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
-
 MODULE_DESCRIPTION("Firmware parser for Qualcomm MDT format");
 MODULE_LICENSE("GPL v2");

-- 
2.51.1


