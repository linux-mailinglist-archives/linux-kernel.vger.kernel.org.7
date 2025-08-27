Return-Path: <linux-kernel+bounces-788254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65876B381DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830037AFB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710E288C38;
	Wed, 27 Aug 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqTUXbfr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB23002B1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296005; cv=none; b=Cb0CTh82Ki452TIK1fk2ThBCy7gvSsnBi9UeHCySwF/BbQxY2UE8w6JbxDegC1J3iM7XwVxAsRJh4Z5H7rT3lRkZY+WqqNFh2X2lMji7V0+t0xXongjKlMmUYvz+6U+t/gNZVnUnQ5Rkfj5Tpa2wtBj9Zp4PHr4RtHPJQz+sP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296005; c=relaxed/simple;
	bh=8M5yUaYSricrxxS4VJ1bV8PKd7JgB+u6qJ1mUUmgcO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bczDD5YrHam2ftJO+f541Dx1vLu6HxhHzUv2zAairCM7RsyNdJdYgtgvk4RddA5E/fpcf/oYBEa4VRrT9Bty5MtcBj5IdqjZp2QfSsuGwUUuYEMiZPbLSBZdQ3MQh3zutdCPxti8E9cbfPeH9aGxR/OftBziDIFUIN5dLBNmxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqTUXbfr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d8921f2so49642255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756296002; x=1756900802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5L5/xgq5B4PffNpG0CbmoeXuQony5EUxgiKJwLilCUc=;
        b=rqTUXbfrekmOduV2pdp3Rx4xIZF7XHfupKQI9irbr1XuJDN4KzH8t1kh/yk8oeSmn9
         swuBgyyiMAkXqgQCMNsnah+aczNthsDyl22xH3++zGSIWCAej4v9Esdes8PAVO80ACIl
         XV3qFhplmJ8DgX4ginPlZNQS7GBxtWPFRcc53/yp9h/euiVryRjd0PhNw6oi0m2F1KJG
         nDF/GGPZ4n/XoPdQinwx4Oj5uTucYPLBUDx6pfDK6aCO4Qd4MIPNZVa7itjKnq5B+Raq
         q0drTgM/DheRF0+AfCsP2A2jAsrM2EOHi4gYu9lU4RIaaFTFWyC5BomvFobqFSTQRy6F
         nLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296002; x=1756900802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L5/xgq5B4PffNpG0CbmoeXuQony5EUxgiKJwLilCUc=;
        b=E3cmf8YpGTdstlOXIKbv2y0MLvQxWeqsGDZD1b3AHld0lYp+RGx7sHe30nTrnjFA5v
         omiZK1VcddQTWNGFtPJmFsY9A/KBneFFLr4ZTLKVajFFJYYVgidKdexux/GhKeWM4L4Z
         AF5R3SDb803qpptCNXYpaerkj7EAQ8BcercR0QI2UM9f2g/NX70h8cwOdKgyZKp0oRgi
         Nhw8oMGDvoKPssw/ZlJg3F4bf9iD5EBK63a19ALHbHg7OFdkSlJyqT5eI+dKcjzw2DiY
         6KJ7s370CPu3waxR/4dfhu+PebSjBdgA6FGuO+/orPoyyo4W6BBHjaubHtW+El1oXExV
         lxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0RPHya0fIbr123hu14RAXJ3BIb47BhGutOVKxZhxn1XKWF2WdriIf++Q/nUoQIKCrgwqqMiMzgRxool0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIjz5dV2fw1qT/6RwEVoNEY+q94eNDnRA/Hjy9i3aTTwy/YLH
	bAQtZYWD8aWJdvke8A6sSako+a+66Msa0B8xQGqqrJXXGmEfPJazBJtLYHdbfde9iKs=
X-Gm-Gg: ASbGncvl9ergZTMCbgnY4LFUhdusXVgzLXK9B8lyiIP2O/ip34Ej66B4omW/vgyM7zy
	4f2AP/OPlJ+WkASUlO2l2r7iCc16TXEAvfKbIY+5403qKc8Tku/Oh0cXtWY4mAgH2mKJrhqeqpm
	kRTuI1l9KBje2Oo0v0I0bRvui/aTgxjZ7w5yX/FO1X/CS2O/wdtIzRjitIqT4AJJMUpM1Y3nN9P
	8ZUIEUZN6NsVQ3CdAkGNUMYlTHX+UqtEb/Dhd83TAmowoKA5Gjx0enx7sqdfb/JxGHgAhQ94b7p
	j8OUXy7Mur9FUF+azekFOVbq2WRhEfRRAOD3b6OGvIhpXiZM9GpZ45jM+fh10D08eSYziN4f1ii
	kvsMwfQWVe76JxDVC4qi8mGo7XW9XdeaeaiH0x1QHpvIIX8DX
X-Google-Smtp-Source: AGHT+IEkh4jsVY8FwY3eWA0V4VXsqlJwb5m65Kq4NVKaZSscJWUEE+v9BFNSpCicdnp78oKhJqCv0Q==
X-Received: by 2002:a05:600c:190e:b0:459:e3f8:9308 with SMTP id 5b1f17b1804b1-45b517ad4bbmr175430125e9.11.1756296001599;
        Wed, 27 Aug 2025 05:00:01 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c22sm27847355e9.13.2025.08.27.05.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 05:00:00 -0700 (PDT)
Message-ID: <49bf23dc-705e-45ab-a2e3-fbb798cd8e34@linaro.org>
Date: Wed, 27 Aug 2025 12:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] add sysfs nodes to configure TPDA's registers
To: Jie Gan <jie.gan@oss.qualcomm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2025 11:55 am, Jie Gan wrote:
> Patchset 1 introduces configuration of the cross-trigger registers with
> appropriate values to enable proper generation of cross-trigger packets.
> 
> Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
> which determines the frequency of ASYNC packet generation. These packets
> assist userspace tools in accurately identifying each valid packet.
> 
> Patchset 3 introduces a sysfs node to initiate a flush request for the
> specific port, forcing the data to synchronize and be transmitted to the
> sink device.
> 
> Changes in V3:
> 1. Optimizing codes according to James's comment.
> Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1-jie.gan@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Refactoring the code based on James's comment for optimization.
> Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1-jie.gan@oss.qualcomm.com/
> 
> Tao Zhang (3):
>    coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
>    coresight: tpda: add logic to configure TPDA_SYNCR register
>    coresight: tpda: add sysfs node to flush specific port
> 
>   .../testing/sysfs-bus-coresight-devices-tpda  |  50 ++++
>   drivers/hwtracing/coresight/coresight-tpda.c  | 278 ++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  33 ++-
>   3 files changed, 360 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> 

Reviewed-by: James Clark <james.clark@linaro.org>


