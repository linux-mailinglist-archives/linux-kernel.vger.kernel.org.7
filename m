Return-Path: <linux-kernel+bounces-822183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4AB833D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46B53A8157
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD672E7186;
	Thu, 18 Sep 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FD0ZzwnZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B212D73B8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178809; cv=none; b=NkemCNWWiwZbkIQ8XZP7QKgIu21f5e4NYwO6vIqhRoZdRQ9+yLJDJYZnRrQjKNy9B6Oungi+cpw3MMznGb6bs4iqTYyfdwP6WmvB1w78Yppr7xP/SlZLRlL6XhmCdLms7lQ2reIRCConor3F8RBJrkR/jbVUmorUBELRtL6Do2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178809; c=relaxed/simple;
	bh=dMPBMjcsgn8U8Ns064JVZeWP50Bq8MfymrupfdTqn3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmPrK8UqD64gzV1LsGcvDH9ivH5mGD5S+oNAKoBjSWEusMIUjeFgo7o0KIWsEjyGZenOLI1WF6FzkVFi9s26aQ1rhENmmyNxUXuOgWAV4kjbyOfPYVc/2QYwEtILVoAYqgIfw4fMjFHVthEH9E2uBq95a39FaemjfhtQda0Rs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FD0ZzwnZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6YMgi027215
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbWfmH/pC1nkCgbZSoU/uA31VLtZW7O3InnzSnNVGIE=; b=FD0ZzwnZ9FI5tSH5
	60sE1dFrl1ZPrFfJ5uI7jRgaHHl0uWXeRIY+wI0MxAVQ66fP4cGwJKZjyFeMFRtN
	xB3CDjO6ztTxOWvhK91CiNK9sq0Xtmo0VxWIfJ0Wg194uTKKZsPlXUqtBQUo4GdM
	dcRuMVQGJmySLA1vQvDdrFcFzvJQ+xUFQaubCSCTxF8sMiQsi0zGXuZdMMPgeFyr
	ETj4ZRllZguijOkmDS13EQIgYqeI8EB1NbRVA0EiZKntcIGv3KYF8aqaVqK64wmG
	MyeW2srrKdt7Kc/sKP04VmubzDI7zgCN7AXalJx1vgLW6Btj0Wzx3iKjdHi+2Nv6
	0QE3EA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jb88k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:00:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54fdfd5045so557991a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178802; x=1758783602;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbWfmH/pC1nkCgbZSoU/uA31VLtZW7O3InnzSnNVGIE=;
        b=vqna/VudyS36NlJW7eIaBt+YfZfy9YlIdQhW+JiwZ0yBmc5E63Kz3TvuRrLbO3jydc
         RnDOzzpGJQ3NdZvpHEo3iRXt5qz61/uJbniUgedD5yBV/XYKV3FmXpJdREF04ByHOo7D
         o7gIIxjv6fk3V55ZiA6DF7Yn+biNGeY5f9JiM3f6Znti8DBkwMV9isP2tTLuQK0DNYpZ
         ern7jSxiAHwVEZ0dqerqn1HDP70zJPeh1255jvU0jm3tYf8G6Ymb47gCRCROfoIiDJr7
         Vv6SJiPlosmuBjrWmojcrhZQpGFcb7HsDxnlIRC4ZmhxlNY5r3SI9wdfykg3MW8swaeX
         s6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBSu97rqQ7ysZHL8Zc1fOmUHFRVc6EkWdZKuoe6ILPHEkBuF4hC+jW9e6f0HYzW15dDNw2wDQqbkdtd/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTCOxIG3Jc4sUIY7jRXP6gfgxeXoOqT4ZuQtHiIXBikW2os0i
	EquliZRBwqMineKrEn3erqEeYT1IQxf00pqrQQsa3gKgVMJWKnqQsdTfRo56gfu+qmeXBfZMuiY
	aXtGoGXdOQ+UllCnyvZpKOIeicQlwAoOfDYmjIGkn3b2BZGY4iYH+8HdbEeNcRUxpxEs=
X-Gm-Gg: ASbGncu8CPx09epjzGHTnMVHlHSEKPDe6t03E7nA8ak3xDQKqw1dNChESbyCpNkjwZQ
	ZnbnkGlkDk1DwFvBcny5hhrnLt4Yr5VQSJ0cOZEUXN2yUFznF9GlyTGG0t/r28SdFsGlghw0t7e
	MzaH9w1Gavykh1yovuVQHe2cqsevVmcXOtYuVkpM9fucViHYVFsS1VNhgq3ak59ALrfNqW11k4U
	JNxmKL3igij81luzsXK/woK6pcqIS8MeHMPfllhFMpHhPNUtD6YxAgD50ogpLebnN7+jX1wV4Vb
	QjoBK143STDD5H/8Pz3jIzAtG1gyR4LbUdiFv+PDGp+oYIlbAH7/WxiF57IYT0vI60Lr3xPNN1C
	by7ruqS03NVDFK8N09zaiMrB4Yv7wC09UEKDa
X-Received: by 2002:a17:90b:3c8c:b0:32e:3f93:69e2 with SMTP id 98e67ed59e1d1-32ee3ef0806mr5833892a91.13.1758178801454;
        Thu, 18 Sep 2025 00:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqOU3X6jq0DY1ti5vQYDwFxJTrFdx2WWG+GVUcFRyYIyCcd6DpTKmCSc0wqBeP9DA1iegvZA==
X-Received: by 2002:a17:90b:3c8c:b0:32e:3f93:69e2 with SMTP id 98e67ed59e1d1-32ee3ef0806mr5833868a91.13.1758178800933;
        Thu, 18 Sep 2025 00:00:00 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607f0deasm1526418a91.23.2025.09.17.23.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:00:00 -0700 (PDT)
Message-ID: <e01fd1ed-0b7e-442c-9524-3248a9cb32cf@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
To: Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250808151822.536879-17-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sAU1EuVc8cUg0phg9pTyslbCJ6VOp60a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX0vjbfQPyG8mv
 /qIw+giM1kT15Hqhny1YxacaG/hfeqL+415pqlMklfA8xw9WDKN+3PaQN2t0Esnc/PeItQjTOoK
 lGna4rO6SqgmDicJFvmV6YPIm//Mq/j3ZQLdDFujs4MpU3froTVi5f5/9rllc9oNWB3hRx0DsMy
 JWOMSnWvYLy+H4rRPcSIf3pBF2Djclj18qdAHWZT0sYBfUuD29aTnCG3jperMiJEI55hz7HfRCM
 K6NOLYPTbnxiNbmteKUp6UskdZuMgSE9/ZNQjpHEQwk0nk7W1W7/xpn02aPq8VX8N35HiF1O4aA
 JQI+Ec5EVDBfd5ZgReFYDONB9bIY96QRHi6ahVgaKSiWJGfeAvQrQ1x2kVpmrepMBJ1JibwvnZo
 WD21x14u
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cbadf2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uLrbQztoRsBK_tCdPC4A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: sAU1EuVc8cUg0phg9pTyslbCJ6VOp60a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110



On 8/8/2025 11:18 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The leds-gpio traditionally takes a global gpio number in its platform
> data, but the number assigned here is not actually such a number but
> only meant to be used internally to this driver.
> 
> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
> 'gpio' number field is going away, so to keep ath10k building, move
> the assignment into a private structure instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ath/ath10k/leds.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/leds.c b/drivers/net/wireless/ath/ath10k/leds.c
> index 9b1d04eb4265..3a6c8111e7c6 100644
> --- a/drivers/net/wireless/ath/ath10k/leds.c
> +++ b/drivers/net/wireless/ath/ath10k/leds.c
> @@ -27,7 +27,7 @@ static int ath10k_leds_set_brightness_blocking(struct led_classdev *led_cdev,
>  		goto out;
>  
>  	ar->leds.gpio_state_pin = (brightness != LED_OFF) ^ led->active_low;
> -	ath10k_wmi_gpio_output(ar, led->gpio, ar->leds.gpio_state_pin);
> +	ath10k_wmi_gpio_output(ar, ar->hw_params.led_pin, ar->leds.gpio_state_pin);
>  
>  out:
>  	mutex_unlock(&ar->conf_mutex);
> @@ -64,7 +64,6 @@ int ath10k_leds_register(struct ath10k *ar)
>  	snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
>  		 wiphy_name(ar->hw->wiphy));
>  	ar->leds.wifi_led.active_low = 1;
> -	ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
>  	ar->leds.wifi_led.name = ar->leds.label;
>  	ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
>  

With 'wifi:' tag added ...

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


