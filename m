Return-Path: <linux-kernel+bounces-838641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5BBAFCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B60E189F347
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC552989B5;
	Wed,  1 Oct 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CAegxa6q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F92D94A8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309875; cv=none; b=lm9ANVvSeG3vnU0f6m4pqQtoVnXiareMIf4eIvIbJveHZlsQ0hlaKESekcX3AnqS8cG4ctGAjifcO+8LBEg+mYl+YXmgdMYrQ9DP7h9tKXqaM/EgMkJ9EFaXrhoUvxPu6vdSyMh6gWxFftmxVfgWRC5DNmg2glQZHYOgRbcaVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309875; c=relaxed/simple;
	bh=e/WEVryWETqOkgzO3C+jeJYAOW+tg3knY1j/j0lK9Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmIAZu8hlwhgdoLZABE99dfPgobRpfPZTym0BZwEHStTNBktVVQ1fpvBnu2ED7Bfn+UsTEKkre9p/7Z1xJSlgNweK/E1d38VKHqZZs+/tTod7j/NJb9+GqXJyBAlEogJkH/b7LMwKTB+N1xO6Cz/6spKhWwQJtxA+z0pihuk5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CAegxa6q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKkSED005324
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e/WEVryWETqOkgzO3C+jeJYAOW+tg3knY1j/j0lK9Ls=; b=CAegxa6qKqqGDQ0r
	Ilfb7tNf9QzTIO8VmKfcoZglS9o8aJ9EzKim6VP+rjNZP2iYuIOjSFGEOV7lHQAR
	W4r42MC0nNcWyRCDXR8XkKCf96Y1OdFSnBIKBucPipY2pQmOERBr0luDeFdjAN4q
	2/h5qjmYy+Qrhj+sUlngYtPjsOKLt4SanvwhE2LIJr5KDta/OhY+lE4PPt6qaYUM
	IkZhzdYCV5PhaYVpr5fGgtoqgEWWZqzCRBc4kqI3lPD24Tj4RCnZtDnvIs5mVtpL
	lyK9uI30jGDj4rx6QzxUGKblhSXh/1AoF+ajYgTKW8W/gtFaGDpIVG5LJJaHZo3t
	7ZCLBA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf5j5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:11:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8703ba5a635so49391985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309871; x=1759914671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/WEVryWETqOkgzO3C+jeJYAOW+tg3knY1j/j0lK9Ls=;
        b=lgfCOw22mb5YS8tFkwFnZVLMY4xqTBCGfdV+gWiBB7et788Ro9u13q0RhHuRNKqyVF
         gVv21C4VQx14zrkMaDVUmSm4j7MtYRHzSbo9QOV33jT77sYbk7Ok6YJJrO5/jV3yVueA
         5zvsUsrNeOLf61tsYjRGzXkhMoz+0RCmSPidtRCupeXgo5P91fYTX+nhPBUqFHEiNVpb
         wTHrwFJC03CESuHqJ89hZY0dp3Xw3RGBRCDgtJnpUWlnjV4E5HIyNxCBijZhamMyojCy
         FUrZaGkvEWkCpmvFzhw0qOmB14Y2tgnuJU3fz0DC9/AKpNIIm6QAAgPNRk7LgKy8B5ok
         AbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsr+I99Bg3dQohG3T3UU+2B7gRpdcFH8PxHANJ5WDTQz53f4p8N2/OcUcsWFuyU5W9qMt870ViLoGT4ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4S11EtVm8/7Erh8N8s/Uf4N6Gl/J9/vfIxHjPDd017SigHclD
	YX4GjgWJsZJBtYU/bzXMVhdeHQ2eO1epXasBKnMeRb493kKFm8CXTOfk2b5EGtNDXotApxHtx5z
	8JeOvvGUiVF3j+35yh8tieq5LC76RcXBR/Q2WMe7n5jQ4Eo5q5RdCEP7+Jsj6+iE4E7U=
X-Gm-Gg: ASbGncu0+oB5bqYNhyS690agtGnV3uw3WZ9GLl+ctZNhJAX84V+J63tbjOTRGs4G05J
	4SnNBCZxGbCjNqE9ab3QpvALvalSzg2QS/qp4SfhOyubkYIDmDbexFmCfY+favm47ta2UOpom0c
	Gs2OozEJc3vZPD/UsveUzN7GofkvFAzYJxL65aUec81uQ0H2nZTDJJyIAdHeUvNzcSvej29nvYa
	X/D55QFocVcInQJhkWA7X4KrTNJnK07Gm+KRmqYyow0wYzguy5AS0EIjeLjan8BFcBQ8SDcxhSz
	GpwBCFnSAk/KJuBeBBtpUIVmofk+ueDmBaTjFZIlHW047BSjToWCtlMy4fMtpMbL8tAGKFjgWOA
	rG+MaEL6xDTZZQphOBG0vossQ1wY=
X-Received: by 2002:a05:620a:4556:b0:864:a09a:e860 with SMTP id af79cd13be357-87375480bdamr242431485a.10.1759309871064;
        Wed, 01 Oct 2025 02:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUmzUAc+cjv9+y3E3KgF6l5ePibQGjbOfi9JLtWe811uw6jRYJrLcGhg95ESiVfppfFFkd2A==
X-Received: by 2002:a05:620a:4556:b0:864:a09a:e860 with SMTP id af79cd13be357-87375480bdamr242428985a.10.1759309870577;
        Wed, 01 Oct 2025 02:11:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fcde4asm1337283166b.76.2025.10.01.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:11:09 -0700 (PDT)
Message-ID: <68a07e54-9f0e-4938-803b-64d6f0c31e5e@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] arm64: dts: qcom: sdm845-lg-common: Change ipa
 gsi-loader to 'self'
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-11-b14cf9e9a928@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928-judyln-dts-v3-11-b14cf9e9a928@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IJ1q6h1m1C_xK2EeZD0pfz0eNZ_Gg_Ff
X-Proofpoint-GUID: IJ1q6h1m1C_xK2EeZD0pfz0eNZ_Gg_Ff
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dcf02f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=j6DUTAs5CoFpl0bgMQ4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfXz7v4FS+B/KUg
 45ihY8QMU9rv1iYhKpkZ2SwQ4QvZyFUDt/W7pwJZaNBQBXOtW+zNWCJ7KcdxjAs3QlsvCjLly1S
 70AvOPoLzFOUzI5/HNFskNU8ZjUlgaBiSbBvL8hASTgjUB5bcgQmBWPT1ZNc6SrbCi53VDV36O+
 WEz8bx/NhXI304ZLEflHZRKXi0Dlnv1ZYMGaE6q7YtD55zIHBpOU/LuofeZe0gzsRhkyotp6BCY
 O0saTww9UtbsHYjBmHMresldI1njP2Q8aUEBg4h/Yxu79/5AG6OOolsfAun5WdVT0p6VK/pbLY1
 FdQJMuwWE8x6ngiBNWmW9/MfKISqVF0LsIACvexjoaMNjiHtPc7aR4fCyMYBwFabueUG4cRi8jr
 haBePuGTsiW05NBOK7d1qyrUuPOxAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On 9/29/25 7:05 AM, Paul Sajna wrote:
> This lets modem get a bit closer to working

What prevents it from working? Does it crash? Has rmtfs started?
Does `rmtfs -vP` print any warnings?

Konrad

