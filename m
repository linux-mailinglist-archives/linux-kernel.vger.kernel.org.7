Return-Path: <linux-kernel+bounces-844355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F7BC1A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C052434F99A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C62E1EF8;
	Tue,  7 Oct 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCNjlgwf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3CB2E11A6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846286; cv=none; b=nDFr3sKeKVbYhlDDqezACtPkJKeXSZQLBN6pad8sYEwYUHITxne5cM/q/D2F83h1xbN6ezVmYQm80Uu+w9qRQNhlkeedKDqJVlnG3DcvhTkIqbR+AsVwnIblZXoWh8rE2EKJbz9ZmsZU4oDHcAKgBIpbawfpk2jdpHElOMm2Eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846286; c=relaxed/simple;
	bh=5wQfQwqYI2fZ4w1KXVMOyK6TI0qttDsdvBxjxVjo+ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDK2lAUJDolRlsVsSnDhNYjD1ASYKSuzE+f8awqDR+XuhD9gthSJrEiElLzQ1A+6dq/g3GiBsVvOETYFSjHbMJ4sHqrflZvRf/bxhi8o32sVpXp7Zp/sqJU75Sz4JipVJtI/DlULgdSI4LWnkPJIpHRXV+EiorjyM9Nzs8OVwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCNjlgwf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5977hiNO020044
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 14:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ktSaSroeEeu0/UwzC26whCkkXqXo9Ky2cJhuhNttXgY=; b=RCNjlgwfOop7gG5d
	arwVlWqSWExlXBE6AuPhk+OBM/Fi3R2S05wbdkdR11TQlbTGttahPn4eJx5RVywe
	rQ0LKj+G0QTwoIEYLDRU+sTorcqIZhyO1GDBKiHzUSH7kXgW2rlVhuK8pLN6oQZi
	4VRmdeEKvYRlue5bjWQqHZ1VNxjmx7nfF4AFYRCjSl2UN++KPN8YXZaP1N0IBU1V
	TQRvLb98F3O3c6SBcwn0UsAeJylMkjWshN8YO/S410q8JUv8Qp10ihZUAz9j5JQ8
	M404ZUaj6jOK4Hj2B062p6BD89kZ/9PESg0Rw35r/tT+0JqO5hYG4WKMwqAcADu4
	0sNCAA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpt9e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:11:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810af03a63so10654285b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846283; x=1760451083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktSaSroeEeu0/UwzC26whCkkXqXo9Ky2cJhuhNttXgY=;
        b=KsU6kecF7MSJtK5rZykpiRDH0Be/NlPqGyOrn/c7RzNwjW017XkgvBOXk7Jh0n/d8P
         JrFcHUXnsU4Nj+qjDDfi7muVRoeZE7oeGZs9O4XEBcJnQmRQX/3j2Oil3X/+SnWcZHLB
         EbPGfhxhzQpBkNm/VqrGGWoEN7buyHtik/FIjHMJ01LwdbBtPUFXS5I4T93wIPOSsp3S
         cuP/eaOxYSukxOEuVeaSO1BaAWjzJPHuYwk4+2uxPZVmu0INHbjm8kwObIAl8Yy1gx8+
         AVxdVh3d+qBYLsq/aEGTiNwzdydwSw0/uThpLMISosXtljYBngBUvJSGOI30vm9MWh0K
         VqVw==
X-Forwarded-Encrypted: i=1; AJvYcCX8a7PuNb7BY+Qc24dsNRX43ZNpiKDy2xGRXHR46TSt6XBfc8OPGu1/NYlL9cnpAE3L5GGigFg1d0YTT7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKh5HGgOzwpyR2awtxCzdzZvY959gQQSh6TY4dhhAyLomyfcEj
	7CWQqJh11J+uZWF75lnzvv0peYKYaG+3d8AjsxKRf7K6rLBLuZdD/umJsUuaVA6vFp+ShToAqUM
	J2fHx2iPB5L+u3lYTCkVx3mquER5ZolF4XFDx8lxR0uQB6VS3CmOBIyVtEW0wuwf3XGg=
X-Gm-Gg: ASbGncs5hAdYMsgt0fY7DfivXa6402XH7HwGlxMtg/CDP3Z48/wezS7b8pEfz6x3ouN
	u41Ga5GMHMtU41rMPR5bgdE/nSirpOikzzA3TjDtG/400YziLQJEB0NzV8b8KTiUzvyVEXmYRj6
	MSBPi4ygmY9jAr2s1aM93SraCkPn4YDqVoZdd8+qDwgUxMxgsJpHYjVB759No0orWfZNTRUhmYd
	LjMufi+aXKn3d/q+NwW/AJnTPM+taClMBQlNY3p8br0qO+Z+yLUC/AtmBlZ04BQfs2QAKrEkdPr
	7eZug7RRLj/s+Ug7jlLuBNgS5n58Z+5kyvjmA5epkQ==
X-Received: by 2002:a05:6a21:998e:b0:302:9f3b:3e5c with SMTP id adf61e73a8af0-32b620a8d65mr21677942637.39.1759846282909;
        Tue, 07 Oct 2025 07:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiWYBtr6EzAYm3iarthma/0DUKSsRzYme+v56XXtnu78Nq/GDSGSQ38ocKvh8T4EgfkEtS3g==
X-Received: by 2002:a05:6a21:998e:b0:302:9f3b:3e5c with SMTP id adf61e73a8af0-32b620a8d65mr21677873637.39.1759846282301;
        Tue, 07 Oct 2025 07:11:22 -0700 (PDT)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4cfbesm15316893a12.28.2025.10.07.07.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:11:21 -0700 (PDT)
Message-ID: <4a32bbec-2baf-4210-a7c1-1ddcd45d30c8@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 19:41:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
 <f5ebf0d6-2f0b-45cc-b99a-b786e5df9edc@linaro.org>
 <5qsgbqml367yq6g5vb4lotrzulojqhi5zlwwribze373a63qrn@rxi4kwyt66m2>
 <4f38058d-a2f1-4ac5-b234-228cfb2e85ff@kernel.org>
 <1ad2ca1e-1d57-4ad8-a057-ab0d804f1d49@oss.qualcomm.com>
 <7da769b4-88e9-401f-bb21-0ff123818b9c@kernel.org>
 <6840d462-8269-4359-a6e5-d154842b62db@oss.qualcomm.com>
 <af0da28c-3ca0-41dc-aaa4-572723ea74bf@linaro.org>
 <klhvgzizub33f46buqsog54wqksqp24a5tijwyv355l2ao2imo@wdkojfebc6s2>
 <e1a6e75a-2a5d-44a2-8bbc-140eb86d1806@linaro.org>
 <2hh3zkdwgqbdurpr4tibr3gjat6arwl3dd3gxakdaagafwjdrm@aj5em4tbsjen>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <2hh3zkdwgqbdurpr4tibr3gjat6arwl3dd3gxakdaagafwjdrm@aj5em4tbsjen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2WJ21qo7cSzSjlVqVPVK4usTQ3JEJrjv
X-Proofpoint-ORIG-GUID: 2WJ21qo7cSzSjlVqVPVK4usTQ3JEJrjv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfXzdJ1i6gW52ub
 bIT3cOaALuXZ63h3e1HzX6ZWTMcHskL8Ej5q4hmuB4u+6xZFixE0Sjfe2SWp6WkSiD2zGGfvr56
 iW2jydF74KNUs3x/RkqO7AvRj1dh8FbFBSAEsGFYGDgKc+hIv6fDwTOkXrLcJ1Wb0JupzvOiTuR
 VNzYP9SAjvYTKXksGYJNP8n+geKDMUZ6ikt8zDhFqtXyh5a+fZj/WAGajUdPlKelTFupwtr4Haj
 JEP19Qk34gxz3BfIKCts0Uv+/Y1hZveLshm6W7ZovxgV853qRFyT07vFPY0r8sNJIBwF1L3vbb+
 +M9+rZW+vfYsoSQeEpzQpTb6+ZO1r5GjMwivgWku1DecJ4BcNjR6RW5iTbQrMcgsrPUyanlxblw
 1a09w/r6lWpo/hzygDa0hirLSB5Lpw==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e51f8b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XxnNId_WCiCfXLSGgVMA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168


On 7/4/2025 10:15 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 04, 2025 at 09:23:06AM +0100, Bryan O'Donoghue wrote:
>> On 03/07/2025 22:23, Dmitry Baryshkov wrote:
>>>> I still give my RB for the series.
>>>>
>>>> To me the only question is should it be applied to sm8550 or to new SoCs
>>>> from now on, sa8775p, x1e and derivatives.
>>> I think we need to apply it to_all_ SoCs, maybe starting from MSM8x26
>>> and MSM8x16. Likewise, we need to think bout secure buffers usecase. And
>>> once we do that, we will realize that it also changes the ABI for all
>>> SoCs that support either Venus or Iris.
>> I think a dts change is a non-starter as its an ABI break.
>>
>> So if ABI break is out and reworking future dts to allow for a new device is
>> out, then some API change is needed to allow the driver to stop the kernel
>> automatically setting up the IOMMUs, create the new device as a platform
>> device not dependent on DT change and have the probe() of the relevant
>> drivers setup their own IOMMU extents based on - probably indexes we have in
>> the driver configuration parameters.
> 
> What about instead:
> 
> - keep IOMMU entries as is
> - Add iommu-maps, mapping the non-pixel SID

Otherways to avoid the ABI breakage:
a) Keep iommus max items as 2, which is unchanged.
b) Repeat the same sid for both entries, i.e.,
         iommus = <&apps_smmu 0x1940 0x0000>,
                - <&apps_smmu 0x1947 0x0000>;
	        + <&apps_smmu 0x1940 0x0000>;

and then create the new device as a platform device independent of dt.
RFC for this is posted[1].

However,  Dmitry(in offline forums) termed creating 2 same sid entries
as -- "ridiculous band-aid just to fulfill the "ABI" requirements and
really doesn't make sense". Looks Fair.

OTOH, To exactly implement the idea mentioned here, I have the below
questions, can you please help me with:
1) By keeping the entries in 'iommu=' as is, then add non-pixel sid in
iommu-maps actually creates the overlapping entries.

So, IIUC -- this requires changes to the iommu driver to ignore the
setting up the non-pixel sid(or whatever is mentioned in iommu-maps) and
then use newly created platform device to program the entries mentioned
in iommu-maps. Please CMIW.

If the above understanding correct -- Doesn't it look like we are trying
to fix in the iommu driver for the problem statement related to dt bindings?

2) However, I still think that problem statement of __non-eligibility
for video IP to create the sub devices in the dt__  is still valid and
can be taken separately and actually [1] is targetting this. I believe
this is atleast required for secure contexts. please CMIW.

[1]
https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/

Thanks,
Charan> - In future expand iommu-maps, describing the secure contexts?


