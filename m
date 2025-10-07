Return-Path: <linux-kernel+bounces-844183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DCEBC13FB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59864F4CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C92DAFDE;
	Tue,  7 Oct 2025 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEJZ7KTG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585532D978D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837344; cv=none; b=q7vPLSoTu+MJtrtaZGJIPi66JnhmjyOhrb0XV95pKEbv8ILzzemKJS4lWZNyG8tDKyZBr4k9jJPRkRb4l3c4GioyQiGvv+iQuC+XWjDc+o1/nFH190vbl6YdivByljOOnDRtCJs/4OhPtT2V4su+BxGbqyU31J/r80pzciTRXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837344; c=relaxed/simple;
	bh=v0istXODWIHL1ltiHYtAZ8N5d97LsN0HcUB5gpH3dT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix3SjvhTqeMNMNhE5NWpIzZMFIg8Lb4qJANUdfBMa+MpbpYQwF+wB9nFFtxFpkvvXqMFKw79hEv+PbzSPi6NPie9/VQAEg3b/7iY6EmUtSCmpXpi+DG4qGBCxiWwtX3HJ92rxwv8sE6EFlY9RuXCeLKxBOQLSmffbefQV36JWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEJZ7KTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5974lEDM024117
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 11:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQGXZvj+fHOBfHt2M7ZMsptXc4V1NWsTLPFuu0fCYV4=; b=HEJZ7KTGYM02TND8
	zMyYndX8ElSYmYg2eI1B6ARKpshVPejHauwn59rDm825JkFKqVrjy4rQC6S6pbER
	nPtBDdVhUhVUOomfFaQsaU+VVvSIMLXWFUFPxMKw+TiigzTqeina2fgfCzAfixoq
	qF/RRHGVofaf1SK51BnkRi22q4NARM1EgvuLgcK+YkjlD6drPgIxAZr1IRXfDVLs
	n3nw8cOgnv0BVHm6j0aOFub3cN5rFoRKfXPCU+DSYK3t0QklcYGnyAhwuYSaXiFY
	b1DzFXnZu4RKDcCnEPMNuzcJPPkP3MDb9AfNvnFIbHtLnSLTsDRlu7C7qfO32fOL
	OLr+ug==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mg6aasae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:42:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7abea94d621so14414666d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837340; x=1760442140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQGXZvj+fHOBfHt2M7ZMsptXc4V1NWsTLPFuu0fCYV4=;
        b=Zrm1RLh75NsnGDR/DqVCaACQ5duaOLbJ6KTKlrflEYsLslmOpAzNDMf6pkEQCVnprg
         gKvXuhWjLcMkjEprzcbxAciY+XJBIlDK71h0CceaDqiKkKo0LvaJKN7Ougksgk5dAgux
         TDX02nJM7Epg1zjCGqMX73jz4eYH07FsRbvCC29Jscn3pbJe1JI+rV5vhle5lA9AOK7j
         TirRAcoNR289gDp0DKqPxHi/r2853K1QuiCERb1DU1EwX/qFDm7ZMF1Tl7wfY+P9zsmn
         3DqPkMrdJL2NcBZh6h8zyrkvR7UbHPXUw70yehOerv60s5UMij5SwJS6YRrK+1GQiA4I
         dlpw==
X-Forwarded-Encrypted: i=1; AJvYcCWNjNZgyr+NGUOyByC7zuVo52yGcsY66Ep4bOM6qoKkJgcP+DHbwtdaXez8XAuvCyl62D3WthiHH+RUyi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFBNBXuzIlKJQd5RrCSppqsVZbIx6a0HauF9M/Y/ynnLluOfH
	HE+8mTRBDrFSyDc6WOVrj6xT+rC4P86VOGOJsFeBbknXwLdioV6xNkxS4D14jeBkGUl6vyD2m/v
	EYssU+2tuH7riFwm6TXHCkut7YyrOitKHv56K9tZC747IiHPWEfjcJ/Z1DpG+TItEdg0=
X-Gm-Gg: ASbGncsv+7DNYGulNf7Cp4F3DYmbDBx6DTmImkLcDAGVsplmGJEiTwJfSo8OFl83Inr
	g92cmQGxW0hOUKuCJv/+F+Bib6hwkqhb1Cm8fm4L8+sgdsNdVq2ToXAzrAF6MSZoTk17z7q/vG3
	5XDWL1kRTnDy2IE4Hd0upafCk0WgxV0MaNXb8SHizh6D2/87W8Eqx2sWR4akfLfYFh8OVq0LU5D
	1/13NqTv/2Gv8pLBo3cgqav7sNAcG3I3rKVszGsSA74l7IBW2O+CfXjt1RZU2gsd6EIrTsHCLvZ
	M9HGCJmKoeHHDXdQwzjqY92zMyHsYuh2G76BlXvhxiKBuAwFlKS3om0kk5PyHmuVKv4p2T2/abb
	ZWgx70FERTYQ/cJmTtprndjlyChg=
X-Received: by 2002:ad4:5d4d:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-879dc8e8b5amr134636906d6.8.1759837340096;
        Tue, 07 Oct 2025 04:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPO0pc61D7PrUDHek89IoEYYlLKOAWdzRK3cyRnVKS0r8C4VHw9zr6UpiSxFXAKmAVKcrTbg==
X-Received: by 2002:ad4:5d4d:0:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-879dc8e8b5amr134636436d6.8.1759837339372;
        Tue, 07 Oct 2025 04:42:19 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6397c9355c3sm5880830a12.0.2025.10.07.04.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:42:17 -0700 (PDT)
Message-ID: <1d052b98-4dfd-4ee3-b46f-ac043b406d58@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 13:42:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add dll-hsr-list for HS400 and
 HS200 modes
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sachin Gupta <quic_sachgupt@quicinc.com>
References: <20250929113515.26752-1-quic_rampraka@quicinc.com>
 <20250929113515.26752-2-quic_rampraka@quicinc.com>
 <20251006214830.GB625548-robh@kernel.org>
 <817f02aa-dfb8-a134-2fd4-fbdf8e8a714e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <817f02aa-dfb8-a134-2fd4-fbdf8e8a714e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QtdTHFyd c=1 sm=1 tr=0 ts=68e4fc9d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=Nkk5IEO714fOIWWTyTAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: E6LaYPWyD8H1CkVnAoTrA7ZyhyFOqeF0
X-Proofpoint-GUID: E6LaYPWyD8H1CkVnAoTrA7ZyhyFOqeF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMSBTYWx0ZWRfX7G6qs8Rc06Uf
 l40zhzpnUYRruYQ1CO2XTIWt4lqA3kmFD9fzC6CkeVFoYtSAcrIKArOLAjDVn0xqq48hhwr6QOI
 1mWK0RIA5DdhiqLItYn7dFb3f8rcyNAVJNHpS2iGtcWEia1saKUDGrLtJRDLwAls5MJhPQyOH6E
 OUBocWSH/OcO1cfVcR/MWaKHdCKCETS87iA0PR3qtuU0M9mI3WxsElbtveGBLUc2ZlYKExreEp3
 3FtFTKYXSSSHyejZ7N+1WU959a832DAl3yKG/KLEOP0VBKIyNBSG2HvZkvJOhogvjEnXOab9ecv
 DfRqnhNT3+mSJmlDMYrCFkeUMMVswNHTbwc2Mtbyv3OStlhX0C/5lMJXqkZVpUlnn2D7J9cfEie
 wVqnCUgjkZBxhHxJg3OenEhNaO9U6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060121

On 10/7/25 1:16 PM, Ram Prakash Gupta wrote:
> 
> On 10/7/2025 3:18 AM, Rob Herring wrote:
>> On Mon, Sep 29, 2025 at 05:05:12PM +0530, Ram Prakash Gupta wrote:
>>> From: Sachin Gupta <quic_sachgupt@quicinc.com>
>>>
>>> Document the 'dll-hsr-list' property for MMC device tree bindings.
>>> The 'dll-hsr-list' property defines the DLL configurations for HS400
>>> and HS200 modes.
>>>
>>> QC SoCs can have 0 to 4 SDHCI instances, and each one may need
>>> different tuning.
>>>
>>> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> index 22d1f50c3fd1..a60222473990 100644
>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> @@ -137,6 +137,11 @@ properties:
>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>      description: platform specific settings for DLL_CONFIG reg.
>>>  
>>> +  qcom,dll-hsr-list:
>> '-list' doesn't add anything.
> 
> list was used as there are 5 dll register, but '-list' can be
> dropped, and it can be renamed to qcom,dll-hsr, I will update in
> next patchset.
> 
>>
>> What is 'hsr'?
> 
> Hardware Settings Reference

Maybe "qcom,dll-presets" would be more clear?

Konrad

