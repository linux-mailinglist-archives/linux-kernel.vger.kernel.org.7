Return-Path: <linux-kernel+bounces-769896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C0B274D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A5C568232
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB39288C32;
	Fri, 15 Aug 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgSM5PxS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE42877F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222325; cv=none; b=IaynzLXP4L6jls8uIf1Xbwo4uSpefGssOoR6DQLAkfROpDA69DNV0QG/2iQzvGwbB5gMudSRS+wRZvM0lKOIEq/YvNw+RyI3KpkPmcMmtuv9P1ofcZYETUnarschQtUexwXIrDVT6u16sXxurmIXWRwuuFISDK7vpfBh+0z+O9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222325; c=relaxed/simple;
	bh=Ddu7QujtO4Q6hfp1GuZr8ES+Bm9lIQeS5W0/PaWsaOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMc9PmxO4AFmVqLybH0e3+zzoUGXCn4MS/WPQefm1HjnFftMlRjkhu9BfyUf4NSbh6rRBo7AQu67b4aU8NKaltSkMV+z0Dg/n90jIjKhEY5z9tfDmfNt3wXMJ6VgMHF4zuUiqlHiZ6EA7LUpOkkhV5ksDuD+gjK4Ia7G/9RC2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgSM5PxS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EITVQF020726
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kxYCF6nACau5/iqJnJgpcLYWSFZCwi7it4PbOasdPHM=; b=EgSM5PxS9S52676e
	gr39z/Y+zJqcax4+6Mu1IB5gYTTb30zEpnXeH/97wK9CWV9UrxxC2wNIhtVhHUet
	MReBct0n4WQlCksmNam2iwpdckpnjTH7QN2b9AfyhcTfh1tvE19Z5fYLwuC94rzO
	lBaRSxDcpXDwALplPpCYMcxFKojrTwycsK7tq5iCYuOVtpS0mflrBe33M/+UyL13
	TqOkJjiH3XmxJQp5Pz3l/84Ncl8Lq5sefQSgwN1dR0yu4Tg+HBg46Ln9MAQ7IcrV
	hSN4GnUHqfq6DR8gF8eA6MWUyOxACkeI5RH3OiKy1oPwTasHxDkFHLHGwwsC8tQ6
	R7Tiuw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9t1vjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-323266dcf3bso1504742a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222322; x=1755827122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxYCF6nACau5/iqJnJgpcLYWSFZCwi7it4PbOasdPHM=;
        b=xUYbW4ztylxy0YUZ88YmcJABKeRKCkHS0FO39DyCCQJSLerX+MYv7M9iTLxnAc1fLM
         ljyFaVTy2T3XaR9ah3B9dR3Ddv0kQWNk6ohB6t4oyjlV5ee4vEDIr+yBPNrg/Mcnzody
         3/VYc4T7n8GmgDfc6aQG7gZbrOUvUwEOPGDB9MRQyCCco9RFKFC4718YvleVZjjTAXe8
         QO3veBDBA1qmIfpoKxsOH0MVaMYip/7qEg+Wu9y5QJufStXiM+JkqyGbc+POmpMA6IY/
         uusT9ssWimvVuX0E3iO6nkQPL+MXAnTyVs2zB6Yt+f23JpCtC/rF7WFJU/FUflgGGSjE
         tw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5wgOAdFJOR6QXNCZVkpP2W+qUAuGORXL2Gils4IrPtOGQ3/hFc4sTbExAadYp0eY4swz7yOFjpX6pIo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJfxknyT+HpE9qmCzTNhV6yC9x2FqBq655slb4JRVxEV4rxfw
	ueSRbiEVWf5IpY3hiupjy1WeCiJ/cAkrdpErynZw7dSAOie2lv6LdqmacJO0RKasArpIxiLXzoT
	ZF6zVgTRXvxlC8EHc2hzH5HKSObaJTC9OeTULK4x1P3jvSZA+E+vnEqr1jk+sQyu6ps8=
X-Gm-Gg: ASbGncsNd0B6g81EFIgP/WoR9AdcjwMJUnNi0zbrwXHiYJ1Ok5Irv2wIlKA8OYMKn6Z
	eozm7yVttz/ms3VBkezEHS2nvqyMGm5G/2RnngFh7U9V/BBwkbUQvXTlb8MtnAxd2EGk71Ref/T
	rrbgztpck+/liFzD41EvXJkNyMTXDPeGrFbq5KcUt4U+IeDZnMRGrdhyzJg9icJj68TdvfdfT8I
	aMisvBu8fEVunUkcj9loKuynhG2Y1WjugAxIwVTHeAPGH3/vGvSZRSscjBekY/il88Hzpn8yBKA
	RxaHMy5wpBbw2JNR8Ewa4PMsofZ/jWekw7XQv15Rq5+4rtcC+ryH10X9L/YRtqaUa7bP5xxL86Y
	VCP/9UhVruFru3nd6
X-Received: by 2002:a17:90b:2542:b0:31f:150:e045 with SMTP id 98e67ed59e1d1-3234224bd01mr480284a91.32.1755222321534;
        Thu, 14 Aug 2025 18:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp4WB24m89Yhcn0ioUDH1nUmYAvdRLnZOaTdAnGSAHnM7xxPbWq3Z6LhNQhmBtmQrugKO+wg==
X-Received: by 2002:a17:90b:2542:b0:31f:150:e045 with SMTP id 98e67ed59e1d1-3234224bd01mr480246a91.32.1755222321004;
        Thu, 14 Aug 2025 18:45:21 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:20 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:44:57 +0800
Subject: [PATCH ath-next 2/3] wifi: ath12k: fix wrong logging ID used for
 CE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-2-f955ddc3ba7a@oss.qualcomm.com>
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689e9132 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=fHvqFdtNKkU2r1BsT3EA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 5NyJLJsB4wC0H-KRfPw5Nv4yuf_9l8Tt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXxkECpRgqWRvs
 bKuSXwVGtDYQk+Q7tyQw7/xUZO0tJUOjmNMNk2Wgc1w4ZGoFmdOabVdKKMAyFPKhgVV82hqynVV
 jwE/3IWVTUDPHnXyuUKOL+POlHFdAg6/7bf6y6tJyvarYiJghbY9M2PRFIoHdawnRrAbmk0J2Zs
 x7B50/dxGAtIVAJoazGagdK9bMgo4JRKkiK1l0FwRpEtUE1hLl0Eu687nMTe+2bumo5308Jy4bn
 Nz0seOSXmYVFNWhsSRQJzeDhFUHfdM5wUHhxuAxJKtuqyNgAegAeUp9/36Zg4ofQUdpjLEV8ouX
 +YcvhCgV8+aovQZbLF34cOQwAM17KaC3n0+QZbJB60zVjVwTf33O4tlpVZwqrh9qhyxcvL0zL7g
 yX2RayyY
X-Proofpoint-GUID: 5NyJLJsB4wC0H-KRfPw5Nv4yuf_9l8Tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

ATH12K_DBG_AHB is used for CE logging which is not proper. Add
ATH12K_DBG_CE and replace ATH12K_DBG_AHB with it.

Compile tested only.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ce.c    | 2 +-
 drivers/net/wireless/ath/ath12k/debug.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index f93a419abf65ec6e9b31e22c78c8c2cdd7bdbc76..c5aadbc6367ce0d18080bb0e15a88d3ddf2e34ff 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -478,7 +478,7 @@ static void ath12k_ce_recv_process_cb(struct ath12k_ce_pipe *pipe)
 	}
 
 	while ((skb = __skb_dequeue(&list))) {
-		ath12k_dbg(ab, ATH12K_DBG_AHB, "rx ce pipe %d len %d\n",
+		ath12k_dbg(ab, ATH12K_DBG_CE, "rx ce pipe %d len %d\n",
 			   pipe->pipe_num, skb->len);
 		pipe->recv_cb(ab, skb);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index 48916e4e1f6014055bbd56d5c71ef9182c78f3b6..bf254e43a68d08f97171d9baffd0ebc3aabfb3e4 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -26,6 +26,7 @@ enum ath12k_debug_mask {
 	ATH12K_DBG_DP_TX	= 0x00002000,
 	ATH12K_DBG_DP_RX	= 0x00004000,
 	ATH12K_DBG_WOW		= 0x00008000,
+	ATH12K_DBG_CE		= 0x00010000,
 	ATH12K_DBG_ANY		= 0xffffffff,
 };
 

-- 
2.25.1


