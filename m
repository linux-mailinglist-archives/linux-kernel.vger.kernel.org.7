Return-Path: <linux-kernel+bounces-739146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1FB0C25C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9953A45F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787AA2989B4;
	Mon, 21 Jul 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3yCEvZ/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897112980D0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096433; cv=none; b=ez6ia+XC5rm9kkiY4WeB1w9h4rtvO2TA/g9N6WH6+3gprDlB2IxQ+cME/z/1jO5PM8Fkzy7rUAVumLU8Eah9JjTiCKAzfwcmG9l1TncPXo8UJJUATozCWFkce0AvfsdeIezfV2VuqICl8L2w/4/oTmLRbERRXP99+JSROlyL6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096433; c=relaxed/simple;
	bh=3LePUhZLqMHmMSA1GfKcOrJBLnHS9teMOpXWN0q2aMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX0IU39W6e3VRtfEty1C01q+Vxe7ZjcPIfin5EzhLFPoXvBA52ncjsPz7bMTeUKlmFnZxmYs8XzihNUcbGkazsz01JFrnaWjrsFIVqt6BQODRltnZyDurZbnTJwdzQXN4OhRM33SgpyXw7ZPi7Hds1VR4qlSX0k7G6z/u0wIfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3yCEvZ/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2436329f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753096430; x=1753701230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCpk9GjmCqOqyvs+4Z7EUdmuqAEP2pxTsgkUzsyKDEo=;
        b=K3yCEvZ/DbLZYArDvEFschm5fG6TaXd8DDVie+6xzKntLEHLI50c92iV1XvGo/Us/G
         YIGoG0XHQJ8sShww3CwVnfdJeWTs3cbYiHWqsZJzT0vc0V28hXKGoswRBQOIT7A9gAu/
         eqfSk+5iGhP1jbfWlsazv28vw1HgAYRyvddIsBhdHW2MNtcdZ0MfSY0xE1DF4+IrchNp
         XMo8lto8Uym1MQ17aBusYX10uuv3gP0xfIrUyM9kypeCFsuwyUG7GYGBWKOFqnK/kX2w
         oVc8zYWRxQs4/qGLEvT8wMbuyhce06N6uTqdmdoBMxn4fLIk1BR8CyuTKMnxaqfTCk5f
         Jv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096430; x=1753701230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCpk9GjmCqOqyvs+4Z7EUdmuqAEP2pxTsgkUzsyKDEo=;
        b=Nbgu9qXbAjEJrYPiX8hNU4uSEzHbrmoJGldCHLS/Ogu223gNWRYKjdYqYWVEdY4Hsf
         pk2DmZSExDPgUPuKDNsexUwqtP0xo4fY59DMUW7UOh/jkI17GxO56evjO4GBBEAJ5Brp
         1AT7VSPhqYJBFCOviJseLU+4kFJIs8HlXV/0vw/DhqlQQ0WuMga3mgrQ5tRV0Nopl+QW
         Rws2NL6B78a7yI8pmP8zCVqpVEvdjVijmdxMTw6CGm4rBIjDFZS96+4BHgpEkO1jk1ZN
         +KpjewiPWgORsE19QWsim+Dk0DptnP3eYb3fu2S2529a5ABwdit8e3t9t525bT2WWoKn
         PyIg==
X-Forwarded-Encrypted: i=1; AJvYcCXPMDo+0fnXJQV/HPLgDA8vnf+FtgO0L9VGvLK+d6hVQDwTcRHmX3OvBcjTZbK86TzXQRL0PwkfQ28Ekro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoMgVvMw5PQoRJh1ss1bBGI3Q46qYAJjXfZfDg/7oiW0eD4WP
	xhb/BD+LlA+5HBp+mNGKVY9yOADquCgK0XVtWjFBYxlkVNeIeIMOKXoClPlQ432wuZw=
X-Gm-Gg: ASbGncv7Eb/mmfDS1rCzuCW7RYsG6fymJayy/vvudPQlgfPrqSf7du8VE8elcPVxdZn
	apCbfBP/2+NQCiDa9G99IQb+oXm3D+UgxmGj5+CXL8RixOqFg8gHDuv8EBxe07sNGUPkYs3IA14
	DDtF3vce3Uf3VEu5TUkgcL5MqpnNwcLQc5pD+rPXEWOah06EjpamZO3VipSX56qLtqRHIbFdXsX
	bQnozKKkhNSovQR9vzI1C7KJNv1Wa0yUf/tU9RqWPQRp0QDAThzpfP7/HHK3xBeuIrf6WFehQej
	XYYrmaMnaUB0S/YA3atdLHC1JNn37Zae4TFbxuNY7AdB6/JfVLNf8XbqW8zNRkC8qZAb2jDK1L+
	z56mXim13OrFJ/WiLPAILs54djtfZx0OxwGRI/qF52Ro8wrfXzXHxYO1/oJv9byE=
X-Google-Smtp-Source: AGHT+IGphSZ4nqGy3QQspzTFvacskBSUZG+3aCT88SVK0C+HxQ5ng+J8deaVhU6sjyoaTxsnS6cTNg==
X-Received: by 2002:a05:6000:144a:b0:3a8:310a:b1dc with SMTP id ffacd0b85a97d-3b60ddc64e3mr16113819f8f.56.1753096429728;
        Mon, 21 Jul 2025 04:13:49 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c9e2sm10284808f8f.89.2025.07.21.04.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:13:49 -0700 (PDT)
Message-ID: <b38accf6-c7f5-4728-9507-2d380207935f@linaro.org>
Date: Mon, 21 Jul 2025 13:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
Content-Language: en-US
To: y.oudjana@protonmail.com, Manivannan Sadhasivam <mani@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
 <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yassine,

On 10/07/2025 10:06, Yassine Oudjana via B4 Relay wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a driver for sensors exposed by the Qualcomm Sensor Manager service,
> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> include accelerometers, gyroscopes, pressure sensors, proximity sensors
> and magnetometers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  MAINTAINERS                                     |  13 +
>  drivers/iio/accel/qcom_smgr_accel.c             | 138 ++++
>  drivers/iio/common/Kconfig                      |   1 +
>  drivers/iio/common/Makefile                     |   1 +
>  drivers/iio/common/qcom_smgr/Kconfig            |  16 +
>  drivers/iio/common/qcom_smgr/Makefile           |   8 +
>  drivers/iio/common/qcom_smgr/qcom_smgr.c        | 840 ++++++++++++++++++++++++
>  drivers/iio/common/qcom_smgr/qmi/Makefile       |   3 +
>  drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c | 713 ++++++++++++++++++++
>  drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h | 161 +++++
>  include/linux/iio/common/qcom_smgr.h            |  80 +++
>  11 files changed, 1974 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5a472a544cfe2ad87691209c34d7bafe058ba42..0fb91c9bce431fc899776ff10b728ecdc957f51a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20702,6 +20702,19 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
>  F:	drivers/net/ethernet/qualcomm/rmnet/
>  F:	include/linux/if_rmnet.h
>  
> +QUALCOMM SENSOR MANAGER IIO DRIVER
> +M:	Yassine Oudjana <y.oudjana@protonmail.com>
> +L:	linux-iio@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained

Missing drivers/iio/accel/qcom_smgr_accel.c here

Kind regards,

-- 
// Casey (she/her)


