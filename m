Return-Path: <linux-kernel+bounces-772999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908BB29A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4AF3A2289
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2A627A460;
	Mon, 18 Aug 2025 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSKi8QGc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FB279DC4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500177; cv=none; b=q5xIp/7mD8YHm6DLbu4yrmNAt24s/4CvbANj3IeDuTJKnNa2bH5bYdYMQa03cD9vdzENzgM/YAa+pMrXURDDxNYWtdw1njZAxO7F25cNwZ0BqfjmBJMEJwMud2KYnLIH9iDNtdzZuNQSbw8N9wM7G2fxGyaehZg5e72J2uBri0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500177; c=relaxed/simple;
	bh=ZF2cvc7qh7L2/sR1ZvsVm+7I8RgsKwMQgdHA40RqXP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAkw/25iyJHqN6ChWmpg8OO1Vevz1z8HCIYiRzwtHPiWtERI8YEWNpx1bNPp3WkEowmLIKxRu+TjywAF7ARyjxHHgDNKx/TXWp9AIgEFYyR1wJ9WbwfKQBO9x9oe2P6evZMY4I8ftaIsRyACOBJd22Krtv84SDTCjIQkvmpX+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSKi8QGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HHQLgW011483
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W6Xp9EvQZXpa7Yolr9M4+PLDhTLkej4mqann/Lijna8=; b=MSKi8QGcYjreq89V
	q5sGg8RLZoxaM32koVnYn9Fge76mhGFM94ddd54w5whrVqzjyjP/Cs5uqctqATaB
	Lz18geb2/iKvXIoH1Zv70PoZSc+UF17+NEkZfJIQ8LAkI5B1x7p0q1FSnAUd1af8
	u6A+RHBqjUPIda35CrWlVKjl6VghfA/MUeNhMIVUkF7dED9QxF+GZlRoZwCnkAHt
	5CYUBmJCxKqsuvCSG9Vl8Pu8/zpIaxjsGweivieDiSNbmVHlTu37jx5498QiTJ9X
	6twq6a/FU+/4jP/mac7k/UrodINSEyKfMGMs7RnCGhyZyKBWyhbsJSFBWaBS1gUK
	V4QRiQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfuhrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581187c6so42458685ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755500174; x=1756104974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Xp9EvQZXpa7Yolr9M4+PLDhTLkej4mqann/Lijna8=;
        b=DIp/vsy2kW9nATFxVKgA3M6WVaKzSe0uNZkOd77XZa/FHSooJHRUj6grAJZxEO7NnL
         0Uh/9iVgOnSUgdogNOupd1uP3gwsHVwxmUQgp9gvVJqyvZJ0FIwNUkN1LzK3s/evrYE4
         trYjKYw0XaX6NPHNbddjMhEyOHuwkid9gBVZhyPhgNcBlQAa16bQaKPSKgGFfFBWrPWv
         ufvvtxTYPYE16KM5XYG/W4mNXUTQb7S7rsdrMHDu7pnh8s0QEwWfxGw8tneNBoPJ5Suj
         ckjvVntEdf1lYTIuw7dUYAvt7ZJC4eCp07bNw3SnZs0asLewy0gj5V4BpH2dID9lJiNt
         HZsw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2UFIUtl1BBQ2nOurKMLgnVPvoml9I0WCXYryVD+3xAsqoOgQVaepLpYExR/huAZ8A7DLorI6joRXblg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEKb6Q/N8+nWtZQXp8zaG/MRD4iuFy2Stwtu+XRXHJ71VIEja
	Y0Q51RnC+NcwSF7JBVuhtw1qOAKAvPWm4mCj/QmLbNWRPBDGdtHPNJczBiwZhcT7a64kDLxl8Yo
	mrniC6tWko4DRmDDwvp0KdH+WiuR8swNqUtS0xmvfGfdA0kXlAvKwdjHlQrze3ElW7cM=
X-Gm-Gg: ASbGncu4z/aVNPeo0X6WXiU7qzJweqWiN7cUDy+kg5VL62cBpbS7O0h0qM/YiExG3PW
	t3dJpTgZVSIZw8iFH06dt466rIGrltXrp8AXfWMyawk+tMwilnNZTjW5Ir9QeP+L6r/SRNW/LD3
	S31N+GfY7Irk5lAVpXzVuUS2kGxInodZaMe41H+eU591w3RJ9x3T7Ih21l4LiHNg8H+RZx/qbjA
	xON2lnOA3d9k6jjb80tlgDQKuXmR++vrib9bOTrOsiNxfBce+edyxNFeui4+qMuAKTaTnUwZx7r
	b6ygaUDoBmXKZqPct3GenKmWKziPIO6R3rmtsLAxMDyp8UVI+eDqqEuF6xzniFs1AlRVetz2q+c
	=
X-Received: by 2002:a17:902:d58f:b0:240:6fc0:342c with SMTP id d9443c01a7336-24478e148eemr109517095ad.11.1755500174398;
        Sun, 17 Aug 2025 23:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeNxUTAjVRXiTV5guQNaXys88HDgIcyosKxt6j2gNU+n+P2aDPEAfHL/PdO10n3dblXUp8AQ==
X-Received: by 2002:a17:902:d58f:b0:240:6fc0:342c with SMTP id d9443c01a7336-24478e148eemr109516775ad.11.1755500173976;
        Sun, 17 Aug 2025 23:56:13 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm70240105ad.75.2025.08.17.23.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:56:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:25:47 +0530
Subject: [PATCH 2/5] bus: mhi: host: Add support for 64bit register reads
 and writes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-tsc_time_sync-v1-2-2747710693ba@oss.qualcomm.com>
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
In-Reply-To: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        taniya.das@oss.qualcomm.com, imran.shaik@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755500162; l=2553;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ZF2cvc7qh7L2/sR1ZvsVm+7I8RgsKwMQgdHA40RqXP0=;
 b=//ygcJjGeh++VVVRReyWtFMl+NJEym2u4DxCH6/QAYpM4+O7JNkTbeP8slZ5S12aV110cq7hu
 H2ektu2v3Y8A4TqLvBhFy8zLNn/dC7Mor/qxxelKo1qBTDeQbJTWGqJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: EnSp05SF6MLfPofpf6l-xu18cHghLd4R
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a2ce8f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8tVK0NU1EB3xojDYR3gA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfXyoKVSrVE9XvX
 sli4Rr+KV7NP+Z8jYxiPS64Kh2yRYdP+m5ILiUOD/dO3THZRN6NH7/qpeP3N/TH5Ha9655GJIhB
 aEJngQ3Y/FWr6sIEQtv3887MroXQjs5SXqt4sIF7iXr7hq0IAHC1nTnCR30TyY3jXtrz7DoK4Su
 hgOqaexLj38cjUkTBgZqOMrpnINtkZtNV3HW1+VttOMokyeDCpbKFl2TtZuPx5YC4lbfMm48ctk
 z2tMhJY5ztwXc86f+udXcJSmUFzGbRsI88qZv1TUUu4WmA+8wTZ1O6BmURCb902HRwQZBsC7edr
 4iTekxBcl1CIVoTUvySxykE2TGogY5II6dKmycMfkDkwTMT3czwTZr3Ej3ftZAZnkr1vPNwelmW
 SwrHxqDg
X-Proofpoint-ORIG-GUID: EnSp05SF6MLfPofpf6l-xu18cHghLd4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039

Some mhi registers are of 64 bit size, instead of reading high value
and low value separately provide a new function op to read & write to
64 bit register.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/main.c | 12 ++++++++++++
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 070b58a5ea75f121d4495d9dfd532f33cace274d..b7ceeb7261b708d46572d1f68dc277b6e1186b6e 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -67,6 +67,18 @@ void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
 }
 
+static int __must_check mhi_read_reg64(struct mhi_controller *mhi_cntrl,
+				       void __iomem *base, u32 offset, u64 *out)
+{
+	return mhi_cntrl->read_reg64(mhi_cntrl, base + offset, out);
+}
+
+static void __maybe_unused mhi_write_reg64(struct mhi_controller *mhi_cntrl, void __iomem *base,
+					   u32 offset, u64 val)
+{
+	mhi_cntrl->write_reg64(mhi_cntrl, base + offset, val);
+}
+
 int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
 				     void __iomem *base, u32 offset, u32 mask,
 				     u32 val)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 770d51e9bfac7434ff4b4013ad045c041c26adeb..540c90d7993ed9dc84d9ee29dd73ea2a81f0cd67 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -378,6 +378,8 @@ struct mhi_timesync_info {
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
  * @write_reg: Write a MHI register via the physical link (required)
+ * @read_reg64: Read a 64 bit MHI register via the physical link (optional)
+ * @write_reg64: Write a 64 bit MHI register via the physical link (optional)
  * @reset: Controller specific reset function (optional)
  * @edl_trigger: CB function to trigger EDL mode (optional)
  * @buffer_len: Bounce buffer length
@@ -464,6 +466,10 @@ struct mhi_controller {
 			u32 *out);
 	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 			  u32 val);
+	int (*read_reg64)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			  u64 *out);
+	void (*write_reg64)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			    u64 val);
 	void (*reset)(struct mhi_controller *mhi_cntrl);
 	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 

-- 
2.34.1


