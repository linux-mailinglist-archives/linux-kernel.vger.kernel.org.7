Return-Path: <linux-kernel+bounces-892875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD3C46055
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808F23A41D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4513064A0;
	Mon, 10 Nov 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/MhN+5F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceG2CcIf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AF288C22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771390; cv=none; b=TAmitqADsIn1veDSTm3t3/aoB4+7CErqWiQr6NkkxY8Xqnsjy+FSCSImUrQUMg6nMQ2bu0jQnsYsMGleNfBLHg8qkcfdl/nzw82AmYNrYeCwFctilsb3qW0NCKZIBSy57I13iwjmnrAUjn0dh6kvfrtrqnMx/faxiQwJivL5Xyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771390; c=relaxed/simple;
	bh=l/d4o3X8P1bYWlrd8hxgMx9JxIkugvcZh3aQV+PLkjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOWSCz2NAbHneGxMUt8sNyp94pAXP6T06qmM09RsBQ3uRTNSMnxX/qmhVshxOZo36kW6chYTN+E1m42psEUoksQBC4J3ihOBEa2Ml4Afxv/xzytoTPG9cK2dkHtTHj0Anr2r5Sy/Bi0PjL5UFWlH51dndhgfT9qJ2ACR1BXTJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/MhN+5F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceG2CcIf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9EhBE2992285
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eSqXKqt4w5CGKMXelCEmeHZsf36l7BOGUQpou8ggYx8=; b=D/MhN+5FBDmQwyrk
	yi8sgc/Z54izzyQvKikz3VpJaZAEosoUWlESfrTOsSbpkE7HwWTuuQpmgusrDQdY
	vbqd+7oqP9K97GOyzT3kEazUqnyODoaRT9E72MJDwkFGwZ2zin+TQ9qwcjDrkHPV
	ibm/DiITFTiA+r8bzgysLVaG5o2vtuUyvRMjlhtHXg7MdK2B9QtgOULdaSBwbJMe
	9Oym9tBjAuT4P5MAaq2v+uCtSSmDShgROhL4wpz7zmoqqp2dqr7ND7DOQDkFLR96
	44iX0YOEn3lAkp9LBanGb3QQeUP/80rAHKpjM8pyhpldsDaH2q4eCRBwXuQ2qdM0
	kfm+Tg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88r8vk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:43:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297b35951b7so51023015ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762771386; x=1763376186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSqXKqt4w5CGKMXelCEmeHZsf36l7BOGUQpou8ggYx8=;
        b=ceG2CcIf8uvQQcPAEKfdGoDhgIdALZL2S0OwocMRt3k0FZuSjjdPhlWq8GhhH9LcV6
         lVco9yNe4WIuKzDWbghF00pd9dE/QpibRB4v9L/IYPfBR8CA/NsrKg9pifcen4Rn3wsi
         6KBSbj0DapgQ6hyVjnpYfKqkfAbkcuWn3Y47qkxlBskD8LUCeIg5SjtC+Vgpnw8fgB7f
         e+yjGSqOLn0vgKxEupJXi0YRZcYv1RI5RLEBikYGzRSa4ohuwUaYGPaRnYT2Pi/tFou1
         sljOd/goIfqJPzwc/UXRJ4Gn9CW57e5dg5+jrP8RBQoTGyLqPYvEaDmU0EHqjXM822/C
         JolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771386; x=1763376186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSqXKqt4w5CGKMXelCEmeHZsf36l7BOGUQpou8ggYx8=;
        b=HY1ly9mGjjQ5ds/I7i7GD6Z0gusw7FH9McrTBwnz2AuNG7vRxiEWbVhuwfII9z7dCv
         OrRvLHQgQaMP+kqw7fje5gsyzFn6YEWHqRb3nuXnrUOLQrrth6uAsd7R7InJbyIIkV5J
         STp06+xmk35SQuFrwoUV+nkiAVntQyCM3nPbZFqlZwj3blnydzfhff8/NEz2AN0RBy9r
         oWDYCnywwA66hvuP3rjKHhGcdvqRfKQKXd1CWT69wHI1rHeRRu5p4CenzwW30m5lKelO
         0HksESu13AT1LLy43LSrG65xKVIrdFiHW8pmSWGzM00wAA9uqxVCRoG5GGvQ9xEjTheZ
         MLwA==
X-Forwarded-Encrypted: i=1; AJvYcCUHe7EuCyrL9GvIQY4vjlOU9rY3++63amGUGPjDH7io+GVOJ2DSKwYW5Ez+yoGXtsPCW1WWlN+golyikIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1KlPndMJRXLD20wWUAig5TKzmxlHzCUnbjZ4gLbrCjPRW3Yy
	+fjtgy9e5ap24jFvhxHaeZD2ZftfuuO/O+k5OSO3L+KSkRWsPS00eqr1BmXyieqO+VkmGQMLqAS
	/CnW3zZsFA+XveeaxdBv1rUWzZKYZICHf4whecFyIUUSI3sDJStEZEV3KgHlbPtX/4l8=
X-Gm-Gg: ASbGncsbB2PYU9MLIDQ+qSBjIuCr4sZEOsSDSwfC2D3rfKKzQGsSrDRntRusUJotAO9
	sCWysldvxxX3cLTBuSg5WLxMv88aANuToalrc8lcla7Rpmx4FIwlb7qfym+Br5VN3TMc8aivRoj
	Sisf21aCQ5U8IG8dZSKAuD8kmPQurncCmSxZgG8rx1jDO+Mg+yYMHEQH9QbAjnmi/JoLcbF4qNY
	k/1SymnhSnf/6NVcGMuTkS5iRftwD8wa7FTSfT1KBJ5X3CCuSQ2k8Zhae+FMMOdKELMuAk+YjIf
	t6XKGN/ELlJ5ogn9eDfzbwsvbZvjMYLbt7A8SJ8o+SXsxnQuYCB0WinCCG7B3WGchR6U7VZDCWa
	o0fxlJogFZrcxtaUITufwEg==
X-Received: by 2002:a17:902:f790:b0:295:9a46:a1d0 with SMTP id d9443c01a7336-297e56df960mr102724455ad.45.1762771385981;
        Mon, 10 Nov 2025 02:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF/4A52+hPm+KGskAyqtu2lioNjT9Bv0FG/S2i/1sn1bpC5Zjl0LIeTPyJfY/iBBpamPtPaQ==
X-Received: by 2002:a17:902:f790:b0:295:9a46:a1d0 with SMTP id d9443c01a7336-297e56df960mr102723845ad.45.1762771385447;
        Mon, 10 Nov 2025 02:43:05 -0800 (PST)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297ddde1e7esm82040835ad.77.2025.11.10.02.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 02:43:05 -0800 (PST)
Message-ID: <1d31c371-0b74-4584-9f2b-dafa76197492@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 16:12:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sm6150: Add gpu and rgmu nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
 <20251107-qcs615-spin-2-v2-5-a2d7c4fbf6e6@oss.qualcomm.com>
 <defc450a-1699-4682-a41e-59035bafccbe@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <defc450a-1699-4682-a41e-59035bafccbe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0_2z1mBeu6Vg9RsVublOyNr4a1nP6C2h
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911c1ba cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=I_p1zpMzltXwdS2KmfMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MyBTYWx0ZWRfXxEVvuODdCDvF
 n1/hHFEGiUp/5qKeSDNq79rmqLZ/gcT8E2E+EhrVC5Tr42ukjwpKMYD5ma80DZWtB1jI4q8pcoP
 KUeoMV4dD8Ckk1qVM4tPrXdmcLaLXMfH3OFfcRM7vn5rQLSNVVjBE0aWQKoadpUPkkR9YolKLdB
 pINs84fhmsprIKI9e84bXrx++3zIKeu1EsOuA7EN85oEZNV4aO7/LZBHAdDmPTVOHM322x2CbIt
 yANsHWKNq+r4OB2MRFBqZVD2Oa6TAtJOIFg1ebjCph0BGfpc7ETnDY9sEf3Pz3fJK6atE8DfSSX
 m+QPTEkWyGN2ynq6rFVatXtp08RhyDrhpQvKAy8VAH/ynHMmXcYx6g0vb1YTRE5wSOB+isxWdMt
 U7/VoNTqTO0okbBFZYh2rGYQBavm5Q==
X-Proofpoint-ORIG-GUID: 0_2z1mBeu6Vg9RsVublOyNr4a1nP6C2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100093

On 11/7/2025 2:31 PM, Konrad Dybcio wrote:
> On 11/6/25 9:50 PM, Akhil P Oommen wrote:
>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>
>> Add gpu and rgmu nodes for qcs615 chipset.
>>
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		rgmu: rgmu@506a000 {
>> +			compatible = "qcom,adreno-rgmu-612.0", "qcom,adreno-rgmu";
>> +			reg = <0x0 0x0506a000 0x0 0x34000>;
>> +			reg-names = "gmu";
>> +
>> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
>> +				 <&gpucc GPU_CC_CXO_CLK>,
>> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
>> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
> 
> Is this last clock really necessary?

Downstream votes for this. So we are aligning with that.

-Akhil

> 
> Konrad
> 



