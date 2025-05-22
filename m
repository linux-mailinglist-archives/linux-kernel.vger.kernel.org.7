Return-Path: <linux-kernel+bounces-658891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F69AC08CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057777A9627
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9692686AF;
	Thu, 22 May 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdjhgICS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7B33DB
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906444; cv=none; b=ZB1AAXxqXeqCzKnsyGdfXAKB3wS6ViaLf2MW93LLdN02kRsSy+mta+o/hl8EPMPcIN2byKFX3kXHTxsClWroqQewFetwSdfh1/7+c5W9SfNpDdrCIsH4QOKyjVfhliP0tMZ7iWaTYRsy7Kb1cgu7ZRY2lY7h1NxTRmgdLpl0yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906444; c=relaxed/simple;
	bh=IeWvAPVEMFtpImN+Yt1ANjjn9pzp+9u7+czvGa0vC8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+8zE7LJ2iebHrYMn26PIrckB/QBRVvHm8dln/nbLlF7CWvx1oLG7WHPI5XC4Q27L3QQX11GhViQi9SqrWBG45HY6TaiDjiWQgUN/XxQTnx8neR252Vs9cIKbzuV/EGV5A5tIUEctSDlsj9eten4Q0I0ueya/sfrp91HgvqjDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdjhgICS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747906441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qw5htR4aFouNXqUNydnWVXW/XvwaR6GrPFxdac2GYo=;
	b=RdjhgICSwar4/nhNUwlZQNZ7bgRLMprVSSqFmNI3GRjAb0VFSB+Ert6n/hVrRBlQw5c9+F
	udh83w+Y3gAjO6EKI5OzbEfx0KL0USl0lHDRLe6IgP/gVZa9R/hWweHP9/IT6rkm8WVJXK
	gTvbHM1j9tDabiMkqgUK/PlYoYofbhM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-kps5cj2bP42R-0SpfJe47w-1; Thu, 22 May 2025 05:33:59 -0400
X-MC-Unique: kps5cj2bP42R-0SpfJe47w-1
X-Mimecast-MFC-AGG-ID: kps5cj2bP42R-0SpfJe47w_1747906438
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad5271a051eso673111966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 02:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747906438; x=1748511238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qw5htR4aFouNXqUNydnWVXW/XvwaR6GrPFxdac2GYo=;
        b=Kv+6pqDeisQHv6LHAZSiKCbdLIS5QMnpyaMeM2Cbp2DYx1SNVZjla9xyNbwXhy0zeq
         x1DfGbLBPCZsDADwUV76S1J1e6OW84qvNa6ZZw2M663x+++p4FBstsJx8JqMeHTVOf2d
         qOoRtbynCNZS3T85kgcTRuCu0kPZMhvNhuD+oLuwRDDGSodbbO6fHmAXZa8De2yOFcWc
         twcji+l+qF0vN8447SWlhx6opmKmwloJYOpMWH2IKeSi6LILl2Qk3BuqZq3rVi7IgeAn
         0WYM13bU/Ew977u6RUUgP5FdtTKEPh++1D51kVjX8/tqbP82dzyyq3jwCP9RhJreXLfg
         6jeg==
X-Forwarded-Encrypted: i=1; AJvYcCVc/DLtVrfRIllYJ3NEpB0bw0yh4i2c6gwLYZz7VEe6MQ6Fl/SPWOC7xBj3y08cIjOoxyweA9kGX32TYcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/7emvbvB/nuIbVTFAfQJcxTwFQW5mKgq/i/euNyAriGAcaqT
	o8TVWpUvdVRCK7ZUzTpkQ4jZUA8yniKdpfXLgnJpP2VWJl/K4Ng6RTkhRCZJhyzkKZl4XJ1tHj6
	ugsKBpITUaRb1uGTYSz+HZfA+cAi8bDJdy21MePoCxQGku+xR7dmU5L36cZ8C49eFmg==
X-Gm-Gg: ASbGnctJ6f+tKgSQqxWKFBGIvg/QqwaVDOAPT/65YbgE/AUz7lpSxV74yTcZ/rdaxDg
	AnmpMuKhhrdqRZ3BW/Ei5X5VeDCSgUe/51KKb5V5pq1YQffwHgFacCgcTUPfhs9JjijGvUwCCpI
	fwahQWnBnJ+5M21r+K5zcSkWgpRcRHq/Lo07TmuYzoq4jzq550SCwrPMpbaMal5SLS5Zxj2HNe/
	lonWKVtYhmnqSwhQA4vOgcfio8NHvkwOEe4DVztYZSQzn4+8WPdf+XQqSHI1Rsq0oeVj+Jqksct
	APYtSG+3kHSZPmZ3FHoulooV6R8fijORIrUdWpSW2Fwefdqb9OV1yvN3r2/TAVGvj+hqWy/g+uV
	mqq9/GGe3WjERF/nDf6B7Abu33JAnf/gOLynjW9FogljlT++XqhzJ9abSA7RvzQ==
X-Received: by 2002:a17:907:7b9a:b0:ad2:4fa0:88cf with SMTP id a640c23a62f3a-ad52d4396c0mr2068019966b.6.1747906438485;
        Thu, 22 May 2025 02:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu2Ay25uSAQ6hLo4W2TLsFIMynNeIwiRl7bKkjJAgZCl44ZiZ8js3VMO+FT3OyfPCfONvxOQ==
X-Received: by 2002:a17:907:7b9a:b0:ad2:4fa0:88cf with SMTP id a640c23a62f3a-ad52d4396c0mr2068010366b.6.1747906436059;
        Thu, 22 May 2025 02:33:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d2779b9sm1040295666b.81.2025.05.22.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 02:33:55 -0700 (PDT)
Message-ID: <6c34ee2e-f2f5-43f9-8e41-03e64c62f830@redhat.com>
Date: Thu, 22 May 2025 11:33:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] LF-15225 input: goodix: add poll mode for goodix
 touchscreen
To: Joseph Guo <qijian.guo@nxp.com>, Bastien Nocera <hadess@hadess.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:GOODIX TOUCHSCREEN" <linux-input@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: haibo.chen@nxp.com, justin.jiang@nxp.com
References: <20250522020418.1963422-1-qijian.guo@nxp.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250522020418.1963422-1-qijian.guo@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-May-25 4:04 AM, Joseph Guo wrote:
> goodix touchscreen only support interrupt mode by default.
> Some panels like waveshare panel which is widely used on raspeberry pi
> don't have interrupt pins and only work on i2c poll mode.
> The waveshare panel 7inch panel use goodix gt911 touchscreen chip.
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> ---
> Change from v1 to v2
> - Remove unused variable in goodix_ts_data struct
> - Use polling infrastructure
> ---
> Change from v2 to v3
> - Modify goodix_request_irq to make less diff

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/input/touchscreen/goodix.c | 43 +++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index aaf79ac50004..8e72174f486d 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -47,6 +47,7 @@
>  #define RESOLUTION_LOC		1
>  #define MAX_CONTACTS_LOC	5
>  #define TRIGGER_LOC		6
> +#define GOODIX_POLL_INTERVAL_MS		17	/* 17ms = 60fps */
>  
>  /* Our special handling for GPIO accesses through ACPI is x86 specific */
>  #if defined CONFIG_X86 && defined CONFIG_ACPI
> @@ -497,6 +498,14 @@ static void goodix_process_events(struct goodix_ts_data *ts)
>  	input_sync(ts->input_dev);
>  }
>  
> +static void goodix_ts_work_i2c_poll(struct input_dev *input)
> +{
> +	struct goodix_ts_data *ts = input_get_drvdata(input);
> +
> +	goodix_process_events(ts);
> +	goodix_i2c_write_u8(ts->client, GOODIX_READ_COOR_ADDR, 0);
> +}
> +
>  /**
>   * goodix_ts_irq_handler - The IRQ handler
>   *
> @@ -523,13 +532,29 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void goodix_enable_irq(struct goodix_ts_data *ts)
> +{
> +	if (ts->client->irq)
> +		enable_irq(ts->client->irq);
> +}
> +
> +static void goodix_disable_irq(struct goodix_ts_data *ts)
> +{
> +	if (ts->client->irq)
> +		disable_irq(ts->client->irq);
> +}
> +
>  static void goodix_free_irq(struct goodix_ts_data *ts)
>  {
> -	devm_free_irq(&ts->client->dev, ts->client->irq, ts);
> +	if (ts->client->irq)
> +		devm_free_irq(&ts->client->dev, ts->client->irq, ts);
>  }
>  
>  static int goodix_request_irq(struct goodix_ts_data *ts)
>  {
> +	if (!ts->client->irq)
> +		return 0;
> +
>  	return devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
>  					 NULL, goodix_ts_irq_handler,
>  					 ts->irq_flags, ts->client->name, ts);
> @@ -1229,6 +1254,18 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
>  		return error;
>  	}
>  
> +	input_set_drvdata(ts->input_dev, ts);
> +
> +	if (!ts->client->irq) {
> +		error = input_setup_polling(ts->input_dev, goodix_ts_work_i2c_poll);
> +		if (error) {
> +			dev_err(&ts->client->dev,
> +				 "could not set up polling mode, %d\n", error);
> +			return error;
> +		}
> +		input_set_poll_interval(ts->input_dev, GOODIX_POLL_INTERVAL_MS);
> +	}
> +
>  	error = input_register_device(ts->input_dev);
>  	if (error) {
>  		dev_err(&ts->client->dev,
> @@ -1435,7 +1472,7 @@ static int goodix_suspend(struct device *dev)
>  
>  	/* We need gpio pins to suspend/resume */
>  	if (ts->irq_pin_access_method == IRQ_PIN_ACCESS_NONE) {
> -		disable_irq(client->irq);
> +		goodix_disable_irq(ts);
>  		return 0;
>  	}
>  
> @@ -1479,7 +1516,7 @@ static int goodix_resume(struct device *dev)
>  	int error;
>  
>  	if (ts->irq_pin_access_method == IRQ_PIN_ACCESS_NONE) {
> -		enable_irq(client->irq);
> +		goodix_enable_irq(ts);
>  		return 0;
>  	}
>  


