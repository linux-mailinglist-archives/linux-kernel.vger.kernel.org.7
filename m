Return-Path: <linux-kernel+bounces-892468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A42C45280
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0136188F03E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0242ECE9C;
	Mon, 10 Nov 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mfq5Ae+S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iuay4f2K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40932EA732
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757992; cv=none; b=lHmybUmuTUVaTmCuwKWsJfiwoxlljds03aN7fw/JELWxxHT88DNV0UpTnfD2KY+IFKNBg5gJ7xInMZwwNZl66uPhc3fCTjUFirRagcUeglBMFPMRznnqeg4tKQfjQQTnK1YWvV9EN9IysmGnIi0gJQkEvY+a3uCaiCV3lv1j6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757992; c=relaxed/simple;
	bh=FEATCEIhTHMz7b3SDtTSGozMG3s3HSCmKvUHkBi8n1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/7YuRU8RocZRN2ab+sSYvNCVdM68g/kDmKV5LADhaK3drAVfZkhT3TXAcQNfp4Ad7H3ZsNxhsGo4pfXpFGZuV/zRHkDwDA4zF319DAPjzCoKeDFg8dSb8+/aRpieBTCzEqY3I1vMBDJqZQ6WsfVciu3AeTTVhsNMYbBOqGWRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mfq5Ae+S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iuay4f2K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9LSloR1639796
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLpEAKj005z2AVaIsDA+4OzjbLyJv2txT17XxeH5bAw=; b=Mfq5Ae+S14LyzdMo
	9HJLI8eMFX5mLYmfdE+GLug0rB26Hgy0U7cJiZGx2BJKCTmyixDJ/OXl2/6DonLc
	HMKKJyhGd9QiRR/QF1JdRgUSQf1Bud4TAlnzRvC+vu5ri22/05Cqw5Xz+p24U4rS
	a4g44ru0SkEir7ne+dGbmA5wLACO12ACaTUPGyCUxS3GLUOUY9u0uTcDscNDPWat
	AMhZnAf7eCreD84DKaz61PWiw7582GkZEQZHZMumMNsJH2H9TFq1nPmlWbNhfNrL
	gUrMrCdh2828B4Jl6ZLQOUohctUgNXS/8EU2MHlaM0QBYB8i1/WlUgUMTCVV/ZvB
	8a4k6w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0hhdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so1979306a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757989; x=1763362789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLpEAKj005z2AVaIsDA+4OzjbLyJv2txT17XxeH5bAw=;
        b=Iuay4f2KOCO7briXd4wcKw7kNyBRxJT9ilPl/ZI4uxlSE8eTvOQC4WKTNOWzxtEiBT
         rOU4Ft3TL8AIHeyJCxlaFO0FM+VtP9EWtp07LKFLs5G/Tqn/fwGkMQUgQTdrA/8mFMgd
         hvEf7hRw5hXkpXD81hdPwf4Pg8RdWhslb2V04aJPJ89V8JDkBi0uqtOp8H83yV2CxQW8
         Rjko7pr5XXlB920ZRBwaOepd3wKMo35Oud1jPlpfTwGu59MAVZr9zB0AgUAdv6XmSuYP
         YxJaI8LLQUZUr2kpl8mwUhiuftwYkO57ivbWKWypFcJ2tWWwRzWJex+MXXyxPDnMYxap
         BQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757989; x=1763362789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rLpEAKj005z2AVaIsDA+4OzjbLyJv2txT17XxeH5bAw=;
        b=sw5XclWJP2OAVAyaQmpw1UqCresc3rxdfRAcMrP19JOspkXDaio++yoLc17i3SGKjk
         czMOujkbpOE1aP7mvMYKTj0n3v6iYGYU7X4XT4rO4fFdzP3zgJiIh1/TY+XZXfs4QgqB
         Abk8uAS/yFwe/9AaMGvMWqmhKMgS+yB6ehXkinZlZGAi7kRGcTv8kej0MUrg85zQjFKm
         bY0NjRxqjNyW8C/yWYbqCd7zmHV1YqDXFYF+ju7gxA7MHoY8nhw38EDGd9ijGk3jRCvj
         SfzK3h8i32Z7dbuUrwNOF/LGVIIOBowV4iD/dpo8syB35YwQK2d8cJZjPLbTxdHOZHyC
         Kqgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2U2GwGvLtO/TyeroRxagE8ra7+Z7vSH4e/35lGcFROZBEsM0zpV/DG9b+yXegeiB9siOskVcluJqb5Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgDjeCyE/mOzCUsIi20nXHm2RG1gTiQEA0kIxfFZrG4gPJjn7
	6X/CEsErvWw4sBxOvSt2MbhRGluPUDfaKhYXysW56VKfKFrIQKmLEeLP+ylDiwKzqugncIIRYbk
	PNDQPIEYE0dQhjpij9xONkgsqX/zY8x0ESfCOtWQQUUo5BvF2bXNH34aniLvmTNwKGo4=
X-Gm-Gg: ASbGncvWDhQr+eWKku+9zI8YtkaxqPzM5RSzXeC4RZ5glby4UUyE9zfAFwzWzXgCEDl
	CQ7GGUfTPjYUPiWtp8dVPYgRjsSZOqc0LUm+CZ4iP7wgbKFd+jJxV5bgqwpuVSOUEUJ/a3edb5G
	C8yr0R1PxQw7/THwIsgETD77vYTHdPjf635ikZu8aj9ZGDZiFzJkZqbGHVE96PSQ7L3WNj9u1rO
	uNJNgjAZYo4WlQRJJRQnLS3RmYtgLYSmZH3hutxnWCOMAdDAI2nGEfCoWX+PAdMWzuRTOAmTP29
	xJzZcH/clLCGbYkch+YQ6Q/vcM0KTo/zurkoo8Ucj5X8TxKjwOxWmg7pjPK0+gB4inBHXmZDfU7
	lyFPuM2LSCYaLY3Cn61JQ/ernm/kytTVuI5jaKi91yDjYvQ==
X-Received: by 2002:a05:6a20:3d82:b0:351:2c6e:6246 with SMTP id adf61e73a8af0-353a3d56f88mr10141633637.56.1762757988707;
        Sun, 09 Nov 2025 22:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9d1kkatJ20pVQSTVs+EbB1h3xArAS1XPRCq6+wqezpcPrpWDk3hkhBM5GKsQi5YCcod6Ojw==
X-Received: by 2002:a05:6a20:3d82:b0:351:2c6e:6246 with SMTP id adf61e73a8af0-353a3d56f88mr10141607637.56.1762757988234;
        Sun, 09 Nov 2025 22:59:48 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:44 -0800
Subject: [PATCH 5/5] PCI: qcom: Remove DPC Extended Capability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-5-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=1170;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=FEATCEIhTHMz7b3SDtTSGozMG3s3HSCmKvUHkBi8n1w=;
 b=7LHbWxRs1CZJ6up1opRxZmF8nyfMw1R5TXGUaO+VWMOWI9Cdw76BRGYMkj2u2t6JT8UTIFEXQ
 woxRuWtw+t+DQ56tVmZCnsVjxR0YX7zCcTHOEddtozmDDVD+0lkXXrT
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: M7BEc5m5IyyUTPIr0s2DY3CmABEJpCNu
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=69118d65 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LA3sOWcMmZYsM6F2gv0A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: M7BEc5m5IyyUTPIr0s2DY3CmABEJpCNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX2lQKQCInRu+/
 2dOZYRpC93IlQlw7smw59t+6RTjs52UMmKAB9AU/1KBH8VzoeDzafOqo/PXkpkQX/aIs7SUYtIt
 zA1g3k2uqRYLGw5Y3VTdtKNJx0IBW3cBFDz4aa4F2Os8jr3AAwnf/OGTe/nKoKZju6vK+plCR4I
 FTHd5w/9X5VTPlEPnCiPkIJ2NVmMXBUib4YgcKPVbFb/oNvvfp9DDjTdEnC28E0JeajIVpfyyJm
 ghf98+d3AV58JrIU8tDPoAO4bVEOgBf8Ld1Ii5ThXoMdR7MMHUnjbCXfq22mEaClw7HptVDAPKB
 XOJ1wX4LnG673Mq7LVJKJnoBL0n82hDIY3qQMB0wh9ZT0fPn5FqrEXqTnt+8nDO7f+1kydikUEf
 IG0gZPVqq/ekdaqyIG4UL74VMdpDsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059

Some platforms (e.g., X1E80100) expose Downstream Port Containment (DPC)
Extended Capability registers in the PCIe Root Port config space, but do
not fully support it. To prevent undefined behavior and ensure DPC cap is
not visible to PCI framework and users, remove DPC Extended Capability
unconditionally, since there is no qcom platform support DPC till now.

Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 09443ffbb150e9c91bfd3b2adf15286ef2f00a2a..1b0f72bc38d912ab46739aa7f904ceca617c668d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1351,6 +1351,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
+	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
 	qcom_ep_reset_deassert(pcie);
 

-- 
2.34.1


