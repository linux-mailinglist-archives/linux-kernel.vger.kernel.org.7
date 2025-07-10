Return-Path: <linux-kernel+bounces-724918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E9AFF884
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03B91C84328
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E3284672;
	Thu, 10 Jul 2025 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDQY2Snw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088E21FF45
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125682; cv=none; b=ED1ooIv7rXEAiV76z24bJCZsM2GnCOIxQTGY5Z2b3VzqE1HwfA7Dk8/5BfwEClL3M/5ovj3tfzQ48YVBpW+xRd+veVEv0chmD5DgsN6aK/hGF42VGS9dbI9aT60UxIIrptkTPfD+mtkGmF0Uvhwvv/o1tZfq/e2PxPkfd288fwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125682; c=relaxed/simple;
	bh=mvZIts8B4Yr67O0UdJmaYEE5XA8JrdqL82iVA7D7HZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gZcmdE/m1Zesx+UvCtXOCmeowPBvJMYGvJZBPukow++I5tJi/wJHvEvmYNqBRAO27Ruk5Q1K0bQ2WAG/jJYjdUsetQ2yPazd4ADTJGdKA41uHGK2KJ4KQYt0foBZ1GG/PJvV0k3ULB/kcfjq3JFvxb8pXXxK7cobFscmuPSLMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aDQY2Snw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0jdIP030233
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bIrjVST+P4OHo6l/rvg23B
	t2hUu0jOXrzeSHr1l+LOM=; b=aDQY2SnwK1k25PXgRRb6gE9oNlq05EbJeDIX1A
	obnofwyQFUFyVqWEXp/EJqgUgXQYD1GXf+8T/NqbZ9sjQMQtl47jQtx5RXChy/H5
	j8fE3WSMQAL8p+JxXvmopE0QTjuVj+PkE6Ixrt3113PcjglnlkTICG0RDMqhhRzW
	Ep76EXM68P7Qg1TbCqOUjALCdEtt+MBG3zyNehr3xgTpcAnpx/4AjYdYOlGVeqT+
	IJdpB6E2AAxlVqmh16zknsYjD03zeoGTq6H0dHswQCU6XSib38VKLW5QE4NvS/0y
	2/dc0olMe9Yy6Ji4fTLZWI3QkCJIqBwag0YDl1iesz0s3K/w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg3kp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:34:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7492da755a1so541016b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 22:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752125679; x=1752730479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIrjVST+P4OHo6l/rvg23Bt2hUu0jOXrzeSHr1l+LOM=;
        b=w+N96TxdhLsJWbL3wKaMNhFx7KXuimDqm4XhGI25xjtWVEFbdt6k1gQOuXvBV/TShF
         Apa3If6y8pHoPnLvkb93mHTUhRevveJNPemQ0brJw9gsxxydnMN0t/ulrSf7wbAPLCrl
         mBPVi9A8CnCSjJZ5Stkty1CKyRIMF8bNAxGz9cAnj+/i6Nr79SS4rvzXTr9TGKL4FpkZ
         mpUbPN3JUcdj1tI0E2i2Z3JyMRcEAXKUptIVb6CtNjTVZshuV/dfwYtrEUuX2MUG2iHc
         uZgGXUMx52ER1+3ov0lCddfQSJannGCGpzN5MCXD6JhUul8qvzRGtY7ZO23Vnq4rggn2
         hCfg==
X-Forwarded-Encrypted: i=1; AJvYcCV/FgPAzrnDzy6y97NpJ40fsLqBVcf/Qaf/DxVaa9A8484NPKy8MTyjW/qZmnd60ZVTonOmjAr9YDRbq5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxkYDUvbGSHtQnN6MjrP0NDco8a1jTxWpaxS9jqohu3Z72e22
	lbFgxLax6Y3KbWE4Wo53ZrKAxenqijgA/OCaTOC2jsGfBjyKHGQJBfLX3/Vn+GELgAG1LoAO+pE
	J3H/W1BgVY6FzhinrnZD34IMiKHmAolG0faFTVLjH1Agl6CDKkUjrYsDGX8FIWotxutL9lvRDip
	g=
X-Gm-Gg: ASbGncvuzQ1P1+DlZIYR9NLUBnISI4Pl6zGUGCbNm3d8VsbG1IS+wHOfd662cCVVRVJ
	QpEZoxjWoVXq+vkvd3jyrIXpZV3Hd3a8fZhVqOvNA0JvTV1LNA3jMcRSqdbTOQKfYSjx732XiFp
	Yde8ScfDHLPs24eQbuKXS1xleT0TSD4Y1S6WpnlEAqWzemhX1XybPBWmi3bMTSrzpLLOQ1IhtMR
	sD/Tf0+31NyM/HWohRlGmd/WZm0tTIoNspco1eBlN8ZyaF7N9EcdABDu8wVHtUadGQgTKo3ELqp
	K+/VNjuhNfiJwTexLsQ2CyICv8uWHjzA3SfX2rzR45BQtS7mB+4AnQTHOvevmNxj1e4FXHlPPfj
	3V/rNGdF+qIwOqDb6v8crvyJcJqVyXKm9+veWYZgw4tU7xvU=
X-Received: by 2002:a05:6a20:3ca8:b0:220:689c:315c with SMTP id adf61e73a8af0-23003af6339mr2352056637.3.1752125679179;
        Wed, 09 Jul 2025 22:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Jtm115d2Fx9f48mUPoH/rzM6XBjf84mmoglbsbzGl+ptQ4J5rEMTNPi0phIoRFtvfvPPIA==
X-Received: by 2002:a05:6a20:3ca8:b0:220:689c:315c with SMTP id adf61e73a8af0-23003af6339mr2352007637.3.1752125678730;
        Wed, 09 Jul 2025 22:34:38 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0201sm1014043a12.31.2025.07.09.22.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:34:38 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211: parse and
 update unsolicited probe response template
Date: Thu, 10 Jul 2025 11:04:26 +0530
Message-Id: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJQb2gC/43Oy2rDMBAF0F8JWldBT1vJqv9RitFj0ggcy9XYT
 kLwv1c2XWSR4m4GLjOcOw+CkCMgOe4eJMMUMaauBPG2I/5suy+gMZRMBBOaVVzQsQ92gGbsMLW
 N8xaHps/JQZMBe+qNqU0FTleKkWL0GU7xtvof5BoztIBIO7gN5LOszxGHlO9r+8TXo98is1E0c
 cqoAx9AccGc1e8Jcf892tany2VfxlK/YjU7/AcLUgrp4WBr9wJbvp3E04eCbaGioNIbp07AgtH
 qD1Q+oXITlQuqlXJGem8Yf4HO8/wDopSvptcBAAA=
X-Change-ID: 20250612-update_unsol_bcast_probe_resp-c88786eb5640
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686f50f0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wscp-l6M08ckTL7hqVEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: bdVBXin8P8uGJR2SpbSFmfskS05VN1o-
X-Proofpoint-GUID: bdVBXin8P8uGJR2SpbSFmfskS05VN1o-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0NSBTYWx0ZWRfXwWlccC8T9A4e
 MbFlQJZ8dp75YP4GrMlnrWwVaXJ1WjOv8u9vnB7dXOnehT/sJUWXMKiQsU+KaP4KuWqbaBAez2G
 hfL+Gvzvqi9Sg55eE4B6FZd/oGa5sov/QC8a67iY9VOuRA7ko81cMd6Q6ADEokPs993jmP5ADdZ
 ljEOOFrUbFTlE2T2z9e4K0A8WHhMWTIdjJ8E+i01Q4xEHXMy8NR+ATiYBkVL7KouSzvPNHOduWW
 rZMFKVmlW2PQb8XtUaeII1uRj56E8sKUymm9ewkl//Q3E2a/DL6ueC8QgNQjBQrkMwszthtP6wd
 u+oJvNafIbDI9Fmvr04yYiCjhH+BAHSQbZ4xxwgPkDPzxVbU6naRuChcwT1J31aU202acboDAM2
 F4lARfvjkVz+9Popw9NgaE722gMx956qXGy0NsrKbd2/Vwy5KiUVVvIntCPzdEhwNCmb+E6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100045

Currently, during channel switch and color change events, the unsolicited
probe response templates are not updated accordingly.

This patch series introduces support for parsing the updated templates from
these events and setting the appropriate BSS changed flag, enabling drivers
to respond with the necessary actions.

---
Changes in v2:
- During CSA, add P2P interface check as well [1/2].
- No change in [2/2].
- Link to v1: https://lore.kernel.org/r/20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com

---
Yuvarani V (2):
      wifi: cfg80211: parse attribute to update unsolicited probe response template
      wifi: mac80211: parse unsolicited broadcast probe response data

 include/net/cfg80211.h |  4 ++++
 net/mac80211/cfg.c     | 12 ++++++++++++
 net/wireless/nl80211.c | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)
---
base-commit: 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2
change-id: 20250612-update_unsol_bcast_probe_resp-c88786eb5640


