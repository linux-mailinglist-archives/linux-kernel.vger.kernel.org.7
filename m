Return-Path: <linux-kernel+bounces-887997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E38C39894
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1E4F3B53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B6301003;
	Thu,  6 Nov 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHM7n0kb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUJBmNyg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439E3009E4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416622; cv=none; b=YKUOlcAKpza/EcJiQJp1adJIxaZ3a3QPZiX5oI54haXgzM1nKSTYHEyYh/IY2buROR1V22Oy6gD+oSoJaCo69osyzZP6uf+DHIB6fahaEo1tMqP7Jo7BEbSMnrybCaLGmoW4azF5MwewemtxeV5Cog2oRROB/d1I1a2CEwCVFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416622; c=relaxed/simple;
	bh=iOp52Pm9s/S77ucc9KDICDH+kgBSiki2x2d50hqV90k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=odELbeLZKn6lBjou8X4ljeCjDzC8k9qu31S+bSRt6x0e2EP9GwLMBlLDezGZTE+OeNRNaELsjVbQSRHAEarFWx4V78CWgrqig0G47SNc5rZQB3yo+oUxx7Af8tXY/79dvwljuH+UJZl0BAsEvKtJf8NF9uzwD4qEiJIgr0U85UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHM7n0kb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUJBmNyg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A61OIFo2799018
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 08:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hvSrFmHwHX/ePZpcJW7M8TGd97ojj0SDV3pHaZazYYw=; b=PHM7n0kba9PwHXAQ
	ePWaA+GGtWGu6BJYZ7AvJr7eYHBfZMGoLTLpkVYzhZfbeqrBk8xu3bD2SCyt89cA
	RC9BsgTpu9VUGEgFi/VTBpdrbg3ZfSWnohkHFKKGOZgtuSu8Phanr2G+67/tjOmq
	+ntgoYgLKEo0mx0WV+Xx0pPnjy+kKGbLl3IofziHzSBtEmHDQhbUA9IJJSxVnAUt
	SnH/5Kw6zqmHeavP1qXYcZ8ciBGskQm2je/tFYKj8guqrPtdrthxCn8f0OnDzzeD
	EDgaSWkdUXPQpKXP6336JhGGHGStIWrE9KterJe+uk7K8faqQVN8b7gVW0eNwIgA
	+UfXWA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8hyts056-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:10:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aee84f1defso270572b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762416619; x=1763021419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvSrFmHwHX/ePZpcJW7M8TGd97ojj0SDV3pHaZazYYw=;
        b=CUJBmNygb2eENLrWIFz8EJuLOb745oBqLhFO3TjpT8W8HAeG4VbIy06RlAwKeJ2MFF
         wmutFqePQ9FbmJ/vQui2Ry2qZ7OgZfyzKW7hy7GRAk67SdjOcufJl5uUHH3n6F2iZ2jV
         /nRu98BOoPCwxSRknq/aq39bU0PnoEDaj9M0koRwFk1fRyIBYKIZLdMSscgH5cmWtBuc
         /BqptcPDKfe2oRZOmq43JsJICi5MXBz8bkA7y3PnegXoXNptqJUvoFl3RmlMrxj70eWr
         yxmVhzu2XDpalCncn7L95dbzUSH9sGiSWAoVtq4xjfWU20C+7yGvWeDkyhJ4rDbSCpB1
         77jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416619; x=1763021419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvSrFmHwHX/ePZpcJW7M8TGd97ojj0SDV3pHaZazYYw=;
        b=nkstS7bbJbzYZqhuXIeI5W5qbxzVM7YT4UX9SyabJac2fOC+qpG/SJuSPuKYqKjEJ/
         6q1elgu9pHlUGC1XZLFrZ9tLWlsJMLEjJp7w5IqJcj9rsusko9UHsK1cEtWc415jELq6
         oWOc4HfJXWiZAsbZaxpbyze1DRZ2Imkcc22oAnRh0Q/8xNHZ2IbwglnHKlJaU8NO37Ix
         InnDACU9aIMCavoOSYilwcoe5hSizUEr992enZeHfJmQGJRCV/rvMVxKzTznj8Jj3udr
         VUiIDV2VGj0yja86YVRqzklcf8gmV0Rtjv9x9xm2Kxw1a9LKh8VNXQR5UV9OHf/cbtLk
         c93g==
X-Forwarded-Encrypted: i=1; AJvYcCUoTAdpkpq9nC5mETtjtw/5KIUI+kfRxk7b0zTbhHWDODj7/htM/NkQlPzqwlZBu41BNuX516cj/iZT0DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LLjKsfD3pMHw22ZPimQvcZYWs2drwnBdYpDtlJh6/CGdvusp
	wD2iEgKxoi2b2GRxqZhBIgnU3HHSKKISwSSY/gEE6OgmcjIAj4MSjH3QhSb6dTDGrqfwha3qwi6
	3QEMaCLm6sMR+ql+PYLLP/0mpChSBSU1DW3r9HRf1hF2em97mnLVxboqikbKHRuTTl7Q=
X-Gm-Gg: ASbGncvguaQuoi9U2WIZtiSBFNPawSBM/BRMQz73N2/EkdQJTPv3m4PgdX1FbFaE14V
	sgIyKGsin+U0SsYE7aqwLNLSe3D1RT7bjGr1k5Lx7MwFaGo8qmmiwZsch85Sn2UsUNu4e1BuvNg
	BvXiFyFWz2pNr4HOOBpeiOu6WRvy3812qwQN3OUgSp36xn4GuhQ5Wvzd1cG/QB4ZKAXdHqlgjA1
	xAHgW9vS5Xph6lDnVTSEQxgTyb7QxRvEgrjCzQYEvfKIobH/k3tF0oKXXOA6hbEtaoV8nECngOV
	za+PQJPoYUKY+QMjMntMG6OEcROqDNv3eFaRh+8MnYG7giba743qBJagOfFhnS4p5rfJwS/9GQ=
	=
X-Received: by 2002:a05:6a00:124c:b0:7ab:63fe:d7d5 with SMTP id d2e1a72fcca58-7ae1f09a060mr6754529b3a.20.1762416619074;
        Thu, 06 Nov 2025 00:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/vrmUbhdqoB9oJDb64U5uS5btnwWXM2u02vhE5LrTCHUrX3DROpMhXq9wC6IIxjJy1R1oJg==
X-Received: by 2002:a05:6a00:124c:b0:7ab:63fe:d7d5 with SMTP id d2e1a72fcca58-7ae1f09a060mr6754502b3a.20.1762416618586;
        Thu, 06 Nov 2025 00:10:18 -0800 (PST)
Received: from [192.168.1.102] ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af826f9520sm1802593b3a.56.2025.11.06.00.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com,
        krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        shradha.t@samsung.com, thippeswamy.havalige@amd.com,
        inochiama@gmail.com, fan.ni@samsung.com, cassel@kernel.org,
        kishon@kernel.org, 18255117159@163.com, rongqianfeng@vivo.com,
        jirislaby@kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20251029080547.1253757-1-s-vadapalli@ti.com>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v5 0/4] PCI: Keystone: Enable loadable module support
Message-Id: <176241661035.23562.15419519383714568853.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 13:40:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 2GjoV0UJ7KiWp4HkO-GlOor51T79-kgo
X-Proofpoint-ORIG-GUID: 2GjoV0UJ7KiWp4HkO-GlOor51T79-kgo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA2NSBTYWx0ZWRfX/sZfo7E1QvPe
 I6SejDH+tw+sEw6K2QxSTBgSTKMFYSAAk6spPm7ETiYaxh1bvY/YzbOLf/H6UIhkkbtXFYI0cRk
 EBm7gBuq1pSt6AGvm8cdEXVqogaEpR2t5+dRH+x0RwxtdIOXsdH8067Ht5+LFNeVQp52B713Bi0
 tSZTpVHiNuUKrtIlw3Zf94ZMJj+MSkfZnEaLZm9hqNrQy1MSP67a4Z/QanWc4w6TRp6FfjJTNqa
 xkMPAOf6uwkdR6dBV3sALxUZdmZaE9fhGr9BNfeC6xszCqfVDJXMPQez5VSv71tPEu6Vtqo6eFq
 bKLPfCsVolmI7KfHMBdhO4Yx6y3HdQmfX+OdTYFvOF8jKoKqPdp/Xi6coVBHJLqTCDWRWqS53z/
 gqckyoqc2HTZC799AHtRvctoQSlWhg==
X-Authority-Analysis: v=2.4 cv=X+Rf6WTe c=1 sm=1 tr=0 ts=690c57eb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zUTZuEUZW15Pn9DWoG8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060065


On Wed, 29 Oct 2025 13:34:48 +0530, Siddharth Vadapalli wrote:
> This series enables support for the 'pci-keystone.c' driver to be built
> as a loadable module. The motivation for the series is that PCIe is not
> a necessity for booting Linux due to which the 'pci-keystone.c' driver
> does not need to be built-in.
> 
> Series is based on 6.18-rc1 tag of Mainline Linux.
> 
> [...]

Applied, thanks!

[1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
      commit: 88254d46823be8563f8f81d78390a7313ae6fad7
[2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
      commit: 9acc60a5bca02351f852651c0123d9994663ec0a
[3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
      commit: 7b5a5b7715c2dea2541e7fd3da15c2881fdfc553
[4/4] PCI: keystone: Add support to build as a loadable module
      commit: 041c2f0e34ba4823101bf307d6a6d41d98f5dac3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


