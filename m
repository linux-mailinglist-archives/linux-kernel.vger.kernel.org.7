Return-Path: <linux-kernel+bounces-846581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4AABC8680
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B04D4EB04B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10802D877C;
	Thu,  9 Oct 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYpgwDP1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCD1EF36B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004484; cv=none; b=nutScKnTMDd3xg8c1maCLX98kSJ6AshoHXDoIO+v7i/YxW58mrMGom+364Ov186m0xXBE1T9TNgvg8fKWqOE6ySBZPMBP2YNikI+6hsQqfapGpvPtCfqQzTH3e9/rIUj61hMz3X0Ds1d3KUeVCmXMthtToTi6HnC7i96s+XYXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004484; c=relaxed/simple;
	bh=kT5aSsHLMvJcFYqS9858CtPC7VkwZb+zjN9Q38ZnC4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGd5pYiBprFYD93rkaVlhmgZTCiodEZoE3VIGdyHEEh4VXeY5X2miqe9ESUKVds10Er62fE4+Ml/ec1fkgLF9SIleWD8xsoxjI9HbXW1eS4AbBIu4I9QtPq+z82UILbuoQHD47oEKA2NyKyZABM9qSNeGh6MtQf1gCPmm1At97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYpgwDP1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EGJ3012249
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 10:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k+lyzqRYoN1PwxO1BIU31aKfB/fnT5JSDjuNND3aBzQ=; b=QYpgwDP1D31aOMyZ
	YywU4gnkuL956SZkp7cBGO5LaGfKNEZgHqi5NfNiQBQxnp9A1zjhbJsRRmahjk1i
	o+AzAphCR8lYi9fUzbfU9z1l3Li99k1/AtAnJzQMN7lypuO8d/2sm3INOyY932Om
	EeXe+yIhHT7xU7GBe4s4hLVAji2cmxqBn+RdfCuMZJwlnZJUV9VvOigMtcbXbOFH
	5GwojK7LWKJ1D+TdXSVka4uVL/avCw6qmNYviX6s0DKO7s7Af4bIz0DCw6rJZRRs
	KO8aowESXsejlQKWn4x+Rw0e2I0S2xExV1xBcKmdLDxa/jP2yzuTJI0LRplvAxED
	owkkeA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kjceb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:08:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272ed8c106eso8456515ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004480; x=1760609280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+lyzqRYoN1PwxO1BIU31aKfB/fnT5JSDjuNND3aBzQ=;
        b=GB+2XOuiNqVE68dmuWpcsG9MQeSfyeqZ9Ov4sIYw5LUcoUEyaYVgcyIQListvXJM/7
         Ta3EcGFLghCFHxWVEO783BX59L97uRov4eyYWPTkQg++Ate/nhII47qwDZCDaT50xCu4
         tK5gQasbBVbqs0AxvSg/tzM24+5GQazPQx55AkacIEcoCUrOE25YOXmXBl6XwMaFQdsk
         DKsgew/OD9OtS7GwxEwsa84yMgvDVeamju9I2BxF2Z78RwJXF/VDElE+TLVpMZRZCVeW
         xBYkmnKAUmbLrKLcO/lueQVXbLlmZ+LmezYsrzW9hwCrCbrILP0jfHSBdJgypKg/1Z7K
         j0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/SNavGIof40RXMK6Uc7/p8+zDB1vLqaJvrK4ZrT9nv3oatzdy5eQPNgYesAaWLQHCYDJaLWrbc+ZFtB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+xbgWcKh5czny+t0kPKzgPDaZbYIQGmy05I8O4WEhO7qKy8R
	9NxwPK8dL3NVhNF9Op+03oJGJqugtA83hxpmtz/A2pYazexUXAH+Lc6oWTLvl+L0DgKVjMKeQ5E
	uZgVN0Ot2e9aCBJKWTF8T/qx6Vkw2x9KPEpBAmvY63gmfJeAteNVXygV3FChnmv0N9nA=
X-Gm-Gg: ASbGncsEvqoNzMz0MvM1L4YLPEyqoVIveDNFZWBs2M18TMx6PizyAi5qidmXIot5hTh
	/WK0g/SYclk4+11TDjqHAFh5b3uzXHrzGKfSAthPxXdJyhmru9jsmvz2KnQWoC7ae9slXhxP8/4
	0kzf0NgD0C82PmEQxJ3maEyAyJ51CX8eoo6Bgjm906CklP7Nw8WjwfYQLFO5WBXVKKcv1ZvNMvE
	pByCvnSQiS/HxoPZYdUOEHXcxsx/DjLrjBC4gBJ+KhoVMmuUexWseLvIRNKYdyfVbJUHynKjg4L
	XZhQS0Nms23YYE8OjsoDzid7m0VIO8N6Mn+s+a8LzIj9yHvvucev5kCfxxBXttdfU9bLFnoNNVc
	cZzr3owNS4W6j/2qxwryG4IPBB84va2dFwZWAqoZ3tdfNeMWj8AvaY5jslqwXeIw=
X-Received: by 2002:a17:903:11cf:b0:261:1521:17a8 with SMTP id d9443c01a7336-2902723b1d9mr94524345ad.16.1760004480410;
        Thu, 09 Oct 2025 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbxN93j7VTEPwO/Swvo0O1F5pdyYPalvwxU1PLckRm8Bj1sYEuo3JDASKn6xxZmVSucH7xjg==
X-Received: by 2002:a17:903:11cf:b0:261:1521:17a8 with SMTP id d9443c01a7336-2902723b1d9mr94524045ad.16.1760004479935;
        Thu, 09 Oct 2025 03:07:59 -0700 (PDT)
Received: from [10.190.201.224] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm23636155ad.104.2025.10.09.03.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:07:59 -0700 (PDT)
Message-ID: <e281599a-b34c-4c68-9848-c3ae51fcd095@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 15:37:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: mailbox: qcom-ipcc: Document the Glymur
 IPCC
To: Rob Herring <robh@kernel.org>
Cc: jassisinghbrar@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        mani@kernel.org, andersson@kernel.org, mathieu.poirier@linaro.org,
        konradybcio@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
 <20250924183726.509202-2-sibi.sankar@oss.qualcomm.com>
 <20251002003936.GB2672888-robh@kernel.org>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <20251002003936.GB2672888-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e78981 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=PTK300C7mqS8JA3qkmsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: OMmLmRdkbN0Q9Q3RszWj-HdR8gZBiqnt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2FfutEOZ/9dQ
 g26pgqI1IpKKgOG2QRxV/+nDXna2KnwUST5fcckRQdL8xxPA+zuh27vqbpXaQFFnyVo3AlNzpcG
 atjQ4t/WbB9GoyzrrwAUdAM/+snAWllxUiJQw8/1uXDFbYgBnrrzP18G23DnQxHVt3wXhMccopx
 C9G9jjycMtq6pI/3CTLGgbztDHXApyRDEZ0nTkT1IfHk1pTEduW+qGUmxS76Pekuj6pb5pweG91
 RfJxoIvPafut45wBMK0rV5uhYQKmucrv4ieQ702/tLWC/eQV9+mHWKvSegDAdPswisTPQUzK23Y
 8JTcNCeisLcWYsyQZZC2yeNTvw/3MSWwQrrywe0HwCE/TjQPLMf/cKbaukhrQ2Sblo6rc0zXH7n
 Amft56rq9t5f3UURd5GP/UEvuJjhUQ==
X-Proofpoint-ORIG-GUID: OMmLmRdkbN0Q9Q3RszWj-HdR8gZBiqnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On 10/2/2025 6:09 AM, Rob Herring wrote:
> On Thu, Sep 25, 2025 at 12:07:22AM +0530, Sibi Sankar wrote:
>> Document the Inter-Processor Communication Controller on the Glymur SoCs.
> That's obvious. Say something useful here like how the h/w compares to
> existing documented h/w. Like perhaps the change from virtual ids to
> physical ids, whatever that means...

Hey Rob,

Thanks for taking time to review the series :)

Will add more relevant information during the next re-spin.

- Sibi Sankar

>
>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
>> index e5c423130db6..129870185884 100644
>> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
>> @@ -24,6 +24,7 @@ properties:
>>     compatible:
>>       items:
>>         - enum:
>> +          - qcom,glymur-ipcc
>>             - qcom,milos-ipcc
>>             - qcom,qcs8300-ipcc
>>             - qcom,qdu1000-ipcc
>> -- 
>> 2.34.1
>>

