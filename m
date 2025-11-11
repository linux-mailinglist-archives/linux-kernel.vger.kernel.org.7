Return-Path: <linux-kernel+bounces-896014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EACC4F7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7905A4F344A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48943252292;
	Tue, 11 Nov 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLbP5CED";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N7dAEEvV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D62BE03C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886734; cv=none; b=qK4WK3o1NmihnPCafQ2sSr/1nnMjbs98F9InvzKbJ7f/kx3tONTV6902czthR3FfQZskotiF3yEx2HxRw7cEYJciJpFMSnGsdLp0SWe3x7RseDs9wpiQUyI4VMaep6+GoL3ZFjE8mY24sJFV2VRbSGiDKbpRjv9HxuPzu6b/qMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886734; c=relaxed/simple;
	bh=m8HjbcXk11mq43CaUrlq93qQaoVQl7sLhwGwxLXplWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TV/ynq7C1ekT6+MmA6Fm0HDwy3Cwq2HE7zH5Pm59tUBnPHpJe+knE2f0bBW6tsPkXjdzp0DuLv60NnbwjpUfcgZqbS2JbSmjP3vEagvF0/9TJh5oxcUsEjkEGDjDrl360U4jIgCgSoQWpvJuArqOWV794NhI4gMMrgzW5N2deNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLbP5CED; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N7dAEEvV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGALG2165131
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iDRuZXkPS1qDYVh7sPEoO/kaONTCP3KF2c/Ipe9RM1w=; b=cLbP5CEDVgM+zFrH
	cmt5HM3VJ2rL7/LLIMTq16a7sd1+NDO+WMSp0Ny7AODJ/zbQcQWGfHSGH0LC45mM
	yQbYI8RCOQK85wMazVwoVdiu0otFp15A9CNsnzoZG1x9tGJldkuM3VV02LWnpBuH
	knjKUhIjkmNkisGGjBpBFhpzK2Sr195QN5PhHplp9J76T04uNdfvzsGW9AXBh6AH
	8i8h1++HnijD/2HTCFE+xY/FFsd/i2tEa5I5RkPNNCjm7xPNDBGtIAoEt2aYxC54
	f0oYuP2B9PAzOp9zwBWB1rO2uUKHFG2tkRk6iJfUxnaH3Plkv+DKgbNaaCtITbE7
	sZMwEA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxhhjbh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:45:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2982dec5ccbso237725ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762886731; x=1763491531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDRuZXkPS1qDYVh7sPEoO/kaONTCP3KF2c/Ipe9RM1w=;
        b=N7dAEEvVJIhBDjLRvR9hP93yV7JZCQEnvLN7SycnoXHREPlgxMdOIBPMr9vzbOyPdE
         gUTyaQpJXKhl7RqjoxtOBx3dAdvo9WOy42ri7u8HcMNeGSKEBrSZOBxuwsGDY7bEi+R1
         tklnR8KG23WyeJWK2fVJg2tED8HkedZBxdvGmod5KPw906ju4nNLrqfgsFqX2cwSOjCd
         /D624J4wH5VCIMIeILsBq0WvEB6doe0ZNrMllvKnrUu2SQsz64GS6t1g70hHlB316VKw
         jIpPkzTglLwA9SLEGgtojfEYyDgJe36LWdyyDtWLq4mVjCw0KvDjxDZD0guGoi6ZCKu5
         3BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886731; x=1763491531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDRuZXkPS1qDYVh7sPEoO/kaONTCP3KF2c/Ipe9RM1w=;
        b=dOIzuRS734aNjYIZnaxbYE7nxTjDGoSQ7xL+OeSDDos6tgMHxpOXKE0FhXL7L0DXe5
         h7vfYaXwB3d1Q5XPz4xF8GBv00KFzI9byMYB/lAbN/0YinDl7+GtH3nMixHTlogqLv28
         c/oHDho/a3C+t/ndpftN7vza8EP0dPf9QRwS17zEDQT2cubJ1MEVZoXE1E9o5Ohl6K8D
         D4Ur4Cv045fceU1eAG7Kdu64XRYLLeMeiTNBPNZXAKckF7LjSP21wTmt0YngPCNhiTct
         9gnjVqB3DlD2s+3W6J+gEJGSlszLpEK/uUDA8J2FJ8PCL4QDWVXZriV9Ol0D5ZsDHv/Q
         Y/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Xx5zZo1GzYSq06Y0s9JB4ZrIWSN1z+LqTbcbDlCtnU0kXRXRslFU4TtE7sNs1vy8fEV0mny/928ArWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqVt32HvdI4kbfXTTga2hRi5gyu6M36xS+EQdyGdJysJLKto0
	utRNN5k1skaThhHcxpn1vNva9blrn1OhR6qKkPmlyV77daBtaAeXM1mUtf1T8OUHFHgFmE11eWq
	ZOyUFaG8KJacnYfwwEetHmYryPNrVVWW/lfYe4myeDqcvl9gpewJLBuyTENSUH9ruxdw=
X-Gm-Gg: ASbGncsh84IhEfN3AkgvOEGBYmjIuIFaUGLJqOd59U+zTiiD9FCB3TIT4oiYWvk9zJb
	QNj7u5heq3dJthfIRLs2SwxxpmODHyHdwBejnSNDJeI+csyU/108tF2ZI+z/NEKtbgZDGmdBLqn
	1W1oSy6jTzFhI0NUFgyfXfPCSu83v4cQKm2oHU896iAezfyJ+Elo7dM1KLk8P37YNC5iw1u2Bxr
	+DB7iDk7+nbhmF0XdAp7Cbn2N4jG5ESRuaC/CwMU/Kq6VMzsVo/kFFubxE8ufsy8DimfcNerg21
	4QdQ50ZY+Eu0wG8y7BD9auAD53lwzcqRgsk6WEcE70hSm9c6aaKv6gxg948M8TnnMz995bDluVw
	wMHGspSYNocdBCroGrcxmd23+79Zw
X-Received: by 2002:a17:903:1aed:b0:295:f1f:65f with SMTP id d9443c01a7336-2984edc8cd8mr3418685ad.31.1762886731092;
        Tue, 11 Nov 2025 10:45:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHudt8EBpHs0AgGwqz9g1pHc97ezO6MMeauxnKj3D0cw/mrZhoZc8rx6PO+N69y8wHTbVSW5A==
X-Received: by 2002:a17:903:1aed:b0:295:f1f:65f with SMTP id d9443c01a7336-2984edc8cd8mr3418365ad.31.1762886730501;
        Tue, 11 Nov 2025 10:45:30 -0800 (PST)
Received: from [192.168.1.5] ([106.212.255.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0ea1sm4232965ad.55.2025.11.11.10.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:45:30 -0800 (PST)
Message-ID: <49339695-615c-4a89-974c-ecd4ea1b544a@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 00:15:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <20251107-active-uber-impala-8d9118@kuoka>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <20251107-active-uber-impala-8d9118@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pc3yRyhd c=1 sm=1 tr=0 ts=6913844b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=pJoDNl42m32kJ7anCML+mQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=dasm5qW_s5I0UYHIXAEA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: jqlCSahXx8p4yYNqruRwsd3LURP3HW71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MSBTYWx0ZWRfX1HEIQbncRwOO
 s16n1SM4kQzS9yfaxVdKza4D1YWXwyMsT+54zTyWqoTASQx5gy53WAt3+Yw2ImwC+g0VOx/dysq
 0DyjbhXWFQDpIuB3T7LKmq150xaLyFomBhKVdFiUZ7BhtGOh4aT8XHhm2h0kKITXzXwsacyCgZ3
 KEqf+CcWIZFiUKqqdfVNg1IIs/BTuBntWw/Os/BfC7Nls2Ku8LCKkwNgyhCAgLah1OyF0VETblp
 bBJHVhS5Omm9WSVum7H7/s9PRCbUgkqJAmvdmC0BVmrpl+nmXSYsOnrYdiEeCsHbLzu6DrjXLDe
 r55NfdouYFojmXSBgw3K7S+yt/kMKLF/1yTubqMeLgUAHdEZBDc663I+dgl6ZxMgfayX7LgYEn9
 C9BeQAnY5ncYULKeuW6Br/ZOJFKcYA==
X-Proofpoint-GUID: jqlCSahXx8p4yYNqruRwsd3LURP3HW71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110151



On 11/7/2025 1:37 PM, Krzysztof Kozlowski wrote:
> On Tue, Nov 04, 2025 at 02:20:59PM +0530, Charan Teja Kalla wrote:
>> The iommu-map property has been defined for the PCIe usecase and has
>> been hardcoded to assume single cell for IOMMU specification, ignoring
>> the #iommu-cells completely. Since the initial definition the iommu-maps
>> property has been reused for other usecases and we can no longer assume
>> that the single IOMMU cell properly describes the necessary IOMMU
>> streams. Expand the iommu-map to take #iommu-cells into account, while
>> keeping the compatibility with the existing DTs, which assume single
>> argument. 
>>
>> Unlike single iommu-cell, it is complex to establish a linear relation
>> between input 'id' and output specifier for multi iommu-cells. To handle
>> such cases, rely on arch-specific drivers called through
>> of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
>> passed is always 1. In the of_iommu layer, the below relation is
>> established before calling into vendor specific driver: 
>>
>> a) For platform devices, 'rid' defined in the iommu-map tuple indicates
>> a function, through a bit position, which is compared against passed
>> input 'id' that represents a bitmap of functions represented by the
>> device.
>>
>> b) For others, 'rid' is compared against the input 'id' as an integer
>> value.
>>
>> Thus the final representation when #iommu-cells=n is going to be,
>> iommu-map = <rid/functionid IOMMU_phandle cell0 .. celln len>;, where
>> len = 1.
>>
>> The RFC for this patch set is found at [2].
> So that's a v2 or v3? Then number your patchsets correctly.

Is there any kernel guidelines that patchset should start at V2 after an
RFC? I do see many patches are follwed by V1 after RFC. Eg: [1] is an
RFC followed by [2] as V1 -- Or it is the maintainers preference and
expectations?

> 
> Try yourself -  b4 diff cover.1762235099.git.charan.kalla@oss.qualcomm.com
> 
> Works? No.
> 
> Where is the changelog?My bad. Will update the changelog from RFC in my next patchset posting
as V2.


[1]
https://lore.kernel.org/all/20250815191031.3769540-1-Liam.Howlett@oracle.com/
[2]
https://lore.kernel.org/all/20250909190945.1030905-1-Liam.Howlett@oracle.com/#t

