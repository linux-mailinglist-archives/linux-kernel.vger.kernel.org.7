Return-Path: <linux-kernel+bounces-769894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D6B274D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF91CE2219
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C722882CB;
	Fri, 15 Aug 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M93puMou"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DA2877D7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222324; cv=none; b=hvJ9djPyz8kvfvup/AGuH4yKOFVmYHLfoWhmMHZHvnovqhUygO3yXQuQEWYXBfhekof2Y0hXVtn4A5m0IR3D2OaMjE2wsep8Wz994hbdljWENOONH3t9SDyLJUcX/Dk+k2UPJcJMOO2NUr6bhLUGqAlP1Ostv1Mo72y/ic+2FRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222324; c=relaxed/simple;
	bh=Ooh4F6PH697oKIemfVheQzHdNaYpbQC31p+1w2jl4Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rg1vT/mg16c4/xnolyfSqWijS3KlOrbhGwrEd6etN4E8MFeUzA3X2tz/+eDL2wJstsAoMs2JyVFXq8pa9jEpkVy0E2JckQ5E1nr9BVHcur4uG/z/NEUhtwXPXid8tp9fYg6ZT3XU8RtlF8h7HaPWfbBUFOigotEyDyljysF8Tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M93puMou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHY6Om002794
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f2JJpNn1stvDlteeqX4h1Cq06+aEkFey/378SB+Go3s=; b=M93puMouYWldia7v
	EGGfEOnkU6CZm+O1LhdzImwJn4mzZXeXy4wdHj64ihFoeVzxkLcISt/fmFFnKoUM
	o96Nr1JYaVHXX3glaEpkJ0U3WZnvioThOyLjoyn15F1/XoRFmRasElUdYqLlLm+9
	ZQQaBKsM3lyB9HjQJgNC5EFae/qBbfdXIL24RIMsLNzip97RH94XiZshcquLqxRH
	aiSGoxFRqcp9802s0pNkKHFbpGHuVQDXWAMAhpaj/JfohpCmGDIAqgPHJjzXud0s
	7w0ioKn0iVPZfGi+DKslCpwYvv5bmsnKGgE1CK4fOKqF/sBt/ssj9vPJvqu4FO7i
	7mAEMA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv9n5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e6d8a9so1644262a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222318; x=1755827118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2JJpNn1stvDlteeqX4h1Cq06+aEkFey/378SB+Go3s=;
        b=hoQKdXUDyXQ8tZ/tEwBNrO2NYE8Jibav6rSBhUV47srMd2kpB84j8EyaDstt1w7oR9
         bY0cs1/MXPDuJ61TDUzzPf+YAPI+6L4L9rHgTjwdNAIk5QU20I1BbRpkLu6pVNDSrqd5
         X3IXGXOtX/ytd8Bo47uyJD5MOFmJ42b6LFaMsvF3SH0MCsOVZABnHntNJtpdmJKusrn9
         cK7xQO1N0wtanOY83cAsVKy8Lef6lKNGaJyEOteJeNUoDdKEY4oq9oz9iHTowysLQWLV
         mMxDplK94ZIhItSku7H8gJ+HdJFHwlIpaRLBJ92cINhLjoTp2jIzsnzR7NwQrxXETbH3
         0xKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmDE7vYmileK+TFHDfvL4p7n5HKPeZzPtE55tt2fiyRImt7uTbkp1cNcW7yiZ4jTniMeJoHPid7g3rVgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAgzFSizN+AX21OTVhVNljrPHWPZBC2aNSLd2KPyOTWjNdXrm
	UoKy3OviFGzwlwEWEnvWzsrYtNxwNegtHnaPjHLWTzwsP8QV+D50Yc3USnkwPpJl2F6aeqRoYQZ
	ZeIP9SpRibyJj8SlOQdkt5GGBNHk2T53YkBKWx51Fhv+B6Nu/hQn4bVjvHUZ1Zc1QylI=
X-Gm-Gg: ASbGncuMkTlPUy+p7U5JNK+uScPAVrUOmNFmSGTtp9oAxfk9k5NnEpIXYN//sM5Xd6v
	EjfjOhSRxirrsOzGTrEi528Yt+PDU4p6M7zuBqQ4ogp2DJHn463GV9SXEb5P8vWlqfs5z7XV7nU
	gnUORRwZm0P1jYQ3Pd9nqQAMxeR1KsINUoajtMjEARWkt4X9+uOM1Q75+SQNDcKzqRma2Af0xWj
	KaDrAPZaCe5S8KeHR8/nIArwiixmfG6wkJ0BJW7c/eBlKH9ZFuUGNmOuCYlGX8ghqv4RK+m4rgU
	aFMiBVqmIYllBlijgrOXh0C9mGvS0mBWMerAwChg93U1n6F+Lm9qM/PHGM1UyZ0UdtQCUn35+BB
	8qKshhSBMX52KDm4D
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr588152a91.25.1755222317986;
        Thu, 14 Aug 2025 18:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTATHglsejKDU1aURWUA2qjKt/Z9C08Zt0r1OWZF/vn9I1mLXPEpEoSQOPZtYki1JSB3Pf3w==
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr588123a91.25.1755222317407;
        Thu, 14 Aug 2025 18:45:17 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:17 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:44:56 +0800
Subject: [PATCH ath-next 1/3] wifi: ath11k: downgrade log level for CE
 buffer enqueue failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-1-f955ddc3ba7a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689e9131 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4avV6w9vhD41MOPHW_EA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 3iwDO51G__Xb7CFuteceYEwVHnQROfIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX0WSHpqlJD/7U
 HqM+v9xSQf7+J88IbFrO7Qh02djKIQll03uno38Q0crkDZa6dbJVidNaAKQMPtDvKaZI6h7Ynpu
 fMwFVRV8dRjiaCqSZxL3xezw06UgkvFfZ2w4244rutwf0HgVRnR09ULY6k7feC3F3TaE0U4+l6a
 4FQ032HMVzjkYpbd8M+iKoLziB1VAjCWB+dKQyoWqLjLrjhaaesmFIp8oTt9bODckz5JfD4Q6D1
 aOA+ooKensNFKhqjQOC8IfMzDdsn5HoIJn/rUcdYaJsOdalmm2DAJtD6ZVcG6tfSnj2RmK00Rb9
 LoDvXNHaOIxEt4nWd8IiO7AXMTKFpqtL+HeWw2IbH5hLc/+EGzLn68W2fxzq1TFITKOZYx6ihSG
 nvHo2Xy4
X-Proofpoint-GUID: 3iwDO51G__Xb7CFuteceYEwVHnQROfIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

There are two rings involved in the Copy Engine (CE) receive path
handling, the CE status (STS) ring and the CE destination (DST) ring.
Each time CE hardware needs to send an event (e.g. WMI event) to host,
CE hardware finds a buffer (to which the tail pointer (TP) points) in
DST ring and fills it with payload, then hardware fills meta data in
STS ring and fires interrupt to host. Please note the TP of DST ring is
expected to be advanced by CE hardware before interrupting host. While
handling the interrupt, host finds that DST ring buffers are used hence
increases rx_buf_needed to record the number of buffers to be replenished.
Note before that, host compares TP and head pointer (HP) of DST ring to
see if there is available space. Normally rx_buf_needed simply equals
available space. But sometimes CE hardware doesn't (for whatever reason)
update TP timely, making the comparison fails, then enqueue is cancelled
and a warning is logged:

	ath11k_pci 0000:02:00.0: failed to enqueue rx buf: -28

However even enqueue fails this time, rx_buf_needed still records the
numbers of needed buffers. Later when TP gets updated correctly, the
missing buffer will be eventually replenished. And there is no doubt on
the late update, it always comes (or lots of such warnings should be seen).

Since this won't cause any functional issue, downgrade logging level to
avoid misleading.

Compile tested only.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220269
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/ce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index c65fc9fb539ef10ba44f1c1d5571462b40fa098d..a7a163621b21067ba5a4f96131aafdccfbda3d03 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -354,7 +354,8 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
 		ret = ath11k_ce_rx_buf_enqueue_pipe(pipe, skb, paddr);
 
 		if (ret) {
-			ath11k_warn(ab, "failed to enqueue rx buf: %d\n", ret);
+			ath11k_dbg(ab, ATH11K_DBG_CE, "failed to enqueue rx buf: %d\n",
+				   ret);
 			dma_unmap_single(ab->dev, paddr,
 					 skb->len + skb_tailroom(skb),
 					 DMA_FROM_DEVICE);

-- 
2.25.1


