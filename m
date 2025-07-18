Return-Path: <linux-kernel+bounces-737193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 116AFB0A8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C2D1AA3990
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FEA2E6D09;
	Fri, 18 Jul 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MT33T1UE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EF1C862C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857619; cv=none; b=UEW541MlnAKp6JTWFJcBOu99hNt0EqJEN4TCwl7cCnr1tOJZNDws8K9Z9gxw35rNvPzgC9ZrPO9qSZqSlJ9OtrB9eB9n0xpJRDpKYhxZuAJEOp8ZoLe6Cg2pL2ecoHv8bVCiVkmp9V6nHsp5OpJAc3oltnojKRSuGbC2z8/9EoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857619; c=relaxed/simple;
	bh=AvT2v88BVC82IUioxoYrikpuG0OmwzOXTemFf4LMJ6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfR5Bje5LqCMwXzLCNZwH/WzD74wv+Rbf3ErSV/jsp9GOOLmmRFouc6+XRRtTheiuiFUwhOXyAsLvTXZMHL1mKnkYYCOhqopoNDcbJtp3sOY6HS7FuVdC1pich+vGURKkOFSMNhr5KdyHiC0q+WDRyBd8QvoLdEesUWV5POd1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MT33T1UE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEpVu4030488
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m1zCD0dfghAVW4/iCikI1Mzy4E0jkoMJk9ypegKSOwQ=; b=MT33T1UEHYC6YVkh
	xssZayZWI3HS9jTCahfMVvQEQoKilwVkz1JDIhdTWrr4fS2s0bFRtxtea1tSz0cx
	WvCNn89b9XbKFUWvy6JOzg8z9k0pDLm7fTdPcpsfrG9CsK7EbrbZhsQP7pwVM8w5
	dhFWVEnhlBAWK3K5ERCzbGmCe3HsEwoOaaln7zV7ZWLEaThH+tVSpffHKWuRfTzK
	e0mUY7unvjQaE/RrPs7Tow3QPlwL6d9HfPpq/Ltwe3CCoZtcvp8935E6BXZHVjWo
	gx/UHuloGVJyE1k90Gixf1pB/v3W/YqPVPFFDXsrUPlD4rBg6S8NVsUuIkC3+ABz
	xfDK0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7s5x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:53:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235196dfc50so23417535ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857616; x=1753462416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1zCD0dfghAVW4/iCikI1Mzy4E0jkoMJk9ypegKSOwQ=;
        b=mfRIN8uFIKHlRMLfcVc/jQn/VF3VxJRSIa6ecwnQIuE0IMh1C51EA0ohFKH+Sy0Ioa
         hmETJyehrlYxIMLsjpiM3rj7JUB481WGk5fRwnE3Fw/uv1MLO/B5RPH9X2XMylOej4Xh
         50gs78eqOpsxW7xr6otzWOajOs1r1ovnDrJrkDP5aV6K8PFDup2fZ+t9QRUCzNvkSs3W
         Kll/VUCcF0b8e+REU6leoWspVh0sUJKtkcByr1jBIclbFpIowyyX0pTOQycKUfUFWUtD
         fBPDVti2o1KhrumQj0TrHkvqPE7PZ1hwt60zMrNGLQMQnZLmNapoxjfL80LzZjsXSXAw
         qIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTBdBit/9iGodl9S+t0dlJtqmc/gFvP/4lI9dtkT05mN0VTll2inQgIl3FMzJuZ6O+3uoBjzbr0fGniAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsY4ph2onuFVhM4PxBbeDNhi/ye4NvgVKi3jk5bOTl2pMNMNDD
	y7RE2/Mq6MhrDPI3j55iPgESskuvuVsEfcov5fPtpcprVIslP6E24KHG9LC3Z49vA5q7068pUXy
	+oAz6jKMxZNKzq4qrhul4QzC+QbsJ9l9lY7GGzaF1UDKD+oe0bt0pbRBC13/vxpOCOFU=
X-Gm-Gg: ASbGnctgnglin7eiV4th3VAQlNG1VTsgp+PMidOdyKT6u2iL4gvLbYiTpERU012UIPT
	XDpy7QhHlGJ3NhQrJWFuTTF8pcYp1JxghOODTwhfu7o/w2V07/vhjkPvBTqT0z+Ehn+1BLCUVA1
	162i1z9ZMq3JlNzyaf03APvHB+D6YtFXrBXWKn2MBy6lUhkqHuKFtxyIhvQ9xvXkwxDKl8d5VJY
	6pIpmSZQGxGKMZyTnnm6SoB1gLkE710XAfNFWhnCO7ofpVDikWe5xf3HaUn5mnlZhW5ppR8QlGT
	FBsVDt7WAPVGsk6c0uJUNcApfEEOtdwY4zmQTXpzbUFioPaDuVmNrqIGgNAu1i8OENiRFhDkNa/
	NTDe/iFbrRusVWQ==
X-Received: by 2002:a17:903:186:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23e2f744c24mr114646125ad.20.1752857615738;
        Fri, 18 Jul 2025 09:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuWrniCXSDlgPowFyHtxd19vZI/IqgnQedWoC58cRaes2308e8m8bmwseHhboSm6uY1fQsWw==
X-Received: by 2002:a17:903:186:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23e2f744c24mr114645715ad.20.1752857615304;
        Fri, 18 Jul 2025 09:53:35 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b490fsm15812805ad.112.2025.07.18.09.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:53:34 -0700 (PDT)
Message-ID: <515c3aae-13f7-47d4-91e4-d2d54fc8e2f3@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:53:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] drm: add debugfs support on per client-id basis
To: Sunil Khatri <sunil.khatri@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
        tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20250704075548.1549849-1-sunil.khatri@amd.com>
 <20250704075548.1549849-3-sunil.khatri@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250704075548.1549849-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMyBTYWx0ZWRfXyCGEBILLcczQ
 GW/vOJyuyQLTa++9SJ96w8o9JEnt2Z6KPejktRfIn/q6zyWhzFAcA4rX1Qir1KAh/Z9io626mAK
 9+QjuU5p0DTLUi7SLpnGyYq8XRKs/TutF1TwJ0Ab2rBY8UuOOK1yadOr/GwCLT6htOnFvv+ZnBR
 /eLVRcaXPgu6aIUbi1vnz0HBuBbfIxHaDaESEQ6EKivm1/lapui3+bsNMBeQKjdkTxA43+5gA2O
 mZJqULglx5SUIOU9FLfc/UMD4vzWUbqHtrR00EoRPAD+qPSZRzwect/9PGmF+56YkTxZA7vtbcM
 2PbBD6s+NQg6QVB1m21FCRa9PAR+24G+sIjyludpMoNNd6uselRtAX3KMhOUTKto+Ndg1rTmfwc
 rGrPAIgTMsmsxiG9Q2I7a6sxY8qUfmAMyTP0YFOpYqj9Y/GlLJYEEWm4aM+VYR+VlduBBoDg
X-Proofpoint-GUID: OotyjoCQbzEDyjtpACFeqa8wXXBWNRee
X-Proofpoint-ORIG-GUID: OotyjoCQbzEDyjtpACFeqa8wXXBWNRee
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a7c11 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KjCdSd8fyryEu2hfdkEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=774 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180133

On 7/4/2025 1:55 AM, Sunil Khatri wrote:
> add support to add a directory for each client-id

Nitpick.  This is the start of a sentence, and therefore proper grammar 
would have the first letter capitalized.  So, "add support" should be 
"Add support".

-Jeff

