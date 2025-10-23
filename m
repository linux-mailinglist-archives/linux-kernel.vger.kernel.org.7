Return-Path: <linux-kernel+bounces-866630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C05C0047E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094E43A3C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7229BDA3;
	Thu, 23 Oct 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxBvhXIA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE33090C6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212209; cv=none; b=CqIuEkdp6N34bBCQJv9GC8q8phjpHZlFvR6ROfWvoRKKUjzLWXZhkTXXbA3ys/AGWor3BNbLAJV/QyCT7YCuKarPSS05cAgnFZheLpCzhh1eP0mr38HUgUQ2RWrfJEMUuoPFD+o1DlQ8Djvrxe72YFhnA0I/aOvUiXnfcY0DtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212209; c=relaxed/simple;
	bh=31I2NZ9E16fvkibGKYsHIzjfGNy5b9QV8vluRHj+fjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZt7rDZZquO/QlD+hZTLxzSMrWWhqEf9JB0HPhhsEc2i0r4qgzbrwwUNuP6jaqxT8FHKilcUjJ3dYtcn3m9BRmkqZtF/A2wVS32JSXGP+XJ+TUskNbxTgNPUOeM3WIo3JjmGRnNAjjN1Xzx9u4gsVJgMr0iiuKBGVxAz4yp8IHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PxBvhXIA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7FCOQ011761
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+iM28/6ufZlmOomF1p5E1/bkuTFa6Bw8f1OnjTV6/Y=; b=PxBvhXIASB+Tew5z
	LahhQmxH6wst8V0qUTE1SOLZ+qyg1Ns1EuO374nnKPigUFPguw8M1zXnOPCOm+hj
	FYdSNj0llMpTRgFFzQR/Qoirqy3EB8EJ9e3OM0dceb0YSOhas16XVE8LqFc6hsVW
	3DJEfJlNrZR9Z7w4RWDwm8a7k1U0vF9KVS0IdTrrm8uHZj5LGkftPZ43ide3mn8V
	Fu2BKMPimHQ3yZEp0h0uAnuail5MIj/gJaetzq5EoY1oe0hNbSgfDx7gX7Sk1tuT
	WiINMPjOcX04IcGvJr2Ap+W/M0mK2ys/ksYG7ysTU6mL+ki+03rxUIDHpkz1ftsN
	eN6aIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524a1vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:36:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89083a0e150so14050685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761212206; x=1761817006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+iM28/6ufZlmOomF1p5E1/bkuTFa6Bw8f1OnjTV6/Y=;
        b=V/Z9xRMs4FsYbNm6RfSI98gjbQlCzm+14RM0Gd1IE0M2u0ruiV73xo+pEhq5T1yBkC
         20oOTGC3sl2C3Vkx+epISC5rV6xid+Yqpn4a6YYGTb9y2bkHlcxxNq5rnITyPSSIqk+w
         UeqIVHJAxNwVBYi+LAkHA5vxrmZlGE+wk7E7FGQE2AVG19aak+is4rr5c63c6SDhmH2o
         IJZVAbq374bpyI2+Gj0uRtr8n0LKK4WOteYR1rd/w1dUXDadcHQhGbqf7f2qV1MKpQiJ
         KDcG293fCMsTT3cJ5jpJhc/miCU+c15PjG5X122wQHbqWNP5//Zb9u5EGdMv58Q3vps3
         O/dA==
X-Forwarded-Encrypted: i=1; AJvYcCXjgME+m1CqbRq+4khz0Hd56faByXgEAFRKWl8Ks53nCJlEkS7kf7zssK7B4g75AkAfF+4GD9hZlXZMkMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Z+9wqFHPXZXoYnWAz5z+tcNVnIcVy3O7CZYpoxkrwnd4K41w
	8Nt/iFxcGrFVlXhJr5KSYy0EnzCx+Yf28e3zkLhRDONIXXykEoCzWiLi6urM4sC1z8z7SToB1QG
	m1YCrI5+n8cAPr3CWFJffrXw2TJMNtosXzmj3Vn3vSEEyNkhAPZdYTDpxOcGq85H9m+o=
X-Gm-Gg: ASbGnctZiDrWjb04EqzfsoKidipwg4qk32U+a/rKO8TdpKBdF25e9ZpStGn6vptCqn4
	efdvNSPTjEXTSMOFpJFiUnxRxiFC0FUhsQEvayjTgLxrOiYTLdXJaCwfiLIedeno8CPLf/RKdb2
	2UAi/nax1zcfofr9cCWzULkqI1NHmQCMEj0zvKuBGck21St5FMWMuKAygdzUk+MlTnov2yo1hur
	01R+srFbr8o16Cr5kn1uWX9prtSwxQblbafZGtQFafcuvUR53nF7wXeNYwQ1AyP6CiRa2jNHUfP
	9NSpitK7gpy+WvMOGLBG3Sy3Jg0Wn7HpTRroAw0QT6z5kWWNU8rcRZ4h6119tl/18e3KEAKf99n
	6NDWYqujJbDML8QbtKbUsol2ECcZFBbvQk60bITidD7lk5TcX8xiuJpY5
X-Received: by 2002:a05:620a:190e:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-890706fe6admr2117633485a.8.1761212206517;
        Thu, 23 Oct 2025 02:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6mY50FZNSqye8z3osZjKohykPCr4NQ1LXRm9tZBZ3NgHs0Ck4cRYybkcjDjgqxKHupXrKRw==
X-Received: by 2002:a05:620a:190e:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-890706fe6admr2117630485a.8.1761212205954;
        Thu, 23 Oct 2025 02:36:45 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5147240csm159119066b.73.2025.10.23.02.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 02:36:45 -0700 (PDT)
Message-ID: <10999a80-df1a-45c5-ba1e-e64b2afeeb4f@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 11:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] dt-bindings: display/msm: qcom,kaanapali-mdss: Add
 Kaanapali
To: "Rob Herring (Arm)" <robh@kernel.org>,
        yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        marijn.suijten@somainline.org, abhinav.kumar@linux.dev,
        simona@ffwll.ch, devicetree@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, krzk+dt@kernel.org,
        freedreno@lists.freedesktop.org, neil.armstrong@linaro.org,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org,
        lumag@kernel.org, airlied@gmail.com, sean@poorly.run,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        jonathan@marek.ca, robin.clark@oss.qualcomm.com,
        quic_khsieh@quicinc.com, conor+dt@kernel.org,
        yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023081736.1251-1-yuanjie.yang@oss.qualcomm.com>
 <176121209123.1694835.2815069098750745260.robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <176121209123.1694835.2815069098750745260.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX56Uljw6tbGMx
 kb2CDYg755xuT2SqMp8SdHsxApjFv0azde5k1IM+T72QLk+exGEiHEjTpygh6dnoBfE3wVOkORH
 W87pWdCJ30o/gXPEJ5HnddnJ4lKpkKFKshrLH3KCdnNOVTMgs28TysdjymFMfjbzHIJAxduX5rU
 p69blEwALDna95JJt2mC655xDGAwg1cXTEppcPcZ2deNZKkMErPZNSp6IKn02qNZxbDz8tGA96/
 bWuMd201bx520z3cXP3PZdnbl523wJQlg8HQzb9QyIlPamuUPNhw8QWTSSuznTtJLxSF0gJcMX5
 ChMrGDGuYmKpQKVMP8oJmWPhfPPs8SvrK9jCepCdYx4MxJfTCatPODtuEybe1NvCvylhb7+YU46
 PjCE5GynvmJDvnu7CmrXImfyz8VcgQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68f9f72f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: l9zj5ZyP2roznEp1ggbxES82taa16Hvl
X-Proofpoint-ORIG-GUID: l9zj5ZyP2roznEp1ggbxES82taa16Hvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On 10/23/25 11:34 AM, Rob Herring (Arm) wrote:
> 
> On Thu, 23 Oct 2025 16:17:36 +0800, yuanjie yang wrote:
>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>
>> Add MDSS/MDP display subsystem for Qualcomm Kaanapali.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>> ---
>>  .../display/msm/qcom,kaanapali-mdss.yaml      | 298 ++++++++++++++++++
>>  1 file changed, 298 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.example.dts:26:18: fatal error: dt-bindings/interconnect/qcom,kaanapali-rpmh.h: No such file or directory
>    26 |         #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>

Please do what you did with the other clocks and simply refer to it
as some vague &rpmhcc_xo_clk which doesn't actually need to be defined

Konrad

