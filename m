Return-Path: <linux-kernel+bounces-602944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19714A88187
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FEA3A5EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96A290BD4;
	Mon, 14 Apr 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LbrucH6q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8F2BE7A8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636633; cv=none; b=nZXQvBMKFUN5ykWRRf4LsK1cCzGBXm8hEllIvmLGBsjyd7Jyv/JkyAhCjF2X2rZ6NirfZx8rmxSBq7KFqeGKfvjxwj94q86XKl/qNseq2yztWbEh+jYiPsyJaD/jgeAccFzN0dG6gAkkJBIPFshgFiaPreJRr+4GfOlq7QnP7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636633; c=relaxed/simple;
	bh=Zrb43kFWTVR3Ap7CSrwLk4KdL5IDZkubcFHeBrO1oPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrRMekApqSf7e2DR66Tii46w2pBMt4KM3P83w9Si3CKNk3G3BF+GcxfRNSgV2bSgs8aGLPbwRi6eRIZPUKFNFZr4x2nHeY8ipwKwXeLpm1/zbbLmGqVw/M1+JXM24ONwo7tzgYtyE/PFu6tdeCM77crJCySACLgAv74YpzOaGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LbrucH6q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99o18017652
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jhLo8hSG2Sld52yb+t7u12oLKb8fAopxH7KGEdG/7u4=; b=LbrucH6qkNHhnwDq
	VqnpY1Uu8aBi8aT+FJVkIaU8ZYRL/rz6ufU4ip4mnCqLAYkJ0OaPiY/j23TFaE0l
	YKkTRQftvLF3mpuXf8/NMJMH23E2XduSwpoAk25TMveScHlywqdbT73Wnr8QcUk7
	8pS9v275A7I20BwTvszBWhrW+5fJZU10moodSdyHboSQMArAvJkkcGmO5gHsbvoj
	kvY1sx8Wij1X+IkEgRBeqh/VuqSk9/u2zCs3ghYDfAQ2vwt45Gn7mEW68TkGet/x
	seRCC4ZdBquBDq2XzX5ncnoLAfaWJU2ecqNK7uERhnuOvlHcundxmb8mc3A2TiDs
	nupA+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vcqjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:17:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c555d4ad75so29686185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 06:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744636629; x=1745241429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhLo8hSG2Sld52yb+t7u12oLKb8fAopxH7KGEdG/7u4=;
        b=jx+RbWINmaqYPY7cM5ugUyozBwO3BiqeiOv1gtGQIrx9lSEjQlyX04etr8YHEX4a4g
         TYce051O6piDKqrOKX6ION/nKth5OsoOU41R+4Z8Lfj8CaoSFAlIuB41VZ/FF5XwOtz0
         FHrpvzBejde32ODcBlxJuGenSBalrSgpwS1YcUfR4RXXuzEAOeqhMe+rsN4zLr/bMcCb
         nFGZSQ9jjYWJqayBkTWjYXlAC6AJPJd+Ln8dymeX2vbXzofW8QjeHrftzF1aIgwyEV5Q
         3ah0c03J7uTgJSMFpzJb30E1HPe1UpYvSNtVQ71teL8zsNUxWMGiBz7j2cGqdvRdtuIS
         C0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXeACiu0o20optelgaZ5PX+Zsa4BMlGDiliSmVCkxs7aNiZjmB3Enb8tBH8l3N5H8ALavzlqkTDckgG7Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88sSg6GRyf+xZ+UUOkplN9Or21AMmP291Zh7wuMkE4d81XyNQ
	5iY4RsaxRi0l8TcbvTZ2g3FBYAEiYmit8Ahk6Hfg6TZj2/lLihcdBPSyZiDbwOla4s2WGEZRfe2
	u1ldqimaeSledsxh6uo1k5NXXCOl9vHiNKOjoIDf01ImLyJMb/MuBc9cW7Uf5cr8=
X-Gm-Gg: ASbGnct/rHttcWXFzw1u7+0lDE6uhK9474DkmswRyOGKbbmHm1Cb1uTBNiwHRuj/vb9
	89moYYZ8MZg+QDOzzcKZwxWdk5urk/jj/y0gmcSM/ZumG4/eKK8jn2OU2JTnsfXLaMv09KsZed/
	+FcpDHbOji7ig8np5ft9DCWQGQbOhGdjqTpG4R0yA8gqk1fHceNdOKQJpFW9dqj2Ee3Vb4mevCu
	Luaz6zuKruYrj30BEHGasm2fp/TTYv7tHI+i5bmopx10Xf40xMpBsY9QWQ6hRhnSMXgL07/Wn7r
	c6GkwzPcNanc/k44NSIeuqR0LvQH9a7pNEsHOReEdaMJadwhltgfVvIT0f0MrtKx1w==
X-Received: by 2002:a05:620a:4093:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7c7af1037bfmr760507885a.5.1744636629144;
        Mon, 14 Apr 2025 06:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt6LiWKzY6fMPs2bAMNAcdjvfSSy0XirJTkEaglVnC5MXIbVEOqGO5m0fSpi/xvMwYDjLw1Q==
X-Received: by 2002:a05:620a:4093:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7c7af1037bfmr760496185a.5.1744636626494;
        Mon, 14 Apr 2025 06:17:06 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef61911sm4872735a12.32.2025.04.14.06.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 06:17:05 -0700 (PDT)
Message-ID: <629bcae5-f999-448c-885f-4737ac0c64c3@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 15:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] soc: qcom: llcc-qcom: Add support for LLCC V6
To: Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250324-sm8750_llcc_master-v3-0-2afd5c0fdbde@quicinc.com>
 <20250324-sm8750_llcc_master-v3-2-2afd5c0fdbde@quicinc.com>
 <0ca929c6-6ff5-4ab0-8ebf-aed3cc5f350b@oss.qualcomm.com>
 <92b6ea9d-0b13-472f-afad-2b67d869a0bb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <92b6ea9d-0b13-472f-afad-2b67d869a0bb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Fk7CqS_kniI2lmRd_nqduWdxMwxdrrLB
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67fd0ad6 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=gk2TToWdodi_jzWV97IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Fk7CqS_kniI2lmRd_nqduWdxMwxdrrLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140097

On 4/9/25 11:16 PM, Melody Olvera wrote:
> 
> 
> On 3/26/2025 6:39 AM, Konrad Dybcio wrote:
>> On 3/24/25 9:29 PM, Melody Olvera wrote:
>>> Add support for LLCC V6. V6 adds several additional usecase IDs,
>>> rearrages several registers and offsets, and supports slice IDs
>>> over 31, so add a new function for programming LLCC V6.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>> [...]
>>
>>> +
>>> +    if (config->parent_slice_id && config->fixed_size) {
>>> +        attr2_val |= FIELD_PREP(ATTR2_PARENT_SCID_MASK, config->parent_slice_id);
>>> +        attr2_val |= ATTR2_IN_A_GROUP_MASK;
>>> +    }
>> This is fragile if parent_slice_id == 0, but let's say this is not an issue
>> for now..
> 
> Agreed, but I don't anticipate that being an issue. I don't think any slice ID is/will be 0.
> 
>>
>>> +
>>> +    attr3_val = MAX_CAP_TO_BYTES(config->max_cap);
>>> +    attr3_val /= drv_data->num_banks;
>>> +    attr3_val >>= CACHE_LINE_SIZE_SHIFT;
>>> +
>>> +    ret = regmap_write(drv_data->bcast_regmap, attr0_cfg, attr0_val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = regmap_write(drv_data->bcast_regmap, attr1_cfg, attr1_val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = regmap_write(drv_data->bcast_regmap, attr2_cfg, attr2_val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = regmap_write(drv_data->bcast_regmap, attr3_cfg, attr3_val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    slice_offset = config->slice_id % 32;
>>> +    reg_offset = (config->slice_id / 32) * 4;
>>> +
>>> +    wren = config->write_scid_en << slice_offset;If I'm reading the wrappers right, you should be able to drop both the
>> shifting and intermediate variables with regmap_assign_bits()
> 
> I'm not so sure. I tried with regmap_assign_bits and it seems the correct way to use it would be roughly:
> 
> regmap_assign_bits(drv_data->bcast_regmap,
>             cfg->reg_offset[LLCC_TRP_WRS_EN], BIT(config->slice_id),
>             (bool)config->write_scid_en);
> 
> but the third argument is an unsigned int (the BIT(config->slice_id)). I tried just putting the slice_id there,
> but got some bizarre results leading me to believe that's not the correct way to use this api. If I'm missing
> something, let me know, but AFAICT, this is six one way, a half-dozen another.

Yeah let's not waste time on this

Konrad

