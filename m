Return-Path: <linux-kernel+bounces-875669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD39C19913
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A082500902
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE52D63F6;
	Wed, 29 Oct 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6elBAIv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7rCmTOw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DF224B1E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732064; cv=none; b=gDFgxKUx3oqSZfqIdfSQ2Yx4/OypZUVDT1OD/UP92H6hU1Q1pZyAdvdytckOBWlA6mOk+geylX3bYy2diOIjZNLJ3v/SJhPpTgV/jkObxZVJNB9UsgK62Ygu8e+xBcC9m0Tp8mP1yGi28UJm4vzmH/ifbeXx/M45kXuM3RPKFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732064; c=relaxed/simple;
	bh=q1a+cRy8t1d4Idu23Ds5LKgiMgaTqXhVpL8M3QMBjw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Unz5gUwtQ/mcXUCh5BeHDH5K6b4KjSrzFVfsZ/1fog0m4CAAe2cFnevORJ2LP6RZO4MvZ1/7jO5TReR2hYw5gwmqxFC2IWrTnCAErLpHhyB6nv80vC3tnN2ticT8i3RiEHDh+armZppBarYezxVcdwurahGkQmiEwbZSKcEpZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6elBAIv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7rCmTOw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4utgG3692119
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TePNPalHMwIQZy41qp0xadoCq64yzmdgEKfirFQHl+Y=; b=A6elBAIv2QDswVvs
	0YUo+0l2ZqvSTWozu2jqV/6/G1H0Pxu7JARdj3e/pAKG293HNhnznz471P+783M+
	yD9LJynxYXixNkKayWj4NPP+UD5nis/AWSbXRrEfCmu/ezIR72Fqn/UJUNlOJosI
	rlf9g48bTLJ5B8Q3nJAViOb9AqLbXrxNQ3qmQRM1lVJRRFdLdZdT6wyVdgAAoI7N
	1YGXbikG0dI8+CB/pgAS1Pec757jlj2xE0K7E9t/opec22VELUjxMlpwFujwlOCm
	pK2kjQ4Z4T9HUpjlb/MywwwQsQpx8sRLuOPe0c3GFzX5j/qjW5Y/yn/9fRBNwbRP
	6sG9Ng==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2j3gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:01:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso5463094a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761732061; x=1762336861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TePNPalHMwIQZy41qp0xadoCq64yzmdgEKfirFQHl+Y=;
        b=C7rCmTOwCE84tPWIPiJzx3YKGMLRYRRkvSCpjoZFk/leVmh3IuRld4uGZVip1OzPpd
         GS0xIXtdZYfPi4loovVhpfg6WG+RMmoK/+S7kUHbcjH1JynzgioKIQhU2PlT2dha9C0f
         nxYPEmlj13pYI57zXGKnL+RzPXxwb6k2z3oRJ3dy8iLuIvTcWbmnwOS9NuPXxjaz3uYE
         9h6B+r9E5oJmPmYf1VK4+RR7PlPGFPJJvtOlthg7UQwzidCYnsYSD8OXKgA69R97KtOp
         vzXH66Q/tfk+1px88Ecqs/PLM6oNwa+TcN/FrXQGeBMoTdnXWwMvssyAlNRzDMPEqqPR
         JKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732061; x=1762336861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TePNPalHMwIQZy41qp0xadoCq64yzmdgEKfirFQHl+Y=;
        b=o/54M4Z2ztbb8zryuJ1baubbw5eYT1YG1e8Hhavv9lmAy07nIedLpnx514hqjBdiJd
         StEa/8YQ0S9UIFUHCsiBtj5SbMkMR4yIZHNcaHd40H0vgKryKJwK+YBDma1BpaVjZT2x
         eRGmtvlDRr9zAqybqJzikDAunFN/m8JdU0UIPN4aY7/4AsvTgX2T1h5AnyCSpqIuTDgH
         PNX3p9vcUdKjdleU6b/A5B7McrUx2SDHwdG0CNTcnr83R5RMHJ+OBU+SgbyqxN3awUAw
         ZZTw2b8sAvNGFosBdVReMkm4p6VqD00W5HhweZRMQ54Jds/9uzNo7o1u3Y8H/lf8OooW
         m1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWU+WboeUzho/t3xuP1P5NhmAaeVp0oxy6+dfCFptgQAPD7Qa4eXIFl3a6XQiV8B5UATBuJlnRcoiNZfRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LQIqSb8QcFNuGoKBctpTU4sU9i8sE2zOBEsglhhz5XqbLFMN
	SeZV2ScT56mxhh/mmEiACNECDzm/7eGOkWvJAts7GATIHilSeFTIU37P3SGG/FA97z8uokwjehT
	h9JwM9DgVvTTq1rO+dpcnZ6WnaSVTGhNJR/+TtEXUV7MIxhD3WWb5lvYOJy3bb606A8Q=
X-Gm-Gg: ASbGncs3xTyD66usTUivXDbiw8jNLjwoxwoojH1P194gIjVAkfeehs8TVTJfblhtuqv
	FscYwJdt7jlRKEgfp9IODP5e19l597uwfqwITuOkP/ic3cX+wnMaVt+Esr8JN35r/MOvRVW+tNY
	37Z0A61+YdXCAbeKHXwhPjQNfZ0305X4yj2YIBrgyfRu6/+UKEjSOddNXIge4nMuhoj6f01XAvh
	oF+HygW71C1LyPnIrGJ7IGtf49Abn1/jZLlDLUF9vu4ubJcSr0Twu6oxVc2ufc21FUdvpYOH8L8
	zhfMUdQUZPtJbVoYoRJ3axsqHLvuDB+rdsoAe/D13Rwilq7sF3y7WnkTybI6sHBZ0nwUdYzqyZ7
	h7zX4ncYJtszL2KFy46soNJ52Tss=
X-Received: by 2002:a05:6a21:3386:b0:342:e2ef:3323 with SMTP id adf61e73a8af0-346553f732emr2780372637.42.1761732060951;
        Wed, 29 Oct 2025 03:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvHLDqBXrIHqT5BhdcfrUajorIAMA9uhhTRhKCPx2T/Ja47LZZ5K0xA7gJ350vkbHObhXNJA==
X-Received: by 2002:a05:6a21:3386:b0:342:e2ef:3323 with SMTP id adf61e73a8af0-346553f732emr2780316637.42.1761732060183;
        Wed, 29 Oct 2025 03:01:00 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm13323143a12.6.2025.10.29.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:00:59 -0700 (PDT)
Message-ID: <0a47016c-1d7e-4026-92bb-a13ac2ce169b@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 15:30:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
 <2960a6fc-106b-4280-b4d4-9c1a3a449454@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <2960a6fc-106b-4280-b4d4-9c1a3a449454@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qp2ObN3rmvXll8_SNlUd4JqLMXJozyJV
X-Proofpoint-ORIG-GUID: qp2ObN3rmvXll8_SNlUd4JqLMXJozyJV
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6901e5de cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HDE9XZ7bw9bohbkjgD8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3NCBTYWx0ZWRfX710gH9wN6C0Z
 GidtFzyGmG7NaRh7WAi1+LZzmTM/+UxE+uDDDt7zM8/HawKmCCVgX4Me8q1AN+3Iq75QDFcum2g
 ZbOH2uc42gqBHsFwaUlXLjJNxzfaN9m18pz7WhyYq/HEcD7A5ZB7kJkU++yBl54m40ma+5Pr2OV
 nmsTzWP0viNKik54qCjE0IAhSnrzUF0YyjCY11UJvf8IsHeT/uE9+xiksWcq586ht3jyTCN+h9H
 nshvwKfWhSO3/+ATl8wxSWGrekQuGlyFJOKa+FwrY/Q3KzaWP7WhABQGH0fTEcz2RfixWk3yBye
 nUkINGO5OF3oJ2tHS4lL44Nz7IeWA1U0ZOEP/zcIRK8YKvVMV9aEQbyrwMItFmTeBuIkNkKbEUj
 tbLplZGFr6YxZDgEKfok3hd2nTOINA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290074



On 9/25/2025 3:46 PM, Konrad Dybcio wrote:
>> +		tcsrcc: clock-controller@1fd5044 {
>> +			compatible = "qcom,glymur-tcsr";
>> +			reg = <0x0 0x1fd5044 0x0 0x48>;
> We can map 0x1fd5000 - 0x1fd5094 inclusive, as that seems like a
> logical subblock (this would require adjusting the driver)
> 

Konrad, we encountered issues when trying to map regions beyond just the
clock reference registers. Normally, we map the entire address range of
a clock controller (CC) module in the device tree. However, for TCSRCC
where CLKREF_EN registers are located within shared modules like TCSR or
TLMM—we don't own the whole address space, and mapping the full range
can overlap with other devices.
To avoid this, we propose defining the base address as the first
register actually used, and the size to only include up to the last
register we use. This ensures we only map the relevant subblock,
preventing conflicts with other device nodes.

So want to keep the mapping same from the start of clockref clocks.

> There's also a laaaarge pool of various TCSR_ registers between
> the previous node and this one.. but we can leave that in case we
> need to describe it in a specific way some day
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +

-- 
Thanks,
Taniya Das


