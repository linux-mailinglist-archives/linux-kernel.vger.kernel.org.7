Return-Path: <linux-kernel+bounces-636500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC100AACC04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4D5078C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35F283156;
	Tue,  6 May 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zn6SuYO2"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7D285416
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551516; cv=none; b=unjFfG8zYBvCsyT6r0zlN+P32KBQJy8K+lO04NjnPuNViN8+OkrzUbwtctdja53vWbsBwiUaCh7Uc9c0Py/0c63RaTohDSQog8T4RyhQ4VJmZ7PtFr8JTBVXME2hbYrKHZKUnUHMjy78iItV0yF2T/PQ4A5incGKUjkDMvPyNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551516; c=relaxed/simple;
	bh=siIncqwNtWC6Cffe/UEzd4HGNlJ47tlCSk/EUKqczLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXVBjum3foncpb5s0t6ppfQVrJbKSVCFlNIy3siTQJ8o1NXI3MT+GTYcL/ka8j+N5WXn6UL3/AQfaH4//KP+EElOE6r8OIOMlHWASXZfki0cRhLYJgQdjDkv9wJRQdVM0K3Qjc2OeC3Xm4u+qcfiiTtffmpzxDK9HdigkPhmScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zn6SuYO2; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2da3c572a0bso3374548fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746551512; x=1747156312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JbcRvp94rGDw5RQs6ZrHCsYm6m5bJbU/CjzQthhb4w=;
        b=zn6SuYO25KPxYG7NvgFfHGAAy8u0YzIda67oylCmmgGmHc7VTYFjCsMchWMeA0ggMS
         aUzPClkzoId63tqud7CwrvzZeGw5T09zQOWTTaOkI9UbCjfA3o6uT65GqZ/y1eZRLbSL
         cUzovXjFtsuwWvtDo+M/bireKAoc/GMtvT02UwRowtxIoWiCVePDfvFYINvIFsXmWdq4
         p1LwsrW6TPC1GJ5nzt2uWlJPZ4DNjoW6VZhLvH/3ITAazcgI2HIOzZxrqV51cuLtyB4r
         YiptKMU9729MS2GpxMgXx+tCCINN2B9ik4CCQ7m7VskBCTkw17ZDqJr5dtmJiB2n5vPz
         sRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551512; x=1747156312;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JbcRvp94rGDw5RQs6ZrHCsYm6m5bJbU/CjzQthhb4w=;
        b=b6igMmuVyb06BFrI6QxAWJqJ2FYsVNb6mHhmwKJGg61kfG9RNcM1NlpG1KPksKe+Uj
         21TkbZPqy4dqPtEg055dvewoiZN2LZlSmpF2fcZTkLuDtlzqUYPpPvqeYfuCaqwBSFd3
         e+frX4TTYPPKadCDlKHfz4xW5L1/mPu+r/sFSjocp9ShEDLATxk7f1gOtXMPiq/iQhjs
         yncAOciJ245NLige51XQ1k99uompI7OpSNC7hwI9Hn72AoW0dFLCm7JwGvh298xuxHWt
         A0Qe+h2Li8BkDe750UhVPLbO3hewmEEo5m+u5OXJ+s1eOATGUGt4RhxXnlcY0IBWGd8l
         3TiA==
X-Forwarded-Encrypted: i=1; AJvYcCXZxbpgmPwi+XoLpJyb1hjyhzFbcNO+Dmmk1MYBF0WWTn8cZ6gmP21HHhxJhVtdcjd6ziGDbj/xBBEH+K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvjJzpSLQaGBfe2d2QjvAlJ7VUdvyYxz+yLj+ehizhhKdvY4X
	TA1l4MlaMKq+t9Vzuc736v4JIW3XH8Xt1JZ2nWBDHY2yOxeDcny+ShQ5ixqCTjY=
X-Gm-Gg: ASbGncv0BJBJgBPJaK78sJRcPkvcaqOq0eoDgOxkwh7V2MAJPpG7oDHR05QkKhUVb0L
	IsTM8K2MoBkma9twAjjbTF1Yv8d3mkWaefQeNPgudq9tOZpe394rIwmDk6nc/hPtuwMmy1WrdER
	l6QXUkkNriNUAMrQimoVtIY8iGuUNGUTMGQ4sDv0SyIydYykJS0QjUuzJegM6GWT7tdJgkkEAFy
	+fylGJOzYcP1vwlQcLHxHyU3b2q2iIQt7+0gqOBCpGdp9TckblvE4GgAMtagqhJ8dGQquW6sRbF
	fYAGTr2H9P4JDeumEt1y0fXSnXnLP4+MpeWokFP+Rk8pPC0WuqDGZRncNvc304w8H8UhAFn5wRG
	0cnzQcC12Ki3PVqCcilT2nMtSiegi
X-Google-Smtp-Source: AGHT+IGgVYJkjCCePqTNI6WyvbdrY2fuOkGm/ofTVtIR4HS2aq9wiljx2SuAeNHIIKo4f+OLxkBFFw==
X-Received: by 2002:a05:6870:4692:b0:2da:7e06:ed8e with SMTP id 586e51a60fabf-2db5bd83d78mr59453fac.4.1746551512329;
        Tue, 06 May 2025 10:11:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5172:9f6c:997a:41ea? ([2600:8803:e7e4:1d00:5172:9f6c:997a:41ea])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa126b848sm2816041fac.48.2025.05.06.10.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 10:11:51 -0700 (PDT)
Message-ID: <d0353f6c-8bab-4178-8bed-0ad6157fe351@baylibre.com>
Date: Tue, 6 May 2025 12:11:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: sensor-hub: Fix typo and improve documentation
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, jikos@kernel.org,
 bentiss@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250506163523.3262037-1-chelsyratnawat2001@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250506163523.3262037-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 11:35 AM, Chelsy Ratnawat wrote:
> Includes the following corrections -
>  - Changed Measurment -> Measurement
>  - Changed clode -> close
>  - Gyro -> gyro
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
>  include/linux/hid-sensor-hub.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 0f9f7df865db..3621d35a00d6 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -17,7 +17,7 @@
>   * @attrib_id:		Attribute id for this attribute.
>   * @report_id:		Report id in which this information resides.
>   * @index:		Field index in the report.
> - * @units:		Measurment unit for this attribute.
> + * @units:		Measurement unit for this attribute.
>   * @unit_expo:		Exponent used in the data.
>   * @size:		Size in bytes for data size.
>   * @logical_minimum:	Logical minimum value for this attribute.
> @@ -39,8 +39,8 @@ struct hid_sensor_hub_attribute_info {
>   * struct sensor_hub_pending - Synchronous read pending information
>   * @status:		Pending status true/false.
>   * @ready:		Completion synchronization data.
> - * @usage_id:		Usage id for physical device, E.g. Gyro usage id.
> - * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
> + * @usage_id:		Usage id for physical device, e.g. gyro usage id.
> + * @attr_usage_id:	Usage Id of a field, e.g. X-AXIS for a gyro.

I don't think "axis" needs to be all caps either. This is a numeric fields, so
it's not like this is a string literal and there is a dash in the name so I
don't think the intention was to reference a macro name.

>   * @raw_size:		Response size for a read request.
>   * @raw_data:		Place holder for received response.
>   */
> @@ -104,10 +104,10 @@ struct hid_sensor_hub_callbacks {
>  int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev);
>  
>  /**
> -* sensor_hub_device_clode() - Close hub device
> +* sensor_hub_device_close() - Close hub device
>  * @hsdev:	Hub device instance.
>  *
> -* Used to clode hid device for sensor hub.
> +* Used to close hid device for sensor hub.
>  */
>  void sensor_hub_device_close(struct hid_sensor_hub_device *hsdev);
>  


