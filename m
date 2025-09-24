Return-Path: <linux-kernel+bounces-829916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09003B9830A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1377919C8A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FA23506F;
	Wed, 24 Sep 2025 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YC3bdMsB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA01FFC48
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687534; cv=none; b=sy8MWqUBsBkL0RAJPLmZJ1RjE+wc/kUtBbEYvQZyvJnAPpjclypC91oshgBKI7y8za02WFeM+7Eq6WvXN+WblXmfYlb4UZVDl1WzZf1032PAXvM2OrlVxiCsmQPKXAjUTgo+eRjESA8eXeF1xvrYKMZ9JVJIVm6Yn0GGj7wn2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687534; c=relaxed/simple;
	bh=vAOxkekAq0XAFtf1iF/yTz+5EAkazBCOXOBpHqiMo4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldQEpDnw7NEVqROsUnr3pWLr/g9heFB/dH3zzK1f+b0bCK1PTned/Hendg+M1WDvK+sdO3ZNdPfGDuq2/DWFaw0yKmDR1spg9paFfLMwIH2Ij48trcauUjfMw6FC7Ui7PfjlgRvh/QCJHRr6DzT6QbpSjX5Du7sjT+IAM15bAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YC3bdMsB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O0ogEw020615
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YFYJHXelKWltng43munPOk4MoakVnMECkySEDXZBqvc=; b=YC3bdMsB48lmVcRi
	vZ+ngSzTmbmiiEIpsBIyM8/3/nb/BN1Fx64/mz16nC1m2CkIh6bJiVlLyvMyCsSr
	9Z/R8HplBm5ljxF0Vd8PHcTUdrJGqiUsSUy70D3n9r635HegQdwaFjHpYVEEVTrU
	LCFk2peY4/8ZLI1DbgeQHVjUnGtnO04LgsQyrTyDcEKrNsSjrs4Kwb/l8/heiheC
	lmOMginlnjC/au7CwXXNtsQeL02TvosjlUQ40CkG7U3TfCL+d+jrhn4LSlx2xAZn
	h0uc7atNeRADtSg25ta/Rdbu+khH/kKsVepFheO5+aneT0q1XwKjemMyMCb+c+MC
	rZF1jg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjvae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:18:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269a2b255aaso109200605ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758687531; x=1759292331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFYJHXelKWltng43munPOk4MoakVnMECkySEDXZBqvc=;
        b=l2Zne3G1MW9EibCQcA2cfPb66Zj43h6Z9O/tkij/snIREh9USHUEk87ZPFg211PhKh
         gEXspaQW2NokaMDEfs+gAnZWMEfX4R6xrIe2n444yhG3SNpsFR4w+TZ7v1iH1RGm0OqD
         Lgs2vfvXTXRJ2C5vdXvj5oPShGPKLZjHlfEP0P/PIPQ4eUT18qZKoCv/IC2brVoR3Bv2
         tU1ImgoXrriks3cuyAr9zZosKMIpEz/VR53nUKqmxiXA3JmLB+B20TrstW0RFqU+Rksf
         xGmNgHE708eA3uWlsDTm+8Wpclv9ALEklKELQUvdoLJQGtWvgAR5X3bjLoGqHEEQDkv0
         XT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0A9rQQ+rjuXRKsgQY9O8NpE8B/4Kx1PgLppKTjV464tbBvjtqtS+ITuF5fC/fTu4C0I4HKCFrinYCRtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+B+RVQVR7fdYqEU3Bu7zwtU2xjYgsC8yYQltBW26BV+SqXiS
	5mmRXbCxcDq8AvqQsRjtd1UxTaunkerM53q6L9SD34TgKj7RDX8+C85wHBdAzBksgrPg2PCqK5i
	62m6ft6iS2SoCP8zf1cdyJCUnaueijsTjRF6ezQIEMyKhkd52giKmIjADNCERoSKFUIO7uYlLqb
	c=
X-Gm-Gg: ASbGncvl/VL5wL053SnvFrHoCONFsmWwISC3OJ9/xjqjl72ZZ4bOwHG9SPG1jenZIct
	v4NejesbZ2FTtUgKjji5XIMkRLIODGKrHNXSEMaf0RbKhf4fhoKDa0hwuNt4ghtlroHUpAXXyp7
	5FLK+Jnrv8UJxes93pyzg8ILKmVxPgxOaPBmDY4KTxP7FayHN9XLriFCr+oGFjF9SJKtUYFKn6b
	a/1hh8buOYq3ZjJEOYHi3RWijkX2aN5axsvY54pLwEu8cclptQZe7/cmT6TkYvistl26qWBigXD
	9c2rw2T0cX8XeEddmdfUKn+Etn9g+9fi4FCGNva7QzRTce1RFmI+s82qPM/EeQjabR4WQE3x/TV
	V8rk76CsUGzramXM=
X-Received: by 2002:a17:903:249:b0:24b:4a9a:703a with SMTP id d9443c01a7336-27cc2008bd1mr66566205ad.17.1758687530978;
        Tue, 23 Sep 2025 21:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6we6xqyGamppkrAtUGaZGv5vNEE/nzDTz/IbJ8bP6q0yQQhcoqovlEEQy0ile8G16PKGedw==
X-Received: by 2002:a17:903:249:b0:24b:4a9a:703a with SMTP id d9443c01a7336-27cc2008bd1mr66565865ad.17.1758687530536;
        Tue, 23 Sep 2025 21:18:50 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2699363989fsm170133885ad.92.2025.09.23.21.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 21:18:50 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 21:18:42 -0700
Subject: [PATCH 1/2] soc: qcom: smp2p: Add irqchip state support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-smp2p-v1-1-2c045af73dac@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
In-Reply-To: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758687528; l=3139;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=UxXoglLSEU+DZqiS+nYN9aP1Dukcd8ZvovND3Gth7mk=;
 b=gD4YKQ/PoN/J7TAsa3IxwX85M4PllJqi76mGEMMOgvBFYMvlUOhXAjUd6Cl91ouUvtGfjzSRP
 fK65kK+oT7jDuvPuYWfmocgE1rRT22El3PzE5FZMQeKUKlIFjxgm28r
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: 11I5nLRYDVvMPfDVC7Ctw1ck9H-enOqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX0x7M4I05YKdV
 rPibOLgiBbXeH3//ZG5xLfcsho796s43to3c5rXor4SpxTIFIWXCvTVgToin/eYzXY9foj4XQeM
 GML8994JXJH0OBBP83qZZTgTBz6bCdPk/t7ASNzWSuF6bCHSqpwJZly+nR8xoTjeUBPPT5CJSlq
 sJJnZDfUC9CdCmyo7EdsPhcAQi7iA78vzAaaZBGVuTFQxyJONA8r1uj87jgNqfuBi6N2HIS5f4J
 hVZNV2JSxNdnkkSY2bkv3dCJ4BXjFplpyhZLQBhUOx0n+XxWFWd3MD8Jryf0rxU3k20Op7X4ftN
 Vf4tWqtqCx9sG4REfYn2prypmk66nwtaLSQ7irNZe3JMlwNDFURzzeman+ic76fqi2ZOtU1OCaO
 L8Uj0hv0
X-Proofpoint-GUID: 11I5nLRYDVvMPfDVC7Ctw1ck9H-enOqO
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d3712c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Ht6YvOiLTg5Y4LB-hcAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Chris Lew <chris.lew@oss.qualcomm.com>

A remoteproc booted during earlier boot stages such as UEFI or the
bootloader, may need to be attached to without restarting the remoteproc
hardware. To do this the remoteproc will need to check the ready and
handover states in smp2p without an interrupt notification.

Add support for the .irq_get_irqchip_state callback so remoteproc can
read the current state of the fatal, ready and handover bits.

Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/soc/qcom/smp2p.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index cb515c2340c1..e2cfd9ec8875 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -222,6 +222,39 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
 	}
 }
 
+static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
+{
+	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
+	unsigned int pid = smp2p->remote_pid;
+	char buf[SMP2P_MAX_ENTRY_NAME];
+	struct smp2p_smem_item *in;
+	struct smp2p_entry *entry;
+	size_t size;
+	int i;
+
+	in = qcom_smem_get(pid, smem_id, &size);
+	if (IS_ERR(in))
+		return;
+
+	smp2p->in = in;
+
+	/* Check if version is initialized and set to v2 */
+	if (in->version == 0)
+		return;
+
+	for (i = smp2p->valid_entries; i < in->valid_entries; i++) {
+		list_for_each_entry(entry, &smp2p->inbound, node) {
+			memcpy(buf, in->entries[i].name, sizeof(buf));
+			if (!strcmp(buf, entry->name)) {
+				entry->value = &in->entries[i].value;
+				entry->last_value = readl(entry->value);
+				break;
+			}
+		}
+	}
+	smp2p->valid_entries = i;
+}
+
 static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 {
 	struct smp2p_smem_item *in;
@@ -368,12 +401,31 @@ static void smp2p_irq_print_chip(struct irq_data *irqd, struct seq_file *p)
 	seq_printf(p, "%8s", dev_name(entry->smp2p->dev));
 }
 
+static int smp2p_irq_get_irqchip_state(struct irq_data *irqd, enum irqchip_irq_state which,
+				       bool *state)
+{
+	struct smp2p_entry *entry = irq_data_get_irq_chip_data(irqd);
+	u32 val;
+
+	if (which != IRQCHIP_STATE_LINE_LEVEL)
+		return -EINVAL;
+
+	if (!entry->value)
+		return -ENODEV;
+
+	val = readl(entry->value);
+	*state = !!(val & BIT(irqd_to_hwirq(irqd)));
+
+	return 0;
+}
+
 static struct irq_chip smp2p_irq_chip = {
 	.name           = "smp2p",
 	.irq_mask       = smp2p_mask_irq,
 	.irq_unmask     = smp2p_unmask_irq,
 	.irq_set_type	= smp2p_set_irq_type,
 	.irq_print_chip = smp2p_irq_print_chip,
+	.irq_get_irqchip_state = smp2p_irq_get_irqchip_state,
 };
 
 static int smp2p_irq_map(struct irq_domain *d,
@@ -618,6 +670,9 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Check inbound entries in the case of early boot processor */
+	qcom_smp2p_start_in(smp2p);
+
 	/* Kick the outgoing edge after allocating entries */
 	qcom_smp2p_kick(smp2p);
 

-- 
2.25.1


