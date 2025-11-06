Return-Path: <linux-kernel+bounces-888073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93034C39C55
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101E118C653B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C130BF58;
	Thu,  6 Nov 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDNgVcAp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNyppZ41"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991728488F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420529; cv=none; b=tCqZXagpxAv70GvUX+eZfP3GryaSCUQ0en0AjKpv9fzjy8CA//t+01aiajjGtXqfV4reWWrYDJxmOiVYC4RbknSby/KP6j531c2sUuyw72I4TVTyIRkE0z81k0REr7d4NxE+CtvxW9oskRggyUIC8FWAPKAvMt5319hGN7G+Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420529; c=relaxed/simple;
	bh=IqDU06J8KRhHUMTkW8BrYVFpwrOQjixDrvjAH5rTJAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkirFak2Ucz+yq7qcywCCp44YWlHdhLSMg55YsNqJEGVqQmJAK5E+KGpT7xCfTNNHozEbGr/ASuYh7r+x04yf5D17EWauSXPkbgBhIqom3CKFDLlI40382a9cGvmJxW9PEf1gn3vaveD0DSkl6aK9XNmksLkE4GsCLt1ISm4JtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDNgVcAp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNyppZ41; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66cUSe1688932
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 09:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSBcZQ0RQcmst4/RrknYi9gdsm4mdIdNyFnHTvoBzKs=; b=cDNgVcApKbRwtG7v
	L5rHIcBYbNNuzNB8KDmIvCcdBIvVgdJM9C19bJ4ettuFGcrKpRk4XFZ8Biy6xQ/J
	h0Qlfn87zo/YE3YTQyJpp1VRw/SuQKs2tCerqQhQSMha/BOn5RsomcgOe1I1YG8M
	s/LaKbPVyi3eig/hC5TPmyYXnqcIk6FMtGp5czn7EYUHBNsVSwrPU2jE+VPJsYvW
	d9q43herYiIKYu/IoMaHdzWUOmA5UnToWOgp9qJ8gul3ZAjsfz2bmHUZIgJ2y9zK
	5XqYbkFUx7Tz5ac5CiD6DCtUtKVVFP5ljPBECo7kULDBQO8gAPuO5ZdBGktzpwfO
	uDXRkg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88pjb0et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:15:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so609732a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762420527; x=1763025327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSBcZQ0RQcmst4/RrknYi9gdsm4mdIdNyFnHTvoBzKs=;
        b=WNyppZ41ePsCf26j0StWs/LI5b+bzeO+VIJ6njMdszO/66mchsnyGTcq09zxHL0SNM
         hyCkTgIN7vK6jiv13cfzAmsQAFt9w2d0lVm+egqUueikUElQJK/nINmwwYtbgyLGzzJm
         IjQCm0//b6iFEYQvfcCaBqL4uZ1F9gilGCQnxDfCd9/iuKhMF7zZsfZtRSn4IbnbZUuq
         OANPsu0HKfR+xacY68McIH0eFJpvv575NFg9AZBw6aIQ0KrPPp9abpyhVtKRCiJiqhQP
         eKlUCkUedeUTnCeIQYO50tIzZt/h+aOvbgGOLlLHMwW2XtoNH/EYlWvKQLaS3TsgUZ2s
         06Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420527; x=1763025327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSBcZQ0RQcmst4/RrknYi9gdsm4mdIdNyFnHTvoBzKs=;
        b=qtXwrsBJKdpvzRjXbTYULnsrO+t0C46lFTeU6HQ6kxzXIP5+eQofcFwH8uNOPvy5Nc
         Svyp0qIgJBf5b73NhK9oW3R5h0BNLsnnV6lXBEXQvt1I4Ffx5F0Kahi3QXLVpzNISBeR
         TvQJDl5K8ofihJBkJRXvYkuuENwBNdPZtV9rLd11GHe01i37m1GmII0gQCCQyuiMbmou
         OVBAiUL204LVHJr7VaWLsplYTfWSFMoKYuyp0ckE87GyH1vueD/VAbx4TgQKCjTOI6wg
         u9Gchvtz5VQaZYcQe7nZ7lXisH8qIISfcuNwWPfGyONf4YN1jZ0DPU3LhXVFMLEchUwa
         xppQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHREOxlT4HTSphhLqy7Yvj1gLSKce7tAtVPNQvSug9+8BWuG602dxaiXk3LxmcjWa084hffKK6jKpzSD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+v3ifPvbPbMC3PF+Jb1UB8v1PfPgFUsMa3HMToSKxkjc77HM
	0VKvbqo+IaWZf/l44dQUBqzmdARI7RC2RQOqqJ6ojp/nETMFCBZQ8VXkIvUHikFL7AaNFHUwZoN
	GX6rGiSzm1B88K/R139s+6JiAlxL5OANykLSxnBr56qNKTKBIbYJ1Mb5R+/qVNbu7TTA=
X-Gm-Gg: ASbGncuB0JzNe91jntirpnKHH7+08FP+6/S35rBIETZw8CUZkhGvz8VypH+bHLTU63p
	2jGouMWZ+u+3v3Dqm66o/gkE61+TF9pmrwpmEYGKPthq7fP/1qUCg+5OfUF5VjitWWF3qlAsBct
	sOah7AMkP3OYh32eqKgZes3OMRD29fQuwjd/vgI2z6buwxTjuURuTOibuGt58+n5OPCQlu0KLaF
	tY/PmaR9qv2WY7dmeSU3XeUeyl1XfZ7FCGQth72L2vsPhhNKl4G5DFPc5xD6pKRLhWNXtliLDaM
	Y5fPRsNpXjZ3i307Ot9vpDR/56PGzG2IBsx4Lk2omTAFbzCIdo9rRAfAWLaCt5xQti2DK4R2Wvt
	sEyPdMehahWb9SfTxQcHlvDISzw==
X-Received: by 2002:a17:90b:2888:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-341a70082demr8272605a91.33.1762420526752;
        Thu, 06 Nov 2025 01:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHun9YYghwsNEVAON0drNEeOBr3tdiHVJCshN/1Daostzc8S6e6a1xDbSuel5MNU+po1yNqkw==
X-Received: by 2002:a17:90b:2888:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-341a70082demr8272554a91.33.1762420526210;
        Thu, 06 Nov 2025 01:15:26 -0800 (PST)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm1083005a91.0.2025.11.06.01.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:15:25 -0800 (PST)
Message-ID: <25e8453b-91fb-49f2-a61b-fd7b3267e558@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 14:44:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
 <1e464f5d-f4ed-4ee5-b966-fc7de586340a@oss.qualcomm.com>
 <7f7179b7-73a0-40f3-b921-888b3e21537c@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <7f7179b7-73a0-40f3-b921-888b3e21537c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nSEx7XVrq-Pj_tQ2W0TlWdRVzhhVBZ61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3NCBTYWx0ZWRfXwQkFEbefj3Z2
 INi3CTmA0ye0o5kNtUGvnpoTMzZhZLkRFWDeYjJuy/ItkpDc5+LY3zicOEy4eetHmE6ZSjGXwdj
 i/3q9MYZ7eXhuxC84b0B7zBOIvh7JdnzYhjrHPUWB33hDLptBcUKpVfDbcsuMPQCkeschsQfp1s
 X7TpoInXZhGRrNkOTg6R1V+R7sx0fXSSr3VhonjK4KmoII/mtFV2RCkLG3LPe9wyyPIDKHo/TWQ
 ya0et6RMiWqB2B2whODLh8J+kB6B7wLBY9AmwZqbDRQ71eF6PdrM8M97eNlUYSxwONz9Yp+fe//
 7uJtvWVO8gNAPnLYjzGCqxB9CATN13mBoeXfvNbn/13pHqmH6xUtS8MFIQK1AV22YUOzRkMhRyg
 ijfqtBkWVTZ+IcghvQ7Nm3IE75Vb2A==
X-Proofpoint-ORIG-GUID: nSEx7XVrq-Pj_tQ2W0TlWdRVzhhVBZ61
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=690c672f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IzPYbt_51FXaukp9Qk0A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060074



On 11/5/2025 4:32 PM, Konrad Dybcio wrote:
> On 11/5/25 10:21 AM, Imran Shaik wrote:
>>
>>
>> On 11/5/2025 1:01 AM, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>
>>> To make sure that power rail is voted for, wire it up to its consumers.
>>>
>>> Fixes: 9bd07f2c558f ("arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp")
>>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 22 ++++++++++++++++------
>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index 5334adebf278..643a61cc91b4 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -4586,8 +4586,10 @@ camcc: clock-controller@ad00000 {
>>>  				 <&rpmhcc RPMH_CXO_CLK>,
>>>  				 <&rpmhcc RPMH_CXO_CLK_A>,
>>>  				 <&sleep_clk>;
>>> -			power-domains = <&rpmhpd SC8280XP_MMCX>;
>>> -			required-opps = <&rpmhpd_opp_low_svs>;
>>> +			power-domains = <&rpmhpd SC8280XP_MMCX>,
>>> +					<&rpmhpd SC8280XP_MXC>;
>>
>> I see that none of the CAMCC PLLs/clocks are on MXC rail on SC8280XP target.
>> So, MXC support is not required for CAMCC.
> 
> Hm, to the extent that camss is supported upstream, I could indeed
> boot without pd_ignore_unused and the camera actually kept working..
> 
> I see in docs that there are links between MXC and various IPs within
> camera so I'm a little confused. Would you know more?
> 

Not sure on the rail requirements from the camera core side, but from the
camera clock controller side, we don't need the MXC support.

Thanks,
Imran

> 
> I wasn't able to test venus because it locks up either way..
> 
> Konrad


