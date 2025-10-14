Return-Path: <linux-kernel+bounces-852961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B0BBDA576
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21AAD50256C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E72BF009;
	Tue, 14 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcL8iZDq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1332773F7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455084; cv=none; b=LnC1MXOFSurXqVQCkdWxd3rETiOfGfjpWe6drcIy9sZ3+KzOfAuFQQz7ZVhnyO4dQPbjrGBUGWfpCpvF/bfIMVT658Ak7J2bZcqArK0rMBDSXn1Qs4umn5ZqjDISpLnW/JPhe3fQrBLGj/F1dO7cgkha9Yrfsxx0Eyvj7Xu5QEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455084; c=relaxed/simple;
	bh=2qslDTOkNHTx5U1EAPc0LcinIVRSAoRDmbEkzn5ZsKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEcb16cZVB8WSOqwdaJ034FsoCLIPqgT9UvvDY3j6q9VoFtVmmI+aEcA5SpzG3TA6CG5Nvu2c17zfGLbf7VgCyzkodN+Fb71ewsoHfajnx0nW9FOVN0bz0Zq+Aefd9Sjc2Qv/qiS4laBKgBD1Gk48iO/zmglxaNwN5Z09f32mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KcL8iZDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EF7QZE001553
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2qslDTOkNHTx5U1EAPc0LcinIVRSAoRDmbEkzn5ZsKY=; b=KcL8iZDqF7OHLSib
	ydzB5l/Xf5tpGyxwXbUYnRMX109gyO841tfYcWnKI2WViW3SQeIRmY3l059daoOQ
	H6DPaH9JVeuiI02nhy8QNwKMW86WcGe3HC4MqeyYdop72nWDfiTVAeV0wc4NA37d
	lmH/MXUYtpqIPrSFCZOsS9ydcRATamSgjcWXWcPck3BjF2PuDODb5WEPJXTrWRXj
	LqtsN84hPxSL2RMuVejsILYfjUsspygAqytbegF7jxdShUtOr9I3T+12QizoAutT
	zodYoGAG32u0qMHHDsJCs/SiX+KSDrOFTra4LAFyjF9um9gTPKvDh3WBrZALdFfW
	I9kpWA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk8xx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:18:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8643fb24cafso230289985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455080; x=1761059880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qslDTOkNHTx5U1EAPc0LcinIVRSAoRDmbEkzn5ZsKY=;
        b=cFAZT3itJnM8MOFnjQmE6Sa//35ya707WlOVPfv4YR25xIxluOxi68GxQUOqlRJGPN
         8ijemmNKTz4FVb1NYyMHw5gNJPqdY3fZ/UfmZ82Y4HUq1yNOnve2IrQC79G5zbC166I9
         2PHzYLSDliBYT7oHNUOOMRY/szuUcgL+ya6oUzutdqxMTtSvATYSO1yznr2P7kX8hgjv
         BV5mIY7PbUvO07zZyFM1wyp6BWUZ5nBiEimXnHu1mSaxnSopaoiOIFrIl9MrNAjN1Bu5
         IFBJalP0HhpmzwzUf+qdmWM/Ii1U4SwIYprwwZDCkT16l6DL5eHq1tM0BHy6AsbZoIyu
         jrjg==
X-Forwarded-Encrypted: i=1; AJvYcCU+iBCQKrRIj+8UDxxDnlRVTy32FETMeVJLEDi2AzJahXF3MedWA/YCkbsjCdMv+j8ugWGQGAw64En1q70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH5JsyDK5Hvtn+kfWfKnwLPvFQt7TB0kikgtCSJS4DFmXbEuOr
	u/CJWlMChIsPvLqq1Kf5L6RgsFvYKwQ8thZyC3xKE3kPsJCu37oCL5DIdBrtkMBjRTnnN1ZCTHP
	Buzu4ue8GZ8vU+iQ2AN2y/hB8tE4vZCq5lEXyTX4tVkWmkyH1SequRfCcYqJejih/mQ4=
X-Gm-Gg: ASbGnctgEVEYzBdvy8uTXDDFv1WYgsVRVmpDGRnnXGU742POpJRuWI1Ma9Exfl047dm
	HzXLC273iH64NKtmvvHTca7PHnjYAARapPrEzQIH9+Ca51utn41YJFnjQsmRZXBFnA8snwhZwhh
	JQvrk4HO0voP2elCT6F79MiaYRo6pFaAa6SK1h13+O/ardnypJN5TVszqubqaiRl4fai4k+i3Ln
	7cTDZPbmI3CByflQI+HRnb5PuZW8i5wugDXJwFqhVNkJoRj/tsXAn+NkJUhjdqX74MS4ZnUWv5J
	BIX43FBT8oEPaCUd2w1T3jjo/ZXzG3Fzz7HJCQQAnlE6t0Z/PqxelKkm8Ky/BvSTd/cK8/TkxJj
	o60ozxqpLpa7OuM9pO/T69w==
X-Received: by 2002:a05:620a:290e:b0:7e8:c4f:614b with SMTP id af79cd13be357-88350c6dc10mr2342971085a.7.1760455079974;
        Tue, 14 Oct 2025 08:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5WpyshMmM85giLMhcoK99ytmz5Lh13t9+32hYBwMSqBtMDGYaB1ldRbtBW8hSXyfDZaJ+Wg==
X-Received: by 2002:a05:620a:290e:b0:7e8:c4f:614b with SMTP id af79cd13be357-88350c6dc10mr2342964585a.7.1760455079021;
        Tue, 14 Oct 2025 08:17:59 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccaaba9sm2866166b.55.2025.10.14.08.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:17:58 -0700 (PDT)
Message-ID: <d06a254f-bf54-4bdf-bd09-3ee5e5b31bad@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 17:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: Ghatto <ghatto404@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014044135.177210-1-ghatto404@gmail.com>
 <20251014044135.177210-4-ghatto404@gmail.com>
 <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com>
 <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9_fBO4TBInKtjvnr_6lM55M6BgjFJTC1
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ee69a9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=Kc_O4qD3dURwiZ8RncUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 9_fBO4TBInKtjvnr_6lM55M6BgjFJTC1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7HRNu+WRI+Co
 /P6P9W2T1Yd8WR/QzdFmVLYuBpdrdnY/t1koXZWJwWtxFC8PG6dFnZAWnyFRO4r3uBN9Xba38Y+
 3SD/j7bw2vNdrtP8bSO9rklAfsAYQ7tJcJwcL8Fy+pLE/ETaBsW1Kv4BMn5sy0bxgPYgm17Kauq
 g7OGbB9T9N4bHY+XaW2DcCEK5TqxBB75sKy2f7OfwW51baUNSPpzkfmbgF6fJDL5BpWPL/nrEdx
 yPcvpeNW4+egZXISlRkbNXlJBKb6qQqzEZHirzXjVqw0i2sZ3qIiD1TGqbmqT9w8CGJdwRuXPaL
 VewwRbNRTMo8uoySj3ukAEsEQvrBy80MLb0lXGMExkIF5sXBnIjVSBYD4FcrcOoQsU2zLHoUfL3
 SyDL5J/WSI0CMVfO5gdzYnsETq5lOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/14/25 5:10 PM, Ghatto wrote:
> On Tue, Oct 14, 2025 at 7:01 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 10/14/25 6:41 AM, Eric Gonçalves wrote:
>>> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
>>> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
>>
>> The second sentence doesn't really make sense to be included in
>> the git log
> I'll keep it to the cover letter then
>>
>>> The device has an issue where SPI 8 (the bus which the touchscreen is
>>> connected to) is not working properly right now, so
>>> spi-gpio is used instead.
>>
>> Some Samsung devices used to use spi/i2c-gpio intentionally, also
>> on downstream. I'm assuming this isn't the case for r0q.
> It isn't, the device uses fts2ba61y on the spi8 bus - I hosted the
> DT at https://github.com/ghatt-o/ss_experiments/blob/main/r0q.dts if you
> want to take a look.
>>
>> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
> The driver probes, but it fails to recognize the touchscreen device

Could you post a complete dmesg and the precise DT diff you used?

Konrad

