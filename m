Return-Path: <linux-kernel+bounces-860865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221FBF139F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE903E13D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09EB3126D9;
	Mon, 20 Oct 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUMiDsvs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691030F53E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963401; cv=none; b=G/GDItb57BP8Ax5HyrcYtD+ru7MbVZlu3TS2xoyRFgo+dY18sIK9YVfRj96tmEZra5YC/B7dv/WVnql3h5mKt1TQkQp6naXwx9L+7qtZp19m92SLG2Vah82o/+E1ab0sgRLu/ZPRIp09bvuXT4z8pZDYmeF0bQbwjLbtVvd53v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963401; c=relaxed/simple;
	bh=kY5bwD/tin8m/07pjzzS8+MlMr6Emf//C8kVMc1Wo9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPAnUCjFzQfhbFH2TE8eixAFi7XvO++3CmhSVZQjunKPpMOXXzxd8Hii502mm74LhdaQEmhTj7i/kJtM4p1lh6Jvsp3gC3Xx9dy0VxOt9yNZxthGRA8Gp85Pa6iMnMRpIeyLwv2NUQS08VDJOaMtk1rJHfdwiZhSTZpeMtJ6NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUMiDsvs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBNaiN024986
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7cbAVS4lpZ6y0VRAxwtzCg6TdsTtz80a5PJ9G9SBSQ=; b=MUMiDsvsE2UXqS7W
	yZr2DB1p+cbEdkt60KZkhWxmpokYEh0tHEz9eyDagjqQFk4lUV/himQoBqh6+PxR
	D89/uTMapz3H5g7c6EgBLJwR+CHTBIQi0B4O334JZoN8vcZF+EGFaJVGacuomRbv
	fgXphJO4cIw28hTpwVcj6nS1XCvbvi2za9wX9p9N4l1PQtnyYeIc6xx9xy3mOLAy
	k2R9qRQVdnPy24VkYNcb6wPfqH8HSKVWF5rUVTBnRZ44Pa0kK2u5mQweNSf4J5TM
	PLUqGbJ6bMkW9LyrvV9EMg2sfZ8kfh7YH6DPphiY/M+vJoc3K2MyYicVb+zTn63O
	XfAMuA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4nj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:29:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f3a065311so157122685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963397; x=1761568197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7cbAVS4lpZ6y0VRAxwtzCg6TdsTtz80a5PJ9G9SBSQ=;
        b=Ys2ZHtpJKh/129v6DpE9IBkM64TB4dEEwIjv3uRPgL43R5gALB9DuPZOsxtAJWBhRc
         7rFgNK15HHIgeNb01Su6Mdl9IlrjCyA6PMWk5W1DTYj5vs0dCzlckXwK0J2w2kGfuFJk
         s5/q/CI3uO7RUAEDy57KuWsg8T21E77LAfH8jARtV5ZwwURmPYke2FqkTXG3bV6NMWhS
         bce2RX2w7a7U+dxyGGOrzmoV4leSnN9AD2QnKh/byKytlZY+A6Z+DNvQk06P3FWumT1O
         2Q/Zvn8AxrYlbUoYnx+VO6X5tfp8zy7MTjlVuwxTcM5B5/wKWfMsT2A2qVjff5GzWMQU
         MlVw==
X-Forwarded-Encrypted: i=1; AJvYcCWH3vWpR/NGqpiKvYDfKo8jD26GZxkqAAJrChqJ654rOSuGnJV2FK2hcro2HVT1q1sA8h4klUmzsPnXMxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9N2g8dsCg2tWgMr6rhqWo3AcGsxsVtxQqEGjpYtSeF+ElegQG
	cMz3FxqqFJ/2kAN6ZllJkS7RkEl2CkC1z9Zzn0Dj/0jI54KsW+qfqKyysofigqslzJuwd43t+75
	TLrkuqGR8zglQ0D1EYNVXaeZTxZMP0BsfOiedxHokeKRHbacEqM2V6IsJcjgLFlDyabE=
X-Gm-Gg: ASbGnctKaRRLyo8tRkvsT0uq4Q7x0rwCbZvPfAs5AQaFRCo0VDLhgfGGfVxQOlGATex
	d20R1fBxU28idJMTorlOL84NMFhky+Enf3RR+e4w7SRpw9VFlJbUdxW8k/mZ+BvwmeXX4uGunFv
	OJ4kYHUYjsHCJhnth3RzVkHNGMDoY5DXjI3MtfwZJC2xKQJw83NqM7aHg/XKNSx+bUUvFeXaNZ/
	ft1Ygc+cgG5Fc6DWz0V9ZzRn3DWaaIE6IyYXfwB1pfyfDALYSCNZVGv+pTwkiWBpaDbQvNjBcpv
	yZZp1cIbj6U/9ezx8yO/Ju9kjQ6zOxbUspXcryqbbUjr9kKokzMY7o03C7c5PcMcUYmhzm8z8S0
	hHnciWYRWNDjbRlEEosg0qafua/m7ioZ5uLDcVwIdHDZP1KRh3Y2bsxad
X-Received: by 2002:ac8:6210:0:b0:4e8:959e:440e with SMTP id d75a77b69052e-4e89d35aecfmr80596941cf.10.1760963397473;
        Mon, 20 Oct 2025 05:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNR/XkjXBAoi3RveOS5rUu44E6/AP4/g0pKZRGBESs7vUDC7aVr4PCy8sCjlDaEHLvbU971Q==
X-Received: by 2002:ac8:6210:0:b0:4e8:959e:440e with SMTP id d75a77b69052e-4e89d35aecfmr80596751cf.10.1760963396955;
        Mon, 20 Oct 2025 05:29:56 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036884sm771820366b.40.2025.10.20.05.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:29:56 -0700 (PDT)
Message-ID: <8e957768-f03d-4204-8eab-e3f8ba3bebad@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-shift-axolotl: Drop address
 and size cells from panel
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20251020-shift6mq-dt-v2-1-d8fc3ec71281@sigxcpu.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251020-shift6mq-dt-v2-1-d8fc3ec71281@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: G3wbavKmuM-VvI2eShNpDFeKSiXr2IUU
X-Proofpoint-GUID: G3wbavKmuM-VvI2eShNpDFeKSiXr2IUU
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f62b46 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ze386MxoAAAA:8 a=EUspDBNiAAAA:8 a=JIWnkRdvRZ92eSO0A0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=iBZjaW-pnkserzjvUTHh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX03VvGQJOOVeR
 xZPFckDgVIsfUitvB/6HAjKT54uGlcy6/n/3Ct1ys+bZdgdAtwRAXAf9bof2foN3AV8SZuuo+ZA
 HmkTwSQc7xa7mGwbUw9sD9FEgYFkyt16Qlt/Z90dHqyHG2utwaOT9BBwpruaHCUKNj+w7ovcWXL
 kTb4eVaE0jKvXk3xDzQEB4Q38voF39XuO7CrOi3si5K4QruCoQ6XGd8zkpvv0u8XuNceqBMBdc1
 +ShnxoRE0B+kBwsbfGFs0eJMW3K24zKTAvcUqmgng+wnvoNH7ufI8jlTdF08gUcdi1Cn4HWeSZW
 settlf0FG5aQmuZAC87R6kKb59EtrsWqfJeSSBHZG/3bcvdbBfpA5TmflwWGrTs+e39DB/JXb+Z
 hNqCh/iLk3u84L1vfkoF3iP3WbsIAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On 10/20/25 1:58 PM, Guido Günther wrote:
> They're set in the parent to describe the panel's reg property already.
> 
> Fixes the
> 
> linux/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb: panel@0 (visionox,rm69299-shift): '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> warning.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

