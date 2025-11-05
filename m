Return-Path: <linux-kernel+bounces-886008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43823C347F3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFB944EE84F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5042C11CB;
	Wed,  5 Nov 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzgDD2lB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0JYG3/B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482AE21CC6A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331653; cv=none; b=sr9a2P4bjf0L/6fayn6P70WTePCy1TeXRNNQIvh14/ow8ZjvC6EaGY7XR5U23gemLB1X/pqB3guWa7bZivrwNO9QY4WV4hd8q0wkJt5oj6zU2oviAst/JZ9ehvtWvEtQKS/MUlhxek13RDuZyyHU40a8CAz0c9eKBzdZh/v7yBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331653; c=relaxed/simple;
	bh=NnSGWr6f8UUqIioqQVhV6tQa6JDXAIcMsUZ3hBk7+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZGZFD4vPa3OKDaB6kYLoIuFl247VNGQ9qrJ3fw2BpJMJhYlOaZACTqef3Eti4BQR7Qx1SnodGiAT3rRtMNB2D2dDZCn2dVGXYMU3jgtfsVSHxCNXapNW3yM6GJjCSJqmYdoTIQXJSqPFHYX+TZXQDkhwb0tXjTQHnNnzNu+W9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HzgDD2lB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g0JYG3/B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58DMjN2996780
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 08:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V6iVgv0dpsKodB/pMhacMSwm
	+tuxtOcBfpnB1qtn41U=; b=HzgDD2lBl5Tg+YPWoiAXMH9rR1OKO3jYigTuzOlr
	r1gUcKtZT+o/MrXzkj5CqlWYeTtzKUmrX+2rCBwipD9xHR2OmhH2ZarAjGZjOGTp
	yZYpHdaW7ogzwf3Ls5oHYC/b5R7s8xMSBbHW6r0OoM/JYYB3K4mfFnX2xG4Lc7Pc
	imClJodQB9gBaHRBwdWKC6ZZc55daBGI5cMIoHXPB6fvvpyevgttXJSHNquUpDeN
	bQ/nAPuAnzCNkudkha94l0KgCYXUC/ZRleJ5GCBvUI+RNuktTmdpaacep/nJD0T9
	c62MZBPKjLvcISbIyIBFsRhSc+FkGNhdDqkf59NWfAkj+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jm4ju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:34:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295595cd102so76647725ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762331651; x=1762936451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6iVgv0dpsKodB/pMhacMSwm+tuxtOcBfpnB1qtn41U=;
        b=g0JYG3/Blm8OKImWXmf4ksU97cFuN7DFiu3ZuK9fL8hE0ZCPQOVdqEL4bu3y36fFl0
         DLuTAzQvV4A3aldxQ2dUb2EH9xT/2z6Md33+65/royP5gvlH+5LVjpLOPDtU0mShvgoi
         cgeetmwaBDJvoK6DoUdDE0sWrK7RMgwWjDTKk8DUok7Tw1FW3RBd20H9xrzitkq8Pmry
         nsY+fVxortpjbmTYfiScHn22cDJ4ZePFt4+GaBfG/PsORa6DypHd8Q/m35ZWN5wGIWs8
         HBtuHGbIzkYJh5vDnTEUo4feBOu/gY8VUjamm9LjSSgMyKgd8OB4zo0YsK6W124Hrz7/
         NmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331651; x=1762936451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6iVgv0dpsKodB/pMhacMSwm+tuxtOcBfpnB1qtn41U=;
        b=uYI4p6rwU1BvD6BysFu7RK44zNm2hWMriZwb8nDbpA2DYOxYsVgXDaT1bnA1UaOjKx
         qDSq0m0qx3AQrqndUTzSoo+qZMei/GCXpPQhJpGQ5/Zj6f9T59hM9YFtTnuxbpJ+8RRE
         qWJdMJlUZtFCt2TgBL6+2wL5+YuGC2FpesQgEbTa5Nf8ZVrxLq6lTy6e5AHtqHXhWX3J
         FEo82rr+TAEjKabSlfaKz/QCGbSn0sS6ySFePwnL6V8YEcwSTgIKa1BMUK81wrEVd079
         66np+OMtBjxNk8BB7VAtzvsXSPVo7Own/sZ5quOVrhxC87PIXO2ybVrn7wAG8FPzLdpN
         P1eA==
X-Forwarded-Encrypted: i=1; AJvYcCWnSEvpv6YTy+x1XrkKZNDVXkBkvI2iHef4cadzqy+lGT0kWLjqvOzWmew7A7LMWah1K6/7BYPAC2Ryh1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKCugTDR7fNztCmHQu+JDKhFHG6Lubae+rOSk6336uWGQNkBJ
	ZTUi0IPtcfE7uN/5ynNmbih92zxE80qvktHriTE+HluA5jy/2ys647YeJiVqb9XMnQ2hRr/Egzh
	xcrmC5xoMw0nTf6xfehI1Ztz5g6z7Jk7PeUspqj0zCt8DU9OlzVBvZfzkA+79MxTdLnk=
X-Gm-Gg: ASbGncsZtmCrlOhT9slwCAa+8wrHI15H/ngo8i9ZSHXTsaDSNJmInw+l6+71K+uzyPI
	9qYPZiHhLoz4XBEnJsIa8rpLZfgmy+SQBkFLSEX5Rj2yldMPV3H6AXBn10u0K5PMz1ckppvyKiP
	ufkGnfQVaXwCyIJQxnmSeQ2SI5TlkEe/+KdD0v7SeKLCqnxHeT1m09vPcHD3nbWFEXoMeFDIT9O
	QRHAZM8hH/JTew+UwHaxWVoGvvAV3JnPgoZ9MluSk1Vc5GW4B22XVHmXDrGt6CHgKtCSI3F1K99
	tWFVIievOkDuStzJ8Jn/wM6PAwu+U5GFvgYi0sgDtFapkJVGil7rwM4DwAr4YR2SNmZfzmAPfwZ
	55dlfOOsfKDAkcJwBs8KFZDR6TQ==
X-Received: by 2002:a17:903:41cd:b0:292:39b4:e785 with SMTP id d9443c01a7336-2962ad3e9dbmr40217125ad.26.1762331650521;
        Wed, 05 Nov 2025 00:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFXBpcvRc2G6A4wtVDwU7gPC/Ps+J02LrDaCzleFH1Q7ZBJHgDfbVxaStU2V7miFCNWmuTLA==
X-Received: by 2002:a17:903:41cd:b0:292:39b4:e785 with SMTP id d9443c01a7336-2962ad3e9dbmr40216745ad.26.1762331649932;
        Wed, 05 Nov 2025 00:34:09 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5ff69sm52309015ad.93.2025.11.05.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:34:09 -0800 (PST)
Date: Wed, 5 Nov 2025 14:04:02 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v6 01/14] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Message-ID: <20251105083402.dvm2w7ezp7spgtz6@hu-mojha-hyd.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-1-7017b0adc24e@oss.qualcomm.com>
 <0608ca9b-083c-4929-a4e5-7d76b2590637@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0608ca9b-083c-4929-a4e5-7d76b2590637@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2MiBTYWx0ZWRfX7QBab4GyYL1a
 8+e0h38TwuchgnuPCTiNwNF7Jnp0CAR02zSzquGnzR1fhYFK5Y/pZ8It1Yjug6xW3/ZzuofosKZ
 5zG1RklzreWYV9CR4bDqp4AEh2e3jde9b3c0+OTKCFf+ujkLnfesxMc4a8SQHxq90DT27HZiDgx
 8Qdy6bLbhZj/oeUSCZknYcgujzkOCGTEesbzimZRYHhPl2TigBtskr0wotGuKimQd2ssrJdsqrc
 NLr+yxtbZJ8WiYSz/F/FBkTxzGFWUcXk10Z4svCpUY0VTPXXfy3BR3tM0FZG5tjTk4KU3PKW2J2
 IyBlvYd+Xbmv/tPaZ5PJoPgYoahZ6Jcm6W06oLybriy/9T0kNnrHWYrjmQ8nl+19SO0XeH8Zldo
 uxrTYu1vsRW7sLa4TBkFUdcIX9CDpw==
X-Proofpoint-ORIG-GUID: 4rcXeK_wFwDEkv28cyRkFJSpFapPLkN2
X-Proofpoint-GUID: 4rcXeK_wFwDEkv28cyRkFJSpFapPLkN2
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=690b0c03 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NS1sl2V-mFnim50cphAA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050062

On Wed, Nov 05, 2025 at 08:17:14AM +0100, Krzysztof Kozlowski wrote:
> On 04/11/2025 08:35, Mukesh Ojha wrote:
> > Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
> 
> I don't think that's true. Washn't Gunyah something new? Like since
> SM8550? Look how many Qualcomm platforms we have in the arm/qcom.yaml
> bindings - for sure most of them are not post SM8550.


I should have rephrased it, thanks 

"Qualcomm platform which feature QHEE based hypervisor or a module in Gunyah
 ... "

> 
> > configuration for remote processor and when it is not present, the
> > operating system must perform these configurations instead and for that
> > firmware stream should be presented to the operating system. Hence, add
> > iommus property as optional property for PAS supported devices.
> 
> So which platforms actually need to do this?

As I said above, almost every platform which features QHEE or Gunyah
hypervisor that support PAS based remoteproc subsystem should have this.

> 
> I really do not understand why you are adding this to SDX55 and several
> others.

Firmware IOMMU context bank was always managed by QHEE hypervisor or
Gunyah it is more of never mentioned schema in PAS schema. So, even
SDX55 should have these as optional.

> 
> 
> 
> Best regards,
> Krzysztof

-- 
-Mukesh Ojha

