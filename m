Return-Path: <linux-kernel+bounces-754641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16FDB19A58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C318978E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A421FF3F;
	Mon,  4 Aug 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9SJJ5ET"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF12156C6F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276611; cv=none; b=R+x/iBrasL2sl17YgtRhhNAVzwrR99lvnQWAscmrI6ApD4VOLLg3EmgmXbFPo3vbIHSVJEDAub2bQ10gwgrSRUV6atZrFbhI5/z2fLpPcbnR+92K16bACDhub4dRm2ZAbqIu+wmv7l0015pKcp6kZk8efZeT2IG5LY5dOyk4SHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276611; c=relaxed/simple;
	bh=jQ6Cvrtue83tSPEngot30qNW8YbInIfCiq3W0BOsXyA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uVu7ZLa5F4Bp81MAVpMS0HtB2jHlsn4vFb1BTe3D+Za/5MFPAspIsG7N94/7wcE1Lbe7F020GJZD1dBCW2CAYGqRIgK1nwBeO7jsUUNEU2YRtdoyyWW4kx9elpQonysigrDW14yXtufdsWZokyQuhjdaQCf8Mc3eUrAhuAxeq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9SJJ5ET; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573No4S0025861
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 03:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jWjl2/LsT3uqPipUgEyDmG
	kvO/8Fme3N41mIfB3Febc=; b=N9SJJ5ETd4G6rz5uzn091+6lFKx7ezo/L5flPw
	cu9gX9/Rv3wmCZJp7dLAh2LFreL3Zg3l1IjIjZFUYuLY+TjgnrAipyn77LpeqJ0m
	dREznokarCkF+MCd/M31r8XblQmKBjXG8mqONk+m6gP/TcY3sGLZvTIlS8oJr50s
	8KT7NbOy41bxp80oMhO3d/OV52qPmYOzKsZqG8kaH/wqfNb+qeRrctm3Qlw18EbV
	Be2rVJy5pHvM3P1Cczkr0xmxcfpBUiq9nqT5dFjY4qqYDSWiEnJVjglP6Pq6DD6L
	HbW4lc1LQWi+KsFDd/jXC9X9VmX+0sD/+b5pKLKxFOGdItCA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489a0m3b4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:03:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b115fb801bcso5480848a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 20:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754276607; x=1754881407;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWjl2/LsT3uqPipUgEyDmGkvO/8Fme3N41mIfB3Febc=;
        b=CxgpD5cH5XcTkNQicfENimxw/NtAV6IM4u5DkKRv6Tm18c+1pZ0uzQ4ZsT2Z3PverQ
         POfSvm/BDEq6Ik9GNahHX5XLrc8aTxUktpLIHmvEHJabuKOzNbQbOLdgusUopvIce72w
         iTrYiFQ5Wy6i+AXMjB0JXgrz/BGMsgjsWK/Wg3v8nrzh0916JHI89zoDwJCUk3bhqK6t
         SRGyyAVV4yT8cnlz4UrQykSq4m16ZuN/F6b/l9mydvTpaZWt0DwByCqoTeXabi+y7w3I
         8+SObJm/0SRsa6d5O1Z0R8hsVTPhAkb2I6jthnG4H+ncwOiH1YLL6yVts4Ds2YTsJzeV
         dQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMSZozk79tpj2+oWRYl6H9fYeEMvIXCIL/cZUCLjd/gh1euTpWALtv1B4c2qVEu9GC2em7MqXnhy0feHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/sDTwlWXy/6d26rTEXGwl4uKLsA56CDirzl3n73+4hpRNoIa
	QdsEwsr7eqJznOObRL+72x5e0QMmSe5yW+pxBXFUgF8rrVBLb33NYUFCDF39nerPH8tZOZFOhA+
	5s6NhLT4SMBp5MrgQF8yYgaSYTZ664cnlHkG9i2CLXUiBUVu26PkrnDEedlZcQHDx44M=
X-Gm-Gg: ASbGnctMkB9xadaQx4O3LIznywT8mPTpltm1Ug+Wuk58YkhpzzXr5TK/hxMzmCz390B
	tuWK/PYXJl7vkCYlxb1hxYRYCpJZJmtmAC1K3jaild7mhjmF7a0qwdr0Sg5KY+BVXqm55YnSmqc
	ybbxqkyXuI3pnYqO/VBxXGywsXdXow6sZN+TupbbknENQ7izPPzjb9XkUoqv8BalTSTt0Iz7etd
	+gaCtcJQw+8UUaB+A4rekLOBqBHokcvIyM6hkuEglXzCFxq6fpzrvRFdua/rzoezOUus4HkoibG
	g7IaQUbpB2DIqqcAr/Ea9cyFbkvEiovpluwq9tnxUY12jFwJh5YoNcqOe8889R9oxIWfNjGNtWy
	fmGtaapo6We+lbdKjUg==
X-Received: by 2002:a05:6a20:12ce:b0:232:7628:9968 with SMTP id adf61e73a8af0-23df8f77df9mr10374389637.1.1754276606540;
        Sun, 03 Aug 2025 20:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExvnKIZdOLteWnTOv2UyQtya6X6UggYZ9wc54uFCIA0Mg9TiA8q3Xq6Gvkrj+kUO2e9aNNtg==
X-Received: by 2002:a05:6a20:12ce:b0:232:7628:9968 with SMTP id adf61e73a8af0-23df8f77df9mr10374347637.1.1754276606144;
        Sun, 03 Aug 2025 20:03:26 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm10489000a91.10.2025.08.03.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 20:03:25 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
Date: Mon, 04 Aug 2025 11:03:09 +0800
Message-Id: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4ikGgC/52NQQ6CMBREr2K69hN+CS248h7GxacWaIQWW6wYw
 t1tWLvRzSSTmby3sqC90YGdDivzOppgnE0FjwemerKdBnNLnfGcl7lEATT3yO/QmgXCSLPq4UX
 eGtuBsyA6iMMEVEvVVKItCAVLpMnr9N8tF5YAYPUys2taehNm59+7PuK+/2SKCDlUotSoWk25a
 M4uhOzxpEG5ccxS7JrI/0DzhEZZy0YiEqfiC3rbtg/rqKPQQgEAAA==
X-Change-ID: 20250716-ath12k-fix-smatch-warning-on-6g-vlp-a97cb86f3a16
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
X-Authority-Analysis: v=2.4 cv=JOM7s9Kb c=1 sm=1 tr=0 ts=68902300 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=2XfRbQ7RPn6m6gspCJgA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Tz9e3oXO9xGOcGS1NeM2x960Xr8CDmTu
X-Proofpoint-ORIG-GUID: Tz9e3oXO9xGOcGS1NeM2x960Xr8CDmTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAxNCBTYWx0ZWRfX+B2snQ6f2lPO
 yxlojvDG083fgONaKPdgYg+gQhybDtEfJQrba4y3x7L2uopt0N+1U+ku7yPMJCv5/wQKYx7JZYo
 Jd0BGf9G+QyL8p96RjWt1m53Ft8NqyKcw0vSqB4t6xDbyocxHqVcz3/7403ix53g1dWzUu+h8sa
 tQTldpijSpyJWB7TsezYcamhP8fkauf3BlH+K8P5QXcKGLslbr1Y3kRXbjuKLsEjJX/TE7LtY5j
 saZ9y31o0hL9p/8RhZSFUrlo92CQ/tMVAwPI3KMi6Zq7+62vpAxz3HYWCBohDTUlf4lUoDHahMV
 D22tTBebbXwS3/PpA+FZjUjnoyChUZS3djSFJ1nqJ040ePwllwOL0DwBWNvHxvUdJvdOFA6ZIO8
 vgtHhwCqZuFkjXqE/K3uadaJrXL6Fd95ytZE9OTvLbV372eQxB/JsXWfVYRaxA/d700LTlfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=701 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040014

Fix below two Smatch warnings:

1#
drivers/net/wireless/ath/ath12k/mac.c:10069
ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.

2#
drivers/net/wireless/ath/ath12k/mac.c:9812
ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
drivers/net/wireless/ath/ath12k/mac.c:9812
ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (2):
      wifi: ath12k: initialize eirp_power before use
      wifi: ath12k: fix overflow warning on num_pwr_levels

 drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
---
base-commit: 4cedae6335644a5858e1bc2c367aedc10482b654
change-id: 20250716-ath12k-fix-smatch-warning-on-6g-vlp-a97cb86f3a16

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


