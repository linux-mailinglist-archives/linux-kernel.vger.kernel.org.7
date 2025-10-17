Return-Path: <linux-kernel+bounces-857977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9145BE8703
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49913AD1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF725B1DA;
	Fri, 17 Oct 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lsmam6MI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E5332EC8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701269; cv=none; b=TctLGWH/uBhluzQUxcxvZp7bgqMgRLXdddWyDSMhBCBwtIjb4Y/gnTqP+Sh0DWlXxTQxe0SfkPoKbLXxRy0afHbPf8GeaGCnwoqN8hDlfFER0JhVayl81JeKtc8xCIVf7eclvjbTdP2eD42skLkhnsUXSiFUs++x9cC5MaZtVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701269; c=relaxed/simple;
	bh=SYQnOLzoc/XQlIR6zJugeR+7h1RDTEhIgsyWh1ZHDpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UX3SsLkoNEWmBFqGhv8lveaRb69UbSKOImufDYTf+rrzKVjDnza5BNBM6arcg+s82HTq9rgbnKU20shqT0de3/qB+hsSCm4A/uNpzEMyP8QLU8b6+wbcXXsQv+2zWxmNNw5IP7kv+LxBFfvwYaa2x9MvASmce7P3fl76CHavmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lsmam6MI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H87blk006284
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BVVLiDkYNXzDn9k+peiV6qbonML0XVUZrJ/W3exuaFs=; b=Lsmam6MISayC59Bq
	7wvRDLxV43rQKidoPOJqd1YVuI4IvUIZfSaSxqODoJQIf3P1eK6miFVmfBhuOdMS
	Yi05h9S4ctd+gADvjdEidF0mGfP6ncJCQsJEtxBfBept764LeUFwh0eM8KGrJK9o
	2TPCfV/ybMYLzu2IdELA8Oos/wcYJEHfjjACREdXu41vwx7CGY4Kiai3DhCKABYk
	Vr4PemiZj2VZfRjRhh4yBogo+NiSzqRU5N/APL/k2P4+6vGaavy85tECtzNCkFjI
	cC5XA56N1JXS7JQWGdhUclZuK4ktRlqInF8LJwlrlVQArz3XPP8Inxf3r+Wi98lk
	VOVijg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwxcw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269880a7bd9so23499285ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701265; x=1761306065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVVLiDkYNXzDn9k+peiV6qbonML0XVUZrJ/W3exuaFs=;
        b=Fg1AHqFi4mKWVfkRDR+aZN8ZiFzZSCyRb/ZL0qV5i0+/sygOclYCBfw8OjtjsYOEed
         ds22ZSd33Pt28h3oxo/+v3chgPy/NvNfyCENqVlTeSm8V3f3jrXxaz+G7QHC5GUeK5qz
         frpZa+1zGpHjl+INrjrPhwbnYwMhOO/PISfAGtd6KG6vRg5pq2UfV0El+0JpQxqzx1Vj
         hewU6OL38hQsk+qJzHRz7XRR0RmdQzTqBwwB74s4OeeUq7Cgp0jU0FzAIBbPSMhRqbdw
         fExiVlpFlFa1SCFk1EQlJAI6WJy1G31ACDjbrjbTEHRp67x0jMvzmUSBRrkPcphj5unV
         Hi9g==
X-Forwarded-Encrypted: i=1; AJvYcCVt8UikTEO52eX9/84ix+1OEkdnbxMmXCEm56KLiAzLUrMSMSB2LrA80bjSjv2fJ81ZQF3KRgr+AB3vqhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiivbVKhXYr8f0FzKC3Jf56GpguyUjJ6fzYlDW4FnmhHuG1wTb
	StSmyjf7SFahqPpCGz4r/wBwJIsDK9VtnpSSdpZswYnp9Q+7pXAfQkoG7vjqDPJkk27zwfNvc/j
	A9zS9/UQYkkCe4s6p5nQtuB6W1i8FcaUpRQupdmf4KoiAcAuRn8a9PKRsfAWxNxhjMww=
X-Gm-Gg: ASbGnctuNsyuHSnLKpus2dnKJitvTXR8q9LbMqjTl7GDxAQ5oqqy3brbX7O0+iTgE6D
	qdrmuRJGNua0uqXGfrNYwiNYBMGJRpWeC5KDHOhTMNeNl8a0kRdPpot0jhwg3qFeN267l90UQv2
	M+DO0Zenkny/WC2AK7cR7hNZi1VhQfN9ZLjumnxkWmJIiMDRiQxgZzcGMAAbb1yDscSFwrXCD9G
	6JJgA9NQWjl94Qqt6nW4r1172nrOduw5jtlyxdQTNFo6fU4iMSTv7zBu6wcQjkbOj5WM143TfHt
	Ak+G0ceMg4jsZvZMIdnlz8QwtBtWOOKtfMqJyhHQCvYTHUx+JMdYas/R548+lELWaFqVgGJsb7N
	RiT7jPFQh4Vhen65YHjiE4aVD7emnkxcyiQ==
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290cba4edf7mr41580335ad.37.1760701265109;
        Fri, 17 Oct 2025 04:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ijODrnEfO8x6cQ5RXjEcoMcy8dr8bkmS1kfEONZv1VUVtXJCoUGK0vbnLyqd6PrGLg4p3g==
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290cba4edf7mr41579885ad.37.1760701264569;
        Fri, 17 Oct 2025 04:41:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de45sm61489675ad.54.2025.10.17.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:41:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 17:10:53 +0530
Subject: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
References: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
In-Reply-To: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760701257; l=3169;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SYQnOLzoc/XQlIR6zJugeR+7h1RDTEhIgsyWh1ZHDpU=;
 b=StbwIRrfzZ1eRAU+lCV0Pa3Kriw8R0MnjcDC+5okRn9gN8BsHhx8yTQp0XQb5/VnZnpHKbDba
 meSn/O+a7EOBaI7jmwK0jsR2dDvyblaGiYdR/N50BRaxGnIqTyRvO3p
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX6vmbnfOedJBN
 4+RI9dkK9eNR882hoiK8NhyQf9Jiz5WnXIFnhB2PRAxOvSZd/lnf4UhG9LKDCxonBgZNwwACTp0
 F0UbEABFgsHgTvXK6uSCVXGbjwhr0UNn1oGSCXiuyRqDs1mnl7dOs8T2sCUsrW8eC0LfjIudise
 JdyajJGXL+qaxQMauaxolFMeZeARS6hiR+odlZ7+cp0IdsW84L3nDpfdprRwtMFSH8NiLvB5g0+
 9clP7BuO1KzifY2Rz6rBqiItZI4m3NPYKxTRQIWyHyXmuR4PALeNalLLLgzAipTXVj4oQ/ruDHb
 IkCLMwamrO+89hhr82PzwGbSssDCkIZ9aFO3eIsqVrjgBx/UJ7UwGL+oqLgdpANQ8wT8P8QnYFG
 GKZCKKGuVhKMG0m6G731ZXtH5PbdeA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f22b52 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-GUID: r_djwYCMWA03PNgEGC3AzckPuoO3AVt0
X-Proofpoint-ORIG-GUID: r_djwYCMWA03PNgEGC3AzckPuoO3AVt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

When the vendor configuration space is 256MB aligned, the DesignWare
PCIe host driver enables ECAM access and sets the DBI base to the start
of the config space. This causes vendor drivers to incorrectly program
iATU regions, as they rely on the DBI address for internal accesses.

To fix this, avoid overwriting the DBI base when ECAM is enabled.
Instead, introduce a custom ECAM PCI ops implementation that accesses
the DBI region directly for bus 0 and uses ECAM for other buses.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Ron Economos <re@w6rz.net>
Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -23,6 +23,7 @@
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
+static struct pci_ops dw_pcie_ecam_ops;
 static struct pci_ops dw_child_pcie_ops;
 
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
@@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
 	if (IS_ERR(pp->cfg))
 		return PTR_ERR(pp->cfg);
 
-	pci->dbi_base = pp->cfg->win;
-	pci->dbi_phys_addr = res->start;
-
 	return 0;
 }
 
@@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 		if (ret)
 			return ret;
 
-		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->ops = &dw_pcie_ecam_ops;
 		pp->bridge->sysdata = pp->cfg;
 		pp->cfg->priv = pp;
 	} else {
@@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct dw_pcie_rp *pp = cfg->priv;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	unsigned int busn = bus->number;
+
+	if (busn > 0)
+		return pci_ecam_map_bus(bus, devfn, where);
+
+	if (PCI_SLOT(devfn) > 0)
+		return NULL;
+
+	return pci->dbi_base + where;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
 };
 
+static struct pci_ops dw_pcie_ecam_ops = {
+	.map_bus = dw_pcie_ecam_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

-- 
2.34.1


