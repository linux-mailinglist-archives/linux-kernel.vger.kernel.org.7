Return-Path: <linux-kernel+bounces-802618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1EB454B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15807560DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C892D5C9E;
	Fri,  5 Sep 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVNaZ0Md"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A11296BCB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068040; cv=none; b=ARllHXevZhJHshxdZkyXD65XbIPx2EimQGPXxhuklIlsRVF4VnYs5SUTPcmQMQuWVvokzt0CFTBUuVh/GkQ9cT+DwjnEXilSr8+woSj/7F6wsZwHNJcrmcdGfRrMXBXa5MipHEvHFuHe6RmeWaxaCLra1BYPF/p6/+xdgcICTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068040; c=relaxed/simple;
	bh=sUEiAJrOLuvgwU8MPeRFCsFvIjwbrUnWFq9tNJDXl7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lukGhCAxK0Rq5C/AvVjt19J36apQy5TtTraRBOIXGhWmAkACZJ+An9kRciZYwjW4LSlcZZ0pexOPc2s8fXtkDxeQ391ASvOD9CMbXQqdcrZBT31KS4CiX6ihTmts1L88MVGVuDd9nngkY7TugVFICO/pDgIzYB/NhjBU+A0q8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVNaZ0Md; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857ae2t008316
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nKlclxedMJXaamSvpbOzBwOcBlOQHWIWmhDC0gUJg8Y=; b=kVNaZ0Md1Hflj1R6
	Tr59lF1SstQgFyY/XH7byCtFs+wsqaS1fw9QlnLv8v/QTfYaA7H3+AoypfbcPeIA
	UMlURKWm1k7UMF8U2d9R/idrljC4WCsWhbLtcIMWaDdHwUfgxmrrdxY2K9j573uf
	Wo9S3oYOey2/a8w7//3hdiLRoIfuxPpA10J0V6PCTA3A8g6VBYcL9Lta7pLfnPPP
	gplyWAnbApdGbFLfAmyfzlztV8hGSKaWtOVgxW0YZ4VsEsnasYnRM0y0upYOaH5x
	HelSZVEvoRpI1sZ469nAY94DaB63AOMpxZK0RZjJjNxuGf8MCFcqIOFLBB8wlESy
	R4ebuA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjtqxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:27:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-721eb9fecdcso4446886d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068036; x=1757672836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKlclxedMJXaamSvpbOzBwOcBlOQHWIWmhDC0gUJg8Y=;
        b=B+bl3280RN6j/5aNuOcVcKkqdNFaY3mzcbRMjb4BqKWxwiIDAXCBYUj12vasIMETzt
         9r3wMpB1Y+7eozY8kxgySwFGPj7+9VxyKPmzxCTEi0MDJpq0LZewvBSx4QBtUAcG1Erv
         R3h9Ql5fPulKBu9Hwd6FsvUkKyCLlOLKkD2aGw92MEF8e85RA2zDBu0TT+S54db906wO
         bRGhRophSK/J7pkhUeWl+mJJ4WRraCFdGSPQqV3dL4Iq+HgSG8do6W7nYUx5fySJVoGF
         QsUcQ1M4+pHiPVQ6seaoTW1KrAiT9nQHrst6ptBf3/Y0FeHwQfLdnzbnYrJB4XWOVrQG
         T26Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDI1OyF3S73dHPO1KDs1MoyHqI1dcDpwrhrDzfYMmeBl8tfp6RjCEURZkrn883oXIO2wY+ZiPjmr+jmNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXpvG/bsbJte7lbzzQHavZ8zxome3NJvPQCJZhELJVXDd+9M1e
	8f5Trn3QVkTjDEtV/SgzJTPpTtA65aNtWQWapOBs/xXLUpATODA7qtUZqp7fmiAGamQ3xvfNx64
	d9ZveKtxJO427+pEYjAhDrMaRn6L3rKkp/mM5rAycZ1KTUv9nltR2boljzW6r9uyn7Eg=
X-Gm-Gg: ASbGnctcYlvmYA7Dx7Uut6gXZ23l9YIspsahwxGwYpetZfvsL9xSAQ6PFv+9SOSR5Oo
	pZKyQTMfd5wLuOs30V2nk4f2hn57BOYrUXOJo/ny5UsRoaqYwtr40POioP7tEZn0MPIXzwQXNbp
	5pHDlWEgyP889QOv3LJL/Lh2DOtdFpr/42wF+WB0Rn25gtHKDuL6sU85MFqQmnqL1Op0+nYdPWw
	HRqoaQpE7qVy+IQgQ+gWC63klNiuqpVaqZs23NHhbAPZbAC83Co4e0RnV+05NcdERLG50fff/dH
	oshIvxzp6NTP+H2tUjlWNo09XpCNnboQ52gygmLbcoJgIyhLsc5YkWNrMaiHbK4cu/N3ShZ8XEM
	3NkmW8bHsCibUkY2EZ8lxOw==
X-Received: by 2002:a05:6214:dcf:b0:731:e63:4d5f with SMTP id 6a1803df08f44-7310e634e4bmr5342316d6.0.1757068035661;
        Fri, 05 Sep 2025 03:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENys2w9y89EnmRAiC2GvAWr1Ii/s0kJct67QLdVLXitDIodzxUlw0kVgyoYfpcuT9cqJso7w==
X-Received: by 2002:a05:6214:dcf:b0:731:e63:4d5f with SMTP id 6a1803df08f44-7310e634e4bmr5342016d6.0.1757068035151;
        Fri, 05 Sep 2025 03:27:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm16033862a12.44.2025.09.05.03.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:27:14 -0700 (PDT)
Message-ID: <4913e5eb-c7bc-4c77-ab2c-b0452e9b495e@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 12:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] platform: arm64: thinkpad-t14s-ec: new driver
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
References: <20250905-thinkpad-t14s-ec-v2-0-7da5d70aa423@collabora.com>
 <20250905-thinkpad-t14s-ec-v2-2-7da5d70aa423@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905-thinkpad-t14s-ec-v2-2-7da5d70aa423@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68babb04 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=l0D_vPNz536yW1AJoQEA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TOC3ToZ-xCiUuBnCFHGOhNFsebJrQj7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX8L8Yus7vy+/V
 HhJ/yoWff9eeWH6pRpT3vtFbU7gTVKvm8K8MFQBNKshnBg7JEYy+jOnSuwV3h8WWU+UcWcktfgk
 Uh7wtIajdEgAUCi6bnEuZ3jHfsQzB9PZfrBdxqFvhdSMKIVllAL/6/mGn0Z8A6p+V93HXL8Ko28
 aJK+iljIEBmtqnmcxgS+I0zv82N6MOExc7HgkZ+61P8TsmRhe2MfhOlcBP75UIWFhMhwdnmfaj3
 JzoTYyRYDCWMjq3Xr6/+loEAIvGgT5tgdeaInBsBPoDFyi+EgKvUJDcZLWlvB8VkIFeeb32JIjf
 4Aym9UP/bdp0WcmI/ABCe5jCJ6eAPCSzB0OVwww4JQkQ3/TLFWElDosZIV1lZwriXQIen7FZXmE
 X6m/jWc1
X-Proofpoint-ORIG-GUID: TOC3ToZ-xCiUuBnCFHGOhNFsebJrQj7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/5/25 3:09 AM, Sebastian Reichel wrote:
> Introduce EC driver for the ThinkPad T14s Gen6 Snapdragon, which is in
> theory compatible with ThinkPad ACPI. On Linux the system is booted with
> device tree, which is not supported by the ThinkPad ACPI driver
> (drivers/platform/x86/lenovo/thinkpad_acpi.c). Also most of the hardware
> compatibility is handled via ACPI tables, which are obviously not used
> when booting via device tree. Thus adding DT compatibility to the
> existing driver is not worth it as there is almost no code sharing.
> 
> The driver currently exposes features, which are not available
> via other means:
> 
>  * Extra Keys
>  * System LEDs
>  * Keyboard Backlight Control
> 
> The driver has been developed by reading the ACPI DSDT. There
> are some more features around thermal control, which are not
> yet supported by the driver.
> 
> The speaker mute and mic mute LEDs need some additional changes
> in the ALSA UCM to be set automatically.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---

[...]

> +#define THINKPAD_T14S_EC_CMD_ECRD 0x02
> +#define THINKPAD_T14S_EC_CMD_ECWR 0x03
> +#define THINKPAD_T14S_EC_CMD_EVT 0xf0

T14S_EC_ is already a good prefix, imo

[...]

> +static enum led_brightness thinkpad_t14s_audio_led_get(struct thinkpad_t14s_ec *ec,
> +						       u8 led_bit)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(ec->regmap, THINKPAD_T14S_EC_REG_AUD, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(val && led_bit) ? LED_ON : LED_OFF;

&& already returns a boolean

but I think you meant to use & here

> +}
> +
> +static enum led_brightness thinkpad_t14s_audio_led_set(struct thinkpad_t14s_ec *ec,
> +						       u8 led_bit,
> +						       enum led_brightness brightness)
> +{
> +	u8 val = brightness ? led_bit : 0;
> +
> +	return regmap_update_bits(ec->regmap, THINKPAD_T14S_EC_REG_AUD, led_bit, val);

regmap_assign_bits()

> +static int thinkpad_t14s_input_probe(struct thinkpad_t14s_ec *ec)
> +{
> +	int ret;
> +
> +	ec->inputdev = devm_input_allocate_device(ec->dev);
> +	if (!ec->inputdev)
> +		return -ENOMEM;
> +
> +	ec->inputdev->name = "ThinkPad Extra Buttons";
> +	ec->inputdev->phys = "thinkpad/input0";
> +	ec->inputdev->id.bustype = BUS_HOST;
> +	ec->inputdev->dev.parent = ec->dev;
> +
> +	ret = sparse_keymap_setup(ec->inputdev, thinkpad_t14s_keymap, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = input_register_device(ec->inputdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

You can return input_register_device() directly 

Konrad

