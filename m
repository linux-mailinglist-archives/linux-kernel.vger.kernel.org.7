Return-Path: <linux-kernel+bounces-877433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA44C1E198
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E6A1894FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F672FD661;
	Thu, 30 Oct 2025 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2T51kls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hSrP6yRB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959A2FB97F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790265; cv=none; b=NEtmIJSh6xENBavbWdSqsKUe1pY6t75tFZfbErYpaGuEXbMb8JUVhy1FuUNMayxm8dt8cVnbKb7aT2KLspRq8rZ9BieBJKZdJYxTkeVjmegq5m//hPd8dumG5yGBP6a+GRqOgm18kun+BsFQl7xZlE7yH6PVCErFrw+n11dUM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790265; c=relaxed/simple;
	bh=shYbqVkuLNtiI53CreU8QZTbiYYqgXW7xVc9VY9PI0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=no6fZf8Lgt8Po015fZdBotIjNw95OE5L370G6cqxeIpuhtTC0Qw+N5w3ShfqUNDAwzrYSN+0ewOVh50qrJtpcZQaf+hbkPpQAWhJrimM0KsHC4NdMXnhZEL5KVZK+8n1+mxK2ZFJva2IHE4nKmian3oWGBtgxRgkWWZHxhc8USk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d2T51kls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hSrP6yRB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TKngOC1598492
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z3iJpVuXX3j99GeKbgFiZof6JOIHOivPLoo01x4NiCM=; b=d2T51klsW1sj5z92
	5vDcJNzrei0myoE3xHRF9OrvueJ57LQAAOnmXz9kGQPf/3DbLFkwDmlkdBkkqut9
	+0/WjCJYPz8n5Ve82PAwrmjqajc+aSbgfVBXLW96J1KyAMw3NJ92iSjskyz64Lbd
	AgCclwGE6dKK/W7TqKspLtFNfUyjYROBUj3a/Ge6ELacnebRIjqT2R6MKxQ3xgGM
	mY1Hib6h6ZjuDjRy9VXDD6grfTUNtfO9gAcFZDmf1ro2yFazMwfpfV7zFOkSX6jV
	Wdw88J/H+95qf1OL6sXDH73xDwRRxdAz6DrfQjribFsS6fa6ZpxM0hOvj0T5lyQL
	4JoPIw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7rsd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:11:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bb4d11f5eso567136a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761790261; x=1762395061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3iJpVuXX3j99GeKbgFiZof6JOIHOivPLoo01x4NiCM=;
        b=hSrP6yRBzkNa6kX7MtjIvb3jboRa9uJ6KlhfWHW/9sdvfhBcvCgKL5yQPcM8QKUN3T
         hS/mLqSeoYVHhwbiSMhm2w0VjR5cHOFct1yt2hn5GLGJ/ezPfJkromjxcTxGzpmpG/WU
         Y2CrOp9X90YYtCtWo/9EdfbFQf80xtNgss/ZQR2aZyjaDj60HFYdvwYKF4GWGatJepzy
         BEHHMpsT8q13uRJ4miLJYMUN0wT9qjU8WUNA3TAt58TfZAy2i64zciv31vxkXlxBdT/3
         0XadKS4WJWGFK0nK+301af2ACpz6PdTUBQBGckZPIi2gbMv6vUYLYfKSSfh1aR295tTS
         EKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761790261; x=1762395061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3iJpVuXX3j99GeKbgFiZof6JOIHOivPLoo01x4NiCM=;
        b=oiWV2WRm14209Ec7vjtSVEmm02xWHrvdn15/bOUM2QvqVCdOME+IuU0MjIsHpH/yee
         FTwI1zlgJSEoetCbtEwBcF5jB7zvFS0JXMtwdWZEuh/lmFyqfV377+euqxzynZHK24Mk
         CAETBhzlGwzEndqsWDNB4mV5sKDgVzVxRgqY4rA1x/kMAypW4Y2yQmrxLfEE+epvgS02
         7m9ZiBZtG3+JuqASlYnVdMuP/KNuk+2CsKPPjY7RT7Fjzz7XBggSBj9hwcF6wF4ZSNfe
         daE6K/0QKQNdVSrVliQGS3uceRYgP56BC4v/3nUWMP5ttBAw1aJV71r1+uvd7+ima82K
         AeZg==
X-Forwarded-Encrypted: i=1; AJvYcCVSrShDBzcsG0DZeyAnwquySAeus+ee2t4W/Lijrv0zjFud7rD6fX99ljarC7+BNWixNk2u1mJa5krPRVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4y6oJzDDLqRUZPLxpCzV0eRbxrKn72M382yAsnHEntWMyBRe
	iV/Dm7xzHlYUN7SzGBK7PYTpilrZzKJLD0ratPedNnvnnt0ea2ayfpzU1+L0IGK/AS6BnvECVZ2
	iAV5vZZC+uiuyqSVZ0HKWuReCzEmtiOwifONKnNJrUTaBArDXnsJ5UHXzz5eLqD89gdw=
X-Gm-Gg: ASbGncvsLvqbnzSipQwrfKXjakO13Z8eExGasfPGEGIeLrqB67apGLlbQqQnn5GW3bn
	vSitqq0pzy6LKNogrrkxqP4cUSK7dR/ncJmooowM37QSaxiXIdAwcfI3ks8bZSO0KK6wD17EU2T
	VPCKFUv0qgHOD5gDsUDfo6rG+wP95XDl8am0azPSzTEK6zoiZ22ds1PtC0PqUFs27uYFBq02XP9
	8YT36y5iO4LxOTIJNZyV+7kVrlQ3TwWQli6oQt7MteNvucapCISgg3emSg1fkN92OBzXwIUwgDg
	aJdfc/STTWpoEIdfCEiXtfKDkfYxniy93F3OlOXAjhUwonoeSCaYlZDkjEAiiz8QsUNZpccf5hp
	rtBgg2jkeKlpCNA2Kx6fNd8SUIzXUD3nWZDISsBUvsaVygLSHT7HygPCOjTJGJaG07vrT
X-Received: by 2002:a17:90b:3907:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-3404c41c74bmr1567843a91.13.1761790261369;
        Wed, 29 Oct 2025 19:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj+R3WSmUGG6kffdX4nhUtyKII1fP8kB2aIG3NI3dVQuvVgPVLuOXt0D6O52gUK2tjrBHApw==
X-Received: by 2002:a17:90b:3907:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-3404c41c74bmr1567808a91.13.1761790260667;
        Wed, 29 Oct 2025 19:11:00 -0700 (PDT)
Received: from [10.133.33.37] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402a528e81sm3939736a91.4.2025.10.29.19.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 19:11:00 -0700 (PDT)
Message-ID: <554b2053-db21-46fa-b5b0-3d548c1e182d@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:10:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: remoteproc: qcom,pas: Document pas
 for SoCCP on Kaanapali and Glymur platforms
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, trilok.soni@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>, yijie.yang@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
 <20251029-knp-remoteproc-v2-3-6c81993b52ea@oss.qualcomm.com>
 <176173731073.226348.14173297054891268954.robh@kernel.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <176173731073.226348.14173297054891268954.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6902c936 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=VXIIVhnlSoNZEwAaSBwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: BbX-OBfXDu1RFurA3rKk-zN4FETGqjNs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAxNSBTYWx0ZWRfX+tFwZ8LHeKgV
 Roc7mypUcuRQ60DVaDF77O6+UmUELSwExrQpwehVXROCojsGOzyeCmRzYdVVc8EI6EgNF0Lkt7H
 3JB3tQWPHf7/5Zc33YYgZbkZIsAJws4TaR3Cg/dQiMT76LHztjantH4O/cH7edgMwk7Ag5pbh/3
 6mJT6ichxMOIGesaMrp1NQHgOUgoYtszGU4W2l98IXVoPFiOeF0cTVAFLgxBKpxCFrZK2CCHOYT
 S2V7zy9pkS8QEW85C0RAfC1c+IUUm/6j7a8f2ynWjhCWFJA4N1O/5I4UiDzybSHbkhfy7olR/zw
 DCbP/HkGpX+LhrCv9h+D+I+UYfCfE+bx2W3H/hNQBuDC/Ui/dWCKvGfFwAaz3guGtOv7iOdU3x7
 PvSfQs3hsthAcbZcYW6SrkocYH8OLw==
X-Proofpoint-GUID: BbX-OBfXDu1RFurA3rKk-zN4FETGqjNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300015



On 10/29/2025 7:28 PM, Rob Herring (Arm) wrote:
> 
> On Wed, 29 Oct 2025 01:05:41 -0700, Jingyi Wang wrote:
>> Document the component used to boot SoCCP on Kaanapali SoC and add
>> compatible for Glymur SoCCP which could fallback to Kaanapali. Extend
>> the "qcom,smem-states" and "qcom,smem-state-names" properties and
>> add conditions for the "interrupts" and "interrupt-names" properties
>> in the pas-common.
>>
>> Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  .../remoteproc/qcom,kaanapali-soccp-pas.yaml       | 134 +++++++++++++++++++++
>>  .../bindings/remoteproc/qcom,pas-common.yaml       |  83 +++++++++----
>>  2 files changed, 194 insertions(+), 23 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Lexical error: Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.example.dts:67.46-62 Unexpected 'IPCC_MPROC_SOCCP'
> Lexical error: Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.example.dts:70.33-49 Unexpected 'IPCC_MPROC_SOCCP'
> FATAL ERROR: Syntax error parsing input tree
> make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1547: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251029-knp-remoteproc-v2-3-6c81993b52ea@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Will add dependency in next version for the include files in example.

Thanks,
Jingyi


