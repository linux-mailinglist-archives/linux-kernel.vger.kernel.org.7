Return-Path: <linux-kernel+bounces-799733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81AB42F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D79566F13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7722129B;
	Thu,  4 Sep 2025 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL3bxp2p"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C328226CF4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952122; cv=none; b=QrgMyB8zRylAo8Z+NYBYZoAGte/o5BRvv54R3OSlOz4qidsSCcgx/rTV+HWDwNah7GRsGwXTs1NHN3Kp+BadGSHtZfHkXngLFHzrsQV+pHl7VhdxQQk0zEZyuDbyBANnQiw1Zqtw06MD4kIMFe+/F67kPQZxmWH7DGQ+GvVn/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952122; c=relaxed/simple;
	bh=4O6K2p+TRWmMSjZhkegRQtZOjebtpRx1fOy4QMy15Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHPzg9xGcHqOyukw3q8qKoX4OY1WL5Wo7PMOCJ7n9hvqx0EmKCeGIImiiUl09jTog630kHDVvky2Ihd+8uLkA7maJNTxzo6lhj+psmGAgjNG9Nakm8Kd0fh4xWA7eiNLd+f2+vNUEZN5FsrYXwhRrfSXATnkrBHcDSEqylumk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL3bxp2p; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7211b09f639so5893146d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952119; x=1757556919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYRXyWLfRH1eL49TjUg//MlDi5BSYCOb1YaJi8/zpww=;
        b=fL3bxp2pHL/91AoKEKq5KyiC9Om3LXdz5+0Zf33jzf3V+Lc6W6qrr+c0Sjotnd4sGU
         vlNH9dJB1WIP2k75NYyKTqZxN2QlZ2m1+zK2dACnmVYtgeXD17k2HHQWOdjIFUsE1F3I
         wCQDmImF7R4DOekfPnMz56FMBqtNL05Uo3NWf3XqhWF3kjzUkzzFzx1grCVV8VeIKFaq
         nBsb1aCElDcNFuj+4wmlBJR+9BcBOP+j4VQ7e5h8eflTfBciS4jRbQrRL1ox7aU3vNZZ
         XbrkkWvR7Xj2HPpdNNwefJUUEolPYV4ebQoeBPvxVnNO+SwuobZGS3XIkoVv8yZ9SeGS
         xSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952119; x=1757556919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYRXyWLfRH1eL49TjUg//MlDi5BSYCOb1YaJi8/zpww=;
        b=WGU9CpeDQI/41jZVXcb3XccrTGdxc2fKj5srLHAWfCqoo9twfX0rqvB2i1x4nkcCiV
         kXutOUPFC0J4m+zgEd7wYSC4P0JPSzMFjbi4878U7fgJYTu8BU87DPoiayO7b+kk/vB2
         14ulemh5LXa+W+MIeZpA8erP33k3XEV5RKbigEXOKRL5TDZAM1oT6nCT/y/NqAcBvstj
         TWk9Yp2rk8iHKB2q3M9q3op2VkUZ5E1TbJZzZRYUPFDPMngVHtCmabiPb+Y+1Sxku+qJ
         sls5leM1vOTCc6ZqBTBScSZJpEM+9h7VULSE4c0Osqkvf9f6iJH9KW/uoGArwqqn6Pj8
         Cs/w==
X-Forwarded-Encrypted: i=1; AJvYcCWkXUi+peNy3lyQwf2Xln0v+s1UVAgs9E4/+3Z0x+ntKxfRRF6GE2MvT15cGTvss3ui9sUWNPvwZWz4xLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywmuqVSKKZkQfivz9KcRxAFrRewpu1SqvCIpa2vGytx5kX2oj5
	jZXF8I8NSHn2ksAgvmPus5yH5CLziv3815657g7PivuBsaLbeAdLuILM
X-Gm-Gg: ASbGncurgSxIWedZapudOPgvaB1wazcyi15OF7WYzV7vjYRArGDtBlrszMLm9m5306F
	QAAYwwtHovlCX3PaBBhbBaPvcKtl2RPjhR+b1bQKIYngGEXb3uUcC5bcUyyh3eFle1CGGFBVF2Y
	Mfwr5t3ijG8SoRqnnd1pzZW4Auq5X+8zxkS0k3s5FViUJ5i8N6R6q6m9F1c+oYnm0E5waN3Up71
	0GLi3DJPDlwxTExuolBPgkxuJ1DcddLOnxXU+mxA//qQjkALAg/ijLWs6vc3yHRW2G2W3mgv7q7
	YGwWT25wa1YVXHXkverg3F2sQ64ZAb0VDYEmfpE7GH/BX5nT45zaKPrxEDw1BnaC9/RwBniVG3T
	Fo5dIYIwlGjnMPx8uwMMGMmgZdJstII4VCocWRiPf1M4kNrzrjE7gppZaCWnQuNCtNtzNJDji
X-Google-Smtp-Source: AGHT+IFNUhoFvVgPo5tuhX1Rvc3EenlIpbeOVZGp3S+WhPDOXrsTsP9ogT1y019z5zNXkfFQfr+zuQ==
X-Received: by 2002:a05:6214:491:b0:70d:bcbe:4e87 with SMTP id 6a1803df08f44-70fac70188amr174020156d6.8.1756952119247;
        Wed, 03 Sep 2025 19:15:19 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:18 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 13/16] staging: rtl8723bs: add braces to all arms of conditional statement
Date: Thu,  4 Sep 2025 02:14:45 +0000
Message-Id: <20250904021448.216461-14-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add braces consistently to all branches of conditional statements to
prevent potential future errors when modifying or extending logic.
This aligns with kernel coding style recommendations for clarity and
maintainability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 27be46c11b65..25f333bb0816 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1667,11 +1667,11 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
+	if (pmlmeinfo->VHT_enable) { /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
-	else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true)
+	} else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true) {
 		mlme->auto_scan_int_ms = 60 * 1000;
-	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
+	} else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
 	} else {
-- 
2.39.5


