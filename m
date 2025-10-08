Return-Path: <linux-kernel+bounces-845367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC683BC498A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F4819E18E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F22E9EAA;
	Wed,  8 Oct 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWBYwcD9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870A2E7BDC
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923532; cv=none; b=DZsSTMK+pCsb0qPmt68la/w/MHQfcAvtR5A933qr90sJ2DPTwJzLw6wxBzebpd/bBD158KD1VamCf5yYAbJKQL70twVQnoEIbrrZcfxDQHtNkdiStlymcU3/4YbswjPPSmMT7eTg8dB7BBCXDFB/JfT/X50m6zyEibmHdqzNMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923532; c=relaxed/simple;
	bh=6cCF2LvbGpbslhl10HwoVuuROYSKzmo8yAWwSaQlewY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3vX27LlhJH5wkeYXhgtvUppUxsyXro/84QchQCqCKoPaFDmjWhm3ezLwDuGtVTE0fSJxjWEmDsxq/5rrOrjGuGetf8R2/k1OemnuO/so7QPTKN9IrSOe9j4uyYm3Q5liJfwAICP/IieWo73Zll/uHAaGwjzaqhNlhCsyQpO73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWBYwcD9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890WD8015924
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ktF9PzCzZcJEY3eWTWWmqTdv5VI7UzhEYtnCUHGqeRM=; b=cWBYwcD941nJAH5m
	5tJXXvUAOqWfhkRWM2SV8Xiib7SYanDX7hnzdxjAsa4kgC3aylWwMNroFJpPwxCm
	b7fCISias3S6C1jHuspaPpVuecVm5kB5X+3Yn/klDd+1jRg8zQGloPg9l3zwHIL2
	2vcQJy49UXuNOJOGSvIOpuSoE7EGbenEZo/Y/PGiBRrwEjQ4+bLs3fXBB3pRLjzn
	Mv9bO9QEiaIYb7eu7IXGtWWBDGyD9qunX8vLxyXKfB4x3s/hi5FXe/HwF614C+nT
	MzHLLQ68qMXSDYL+KAitM3fqKv8WksE2g5q15VVI/yIUZpxV+UlgEi7oqiI0mjRv
	RRL/gg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk729ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:38:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dc37a99897so18866941cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759923528; x=1760528328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktF9PzCzZcJEY3eWTWWmqTdv5VI7UzhEYtnCUHGqeRM=;
        b=Bf1d8si/uIVWRtgZc33lYMbwjjWlwz6qq+4MZLI4Hq+VOeHd0SRfrdXipPOtd/zD0P
         MM2Ig79AF5ZdYVzqchEtIwzYg+wSWc94Anm8PnPeCW8NkEEu9nt0h6s0PeN9y6Pj+m5s
         jxL4wXgq10zcSIVsInDOajAwmwVVE5U6Otb+Biwk11PkfP3/T03/musag/ElOgZATpvt
         mjnsyGAdLnMmG5JNcGZAsv7uLy5ZHkk/loigve07HSTfCoW7IbUqk2+59OYIjdIGBOca
         jatFZTZxC5SMX5a4Qmr8zqnmm5T+nCMW92bOM34wzocBBgT9b53jJ8DfhQGh1ctT+8WQ
         UYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUCu6S0Iv1XEBgtRhK3g3pNzwgI277vxv1qR6qkgE7IuTr+GAmuwaIdwU+C0NssDC5Dm3Gu3bfK72roVHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+LQztkj+H1TPFGy/iRCMdn93Oy3T86UGZDNw5DVQyxqrRv6ur
	rlorGWlfnsNhW5d58sYge901h05JpMWi5SI/Z7Kw3lmAFjKne1djLJHv5BmOWB4wq0uF3B6G6S3
	60Wmgn/DR2AOy6FDblS5O1roJ8J+e1nUn8IX715qEiVtwPMzSAyg8pWWlUsYi4ohEqwU=
X-Gm-Gg: ASbGncsWkD8mrgY5VgFO1a7SxRyP1yyg4RRLVuNpOm03MNPdCXWp5GMRLSBedQd5b9j
	pO97VTYBfaS7FoU8V23O3L+I7KMAzK7gjFeCTJqiEOoDR2Z/WLUcrl+CnOgDLv5vApcHqDPt8Mk
	jH48UIu2O6rSxd7GTqTLw1BIc0EypIHyhkKlNL1ZvwYep9jKJzya2gafWlsmqX79lX8dDhZLely
	s/JUnMRTIzrrfTmZp09m6KQ6UMnF24v8qB5UrCcH4Xy0Z+QqyraMdR6kR52b7fw+d/F3itx46Ki
	8gWq1gBzox5ehq0fApYxNPBRFS42KjuLF4n3aeKC9bsprsO7lfBk0tZxEpDca1bXaObEPQu4+1c
	/qDVVV+XdRL5SHciNE2MR2MPuYHQ=
X-Received: by 2002:ac8:7d8d:0:b0:4e5:7716:53f2 with SMTP id d75a77b69052e-4e6ead4d187mr28105561cf.8.1759923528389;
        Wed, 08 Oct 2025 04:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxXdxXLKV4c4vK741eJCYPaC0LrPYDOhy1QH4L6lPiyVX/KVRS60uwDKYl774T/rgeiZSNvQ==
X-Received: by 2002:ac8:7d8d:0:b0:4e5:7716:53f2 with SMTP id d75a77b69052e-4e6ead4d187mr28105351cf.8.1759923527915;
        Wed, 08 Oct 2025 04:38:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637881011e9sm14525558a12.25.2025.10.08.04.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:38:47 -0700 (PDT)
Message-ID: <7abe83dc-5469-48e1-8964-ce3377d82a4d@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-asus-z00t: add initial
 device tree
To: Erikas Bitovtas <xerikasxx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20250930132556.266434-1-xerikasxx@gmail.com>
 <20250930132556.266434-3-xerikasxx@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930132556.266434-3-xerikasxx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX8P8S45PTQy7z
 vs7ty/ri/rE6gl/xs3K3OiD/gUFQJWvt7YoodeZ+k859FSxxmgoXA5XS2eISjgedqDKMgVbZaHW
 AXSsHH6Q0GU0l1pjgcEomOifFElS5FV+Sd0Ee3Xhu14HPPf8AnWLj9cMwHpAXX4gQ2uWr1wb+bN
 06OAn7Yps7YKedivxkiz/cFc7XsJdszZEzocP2uM2faf+neWT4PnY84QpZcMmc+bwL6hYNf5AUk
 iKabmwWCkYutCw4Azw33sF168zycC/D1MQ6WFLIRow2vo8AMIpolgIsLy43E5TiOMubK3D311Ti
 39DMdFJ9mQcY1WUJATmP9eXB4DCrgaydLkquwSdOyUxxhSENko8rZ296j1bHhfmjZSXyKo3a1oC
 hYs3KUDYleIjkrLymW6x2KwtEUf9HA==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e64d49 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=wSXgXpi4_rt3d5ynXFgA:9 a=QEXdDO2ut3YA:10 a=5XHQ0vS7sDUA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: bbgYH9gJ1YiEmRkeElX8PupaaPmO0S5j
X-Proofpoint-ORIG-GUID: bbgYH9gJ1YiEmRkeElX8PupaaPmO0S5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 9/30/25 3:20 PM, Erikas Bitovtas wrote:
> Add an initial device tree for Asus ZenFone 2 Laser/Selfie. This
> includes support for:
> - UART
> - USB
> - Internal storage
> - MicroSD
> - Volume keys
> - Touchscreen: Focaltech FT5306
> - Accelerometer: Invensense MPU6515
> - Magnetometer: Asahi Kasei AK09911
> - Vibrator
> - Audio input and output
> - Modem
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---

[...]

> +&blsp_uart2 {
> +	pinctrl-0 = <&blsp_uart2_console_default>;
> +	pinctrl-1 = <&blsp_uart2_console_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";

nit: a newline before 'status' is customary

[...]

> +&tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio107", "gpio117";

pin configuration nodes are best sorted by their pin number, please
reshuffle them

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes

> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	imu_default: imu-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	mag_reset_default: mag-reset-default-state {
> +		pins = "gpio112";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;

odd \n-s in some entries, please remove them

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

