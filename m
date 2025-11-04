Return-Path: <linux-kernel+bounces-884750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFBC30FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BACD4E45C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252582E5438;
	Tue,  4 Nov 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sv3SlHj6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZblhvTPA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015E1CD15
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259528; cv=none; b=IseQWQ2MHzTXNM5Zz+veWo8XYCj6B37MHoR0+y/xbmal+1H86vhqiG1Hsm+D2XRLcCfxrEsbWLDlzxpaCr/4J/ok9Ou0BlDUUJLCpJzDJBQ4Q9TYtDR9l0hWOBmEWieBm13cgqB/ml0PMJKh+xdsyPqHoRDJQrqhkc7oFEP3y2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259528; c=relaxed/simple;
	bh=iqu/Ya2dwS9ONJUXHsu1yCgirOeUVkBUk9APrAHQLD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqpQgoVv+/6IMT/9HSSgzAjhwM6YtrTXsABAH5/eCPzfwZa+eCDkyk4Ffp/aSva684KBl7BxFByqftHnu0TSsbGvT7pBRVyP16LPQ16NPWxFvNltGdLadiYyD1ZDv8k1B+jbGpQTQ43jXs00Uu4W+t/bwXOjHUs8hkiNC8pJUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sv3SlHj6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZblhvTPA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CMKgO1935218
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LyszaJhakD561ZLBW57AsNnvbXTrFvY/B4WU2SNmYTo=; b=Sv3SlHj6gEach04s
	jN+XZyRC5yWUQFhTX0Vq6YR1+YYwZJJDfYRmRoYzmv+7V0jG4xHViOy364FUuss1
	RZ0tuni2FschXt+5InLD1fJ1VioAH6mK9Z8M8EED557KMggzBkh3Z8D6Wy/M4nIT
	8P10E1ZsgkFLjA++8y3wOs/TOREw6liytR3vh4pxDZ+Zxks+h9zaGahhSsRu8XhJ
	6nXAa29j0gVMFeupUvVv3Q44lnxFykK1Ji6qWFwkESab3LrLkNplf6RZcO0Sk9d3
	sKb8YB9x1O/vAF/15yHBzqZsnhMVlUiVzYeSfmLgu29O7rMOJyKc8evOxm85jdP7
	7pX2+Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heag0r4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:32:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf8fad13dso9517961cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762259525; x=1762864325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyszaJhakD561ZLBW57AsNnvbXTrFvY/B4WU2SNmYTo=;
        b=ZblhvTPAdi7aioM8HS+JxJxPELEMmr2tRjw2dWi+JWQKZIkcnX+cxwfT9mxXszQo6c
         iwJENit0TThr0psFc0DenmIPNhswn5Y3N4X2B/EqQFEe7ecEFd+pGwoHQbhflze8n+CK
         AvlKnlqkjKM2w8ZYVr2b9LtOcL1GXLRQWyNpmvRAScxyrJKc0+D0YFcJEFbD4Fv3hwhC
         QC3D9jj656KM0wSB6o2qITUJXoXAQGsietG9s5v+vC+jnKKmRpK1e/dVC4wy0AvnLF6K
         SZ0ZcqMFJBgDLWZE3YzMOA5gArdfqeB6NS9/Lns1re/izbNM4hVkFWfyUjmTQrbBXkeG
         59Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259525; x=1762864325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyszaJhakD561ZLBW57AsNnvbXTrFvY/B4WU2SNmYTo=;
        b=aLdDJR/71GsA37rCWM1WkCP1G1jSWd84+j7OFAoFZwN9gRy2o8D/zuwR0OxM3b3XwP
         pGckXokqsYEbI+LdCQYM8TpqKarayO4dV3JUkt9t6gULV0RakHBdhfWL+t3lD0wOk5Im
         VGbNC9OgRXvxGeQZU5avT+HHgxJgCaJgSOER79XeU7NUMWD3gEg8j63vEgwXfw8ZMHMT
         NByW7BzxqC58LtVKK6UGwhGDwiudB1NsE/IyhriPm5IfegG0JlpZCxy99eI1aeqL867w
         jol1cDo9m0TZKQCCTaUAWAnENv1aRAJK+DEMUTEMCKENKav0s+l590pj73er0cpvCDIH
         2zXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1+o/CnI0O0CrEXLPy1cn7+zKNvwQaeoD6iU9YhIsiFrqDEq7hgBRlk9wOBJLFkFSfuyyRPeOpCTSsJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJUIbDGGjJslFfFwyxpJ6P252lWGwFXmyVGVUwBWrLeVVOIYy
	wV1PU2Vo2lVu637mZha2dG4qP/x+0mHYb+2PXqP4hTkToIuxI+GraGD6qI90Fi9Wg7mjJRTb4Wu
	O3suF9uB1pewCRS4Q6eR/bPhQBjU5oMi44ZlGe2eahKxKsexDcGMLbiP2VbHnJbsi164=
X-Gm-Gg: ASbGncsbSF2jdVay7/83GIXDa4mT36dQFPrceRkq+Nk4wxgFzpo1R0Zzqetwv/EI8om
	HQcKIGDcdCbG03FGQiq0CCW2zW+DC8rr9UOLd61w/sM3yXt65I6dRu8OXLr/zPbovBJvn75cLqB
	CZasW34W3lZnCtq3Do9JoAbh1lWrkR91jfAy5DkLqeW0RTSDF7Mzo3VmQ6r1egsX82+iTe9/Fg2
	W2ntAH/yVbJgaj9J/2finnXIVmwBzHMm9RKNje7QNm0EenkPfUYaFMgenbnh/olXPZXjf5vpU6/
	ZA74YF4mLxUSY5ZLw8WzPrpy7uYHfIZWFjBj/IFd51uWujZJjRe2Y8BTJ4r/myygn7ABQBf1w9j
	Dl23XQQt/qWu5a6AujzQtxuLyR40/kaXd/foLoGvJavQw+rK0PRXRxYzY
X-Received: by 2002:a05:622a:409:b0:4ec:f075:50cb with SMTP id d75a77b69052e-4ed30d4641dmr129558361cf.2.1762259524690;
        Tue, 04 Nov 2025 04:32:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG51Vci1fQYtyUF8ZqRWbO8+HNZTvYQqZoIMz008jdi7wzWhQWr6jzzFAkQFLU+efsFn3wONg==
X-Received: by 2002:a05:622a:409:b0:4ec:f075:50cb with SMTP id d75a77b69052e-4ed30d4641dmr129558031cf.2.1762259524230;
        Tue, 04 Nov 2025 04:32:04 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72406568a2sm200000566b.73.2025.11.04.04.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:32:03 -0800 (PST)
Message-ID: <790ca394-cee2-412b-97d8-c6416b843010@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:32:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102-knp-soc-binding-v3-0-11255ec4a535@oss.qualcomm.com>
 <20251102-knp-soc-binding-v3-1-11255ec4a535@oss.qualcomm.com>
 <20251104-glaring-rebel-pillbug-a467ca@kuoka>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-glaring-rebel-pillbug-a467ca@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=6909f245 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=df4OXsTxo-j3LUg4bp0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwMyBTYWx0ZWRfX1apwdOvwlc7z
 lRW7ake8U2eJ7OqrLeYzipQTR8K/U210Cw25qWgdojPhEW/Uq7Oax6Qg8H9VsnF1uSb7r66Mf8E
 y808shc92mVQySfTDzNGO4WDQgCPlMGsacU4LyAzSfRcXKNGntD48I/B9mlISL4EjF0dTvHY2W4
 UIAp3JMugk9qi5yDt+A1JdUA/xKJ2pIfPs28NEuB0JO0hhmHLJgRKXMuVaZYsMgA0D3w21ARZzl
 zwr40C1Tdkg2oMW8LPLObHf2Oojf1GINaQF/SW3nZNmZPMqhzyJqjI8h+g7gfE52GDEOte26SwT
 s33bpJ28/SGq40FSyjutl/BG33G04J6gJrlxkAs0w2FVS3nd6xCHvtl7eIUirDP/emjqgK8dZ57
 1TERw9IKNn2ICa4qR6BrfPXMR/tzqg==
X-Proofpoint-GUID: ANq0ghtBshuHarKQFNuHRc5Q8NNnSfhV
X-Proofpoint-ORIG-GUID: ANq0ghtBshuHarKQFNuHRc5Q8NNnSfhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040103

On 11/4/25 9:16 AM, Krzysztof Kozlowski wrote:
> On Sun, Nov 02, 2025 at 11:25:06PM -0800, Jingyi Wang wrote:
>> Document qcom,kaanapali-imem compatible. Kaanapali IMEM is not a syscon or
>> simple-mfd, also "reboot reason" is not required on Kaanapali like some
> 
> I do not see correlation. Something is not a syscon, so you add a new
> generic compatible? No.
> 
>> other platforms. So define a common "qcom,imem" binding and fallback to it.
> 
> You did not define fallback to it!
> 
> ...
> 
>> +      - items:
>> +          - enum:
>> +              - qcom,kaanapali-imem
>> +          - const: qcom,imem
> 
> I do not understand what this generic compatible is supposed to express,
> not explained in commit msg. Considering this wasn't before, it is a
> major and really undesired change. It also makes no sesne. There was no
> generic compatible before but "if not syscon" now this must have generic
> compatible, what?

So IMEM (or SYSTEM_IMEM more specifically as opposed to BOOT_IMEM which
you can take your guesses what it's used for) is to the best of our
understanding just a piece of SRAM that's accessible by multiple
processors/subsystems on the SoC.

A smaller region within it ("shared IMEM") is a little bit of a dumping
ground for various (incl. runtime) configuration and debug magic data
and that's usually what Linux is concerned with.

IMEM is currently described as a simple-mfd+syscon, which it is clearly
not. The former, as we've established in the past, was used as a hack to
have something call of_platform_populate().

I think that in turn is only necessary for the old arm32 DTs which have
a syscon-reboot-mode node under IMEM (and I think that's where the syscon
compatible comes from).

Should we make the switch to mmio-sram and settle this discussion?
It would probably require convincing the sram maintainer to add that
of_platform_populate() call in its probe func and making syscon-reboot
not depend on a syscon (not like it's very hard)

Konrad

