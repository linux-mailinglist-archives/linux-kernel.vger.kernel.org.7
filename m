Return-Path: <linux-kernel+bounces-805348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A7B48768
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3469B3A2EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3402EAB6D;
	Mon,  8 Sep 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ey5CPwr7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8F2E8882
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321039; cv=none; b=Sy1PPWqrHGZkaSmZGJgp8N4PKOD/RtPH9HASlczquyBGAeNUek2QG0v6HcZ31aTi1164MaorCHnNr1gftv0O76De22KlBdV0TPnVgIWKAmIjnt2Th9LBxKoKI1N7eOT1ro+E+Hh0sYa9ARAF4rVCQRShhqNXwWqLtezHFmxBt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321039; c=relaxed/simple;
	bh=YfZn2EbbDDr/m6xEKnUctK8uxT5iQKRoZlYMUFHprBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s01Y5pmNeVBlLDvsYAL6fjyZhgixpxrxB0EjKgjxInmqNVzvSDkBZ12p8cw0X+8PA9eUdOs/B6uesKVfG4TLUZukt2wn1dcT6qAeYpMArGcuwyATIDTRTJwSrA5z0rEEG6jWH8miojbXfthAM2gxX0U4Epnw+yhgqeSp8pgXnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ey5CPwr7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MlMf5017314
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YXirHZWAcnAup5Mc4KJofofilhQ2FKmIuVp3xsUIzA=; b=ey5CPwr7eQrwsouc
	vU7LaGnKCa7xBSyusIZ52gHEXE6fPg0RnOshIaYeRCHGD31mp47OsA4s/fMgb0D4
	49xIqo+1uEO/8+tfNgqSodjX0ZmiyZSFNWR5fapcuOxCMTXxfYCb4vLGoBF+1ZiH
	5S35Pd2I8l7xD7wDkkpfN+k8jItAgHINHf9ElQVg8wL/FRxuISkb+9/qTWfwPhNJ
	QAt0z89l41jUzBHlYxB4wdBocZwFhtJX5CSm84hdBpEEqldVn5pBqLuoGQrJzUOR
	bw+pXOTn800Uras79HSIpuX5PHznFBd5i7XuA8wbHdRhGo/192zqjPOR9ZcqCSgJ
	sU3C9A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8bv8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:43:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-72a3a4a41a0so4931546d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757321036; x=1757925836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YXirHZWAcnAup5Mc4KJofofilhQ2FKmIuVp3xsUIzA=;
        b=DyNo7P/YHMACccI9PK9VRsXvfY6nup71zAZC1uelLbxSnbITGvhr+XUVxhznNcoODb
         2+Fc6edIlCqOqNZEp6QyvqE6Y8bXHzeeSodrYCDeckZo+2Pc4G+5GJvmlQyAN7hCLjBa
         GGJgEtvlVK4ZRZTfMcgXWpugOKuhh9YH25ZwXqUqW7sM0bA65M9H8P8C7dz5yV58y7Vp
         90uWKD6PkMUbR5oilpq0rVDYMYdjuhP1uCZgMZYezbMYMzLf81+KuzuCxs08D5q4lwpf
         Y1FYjcxZSaJ9SCoVSTXDYJ9T5HN4vP2M+t7iJWsLcjvj2wW0AZua8apFXvPVZ5Cg6+Zi
         Zs9w==
X-Forwarded-Encrypted: i=1; AJvYcCWPXACqjp6MUKV2r9zSuCP6s8rpfDemObp6VUm63TWylTAEgSelAJSkCCyaIt3tYvxHGQHr8IAM+Z+47xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9IfLyes/AciPeBvt1RFH+dWHmhhsBUFUrHZ7pF+HJ5FT3/aV
	xOrzn+ZaLEJmmixaKI/a+aRdDvGFcDjAXpOSPaiWkfdHHChiCv9mqndMvlNJS0LjE5FbREtSAAO
	6fQbNF6S0dZkbuc9ufCp64BhBti/4KIOn4umzAldUjxGkE/UI+z4dpGxhV9CGibeILOo=
X-Gm-Gg: ASbGncvKqNCyLyEZ+o/rLp8DOJhYrTJvrC/eg0VAQGFZjNf+AyeCBUBd1K480SZZczm
	TAJ4csymCu5zJtt/y41TmbB3e2xYl8GKOHoJ9Sm4gypHtsHp2z33ObX7ZnnwXt/RBEkB83ouTtc
	ub1aPYEgbZkDQWQ1Ue7LnqTZIbT/lmL6SkABfGTUH06QcnEHMwXZA7Aeomt/wfJvq/wKZgijayG
	nljhvSw4V0P4V65ioLXIzXHAGJAa6TZ982s7BlzFo3XF7+X6eyJrigknyqgcNdNncr5ofPjVEEt
	S8y6kFNr0wDUV9b2IsaCpFXKp4PV9t23/SkLklBuyBb6ea+othGv/EhDS6EmyXn3lxlx8SnQ/SJ
	VWKkfK6dFT6itYgQtUUwpJQ==
X-Received: by 2002:a05:6214:411b:b0:738:2797:92c7 with SMTP id 6a1803df08f44-73944a0c619mr46426436d6.7.1757321035207;
        Mon, 08 Sep 2025 01:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFppsM+5VIrAF9EEkJhMHSuYD3hi4y4xvCofPF7mq5yRs8Lm4MTOnPqOA+MY9ePWLQNhh81ig==
X-Received: by 2002:a05:6214:411b:b0:738:2797:92c7 with SMTP id 6a1803df08f44-73944a0c619mr46425896d6.7.1757321033937;
        Mon, 08 Sep 2025 01:43:53 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6222f293a31sm5874197a12.12.2025.09.08.01.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:43:53 -0700 (PDT)
Message-ID: <f508bf92-a513-467a-a946-17c41e1d72d1@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:43:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
 <aL6Vp-3er71AJPJd@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aL6Vp-3er71AJPJd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX/76xUnx2bawJ
 QG2g4ArlwzcDrh6Zo+NM0w8dkkgOv1ORAB69SH83uqM99NaPmdWlBCZ6Akxg8vnTKSw510o8294
 0mVM1Gi7lqA4bzpU+JLq6u8B5x97hS8eEugiZz0YErw3mPyKoUZxi2t1CQmzLwIE+hpB7uhD0jd
 nunbgUqmOxKraoL0g++bScH+6bcAD1gnGElZiKQDmLyPy75DMTSRc3Ya6VIhZUArGUdGEK3v8W1
 NjTpb3URqyfeClm2nyfoYQWhU6dnwlI+HRVezIOfuJYDr8RIEKPKCh4C6O5toOQVhWZ5BHd+h0V
 bsxPR3TVQjHCjHEcyE5l7qOzlq6sit9WG6bqOEMbdQSDF2/t8Xb4HkNbl9JpGr88Pf+QvC38Cbi
 ti9DyJB8
X-Proofpoint-ORIG-GUID: tG2jJV-vMTG0KsZgEvnebyEH7PNpLOqP
X-Proofpoint-GUID: tG2jJV-vMTG0KsZgEvnebyEH7PNpLOqP
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68be974d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eeKOm84Awb0PVD3MLwsA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/8/25 10:36 AM, Stephan Gerhold wrote:
> On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The CCI clock has voltage requirements, which need to be described
>> through an OPP table.
>>
>> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
>> (which is a value common across all SoCs), since it's not possible to
>> reach the required timings with the default 19.2 MHz rate.
>>
>> Address both issues by introducing an OPP table and using it to vote
>> for the faster rate.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Using an OPP table for a single static rate that remains the same over
> the whole lifetime of the driver feels like overkill to me. Couldn't you
> just put the "required-opps" directly into the device node so that it is
> automatically applied when the device goes in/out of runtime suspend?
> 
> And since you need to make DT additions anyway, couldn't you just use
> "assigned-clock-rates" to avoid the need for a driver patch entirely? We
> use that for e.g. USB clocks as well.

This is futureproofing, in case someone invents FastMode++ with a higher
dvfs requirement or for when the driver adds presets for a 19.2 MHz CCI
clock which would (marginally) decrease power consumption

Konrad

