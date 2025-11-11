Return-Path: <linux-kernel+bounces-895611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D1C4E7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B119F3A426B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445312F12DA;
	Tue, 11 Nov 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGgsmsp3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ilqxlCWz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109DA55
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871150; cv=none; b=DS7FWXsVYwCFm+OrEmcc//Tr8C9fMWDQzzd9CNTMJB2+2BkHMeyPc0wUtOWb3sANM+Mt6WPs9xXciAMBTexb82oE/tbG67N/JPfGPXJD0tB4tw7fXw/A+ogpL7D5mI7boVFNsLKxuWd2+doEGCuVPWPoWgSNUJv139VoT5dDCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871150; c=relaxed/simple;
	bh=ZynVm5GTjJ3jV5ewXN1Dx5baeS9+v8p0cOWdmi/XlNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B62sxMDHcvKobIlkpNlNhl0mPn6cQfGsY+ndIO1qu+dqqql9u2RihJmzvb3x1Ebd9VZJT/nt9nT/X1x/h/cum37Brk34btPa4RHzJwboIwMTz0QLa8mB5HbMCFcYsUvOFBIESw9p4NW7bLdoVwGKq1iYRknvBUat+FrcICC+2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGgsmsp3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ilqxlCWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGBTj2165250
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGa7B98r9MqkGDgKlmDgrSnW42cjpgklRI/2tR3rrb0=; b=DGgsmsp3z5Kly49F
	2Hq/3japteXVdZPaeIYVZvju6RwgCftm3mwlfB5kZrBZWou2alIVyDiJ8gra/AKt
	NtpiSahSi/l9VMHGE3iqpp5/Z/mNQW4lcrVFjs0l8IB8Eo0+8fhBQBGUYJR+VO5E
	VTXGwe59agQekoRbgea8fGGod+LVAqjbQvsN7tLsxWYmq9mJ6RpOg054zekzaszX
	7oKmwQjXANhYnkw/Dix/5sc2qB6H/L8Qa6KyE/aKSFYuPecUakEW5SEf70FiMmvq
	9jl7LKoTmdduSKy3zuE+u8GXJV5aNOAFxGyBp4i2KZYpkxWRKK6eNZn9AWRurky0
	kWM9YA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxhhhj0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:25:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bb1875e1416so2232857a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762871147; x=1763475947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGa7B98r9MqkGDgKlmDgrSnW42cjpgklRI/2tR3rrb0=;
        b=ilqxlCWzdnBvjL1wf+S7veMzVqRVC/1kphvJwp0tGJ/mrNpeNx7AvERarIzJht/HHj
         h2LyH/yx4HWahQnesNSc6c+M+yDxXYW6lWymENinM4Hn+dmOiSTKk6Whmkca8I6njTg0
         iPrD5KYocxwr52c202hHOII8+i3vBY6o8wDVexRF+PwkuutpKkdpcjDB3ys+GymO8aZL
         d6I4VPVDp/b+gF95WOkqcQCqVeVE6okjoJEiwGe+oWmR7BTSpF4frzSmbJLb94sjkYzJ
         AUNUIAno7fRiQlsaaLxjCQmxKcAd3zw2dMRw3GiXTMXQPqUf+4FSMBI8lrKNxXJRdjR6
         4ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871147; x=1763475947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGa7B98r9MqkGDgKlmDgrSnW42cjpgklRI/2tR3rrb0=;
        b=PwXAlsp0UNHfwMJhYiiqZ3FrM5JDtX4d2oH53WVEL4ozSH8XATaaGW3gYKMuJCvG9V
         Mfgz64zwBfsR638J9udELaIp6vyfEv6gTuNlZAJ9f8z/V0tKtbd2BRbdVn9uUs97DWZC
         OR7TKEcTLEHX6LfK4ium/Cvw/RpYr0cvHeP+gCMfmX8Quxmr+JGjEMCVXTWs+pFTl9kf
         scot0HisAKo+SZ+ynZxO9aBonGP2xC3vsdErCMZ2/Gc51QYzLN8qASv+T09BEX2QSFxO
         DB+O+fjmpOpPRMaTDYcPTVvCNR+T8SCDofWz9N+Dc7UPTrdg6teIp5Al26XqTURYjoGE
         FnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU42PXZBkQBjv1Y46OrDJWduK0gqWESOpEHso3LT9wa7nYwtLcEYmwDdXrdfDvYUs7rFE2HYA+99chl/uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAWv7aZoQLmt08XI5m6MLO8RF2imQGGsoO4YjyxdS4BAGymz2
	V+KH1HDm3XR+pdmRWjobenL7zKN7mFPmxikwDGoa76iJBU6SQ73/IMb7ThyGrJSV6QrEaxL64gj
	1lAgsCSOdu9aFYz61qPCufw3P4Htwpxck+PZYI+1KGrsgj/wdPx8ddGIvocrcuH+F1xo=
X-Gm-Gg: ASbGnctq+kRz2iyglNhruCZDi6sMvzcBxAVWmSheS4FlUIazMa6FnWPVF+8q7WEugBP
	Dtn0hnNvGe3Hi5nfg9kuVkQMILQ6B4GG5c2aAnbV1qorOGWawCuE42R0YTcABTTHQYiLAaBoKXd
	0JigGEkqJclRk9i6qgIhEswZpvZIQjuQWZES7virbzQnSkJUw8HdRl9nGOXnKsWfyJVSBr/pBw/
	qGcTMPldtDr+Y4y886+VIh3rQkgK22YsOlabV/ZH3Pz/SJHDs3uS2FMINpGP3EzUqKj8rS0AYEO
	hHAzCeHDd9WRmxcqBZSKtTiRZfwO8Np9hseTQosW+26uExFotNi3M9273DVKlieOqYmCi5q/W3D
	chVZj3902KM1zAROrJsKzpA==
X-Received: by 2002:a17:902:ea0a:b0:297:c638:d7c9 with SMTP id d9443c01a7336-297e562e197mr179715515ad.13.1762871147464;
        Tue, 11 Nov 2025 06:25:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkROrZLUIRrbkgoTAgkprVjqaX7dHmwbXmMslaYaaMrgNrailMFiy5g2vGuUSJjGn5syzSxQ==
X-Received: by 2002:a17:902:ea0a:b0:297:c638:d7c9 with SMTP id d9443c01a7336-297e562e197mr179715115ad.13.1762871146970;
        Tue, 11 Nov 2025 06:25:46 -0800 (PST)
Received: from [10.206.103.12] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740a9sm183312755ad.53.2025.11.11.06.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:25:46 -0800 (PST)
Message-ID: <ad372979-adab-4486-ac69-90a9df1ae512@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:55:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/21] dt-bindings: display/msm/gmu: Add Adreno X2-85
 GMU
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
 <20251110-kaana-gpu-support-v2-20-bef18acd5e94@oss.qualcomm.com>
 <20251111-magnetic-jasper-slug-3abc3e@kuoka>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251111-magnetic-jasper-slug-3abc3e@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pc3yRyhd c=1 sm=1 tr=0 ts=6913476c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=3RWeJ3mqlPvKrM-9dKcA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: diMY4M3rSshoBDU7JioNiB1IU_E6mRvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExNSBTYWx0ZWRfXxKhK4rTkgWuF
 x3tXWV+L4Xhnp0zXR/Ks25Dg2X+If1db9omvRdrblA5G3LpU5AvqPCk6m+qK5zNhpku3gYYNb0E
 FLmtR1bvC+IBvMisVv7J76KObNUqRkqq+Xsd7dCntIwZvlX2Nql+fm0wxtMebrRNOQ1x30JxXbF
 uYVXTJHetIRAccrZMIUU/pPpk6UgbtS2w3cL8eZ6X0PfjMFkV+NWtUxXyu6KfkOqpjeIDWkGbYd
 MVkJFu0qpAat9xSVFHSsLt2VSYTlyVFGcF4KlZTElebyf6GcsOS2hGr/x4u03RftkIjrXYH5wO5
 yAd65wHIkt7dWAptR9JOe/ZLCdjCu8Dg79YbKyIAFpYcoG6ECzsOeVRK+yAJUSz6y1OkjWCFTkQ
 VG2VX0rGq5zfSaQVbhqZN9d2CBy2lg==
X-Proofpoint-GUID: diMY4M3rSshoBDU7JioNiB1IU_E6mRvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110115

On 11/11/2025 1:19 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 10, 2025 at 10:07:26PM +0530, Akhil P Oommen wrote:
>> Document Adreno X2-85 GMU found in Glymur chipsets in the
>> dt-binding specification. It is very similar to Adreno 840
>> GMU with the additional requirement of RSCC HUB clock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 

I think you got confused. These are new patches I have included for
Glymur support in Rev 2 (as mentioned in the cover letter). Did you
confuse with the other patch for Kaanapali?

-Akhil.

> Best regards,
> Krzysztof
> 


