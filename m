Return-Path: <linux-kernel+bounces-873389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5DEC13D35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5D50885E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70033201278;
	Tue, 28 Oct 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OuRNaO/Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC66145B16
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643737; cv=none; b=DzNl7VIN9rdaQcorlutHrl29G4xq2wmqTBwXfnIM9d8kuTu70mPd5POGwKU/FrUYJhfFwjVADps4nw6E/ZlbtPqnTe+8Mf7i0fUEb2TfdvsrfzTOD/y/8RPAPG/1ASJk3kdmdkssF/JI4ANySqlmhOURCv57Cf129Yp8DWW9Fo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643737; c=relaxed/simple;
	bh=ZwcXGonRvN92emIPNXJaJ1t/xG4py0/uAK0YGXZ995c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAQrhifuEnWgyxNlseoDHv7dU/wrsT//eoL1HECosadkhum7yQM7ms85AY3hC/G2inJaKjp4+m03mtgXmy7VcK6uC/68h5L7PntduWmT0n9hjCrRQx1R+u70zUGS8gL4l9iDRhWSrlE0miIDoCcrhKCmQaL4jR/0+1kkYJLkDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OuRNaO/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S8XrRh1177136
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e58+fNddGzKAOXNx1q0z8A5H8OAdJV64gGeZoQGGH1A=; b=OuRNaO/ZXOk9q3hp
	t5iigTW7+TOM94JNxgV3pm3jVgA98LE6rTno2SuetfrUkraWTzsiDFu/KrnI7exB
	Fu4AyuWD90KGYZqKuVkGHfKiS8vd9uKMVUbssUIpUgIFz7GvNGGj5SPmyAbdkmjI
	A21YYDQbmLeHWgNBW/1p6heoODB9TWKp23+mNKo8WxKofNQBHjfOA7r13Oumi6BM
	TpITRsJMNAcvw2lqzAyBmp3MIEGLKhL8LJzVWQBA/3gERZAl0QnzEp04Cok9Buy9
	LylIGaf9aq5cGVUAglp7Fh6ASTR5mHNX/dtQ/fLXFVkoY5xQEb84yjOR4qvZQjlf
	1jvNpw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2tebg5wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:28:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a35e1923so13829681cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643735; x=1762248535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e58+fNddGzKAOXNx1q0z8A5H8OAdJV64gGeZoQGGH1A=;
        b=ogxvdAbyRCO9LQt9gUOyqQFg0QLYye7SINVpAT5TeISNt3VkhgxSWIM4T/qNTRVtSA
         8RkXrXReN4yUmj2AAHFpC4hIIRkO/kauPfQ1Nnx0idjfIaBSo4ibfLwJYwKUKQOVeIkL
         1/EcyC1kt2dgFODjwr3N0VGiz4liWARqzFeZfY1JJ3fRHDpUFG4nPryoYMXJsjWaEcTu
         0Pqef9MKJAtZGwT518m5K+qfx1A/Okh6ogacYTG/om9/S9xgqgck9HY78e0TwB5fihxm
         q5jf9ohQMnimaKBsvmY68pZKX+KKRhJAy8N+/W1c7q2PWs85/eXhnz5SuqDr26e8o+LH
         8tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCLEOerVQKn8boLIiv3c9o4gsln5/Ajcbmfi0DGi449+0YJRCQiHIqU9MUn1jfd5gOL69c42tBTxvxr6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMSz+qOo1LTk0wnoe0A56dQhvCni8+QMbaA5YvprHMlnBNPVO
	JA9YvLerACw6EbT+/9upUUSaqWAriOAxW9Wz0/WBHEcGmJ8VVIavaXg72Bh3NSoIIiR68sUlKxp
	MjMvSn005qHFkr8gD/bIqeCDffAysf2aYt8eJXqW+p4Z4DI8OK7c/x5PQ+pvpTAmR9AQ=
X-Gm-Gg: ASbGncswEgMlQS5fsDHn/H6wwYM0zrhsdpQKygWyiRkxwz4UcD7TjSto458VrCC4Ckx
	8gySEhnFgA5j35uUDkrfrTT0lJZ3ksuNG7u+cbIMkjyN6dhbrmtR7L1tAbNXji5oVFh10KIknep
	KiE/eFM0Ks+JXZew0QnOUY3qGi67L00AFMVzOozQ92uSLVTnjwOK3soUq4CNTs/ISqQdSkjKDh2
	93cR0179K6/py9eEbqYf3+APUveNk3Sz+e70Dtk+PO5JHEmLRHRMu3yPSApeRMyLKjNI//FezIg
	waIPXOUk/w+1M4B8st6BmrE1lQJ+2jUDvWE+5MWuLq+EV8OTQV+rIyUp9wU3qHJZ9PVESq/QCVL
	mkImDFxQJyrXYqIYgk2SK611dgzQpyiiV8pJyoa/7nq20n9aMzC0LPj87
X-Received: by 2002:ac8:7fc4:0:b0:4b7:94f1:7722 with SMTP id d75a77b69052e-4ed07300584mr24794511cf.0.1761643734637;
        Tue, 28 Oct 2025 02:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1y09EzKeIgKo6FSlPS4BPv76TL/fj50gN3CY3VRT9ZqcFngZTXBYoyq9XTVLAJGTrU+4UEg==
X-Received: by 2002:ac8:7fc4:0:b0:4b7:94f1:7722 with SMTP id d75a77b69052e-4ed07300584mr24794321cf.0.1761643734082;
        Tue, 28 Oct 2025 02:28:54 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853386casm1023836866b.15.2025.10.28.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:28:53 -0700 (PDT)
Message-ID: <38628ff7-8080-4ab2-a9a7-78b51f3f699b@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:28:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] arm64: dts: qcom: x1e80100: add Coresight nodes for
 APSS debug block
To: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jie Gan <jie.gan@oss.qualcomm.com>, Johan Hovold <johan@kernel.org>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
 <20251027-cpu_cluster_component_pm-v1-12-31355ac588c2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-12-31355ac588c2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4MCBTYWx0ZWRfX6CgmbUDKuxqZ
 Vl1uq7SP0SUFtc05HgWRhvgOR1ORLyDhmYgaqwFwFuY1z3H61ybvssZlee7IQS+lV1FCW5Lrcf8
 7N4Bbz7q5Hb9YSxJuEghVreyKpE8zkMwYrUGVV9e7cbH7GiVViLUuI/qCpKZggJDzaQdCkcv33g
 C1uICY+Ef+aUN+ust4mKGPJMayUbv8p/Aei7ZImqqvwSzXgOcuFWBXFvfzPdXHD8pdgqRCtM4Cs
 /7RVwn0SMzfcMyWntuSL4HAeXqBl+U0rxqaOEFnMS0bwbacOtjA1DFka98UPgdpAHyWzAvh+uWD
 gc7zFC2Mcj4LClzIitMp3+dIgubiQimSzNYlcMVo3UHg9yfZbicnkP6ozIhkeUqcIxH0acEUT8a
 zWUwUGh8etg2tM4nWVgG2zSINze3MA==
X-Proofpoint-GUID: IYLpH4LhVhNwuY1yF9nlWZFGyLBG6ucj
X-Proofpoint-ORIG-GUID: IYLpH4LhVhNwuY1yF9nlWZFGyLBG6ucj
X-Authority-Analysis: v=2.4 cv=V/BwEOni c=1 sm=1 tr=0 ts=69008cd7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=H2ti3IRskaQp3tPIb7kA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280080

On 10/28/25 7:28 AM, Yuanfang Zhang wrote:
> Add below Coresight devices for APSS debug block:
> -ETM
> -TMC ETF
> -Funnel
> -Replicator

This is a really crude commit message.. please take the opportunity
to describe the topology, any updates/quirks/exciting new features

[...]

> +			out-ports {
> +				port {
> +					apss_funnel_out: endpoint {
> +						remote-endpoint =
> +						<&funnel1_in4>;
> +					};

Unbreak this line

The X1P part doesn't apply on on next-20251027.. I see that your base
is some coresight branch - is it part of linux-next? If so, you can
just base your series on that.

I can confirm an unfused X1E80100 still boots up with this change

Although the problem that was originally brought up here:

https://lore.kernel.org/linux-arm-msm/Z6t45aOGDkotqM4Z@hovoldconsulting.com/

still exists..

$ dmesg | grep replicator | wc -l
128

otherwise lgtm

Konrad

