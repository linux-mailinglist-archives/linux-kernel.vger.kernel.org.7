Return-Path: <linux-kernel+bounces-895614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE88DC4E80E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B547F4FD140
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D8D54723;
	Tue, 11 Nov 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELmNGRaY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGVdv98e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28B2FB99D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871236; cv=none; b=RU+zQA41cxFvj4zMba9GHfBSq+8jJFX+GKYjNAdqpvd2B0i0s7gzkAmHATua715XXNS6arn+XwnYHE4W1y3R6lMohodhAmbayvopgeFrWyD5She121TtLi7UENUXPaocrvFNsmtUxhZ+fy+mJkgBbNzsP53ZaKLaUqggerldBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871236; c=relaxed/simple;
	bh=At3jsEqPyxFdSaRWeiEomMCAUDUz26XIRWm1MrjFu5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3xNUy+x1/j0ag6HvI6s9bGkHeTR7pIXk5a79MCVrluSAuImhUAMWscCfFkEDkkmuFfEL9NUkAfksp3iwiPb1ZjKhz+uEaRn/C1Tw22LhCvi9b+/rAkL24dPWHA8zVyjny7GgPSmBneBGfH592DAwgZIlIUkUPDaSkfJBcw3Wr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELmNGRaY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGVdv98e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYZe1937346
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VLUjnRdYKOuu5qj1KoQzXxsr2RycgjfhzOqnzAirtEk=; b=ELmNGRaYr3Ek/O6D
	IZP2qD4dyHqpwVTbQTB5Yw3o7cHSgiJmwqmKEAZZuu/Enh+gW8oEjFXL/nEAT3Kr
	BF3WhBOaHZgcNJEUMFuq6hqLxo8WqaeE1epEsVy6qbmYVSYc9PWsbkAIXUpnh+Gn
	FjjokjwRWSwj07XNlHaB94Sun9WFZfj5zsYISJ7hHCGfQunpODwWgXSfrhtoR0g2
	DDJvIWFa4vjpKY04ixCA4UYNl5IsESmhuJhQJbJuUqxwr5P5XR5DfoOHWvKn5tCo
	CfxfwSfKOxzJdYrZs6Z7LeJ3AevlDHLGPuwe0BXz/SyUqlIgLS7uxuvJ1vt6H3fD
	OGAqFg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9pjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:27:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7ad1e8ab328so3608945b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762871233; x=1763476033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLUjnRdYKOuu5qj1KoQzXxsr2RycgjfhzOqnzAirtEk=;
        b=GGVdv98eKxY3Hc129GA73zrElAiyg3hm6R/8uA8JXf/kP7R1nQsNMzCtxXn+4OVqto
         bUPnB5jbSsaZIygVufpEvNboQrclTCMknus2ktopzzPUvP2ryHt4vK8hyl1qd8vKxfsz
         kI43HxgVSAk2CdNmWAhWjtnnu2OcGhLmBSJTtfNNuZneErMMpBafn1nrTzntMbkxsr2r
         owfbFi/IoypOXFzqACqk5qKJmw4CCQm4t0/Of3gkYZ0aWgmpoWVxSnuguxHOfOD7Syja
         XTSN//6DCQEDzXfXE4q3BEgAsERM88gAlwtFB8XVviXdUsbHSOlMT3/o3Q+g0tTVlq12
         7xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871233; x=1763476033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLUjnRdYKOuu5qj1KoQzXxsr2RycgjfhzOqnzAirtEk=;
        b=hiDoHtCMSo7ruKPF8Btem2KipdrTvyNlZpes4OuqRNWYuQtmW9H/j81nvF9eGr6kPR
         53jAXsmqrIPpu3xe8752I3IJ5HvoVKuLIoe+1PDUVEqt/enafvkQrTWealib+NLrg6cf
         iuHoUhXYCkEiLr7r2xZAgfwiI216HA8SY5aYy1bygdGRTfezDlr4rIfAh67KFWKuFUgs
         beCQfqthZpaQcoQe210PVt2HmJEnHfRdqDBfs5z0lJjOB4GhDu+fZ+uyGmaFit19FWVk
         q89SXT97tyqb7a0rpAqoU0Jm8Y6tKnUFXuzfqKV+052FA0UBeaZ1Yxm5+ly7HgMG2/os
         oK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlBx+uLc1as9S19jPQx64L0g++tah2qGZVql1uUnu4/fup1VMCUOiSWk8ugzhZdxRxHS9+blO0c5rAYrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjsVxa9Q1cp8S7oUH/3Wb+3YftO9wr2JH7iOsRuPyoDyv1upf
	ququ3LBentVNsUM6t3uUbiLqh45AIkXRBoZkcOd5Z0LqyehVUqlnw66GzbG7+YN6B7BlIGd+G/G
	jttb4PD5w8XfBjbSXx2wl0VqyiAQ9ax6ksSs1HnQGtrF3kmMIPUVnPNz73TC3AHGvhvU=
X-Gm-Gg: ASbGncuEDC1Ra50FVn3rGSf8KmUZ1Zn785rz2V3kG5N79BnPGIecA8jjLNoubgtp6VV
	c4h1SU+vsGhq0+8hkBKykT8sWl5odTCuhydbc2Si0arSathIgFDsXmaeS7Nb75nwcIa01NSQK/P
	C2ghLwYg0tcJPIo/Ff6zp9SIM1ceybCgaAJq8VSjdQE2rZCzkj2Orwj1O/M69si6vHj5nkSS21b
	Vcd9ZeIP9GePwxRDv4SOmVsPUJyLN+tWW5C7Q3Fn7Mtz7FUBQw3uP8orabVoE8OpfF61fyl4qsx
	x+RozVFgAGf3pl9CwbNY4EhWiLSiNSH2msKufU0ueO5IKyDQ0j6QJJuWI2vlPJyKmb8/jPIs0A/
	g0O2XlRL/AJGKzQkLfHnFaQ==
X-Received: by 2002:a05:6a00:b44:b0:781:17fb:d3ca with SMTP id d2e1a72fcca58-7b2266a8d96mr16270342b3a.15.1762871233000;
        Tue, 11 Nov 2025 06:27:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGS/7Y+JCV0WL0rDJJwpThYAOraNVEcFIM32zGMLfnISD9Q77+PeHDE8FGvMX6ZgCVDRIoTA==
X-Received: by 2002:a05:6a00:b44:b0:781:17fb:d3ca with SMTP id d2e1a72fcca58-7b2266a8d96mr16270287b3a.15.1762871232438;
        Tue, 11 Nov 2025 06:27:12 -0800 (PST)
Received: from [10.206.103.12] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b75bda9f77sm100571b3a.15.2025.11.11.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:27:12 -0800 (PST)
Message-ID: <08f8de55-52a5-4942-9a39-222fafb093a5@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:57:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/21] dt-bindings: arm-smmu: Add Glymur GPU SMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-21-bef18acd5e94@oss.qualcomm.com>
 <20251111-mighty-aromatic-urchin-f80cd9@kuoka>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251111-mighty-aromatic-urchin-f80cd9@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExNiBTYWx0ZWRfX1YfQyyjykm/w
 00djR9RWk287iEVpxJ2HnZPhB1sbGPj2Z+iDxaY+hxPu/8Qlpj88JTGGfdfDeaOQlU1mMgIdFU7
 ZXTY4lV2Le7tkKdEP6yaI4Inxl+qlZgu7hu/T5wSP3MO5eAtPN6XnN8byNNtFC+VHq1Yx8S3vV7
 kqjzp4AlUUTdVWTXUk/B0zL0atTvp++j+cYHXMWxhb36EU3gUeMO0P5x3/5K1Mt7H9bZWw2WuKl
 lQgxTxB9sKgF1rF4VpjJrhVtWJXwPEyuUTuqWsYH+I0QQeHBDwYp3v18YqskYxZi92EcCrgECgF
 PRlHd1T+h5UFd9R8o1FBV4L3GBDBGC76XucTMZyOw4hkpujhRczbIWFijtr5LeW6dth1cLoIzES
 6+S1leibtrS6LFNOoGFa36xNPZ/TzQ==
X-Proofpoint-GUID: oEUDVEP_nom9nsEEDETz-17W5FRKMqU6
X-Proofpoint-ORIG-GUID: oEUDVEP_nom9nsEEDETz-17W5FRKMqU6
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=691347c1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WzT3ZZK9S2hwGh7ljtQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110116

On 11/11/2025 1:20 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 10, 2025 at 10:07:27PM +0530, Akhil P Oommen wrote:
>> Update the devicetree bindings to support the gpu smmu present in
>> the Glymur chipset.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> So you ignored entire review? I drop the patcshet from DT patchwork.

Same here. This is a new patch. :)

-Akhil

> 
> Best regards,
> Krzysztof
> 


