Return-Path: <linux-kernel+bounces-597589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC7A83BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F7A3A4ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8E1E32A3;
	Thu, 10 Apr 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWAjylSl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F3130A54
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271575; cv=none; b=PafXe7b2rRd0N1mkBZsU2GlsJTiuutN1RPkRyI/U/M8/0OUdjiZb8DlefeN5dO+8oYEQfQAfp7RTucRpbD1rtAMHLGXwTC3sgTu3mwNmLQLqhanufU9dCnR9+rLXMdIvnZIfGaLONhUDS+yVkafxUR7T5xYDf2Nypibuf5on14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271575; c=relaxed/simple;
	bh=8W8A/ge74B5Up1+m3x8qVG/YMkIdKFsPE4oY8AXG+TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVW6A96b4GKyJ0zv184N7nXH0gmZqGoj1KAxV8bkFpZyHGwAh6cNcUhrcXiacHRx3oo/PdfdjMvCkL7wyUoe5T3G4D8kpBo2A+zW4rJNtwi1Ne4wW5FSEcvN3aVx+4BiHlNtm7BkDgadKkj7enoYus3hpFR2dJzR/mColwCJyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWAjylSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744271572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRCyAMNNVq6+4i5409xIeFnFjYc/oiKQZz4zgkZf2gg=;
	b=BWAjylSlvNNOn/cYwLm5dFVi+HnAY0PHBrG6jQK/4HwcnJU2DBI2zGDsx4Steqy9G4+UxJ
	6M9Vr/6C972TwA26HKSqY8A+dfM43JoG6pzHys94OW5JnwH4htO3YL106OI2d5dNVYRgkh
	gBOKw9nKgtlhJ786efYiM2ROM3sfL7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-2qk4kd0TMyuB0dHyHAQAhw-1; Thu,
 10 Apr 2025 03:52:48 -0400
X-MC-Unique: 2qk4kd0TMyuB0dHyHAQAhw-1
X-Mimecast-MFC-AGG-ID: 2qk4kd0TMyuB0dHyHAQAhw_1744271566
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1F5D180034D;
	Thu, 10 Apr 2025 07:52:45 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B1A71956094;
	Thu, 10 Apr 2025 07:52:40 +0000 (UTC)
Message-ID: <e760caeb-5c7b-4014-810c-c2a97b3bda28@redhat.com>
Date: Thu, 10 Apr 2025 09:52:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] mfd: Add Microchip ZL3073x support
To: Krzysztof Kozlowski <krzk@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-4-ivecera@redhat.com>
 <Z_aVlIiT07ZDE2Kf@smile.fi.intel.com>
 <eecfb843-e9cd-4d07-bb72-15cf84a25706@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <eecfb843-e9cd-4d07-bb72-15cf84a25706@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 10. 04. 25 9:19 dop., Krzysztof Kozlowski wrote:
> On 09/04/2025 17:43, Andy Shevchenko wrote:
>>> +/*
>>> + * Regmap range configuration
>>> + *
>>> + * The device uses 7-bit addressing and has 16 register pages with
>>> + * range 0x00-0x7f. The register 0x7f in each page acts as page
>>> + * selector where bits 0-3 contains currently selected page.
>>> + */
>>> +static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
>>> +	{
>>> +		.range_min	= 0,
>>
>> This still has the same issue, you haven't given a chance to me to reply
>> in v1 thread. I'm not going to review this as it's not settled down yet.
>> Let's first discuss the questions you have in v1.
>>

Sorry for that but I don't understand where the issue is... Many drivers 
uses this the same way.
E.g.
drivers/leds/leds-aw200xx.c
drivers/mfd/rsmu_i2c.c
sound/soc/codecs/tas2562.c
...and many others

All of them uses selector register that is present on all pages, wide 
range for register access <0, num_pages*window_size> and window <0, 
window_size>

Do they also do incorrectly or am I missing something?

I.
> I already started reviewing v2, so now we have simultaneous discussions
> in v1 and v2...
> 
> Best regards,
> Krzysztof
> 


