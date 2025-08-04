Return-Path: <linux-kernel+bounces-754643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097A2B19A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE9D3BA50C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38C222560;
	Mon,  4 Aug 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxaFGpnF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A520221DB6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276615; cv=none; b=Ex4T3tuBJnkMi/mSCRno4dmqYMdcE6Y5Wyqnh/+UiOEPzQDLZzd4NodgdBie3j7xAnXD28IQxdzQeXnmGT2ii6+I4HnvzV17SFuGvL92xmSSPVC9AVkSaxLl0R+nicwLKf2gq+84cXC3nkuXHlaHtF6oyma899zStzh2sneJRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276615; c=relaxed/simple;
	bh=qjiG41H690nP9mB3xq6Z0RT6CrVbRj7u7Wnkix2PW9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9ccE3K1n/a1LXHN/qbv7p2uSI10ECmHccmf9hRaEvIPgNm5r+Y9XicX6/Q+90/yRVyJE5tPzBZZQWAp6PNGDrY0H9CCcjyua9FsxrjOdlY9uy6MnjPNMZ25wVdflBIdA1mYi4VmgPQP/ktyjBVNLzTTFw6NnwzAvtjq3qD0DV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxaFGpnF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5740sLN3019447
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 03:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kugaIG05z6TB8lU/3AG4HIpKbvmdeKqgwRzdGMse6is=; b=GxaFGpnFpjSf+FAN
	ymIONS7/Jzrr90nV1sY4hOOnufocbaJ8B1oSxmaltbNtjlwAxBEWtsU4VWVI1T20
	Eq0cF79novVLJ5G1qDojD7CseKI7Ow7+Pd6EoAWMfcGKwKFAKCKSwp0YNQGJh+hZ
	8qVQLpC721k56v1+ISRVoBSljwWGVhkmh0F5EdzCJUpOyfi31kLISHgM4kf04r4A
	KZJHLcQMg+1Lx8kzjz1+dgKh9MZzMnp1ho5yig6PSJwWZ90WBiD8ive7ysqP1hpX
	KCnrJLmvna610rSoNCgrCoEEkm7j7mQXKNqmu3dOPI/3Lo9/+HZ2hcYPQbAwe4yA
	4ScncQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek382c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:03:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f5f70a07bso4452369a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 20:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754276612; x=1754881412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kugaIG05z6TB8lU/3AG4HIpKbvmdeKqgwRzdGMse6is=;
        b=MYMcYYSNivIoxMIJnvym/8ceR+6PwrCCIWbO2OgyuBDi3LnAhZ0dsi8h5Y3kekbJiL
         ZsozyWHEvY+euR2Hllgpugmou9pSAkO4P+vHBfJEWVRfj1pQQiLjM0pHwvSQdIS+i8X9
         SZ+o7gt9AEAqfRq2dbnuuACLHGNf9Xo8U6B3Jjw53IjjkhJVFaG0TE5tt9nJ9y5R4O4d
         /3H4kjiH1OQAqK10gFjjm+kszxAHZKCXJd8rPRenmNRXPgCHyzkpmfJeHyH2GTLgJHbX
         wTbIwjYognlSLN2D0j+ZCi9ZDRt06ObpUHeuZAB1pEFNgld4cmzATUn+aVTViUFq3w0C
         SyyA==
X-Forwarded-Encrypted: i=1; AJvYcCWeXDOTBJ/vVSZsQWoDg3r5namxC1QLk3oApnZusI9M/CHb10UYFuFmKgolD/rEIiTueFSu7riq+qqPEHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZyxN+4etcdwFCvsZWvAqc5foEoa+nwqRpv69ZrEMK6J1uFbs
	ucgAlZgtQgU/oGnE5BgwvbLL9KEPI8qkN/f3/F3ZQln1GkRHAEeI/EYLaASV0jHnnJ6HpeVjE/t
	0wq/XvH3qqU8e7BuXNCpSij+EpLMc3Ncb4A3xWKGOzSxb66+wBW7dH1387ESnyYll5cI=
X-Gm-Gg: ASbGncvYH3T9Yg3eUV5axQDg/pir0W8i6yRak4k8HA2lSJlKhQvBTkErR8+13bbRlgE
	zgpRj5IsWHXRBvvXrsv1hSqlDIjkDRtz1eXnZMi5l7VSL7gYdNQ3FfNtpB+3M4ahzzNnoIEpxsC
	K/i6I27DerLGvLsYa/E3xLWvG0AYL01XMb+JQ9tAQf1ypDilSSXd0DL0vzvG8tMvWhMsuTlQHF0
	yQEVShvz3B3puTFfyOC3/R9sMOVfTQY9uTdm4J4T4Wo1Owmy7u5g1Jtlpkl1JgrKZ9moh/F937p
	wLFxthUzJf9iMLCuCsz6WjK5bzXmHYlFCGozXUr6kY8KWPWlIgYbA+1l+i4qiy4B00902lCqsIo
	qlRaEcUI9sNfaLQZNUQ==
X-Received: by 2002:a05:6a20:3ca3:b0:240:dc9:71cf with SMTP id adf61e73a8af0-2400dc976eemr2467491637.38.1754276612428;
        Sun, 03 Aug 2025 20:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ8hpq8FcFPIUvqKGjKzFf0aD9aYMfmslygFO5EjJQ8zoEQ0LW0hIkkoaNDD9j549pSh6i1w==
X-Received: by 2002:a05:6a20:3ca3:b0:240:dc9:71cf with SMTP id adf61e73a8af0-2400dc976eemr2467453637.38.1754276611989;
        Sun, 03 Aug 2025 20:03:31 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm10489000a91.10.2025.08.03.20.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 20:03:31 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 11:03:11 +0800
Subject: [PATCH ath-next 2/2] wifi: ath12k: fix overflow warning on
 num_pwr_levels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-2-56f1e54152ab@oss.qualcomm.com>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=68902305 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=eeRMwnN673tcwiIEPYQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAxNCBTYWx0ZWRfX/N5MK02wSN7C
 S/BHpOic15Hj+C1QX//9WeHgE0+FgHeRNvzqyx7hs4wyBYytC172TCpfclUWbZyejRKRN3yiLoN
 hNsYfqDd7DOaqKcE5vSibQ88wZjpkWaxMIaDy+H3HbPem9Q97f9zZRW//sspRBzCK5nB9Qy6DpE
 I3XKnLaJ2TAaCv/nWzt/5YOmJazdOH4QkPtpv52f8KZ1ozNRZ4d8GIWMOQGrpPksRxKOrShf17T
 Cl0UcJOdk3AS6ZRKko3MZP/yDhclH7fW2mlWE3xqTUvixBXexXtrLtyvrmQuo9YX42PD2SD5i4i
 BbHzAKiwB6JDy06m54PLETMHYeulmS0GtaZ/da2D7XIJ2Rm4F42G8ovxNrtyGrQI5VIqcgdNgZu
 zrsikjc2wIDEAIRPjxi8HOexzDAwUD1twovfCbrbTcnTJBHlYSNRxVsRfowrX7yd9RkWu00H
X-Proofpoint-ORIG-GUID: k_Xz9hkRvl3d6ZYikk0UkzmjWbiZHSsY
X-Proofpoint-GUID: k_Xz9hkRvl3d6ZYikk0UkzmjWbiZHSsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=869 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040014

From: Baochen Qiang <quic_bqiang@quicinc.com>

In ath12k_mac_parse_tx_pwr_env(), for the non-PSD case num_pwr_levels is
limited by ATH12K_NUM_PWR_LEVELS which is 16:

	if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
		tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;

Then it is used to iterate entries in local_non_psd->power[] and
reg_non_psd->power[]:

	for (i = 0; i < tpc_info->num_pwr_levels; i++) {
		tpc_info->tpe[i] = min(local_non_psd->power[i],
				       reg_non_psd->power[i]) / 2;

Since the two array are of size 5, Smatch warns:

drivers/net/wireless/ath/ath12k/mac.c:9812
ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
drivers/net/wireless/ath/ath12k/mac.c:9812
ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15

This is a false positive as there is already implicit limitation:

	tpc_info->num_pwr_levels = max(local_non_psd->count,
				       reg_non_psd->count);

meaning it won't exceed 5.

However, to make robot happy, add explicit limit there.

Also add the same to the PSD case, although no warning due to
ATH12K_NUM_PWR_LEVELS equals IEEE80211_TPE_PSD_ENTRIES_320MHZ.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: cccbb9d0dd6a ("wifi: ath12k: add parse of transmit power envelope element")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202505180703.Kr9OfQRP-lkp@intel.com/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8295480e8b1eeaa3e69cca823e6745733ade50e0..57c81ba988ad3c7c3037286c6c093cef4c4f8116 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11435,8 +11435,10 @@ static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
 
 		tpc_info->num_pwr_levels = max(local_psd->count,
 					       reg_psd->count);
-		if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
-			tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;
+		tpc_info->num_pwr_levels =
+				min3(tpc_info->num_pwr_levels,
+				     IEEE80211_TPE_PSD_ENTRIES_320MHZ,
+				     ATH12K_NUM_PWR_LEVELS);
 
 		for (i = 0; i < tpc_info->num_pwr_levels; i++) {
 			tpc_info->tpe[i] = min(local_psd->power[i],
@@ -11451,8 +11453,10 @@ static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
 
 		tpc_info->num_pwr_levels = max(local_non_psd->count,
 					       reg_non_psd->count);
-		if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
-			tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;
+		tpc_info->num_pwr_levels =
+				min3(tpc_info->num_pwr_levels,
+				     IEEE80211_TPE_EIRP_ENTRIES_320MHZ,
+				     ATH12K_NUM_PWR_LEVELS);
 
 		for (i = 0; i < tpc_info->num_pwr_levels; i++) {
 			tpc_info->tpe[i] = min(local_non_psd->power[i],

-- 
2.25.1


