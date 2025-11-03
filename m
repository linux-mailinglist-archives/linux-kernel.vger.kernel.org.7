Return-Path: <linux-kernel+bounces-883535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA84C2DB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A3347000
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E631B832;
	Mon,  3 Nov 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZDPVvQg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SoGaV+UO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2183093A8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195407; cv=none; b=HfZIVwaVabjjpo7As5yM5CbuZm2L8Lu6dBru0vSOm7ILLMfNCV3YV/yB2F0hvyWZS7pmDpTdT0Ia4QkKqFsiPq4OuYxQLDhwsZt0k/reO0OrLl7vCOln4+8hdjhh6+cLcGXG2ef+JsPYRoeXW2qwCNQKBS1/I6XA1B5OboYAJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195407; c=relaxed/simple;
	bh=/GzKpLC6PmQOMk52lWhyCWqg2aaUKd2qMnQB0++1v6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOk1n8yqsFVuOcA3vANGI8toVhEA6MqJneRRT8ZdaBGJI7XrkZX2HwKw9/EsUKV0G1lJV8PDy3aEvB/Zh6Wq6/pgAMlfiGdRk2Yi814CYdqOPesarQ3jWZHe7DdA0eECnrkn5HBeQpndRe5paM0uAiiKRtJuBv9vTFPbNoMzwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZDPVvQg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SoGaV+UO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H6Q673693397
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 18:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c5+d4jykJaGaK4q6+ofZATU9EzTTNPt9yANrk9kKwWI=; b=WZDPVvQgQxWgsKOT
	dT0cIk+8+nS4rTh30074AFYVUew/j23DuEHXBP6Mt9NPWp0RueEJMriyYvtzyzeS
	z2t070Vg7zk+hfYXPAszz3seLeKZBrRNGdfJ7ByYP1lCdgO0zkFjaaWqoyyB1NVa
	VxlqjnCsh1o43CU7agK4RQcV5kl8t3Za3brFGd9bM8+OcGrByDV50fsEALUqCaGj
	oTAPpgUR/QiYF/7HP/zeXhjagkMId4E6JzSWy4RCsoFdPYmfi1b9bridXowAEzME
	iKB1hyUkhWLX4cqmwDfk0Ex4eqGJwq0juzXMa+g9iIu/nW+aDImbjdYQarqqVEnL
	R+ZyDw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70gm89k8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 18:43:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so3799329a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762195404; x=1762800204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5+d4jykJaGaK4q6+ofZATU9EzTTNPt9yANrk9kKwWI=;
        b=SoGaV+UOd3t+Sb1SdzgSAuVUWns2d9fGnTkCf+5CZE889S8J4qi9auFwFVeRrWzCNz
         niXm9CSG0W7g47xiYQn9cbwXQ72ptJ45H42E4A19dTBQh85gROdU5ngWwO2hFXRkgRJb
         yQgATHkTp4ThIy7N11Pdi6UepxziWNv8AnNUes2REXCymQgRvxKS3ERcLKWF20SI5ORF
         2nnqmTm+M0nVMhXEC6pTqkROsVvgGjCx6l804TxXFGkVDTNFDF4Eg3w5UyQiU3ylRppA
         x03Qe6NQ685g3Yr71X84nXbiQwQcz5deF4sK53EJ0apJB7/2RxE8S9vG3PQapVwuEj6r
         HZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195404; x=1762800204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5+d4jykJaGaK4q6+ofZATU9EzTTNPt9yANrk9kKwWI=;
        b=qbrWjyb+Q1iADgslOSdQCUlTkakr0j3xP1S+e7FK48gzP43Xhq9XOc+ahaixfdpZ3s
         7m17NVoFekHKbVtYIxXGY2FmDszbO051kAxJegng20rBtql4t2+QRVpFJKM8CgdgygzC
         EASLPQIfm1Xz0C+cP4q79qpWHHunLYwwDpELdi62DyQ/f9S9jWrgQHThicHHzmAR6ubj
         HxH694737fMGUmwGbRIxZbAj9WSnHetPw6E+gbfGCfczzZqG52yFxAoBiIxf+IhVtI6U
         WGPZW7mBJ3dbFwYbXATV3Y9TDEAiKQ3ahtyQn9xlubdCyHDgwo4kTjfZN3JkKhIUFwWQ
         pOwg==
X-Forwarded-Encrypted: i=1; AJvYcCXdtmHELRNMJG8MI0HxRst1pPYjEra5XcRU4VuMOxQf5SvbAw7LNDj3pdzD/W45vEqJxyWefec9Vg9KCPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv037IqM1Dehf5dNjw0Q32DzxWOmFcICawwY9LQ+lSmsBAf9TD
	6DXbjTgNAdTTY+L2G9ZPbHkrLZQ9rcVbSMV85NeefxEaRUA/oQR+EExNVOf/6wtJcJoRzdUxGPr
	3HBP1Lc+WPifd28iKh8B7XNwnDktebY7SMT2rM7bWoHhOD14qKAuKUQTnk5bOH26aAX0=
X-Gm-Gg: ASbGnctb8jr9vdSU15yaB9EBk6iTx+gKrW2IeABujHe4mwG24QIVsBGNwRc86mejDH0
	SbLjAC4NIqTGePeMM7ngvuTWDYNcZ5vhwymiATe7cznzH0S4QTOLuc/wdnONPYtfAG+Zf1db6Cc
	K3CmLPWDEXqILETdCojJkv6YLuL1cAzcIDvfxVx1nnkxLXXcIWpeafcMabALRQUPz1W1KuQXvtE
	Bn6yTS9bE7mx7EI5N2QHvIuCxpMD77ogrfzuk027PHPSh9xl6DTV6joDZt/dI2kGeG3qg6DDOeq
	apJgwz1Ix3kEkRY9dxSZNZ1ZzeVZQY0QJpYBEizk0prsuxeRKwX1E1YAuRHehPPj9fpEPQY9RdE
	pglugQADoRJZBD502uyvC3pk69niEJxYKlkNLiegqt3v1Z9AxulCmGA==
X-Received: by 2002:a05:6a20:3d8e:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-348cbda9bc9mr17950921637.34.1762195403776;
        Mon, 03 Nov 2025 10:43:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdThbEmXK0CuxBH1/c5R33FC/ss8+vn/2FSzn25CBYYPmQnSb4Y6drTofKNBCE33oGQcIuUQ==
X-Received: by 2002:a05:6a20:3d8e:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-348cbda9bc9mr17950873637.34.1762195403090;
        Mon, 03 Nov 2025 10:43:23 -0800 (PST)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9b8f2b5403sm4879826a12.17.2025.11.03.10.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 10:43:22 -0800 (PST)
Message-ID: <8083f0d8-6fe5-45df-b5d9-f8d4e04a5cbb@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 10:43:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] media: dt-bindings: Add CAMSS device for Kaanapali
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251030-add-support-for-camss-on-kaanapali-v5-0-f8e12bea3d02@oss.qualcomm.com>
 <20251030-add-support-for-camss-on-kaanapali-v5-2-f8e12bea3d02@oss.qualcomm.com>
 <631e4da1-92a0-4d44-b92e-bdcc56196c26@linaro.org>
 <e9da04ab-5119-4bfd-a25c-50e7b2ef05d3@oss.qualcomm.com>
 <20251102-charming-angelfish-of-experiment-eaa4bc@kuoka>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <20251102-charming-angelfish-of-experiment-eaa4bc@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rO6ADk6WZkKhmzI6Gmsp5AokZUe5jzYX
X-Proofpoint-GUID: rO6ADk6WZkKhmzI6Gmsp5AokZUe5jzYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NyBTYWx0ZWRfX6gZoDNDEweeB
 wo5u/N9up3Dx3oxkYPUOBAXZRrtqrvUFj+ENHJMO4Vsy48zb+3WVoC6+3clg1xDsEf8lYDdjZaf
 DHfWPoot4ZzGbQbfpg3xrGMmLKyci5znaWBJ9ja4JV+s39WqJRiCiPfRUhWJ3T0LWeT6STdmvgv
 roqaEm0UDpqV2gVm+zezWUq51YfYOmBnTiIEC+T7u3xM9iLhlF6pjFqF1tjnGl0mG+zlVv+bePf
 WIeJm+pL1EYjS84IwPj8NtW3koZzxzKCrmpWHjehU6n1Dl9SG10LtKj9h0BODQ+qo2N5BLMmcX+
 0DstExHr+fkd9ncjmKlUhed5ruBJIBKbmu3mHzZKmQHFjm+RdtI2qJ9nubWErNyb7egKFjiBkxU
 gpyGU3z0xuMaUkssrIfi6svebahYIw==
X-Authority-Analysis: v=2.4 cv=CeMFJbrl c=1 sm=1 tr=0 ts=6908f7cc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fy5AM4a-v69lRwORk0gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030167


On 11/2/2025 8:06 AM, Krzysztof Kozlowski wrote:
> On Fri, Oct 31, 2025 at 10:39:44AM -0700, Vijay Kumar Tumati wrote:
>> On 10/31/2025 6:50 AM, Bryan O'Donoghue wrote:
>>> On 31/10/2025 02:59, Hangxiang Ma wrote:
>>>> Add the compatible string "qcom,kaanapali-camss" to support the Camera
>>>> Subsystem (CAMSS) on the Qualcomm Kaanapali platform.
>>>>
>>>> The Kaanapali platform provides:
>>>> - 3 x VFE, 5 RDI per VFE
>>>> - 2 x VFE Lite, 4 RDI per VFE Lite
>>>> - 3 x CSID
>>>> - 2 x CSID Lite
>>>> - 6 x CSIPHY
>>>>
>>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/media/qcom,kaanapali-camss.yaml       | 406
>>>> +++++++++++++++++++++
>>>>    1 file changed, 406 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>> b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>> new file mode 100644
>>>> index 000000000000..c34867022fd1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>> @@ -0,0 +1,406 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-camss.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Kaanapali Camera Subsystem (CAMSS)
>>>> +
>>>> +maintainers:
>>>> +  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>> +
>>>> +description:
>>>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,kaanapali-camss
>>>> +
>>>> +  reg:
>>>> +    maxItems: 16
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: csid0
>>>> +      - const: csid1
>>>> +      - const: csid2
>>>> +      - const: csid_lite0
>>>> +      - const: csid_lite1
>>>> +      - const: csiphy0
>>>> +      - const: csiphy1
>>>> +      - const: csiphy2
>>>> +      - const: csiphy3
>>>> +      - const: csiphy4
>>>> +      - const: csiphy5
>>>> +      - const: vfe0
>>>> +      - const: vfe1
>>>> +      - const: vfe2
>>>> +      - const: vfe_lite0
>>>> +      - const: vfe_lite1
>>> No test pattern generator on this part ?
>>>
>>> We have patches in-flight to add TPG so it makes no sense to omit these
>>> registers from current or new submissions.
>>>
>>> https://lore.kernel.org/linux-media/20251017-camss_tpg-v5-1-cafe3ad42163@oss.qualcomm.com/
>>>
>>>
>>> While we're at it we should consider adding in the other key functional
>>> blocks.
>>>
>>> OFE, IPE etc, there's no harm in including the registers even if the
>>> intention and outcome is never switching that functionality on.
>>>
>> Hi Bryan, we have quite a few register spaces on Kaanapali or any other
>> target that are not required for the RDI only CAMSS driver, including ICP,
> Please read writing bindings doc. It answers this question exactly.
>
> I'm marking it as changes requested in DT patchwork.
>
> Best regards,
> Krzysztof
Sure, thank you Bryan, Krzysztof. Appreciate your inputs and patience. 
We will address this in the next revision.

