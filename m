Return-Path: <linux-kernel+bounces-822774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C4B84A41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5502A3278
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40819047A;
	Thu, 18 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IkOm8Zlt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88C303A31
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199551; cv=none; b=KJW8OCcil8aHmnGakOWlNlb2ifIqioJPeAif89K1tHMP9t1QbtcwmNvDQVEvIndooF/XKA6aX+KUHqpF7c1QWqhEGNT+D4S9dvwkhaFdUNyYhS4QGTSK4pJqgYqSbzNY+eSeZafqtPR7Y9ihRKjRczuX4MlZsVPp+n0xOm+lgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199551; c=relaxed/simple;
	bh=LoAKVvtag7GjmWOFgtJXkf32NvYSH1bkz1YunveXkr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSu1v8RI4MyGBadDIKkiKl7jsLfnC77mltpHMyZPJXPgsu0xezDkVXzBFQwBLjgT+iulTheJvSDt9O5Vy+gT08mEv5B8t8Ozp7zWHNgObH5RZl31jPlXGikguRXc8hm1vcHkEHzZaVg7QZo70yXBu9shJw06FR8w8G6Sr4obqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IkOm8Zlt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICPYKo017667
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GOz+PCs7jp3F7RKfOrvc7eml2rNmKhLmgtLqz9c8L4=; b=IkOm8ZltqbwueZb7
	sSImWx1JWPiNMWGcgN22ZieLjsg40Y7L5OAtj468z7nFNw5Avcpz1lHcCdfIloV6
	0epkJdPEcPQo1t36w44vpzvSNePqiokTI3UofnudaqqPTUZfKfRorQ4/m24qDe/J
	E1CNvPR0a0fnBOfdDWtJDHQDFREGszA6GkN0evT9Q8FIsTeiENueajZbcY6xYpD8
	sVxYIkpa7peruBwHulq6Ci08PV2zWSJTX529UiUtjNSGNjqVpOZjeSFNHa0vW8Qa
	aA1P+bIlTc8mF65Js3NRNhIK3mmElei5BuNw1a/wz1gb+i9oc+j1Rm0Ip/b99BSX
	Slv2zQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deaw27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:45:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b77da4b375so2474981cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199548; x=1758804348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GOz+PCs7jp3F7RKfOrvc7eml2rNmKhLmgtLqz9c8L4=;
        b=i54+5he9Atm0pyW/n23n0DKN/gjO9OtxOaQ30t+fr1dPB568zzIoWiXkrzO0RddvMM
         cC2m8iI8vdwLqxAaYiCs9ZI+TvC67cniyYav+qupFWvd8qSnnSqWGJeFXRiiIrUOiKbN
         56xBmrHBeIrNSqHG7g6sFtiHZYgnqmbyUE5dtmrVCAnqhSCC/WFWp8hijXv+rJ09NltZ
         rkf7oyBsUpuJKwoncaB4VkkUAUR10YUH6vHahi22HQhgACG3QJievnXp2i33XpAQJG9K
         T9FrF+9JMzLLsl03CG7n54Yw7Rj71/Tads5Zjo4V1qzE2ExyYIUb1x3+J1gwC4bCToL7
         DLLg==
X-Forwarded-Encrypted: i=1; AJvYcCWYG4CpNKQga64MVdbfSbW5Jr6nd2OXzt0G9nYtt6/Jfm6GMGAfaN9aAjtcT5E14JeDTIO9m78vTRRirf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvts1IW07KRABTEDAJFmg4AxEcEmOXLV+ZO216gUTZQhwnqAgc
	IhOfYUijxjd0JSpJtRA72miDcuOKbzfhzldXjf5HfWZ0KcjE1/mJbxJkKEng+IcxjbhtTfesyWC
	jGLSn/dTPbCjP/53gI2l/m8kp+GIUtjSUO15OWw9Y/8+ns51rmi1EP6UDkQotLRkySeQ=
X-Gm-Gg: ASbGnctium/cuEgBgzdd9FyhDKP4pGBMj2pz9D+qqXD0CUYzS9YXNaildR3MyhfjFsi
	Mc7rJfBOTz4uW6SMzS01yb/9zbtIZqptrI43Yd8AXuEL+FAOHMaNQu5EYHK8kJMsEVzJquDLsnr
	F2E9AOZQOtLCx7X/zBVCwCMn6M7zDO+1ZQDQTe+apvWS6qA1jNWjagp4u9zqYAfnEImGOJA8LCQ
	yS3ZsJKNljmVS0fMeSAF5MFyEK0QVz7qWSKPFQ8mTKi4+YDCpQYfahm4fN1vLbbnViKTByqSkdE
	o2HyZsqdzt/GPMXCypg4G7enT4xvg556j7i8bycVlOsJPpTTxJTonTPeNvZxq2ZnhCQ2sZfPJ/f
	orL6j23BLVUpwx+BM/lQIgw==
X-Received: by 2002:ac8:5d08:0:b0:4b7:a71f:582e with SMTP id d75a77b69052e-4ba6ae98bcamr50054861cf.9.1758199547937;
        Thu, 18 Sep 2025 05:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6WYPa0ZzSzMXT9Gf43YxOU+vRKLAQ2MENxshhRg41bayczaicmdHGOqcldRH6M/5nmSv61Q==
X-Received: by 2002:ac8:5d08:0:b0:4b7:a71f:582e with SMTP id d75a77b69052e-4ba6ae98bcamr50054551cf.9.1758199547332;
        Thu, 18 Sep 2025 05:45:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f42f1esm1407927a12.53.2025.09.18.05.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:45:46 -0700 (PDT)
Message-ID: <c1d7ac51-2e5f-4b36-bbfe-c56b510aea4f@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:45:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs615-ride: Set drive strength for
 wlan-en-state pin
To: "Yu(Yuriy) Zhang" <yu.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250918112729.3512516-1-yu.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918112729.3512516-1-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cbfefd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4-aev5clkuGwqZtU_tIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: lSPforTVUIju9ZDLqkmleeo3cUkibETz
X-Proofpoint-ORIG-GUID: lSPforTVUIju9ZDLqkmleeo3cUkibETz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX47nFCZ28F6Q5
 59y2B4Ep5KIhQ3ch7uP2RWuZLqwMZauv7c7yg/iwNSvLm5PSHDds9TiWGkn7uofHU4zKbFHJjIb
 nIWWE6M452u5iD/1Brpl69EW/8eNNNEVonXmlc9Mk55gvSmxqe9U1lxmYA2CJ6GV9Hf4dprCD7D
 h2FvbOAhC8GDluiUB8Aue2Wd5kE/NQyqf+YCTKDj59W5OtBRV/zN4Ne13d+T0UnomMEpJ1Stfxw
 gzVOxvxtEMtvOL/FthaqUAXObazBrxIao/TPtTzVgUSB/wzMbKDHNETdlXp8F0DQx5oTR/kIrUy
 krRAeTJH+YtdMaDTlFUIb+oPWQtz8hpkDA4wB4ByZYHHpg6UMrAgB40GS53NMRoQ9NtG+2Qdf7l
 KL8WIETV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

On 9/18/25 1:27 PM, Yu(Yuriy) Zhang wrote:
> From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
> 
> Set the drive-strength to 16mA for gpio98 used as wlan-en-state in the
> QCS615 ride platform device tree. This ensures sufficient output
> strength for controlling the WLAN enable signal reliably.
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

