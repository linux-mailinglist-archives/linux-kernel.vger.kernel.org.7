Return-Path: <linux-kernel+bounces-754642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C41B19A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D73175BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C1221F39;
	Mon,  4 Aug 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZnr9AmE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215FC21FF25
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276613; cv=none; b=NmEDkKAv0OgXSwCn8YJjGoJaL+zugL+gxeYMuj8UPvCklaaYC5yRqro4K38BncfgYg4o9AdiHPEszN+znwpnSGQ8osLxwFzNE8HFEnYAKBzRyviXP+j2lskYi/tesh/WWQcQl8dKDKzKmf4KBXXNU2Yn/oHerT7xUVIpX4x1gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276613; c=relaxed/simple;
	bh=fulF+7++kKIq3FU51fxvSd6TZ2z/1EkUJ+ZdPG5wMqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxbiDBJmnmluBWdeJQWJLFhN9hUc/qee2ZTjMcKIYDFLzH3FCQPevvYj5ki9hNeAhAceXdtkDAlWE/YtKFDytNlnLizrZc6gZ7D+EPzJG1iUB6v2mshzySMmAAsdOKtRSnfV1OUlQfApnH8MoCAS009OiumfxonCVKZksEUkGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZnr9AmE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NnWDQ028438
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 03:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ws4K34M895QlwoqCvDCnlEt/m9zE1eKyV/9hDVzwdwA=; b=hZnr9AmEJIIm/hBU
	fzKLwCRWWUOWCxvwjZGHxP4X/PXt9H+WCJcns3ZyEVFyDslivoEArEgKWaDckw7n
	irbZYKBNY2Pi5IyQv3dtbAcKPwDrMboPTNdu1QHlZcCdrVdt56x9AqRyTB57VxAC
	oY76ggdZfMWVRB2aIFJ0MMeHLaevRBQSUadkTEUs+KXg/jLg7Txvik0RC66tt9tK
	obCodXGi0Uozsf/C11jLnnw78OJOTw44TLLnzczQYiLVws6+kCt9KqhNcsDYTHDn
	DNRyCMQUzJkuMBzPK3IflC+N2qF2ou+r5e1kaZs37rFMCidTE/U2wRLCCGkHwASk
	TL11hQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pabcg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:03:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b321087b1cdso4921830a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 20:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754276609; x=1754881409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws4K34M895QlwoqCvDCnlEt/m9zE1eKyV/9hDVzwdwA=;
        b=j6ADEH1NNveeyuNSxDvp2dCmu8VU5V4K47/e8LzEhCRCEwpTA6ziSo9QnL/YzpRx3D
         WV28X0RN/Mx4nCNTjCxxSrb5LNUAG3cQR9hOEPsHPH5fury+xImAM0/1PTifYghWjtYp
         4QW5fNCktBA/UtOk5ZOV+1LHc9AXrcv7i1ZEKZ5Mz+LP1a7DuJqQKWeWFRvZHg7SHWCl
         eSEKz4Skg6nPZePbSlDgQZoi3W+ghEgcAJflN+OBCqXzFEgdk7dbIOdBUqug87jt0+oM
         hLwB2LJWG5MRifJ8QfaPSe84GsUZMXjwsy7TttHfoOORCrYouisWlxc4ntLLyt66rVTv
         yK7w==
X-Forwarded-Encrypted: i=1; AJvYcCXG4x03b6z4L7ySx6UMKe3SuQ8ev5vVuRDouwK9KVPYsYMXhm3hualm701yVcVOfLcyfLn+fwfgwvPAIaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIkvS/y2LsSaFrmOz/fIGipN3Ylm921A226qW7rEW7x1VOhCy
	gAtfHk+ygpi5drb0WDuxgHP5pSMbHRYm+xxPDaioeLHV+4iU8CI5/1wSLgilm0J0HC9e8cm8Kmo
	u2shlTI99WxYhhhYjGNE8JJH1+0ztBAoOpWnd3n/OY76wfZpw4TRBZCXdO23Ji4HWLmg=
X-Gm-Gg: ASbGncvB0IU+mLOxmy3hA074+gO2zvJIFzgQukhw3+6qlBq0SgjbOVIKaMTtwNRSi2s
	rlx9+WqodvdGGBm8JVEdoMOm7p6BOaRC76aaNjgfsuvQ15pghw/DYuvsVsMJAbrSaXbYpLYZyNo
	dg98tSNltBtcmUmgl+g4f3yoD59AublkKynihOpDtXXBrV/asLeP5L+DUNSyKOJlxrCO1vJd8DW
	hrTg8IhQOwf8IdRTE6zOiqGBW1IAPimfqIS4q9+RbcLx6/ULoOx9bSQMAQuWdAF+rfY/YqUGEI2
	98YI5ojBFhmCWaSVCgBv8jQ+NzE3eJqkqOogISAfohTQ9MEkr23ls6bRXDgsjzCmUn+QZ7raLmT
	1KH+/RhsiA2+xenYRug==
X-Received: by 2002:a05:6a20:1583:b0:234:8b24:108d with SMTP id adf61e73a8af0-23df9802825mr12965504637.22.1754276609367;
        Sun, 03 Aug 2025 20:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNOz3T56VRaGLUiNKjisoMK0eXMn1xWIfG3yzjpBzA6Ry//yUXJa0ThZsF7/BH5KTDJ3p0bw==
X-Received: by 2002:a05:6a20:1583:b0:234:8b24:108d with SMTP id adf61e73a8af0-23df9802825mr12965460637.22.1754276608919;
        Sun, 03 Aug 2025 20:03:28 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm10489000a91.10.2025.08.03.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 20:03:28 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 11:03:10 +0800
Subject: [PATCH ath-next 1/2] wifi: ath12k: initialize eirp_power before
 use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-1-56f1e54152ab@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAxNCBTYWx0ZWRfXyf10VXZCYt6r
 B8CPI1aLa3uhtMmsL0vhvgR2MJOKwcXFVt2xwqa7/qTi/sXdXzYwoEvRDStxUBunzBHkBHNLVgt
 IPSVImtMMkXDnm8l1MoYIJWsdtcQnx7DJ6f+X7j9PkjasTuovDgx1i6oglRsoTxRhO0zzO2rhWF
 c4aQSRCn0EOZGORRJgCg9Aksi8lvfXt0SiWO/2nc9p3ZKwK0L4mwsEHnKtdmYoekh28qsQuFB1J
 LiBv+SSeC9LEokDVz3vH+SxriAQo2fcoAGWoVXDEeEGD+b7CcOEmOeb/lSEWlbleSEBtN3VWu1H
 vmtS1n980HNKWM3G/IUL3J8nqIQT3WvxNvMoXND6/b6B5xo6JdSGAv0fYJ7Dzh4zNA5mIbxiiBY
 kfjLrUq8e6Zxgi6BPsmxVgZ5TDs45mlGSGdcYAv3VztNY2r9t7K2199IduE2xFHzEvlQ9wF6
X-Proofpoint-GUID: ypmxpuy7z-zC9pglv7Y-feyf2ps5SdHy
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=68902302 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LZTIgfvDWzmdvsE2OGQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ypmxpuy7z-zC9pglv7Y-feyf2ps5SdHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=717 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040014

Currently, at the end of ath12k_mac_fill_reg_tpc_info(), the
reg_tpc_info struct is populated, including the following:
reg_tpc_info->is_psd_power = is_psd_power;
reg_tpc_info->eirp_power = eirp_power;

Kernel test robot complains on uninitialized symbol:
drivers/net/wireless/ath/ath12k/mac.c:10069
ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'

This is because there are some code paths that never set eirp_power, so
the assignment of reg_tpc_info->eirp_power can come from an
uninitialized variable. Functionally this is OK since the eirp_power
only has meaning when is_psd_power is true, and all code paths which set
is_psd_power to true also set eirp_power. However, to keep the robot
happy, always initialize eirp_power before use.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: aeda163bb0c7 ("wifi: ath12k: fill parameters for vdev set TPC power WMI command")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202505180927.tbNWr3vE-lkp@intel.com/
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd1ec3b2c084169b841146931c54b6106f7006f6..8295480e8b1eeaa3e69cca823e6745733ade50e0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11228,8 +11228,8 @@ void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
 	struct ieee80211_channel *chan, *temp_chan;
 	u8 pwr_lvl_idx, num_pwr_levels, pwr_reduction;
 	bool is_psd_power = false, is_tpe_present = false;
-	s8 max_tx_power[ATH12K_NUM_PWR_LEVELS],
-		psd_power, tx_power, eirp_power;
+	s8 max_tx_power[ATH12K_NUM_PWR_LEVELS], psd_power, tx_power;
+	s8 eirp_power = 0;
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	u16 start_freq, center_freq;
 	u8 reg_6ghz_power_mode;

-- 
2.25.1


