Return-Path: <linux-kernel+bounces-703813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856EEAE9519
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 07:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8FE4A6323
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 05:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A52135D7;
	Thu, 26 Jun 2025 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WamTXcIZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF035972
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914977; cv=none; b=AAPlKr6e6Sp0tlGIE2gjld8h/sbRQvMOIIVu5bQ7NsEey3ScJH7cG2m7iDAcnM1sWWxIW1ScaMQgvkKNEbcnB7Lzu8T+VzX5znfGUqVtvcwXt7MEIdFixfJDo/RkHUrDzjnCn2S2Zfl8dKET0feFX3oJMH/F+6AyRI3HQBDiI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914977; c=relaxed/simple;
	bh=DGIscSfCziwlOv1P8QbTdNlq9sdRWlYurdgZqoUEpB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWbTqxl8hXxRgdEf0Q9QOCc6puQgiM0Mzw2smxLaALAc4gGmyUEE7Gw51IxNSRV2Q4g1C8zWh4HcrQJK91zgoVIvz2FR2Djl56xOcxnUiFLytMgOKNcUCYWAtrQXj2gl8que0W98RrSiOwREweh9t81ipq9fhxmZvETvRMhucFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WamTXcIZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q0EDLG016254
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 05:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LY71DyKBMD5t9RNhRw/JYOoNO51ZSy07y5vbGuiOBVk=; b=WamTXcIZMQ8WxaBH
	wlzoE4GqgHlTV9FknB5JMrW/KsaQzyAaIgZEk0DkT/Hoftwj9M4y+HbvEZQqyTQI
	cYQecNR0NVYfjCx6yhR9lfnLqM8Mu3I82ZX9u2PUk64dgSJyXSO+TEvpMJtx3xuk
	tTiWWXvTKEqvAaHaAez43By1nfthjJCM+kVqeu+V+vuFMjVabHG1tdGuh+n414Vf
	IKQWQTLrzjVDojbeCg97njnjOt69X4qUaluLNSXMdPkFRU5zQkh3zbhJbcWg4y3G
	CZASp0i3lwAXlJesgDaSL4OljDFLGo4J05zyqh3YrVm22qTV+7QPcIa6UUd37Tlr
	ZR9Myg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fbstx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 05:16:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso379307a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 22:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750914974; x=1751519774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY71DyKBMD5t9RNhRw/JYOoNO51ZSy07y5vbGuiOBVk=;
        b=KhyRhJGoR96kFbhYSTjB5UudotiJUKkcL3ApNedloYU8qOXd+8XcNYEEAgkrocHqyt
         HUxKaUHaCUAQqwU7tM39GD+Up2F/FVt5XtLvnMLe1fofBWfyqQsu2nAPEVEmVEuz4jqS
         T28F0xjpTqE2QEWBOXxa+PIB8PlMa3HHYNsCApkn/2n4Wj4sa32I39cTEqnxKlTXafNd
         1gSUdXS2yBbyWKP1w8nNiTRrjRAaBXX7saTWu9PJoLy4URRlZjS2DXedDB3YLHjWpbe9
         ltIHiV8xiYXY1g55NSbwUOBuFRhqi4NjHZKlpZpgs1GXft1PSWlPcgRJP65logocaz5u
         CHyA==
X-Forwarded-Encrypted: i=1; AJvYcCVcnVmzGET324+Y8Z9g0zdg75Z/7HBoua0icV6BqsZWUjKjoXarRDd4wyh23ArOwgJ93JJa+hYu18EsB5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRt89/GwGEEN00YTYq2zyuXacZDB8Jd6DZu7QNHws97HYP9k4+
	f9PIqSnlpBTe3xIuGRKoK7NSlzMQuucKcRD06yCsAKszW0ua6sJsisLhLnXEW2eB/9iScC34umF
	N74xaKrSd9432BM7VXRPnnjfTTIWwqLtDV7cOQ4+lLYyr3tgMHv4Mi/UPXiO+klf4gxg=
X-Gm-Gg: ASbGnctWwgDzZ4TGkg/AriqzpeUj0kp8O2ZIgCvVDdGieWolYl0XsXAJSFvlWeIrtRm
	ay/NYarplj3cEhpaZjTxjZp8esbLbSnxx1T72fnDpx0Q9pME3Eo+KI+BjFvFGfEXlCAZWhaEd2X
	brPTil4Iv6eL52SFfVsVIYSsQgyCneTPlDvVWoHVodd4Sj5+HRdzYigzvGY3VnwadM/v3GRlNK9
	S16yM8OxcbxI4WzQ/e0OfLZzI8JXI/YPF4jxLmIwQnTvKP0qtKFm0aAq1JTEmiSSayENswcF760
	Dc9dapGyNYuY4mrk9rdQeXGJqt4PTNsDQRLjGw9Lwyw+JlNUbSoGTOA5GvR0aLg=
X-Received: by 2002:a17:902:c946:b0:234:9066:c857 with SMTP id d9443c01a7336-23823fda014mr93556365ad.21.1750914973618;
        Wed, 25 Jun 2025 22:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1J4U+ZM0bzuwizefQYFWAFIBA+Dan1+AA0/xNRtmYf7564YTHsnuN3w6c86htat1ivMpLSw==
X-Received: by 2002:a17:902:c946:b0:234:9066:c857 with SMTP id d9443c01a7336-23823fda014mr93556165ad.21.1750914973097;
        Wed, 25 Jun 2025 22:16:13 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86d1b74sm152989225ad.209.2025.06.25.22.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 22:16:12 -0700 (PDT)
Message-ID: <5925b608-1251-4b73-b310-948b383f7b7b@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 10:46:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq5424: Describe the 4-wire UART SE
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250624-ipq5424_hsuart-v2-1-6566dabfe4a6@oss.qualcomm.com>
 <bdf7e3e4-f1d1-4f3f-aebe-ded7b8091884@oss.qualcomm.com>
 <3514a3af-ab7d-41e6-9e59-95defe9105b4@oss.qualcomm.com>
 <da6daf53-11de-4ca1-892d-73754adb435f@oss.qualcomm.com>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <da6daf53-11de-4ca1-892d-73754adb435f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0MCBTYWx0ZWRfX3QxxaADU+sbH
 FL64uElbjzfIf3O8IoFlpwHqBCpIfkRG5aQ0A9OW3unpr/ltp1m2q+dCE984b6TfceUB1hCFAJL
 fbQ18ghFflNW38Fu8SC3OSkA5xRaYlsVs1OZiPwqx09J5lAinve//JMXs5e1XJY3lhTlL0Od3nq
 wBL7s1GS/94jHehSbmaJ475AeFn61QmpRhLDf0ZEwYuCJ1zZTrlwsS0X4CAzJSBh/wGUJ3nabqB
 ZQzmu29YF8RUl6meHENSTXPDejgLNLuWoj7QCMC2y64sdMyBqhs+Svn4NB/Vx3IBjXd8JQJ6zIv
 be70xzuPsjPOZ/lSX9sbTt2B+L6La29tkLLKbtl7qHknQqYGsYes5pALXEdej1rNV6UkRrIsRLl
 x6XKwN26gLKSDvAnrHLmt0O3yk4pkIn+IupaE2geA3JBVti2fvmOzJ6O4OodN2wIsLAYcBD7
X-Proofpoint-ORIG-GUID: ld64BnGS_pf8-fkJdD3aKM7et9c5UrK0
X-Proofpoint-GUID: ld64BnGS_pf8-fkJdD3aKM7et9c5UrK0
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685cd79f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Dgig-iccZCONCpKWDfgA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=596
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260040


On 6/25/2025 5:44 PM, Konrad Dybcio wrote:
> On 6/25/25 7:55 AM, Kathiravan Thirumoorthy wrote:
>> On 6/24/2025 8:08 PM, Konrad Dybcio wrote:
>>> On 6/24/25 11:00 AM, Kathiravan Thirumoorthy wrote:
>>>> QUPv3 in IPQ5424 consists of six Serial Engines (SEs). Describe the
>>>> first SE, which supports a 4-wire UART configuration suitable for
>>>> applications such as HS-UART.
>>>>
>>>> Note that the required initialization for this SE is not handled by the
>>>> bootloader. Therefore, add the SE node in the device tree but keep it
>>>> disabled. Enable it once Linux gains support for configuring the SE,
>>>> allowing to use in relevant RDPs.
>>> Do you mean fw loading support?
>> SE0 is minicore, so we don't need to load the FW. But apart from FW , protocol specific configurations to be done in the SE's Image Configuration registers, which is taken care in the patch[1]
>>
>> [1] [PATCH v5 0/5] Add support to load QUP SE firmware from <https://lore.kernel.org/linux-arm-msm/20250624095102.1587580-1-viken.dadhaniya@oss.qualcomm.com/T/#m37a6b739c66040cde5b6b0121a03da7ea6715842>
> I've heard the 'minicore' or similar name before.. how does it differ
> from a "normal" SE? (+Mukesh & Viken)

There are 2 types of SE. One is Minicore and another one is FW based.

Minicore SE supports only I2C / SPI / UART protocols and it is fixed in 
RTL. Depends on the protocol needed, we need to configure the "Image 
Configuration registers".

FW based SE supports wide variety of protocols like I3C, CAN and so on. 
This can be achieved by the loading the protocol specific FW image and 
configuring the "Image Configuration registers".

> Konrad

