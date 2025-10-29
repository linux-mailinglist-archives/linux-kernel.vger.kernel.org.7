Return-Path: <linux-kernel+bounces-875895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CEC1A0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E09188B2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092E337BAB;
	Wed, 29 Oct 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQPSGRmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuoogLxP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8323339B3C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737428; cv=none; b=F+1ZAAtLvsygXQ8kkZ7K0vde4Meu7Bt5dA3TMvhuxtJrlrV6y4CMNX/1wDQ0y+Sql7W1Z75CGxJZUA3Y/0BrPHOYYXZsl7hsik/ruIKIe1FULcHzaZO11UMF4c6ddah9VgEQnkbMEQVeoWhJNTP0u9PWro5svIjTtiyY6fTErW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737428; c=relaxed/simple;
	bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itHXtpGyO7RXxDFHHUOVirCcBy44YnTnPEQhsi5bjBJv04mq3WlvYgoHe0ESnEzU6nZVaZNT/G6pesjswfmGhl4oUOCMyPHY8T9+1dUIHG5QuFSmxA4cftxUvCE0cTADNcVDSsXNqTl5ckom2jGrRdMr9x8T+awExvN8Ky0SUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQPSGRmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MuoogLxP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uxp63663636
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=; b=DQPSGRmG3c/8SrOx
	hqpZ7nzbpvZcXxVBCYDkX3lp0iIynf0YJ9jSm2popx9x/W2tIqNQLHpxNPNNy1kK
	nNXc5052y/Gu8yuHi10pM8X6E7LZhTPwyQ+5VFwbLI0CBrrONyfNX81getHpm7US
	VuK/wBbeS8pTk5KLwwETTR9ehtp00ad9dWIFLbZbeTmHszY+SqikC8Nvo+Nwkf2q
	JemCs8bbbRv78vexmxtUagVKMYfiE43bA+dCmEkp17+xxHQTHANjVt/LoX0BP/+y
	lx1+JviLcikFwqN7TLY1RRjjgbFsU7+0wyyVtgyNNovzwP2pLev0RwWjO0hWVXTb
	R3LRRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1ta91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290d860acbcso149325945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737425; x=1762342225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=MuoogLxP0jwPgrfgZbS1rM3AJmHkpztO8NNqkVpi8sbKeDrce3y1XuBSOnoX9GoycK
         tWOtQcfsIS4og4CCzVwQHonQoyY1XntOrGtJ/qW7RLQic9Ieb6OHleW1ktqql121djAo
         xOQZEXtKXVetOHmeqhv1DJlK5HxWahwcnXyevsmc/DUiKQK1qo3KVOY6BiPi5Quf3cHy
         rchl5inVBS3mttB7/paW1xXTBpYJIAzb4KY1Zdj+YCOLzaX69Ta/7e9D/JM+ZNgDAwUO
         YuLFqPUNp9I2SadKspKO2siSgv1FB2YTErmEov1DfbDqhhu1x+TCRfnwoPAeuExwoPKk
         k9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737425; x=1762342225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=XbteXwOj5P9BNEdsybwsNPSfm6Fx3dxprntPvOm4RMoPl2yEO5dCH6lydqN8mL4VKW
         VW+DRAxPan6+kdZliyKPj6HnsdWM7FrQKVD5N10cCKvVEwpfUtrdudpeSJfUI4Bx9cVt
         C/Qph9NauOcw1it+azBjxnpU4AxPnRsNle/oOqj1R5mbQugZnKhWumCzfvVIz+Qgb4/J
         pwNw5nlHiei61y7L2/9tUye7TMJ4jfHiHvoaesEgMkxL38k1h44nAW1NBZ17aAle7g18
         m/lGctjOdBB9KKJFSbyMvOvHVAA6EkeeyBvz83j9+fL7x25irZH2qCDxMDk1+neJu9py
         iZpg==
X-Forwarded-Encrypted: i=1; AJvYcCUQfpnDsnmeXlOBMV/H5f2mdnD8cPZwIX/IiLunttx/TKL9WNE80CekBN+y+Qv0JIAaAJty6q+bfzoESe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0BJ+WsO6PinephF9owBjOtxZ4glbzUFl2ZI6ucsx9n+UnWfg
	hGqJOxMxd8O7L1jTG2pMS2WQaeGNlT1NizkHeF+x1ER5ZdNWU2jsma4dEp+MauBbjJPRRBhUdB/
	+0m9Q3eE7ikmcg6eF0Y9d+Vsyn1wSJLe6BEPw6/Jang99CagMVyiazv/kS3QFA7/S7ho=
X-Gm-Gg: ASbGnctXXeVtzA8wWwwolP9XEktoLhCjy4xQ/x9OHRkrJOuB7H5xB6WjXScWuhDE2d0
	1I5VyU66vlhAoHNCUhJ89eJ8TMxc6mlvTE+MiQ425Xh0/MMJf1u0F7Ri4bHFdCBDb3Iu+N7MQDp
	j0dxBQJiheDVwiyppSaFD9yZsDVGrisuBJApGUiGZsmxget2LqkvyL/kYhpnBexwIv2tg0w8M0/
	BX+J70I6SZVEMQYLr6Xornrg197YFOnGglNkUTtFbc6M4VVvD379LFgW94FbIVdOBxrNekvoD7m
	rPCOzScVpoAGi/+XaqCDtVo7Rqwi4/5UIo5tnyZfjRYMHfGZQQhj9FlxBwpHecLl5mAJpDp/ow3
	L9AuV9KqBvPic7+9NamMI4HGksUUILJmK+A==
X-Received: by 2002:a17:902:cecb:b0:267:ed5e:c902 with SMTP id d9443c01a7336-294dedf64cbmr40460905ad.20.1761737425069;
        Wed, 29 Oct 2025 04:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIfsHVKEWsWz2BHUSJeZ10JbEH9dJ62Uke5+/3SiZnq91/wZtwSuoAq+jP/ohaK8whQGV3UA==
X-Received: by 2002:a17:902:cecb:b0:267:ed5e:c902 with SMTP id d9443c01a7336-294dedf64cbmr40460225ad.20.1761737424487;
        Wed, 29 Oct 2025 04:30:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:59:56 +0530
Subject: [PATCH v7 3/8] PCI: Add assert_perst() operation to control PCIe
 PERST#
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-3-68426de5844a@oss.qualcomm.com>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=1537;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
 b=Wn2wemwGSrMgNe5eofO27eQXZ77sOUAVyX9DJBD9M17t//dwyKWk4QUnx8EayalfEjFvvcFE0
 tBAHEzTYMVqBRoueX/dG+9i/X6PIb8NzwikYAt6G/sCsf1iLvVEfEL1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: T_NAZtae9gnfeijjKCAbJUcAh92xrG67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfXz9yNTTaFJO0R
 9Bvfd6H+ckl9EdWYMtCmsDAMrJRAvqD2/69QU24EBpVMy3kKDkT+xwrW9APPifKhdLcGolwHS+o
 UuAvTS3AWPlPKWiOCCZ6AKWcUD9r3kSBh1INpYkEsHXhkJbSL4JA1h1fK0mmOGskSyqfOTKKCsA
 VXsrCrXH6B7sX440LCWOjlFO5/+XTlvbzS8t4pRDHL6TxSU0e4xdGoXLvAwpc46JkrGrZWGwkac
 ge+jnaC2PhGu+kWCzvHmGlIEerFCBfVsLfBsSXW8eWAqUmnUwxhLuOGOEAs8sZQw+H29Yz7vvWc
 oEOq2Iw6TOpUDCX+jmgqzLvbL/2fMI/TOyC1GUQ63Bqip6ppft6XSQVxQ/xYaFwgmh1yoZV922r
 PfmHHBVOBzvzuOpxGsmahmXGv4mxyw==
X-Proofpoint-ORIG-GUID: T_NAZtae9gnfeijjKCAbJUcAh92xrG67
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901fad1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

Controller driver probes firsts, enables link training and scans the
bus. When the PCI bridge is found, its child DT nodes will be scanned
and pwrctrl devices will be created if needed. By the time pwrctrl
driver probe gets called link training is already enabled by controller
driver.

Certain devices like TC956x which uses PCI pwrctl framework needs to
configure the device before PCI link is up.

As the controller driver already enables link training as part of
its probe, the moment device is powered on, controller and device
participates in the link training and link can come up immediately
and may not have time to configure the device.

So we need to stop the link training by using assert_perst() by asserting
the PERST# and de-assert the PERST# after device is configured.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..ed5dac663e96e3a6ad2edffffc9fa8b348d0a677 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -829,6 +829,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*assert_perst)(struct pci_bus *bus, bool assert);
 };
 
 /*

-- 
2.34.1


