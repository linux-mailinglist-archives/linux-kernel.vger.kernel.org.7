Return-Path: <linux-kernel+bounces-807542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A8B4A5E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761C21C2455E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCBE27586C;
	Tue,  9 Sep 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8Sd18PT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA05274FC4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407684; cv=none; b=HVz8smEA8lbtzcAdAGFXsuOckfgs3qc5wx8kzMxjZlEuIAjH14u6TMAwZZ5M0/BX0qao63rdbh91DKkgxq2/CeAxZQ+bxe5NalQ7Jo0MhOcNBUaMBVHc9U3swIE0VBiNxqn07nqSKS8wOCynwTv0da+PFFN9VrnEspFzBFUv6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407684; c=relaxed/simple;
	bh=UAxLOwoumkc+BYNbc7dD5zqL0NY/zwNwOjcx25wNFMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iytdlCh3/BDTtj+XQpv3vp8PaHVSPJ+Fo9sGuo4zEzw5xO3epHuJqJ+NnFRyGq8NZqPIGxlXPRXlBvvZQrXQ21XaA0Fy1VaMnYhxQgipPy/EVc5xJiOYUz0l4QZpCsMlaKj9o6cCmdbM00aI8028fMa6F3kahJwsBo40ufNjn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8Sd18PT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896T1UX021513
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KZymnpnmhs5B0YBDAMI52uZ/Inhmlk88lRXrLORVF+c=; b=L8Sd18PT9GCr920+
	ktTKgAKJQX5h6vBy+sqlOJNBCDze1sMH2MMPgRohQ+PbHRjhYHQiqI6WaKX1OVg5
	ov98vj2OxCFx9qeAMpFZfXr1I/lb3XqswZevZFG5/Oyf2lETMkP4lrisRPrywnz9
	N65bYaQFOkA+c7/KwB6NkHXt9iVDIjGaitmTLQw8qbwT3mfvxTuLQTHsaS3HWgOm
	HXmiSz7ZH2Gxef3Npo13I7+Bsr/FyZSBm89kUM+W6kQ+TCnJCP3yWRE/fHb0GN+B
	XayvryN7ECaB19spRXGKWF4NbYALDOED+W1rC4iFhOtxI58kyOy8bmLyxtNhqU0X
	Y2iP8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8ymps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:48:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24cc57791caso14319285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407680; x=1758012480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZymnpnmhs5B0YBDAMI52uZ/Inhmlk88lRXrLORVF+c=;
        b=pZGQichzCuVXqq5qGrtHKBIcU4gc/2xAzCk/1u3XHlYRR2RUs4/xGwhSUd9pTWlCU5
         pmPqDn9DtH0VnEohpkaaB5AEAk4WlFnKtauclke+M9EsIC+cCZQZYhOoxcYX33gcg3Ig
         0fyty6ULd4noXremX3s5ZJmm1+x2KhZu6v7UShwAD+gGzt7P8nEcc49b1xxv5qWNju6w
         E1Ni0jAk4/iKUnk3LUm++UqO0WfQ6KvTlFvNfGrzpMnSu67vLcYxJjvThRRtnonH4MIa
         xTY6XNQgwT20o2M0kdxOw5p7gW3b+Vxmn7et8nRg3bnuExeBGpTZ+xNVoN+NC/7JKAyO
         l4JA==
X-Forwarded-Encrypted: i=1; AJvYcCWF/3TgSHiAYuWGz9FITKRpjbfQOcgUSwP/KBZ758zyVDvUQyjqM0p0jU+5NP/rZeh6bjkCTJTRE1CyVy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/Gdfz2yTt10rxyEPhlEwGYqyxU0o7/t9Yw4epUABuYim8DPU
	+9wrr5xjyBuqF7UokvWYSBPru/4GU09DYiM1JJZVOGB7hanNiMtLRbr9hp0dHCXYDTkpjd+VbGH
	deLRLKBWKqtx8uz5DaG828PHeZan9McRrhzUD+EAMCw2DEEbIDbaVRVRYgF+MJgttA5g=
X-Gm-Gg: ASbGncuVgKahlY7RYt9tHVwT/n3o99Am/pYl7ar84aEY7JV0p4cap/U0zGHUxuSG8sU
	Bjv+NaFyyyIb+4PLnF7VOB4LJsxAl4fTYiaTlJqmLx13n0IzcZxg2oshIoxYx62GWtICuoKmz+J
	/qYiYwQxtXlRFEcJJ5iTLx8yEOdPAGLplS4+QypZvO7twNPXcg8EnJupzMymxz/iUi0mFo8EZvm
	D34emoDIa6zElRzArL7q/G2c4H+9zbch574PQQFRuccriHVuh+HIRuJC3lS295dXFvpBoxKE9a8
	Q6ygRhSjCyjomp3TGkIypZIsE17QaI/hNdEBles1fxdM9AowNVVuu0bXzAYBHvxDs6KbuPDVmS8
	lxoAATcmfKn2+6MgZTbjtbTKwFbmDLA==
X-Received: by 2002:a17:902:db04:b0:24c:b39f:bac2 with SMTP id d9443c01a7336-2516ec71a55mr86020395ad.1.1757407680137;
        Tue, 09 Sep 2025 01:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGcPEO4ewq8vPdRBMjUnVoQbZofkFK2H8oWkKbHPow7Vq7zP3XFvEVLEjwbhoyUbsAwksJ8g==
X-Received: by 2002:a17:902:db04:b0:24c:b39f:bac2 with SMTP id d9443c01a7336-2516ec71a55mr86020095ad.1.1757407679630;
        Tue, 09 Sep 2025 01:47:59 -0700 (PDT)
Received: from [10.133.33.137] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm206214375ad.138.2025.09.09.01.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:47:59 -0700 (PDT)
Message-ID: <48a76d34-b748-43e6-8a2c-bebc8095478d@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 16:47:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
 <xurpc3mk5kksx7lfpsdqgasov5gc4dpsmz6iv2hjhsp5tewbue@dvrupbjzgxle>
 <c4eeb8a8-2819-4ac5-8dc1-cce209d7cbc4@oss.qualcomm.com>
 <3zi57uvggw3zgrj4bfouzjnf56yywjnw46f5ru7krihyrw5bkc@c3xf73ianksa>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <3zi57uvggw3zgrj4bfouzjnf56yywjnw46f5ru7krihyrw5bkc@c3xf73ianksa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bfe9c1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0xAmN0HNA53ciqJMUUUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: vziaYaEDUoPLdTxvNuobOeudEy3lM9OZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX4siQQyOrY/+j
 /58otJit6/gKMyGj3acHNiwjsv5FCTxTw4DA9k1W4WINTrYDmxNhu2qjioKH/3J5gFPu5kuVmj0
 OK8r4YA4wZUk7SpPPeMZhq2SL6Bh5QgXbSLi0PVJCrjH/7VCC/+W81Qi3DPDJDVYIiVT+hs9Vdy
 +NI3hpRJFK6FqwrWEcFCdJyWATWsc9PLDysnbZlNZyduk9qyUHLgdc3iNxTIZGXAUh63x/cIMdN
 hdGqylH6EZypFKqrwG7MQKOoS2ifWKzvoJhbrAx5JMSY6HLdAxx9eKu2koe0fI3LHrxsHU4zhQC
 g7Lw5n95ZigHX4T0uJ7L3m+f1tco0sUVwstpwWBLSLRDjlcLxhm2Z7i/hXccQV8PYhcwpJii5yw
 fJVX1P7j
X-Proofpoint-ORIG-GUID: vziaYaEDUoPLdTxvNuobOeudEy3lM9OZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018


On 9/9/2025 4:45 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 09, 2025 at 04:39:26PM +0800, Xiangxu Yin wrote:
>> On 9/4/2025 8:34 AM, Dmitry Baryshkov wrote:
>>> On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
>>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>>>> While SM6150 currently shares the same configuration as SC7180,
>>>> its hardware capabilities differ. Explicitly listing it ensures clarity
>>>> and avoids potential issues if SC7180 support evolves in the future.
>>>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> @@ -27,6 +27,7 @@ properties:
>>>>            - qcom,sc8280xp-dp
>>>>            - qcom,sc8280xp-edp
>>>>            - qcom,sdm845-dp
>>>> +          - qcom,sm6150-dp
>>> The DP MST bindings were A-b'ed and R-b'ed by Rob, so I picked them up
>>> into msm-next-lumag. Please rebase your patchset on top of it and
>>> resend. At this point I'm interested in DP bindings and DP driver
>>> patches, the PHY part can come up separately.
>>>
>>> As for the compatibilities, I think DP on SM6150 should be compatible
>>> with either DP on SDM845 or DP on SM8350. Please choose one which suits
>>> better.
>>
>> Sure, I’ll split out the DP binding and controller compatible parts into a 
>> separate patch series.
>>
>> SDM845 seems not support wide_bus, while SM8350 looks closer to SM6150.
>> But I noticed SM8350 is still configured as SC7180 under dp_display in
>> msm-next-lumag’s top, so this change will mainly about the binding, right?
> Yes, it's only about the bindings for now. The driver support for DP MST
> is still WIP.


Ok, understood. 

Will update next patch.


>>
>>>>            - qcom,sm8350-dp
>>>>            - qcom,sm8650-dp
>>>>        - items:
>>>>
>>>> -- 
>>>> 2.34.1
>>>>

