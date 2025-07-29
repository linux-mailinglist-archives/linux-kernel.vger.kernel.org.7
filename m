Return-Path: <linux-kernel+bounces-749239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BCBB14BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FA61707F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9328727F;
	Tue, 29 Jul 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYMp/aMg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70628724F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783328; cv=none; b=cDxB6K2K07LxCqKf6cgB3ebOq83KesiMLTaKUPnbLtIc35U7C37Okg5jegzD+ioc/4gPYstbiPJBXXHOUfi9xJLuby6cwXmkQUM/h0SqziJATgC1UWZuj4sQPKX5eHWwUHCjZSGgT8dfLGYWXFSgwfdXjXoColF87X+isXHFN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783328; c=relaxed/simple;
	bh=b5/AbWh4VGYvJYGMYEoAI1yd9P67N1DcHHSd8SASrxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt9nf+xbOiSdys2mNXP37UvYfkmAGl3muOHPYLTr/NGCQmLM6fC6jmpOphOjodPgueRnODRfJ9NaK/Z1U8qj/SPzdUstDH5xDQjRCbciZlFLbPU9mm9vguBdlXBYXr0L0acoqmpPIMEHbJAHIfEzKfuto95RkvrKXtKQCjTWbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EYMp/aMg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8FfLR027637
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i2L4H4k8qNpD35pJiHRB3w3KqGWKmWWZOUOqEsCI49U=; b=EYMp/aMg0TzTTDne
	dpd18urBhEYRJPpeB2NpnSWxOT9ZqYwOolDOaioOPBqUqXpDK8gkO8YH+UUoC9Oc
	boxbDvutROmAIo5KZwst8IopwV4c/zDw32G7flXz0svyjA58ujXdnuujZGVQ01FJ
	o+VU44pTGP+i8LbNJUvFrda1xIicD11+SgcJUA5VzVZc/A8uVfmbDYlq7p8wAN7A
	MdMBiqpCvREE6UevLbG0yKmIk/NWyIcIivMuaW0ZEepd+klZJXuOU1OYhn8BgKk+
	5QYpSqeowCDUO03zAuCIc6kx8vodxC36CkHwTY6wyNLn8yUMnc0bbjgnO2YkWFdl
	yFFysQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860envwah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:02:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e34ba64a9fso25213185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783305; x=1754388105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2L4H4k8qNpD35pJiHRB3w3KqGWKmWWZOUOqEsCI49U=;
        b=JtkIK2kwl5aFJXpfHoxTG/eN97h0cDT5jHaLehWGw36QEPt4wseOM98+O/ksA7aCdv
         yIxwiejjsQlazJpzq7CudiL2m5xZbx7reYUy1+ppGb+uDZ1Pb3c1VD2KXBCl1S7tWzh+
         rJdTS71wk9F3aOtwAOexbEllPCMG3ptAraNeUzjJQe9+YWv2fjZ9q8rNSr673R4Xmzm9
         off8lKZE5ROr2r+GqlrUeSNb5gN09U0zsizog1bySmLgn98XWrRtKouj4ve1ZlZYP3Z1
         93zfd8dSujTTTFDAvLoGueUyQln4dSvBiFWioPaVo8ee5fkDBC7REfcHS91MAjh6CD6x
         va3A==
X-Forwarded-Encrypted: i=1; AJvYcCXigieEkI41B/Ou77WmdhFzhXEIYn0Aw07/18wguksn9Ut8z7eOSXI0ic5lcfsEIL2AMN94sVwgbLP2UyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlT9vkS+XVSYZe4wtJ2MX7nTrFSy+Ps2dTiknhPgJWX/pptcB
	82ENm5CN+KQTObbRW5L7Rml9XmmuW4zOrMpIlomVnyRNo8EyOPk7e0mX1GJpMMAGA4xrSuYNNYH
	xjXyWIkEuErFAAzR+VEzgIrGkmDs/LZTlMYMrdvBZWaXLdGE6lMWEnQJwa/s5FU+4buw=
X-Gm-Gg: ASbGncv5alxpzIr6e0txi2SKWJdHvrGi+CEVJivFUzeg83l/ZBnEG5N8tKeKs4IYH2h
	w5hofAjrl71ff26Fi7VWUW5euuhlF7K3uS0euHkQi8i/fUFFWJgtG1GXyttKT3p66BAV65wuUC5
	VLxmXpCG8GuROikc+surRxE13PAViAxv88K91DCKaUSF5+xZkpJo0KAEHgJFPY54UBlrBFUIZg3
	AtYps8d+DjCpgeXVi8tbZo7dtGTWNRXsxcFVQJTJXtLe4GZvBsJqHK2W1SvwxWET2pAkTIw8zgS
	iQRQZPceEC0WvEOa3ifYIBBazbpg5asnvvYF9Yr4QggBAD9jENKfSLEseZuWMpbVQBNQWNR8jTg
	r682Ph9Puck314VIksA==
X-Received: by 2002:a05:620a:d87:b0:7e6:23df:a465 with SMTP id af79cd13be357-7e63be3ddecmr914838685a.2.1753783305119;
        Tue, 29 Jul 2025 03:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiy7mRTlkTSBHHGFfxJGJ7ZmooAMdpG8CLF6Bxy/LBKUaWbfUoweJXi6ZBpw/4Kvy3dj7t0w==
X-Received: by 2002:a05:620a:d87:b0:7e6:23df:a465 with SMTP id af79cd13be357-7e63be3ddecmr914834885a.2.1753783304592;
        Tue, 29 Jul 2025 03:01:44 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500ad0451sm4462352a12.33.2025.07.29.03.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 03:01:43 -0700 (PDT)
Message-ID: <23f37207-fed9-4584-b92f-7142558473b3@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 12:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
To: Taniya Das <taniya.das@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-7-227cfe5c8ef4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-7-227cfe5c8ef4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bd-w72_0GLplbIvBYkJsuTFTgsr6tE5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3OCBTYWx0ZWRfXwiWQbNm4MdE8
 GbUOCxVxSX9TM9MhvY2n0eK30M6+2Us/zmHur2eweSF3vFGBlJQj1tU/24leUf/5gmxpmz8N8Nr
 2AJdaKvLKqLMCMgbWixheHXpLBYn5VWtGMk3x/emnwBe2nzFo12B0S/+yhLoiRgL6AMIALxbEl7
 1F9WRX2w8xrlNse2xxX6B7UUbL4S/cxGihu1YbiqqvpEhFDLBLHiaxhLigHAPIlPZ+FeWaevrbR
 0Omr011YgQbYTMANpoYjnyqn/maYW0Ulx6tw/Uc30ZyMlye8hpjkDpixvtH5OmgUI3FRqCdsYe7
 ICKCI+o1wNckLaa04QUxPElDmklMZlTjxhaO8atIYHUe4b6gaepVe1O/hNdiMjFfbePwvAyJbjF
 9q7yn4egkSc6VTFmCSkHjqKjqfPxtAXPEGkzBqh/m90i+/3Ja2sHpQTE2F+7k1j3YIABxEWP
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=68889c1d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=sQv67BsiESNKl3dOTAkA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: bd-w72_0GLplbIvBYkJsuTFTgsr6tE5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=953
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290078

On 7/29/25 7:42 AM, Taniya Das wrote:
> Add support for Global clock controller for Glymur platform.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

I don't see anything obviously wrong

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

