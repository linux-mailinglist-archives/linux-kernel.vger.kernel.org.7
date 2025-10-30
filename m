Return-Path: <linux-kernel+bounces-878741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF2C2161A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BA84002D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19C2E0B44;
	Thu, 30 Oct 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGmKKO+E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U8yq1Nxj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514F26AC3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843979; cv=none; b=LtInpbX0cY87dovasKdEgcvgZvU8DwDnYLgtulAqV0ZtonhKzT9H6U3DKBVsi8zZLV5Zgxpk9XbN9spz4oA5P7qjwGOIaGmfaKuXCL1AfvdKnpfxC4q/RO965/m7OcAck+PD0E1rGjDGb9ruV7fP9GByv2is1RUf1gkJuumHvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843979; c=relaxed/simple;
	bh=LvR0uV2UUFEjjW8GoIT53Fs/684GGpnkAc2fKO9ZbTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/VhzYtx9VxQUjGPKhxL0CqAPz22LTaFAxCREUFPh4ERHlbJ+sQ8LbshJYwaUEqM6RfAon27WEV333Tga8aeE8JLjureguHGz5/WlwY3ZRetfsTc5yCIWecoNTtPcS7g3G+zuZaZgwG6ly+WRuphJaE4e/XZqTScz8J4pm4477o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGmKKO+E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U8yq1Nxj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UAPJ0I3281416
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RQdiWSs1pdAq16tCBx6T1gHaJtXV5GNkrGHabI2OIg8=; b=RGmKKO+E4/IgzYXF
	UqQN3ci57t38sFZpHrc7kOnAmeiTEQVi/DZUBZ4Hj681989qjA6Y3DFklW4Q4eep
	nuboUKLPQQ8LFxfyN13dJ+JkiN4YtpxvJm0pORxCKmjmdhgWpfT95MXExIY7SlBI
	5/QOpzeRRUSH0l0Y75228Td3lD5Rs7CxoGIhSSLowIhBgU38cIQ6Dn5V14U7jUR+
	Lgt8YKplKSAFAQ9doaVIDSpkG2On7L6BMVHlA7XLyEgLJsCNs283+w0FhYjhmQal
	U1sicJL66EVvlFoA4eHoJ21WLjcXjCYg4dbpGUA9qRrpqnHZqTpKtqKiK73rbR9N
	crjsxA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a468kh442-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:06:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2930e6e2c03so12951175ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761843975; x=1762448775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQdiWSs1pdAq16tCBx6T1gHaJtXV5GNkrGHabI2OIg8=;
        b=U8yq1Nxj00WAGdiB8Tzv/nFdLorkHXTwPWtkn+ODkTXfxf1JyF9IS0COi/EifgZHKt
         9zw8c4Rgnq9r9GjkZl+nUX1kBEMj/4qcjObVhtXPUIkm8KOJsICNJFmSSK+ZnRYxPyDi
         HqUShdsc9hgEp/9X3l1+G4M2AgDLE1G3JVows9fUXw8yZ8KXTLcZwaSIULfQauNfxle6
         uJfYhjsceIy6NGiCVTXxM1RMtcRL1iGGtfWgyCDMqxkspkOmt61DV+Nw6ZWcBVyloJW9
         ZLx12N46kCvlUFL5xVq/LWh+/X/Xc31S++0NayFeHkKrs6BgUkxxVyIGRecDzm2/AKiP
         Mwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843975; x=1762448775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQdiWSs1pdAq16tCBx6T1gHaJtXV5GNkrGHabI2OIg8=;
        b=ePHp1r+Y+CZmDgSjRbje6CM4gNq9jhqIvFe1FD5w+RO9oa2YJMSdVASg3eIDEWPgJ6
         uMdIZ6e12lvObA0NaFouvLwENSZ9MoHsGTFXGpl7zFYjWNPy2tHIjXY4vKfE5yU+AdzQ
         V7jIf44UNIE01RTDq8yA3vKZ0U9COtuseffeBUBAqf5Og5l/6bFCgekUNRMgVASx9MHE
         NB8AGbEzgDYjjbrTIrY3LEo3/9WZzXMPpYxY9QXN7DFLnqzbsf7YFOV7H+ib+pye7vlW
         W8CHUtPKakRnVjCsJMOp3eY391cYrA8iPwkbbEFcD/UXULVVx+PSOnPESYWODfeYBr8S
         R94w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4THTbqV5HiOhQSrdn2FaP4FKyWV6IZX8gyaQ8NOMNbDRskJPs1cnaLcSlmZig9R5rksoIxmzPmeSJDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9RAFggw5KYBfAKkaIH5R8sN14g6ou1WwFEveB56cblqwMwCE
	yVRIaDUT2rRrw8b8/ywNyeH1V2eWncZ1tgnpcE59F+VQNan5FbICQkRSu69QQN99r5qRtiXcdQX
	//Wav4BhydEkXjAUzIyZE6raj1q9opuXovcgcw4SBOvrjUOCtwqyWht4lNAfBtgcS3eA=
X-Gm-Gg: ASbGnctbMNT8NAJUTLVfZYKpGbgaH496mLRDL0/qXzpoI8GnM5Rdy7ZlNWB929uVho+
	RbS9wxNVGJ8Xc8dRweixysTsTihRiBM/zoDYm8kRBl6qJ5LALSF1bOyI22uphzD7cWczQm3OCFY
	+2EhEvw0RPqK1ivo9zobyM9zX1U2onjc98QQISrGPW3ZzZsJArjympHwbZZ+iz4erGlcVujTwrD
	3/pXCNUDnellONDnvyJCEE7Jz4tm3fkYuuJu9oDWgrxJ74P/9gtyDUHE3dj93QfGvHThs26UciV
	3DtS+EZe9KT0LvPLv0+tSEaKdh0X3kTWXF8iV84B08xf01iajtpqRoyIWjJUQz+BVmCP+V/TNmU
	a7qGTgyL+7gTYxhtNrR348l6Jf8g=
X-Received: by 2002:a17:902:f644:b0:275:81ca:2c5 with SMTP id d9443c01a7336-2951a600875mr6526795ad.59.1761843975084;
        Thu, 30 Oct 2025 10:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmWxDYd8AFe9Hj5FT5SvFYc4S0giUKw0u/xBUp8Hfu1jGx/wHegd1K6+sYRoSAbI9+qYjVCQ==
X-Received: by 2002:a17:902:f644:b0:275:81ca:2c5 with SMTP id d9443c01a7336-2951a600875mr6524995ad.59.1761843974115;
        Thu, 30 Oct 2025 10:06:14 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.28.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3465sm197299615ad.1.2025.10.30.10.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 10:06:11 -0700 (PDT)
Message-ID: <41e31da2-5ea5-443f-a8f3-ef8280f25a00@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 22:36:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] clk: qcom: ecpricc-qdu100: Add mem_enable_mask to
 the clock memory branch
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
 <20251024-sm8750-videocc-v2-v3-2-6286bbda3c8e@oss.qualcomm.com>
 <102d9042-49cb-4aff-8b93-a882ed8da27c@oss.qualcomm.com>
 <e308a74f-1724-48d4-9d1a-fba6d06a29aa@oss.qualcomm.com>
 <98da2c17-764d-43db-9b13-d950078ba41c@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <98da2c17-764d-43db-9b13-d950078ba41c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0MSBTYWx0ZWRfX3uUte4ZspW95
 iYat7XOAi61IiFRVla2SPf0nNt0OGKlWIvqgo2ah/0OjJWbSVVaZSpmR4KNcVZzhPbRKPyyHF6x
 pnf0Lh1K7AHKSLX9q9JF9LGXYocXh1PnKTjDaCoeBQkSFeNjPq56MyOJbYAXAZweZq4p8X5U9Cy
 muJheJDO60n2dfK4sw1iUpyIRtSQcTXMZmUuTW2o81yyi0qnf8JdeuqMCYSk5BrULJ2j6Ch1iSW
 gH2VC88wYvQOiogkoKSX+2BLjn1hYU2/kwicXVdltkxWdBH45CDFX0ACLvgrzGV9ZdeP6cRVcd1
 obVp7JNjnV+DxY7VUZwrNnvTSKEIR7PliMMxeWNVLDT4xlwbzeKSBLnEwoKGsr4rQbD3OaiTw0T
 aUSloq8CAGXGy0CM4e9eYvfnN7J4vQ==
X-Proofpoint-ORIG-GUID: lGW3Y16R98eriD_3IsMH1eWK_fORvFid
X-Authority-Analysis: v=2.4 cv=LoWfC3dc c=1 sm=1 tr=0 ts=69039b08 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=kYOnW6kYNC4MuwyOue8uGA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ve3y1cz88okj8OIuEZ0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: lGW3Y16R98eriD_3IsMH1eWK_fORvFid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300141



On 10/30/2025 4:41 PM, Konrad Dybcio wrote:
> On 10/30/25 7:24 AM, Taniya Das wrote:
>>
>>
>> On 10/24/2025 2:09 PM, Konrad Dybcio wrote:
>>> On 10/24/25 6:24 AM, Taniya Das wrote:
>>>> Add the newly introduced 'mem_enable_mask' to the memory control branch
>>>> clocks of ECPRI clock controller to align to the new mem_ops handling.
>>>>
>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>> ---
>>>
>>> This probably fixes some ugly issue, could you please mention what
>>> the impact/problem is?
>>>
>> Konrad, this isn’t an issue. Previously, the ECPRI clock controller’s
>> mem_ops clocks used the mem_enable_ack_mask bit directly for both
>> setting and polling. However, this approach didn’t apply to newer
>> mem_ops clocks.
> 
> Right, the videocc patch you attached makes use of this. I didn't notice
> previously.
> 
>> Based on the feedback from v2, I’ve refactored the mem_ops code to
>> handle these cases more cleanly, which required updating the ECPRI
>> clocks as well.
> 
> Please split the changes into:
> 
> 1. add new struct fields, explaining the reason for the change
> 2. update the ECPRI driver (so that when the next patch lands the func
>   isn't broken)
> 3. use the new fields in clk-branch.c now that all users (just qdu1000) have
>    the required data filled in
> 
> So that the platform remains functional at any point in time (which is a
> policy because it impacts bisect)
> 
> 1&2 can be potentially squashed, potayto/potahto
> 

Thanks Konrad, will update the changes accordingly.

-- 
Thanks,
Taniya Das


