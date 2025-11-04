Return-Path: <linux-kernel+bounces-884109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83EC2F619
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA5E3B49DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FE2D0C97;
	Tue,  4 Nov 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvLCrYAp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IONOni4e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843802C237E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234511; cv=none; b=HstEozN5gznUmwnBo+m6FZVyDKN/nrFfyuSxC+24+8AM7fYK6JCRGM1WGUXIRgvnue2oNC2rTNd29ijFoNN2yR/PZStGksdRVC8jSgbDyPT5Nal97pjGUteU4lyjIWzdVZzBgya5QDU/IaQnxiJnTPBLlP1ESJYCv+fF/y4a9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234511; c=relaxed/simple;
	bh=2P+CxIoELezvA+RCfalPVsUy7iSXyonL+qlhkllQlb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTcZgFya0v9PXFYvjbzSxekSkDbmtTG55gmBk7kVy1FQfBSZ4CI8bNY7fpKhNtCq11KFYvMuPJftzHUQeW+nqQLVoVTrH1L0BbI+L4frRnLJ91FfCYOVu4fdXEGXQyYB278KFgfYYGw+S/UC8aWD4fvkI/Be+bXnDgRTZRz4/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvLCrYAp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IONOni4e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42o1gB3616996
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 05:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1yAZ5BZxanPwdn7pnZ47192vgH1AOWrXwIL2Xsu5H7E=; b=hvLCrYApud9gLrqr
	TU7pmqOKylKn2G0Q1RSCSIlyROfbayjJf3qVTc477fHIn7sC09AJbaGP0xakcr88
	wvvBRx7EQHdgTSu8RyqNpXM2O8epJGKig95b8KoAq+VxAEdSwARciFWaqUtcGZu5
	0P/v+ot2KUNINhmP4dEcuQ0Amj9UahxpeyGet+gk2OqtqTDdO7N3Zpo5ZpSplaXE
	+whntNdmOIkTmMArtrrzaXudzoAgEOjG9lAyudPHgL449xco9O7+bV4JD0qpkCEA
	ngcMDddv5ps+VfxI+gODhbLGnl/go4vxwm/HJrrDPWAb8j/yYNhSmXPMG2gK2D49
	CWCPfA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fhsrm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:35:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso2036480a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762234509; x=1762839309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yAZ5BZxanPwdn7pnZ47192vgH1AOWrXwIL2Xsu5H7E=;
        b=IONOni4eGirUbQAhImCQVLOqE4UbtQaCLGjtDnJfhdhlEn70aYlvIK59sWAIAEoi1u
         yzXnTpMe5jjhhQ3XvjRh3e+x7qGd+2c7Wt2ucBAsSkZsxFGHvfz6ai59n25aL6OLlCV5
         XMVNiEK12RGoYFAxlnwVOtMW8RzjcQdpb5GlWCRSuh04o7m/mxWIXGUzWRy9t8HR7nys
         ZW75iTXefdNUEuBB992V4pEOPFWLvaqPCbIg4sQF7dIFUw3ezWgloim8pTDSKrQYx7lp
         axgkBMyL5d5RViV1ThEyzcbGSkksVHSCupwPJTHrECK3XOSDLctlFjMe1WsJA8x/nxp0
         ogNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234509; x=1762839309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yAZ5BZxanPwdn7pnZ47192vgH1AOWrXwIL2Xsu5H7E=;
        b=Bj+W8wbAh22f5tsLrg0SJbztrzIr+6v1iF4GKYV3V5iLWvIpVwnMPOJ1OaUpNP+xXY
         xapILFx3OkCKiiXWU5sIlk+w/3me/ICsqkI7MbxQFyUQ/N9ETJrHDzF6ZdScOPKvnxoA
         ItmlLpP+IfIFwt8VUkrPlXZUW7QhzsS3vkV52VT2T1dEc68E1cN3Uqjsjg53vz2POk9e
         skNHH6m8z+GOECUw34++K5u90CnL0XpimxnynQQaN4XnkK7/mJwAgLumvUO64kWY3lTC
         ll+pJBa/e6ZzAMx3vsjrKFlIuigKkMb3UxVWWwDgAnfN0iZYFyUiGYQZzkwSk/10tZNq
         aIdA==
X-Forwarded-Encrypted: i=1; AJvYcCUJJxQFPisJmtWbYPnvRz8t+tF90WnBke6thzbpo3anHFHPlBPgdPqrcjG1CVvbfA6CjH1zQ0HUaDrR8Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfeBolXuOQdzT7s7IA82ES0osvQwRhokfc3gVoYHjcgSrxUjbO
	VO9D14agvdju1KND7nYM/3zeOPaqvSNQl1WzGvZE3pcBUV2wKxlsH2ol62GQeMXWJKaIrrDRyTm
	c1To8sWBH2ykC2HmuzREDCgo5KmPOWuWs8UtZkzQ2Jb9rAa6sgnBGJSAkvIzpHe15BWk=
X-Gm-Gg: ASbGncuBcheuneExC8ff3tC7Vzikyyak6ugUTwq0zU+GiCw4hquwbzZlH20g+wBfcUk
	nCjGUQsLjYSyFy3RriZSeRbH9gZtdvoIGYocUTAmtilAYR+9YPo/ZUPtDAKKHwYMxjXfZ1iEvJS
	Vs6RqjetYfHO30UwNsEbB3lWXF0nkuQPnX9qdlxHtJTJgdGcMmQ0bN6e356cIRW+5UofpJ7jNV6
	BmZkX2/8zX++MreekW9JtYgrqTz9hpoJWz92jQ7v1uzqs78QvdKcHM0+PCYyVGISd/uog366ISS
	wiNe2vlMeWaqwflUOZTIIY5s6eIJ4yPqWV1AcRRfQOjbXFhGqVDG+juF5mVi2/wc1sMMiqe+LdX
	pDO07KjOPsN6aKsWjHqtarxGVP+LSO2aDs8/kESa5Ygu6Gf2LYlMwM1gFVIkBiIHcuVmN0w==
X-Received: by 2002:a17:902:f60d:b0:295:28a4:f0be with SMTP id d9443c01a7336-29528a4f6b2mr143160145ad.10.1762234508773;
        Mon, 03 Nov 2025 21:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHng7eVS5bLdwxY5O4re3A0l3NZGOVCyRWV9eOTQvzKfq1x2VWpkt7j6UzUVTsx3vqD3p1wzw==
X-Received: by 2002:a17:902:f60d:b0:295:28a4:f0be with SMTP id d9443c01a7336-29528a4f6b2mr143159835ad.10.1762234508290;
        Mon, 03 Nov 2025 21:35:08 -0800 (PST)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a609c8sm11237775ad.92.2025.11.03.21.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 21:35:07 -0800 (PST)
Message-ID: <ad00835e-bc20-4f97-aba6-e1b4f5e97191@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:35:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: Add compatible for Kaanapali
To: Bjorn Andersson <andersson@kernel.org>,
        "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com>
 <b623c7f6-f28f-49ba-b6f6-25084117a6b3@oss.qualcomm.com>
 <l4mb5pi7kz7uuq6o3eueoxl2ngt2sdd6dv3kyudw6i54co5v5h@w6ya2nuas322>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <l4mb5pi7kz7uuq6o3eueoxl2ngt2sdd6dv3kyudw6i54co5v5h@w6ya2nuas322>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA0MyBTYWx0ZWRfX+LS4Rwp/UZLq
 7hLi02tHCq2MHAy7jzTHp54r2FzvadwmlUklGQEUnq0vel5Z64HRgUQPxAqNpr1BCx1QtNZ8y1F
 jSE2VQ5Q1IpDwtCjmgzbBnmjx1vyzACHeUP+fcCwHHaInoIR35qmLj4/o5m5F2MlN6qcpFpPoLi
 GYVcC6vT3xJKTFM0vgjphwzINGP4JVlNhCXYUaVXPz6zdct4FicRJmTYNxaVs7aIHbrb+PxnI9P
 nlV2XBk2ujKbbA6hPGgkMHcfcjLTHbXmKTnJJnHlOt7bQA9NAT2x92/pTVDMh9S/vmg/QytyaLt
 mK2I2XUcQtJa8Nl5oThQzrct9zNtWt4AupylbOmA/eSxap9jI8UYuNoR7IEU+YcJWLoav1L7RRi
 1jtAEmyST8QpYMVUbs7jfkUI4pFkvA==
X-Proofpoint-ORIG-GUID: W3gkiuSLoo_vEYlfOOuFnucK3Cu7w4PY
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=6909908d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jXqUCmHUJh4Flt8Z5iMA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: W3gkiuSLoo_vEYlfOOuFnucK3Cu7w4PY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040043



On 11/4/2025 12:02 PM, Bjorn Andersson wrote:
> On Tue, Nov 04, 2025 at 11:34:25AM +0800, Aiqun(Maria) Yu wrote:
>> On 9/25/2025 7:23 AM, Jingyi Wang wrote:
>>> Document the qcom,tcsr-kaanapali compatible, tcsr will provide various
>>> control and status functions for their peripherals.
>>>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>> index 14ae3f00ef7e..ae55b0a70766 100644
>>> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>> @@ -48,6 +48,7 @@ properties:
>>>            - qcom,tcsr-ipq8064
>>>            - qcom,tcsr-ipq8074
>>>            - qcom,tcsr-ipq9574
>>> +          - qcom,tcsr-kaanapali
>>
>> It looks good to me. Glymur didn't have this functionality verified yet.
> 
> You spelled Reviewed-by: Aiqun Yu <..> wrong.
> 
>> Remind for review.
> 
> No need for that, reviewers will review when they have time.
> 
>>

Hi Bjorn,

> 
> But that said, most modern additions to this binding follow the common
> format of qcom,<soc>-<block>.
> 
> So I would prefer this to be qcom,kaanapali-tcsr.
> 
> Regards,
> Bjorn
> 

qcom,tcsr-kaanapali is used to distinguish with binding for GCC:
https://lore.kernel.org/all/20251030-gcc_kaanapali-v2-v2-2-a774a587af6f@oss.qualcomm.com/

Thanks,
Jingyi

>>>            - qcom,tcsr-mdm9615
>>>            - qcom,tcsr-msm8226
>>>            - qcom,tcsr-msm8660
>>>
>>> ---
>>> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
>>> change-id: 20250917-knp-mfd-4dd3c81e6b9b
>>>
>>> Best regards,
>>
>>
>> -- 
>> Thx and BRs,
>> Aiqun(Maria) Yu


