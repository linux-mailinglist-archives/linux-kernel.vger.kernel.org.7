Return-Path: <linux-kernel+bounces-888220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC76C3A393
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC841A40029
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396F1D63F3;
	Thu,  6 Nov 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4PKp3VV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SFrWSyr5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673341760
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424212; cv=none; b=W/ICIRGjmNud8AC8O4cFllAzqO+SnYVWaAI7Pnuhp1PMHhypjNQL0CygGyntGSn/1xUZ4281BnC2/L40hFx7WsA53vnyKbkS94yJvU/l6m93EHnxRkUczzH3uecz205EIYoEdMPEUfzvZ2pKbXRjl1Pf043GMM5JoqbnscFpCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424212; c=relaxed/simple;
	bh=DGWoqCzKmVs/0jZaz2EfOrEZl/PlMpk1s+c9/RziQu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdwCeUN0ULV3Sml8kHxhdOdbvjKSxb8Eb4Pmm8vZ2gGHQsFEpWs6yoc8ZVYVwl9nvrPofOVpgTmk8akHCAE6H4ANUo3mf2FZEaDk7tWVPhCOBoqBZf9awr8/ui7B1qhUHncZ9+nJAKiPdWKPvKsptwZFtu79pYxopA6F+VG55Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4PKp3VV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SFrWSyr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66f7Kr1784631
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ld70hxnphrhk4Kj9QGrjJNc8gxNktsdj/F6KF/k5xBc=; b=G4PKp3VV7uS3XdTy
	dsvqGawJORmig4RZ49jJ8EuwhGH6kLiJHpm91IYw7JNzhG61Y3JEMqh/XK4EdQSR
	rjiZwffD8TtenicOLftHqmaq48QoXgbOP9cLrgHrIbQB016267qcUh2lbeK5B7Bg
	ws+7DGCG+36jKfx/XJEQzAHVKqoCJTyw7XJbJDCMZrWgnoItI0HsKq537U/dXqcm
	+OpPiSkJnt6nc2l7TJMA+7Y7x72mvE6Mh5J5puF4CV7TM7MWJxkp41ECBwzejqKo
	XJJdbZOZC10TmY80+mNqfoagAnwUJfbBVNVGQdtaQVyw0NZKOs7BkR6v43NSPSCW
	bkRWbA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8amxapst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:16:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9c1b12c151so112283a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762424210; x=1763029010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld70hxnphrhk4Kj9QGrjJNc8gxNktsdj/F6KF/k5xBc=;
        b=SFrWSyr5oMcRZbq2rTKvyc3C5DJ8uJ6gLdsfHO8drUIpb43mUKZK9Ce4AY7UODeHDj
         eKjTWeCgsdFv+KBja+GOcnKt5z4QleOZkrhF8MICdFgf/IM7TX9gIJDafwY4HQS8nd6T
         sYqoKCc8kLedOlP/eAF9g/3WFWUVdsaHNTiM/m7fwMSN3zm3pSl/RTm8X8Zw6PWmj+OY
         Mi7uW0J7KYaQp241rIJ+sDAA2ADWquaS3iZdpGepDBYu3YB06GjN6teg6IkE0IeeUB5z
         V8gPd9tO6cUwjo1R7RVTXHAKNE//gvuUxvDo4h/74XHWOWleKBKDRsAiXrEO4wq9dXdK
         JEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424210; x=1763029010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld70hxnphrhk4Kj9QGrjJNc8gxNktsdj/F6KF/k5xBc=;
        b=lk+E4MuvPBZ2Sv0BanUkvxKeYaro7p8xVZ+YCjK9eP1JitKrNNwYctmIaNb9P6ic39
         NqIZc8/htsHSmP5XKP860uOxXQ6HlzdziMiIual4Q8R5khXtNxGALbqQlewe62EbWB3u
         JrKirgUCzuUuD87CQwgLVFxrauuP3j/U60tI2fKcbkDu+kP9HDaG64Q8K6mOIijnLtXP
         KHQ1VexAbYueRT6hMNaVCUQdW7VVAWi5maxdO3S//TzPWCe/HUsS0QEpwaMYK45o3OE9
         3DUKwpKvC4s+clhBa9JQycUWqRdILKTwUPG+cm8r/BItG99vqEeRwd1chhoYMKOZUVOm
         OAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYoBUkZt+2jjzru6L5Ag8wv3gGmR0Zo0Ng5PkZ77i2yALwL0suzW3XE6T3wJVkw6IRdLfPYT7Brf6GSkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeL5BLstL5EBokmvy6I5wFGkfsLFCuvyZ5k0bEGW0eXZMSR8o
	vDZEUd5Z1FdGxopyNJ4DykMuqlyfh+2++hzW8J2l2N0sUVoywDywMvnygUot9sSo6+wd2FF/Tcu
	dWwA2ig5oelu3muW4TuP9LVf7JaINo9ADXMnruhhyICVCgtKlnuqi10kzkzdf7JFS/ck=
X-Gm-Gg: ASbGncu3w+RtaTlh/6T++xPIzgHWq9rOFWI/apdfIgkYZPRPzXhRbl7iiCbuGRdqWnd
	8enjbOFt43kJ88VMJssuyTK8i4DYaDvkDJO8NQig4DckgHzc66PRcnScpSoWj8BTYt2ztD1EPzN
	OwyP4yTKoI3dPk0dqfH4drgI1eYuiL5XImeRfxgJuiMrm9h3TqXnNdq7Juefb6NiRbFTzEv2l5E
	XlPQ0cr5zYjlAJsSwrF+kRtBhxKnaHWRtbKlVP83ycnIHcmChZ5obK1StXQUy+SPXc8HY6urIcr
	YavMomstzL4WUaar0gChyBSBe7hznYIC0gcZaTOzRZl6D1vOXEMCGtOAht2axjJevTDyMbYJ3tD
	yWUyMAtxT8u6k3z0O/2cfjWIAl2q31Si8AvMeWHnUPHo9kFr84564hHAga012LSA/xA==
X-Received: by 2002:a17:902:d507:b0:296:4e0c:8013 with SMTP id d9443c01a7336-29655b1d5c2mr21368715ad.6.1762424209476;
        Thu, 06 Nov 2025 02:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxkveGzxOeBDZzm4RdgFR5ZBXc88H70L9ilN/dHlVAMe4qDjUOu4tDtQfp+FEslZh4bwV/SA==
X-Received: by 2002:a17:902:d507:b0:296:4e0c:8013 with SMTP id d9443c01a7336-29655b1d5c2mr21368395ad.6.1762424208558;
        Thu, 06 Nov 2025 02:16:48 -0800 (PST)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm23392665ad.44.2025.11.06.02.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:16:47 -0800 (PST)
Message-ID: <b5ecf5e7-4dc4-41ac-9b56-7c52afacb950@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 18:16:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: Add compatible for Kaanapali
To: Bjorn Andersson <andersson@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
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
 <ad00835e-bc20-4f97-aba6-e1b4f5e97191@oss.qualcomm.com>
 <f2q7a7r7quq6pplcn3kklwrhdc6hxa5zvc7osygshtyurwyvi4@t5iyragt7irh>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <f2q7a7r7quq6pplcn3kklwrhdc6hxa5zvc7osygshtyurwyvi4@t5iyragt7irh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3JeLi1OVprSnNC_Fn8Jm3REeaqOvkW9I
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=690c7592 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ON1wIvcCeMpCzfIEu8AA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4MCBTYWx0ZWRfX9PeEh8HAy23c
 OaGlCdUBA7NrxvGSPceukhZbY8F9QZCOyWfhZxs0AH7loC6DfisbdTI84CTiliCW91VNHQOJVD+
 q1qmdkMN1rvPhfy0PhIgpE2VNEenpzv2py7y007BuGC1v/RsqbV4jugo2Xka7rDuWkSm6X956VY
 NSkB4/mracbgJd+PbgVP4Wm8KzlnSSdG/WR1gZhbG5lNwzLj4EiJgg7rmX9NgJZGCGU7/v2uJRZ
 coGVdJYOLvNA7cvzEyvaB4atcVCoSAzNxBOyZhSI0tgyq4hF7kxgBWbazwPaw/jHBDI5fg/92h1
 jY4Ngi5xdDA2QEtidizoOfn2jDObDW8dHwX1Nm8EUou3SnlJEQpJY9V4wfS6X5uqIJByQ3rgBs1
 +92bqQEtyS4JL9AeB63qehiq1bruUA==
X-Proofpoint-ORIG-GUID: 3JeLi1OVprSnNC_Fn8Jm3REeaqOvkW9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060080

On 11/6/2025 5:06 AM, Bjorn Andersson wrote:
> On Tue, Nov 04, 2025 at 01:35:01PM +0800, Jingyi Wang wrote:
>>
>>
>> On 11/4/2025 12:02 PM, Bjorn Andersson wrote:
>>> On Tue, Nov 04, 2025 at 11:34:25AM +0800, Aiqun(Maria) Yu wrote:
>>>> On 9/25/2025 7:23 AM, Jingyi Wang wrote:
>>>>> Document the qcom,tcsr-kaanapali compatible, tcsr will provide various
>>>>> control and status functions for their peripherals.
>>>>>
>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>>>> index 14ae3f00ef7e..ae55b0a70766 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>>>> @@ -48,6 +48,7 @@ properties:
>>>>>            - qcom,tcsr-ipq8064
>>>>>            - qcom,tcsr-ipq8074
>>>>>            - qcom,tcsr-ipq9574
>>>>> +          - qcom,tcsr-kaanapali
>>>>
>>>> It looks good to me. Glymur didn't have this functionality verified yet.
>>>
>>> You spelled Reviewed-by: Aiqun Yu <..> wrong.
>>>
>>>> Remind for review.
>>>
>>> No need for that, reviewers will review when they have time.
>>>
>>>>
>>
>> Hi Bjorn,
>>
>>>
>>> But that said, most modern additions to this binding follow the common
>>> format of qcom,<soc>-<block>.
>>>
>>> So I would prefer this to be qcom,kaanapali-tcsr.
>>>
>>> Regards,
>>> Bjorn
>>>
>>
>> qcom,tcsr-kaanapali is used to distinguish with binding for GCC:
>> https://lore.kernel.org/all/20251030-gcc_kaanapali-v2-v2-2-a774a587af6f@oss.qualcomm.com/
>>
> 
> So, qcom,kaanapali-tcsr is the clock controller region of TCSR and
> qcom,tcsr-kaanapali is the non-clock controller region of TCSR?
> 
> Sorry for not understanding that earlier, but this doesn't work for me.
> 
> It's a bit of a lie that TCSR_MUTEX is a separate node in devicetree,
> but it's always an nice chunk of 256K in the beginning (or end in some
> cases?) of TCSR. But for the rest, there should be a single tcsr node in
> DeviceTree and that one node should be a syscon and a clock controller.

I've been dive deeply on this tcsr block. And actually the tcsr clock
controller part is a very small trunk size(0x1c) of the tcsr block. And
this block have contain other multiple purposed sys registers. So maybe
we can have a more discussion on how to have device tree node describe
this situation? It is not straight forward that to have a non-tcsrcc
related area being described in tcsrcc.

What about option 1 (tcsr_mutex + tcsr_dload_syscon + tcsrcc):
tcsr_mutex: hwlock@1f40000 {
	compatible = "qcom,tcsr-mutex";
	reg = <0x0 0x01f40000 0x0 0x20000>;
	#hwlock-cells = <1>;
};

tcsr_dload: syscon@1fc0000 {
	compatible = "qcom,tcsr-kaanapali", "syscon";
	reg = <0x0 0x1fc0000 0x0 0x30000>;
};

tcsrcc: clock-controller@1fd5044 {
	compatible = "qcom,kaanapali-tcsr", "syscon";
	reg = <0x0 0x01fd5044 0x0 0x1c>;
...
};

What about option 2 (tcsr whole block + tcsr_mutex  + tcsrcc):

tcsr: syscon@1f40000 {
	compatible = "qcom,tcsr-kaanapali", "syscon";
	reg = <0x0 0x1f40000 0x0 0xC0000>; //align with the whole hardware
block design.
};

tcsr_mutex: hwlock@1f40000 {
	compatible = "qcom,tcsr-mutex";
	reg = <0x0 0x01f40000 0x0 0x20000>;
	#hwlock-cells = <1>;
};

tcsrcc: clock-controller@1fd5044 {
	compatible = "qcom,kaanapali-tcsr", "syscon";
	reg = <0x0 0x01fd5044 0x0 0x1c>;
...
};

> 
> Regards,
> Bjorn
> 
>> Thanks,
>> Jingyi
>>
>>>>>            - qcom,tcsr-mdm9615
>>>>>            - qcom,tcsr-msm8226
>>>>>            - qcom,tcsr-msm8660
>>>>>
>>>>> ---
>>>>> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
>>>>> change-id: 20250917-knp-mfd-4dd3c81e6b9b
>>>>>
>>>>> Best regards,
>>>>
>>>>
>>>> -- 
>>>> Thx and BRs,
>>>> Aiqun(Maria) Yu
>>
-- 
Thx and BRs,
Aiqun(Maria) Yu

