Return-Path: <linux-kernel+bounces-786925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC40AB36DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B28A177AED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9122C0F6F;
	Tue, 26 Aug 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4P3LLgH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90D2116E9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222745; cv=none; b=tpPhaAFdOCk5zii/Yrh7agjrvJStMZ/TOR86pF8tnABfMjchPfCsgOKl9zkGiBfCjip+SW6fA8XM68FDo1mV5a5cfapcBzRDYJHVm1QHml64RYu/1kHxeNFq5yDuoRWwdghshl9DrDLPMMGSNjjnj8BBRsTdoms8qvYMKaAJQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222745; c=relaxed/simple;
	bh=bkCkv19S9wHdnx0Kc3+tOj9A6SmyMAB9oyi/16jxTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+k0RFL0sDhodG9t8VfTWhuLYqxpyQ5aDMLjywo70KrxRP+B6WQWtycaW4OwTr7s35wPxJoMtezv1bKKoPkaGh9zZ5jAq3xQRsF2/F3dwPtbJqs92Ju9qkPslrSpGf3rhN0O15zFf2LhENt6iGG5zewy5dsjfgL5QZ6OXZkj+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4P3LLgH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFLd0V011572
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1//9ar4mn96BTeRcegh7QawnDMTKdyK81gfdwaa5TQA=; b=X4P3LLgHNPk2C2Jd
	5x2qMx8myzFcDvd3GsgCO3pcGV7w/koG/tWWh8qqUqFLDyP4Xd3ZwtdBIaPmaidi
	CONaiwJ1SXb0I/hfrCPY5IUnND3ndfEJ4BbY0/s0gcu3Pdjj53rWqbLM3QetSuDg
	+PTAZVmBdEg58qEPG1qHl+l5GbRyM65DPxZrLo0x7Vj8RHPm2B+DsNnNOpj+WWAL
	nssxfJamSDEvzBJMGG6JfRcIIZ1IbW5tIrNFPT4mVAaU9PFInlQq3qkxyP06VT9X
	WRWT8Y+vIIHPMy4g2iPQf6Erh9HUUZCeuJu0VqcU4h0OTCckdFf9SAEIApRkXmu1
	OkHQIA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615hajd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:39:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771f71fa5dcso848960b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222741; x=1756827541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1//9ar4mn96BTeRcegh7QawnDMTKdyK81gfdwaa5TQA=;
        b=qhFeR3EkoxFbRRjiHlK8/K9uYtgTOZaN+4zXUsRFPvsmJqjS+BPum+pOhkpIE85zqF
         LSGJRDyHSOE6U6293+ESkB6FjbRJSWMKLBeAHbNdX509cOzmMc71H+2S9OJ0HeWnCgDj
         6WYKOi+t9HLsTpIrYmN/XupExMI/SCo7rhi7EgadgKc2MBpt+tGZIA1NmVg82tOaMgD2
         cTlIPWizAZv9B0kFOWdjcLOTQ9osHaaUfprlXOiUePHtJUYKEXT47QJPnBJI5hSgmzar
         eWBUUzY9ScmT/7fz3sk6mQ3dAf/uLFt9miBg+fEdBHYy9lbwCskeL3Lv6C5zixN/tkHV
         zbog==
X-Forwarded-Encrypted: i=1; AJvYcCUcWeQ3ZSH9ay5YcfALIvtmtpktwdJFmjLpOizGxl069eoKfdNedHZaZhDVw1GJHRU+nSjXknWoKNn1fgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVS1bm5aCoxqlC4+UQYNQxDosS9ekAZzwJD8GD+Gd4TNj+2yTE
	pPsqVt6SdkaZmdUrz5UqZC6zlNBP/CLcKJDjUQnVDBsdH9dLq7+ER3fgYp4Mj6yHvxznFtucgIf
	npFWGH3zRRsgDR/Y41Ktulu/f7o+6dfVccSAtDDT3Bse5qJEmfT2fNyfxLGBu65QsT/U=
X-Gm-Gg: ASbGncvdLVmr2PSkN2qBUM2Usb+kzhCA+ZopMu+mo3KwrRBtwdq28A8ZGYqRC2gDvYo
	Vnixhqr/AYD54rryLX+jZnEMyJ+7zKbpaB7ahQmTi7b4mi0V+JlKV92TWlv19ij0qBu8ca+jIOY
	qCI/kgbltGmJmmgNCTueFzSj4JrBzdYLwW59NUYDyQ4aO8fA0LiNAVYC8QFSaJjExW9JB26H3ot
	Z9YhVlf2g/K4FkSh1Fdh8xjwK6gdhTQE5AtCMLyyubJt2Yec1W6TP5kXuQ4daoBQMIoc//vdBQD
	Vzkf20Pf+ED4XeATkH9Qw9jriGroMgYx+VBtZZrl8fzO8vySL32HmgHygG+26E3IkxsZLalMuH0
	Ct/zoGlzyhzlyG5efVy8=
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id adf61e73a8af0-2437cff65ccmr9026059637.26.1756222741343;
        Tue, 26 Aug 2025 08:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL0KSG01yve3r3qzqiKchOxZo/p+aKsbAcVtQItkNd7vJ4cyfMgvyDRPq539k48rr7cMjN6Q==
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id adf61e73a8af0-2437cff65ccmr9026009637.26.1756222740816;
        Tue, 26 Aug 2025 08:39:00 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffae973sm10724369b3a.12.2025.08.26.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:39:00 -0700 (PDT)
Message-ID: <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:38:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXxGbL9/U/D4UN
 xhdvmXcJnUAOhU4BoOu+H+d922FHOx1czRN1p7DIfhULEGVjOHF4DHscOdEScG/itimAP5R4wQR
 jFRp1YVlebtoRMCNo4cBx1KIXjT2aWVm9OSBpB4ZAnXTNoags0fa3Qhmnviqq3/H5TVacyJ2Z46
 QRQ8+SNHxikYqJUUKvOEAQuIL27IOed3+I1oEScIt/kRu8c2pDxq8rf01hQc3uDB1JM/1gQ4v+C
 N3CFySoLPhiz9zjwHqcZpMUpLm9UgQWsN4JVnAOwFgTBhGQooe6B4xRPDoqFJlWF0Igo9WYjl4F
 4O7QQ4h3B6sGw0UnWXzN3ZPYfso3FYwF8OCevEN6XAuN9AxvUsbasp09bhuawcQT1JZRL/Nxomq
 6TaDXmlb
X-Proofpoint-GUID: 0mZKfz5q9DerQzdB8RZDvxUM2j-PXJ2m
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68add516 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gMjHX16tY-KYiP7tJ_8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 0mZKfz5q9DerQzdB8RZDvxUM2j-PXJ2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>  config ATH12K
>  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
> -	depends on MAC80211 && HAS_DMA && PCI
> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM

As you point out in patch 1/8, PCIEASPM is protected by EXPERT.

Won't this prevent the driver from being built (or even showing up in
menuconfig) if EXPERT is not enabled?

Should we consider having a separate CONFIG item that is used to protect just
the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
functions into a separate file that is conditionally built based upon that
config item?

Or am I too paranoid since everyone enables EXPERT?

/jeff

