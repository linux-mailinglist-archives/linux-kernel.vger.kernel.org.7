Return-Path: <linux-kernel+bounces-786899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D177B36D95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2367A7684
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08B2701B1;
	Tue, 26 Aug 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIgUxzsw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB30262FDC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221557; cv=none; b=pvAD10mmRZfbgIqFBOtmJsMz7HWXVvbzWz7fi7wqL6KGO1fgagYl7S5TPBrY3x4Ll52+ULVCnfaoa6GP3FXBOSSldogz8o/cgzJ6eSjyhRBuEdmnICNy/fd8uF7/zINtQaUZQeHExfMOkxbDj+/3lW46bb3nQ0X1CGYR0O8UukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221557; c=relaxed/simple;
	bh=2qMlQd1EHzZMq6k8FmHmnZfMzOsgEOBbXiMatiIDWT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s51Yv/ntCQtExB77pBpU8irjJut/2iXu7luhS5WWRIpYeUgecKTUs8Be+2EgmGDGChJaOKZvJBsGvGmLTA6AdipVzyGPG3aiGI1UvOzQDZQMesu3UG4f1wEdm9tgBwepKB/ONQ5oH9CMLZwYPcRORcpPzJ03Hx1jr89PTTckMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIgUxzsw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8eGUe019189
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SwQL66e3Nu9k+2rWN9KxTqPiCmr+WouftcMZ22iOrnk=; b=eIgUxzswlkZHaCJj
	rnGJn/nm+urEM+YqiKmfCGzN9GianKouzNyZ4SMpX/5oHoXQBdOD92gtcvaJyGHJ
	HYcIwvtBb3wL+6ClPuis+8ZugT820zeUWhxaAf/J8MFqajlb0f8yyom/5qH5LcMG
	MPAUcLqG5oXx2rNdeim+dtqRMpnKQN3VNzUkXKaqRqHcyyoEQYQ32v2vAd5GIvcj
	I/rZmy9gjqo6fhYhEZZ7aPePWpgmlf8i9yjFrk4UWnkuiUfZKWJqX5k3ICVl6duZ
	fkRGBAvgp9w8u/ByXFJ3YR7qq/jxHiPjhtl5ldeR9VJji7FtqxQDrB7rFCfZIW9A
	ZrE4EQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5h5d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:19:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3274f7e6c1fso591371a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221553; x=1756826353;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwQL66e3Nu9k+2rWN9KxTqPiCmr+WouftcMZ22iOrnk=;
        b=JRI9Z7TEMGFCKGUDi9W3bvkLFsqmZLREZ61pg11Z990aV4IOSyqHPC87g+7iUgm1ca
         cAFwe26wo9awbXvTno3qKxNyvUwi5xglxyfTcTAHdv7d4iIYXLDwyXIIW0jCc06VPunO
         DpYHxg62Ur7E/luPH4zhh5xDkf7XkSK6MtL6thw5Mbcbhb40jHTlWOSpskfn1/AUYqmt
         +ub+mmO0K+2hMCvBGLkr0IwSBqBxctEfYWu3nJG38Vek2CDcm9EMwO94EMQaZaWTeWAJ
         GjYr3rmM582wa5Khyb00q9+jBGWDsSSJDPwgjcrhfLR0YbQjqMJlneBDitQihwQt/diF
         jlLA==
X-Forwarded-Encrypted: i=1; AJvYcCWGq/+jlzD7Dls4sf5R2Yem3TWqPjxpzd49ESNvOrGu2wLqOAkyu9YJtNB/hUuQSGTBc+l/nvrP3MzvSro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eUAdRl89GYPnBDqxWAeF/L4VF0oGPDyKGo1gh8lcsYVuh3WB
	oHYR3r2IeqlJ1IrowsatJVRVwpb6mFKkfJkB7Gwm/EJkffqIxeBkKoLUk66cNrIGfg2oPkwUn5z
	+MHbyn0XGwqlML1fNUKSf8z5DYz2o8LyWVx4LDjYxibBJ/iMTa1dNcin1zDsHiNevtm4=
X-Gm-Gg: ASbGncvl+sDlaPYTIaIK4hS9Q+/4xA8K/L8qI3/4yaPZdmIR30iwYkI+m5Hr6HAR0cR
	083dJYozh5tdaWjI4UyCQrthBsC5ui0vOpDvjVDjJdhQUfAff+dFUXCE0LjgMVxSBxPwWR/wznK
	cviroeNAshUQ1FBByXS0ymVnD8qnDEdM4tznDyvzG08Kh+WkGRGf9z3H08rAMtC5qAgWHjhqdFO
	wmupRa9JUa9tmbIBwgEXexCA1Mzd+eELRD1nPjV2JnUcmNkVejK9U3fi2scFulCqBdRGI+1oiU6
	/JBjX98F50je3/jgo8VuNLwvBsKzmrd9WkhP0YZMvoiCy6fxgbuiSt8LTrW+uXk7Ir/1jlqdNVE
	7SpDxLjnymfyWrXwlYq0=
X-Received: by 2002:a17:90b:39cf:b0:325:17e1:ab69 with SMTP id 98e67ed59e1d1-32517e1b5a7mr19762813a91.3.1756221553068;
        Tue, 26 Aug 2025 08:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBFCqB9ocm/fFjwbsOzFsZHFiZH3GbPHYwnLpzF4CEcjFDhaSfsGGNUpwdAdtaM5f+IRrboQ==
X-Received: by 2002:a17:90b:39cf:b0:325:17e1:ab69 with SMTP id 98e67ed59e1d1-32517e1b5a7mr19762764a91.3.1756221552537;
        Tue, 26 Aug 2025 08:19:12 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa708cdsm10154132a91.26.2025.08.26.08.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:19:12 -0700 (PDT)
Message-ID: <0993bd25-3cab-4f96-9398-bf5b5f7770cd@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] PCI/ASPM: Return enabled ASPM states from
 pcie_aspm_enabled() API
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
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-5-61b2f2db7d89@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825-ath-aspm-fix-v2-5-61b2f2db7d89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/w4oWvVnuQHY
 4mmjWAeJomMXRf8sxP8lWpu699VfytiVscoDvpcfmAq/qqeUNXGRXcpQ6QQ9qJCLe+g6yh7auDN
 56G0xYf9CG14Zkq9EGXe1dwj01KKxM2mBtkI+EH08qYhuQsdOxOMvJtbRaaaAPt/C2pO2XbB5a6
 HL2W+q6iFvwHUb1FtZZbLOQwDYHJijtLpLJbouI/dyaIEvaXNb28fjedNQQBYXLGWonJ7hJ1J4Y
 IDPsICL2F+ni+xqjCnDefdS2BGLPh2h8NYJ9emEXyV3o0460AKsNA122OHuJa3KmpyG2XIbPmJG
 PQzZxzbjKbVzxeoTE/9txJZSx2a2BnY768L5MvtjjCm/rveaZCndaOTnfVaTN/AVsQXnJzGDosy
 ugoeGirB
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68add072 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=guytT1_IP8q0_Fb2ReoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ZZsNgytTFmetCIWGem4zlXoZoZecutZO
X-Proofpoint-ORIG-GUID: ZZsNgytTFmetCIWGem4zlXoZoZecutZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1851,7 +1851,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
> -bool pcie_aspm_enabled(struct pci_dev *pdev);
> +u32 pcie_aspm_enabled(struct pci_dev *pdev);
>  #else
>  static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
> @@ -1863,7 +1863,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
> -static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> +static inline u32 pcie_aspm_enabled(struct pci_dev *pdev) { return false; }

return 0?

>  #endif
>  
>  #ifdef CONFIG_HOTPLUG_PCI
> 


