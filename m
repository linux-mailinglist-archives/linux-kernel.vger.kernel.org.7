Return-Path: <linux-kernel+bounces-880041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF4C24B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B286347D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125D346FA5;
	Fri, 31 Oct 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3Fkzy15";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BTGGtahD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95A34677B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909149; cv=none; b=rcJLx28H6/ll+TQwBG8qHhf4phud85hcynMK/fK5EeUbYhsKAozM7FT40EhC5Om/PMysdo4v1HJyOqkCr3hGPTwk597Qw1kE1KQ0gOuAltFyD63M/0TdKfVurrD28JPkIwSnzVHWcqfq+e6k+LAKxhnfTjJXzNSONhDVU5UIfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909149; c=relaxed/simple;
	bh=Cpg3+E+77cgaN8CmBzJQTZxMkFdRoEwVVkKgFdeA8+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8Quie52qQQNXJRVfLNaEsUpoJ5s6KQe9UGqz3+nrmGXxcCaoDe0FZLO2HNjN5ZP9pgSgEFJP93xmzZdPpeVk3dZFaC0UqAY9F3Y//iIoYhSbm+ehraKwqh3rmqONy3XlF3I1bAWhZUAV+iMnUDo+jI4j+cbdjzQuraGh77Zs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3Fkzy15; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BTGGtahD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V6SGwq3116501
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=; b=l3Fkzy15ESuU4uR7
	Cgfs8CSukRFuCmycic/BfGA1Srr9AIIvLYW+vabob1MrZTOSdEkhS0ZsaYbltDJP
	8p5+TUo79WNasulbvmoBYhETNE0KINz/q85DqRGvCKQt3QpF2OYvKT/iZ+72SFPC
	7kbzALVNonYZRmXmPSKZSkrfDKvAsTnx/5m/p9OhkkmA26JGEW2ZGGEV2y5an0oh
	YxF++wS7AzXjwUJrPN0LTfkD0dRI1LytLInF0FCDUUSVMKGl1mllkS6O+tn+srvm
	lZKj5EgYB5wBzHpXMxBG74GBndeMSQXBTrVm1OZR68SZWJuvo8AtM7V/HibBkyui
	c2ourw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b43y41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1657473a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909145; x=1762513945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=;
        b=BTGGtahDVgJ+MZ38Ygy+YMRCIDGSylZVblonq/9c5vJuv7TAI2UkAVB2zOU69rwqMz
         NaCJN4ol/yOQr2B7ruZhZ/ofHYUEsgDFJf6g8J5LswZhf3KToKOMZg91YBpYYbOYoCwJ
         YVTP7vk3xU3lIzhodn2xz6r4eGg9zvNIHk11ZMoMh0EXqQ4LkUq6LV6mzWPQgLx8RKg2
         HGGnkj37/sc54EPy68T0CY9VDW2nTdSDfU7K4M1xj5ORqVCT6khEQNyS/1V6GSaSXgv9
         n+l8yPD/7Rquwti/WfbDeXFqBaoy4h+5pm7gVKZbvwXEWnU/VeX7OyPFsfqksVxlJmTG
         gv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909145; x=1762513945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=;
        b=EM3UsVbsE9BvYG9L7EMiTFLrdVX+nSshm0E5aAxjw1ebtG7+u9Zik5X5D/bvmQqda5
         8sY9B0G5nP0hA3P+S1jFSwh/Jyaj4UlRMTUnCYnT0CMdewcjG9mAxRA78aylJuLKZg+T
         PK0LtkjcYP3tVTgx9z2tWnxiNqyF/yLzz46qnYi3hCUs1imYyyJVqhzAzdEB31j1POVy
         sdkrNn4+UhxYqAtnXkEACksp0y3Nfk0bZI4EN3UzAysLLKcONGu0qymMfY+iphUyGfDW
         gmrfQYHQmUrM4NetXa65FeezlfekEAnuSoff2Zl2HvYEs4jI1aK+awjd8lf1R8n65Gor
         elZA==
X-Forwarded-Encrypted: i=1; AJvYcCWYHLpiFxro4eEpWIgwoeyBNIqQ9xmttd8qSH69WJ41hgx6w9RdoR8dML62sn0acfSE5fJgyM5YtaoTso0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaia/PC5A4DFoiiGMkEAGy/U4c7BkYSEURHldXMlPJZyi5FH/8
	hT+j8sZfEwAc5tys7n29Zz8/+O5kQvzC0LqQJxMIgTWS9zPo1DndzqcFC6GGMjQq/iSFYN80gxq
	Cb55+O8cLI9/Kl+0LZcIOkMxnrUbZByTwJQ3P4YDY936xUnZT4HvoFmYuD44/gawnEFg=
X-Gm-Gg: ASbGncvL2d9+Yr7BmdVHeZd6qxN/qtLLZaKoJPa7+9u/THOX3J8mGTqJssIUU4cw8cV
	ielH9qTwjHXAZrltaebi/mA30tIxf0kTafC3LVY0ITRSMAs4QRrJwNpOHChEdOCReEP6Lv7AwHg
	chdZtZzPg3PT3DdQhLKlqw2ZJC2x89jMa4mA0/PIorfHpZcepYP7l+Gm6a5IMef7NBdSU3+8FG9
	1r7mLK6Obdlp2hvUyHxRk2UQzCFDMUOzMj0qH7xqxoxqMbvyDVULVHZ29/aTJ71PLIwyfMcjgfl
	9Kmv7MB38N8MUi6uJeq7QjskxO3jwWwSitgZDUBYE2tri+RHgN0oxEob5/BQfX4MKQr0H6MpOJG
	9L4+0QKech60xAuFL6QYdf26zWSrRv8CmYg==
X-Received: by 2002:a17:90a:dfc8:b0:33b:bf8d:616f with SMTP id 98e67ed59e1d1-34083055a66mr4429859a91.20.1761909145264;
        Fri, 31 Oct 2025 04:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ST7ootNOsSdE4YhU21tYljL3YrKuXc3saWzAqhR06PAK+Ghh+MoVC+hiJ9vhboqoewtliw==
X-Received: by 2002:a17:90a:dfc8:b0:33b:bf8d:616f with SMTP id 98e67ed59e1d1-34083055a66mr4429812a91.20.1761909144819;
        Fri, 31 Oct 2025 04:12:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:42:01 +0530
Subject: [PATCH v8 4/7] PCI: dwc: Implement .assert_perst() hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-4-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1221;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Cpg3+E+77cgaN8CmBzJQTZxMkFdRoEwVVkKgFdeA8+8=;
 b=A2apmLQWjrpCddCAoBMYspOGbY1QIo0TDIIU1w1angVGKY6uhitwrodwrhHFadFXP76rvNBG9
 lF0Z9T/66d/CNKEsVM2Flb0Jry7Ll4C5n6750sqoZXiAgJw3h21j3OJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX67His0loA7We
 XvmsWNM30b3Rq2/qZ+4XMn1Zj3MElbKy3NyuLX1TejGH92Q+mS7VFw/c5xByPNUTVCS2LzTgHgn
 pO8Dddt/rF3BNQ3kaB2gTl3ENhLfNXVdl2Sl0yx8OWAToTKRoJeLTczvxqyh4hunVERax2TZFn/
 6IrNdWfmHZ7jdTlThWrJA41y0O13kK4xBo04hoSw3kLHp+7Adau8NrckpPukihTKEbYDUL3FLPa
 ZCoWLGja5+O6Ay8UnaUM3yNTECWLVvuKWhkZmOpugwQ5lejZLEAX3wcxZWcR9W1dIyZtHlzXJM9
 fyl0FvbyXcjZS59+6OsDT4Z44t7YVgiYZwreGuMHUUxpi8GUhIxqqys/rmk0hpnt5LkS89C4bSn
 iy47jLBj+VKRjfGEkRxlPpTv6rnCVA==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6904999a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dSOQ3hK3KXaY1HoqDbQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: P1HNoaG0gBjh6xE5NYl1EoAhquPfnjjj
X-Proofpoint-GUID: P1HNoaG0gBjh6xE5NYl1EoAhquPfnjjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

Implement assert_perst() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..b56dd1d51fa4f03931942dc9da649bef8859f192 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -842,10 +842,19 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_op_assert_perst(struct pci_bus *bus, bool assert)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_assert_perst(pci, assert);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.assert_perst = dw_pcie_op_assert_perst,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


