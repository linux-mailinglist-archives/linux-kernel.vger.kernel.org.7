Return-Path: <linux-kernel+bounces-804952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48508B4824F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2237A869C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8561E25EB;
	Mon,  8 Sep 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPkKeZ/+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D40146593
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296311; cv=none; b=RpXojzE5txe7nrqUBN/7/ian9iAhMTcI7RsWIhI0VO9crCBNtfGCO13zS499a3xiLvLJkuHY+p9TOC/DmACfVMXBjoz7m4zlIaZbGADEsawWc6VYxbuJuYVQFR+WksWdVu/HHYsuDSiHX7rDYQhStGjj+lLK4+w0VcU43eVGtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296311; c=relaxed/simple;
	bh=/aDIxeT3TsNj1FBfWntIgZ7OZ6D7aYjEUEGG45hiKgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQzcVT4YIBCav1SaJFiFhaiXNSnIizwSR/viP9gOMiIV2M0cX9juYU4SGsUac3Jhjqpxqd8mrEvaOLB1K1jCLlNq3Yf2/ibC5HIuG0onioO3EH1W0BSKLtcdW80iRQ7VeDa2hKOfDDJx7rtD8Xry4NZ+0I/r9D1RleITIepKgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPkKeZ/+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NGXZc029227
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 01:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Rrx/5RgS1f+GZ05XDctzozDGEviN6tc7NYb
	3BzDD0ng=; b=nPkKeZ/+N6M7TJS43xNiUwDoAU9ojji6wx1ArbpHU2C9yuJHWYp
	Xaav4bzkVdKjd92KfTmEOqfN40/lHX//pwN2h5CY279jkuOfv28zqa/CjRMsoca3
	aGgoCUHmysiHpsxrq0POCqniaoCx9GRSB7I8kLmOcc7AkmI3RK/lbHH8E/q0pbvh
	qK/Ob6f5hFRNOF4LjXcHuzkj/+Qg+YdZlxwmAejYDtcbWdrauMLw7XRRTNMsjWhR
	pQWiPOFA1WP9hfBoO3geOWw2U730cGm4mvRi+R8ZizoF7oLdVUZW2nlDIHdeKQb3
	6cYWvV4oB+jOJKf3YQobIX2BTNerXx3SfqQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vax2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:51:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32b698861d8so3666007a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296308; x=1757901108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rrx/5RgS1f+GZ05XDctzozDGEviN6tc7NYb3BzDD0ng=;
        b=R+Vut3tnkV/UcOopPonZUH378qFzyhnZTGjHNA91/0PM68z+qqVu0zsPCHcMmIqR6M
         VyI87WoIkoNkDmLBXfYQN1Elf/ZMJuSAfVqPrL7vd+Nv1DKmpXR3EOj8IQRTWS30Lwus
         RH+/QKo1UTgott2gsiQtT0NQ3D1GY3752lZtHMJ1H9K+5qd1xkYvXdulzdx6ylLQ9KWV
         smJc4Bnn/RRYAgFpeBxf/aZ3uoKuVfRv/bRi1+yA8wJmrEudgMvc94Iah7ecxYH3O9Oz
         uilhKlMZcZGHbSfvwCAvtdAMruQFceGF9Fwgi4g0O7Lf3oxAleiB12H9Lth1TuCqNgPA
         xhrA==
X-Forwarded-Encrypted: i=1; AJvYcCW6xHyDCrcTp3zhQPWKTPF3NlFZ+qYZH+1FkzB2hnnFx5ZGX9HpWJ0K5njqns5JiGapbfSx835xSRHHKRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCxGOTC5kLb5DlXOvli8XbJXkHTgXim8iAFXlMFl+qH1rncro
	gnM/spKAJ9f9pWysO8Qxe3WPgBkxVcG6Lp6epDz7HQyxPNW1CXPPRasx78uU+y8iDSYwmq44U12
	mj6/btFuaSi+zpQW6kyDe8+6WSKCxazszhsyn5FqIkLUYacaomiwWMWnSufZk7Ku2OjyN/AI0tp
	SopA==
X-Gm-Gg: ASbGnctWIyag29x9DnvMVPEXQePkt5bfwYWJoED2esrahpKLdXZuYrlvOTkGpu5yePE
	sX3avuOITLc/ueUdRzrBTjStzWA7yfMoZrf2w6qv2GWB1sM9lFm+QCWb1AqN8vsRWXBIbZx0ab8
	xez9qRfXnAxW42Lrq8biNmWGYEaL4uTOGNDEf6FayhCOFjKyAphyCduH172Ujeyhm5KSxW4cpcl
	f546Hwnau2czjtDRamU5qHyVvzjrxGDAS2/KJ/Vi4jF6BjvrXouUhsl49UFPZ/fbpRrfMD18+OX
	lYDfSA4+tmpx48fbb1A2fks0FPuq1PpR0OLB6WTm7G+nDsGx/3M1sTOrFoNF7sRot6SSxXxVBuO
	Vcmpj5qib2YxHAGAmx6mZNqo=
X-Received: by 2002:a17:90b:38d0:b0:32b:d183:facf with SMTP id 98e67ed59e1d1-32d43f76ba9mr7024658a91.28.1757296307551;
        Sun, 07 Sep 2025 18:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5nRDidvM463gKG+C+xMPrHa3szfL3WmBr/t6VEt4l6o0AtEY94nQNcmFlQKvdElZnhnqKbg==
X-Received: by 2002:a17:90b:38d0:b0:32b:d183:facf with SMTP id 98e67ed59e1d1-32d43f76ba9mr7024628a91.28.1757296307064;
        Sun, 07 Sep 2025 18:51:47 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b58d8ca8dsm14563309a91.7.2025.09.07.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:51:46 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath12k: fix WMI TLV header misalignment
Date: Mon,  8 Sep 2025 09:51:39 +0800
Message-Id: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OMI4sY6BnYCCQEnj41zYmEMChCZmRaha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfX+Fov2SCOjiAl
 VRMWCbBmzWaezQzsCXF92ttn8YR2F+EHKzTcszjgZFlIbaDJTVw56C6Mdwb/vKzA1j0jLZauuA2
 1HPJkgZ+EuWzbHy3dodvlwdZiUv9MjCr9WGlsrmG7WyVGkMHALfsSPZ5iUpVW7Jsav/ON2Z1Zod
 KMcxQDEcdoulL+OwhMfIOFxnRXbUEqHMHIIIm6hihURN4t/EcIWwQ/0KShknu/kA6wb3kG3qWt2
 qJqreLu+OPQMksOmlHPgAcO1Na1dKqXGRhjgOubRTmOXjyRfFiWf4pALDEeCsu2r8m5jFc+AcuG
 rOZBfREDGrrdkM8VuFzuSINOyeLVymkPapk/21pMsSZq7k92BbXC4QVx3vD6AvwPjtk9sWoz2Qt
 1PuGmgkd
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be36b5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dYpq24IgevQlpX1txhoA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: OMI4sY6BnYCCQEnj41zYmEMChCZmRaha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

When buf_len is not 4-byte aligned in ath12k_wmi_mgmt_send(), the
firmware asserts and triggers a recovery. The following error
messages are observed:

ath12k_pci 0004:01:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
ath12k_pci 0004:01:00.0: failed to send mgmt frame: -108
ath12k_pci 0004:01:00.0: failed to tx mgmt frame, vdev_id 0 :-108
ath12k_pci 0004:01:00.0: waiting recovery start...

This issue was observed when running 'iw wlanx set power_save off/on'
in MLO station mode, which triggers the sending of an SMPS action frame
with a length of 27 bytes to the AP. To resolve the misalignment, use
buf_len_aligned instead of buf_len when constructing the WMI TLV header.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 742ffeb48bce..29dadedefdd2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -843,7 +843,7 @@ int ath12k_wmi_mgmt_send(struct ath12k_link_vif *arvif, u32 buf_id,
 	cmd->tx_params_valid = 0;
 
 	frame_tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
-	frame_tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, buf_len);
+	frame_tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, buf_len_aligned);
 
 	memcpy(frame_tlv->value, frame->data, buf_len);
 

base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd
-- 
2.34.1


