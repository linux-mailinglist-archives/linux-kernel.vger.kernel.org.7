Return-Path: <linux-kernel+bounces-805198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9CB48537
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EA27A625F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1730223DC0;
	Mon,  8 Sep 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eozoCN0Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73162E4252
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316500; cv=none; b=a3XI8v5w0qYOJ/GAKllORuokRjDpHl//ZTR8EPLG8YMB963J1F1vrTUKENtfc9r8Sy3J6NhzWLHCUFnQENLYzB3juwkBYx7SKwL14aZUZs6Rx9RXKmyZC9DE+r/Q7grJpGmUnsh3WXOLhpGwA4HEM8QVTw+j8corOCEL7b/733g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316500; c=relaxed/simple;
	bh=qbzdEVIeV69/mmAKbuz9lop8NzAL+wErgvl0Fl2CZ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o40MOCIIQbx+k5ffzEZ8Ca4dJIxiqcPtW+5B43D/KVDKTKzOVRzBppsjxAEBRTa7SqPfnq3ACGS7qisfnDi/nWC9RU3mp2PQsBA+2RUJBw61z09g59wWPQFpu7hk7ciVyJbKaxidNpHcrMHvPPEiT1vM8cSFum0XPfcmgk5syFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eozoCN0Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880fo42026519
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 07:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERLf/ncv7o04qbtewCDq3K9ys9j1usVy2WEVFXE0/HM=; b=eozoCN0QzM4MqTN0
	oAUlUWFjDBGVTzSNld5ige4n+UtQK7ecqJS+f11o3jTUqtOliXC2DwWmNpKIjfoj
	nn+mRfGiqv3B9bekNuzLXtV4EU3a+FwNIXL8dK8EFjjSYnXmYZWDBZdTkqOvZWE+
	ObfJ5P0AXapQxq4fkh2QvRYFQAp+Ipwh/dtyhDXVxCZil9c/TYr19Zq8xD15D84B
	CffZ7ZSl/PzaUgugo+CDWZ9aE4VfrzK7XHa7E0yHz/jxtIufe0janLjiZ6Xql5Vq
	lUVFRkqU2LqX0lvKGCrGPcNeA/tD0HJUmcjz9WVaJUICgWPVOqpSd+gPicvFhR8Q
	OCvmWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kuj5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:28:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f92a6936so8519901cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316496; x=1757921296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERLf/ncv7o04qbtewCDq3K9ys9j1usVy2WEVFXE0/HM=;
        b=NaUBksJSiN6S8qYMKic2v6BUajRSxlxNuPlXfwM9OZcnQvC6XMcUJeXxK3BdXNoqml
         0o6OU1EWCtbJjV/rCrkglBcHDA8VFav5NCIlinOt/qzerJFWftOXLyRGbuWuUR+nHs1B
         XuDtoTUMUVsCr4oOwVbKGnzcIJSdnQ4UD08Y6J9BMagFcqoK3Qj2cEuCfsBWmvUQ6nkP
         hGhKaymgleemNhjg6KnTZKoEC0O3TLHSMuysn0Vs2BGLlWldW4yOqL0LkMktbi6NxQXy
         69JE7whMIfgYzXlrr4nRoIStt8ZpwKUh/HTmHPzTYUyYgMgNP7gk82Twp4yPtM5+50bQ
         5jfw==
X-Forwarded-Encrypted: i=1; AJvYcCVpsNTCFhdYD/SEvZDZASR3MyS0xtz2Y3hNIWq0dSKAQ2rSpcZsA7hMnOzUv82BZHASdMJ9j3bJqKKOj+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6wij2g6sbqy88HzXo31YnSt6AQvxtGHIjBdPztFbUCyd/wi6
	ImQ60LPTkD7flo3XtQbYXpviaW3tNcRXpwEJHEbDsfVWlnZ10XuUU+UIcRewD7bEl76pWBwa65B
	ou5sdtucCHrlcccIt6V9Kl77UGyMMwyFlOpSi8qmD1Kpeb9Zyn33QThDHxD8GE6ILDIE=
X-Gm-Gg: ASbGncsym6gJNw4ZC/QhbCsRjBmZQE8+O1pIMNg2wVQ59UMojnogGIMXhjOc6X8HuBc
	P3tLnMsDgiDrIzZgIFIQ3eGlnyxJ3brN9DKZoopC7a6jH3I0FwH25U4KJEcf+iA8mKwsRf1LrBk
	4a3YfRer97lF0kzw9GQ5njaodD/X6be+4F+B0rpSg8TFtwk+x4H9RDO6DgJivm1K6OmJr9/igLl
	03ABFC+I/IDwq8kj1ZmHu2RWQBTneAIYZpBDOT5McrruierFEECrgw8izTDmEW8ROv58ppDmLO4
	Vijw75zH6Iu2iVZSl85KvMHvNIUREBuyuB80YSFsJ5OV2xgJ/2tNNgU66JlofzMew+XQMzLbRgR
	xiRrtgP/cWOWAFoAo60E+og==
X-Received: by 2002:ac8:5e09:0:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b5f83aa98fmr49543241cf.5.1757316496577;
        Mon, 08 Sep 2025 00:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGAgl00GaYehU+zuRCAg7V4DAYv8tb/FWR4y4Uvtjs+MAr65Vw5x+XLudGsUA/GY92sb/oiQ==
X-Received: by 2002:ac8:5e09:0:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b5f83aa98fmr49543111cf.5.1757316496019;
        Mon, 08 Sep 2025 00:28:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2167090466b.12.2025.09.08.00.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:28:15 -0700 (PDT)
Message-ID: <f16a858d-fb41-4cc9-a138-7bfe5ee2800f@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 09:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] platform: arm64: thinkpad-t14s-ec: new driver
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250906-thinkpad-t14s-ec-v3-0-3ce6ec21ae89@collabora.com>
 <20250906-thinkpad-t14s-ec-v3-2-3ce6ec21ae89@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250906-thinkpad-t14s-ec-v3-2-3ce6ec21ae89@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXznpg0ydLUOf6
 xfC5lTE5UI5bFXyfWMKJJ5gB57guQ1s87mdp/STTJw3OgAMocwz80B5VjIjHdlcwiFtgy0YeGsI
 xCdIJuBfQf9Nxven2F+jVJc11vU36se57bL9F51V4Cl5Qx4x20aDYF+HJ7oBizPBk9NELEFECaQ
 Jbg07u1QXM0VQt9EjgJF8Y02iXibGMz/K+Z+jMwt5kLCWBzoVlhkBHQMMnxwuR2gYSZrJzhpwij
 viAjj4ita1BAfpom9rUidz69ByaWkT4Hdf9VDYDTJyBnTHxMX1Zl42bT+z6fFczqhswEmCe3GF/
 5HLJ3NKIearVkmjj1/6bfc8zwE5VS+02qgn7XN9FwIfaYTSGDe+h/rbwkfcWU8pfAiXR36w5eUM
 VUVJf3VC
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68be8592 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=l0D_vPNz536yW1AJoQEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: GuP-sAAKYZB-CEHXjMQVtwr9KZMYkWEN
X-Proofpoint-ORIG-GUID: GuP-sAAKYZB-CEHXjMQVtwr9KZMYkWEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 9/6/25 3:12 AM, Sebastian Reichel wrote:
> Introduce EC driver for the ThinkPad T14s Gen6 Snapdragon, which is in
> theory compatible with ThinkPad ACPI. On Linux the system is booted with
> device tree, which is not supported by the ThinkPad ACPI driver
> (drivers/platform/x86/lenovo/thinkpad_acpi.c). Also most of the hardware
> compatibility is handled via ACPI tables, which are obviously not used
> when booting via device tree. Thus adding DT compatibility to the
> existing driver is not worth it as there is almost no code sharing.

[...]


couple nits, feel free to ignore

> +#define T14S_EC_EVT_NONE			0x00
> +#define T14S_EC_EVT_KEY_FN_4			0x13
> +#define T14S_EC_EVT_KEY_FN_F7			0x16
> +#define T14S_EC_EVT_KEY_FN_SPACE		0x1F
> +#define T14S_EC_EVT_KEY_TP_DOUBLE_TAP		0x20
> +#define T14S_EC_EVT_AC_CONNECTED		0x26
> +#define T14S_EC_EVT_AC_DISCONNECTED		0x27
> +#define T14S_EC_EVT_KEY_POWER			0x28
> +#define T14S_EC_EVT_LID_OPEN			0x2A
> +#define T14S_EC_EVT_LID_CLOSED			0x2B
> +#define T14S_EC_EVT_KEY_FN_F12			0x62
> +#define T14S_EC_EVT_KEY_FN_TAB			0x63
> +#define T14S_EC_EVT_KEY_FN_F8			0x64
> +#define T14S_EC_EVT_KEY_FN_F10			0x65
> +#define T14S_EC_EVT_KEY_FN_F4			0x6A
> +#define T14S_EC_EVT_KEY_FN_D			0x6B
> +#define T14S_EC_EVT_KEY_FN_T			0x6C
> +#define T14S_EC_EVT_KEY_FN_H			0x6D
> +#define T14S_EC_EVT_KEY_FN_M			0x6E
> +#define T14S_EC_EVT_KEY_FN_L			0x6F
> +#define T14S_EC_EVT_KEY_FN_RIGHT_SHIFT		0x71
> +#define T14S_EC_EVT_KEY_FN_ESC			0x74
> +#define T14S_EC_EVT_KEY_FN_N			0x79
> +#define T14S_EC_EVT_KEY_FN_F11			0x7A
> +#define T14S_EC_EVT_KEY_FN_G			0x7E

Please use lowercase hex consistently across the file

[...]

> +enum thinkpad_t14s_ec_led_status_t {
> +	T14S_EC_LED_OFF =	0x00,
> +	T14S_EC_LED_ON =	0x80,
> +	T14S_EC_LED_BLINK =	0xc0,

These conveniently translate to: BIT(7) and BIT(6)|BIT(7), meaning
BIT(7) could mean "ON" and BIT(6) could mean "pulse" (can you pulse
a disabled LED? arcane secrets..)

[...]

> +	if (brightness == LED_OFF)
> +		new_state = T14S_EC_LED_OFF;
> +	else if (led->cache != T14S_EC_LED_BLINK)

==s are easier to logically follow than !=, but this is totally
potayto/potahto

[...]

> +static int thinkpad_t14s_led_blink_set(struct led_classdev *led_cdev,
> +				       unsigned long *delay_on,
> +				       unsigned long *delay_off)
> +{
> +	struct thinkpad_t14s_ec_led_classdev *led = container_of(led_cdev,
> +			struct thinkpad_t14s_ec_led_classdev, led_classdev);
> +
> +	if (*delay_on == 0 && *delay_off == 0) {
> +		/* We can choose the blink rate */

"can't"?

Needless to say, amazing work on piecing all this together, Sebastian!

Konrad

