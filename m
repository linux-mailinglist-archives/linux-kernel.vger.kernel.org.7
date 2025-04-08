Return-Path: <linux-kernel+bounces-593058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE65A7F49D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757893A6497
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F27261560;
	Tue,  8 Apr 2025 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q90arvgM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05A261377
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092415; cv=none; b=ABReBNQxYBbf0BfbtuJF5TM82vbo8lsygA7vO/i/c8u+DMbyXb9GRy9wNoRbY9dcVQR5A+na/IJqRpx6oHciGK3NdETzx+dn3nyr15G8G+WcmA6j9bAo9+kYQ9nTxUmOUQwbMVDW9TMUV+mN+VZyZoGAes+XGGwNpzKQ+wGAFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092415; c=relaxed/simple;
	bh=Qg2tuu0wK5R2PRbA4sG9GA532XpVl4FSIzs+bRLlMCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+csANCV5gGgO+N8RUzXbl9p396DFHwU2kSDC8fJ0CPMtTtdoOBM4rxcKJIgD5VBt7SljBfru/BEBkud8BexpcTZAc1SPXlW3q3mTTGOdWdYialoeF3KB/46fv67s9BHP7FN3ocQG6teGL/AmYC+qMC8YBZkDkqOwa+ilAt0/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q90arvgM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GNbM006296
	for <linux-kernel@vger.kernel.org>; Tue, 8 Apr 2025 06:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxD1d8+SURGaW2WmT3Vs97sir9axBka6nu3u7fHBVV4=; b=Q90arvgMkL3TE1WA
	mysAs83NjH5kzrWE3STROVHVvYMG77Sh+YFpUtpIf1QZG58NkwHrA4uwgCHwJsJ1
	Tr7gNTz9tCZ+PyhONtCnVhLi0qPVM1kZ4aP2Q9Lzanu0CWwXgUZ6mUF7DRm5/Dbk
	pQCqNRcrYBovURYF5PhbVfyf0GynOtA8I+gwyuMWW6NhNp3HZIoV0q+1jvmntwKI
	DtwLEYYsa0q9DxlmV8uPMgp+RsTb+Sg/nZRSzg45ITSsEjfU10+xfwdcZ0QIURDj
	YN7TNezaQy9rxyq2GIGpERK1pBtrdsyWLa0KXoYTaaLQ6PYIL7phPkGaJWmRBDvF
	LKG/TQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftekp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 06:06:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73009f59215so6176228b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 23:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092412; x=1744697212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxD1d8+SURGaW2WmT3Vs97sir9axBka6nu3u7fHBVV4=;
        b=Adp0nrFi/IRglOGjjvcwsyvPlvDEOjjWsh9f4IGu6p6vzjjlRNFuoMR5WSUamDSBrs
         5uGioDvHVnxeXjFBhOuhtcYZCb9pOm8HrEykLxS0G4GDJhZn8kWitPmzoRruFugSYJxS
         q9BYaBro7UMSwdnEihAGY7EnHJplBuoBubMK+kvul51DeB2MJGVjmhvQjgis7E8zw4u4
         8kpo24BIUkPk5UL/M03auFeyPKn6LzzL37oxzSlWMgjZ5H4vehOw7n1z0eZBFNsFdFTb
         0ZaHUVllG16aQMTLGC2REm4zFJDPmUt/TWJSzUhLLPjhv9w8ibSfg4FBjqdKiTCjqdrt
         DMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1NWw+x6Lr4dDVWHcn487FVKqa0zxkqAXqL4Q9WrN/H0V6RLtuYolc/3cYATtf1OfIjNkCweF/8+dfR4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUP0AjyhikGyq5nvBICq2mp+ua+NoS9bkQA8pHyqSbQB9jYO9
	ETeNz2Kjkfi0wBAjwqiUZFaXi18SzOsKY4jUKOjI4SnPQ9l0jSdM8uNMy3Sd6O7QpwEgoHcoGcQ
	izp0S81q5cqLWFz45GVdQyhjav+5JURdWc5RR38Oykbr6xq2DD6lm/oIUiA/N2uc=
X-Gm-Gg: ASbGncuRtoqLeYpvBRBD5zcpJlsOr0vDRYtZv/pWRgimn2l588Y6qkLAscoRQs9gPxG
	o1xwJBIXZC9sZ1dgbUkz6VnjWxz/dLY9zzBodGsHygeHEnJWgcJeea/uAPgFIkvU2z9l9wYhtHe
	+PEIg6lDMGazFcpPrtuTIvnB7LP4xZmGN5uJJPrrAqdw05x/QudBOqqPao3kmSAxV5TvLjXBqDA
	cjQNVS+7oFTapNBSEFhWzY2s9SEfSO5Xj89b+BU0euDVMaBrOtSvjDCdqFw3/rb81QbNUmBBsLj
	383NY+a1+sBvUASoaZ7o02WlcljLTLYpz9zlA+/JaHY9/sb9alAb9tf96s8hsfNyaRVuyw6lemq
	CY//6rixfnmhOBCww+skS4x3PPrPc76I9GqOmPv1K
X-Received: by 2002:a05:6a20:2d06:b0:1f5:5ed0:4d75 with SMTP id adf61e73a8af0-20108139fbamr29100398637.31.1744092411772;
        Mon, 07 Apr 2025 23:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGNs6YIAjtRMwCSgr1KcB95nwYEiAKpz4GyZD+0pmYEVFXHVcTPMA7Lk9EKDFmHiBoEw/Jaw==
X-Received: by 2002:a05:6a20:2d06:b0:1f5:5ed0:4d75 with SMTP id adf61e73a8af0-20108139fbamr29100341637.31.1744092411321;
        Mon, 07 Apr 2025 23:06:51 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc35079fsm6863981a12.41.2025.04.07.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:06:51 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 11:36:31 +0530
Subject: [PATCH ath-next v4 3/9] wifi: ath12k: fix failed to set mhi state
 error during reboot with hardware grouping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_reboot_issues_with_hw_grouping-v4-3-95e7bf048595@oss.qualcomm.com>
References: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
In-Reply-To: <20250408-fix_reboot_issues_with_hw_grouping-v4-0-95e7bf048595@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f4bcfc cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=zZIk_WvpsQkbQcpLs4gA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: re9c8IhqpeJVbdf5puosxc75q1_sfcMn
X-Proofpoint-ORIG-GUID: re9c8IhqpeJVbdf5puosxc75q1_sfcMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042

With hardware grouping, during reboot, whenever a device is removed, it
powers down itself and all its partner devices in the same group. Now this
is done by all devices and hence there is multiple power down for devices
and hence the following error messages can be seen:

ath12k_pci 0002:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
ath12k_pci 0002:01:00.0: failed to set mhi state: POWER_OFF(3)
ath12k_pci 0002:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
ath12k_pci 0002:01:00.0: failed to set mhi state: DEINIT(1)
ath12k_pci 0003:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
ath12k_pci 0003:01:00.0: failed to set mhi state: POWER_OFF(3)
ath12k_pci 0003:01:00.0: failed to set mhi state DEINIT(1) in current mhi state (0x0)
ath12k_pci 0003:01:00.0: failed to set mhi state: DEINIT(1)
ath12k_pci 0004:01:00.0: failed to set mhi state POWER_OFF(3) in current mhi state (0x0)
ath12k_pci 0004:01:00.0: failed to set mhi state: POWER_OFF(3)

To prevent this, check if the ATH12K_PCI_FLAG_INIT_DONE flag is already
set before powering down. If it is set, it indicates that another partner
device has already performed the power down, and this device can skip this
step.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 7f1bb150f326b317157f6721d990d61a27f38d6a..aae1989c686bda37c12544e72338bbfbc5f75042 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1487,6 +1487,9 @@ void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
+	if (!test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags))
+		return;
+
 	/* restore aspm in case firmware bootup fails */
 	ath12k_pci_aspm_restore(ab_pci);
 

-- 
2.34.1


