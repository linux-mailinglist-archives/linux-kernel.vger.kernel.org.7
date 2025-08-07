Return-Path: <linux-kernel+bounces-759012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB0B1D70F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EC07245F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2C20B7F9;
	Thu,  7 Aug 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="GoxZJoKs"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9443202F71
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567743; cv=none; b=Seh4yzA7YYGvAeVJkn9QQZYhrCvlaaQaDuvOAOcLhscF61uJWou0US99DCExiOQqCm8P6ONZlm5oGjthohjOVzOkznASX+jEOEC4MnjcnflzAZ/TLOq3MVH/yfo6cbwHVOaI9aopGcp1X16HHEkMvzYBnrRL+aB+v6JpDDtKqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567743; c=relaxed/simple;
	bh=lbQa2W/bR/FxgQYKWNOpVN+CNFSYZp4dz5+1eJ3QlwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUsuie0naA6qEXYFvz6cEB9TvpEarXeg26yUrrgjTcvSo3sP/QeZiVODDt/IGuWZopBh0zTisQnLodeA06/xBX0IDdA+ox5RluS8VjsK7JxxB/Eb46URs2KYt7rfJ29rycXuOFJxUj/ct73vJ4JAVrgg/TPrE65Rn+tO2Kdnbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=GoxZJoKs; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-883e1de0606so24314039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1754567741; x=1755172541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDJav/l0x6TJpNlmvipxLhkS/rO66KRXVU4Ugz2QqFU=;
        b=GoxZJoKshEFl8gLIRebbM6HSl5anMwEqEvlkaMze8TBZwwle4ffslpshcfcHisBGEZ
         LQ9nRor4n2KanNUDAOv7V/eVDmDT+LQvodaeSEzrjvxdjkV1wtLvVvi35Z2epvgJyopg
         MJXNd6mNw7TJYgVVSSfYQvvWKUUhLlsk7LOTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754567741; x=1755172541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDJav/l0x6TJpNlmvipxLhkS/rO66KRXVU4Ugz2QqFU=;
        b=PJp35Csk9rphKpQHFOiGO1r45XDptteSS+VmmU3RPQAvXXUIt6/6/gUTVjlA7HTcbW
         77AaxwPnoq+w8/h3NZ1mdTKWW1I6CVNTaJSHH0nmpFT2t7dvzrsDoUZgbVOWABqrh2Dr
         CEECNezOvJvpXSxk5dcK633M92TWbYUdFgpr8yUDJxtH5Qzo9JU/rVB3nWFVMAGovcOR
         qfIfF9q0GZMEzylqEAcQoDUCEu6mjDbJNdGzRW9fNrJ/sHw5HGKfpFbsvKKuRP3JwzM1
         EGxxFYRUL4C03PH/Gpr9PGCqb58ojQ48t80prQizwNPm5MorZRNTA65AqKbf1qxA/VHA
         i16w==
X-Forwarded-Encrypted: i=1; AJvYcCVn8kO/ArWFHskft6SmxxlcQYRErchYKqAtkz3MnXwWWO7aPx1Z5B1UasXV/0WVW4arYIdqP8SfPxxx6BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHqzpUgaPqOwPIiJpVIbo5igzur0f9QWMrqGiQ189E9L1dSC8
	sKVbEbELRAH85qYFzHI68Y6BTHhBfZmaS5bosUa5LPtjJZ03tkNVzJ/CvNKm4cd0Tg==
X-Gm-Gg: ASbGncuY8jaPpPD97fz4G/loe3CGUmZI8ucp/RqZlXuBlJ9yRI332lm1CJUh/q3S3zZ
	PpCSbTJKF9wufdW48wbT/FEy/uv9DBd0lrkv9J1hKQd8yxPJo80/S6AN1oJAmW27FfosmqFnlte
	C6+lMTgERlGJiU3VibJ4z+94W7KbIH3yx333ZewLULtNE4AUJwP+rbzzdPEvR6T0NRCUvNsgLDK
	tClLDZ48hdOa9KxXTLO7K2RxqbIGIMA55HjlM+6dqs32HNCTke4beRm2Jq0m48yCLquBC1/6ker
	3q7DZ4ADQtI4VILoZeejA5kTcEHpRbf0te8Z57tuhO2Hfqlog5JEpyQeUkqoImU0SblLLBQbf/q
	2Jfy63UpMZ7bYzORTT2L1mJzhD6X4Dw4C5EELKExvmZNDAegY5X/NIhtq
X-Google-Smtp-Source: AGHT+IEtBJjhUCVSUlXC+oL0iY/rk/JMAXniUp/7F2ZuuNi14gQDrMaDUSgLUnyC6w992pz9L32QZw==
X-Received: by 2002:a05:6e02:1a04:b0:3e3:f8c4:2bcf with SMTP id e9e14a558f8ab-3e51b882290mr102842575ab.5.1754567740689;
        Thu, 07 Aug 2025 04:55:40 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3e4029d41a6sm69781285ab.24.2025.08.07.04.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 04:55:39 -0700 (PDT)
Message-ID: <81913369-783f-4e7e-8172-41f808537b3a@ieee.org>
Date: Thu, 7 Aug 2025 06:55:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: svc: use string choice helpers instead of
 ternary operator
To: Nai-Chen Cheng <bleach1827@gmail.com>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linux.dev
References: <20250806-greybus-string-choices-v1-1-3e1c91048b62@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250806-greybus-string-choices-v1-1-3e1c91048b62@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 1:27 AM, Nai-Chen Cheng wrote:
> Replace ternary operator with str_enabled_disabled() helper to improve
> code readability and consistency.
> 
> Generated using Coccinelle semantic patch.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>

Looks good to me.  Thanks.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/greybus/svc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
> index 4256467fcd35..35ea7147dca6 100644
> --- a/drivers/greybus/svc.c
> +++ b/drivers/greybus/svc.c
> @@ -10,6 +10,7 @@
>   #include <linux/kstrtox.h>
>   #include <linux/workqueue.h>
>   #include <linux/greybus.h>
> +#include <linux/string_choices.h>
>   
>   #define SVC_INTF_EJECT_TIMEOUT		9000
>   #define SVC_INTF_ACTIVATE_TIMEOUT	6000
> @@ -73,7 +74,7 @@ static ssize_t watchdog_show(struct device *dev, struct device_attribute *attr,
>   	struct gb_svc *svc = to_gb_svc(dev);
>   
>   	return sprintf(buf, "%s\n",
> -		       gb_svc_watchdog_enabled(svc) ? "enabled" : "disabled");
> +		       str_enabled_disabled(gb_svc_watchdog_enabled(svc)));
>   }
>   
>   static ssize_t watchdog_store(struct device *dev,
> 
> ---
> base-commit: 7881cd6886a89eda848192d3f5759ce08672e084
> change-id: 20250806-greybus-string-choices-e6d53d2382a6
> 
> Best regards,


