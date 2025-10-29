Return-Path: <linux-kernel+bounces-875399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA46C18E62
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E2D1C81F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5103195E7;
	Wed, 29 Oct 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUOFph9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5uTtXS9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F2314D0A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725158; cv=none; b=ByWWKxbBnhrrCd9szbJePUK1YC7uztNERVTorrVqSO8a9JvelV6AN3C5NAb9OT0bTHaCCB/Kv40pqVtv23NaOjkhmtBo62p2k/EURW2SummWDlG977OrGRaBzHcMpEFP8XV37CtTHbjmhQuwtTdnTMiOjDKBYz+yljD0wO7v08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725158; c=relaxed/simple;
	bh=CKt8Skmgsmi0xiNgmGVCB0ByG4/WRoa7PomttZXz7T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdFMSe0valVtN5775/H+j2X4+2Y9czZBGQ/QgAAtWXt3Xy0AM6KBuX9xxQnR6Tgbm+xKQFYWpz/Uh8uCS3BKy3ivdJ38Q7h8iPoo9zJOUtXi7a+VF131Ou1ojXKyuaQaxT9bsReQjSEsV1Nd8Rx5LSM3QYyBEtw/tHEXzxLH9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUOFph9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5uTtXS9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4urHI3764247
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NX5wX2YhjlH69BNTyfzdigy0bOKooGYLfSt5kediBY=; b=GUOFph9WbtWcfYcn
	dWH9N+oLNxurnVngya+Plj1u7SIm/5vW1dtefqT7xFXud7iV6WGLhiHf3LUdwRTp
	ZpqCKYEd1K/8tjaY5JbIy7LWbV57TU4LqAMFOuBO/z4izQcPy5wdk6jktSOfT4Ia
	aq/b1R5+kZbIsIv7Pf0c0IFLwh77BJy+xYNOsWEt3+Le6OsyWJlJd/fPytZqNnLy
	4YPLRzlW5uwiBG4LzDP2uJh+v3hC9uoESw9/up321gb+5XrIh//8JWUG+aAqRMg8
	yj6IAUGEqpAIEbiUiyKJeUY0pQUn8/tLZSmIrGuf/QK6echwdgx2TS5JdLc7wfcr
	pqRnGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a11q3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290b13c5877so139963225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761725152; x=1762329952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NX5wX2YhjlH69BNTyfzdigy0bOKooGYLfSt5kediBY=;
        b=I5uTtXS9qNV0QVHGVKpkG9fwvDr3yp9oxJA2eRkkGSgkh9UjiUF8fsfFs+HLUpOEdZ
         GglU/fozFWicOm4OI8CUHJntfcOnLsRZhRxpB+Vudc6fyu9b44gH+xmjdj8urZtQgBGo
         /abc7RPczlOsZUQqZ7HR29bs7GaYXdB9Fna25y2A0utfrGohfDROHS1Zxrxq3yeWDP/7
         195MiEziePaGY+8FxALJSvm609DDjLNKmIuW/Ux6Z8H9vQzDLFZylLMPdyIYIdZvom4Z
         c5jXR1H04G8aIRvyMMqtzQPwJrxwDa42fjHsmBzSmMHY+isCcf2muC0cG5wXQwui6nOV
         7x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725152; x=1762329952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NX5wX2YhjlH69BNTyfzdigy0bOKooGYLfSt5kediBY=;
        b=oqpPiOP0ioNUojlRMOFKfMnKCeQKSVQqwixharPA0MYDTGDYvbW13Vbc+0so50jwo0
         BM+6LxBnPC/LiPwGYD65lbfKxja9E7kC8bcklrG6bomN9nW4Lsi+JADHtXsMiWzq6zH9
         rmsyCCArTNgr33alhwHxwiIT5Kn/5ouv03C40m+CB3aNE3X/o+ZOTCdhKTPwZyuZVGHJ
         T1zg9iXD6hLrU1WlrrmXL6C7BJwAMRA3+giiNSz2rnLWnVX5+QqleQliQ/jvMnm82Euv
         wXtYcipiZZzWMSOPxYJr0UQtcAMvYCH3wpJcx5nqQxQUT/9yfL1raYPHpaS16X1DrXrK
         a7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW6nb6krbnB7RJggvlGGe2PqjLMlcfqzatB7n5lrK4k3KuW5l5wNoV1dZSbT8nLYU5EHu7b86HC1YCNyy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJ5PUqW72F8hd6Ef7o1iSmm64LeHgT3INp4JQe1xTNHtxiwC4
	Lg+aOvZQyizZMwrCj70lsHRRNq3AvvCoFQ3UAXHNjdb1lHX3bA4m7gdQNwNpMqR3jutkwxhkGU4
	s160imdQktJ8QaJvdnUwcDMZHLshdGRPBztj7cmxfhnDzxeDQIn86ALKwCr/YX9yYbaE=
X-Gm-Gg: ASbGncvwiWH/Do7WV5MuHoTw1PkBermwkLn7u7lCzhjFQz0J9x2Ub56uKhUZ+SjEr2F
	AVjNHd2t7g0iTdj1hNNzE6x1ff16XCFum+ZJWmg+nQnhAamObNHzBZriCe3KMwS9Fp3ymai1u7N
	CXobyEHDgmUStEWJyCJUsfjwnYDJ9zec88EI2uLwqhNO2EfHT7pUG1Egzi5xi/wrpx5H7Nd1nTu
	LeYgtwbwmxo74FO+Cn+IAnPrvbRQoKPL2N7h7oHn+hRPl9hymgMVzehpXZJjLs6xdVebDZi4YzD
	FlXVZ/3oHOV4ApbGx+XbCvQ1duXtecwp7hBxoQBFk0QM6ISBf7nsx2LpcceX2TQ/+3goFaAkH/7
	xb9izjkIODAYGoiIqlA3QwpuyS1HJGzDzP9jKkjW1rpl+UQ+nzQ==
X-Received: by 2002:a17:902:c411:b0:26b:da03:60db with SMTP id d9443c01a7336-294dedf453bmr24761495ad.13.1761725152057;
        Wed, 29 Oct 2025 01:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpC4Yaz06BQLmNZjQOHk+DUr2aZgqq8Ytc//6fK2f6hDjcm6LdFNuXkxUgm3UGJLFIDbAaGw==
X-Received: by 2002:a17:902:c411:b0:26b:da03:60db with SMTP id d9443c01a7336-294dedf453bmr24761145ad.13.1761725151516;
        Wed, 29 Oct 2025 01:05:51 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm141754705ad.96.2025.10.29.01.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:05:51 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:05:43 -0700
Subject: [PATCH v2 5/7] remoteproc: qcom_q6v5_pas: Add SoCCP node on
 Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-remoteproc-v2-5-6c81993b52ea@oss.qualcomm.com>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
In-Reply-To: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725143; l=1580;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=CKt8Skmgsmi0xiNgmGVCB0ByG4/WRoa7PomttZXz7T8=;
 b=zraglLPDxf1FKILsB9DgQV6I1xCTmrtSZ7BHX/DHCEQ7LWe2ccah/FiVFuUGYjOFWgT4OaEzJ
 xFTNEcPE+NuBfoVVlXVkPoj7L5kbV6xN+1sm6wPn9uVHEhpZn2C+FVk
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: YvlCfAe_9xs-yb8rWFThiDREmmV07CQR
X-Proofpoint-ORIG-GUID: YvlCfAe_9xs-yb8rWFThiDREmmV07CQR
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=6901cae1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-54vo4t_4OUFHp6kYXwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1OCBTYWx0ZWRfX/PtkEkVxoP9p
 be26VnGG+BPtOWbq9ePDPwtsseJIb5H865Z1GwFeNWmymMnr0P1CzLTCckKOX2O98kJ2rnRkR8N
 Ny0FNf9TR7f813EuJ8xI6qE42qiZxCk6zN8vrEMqLjBvxGQblA3POfgkNWPNi1jKvuxhcOvOfIa
 L6GFiS6ys7kOf0CUPQgOsdRYgHnMp7yz5zlsmBvwh5Kn7wrv71ZBjS1+8ktdrMrFeZkxYpMVem0
 60qOYmNjIn7idHr9FwjlpQMgpW9inOQWbaGqK5ZfKQCMtvPZnq0HpUPVwDmZZSxwLlEtHOq5atv
 jo+V2dRoV+pssM3TQO+j8Qa7E0tpUkG9Xtv8LAz7TGvukKLJLH0BVMwbfBBwzwNxdq+MYn4VeGA
 PdUO1waS+T7PZV/adRgEEnG17j5fIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290058

The SoC Control Processor (SoCCP) is small RISC-V MCU that controls
USB Type-C, battery charging and various other functions on Qualcomm SoCs.
It provides a solution for control-plane processing, reducing per-subsystem
microcontroller reinvention. Add support for SoCCP PAS loader on Kaanapali
platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b667c11aadb5..c470b139afd1 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1515,7 +1515,25 @@ static const struct qcom_pas_data sm8750_mpss_resource = {
 	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
 };
 
+static const struct qcom_pas_data kaanapali_soccp_resource = {
+	.crash_reason_smem = 656,
+	.firmware_name = "soccp.mbn",
+	.dtb_firmware_name = "soccp_dtb.mbn",
+	.pas_id = 51,
+	.dtb_pas_id = 0x41,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mx",
+		NULL
+	},
+	.ssr_name = "soccp",
+	.sysmon_name = "soccp",
+	.auto_boot = true,
+	.early_boot = true,
+};
+
 static const struct of_device_id qcom_pas_of_match[] = {
+	{ .compatible = "qcom,kaanapali-soccp-pas", .data = &kaanapali_soccp_resource},
 	{ .compatible = "qcom,milos-adsp-pas", .data = &sm8550_adsp_resource},
 	{ .compatible = "qcom,milos-cdsp-pas", .data = &milos_cdsp_resource},
 	{ .compatible = "qcom,milos-mpss-pas", .data = &sm8450_mpss_resource},

-- 
2.25.1


