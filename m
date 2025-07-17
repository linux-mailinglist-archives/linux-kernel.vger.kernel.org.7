Return-Path: <linux-kernel+bounces-735965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED6B095FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52E3A44D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43872264C0;
	Thu, 17 Jul 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PnjB3q+z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC81FFC6D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785479; cv=none; b=OmrwIKdfvFJFJMpRTsYPR0zzU10JGrCCsXG4BbcktuWDtKwRd9V+OQgw8uPCOBpi7PAXP1+dK5/c0/Xuowz4YmWcUO3fcrUNTdpNkIRT5A6pEMKrmGNHPCs3m4yg0uJfZI7dj3xfGZ5Ez9P7/7e9lRAGPzGtRrgaylqfGuyD+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785479; c=relaxed/simple;
	bh=ZzdB0c9lS+Bqc6XkxukHQJDk6iL7AEBq0SCr9kWt5Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSDy4FTjJoaPqfJMLjhCwMn2xvuUitbme8Dl8fFGmNRHIQ9yCVqzgo7NB4d+LBfr4/MTDFptAEnev9pzxgK95BzDLAyUAoj03xukHDyVjEeV1CNPhOz9/SLW5THeixKCgyj/SI9uKvn/NEXuFDQurgArctpN4H9wKE9Sav24Tz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PnjB3q+z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCdPE7028066
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zI1GQsP3FtlWSvO2Fv/8SUzJeJc5OU5sQJ2EHFJlKCw=; b=PnjB3q+zCE/jGSpK
	vqHLp8hghvN2yGoF9XpPQXcjYL2X4IpoEK9Zg0W7DNfTwXFXP9mqfm7JchXSknT4
	oqlkwiUQQr1cx0F5L2DlhiPR2rE56Kb9MvKw0uyWUpHOjyB6jWT15Elms/N4rsJJ
	f+JY2CkGQCiVbxHlAUSTgjbd8Ec9J8w4vtskDWm2WIBcymwzvumavq2zxEnH0vBQ
	cl7XzMq1hMaU9ySLSelSDJ8iHPeW9c29RBFQ18YRvBIwnVhCsODBr5uPdvnbXs/W
	dU28SqxQGMZGU7fMVAjNfQEGTtbrbauPA7rRc+dfeUg8Q/hiECZmSTKjneIb+fU8
	+xSJYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh61d78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:51:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2ced79f97so25306485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785476; x=1753390276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI1GQsP3FtlWSvO2Fv/8SUzJeJc5OU5sQJ2EHFJlKCw=;
        b=ZZlAl210D6HTFE87IANx7Cs7itKCgLKQ5JZ7uJXipvy97E0agsbxGPReYBnDwk/sbd
         Eq/f7GKX4J6yZBqxCxMWKcZF9lHYHkG0DqTMf/ZtEgqL7xJfwK9Cim2AUwDh+OvRpAQr
         Vc0IHlsAsuaE4zvnJUbxHZ+YiJArC4OSxlA3tKNDK2OtF9POkYtSB+tAl6KtEC+utTbn
         FVLjkqump2rQ6fQjDcigFT6XEaJuKNFJJ13urwfAa9oCxD18+7q8+6uHnyf+WlPAf9gZ
         RGAHgT8Z6ll3ERDQk3dd2cE1WCCtgtfx1phpL/k34yZvzzFy8QWiPuxA92VrRvD30/Ya
         f/MA==
X-Forwarded-Encrypted: i=1; AJvYcCVkhUs411CU7KLrc49PxhGzOro2yWI0Y+66NfwofKzOxeBgLSHEEoXL/Fg02Ia4p9Tr1sAap4HEspZPm2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfuAjmyECQiAKQ6LbqVAbrqREnaZUODP76uQCtRunCBtXBF32
	SnU8kaNMeDoYTAQGUcHBOO8NjDZgHiTpvyIji1hi7OCQ4ipwf/QL4p91mtXJLvSQYNR/drQiAUy
	bt7SmMOP3zXhi0lWvspQ8uA8/ISvDHdCTAToq5uymw05uVKGhT7QvpbwjmbW2+8MXqnU=
X-Gm-Gg: ASbGncvx7hmZSLS8NSIpmrjMDXUEVyzkqwUYbEi2amdd+wKjOzCMe7n1f7y6p0R63gl
	75NxVqkijlgGH/lLFNXMY4D8mvuJCN30wMozU8Te4ag5pOl6D1moRqwYsX4qvTqGRcURzL+Krfl
	fMamogU+U4SCdP4/XAReEmJTt8g3Gr7Mk/S1LJIVlJVlqB55l4g9VWVGfunLssOdgv2Rhh8PYqQ
	6SJQAwwgYLZyc9x4kfsQIiddAO6yd9Jb2gQhDj2tlwrxd83MAlcxHHuB399ijK1wikIhdTAo1dc
	7j5WAoMwb8eu8aQe5f08Yy0vh9Zr49hgiJhqjQRqCbAkTQZqeXHT3t/Lox32nBtVMcgjLkgWIUe
	kDXjdTx8RP7IhTCkgo4jQ
X-Received: by 2002:a05:620a:288a:b0:7e2:5349:7da1 with SMTP id af79cd13be357-7e342ada387mr512190785a.7.1752785475658;
        Thu, 17 Jul 2025 13:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1oOZ0EIsupcE2PuNyin2lTsXVWnKq+kC+fhAHB0zn97Fx4BA87XhhMZqt3iqSgMkwZ2vC5Q==
X-Received: by 2002:a05:620a:288a:b0:7e2:5349:7da1 with SMTP id af79cd13be357-7e342ada387mr512188885a.7.1752785475094;
        Thu, 17 Jul 2025 13:51:15 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df540sm1406774066b.163.2025.07.17.13.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:51:14 -0700 (PDT)
Message-ID: <ce888443-c86e-4353-a4e1-64f2cc62604a@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:51:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: i3c: Add support for Qualcomm I3C
 controller
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jarkko.nikula@linux.intel.com,
        linux-i3c@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank.Li@nxp.com, wsa+renesas@sang-engineering.com,
        alok.a.tiwari@oracle.com
Cc: andersson@kernel.org, konradybcio@kernel.org
References: <20250701071852.2107800-1-mukesh.savaliya@oss.qualcomm.com>
 <20250701071852.2107800-2-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250701071852.2107800-2-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68796245 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=JRR-jv_DfJOeuxYAjpkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: dOHzVnA7c8WlXT_jXpcruMcY_zr6ewAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4NCBTYWx0ZWRfX1yFS0j1fr+Df
 uZ8y0REnJSvBSyXG7mdrSC3AcY66BQOmQAf3ApQlZlJceyE9XUfGzRU4KuJqX16teB5YGZbCmVY
 jH3GIVJ2lL0aqVBtSy1I+45Cn+u+HS0RHBPUwGivUZVXMFK9yXosoZpzI5XlusGTyqJdlhY5WhS
 TMyqg8AOVHpCFsIGqiSfxtqK3adxxOGZibS7td+bB9qRecjmFVUlSg4rqvAKG9+G13GcDZ+rhYL
 d34v0zhD+ZMW99Pcd8629eX/YpdtKNK7/J0YEn4IlW+yZ8BXjKJtnLUqQerGKVdfkUDU5ApXAie
 4asDeBhujKe60rrmdwnNVRE6mgGbzHoQg2e4XlYWJ9hePH6zMPsoB3Bb59Q67LOqGLf6jvaPlmi
 0JM4henYdvehS00Lg/RXXu7d8BHJKPWvZqvMiEPeb9uIy3WGUhmT83oxKiLCR3ehKAYh6/li
X-Proofpoint-ORIG-GUID: dOHzVnA7c8WlXT_jXpcruMcY_zr6ewAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170184

On 7/1/25 9:18 AM, Mukesh Kumar Savaliya wrote:
> Add device tree bindings for the Qualcomm I3C controller. This includes
> the necessary documentation and properties required to describe the
> hardware in the device tree.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[...]

> +properties:
> +  compatible:
> +    const: qcom,geni-i3c
> +
> +  reg:
> +    maxItems: 1

In another patchset, you expanded 'reg', can you coalesce that change
into here, so that we don't have to worry about backwards compat?

Konrad

