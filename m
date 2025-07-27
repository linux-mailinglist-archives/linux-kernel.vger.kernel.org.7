Return-Path: <linux-kernel+bounces-747069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256CB12F54
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D1516D668
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BDE21018A;
	Sun, 27 Jul 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q89WmYfw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868C1E260A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753615519; cv=none; b=nTXdFxx3IRshzC7fLBC6kQXdK+GlcqkJhaVxnqZXaZosrL2wNOX1zKXb33DHcAIu8pBFy3II99L0vY7CW3eqaWjD5dNDR6VYJvMYG7e1gDs29zrlt9+dQ7nfbnRQVtnJb/DTjjlQwgYZRTAvP8bYck+axcO6D3ePDnW0HfJzvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753615519; c=relaxed/simple;
	bh=mpicCbPyy9dZQR13RfrXUc9e1M5HBHhRY/bkK7x1vjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLLSaUA+yt+xW+4ExhR6mr36hnorY967JVBo9QqM+mKBQgJWUmghrXlOcLzpMaIcFrBVvnsc6Cey4+NwnyS2JAOmE335bkldyw3NrvtI9eCcSrQA+FKIduWCHerl5PllzwZ3uJvd2blmhIEmuIJmV/ArAQlxyI25se9IyFnKaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q89WmYfw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R7VtkC027753
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfJKZhMSNWDE28vPZNyTvcOOnTgpUT1dF1tLEjH+ZFc=; b=Q89WmYfw4DOBQLol
	HXZhb830aRzwUa747kEC9YifTj/wkA3q2bIZcgwtVvfdoZZHKXDmxP6bkDv7Z3ZP
	Rm9/MDUmfHojmgAC0IQ2WT04PVnhLq9TKKm5r249awK4A6PLE2y7Is+Fjdj5hG9h
	OYsPMsrDRtGAxJ9zi4wvX+rjhgsxfLZj/DteH6LL4+8KFj0GpDmhIOCJkMg++5vv
	IwxEHkLYGUEB2MkFpXKrrkMaoG5sbsPMaFVZTkE1QfETKUaOe8KydM9/H1hS5l1N
	E6WU4E/G6wtdzc8uj6i+ZWk41m9hxkGAio3xb4kQHEbLMYHMZFi6kV7iDfFapILK
	JVaAXA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr28yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:25:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073f12d826so16591136d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 04:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753615515; x=1754220315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfJKZhMSNWDE28vPZNyTvcOOnTgpUT1dF1tLEjH+ZFc=;
        b=ioNUHE/yaXDYvcIEw4ngeiMh5nFMFHK+K7CtNGaD58LzAzsg9mKxFQAciTg8S9LCuw
         tlhAZBUYjaYlbjnQEg5F/l0FFDZ1yexb21YK3VB+DuQ1+w9FzwByNGoZjaOEuB00DaCD
         MIhpNg74p2sYv4DxO9VEOXD/Y0qQaclST5SbzfDp+iqS0jJ4GCH9m7rARetumtGWkEtV
         J/NkiZO23IK8Yeej6uq20HQJY7D8a+EcRfYGlecjF1BSZeYFJyp9yzPO1K7e3Xudi5Y4
         kRFT5dflDPf3zjoo991taGmH1peiWD+a9Tv9QBv5Hh7TcknuTC1H6gDIFGhMjaCaO61I
         zvDA==
X-Forwarded-Encrypted: i=1; AJvYcCWfa/+INOAGidc4WrXKvYAwaK8WI/PeUwexCqaoXMEDcnmdVBlUUyXQAP19bJMUvbKj6mbuJf+u1mLZ+2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsTJn3HMXIsEmxlDo0nSYYR7kcysxncDOZN856ThP+odKUfY/
	n4Onhzhz2IfUkOSavAZeCf4gaSWfhqrXWbO0JxfytGP+rWLdckQXJLoy0uOn9fVJ75uK0TwdJlg
	M4fvUCGVgLCucPB1sZQARzYQetPttD+4GU3q8zR159IlzzRiLgSwDc5taV1PKURCICbw=
X-Gm-Gg: ASbGncv/CFG1GBYm9TaEF6MNvhygAW78CAYIvlQgGyvFVNeTOAjkceTKco+TXVQSGBw
	oazXyOaFXUkF1/DnkzPe9tlsK6Xm4dKv+7PEI+6nUrrFbEMY976tGEgKdCGvZ+GYjS4Hycvtuxl
	MzFW62iOgol+V217/JUsJunMnDsce25HUH7ANWxipoOmLhrv3o04pCYquo+/Zy82TRodMI3hNRf
	iTLhv1RSoAUozZ/xX4n3ivQvYIJD+hhN3s67/BsPYrSfU3EqZPWxxmdpUEfQ/oUiEd4Qmv+I04q
	ojjvVNzOIgrGEG8ZrF/YCpb7lMBgWxlHGIiTV+OB7BQd4EFUnn3DJxpXiwFRL6bkxgI=
X-Received: by 2002:a05:6214:300f:b0:702:bd34:75c8 with SMTP id 6a1803df08f44-7072049f3famr99229046d6.5.1753615515308;
        Sun, 27 Jul 2025 04:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkCofJ/1O0p8bOeiGbSGwSMF+ue6NzNwSlWHo2EXq+Z7g+oFlTe7pN+OBZy9EjswapZE4S/Q==
X-Received: by 2002:a05:6214:300f:b0:702:bd34:75c8 with SMTP id 6a1803df08f44-7072049f3famr99228736d6.5.1753615514814;
        Sun, 27 Jul 2025 04:25:14 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705c4cacsm114650875e9.24.2025.07.27.04.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 04:25:14 -0700 (PDT)
Message-ID: <8b3abd1a-4246-485c-9f2b-63ee37ef808c@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 12:25:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
 <276b7977-45d9-4b37-a4f5-1c65802ac267@oss.qualcomm.com>
 <mwhxikivaxtz5px5e7jkqtuuk2iz457fy5drsnaj32j4o5qqk6@hwkcjso4jpsp>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <mwhxikivaxtz5px5e7jkqtuuk2iz457fy5drsnaj32j4o5qqk6@hwkcjso4jpsp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDEwMSBTYWx0ZWRfX4coLwLPqC3xG
 IoasZdmBgwxYJ3CWRkln1ubbnedUuTKPz+ahmCeyzROK1KoMYmSYNse7B/uKxtnEns1C6IUOjJi
 uY/MIKHstnGVgcEoPy4NAZCFKL0fdzHKuPBdpox/aqbYB5tqCGQHjhBVY4rGC0E1qsaQhk3L7Np
 /DsfGK8cCs0oK+PP7d0CXQFT77ys7A85j+rOrF9OcJcbtIcLWw4xFV8IU0wwIqRqm1vnVov6GMp
 KkrTvVCnaJ+elmtd8vocx3g1uCFNLXJh3d+jJZ4eQpGS2Toyc1JU9TlkAOzxEno1WZuqBX4bQ4E
 m7jeBw0tZzEG/vuLLlFRUC18/kqv6xKH4z09JaDDLDT9S1wkpKSNk1EJU/V4wDfbtLgWwU+fDH9
 HM5nUWVbp0GKTGLqYEBVZmGl09HuqQEsECbaEc2+FlcYk1ohoC7Z1hEOnbesWp0+AvZ2LuXU
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=68860c9c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=XE7kxn0J_hhxY9Cja4kA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: q7n8gaIKFQcbYGCUmX3Qbt_w7xZ-S_On
X-Proofpoint-ORIG-GUID: q7n8gaIKFQcbYGCUmX3Qbt_w7xZ-S_On
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=700 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270101

On 7/24/25 3:24 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 24, 2025 at 03:31:50PM +0200, Konrad Dybcio wrote:
>> On 7/24/25 3:28 PM, srinivas.kandagatla@oss.qualcomm.com wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>>
>>> Qcom Slimbus controller driver is totally unused and dead code, there is
>>> no point in keeping this driver in the kernel without users.
>>>
>>> This patch removes the driver along with device tree bindings.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>> ---
>>
>> I *thiiink* this is apq806x code, with 8974 adopting the new hw.
>>
>> +Dmitry, does you computer history museum require this driver?
> 
> I never had time to try enabling audio on IFC6410 nor Nexus 7. But if
> the driver would be actually useable there, I'd prefer to keep it.
TBH, I have never verified this in full audio use case in any of the
qcom platforms. This driver has been unused since it was originally
added in 2017. AFAIU, no one is using this lets remove this now, Am
happy to take it back if someone has managed to test this.

--srini
> 


