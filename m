Return-Path: <linux-kernel+bounces-730620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9414B0470F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB033BC8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D8726B775;
	Mon, 14 Jul 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HF+RSwUp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92F26A0F3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516093; cv=none; b=Iho6QjL3WO0XFEvkbQpp97QzSLmT1cf0NKPXMEzzP9ob5BsL0DQCnDSqlgMvaiV9kelpCn6ngrCFR2Cg9YDjZsFYYRUgtm9ODTJmtj4jLYWDMdk8UECFlmMyLqaiAROJo9zr8OV6caXvNJcqhYXG7WcRfgkL25Gd55DKPgrq8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516093; c=relaxed/simple;
	bh=yYfHim4ZDFsrzpHA8cLfOnvj8+CGJU7yGqRzG3SbZzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEBtVv030nVEPMLS5gJK/MuEkq19kHgyQXtHNg4X7RgqXk2f2B6yVlG20W+RW0Aupm2bQS5Bzw1WTlKtyyn062o74r5setLVAQNQtfZ3KYlF6qEPtMUL9w8VVlsoCnFP9DJZsSIz0JwuG+XBgFVNDtVn/LOc9gXDFIjkJyiox+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HF+RSwUp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGGkYR005616
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5ZBXTqzHXuAvDGIfilsaUyxXa/bYRbG9rx5ykQkTbM=; b=HF+RSwUp/EgXlHd9
	gyyTeKNzuTRGgR0oHINPP9k7S6F3ECx30/ImVYKxKwLSd5wIF4eKvb22PT+MnsFQ
	OyBl7TZ+F8pK48/6ft18wwCV5q5XFWx+3JPcvlRDRRI/DBUX4qaPj4znoO+uiAyf
	aoHK/lZvSjl81rsyXqp36icQdq4sgJFJdG+wsseRQ/c88N6DHgQsxct8cpRuGowu
	cmssQU07Uu3teZLew6P1PQtW1UhbLijuRW5agtSE4XX/8Xpzx8xPRK964AHmhoJF
	Ns7uDjVjhYttRR+IMVRZs5JzwnNEd1z07msJSKUXnA9Yc9lmwZTpdpbeHwA/ZVaM
	LIa8jA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58yga1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:01:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab5f8c7bf5so47075821cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516090; x=1753120890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5ZBXTqzHXuAvDGIfilsaUyxXa/bYRbG9rx5ykQkTbM=;
        b=g++1X+0SGZiPcocL5cNkXkWRrVNKU122QLa6HxiZy+E7a/cBY8ydT8BuvCoRTGRTLX
         mbhSrfjDrpFlWmLLV9+djkOapzkzV5RBcli6QGYOMTqigv8cma8Sm0H3gqvKZvhHm+zF
         CcJX5/fRS3kG7MagvHF8otzO3Sqf446FizA/mBrWAE1ijBJQIIDmdJeUQakbjl5Xd1N2
         tsJ/xvN6h6T96UjH1lGRa5UEJSayq+jeDMvdUYN4k/GkCTcVvuxRkFH/TD6TMlV1dxwa
         KDcB9vjDrQq1CJHdkzwv9i7VlCV+meAdALiOpmk+eILfaO1K5SyepAsrFhJkIOEcGl37
         1K3A==
X-Forwarded-Encrypted: i=1; AJvYcCUlepI24UTIR8pm1ZjaHWH7qq0FwEhOoVcxStsuUUEIFIZ/B0jA0i/KLXjiGRV/OKzFx6Pn7WaOCV0Fqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylj3Q3Zhe8KY6hlf/GU6lF22N9q0m92VZVPRpDGT+0rzrYNEoO
	FPCu8m6mxTWSFIwX8110wAZOX96qk7PECGeJGkaS/4RsAgmhWAiq8CJTkyu2QTrnC8vwFaqQNez
	g1UTs16mYvcQzoW8Hd+IPa47Y0Hqe98CqpRCvLNF+ydTThkROhcBO4OBAIBwUoZse2T8=
X-Gm-Gg: ASbGnctWRGaeWnsfIwLDeCbgSgSWT1Ma3XRj/uvZESnQLpg6TXrbKKKPcvq9rjbzQw1
	gG2bv98fR2lS6wa4Y6t6/X+7rtNZnRZt4hIcaQf99k1hQPXv4/kl+6i7Jj9CH4JqBe3zvH0SRDV
	yDqWL0xdZefSbBKWXerRALUXubKjSgy4kLw9LbnivKGKPtJKenaXge0+cmHijkIy4GNPFsT6ko2
	Gu+MiiVxc73r0Iz/m2QatT6fc1Fii0BuxQdrbMtW8TolKOBuO7IAe4ymXKyQOHDWK3A4ZxpPda4
	TMzgA4wm4WplXyxCBc1FXXlEe9dBiYtW+CiX+qryODiFR+TtNtS6iCjPjmbrgVejEZ0=
X-Received: by 2002:ac8:59d5:0:b0:4a4:3147:41d6 with SMTP id d75a77b69052e-4aa35ca9258mr223138701cf.15.1752516090051;
        Mon, 14 Jul 2025 11:01:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6b0MscWvlE92Cx4CvPn9GtRvi5uuB/soRmkMj+d2LknE/jSNBX63NnRPdRCVgx58ZHm0dOQ==
X-Received: by 2002:ac8:59d5:0:b0:4a4:3147:41d6 with SMTP id d75a77b69052e-4aa35ca9258mr223138121cf.15.1752516089476;
        Mon, 14 Jul 2025 11:01:29 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.67.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab659238a1sm16999381cf.17.2025.07.14.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:01:28 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 23:31:05 +0530
Subject: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to notifier
 callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
In-Reply-To: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=yYfHim4ZDFsrzpHA8cLfOnvj8+CGJU7yGqRzG3SbZzk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBodUXrO3trMEg0+C+vhl63y9bSQVTvQNfatUqV/
 rJgpFgFBx+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHVF6wAKCRBVnxHm/pHO
 9VnuB/47R1Dng3M1Ke4uwnMr0UQjqG3/ZNtbTVSJYxDpdS2wzb2CVQ+q6TouVKl/a61XG4nsJ6e
 T2oNSkjXVsyKJM+uztQHO2AWQsUYXbASssBrsGW7UA3SzUhShsraVkdCNT3xhqmjovjjzyvkhNx
 Eu2iT2PjZoZ4haWGAtlTssdd1hrTSJMboaZJDjYxg+8d2tppPQsAKeK6OxxGlVGr6944XwlMPHy
 6jBNSR9zl89jTMNR61WXou9UKyNiTuZXuQJm+6RFOYLm9gQdAW1MErD4B+Ah4gJfhgnUg2sFyog
 axxNQORipXla0p65sa1aSwcNGyK0ap9RdpsU3xNUZu0qqUu3
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExNCBTYWx0ZWRfX7hrN8TZ5HSN6
 OFMKi9APwjt0b7vDrfZtuSkHTHjSRWmqZ2Zw3TFD4Sfr6b7GMTSY+ai9RF5rrnO0FOaOD1qp+5m
 XPVc1gjblXTBxP+RlvhU53dm5S7YmMF7dTf4UhfcziaRhlnzamHGtVi9z64FkcwvDBhIE8SPi6S
 yiNNH8J6a8oO23dXGM1x09XNsDwbv5rAkGAgHwXuyLbwN909e4I27musxZ19x4sV/wn1QshsnC7
 OmsUlVdLeReMJDRvAMpAenn5WmxmRInRaWtqzm9pXPFvsw7mWD7pkWOY3OTafSjs4M9ll8T6UkV
 +xCs4LruuKBxCWbZFHFN41AWFrO2OOt0m830AVjASbAy/xh+3zyxnHs2FvyVGeTJ5brtTOY8EE6
 VdnGXEk9D8+MA73CEELKLYVx5JyZhAkmI5lpWqmr2tl+SYbICzNALBqV1rojLlqkEaZbFV/O
X-Proofpoint-GUID: hiG9h79_lPn2VWkuFvgzjB0zPv7a5NU-
X-Proofpoint-ORIG-GUID: hiG9h79_lPn2VWkuFvgzjB0zPv7a5NU-
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=687545fb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=fXYZ39HhpiwvwaHYBd8ing==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0RnmVqfoT97TjDMFmf8A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=823 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140114

It allows us to group all the settings that need to be done when a PCI
device is attached to the bus in a single place.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
 		pci_unlock_rescan_remove();
-
-		qcom_pcie_icc_opp_update(pcie);
 	} else {
 		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
 			      status);
@@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
 	switch (action) {
 	case BUS_NOTIFY_BIND_DRIVER:
 		qcom_pcie_enable_aspm(pdev);
+		qcom_pcie_icc_opp_update(pcie);
 		break;
 	}
 

-- 
2.45.2


