Return-Path: <linux-kernel+bounces-772327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC0B29147
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986737ACDE6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA61EEA3C;
	Sun, 17 Aug 2025 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OZxx+DKc"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A215E96
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755401533; cv=none; b=dXVy3NXecsyEE1aiqVlmsuAXwQ0COy2F00Ok56/xa5xcCyth5rOwVwUI27klEK646SHMw+qnQLDTyq4+J64W5XJyhANsluoOrCLWFGXHbHZZXDtkrMklrpvnLdqXipYdQdXH2wPN63i49Jq5z5Dp5INrtyfJT+AV4CsHUfjYKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755401533; c=relaxed/simple;
	bh=lXGqbYs4HzXGILPprhb6wkYaRL/O/aJ+yUDi7RGO1QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=twQJNASKsdSa6ES8Nu/i+oUmQgPzemeeT9Mf+3AwOTNvosfo+Y+Mnr/ge13tknlScsHrxfVVYVUPkuZb8EY1xOruwiRLfs/ZKoLKAySk7OaYSyb7qW6sZMP5ErQfyIiFxBS4oqk6yoSsK2UpDq3ZsMSPa2cccdi7R6hKOTIliIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OZxx+DKc; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce86052cso1892536fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755401529; x=1756006329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jk4M8A7Sq+oUZNkIfHBISleszXEZHXt8JDjM8/2oa3s=;
        b=OZxx+DKc7X8t5/n4KK8ucRjeDYcQ+7rWGbxnQQwWMgZYy825Tv6CrdiafdW4EG+ht9
         AJxyDaBtfL9GuiPMm9wfYwNwKk0rjvqwW6uia13uQD/2gWIVD+D2d3uNFDbvgbwpWLgu
         IsSdOM0hrQnNp/uB4n8h5p8/axAyGF3Jn6Sea+m2xp8MjZ54vVu4tfoNDACYgem837k7
         yCPXWqAXd9vkraQsWknm/m+ahblxI/dj6CthCB2XSpk7Jyp9TuCv8aeBpYmsNa04tmcU
         e1GO9WWpvJdvcdwMxTzozxbnPe6+wR874poFv3rhaJqss3zWH5U3s9DV2W694Bk7NPZq
         BVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755401529; x=1756006329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk4M8A7Sq+oUZNkIfHBISleszXEZHXt8JDjM8/2oa3s=;
        b=W1Ka7jmkXUCFZ6JMG0DlLf051k7BLicL2S92tn/byUvgSaU18M7mt2Ld9bgCf8kyX2
         /spb4fy/YlMgyg22Dz5SNDEqfPUrDkz+afJb1ADL6QxDzg0tP6u/ND1HfmWmi3O/HNVJ
         AewlNYF9Skppqbejv7hss1qubSn318EcFqkOMl7tqeJl5BegpzTcUlvZNBjKIMASdex7
         7kXOLImfWZALH4nC68dfv6UnjHUJqQY3XCB0s3xjvPAhR1x7XwTB/C+jPyqPltTTnYbR
         VDoyDrBXOuHEe6sbqk71SkzBOSU40kUMiAERw2BufS56xz67j+FsXEFfQnuZYGZxUYpN
         m9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXkm1c7+ER3TLv4c3GzVI6z2gyUqz49rKhB7JcERHm+dZvbu/HM5meol8yQ+FnQXc2ZT6wy04DUIej51jI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1d286qZGJnndNIS8RFns1rE50gaBe6uGFMWULgu4kVvDZLYc
	w6uUe7bb8I605EKSVIXkUVvI8+eZSH82Tz25rW9dIpbQCb5oR/0nUHxwFLwNuuc5BwfnSW37OPt
	Ce765
X-Gm-Gg: ASbGncsPnuVboFhrYhKsW0HASM2fFYfA5CopKoYUXOJthmMHm/bY5rzn5R4BHrYkiYU
	Q4getq/3pti+v5n1EM3YhYkiogFnhaOr1orkyLkUhfXljx3FNYtE+76s4BNTsHOf1/gXWkLh17V
	AJFWknO1YHj/YGXUyTaRTQ8YpLKPHzYmEqRKwcaxvendWsjniRb4ltT8DGh65WfdNmAcqAihlkk
	ZmN2M+Ye/Ogvqh2eTgI7ytNxRmy2RUdNvVAO3aUEzqzREx5JuFMYF8xOGkJBSWg2QC52pg4Utn0
	0oWdVONsGoz7cP8kWUAe4p1m62KHhm0coIn8jPb9iaPSjBD/X7MPHv8m842QC9fo/CYSAF88rH3
	C3Q2eDZ/DKDsw01cSBTTmHvr1kpA+46TfO84o2Z26rJGbCuX30200z6cGNFGqHx8gUQQ9jCGUVw
	nr1M0u4Ug=
X-Google-Smtp-Source: AGHT+IGtnDicEi8JeXTCvIVZIDNNbXd9yYPm529q0KGi/0stnNOfER9iWBc/gi/CqVdyO6UwOjr01w==
X-Received: by 2002:a05:6871:4195:b0:30b:582d:8eed with SMTP id 586e51a60fabf-310aafed812mr4305356fac.39.1755401528993;
        Sat, 16 Aug 2025 20:32:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf94dasm1629022fac.34.2025.08.16.20.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 20:32:07 -0700 (PDT)
Message-ID: <0578bf90-49d8-4547-aecb-cdec16b4d6f5@baylibre.com>
Date: Sat, 16 Aug 2025 22:32:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-5-bcollins@watter.com>
 <7cd6f642-b26a-45aa-a2f2-ccb7fbc28b20@baylibre.com>
 <2025081622-industrious-dragonfly-ed3cba@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081622-industrious-dragonfly-ed3cba@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 9:54 PM, Ben Collins wrote:
> On Sat, Aug 16, 2025 at 01:24:24PM -0500, David Lechner wrote:
>> On 8/15/25 11:46 AM, Ben Collins wrote:
>>> dt-bindings documentation for this driver claims to support
>>> thermocouple-type, but the driver does not actually make use of
>>> the property.
>>>
>>> Implement usage of the property to configure the chip for the
>>> selected thermocouple-type.
>>>
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---
>>
>> ...
>>
>>> @@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
>>>  	data = iio_priv(indio_dev);
>>>  	data->client = client;
>>>  
>>> +	/* Accept type from dt with default of Type-K. */
>>
>> We still also need a dt-bindings patch to specify the default there as well.
> 
> The existing bindings file for this already states type-k is the
> default. Is there something else it needs?
> 
  default: 3

in the YAML.

