Return-Path: <linux-kernel+bounces-884771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D53C31147
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF28B4F8E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2020C461;
	Tue,  4 Nov 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1ajb7Lz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M2iOnrkE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41E2EC57D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260715; cv=none; b=UUYXCC6De4dAipyT88XrsRX5Ati+tqQLg0NkHgJofay2yv6jldAZSdRZ3H9jHkjTz/cRrZr7vg27k3HegSnUXaR+cdN5xvruIwH6vfFtU1UA/1M997yDRVSl4sNmsafubV9hPt14hUyhYSdf26HSz/PgxZ2uLmnXBtTTXw3f5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260715; c=relaxed/simple;
	bh=3GxJQierKYpfNjMAZtePaH/hGr/R23DzRiCAO2a8Wlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZ/L8x1jgQjwG7t3Gq6lcoM7fY465DN6k8eMoX4+5ofMlxjGaORPwUyW7YIuDBYV8z+g3gMbMY06JLDaM2ZZYZuP+si/dVvOo63M/jkDF4H2zblkZ/hEMAh7xf1tZTPGNcPvCsRAIXcES7Fic+xx7PhSPaihf7RoIFHlCfnZhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1ajb7Lz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M2iOnrkE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CgIvY2008110
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nGMcEo5N0s57f7TFRVnqDseGGUisgNaE71hwEncLIRY=; b=I1ajb7LzVcNvA2Cb
	UNR20zxCt9nk8RxZKs6m4YLUTJSyS/wzfd9E/47jDt6J8yjSjqy8+MA8Q4CG+hlS
	KyxK/SknUpMmefNvjOBrB74MFkZJNUeTxFKpLTnuhargptacmW3AIvPFD2NT40TK
	PdbByGBjPf5Ib+hEJ75zwzNRYrcmEYfv7FMExCAr6CsjWqh61Z41wfCTBKYCg+Xv
	bqGVgSlZ3ZdrMo7bi7qJ+9vq8EndXWBNlaztBmkV6Brm3vZn8jq+CWDMyRVC837q
	GxCInT1XSOeWkRkLHylu7kSahwVkXMx4ASevvJdbe8csWpnpqp0r+T0NruEV/6zk
	IFF7qA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jh1gf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eb86039d9aso15844681cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762260711; x=1762865511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGMcEo5N0s57f7TFRVnqDseGGUisgNaE71hwEncLIRY=;
        b=M2iOnrkEoNVIkrNqyonMOy+9yjxo2zHM4imrwXq9BN1fqu1n9+QvkRm+3XXe/7WhCZ
         VEWz0ljjsnAMVVXD01515Ze86AZIApFB7zuI3vJH+OGs0LtqdAOMmnHcWmUykLxwNM7w
         71hOuLEqdlAl9GRUsDAU2PGQr/qmyWDTZLT5u96OJWbcKQMcI9kKtIWr++6ggaMED0lA
         U7UikAcuc7Ol3I/YJ39hKl2UndQD+N4N6f+dV6XPqUEA+VAQI+W+gZ1zWqpXJ1xeGOPX
         9ZDWeLKnkSTV7rBqCrZI5d1vT5pwaE0kLS7jJHqdQT+sq2zbf6KgYdmw1iXuYmfoV4HL
         k3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260711; x=1762865511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGMcEo5N0s57f7TFRVnqDseGGUisgNaE71hwEncLIRY=;
        b=OWTTo011Ty0fxHik4Pr+1TfKOtLaBALYMYSg0PPtei4VgUoePacYWkIn3ekSSPWlg0
         2iFSQcMrI5YP4tkWL7OryutjEf+x/ZmTWrAlScbGt5Ccgx3o3t1XrGpbGLh2RuxmIJhw
         TS4s2hYKjc7uOA9uaNeA2Rc7ysYvWQELGgviogN2HU4ZLdL8hy40GOzTH2VIxINCQBZr
         ftKJtKKQv4QmkCGzs+iX0VDltfSBnnYMFDREOXvHu/aI1GdxByy+Ik4I2nOEAtr3eLAT
         QT94eeDgQG70sW+9tzAuF74io71fivgiVEu/QaZSKdQkpJIn+A2p8xEgmvIDJlhCLiLv
         HrAw==
X-Forwarded-Encrypted: i=1; AJvYcCXz/K9JY1RT3pvGplKkT4WjU0PezQ+l9JbHUX85Yhy7eYYcsZuWc536iD7ePYVsJClMVd1M2d4m50lTgsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvLb2/dgTz1bDq/S7MsSjr5SuXP1+MZFP5F2Wm897iwdZmTTM
	cacTwgGBZSVUFqzx2t5IiE6I4beuB5e0brHWl5qFHXCRbw3Xu9fa/9U3/SI5HaszIU5B3ELcjbu
	fa3IyQARg43fd7wxABuNdYdKx7pd2Sz0njUFzYtA4Yte42pNF9c3PoDJG4Jw93a4O7M0=
X-Gm-Gg: ASbGncuSUoLlBQ+bNoYJkLcURUlYRK24i1KxaGN/nz/wc6Aq+aw4VS89PvHmc7Ypzar
	2kCNuY07N1giVPx2+GSKxlDr2L0DDZbHqClPvGQj7t5DgnH253DENCS1RUacaegPzlXupsWojFm
	8+tqhgQOAtqMURDQoJQcosklh1BSrh9GdkWivyuHwBizScHc6FXVoCGL4bd/ymQ8pNLq0Ju2z8H
	4BQr8rYHR3eGY5aA91iRVvxrfXMVqy7DLLmNV5ZYRpw8eQq7eiZgHdtyqqjOBXWIx3zXf2H7Cr7
	Bd5FRBLi1HSc3/yR2EE7y1eYdmSvGLK99VxIUMZ3v+UAAgxD1Zw63HPoDTKz5QfI4xT/zP0DGkE
	U1Ubn4D3msmRz9Yz7yIgXnKfblA9ePLjq3+BJgiuIJsTSjLCF3x2klH7/
X-Received: by 2002:ac8:7dd6:0:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4ed6e12f871mr3017531cf.8.1762260710947;
        Tue, 04 Nov 2025 04:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU6St66hSeD14z+3rWOf4yGnqadyqQ8nRKgxFwlsUiVhjRLriVfJzPhJf5CQWAyyU+q101PA==
X-Received: by 2002:ac8:7dd6:0:b0:4ed:6e12:f576 with SMTP id d75a77b69052e-4ed6e12f871mr3017131cf.8.1762260710357;
        Tue, 04 Nov 2025 04:51:50 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26adsm205948866b.43.2025.11.04.04.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:51:49 -0800 (PST)
Message-ID: <19ee7cf6-8b92-4221-b450-75b3e3d66e8b@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:51:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Bjorn Andersson <andersson@kernel.org>,
        "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eugen Hristev <eugen.hristev@linaro.org>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
 <g2iviaqetgxf5ycz2otzkpmmc4goo7xuyjmttuu254bfzqqvkf@4vybjh4eghpm>
 <4eebcb7d-1eca-4914-915a-d42232233f9f@oss.qualcomm.com>
 <dwfvko3hszsoh4ihnz3qdpsugmocbkrbhosijdw5q3bxh64kuo@o74as2li74px>
 <lz4sbvzfiij3qsa4d7jeblmi2vfubc4ltf435sh6tcs53l6fbq@7f3tfm7yiyjc>
 <mwin3lfvpcwxxhsub2whcpibuayk36f4ljrodvithfygqad5w4@cg4h6peh4v4a>
 <ygqgzflpavwgd43e5zedgcijm3lz27nqlzprttalgcroedz45u@ztqkppajpyry>
 <a7cdd2b3-6097-4a8c-a639-af974292cc8b@oss.qualcomm.com>
 <x4rzktpij4ggnbvnuyoli65gugymli5acrmrlovglttpakaauw@o3vu23bjedul>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <x4rzktpij4ggnbvnuyoli65gugymli5acrmrlovglttpakaauw@o3vu23bjedul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwNyBTYWx0ZWRfX1DFv3hrlrN7e
 o42p8ifr74JzkQI5Oaf/pWBiZSBP72uq4KQcAfm70TnLJ08PQATYPxdsG69iWqofdkRLsE6thO6
 F3YGQB8JCp8w/cumE2b3oIb2fHX5On2+J1zrYkaYJMjWGV7Zth4FwLMvxOsZLeS+ZYXCx6CLYPc
 7/dkdlE1bLQzfxDonGZz1Vv6MUhVT0x/hR9mEJ+3nZ7E9a66Bi/k0G1EvnyhghNnbhBUFc6aZQ7
 Ns/6r7pexHL7RGlPmXDee/BmhTt1xGkSOZ4XqZe4EaFRw8HF9rvJztg+ynwrsBwQllbf/gs0+KD
 lbIylRlP7tf6xma+cewLAKH/rg0qBZydXJPsHGRQN9NqHg1lz86X1aVqYES1A3vAn5fLj+wmF8G
 KoZ4ytR1DK9kI/MDHEUATUZNcBfNrw==
X-Proofpoint-ORIG-GUID: 3_wX7UUZ9-p0kLK7GNZ6mWI62po7kvyV
X-Proofpoint-GUID: 3_wX7UUZ9-p0kLK7GNZ6mWI62po7kvyV
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=6909f6e8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=yiTxRK5lG8Kk4Q43fuEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040107

On 10/29/25 4:37 PM, Bjorn Andersson wrote:
> On Wed, Oct 29, 2025 at 07:47:11PM +0800, Aiqun(Maria) Yu wrote:
>> On 10/28/2025 2:44 AM, Bjorn Andersson wrote:
>>> On Thu, Oct 23, 2025 at 03:06:00AM +0300, Dmitry Baryshkov wrote:
>>>> On Wed, Oct 22, 2025 at 05:42:58PM -0500, Bjorn Andersson wrote:
>>>>> On Wed, Oct 22, 2025 at 12:34:58PM +0300, Dmitry Baryshkov wrote:
>>>>>> On Wed, Oct 22, 2025 at 05:05:30PM +0800, Jingyi Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/22/2025 4:49 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
>>>>>>>>> Document qcom,kaanapali-imem compatible.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
>>>>>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>>>>>> index 6a627c57ae2f..1e29a8ff287f 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>>>>>> @@ -19,6 +19,7 @@ properties:
>>>>>>>>>        - enum:
>>>>>>>>>            - qcom,apq8064-imem
>>>>>>>>>            - qcom,ipq5424-imem
>>>>>>>>> +          - qcom,kaanapali-imem
>>>>>>>>
>>>>>>>> Can you use mmio-sram instead?
>>>>>>>>
>>>>>>>
>>>>>>> Here is the node: 
>>>>>>>
>>>>>>> 		sram@14680000 {
>>>>>>> 			compatible = "qcom,kaanapali-imem", "syscon", "simple-mfd";
>>>>>>> 			reg = <0x0 0x14680000 0x0 0x1000>;
>>>>>>> 			ranges = <0 0 0x14680000 0x1000>;
>>>>>>>
>>>>>>> 			#address-cells = <1>;
>>>>>>> 			#size-cells = <1>;
>>>>>>>
>>>>>>> 			pil-reloc@94c {
>>>>>>> 				compatible = "qcom,pil-reloc-info";
>>>>>>> 				reg = <0x94c 0xc8>;
>>>>>>> 			};
>>>>>>> 		};
>>>>>>>
>>>>>>> other qualcomm are also using imem, could you please give more details on why
>>>>>>> we should use mmio-sram here?
>>>>>>
>>>>>> https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/
>>>>>>
>>>>>
>>>>> I considered exactly this when I wrote the binding back then...
>>>>>
>>>>> But the binding defines mmio-sram as "Simple IO memory regions to be
>>>>> managed by the genalloc API." and the Linux sram driver follows that and
>>>>> registers a gen_pool across the sram memory region.
>>>>>
>>>>> I believe IMEM is SRAM (it's at least not registers), but its memory
>>>>> layout is fixed, so it's not a pool in any form.
>>>>>
>>>>>
>>>>> What Krzysztof says makes sense, but rather than just throwing a yak at
>>>>> Jingyi, it would be nice if you provided some guidance on how you would
>>>>> like to see this turn out.
>>>>
>>>> I tested, pretty same approach seems to work:
>>>>
>>>
>>> Now you're shaving at random ;)
>>>
>>>> 	sram@14680000 {
>>>> 		compatible = "mmio-sram";
>>>
>>> You can put "pil-reloc-sram" wherever, because it will perform a
>>> of_find_compatible_node() to dig up some node with the compatible
>>> "qcom,pil-reloc-info" .
>>>
>>> In other words, this line created a genpool for something that really
>>> isn't a genpool, but luckily that didn't have any side effects.
>>>
>>>
>>> There are however other users of IMEM, such as the "reboot-mode", which
>>> relies on the "sram" device probing child devices, and is implemented by
>>> "syscon-reboot-mode".
>>>
>>> Perhaps the solution is to not support any new users of that?
>>>
>>>
>>> But no matter what, the definition "Simple IO memory regions to be
>>> managed by the genalloc API" will never be true for IMEM.
>>>
>>> And as this isn't a syscon, simple-mfd, or mmio-sram...how about making
>>> the fallback "qcom,imem" (in this same binding) and omitting any
>>> implementation until we need one)?
>>
>>
>> Totally agree. We can remove the "syscon" and "simple-mfd" compatibles
>> for Kaanapali.
>> For Kaanapali, the reboot reason does not rely on imem at all—it uses
>> nvmem cells instead.
>> Previously, the syscon-reboot-mode required "syscon" and "simple-mfd"
>> compatibles for older targets like APQ8064, which used imem as the
>> reboot mode solution.
>>
> 
> And there's
> https://lore.kernel.org/lkml/20250527-topic-ipa_imem-v2-0-6d1aad91b841@oss.qualcomm.com/
> which Konrad pointed out, which would also work with this model
> (qcom,imem fallback but no implementation).

Hm sorry I skipped this thread and started repeating similar points
in v3.

Ultimately I don't really care either way (mmio-sram vs generic node
acted upon by different drivers), but I do care about closing this
discussion..

Konrad

