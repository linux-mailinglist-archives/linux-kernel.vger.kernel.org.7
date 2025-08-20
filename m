Return-Path: <linux-kernel+bounces-777420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF69B2D92F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16723A8B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A12E040F;
	Wed, 20 Aug 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NlKIlU90"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20A2E2F10
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682858; cv=none; b=bgEyRcDKwDvcULLUTTA0RXhD2hUHcEEF7EeH8wVFmE1IdtFQa2MiIHlQtT1CsvM/H7i6oO6l5/MulzVfAov/+QYUhPLcrlt8j1A/gp+ksBngnD0bsOZs60s3Sry2wS4zXfoYYJuClRCZ+g8qe8tSbI3c9hXghnWqyd3iwYogqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682858; c=relaxed/simple;
	bh=pTVx/c7v7MNwSE85DS5ROcGDXqyxeTPbAbsaxq9a8VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLCxNVoPXfDGwfI0tmq2+gj/THYO8LywhVv/8gSjOMHA9M0PUM9c2XjHNkVtZ1iuBOEwYWdX4rWbgKYt56/Ay0QbHV63hkIJqf8TF+fwidNUBo694TNks9h1qnWOO5td5SewMX3B18Q5zbjsbd/9MUdihKMQKjfQ7yaooyH/RVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NlKIlU90; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b004954so45530605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755682855; x=1756287655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzzsV1XvsxlzkLd9loB0EUOGKZo196ybFa4QKb2RzLU=;
        b=NlKIlU90l1/TjezKDMR4DpoIMk273lERZ+uJotAYJJ402Hts/SYKrdiMs4fCVgo3Fs
         wuB0cUQzBGc1dWGuibrZ74pgLUe3sbs3zlpa701WVLmklzADGCymtY9o3JV4x1+fCb8z
         XEVWpuNyt3AYRhGZN0d1DEOML/h8kC5qRrAz5YS6oo2mt+ppZ8vdikWlInILBn0oVhM9
         qO4J9sjUyqvZ/7NGm7tgumN0SAo+2XAlHapN0JcOIoLL6hue47fIlqGsXoKfK1/vn9dr
         p+vYajI1KHlh56xjEt5UuAJ1BT1TihVvGqKH3bdQMz7BJQ8aQfjli4sJLJJbgHAtXZ1c
         YTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682855; x=1756287655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzzsV1XvsxlzkLd9loB0EUOGKZo196ybFa4QKb2RzLU=;
        b=r3mmBbxOfF1sT2b9leAJKJLHehsqWmhccVL++FKKrAWVFB2g31dl0lHOQ+2zzmuapP
         ZynOpkxqCQ3cSdRZPlWzgROKhRZ+QljINrbUJfYtQf0FXDWxwUoE49XzzszxRCU6vnfG
         UGZAVq4r6FnemrsWJOXE5j0eyFYcBLEo0ZKnnwhArSkRBwtBQehgxeTs5qG5JiBloSjh
         YUIiJMr/QJjsKla9aPrD44B1VlUG9gHkjPTQtS35fB9+Jj6gvzcli4mIzB1IXuhA1gHc
         mhwssFKxIanzo4WIiOYcBtw04rTHqWEryHWMnrjhd3fha8BQLlCrq3QOCuk97FYx9+v8
         SPIg==
X-Forwarded-Encrypted: i=1; AJvYcCXjcmjW1QjOk9xl+wZzBNB6g5Zl40AfSTJhlz0WQrqsVL5fMHxg2YezaMHrILhqSeADJuCwifJKjhzoySk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFX2fKpJHxs0gce1tQM++UbpYPlh1NSCrY7r4ATVuxSJt1+S9K
	Vi5MMPDIEeH1X0cMbBaSocG57bZbrbLfBmoe5ulIN6AljsHHOO7vY5vrBcx6odhlmKs=
X-Gm-Gg: ASbGncu2KevE2HvFGlk7F2M6KnOYFWngt2rzlrhYfQEcnIi/qPAsAIcl++kkeR/wV5J
	+KjoWanMOq/x2D4nsjj7jIcXkMvCs2W1x63hnArd8doI7h9npbJ6ySueJWuEHBd4ZP8hoErgqNc
	rexyGGdqrBRhX0J4cx8qon+2rL54G5Xv8r5wFACxaINmx0oe3qkvEkcryS/gjsbyz9HVZE73m4P
	XPRPGVCRd574ow8axg211UH/j8ppYsUTc+wvrBkrcCpOn1ImMQA1ySaTxO83zBDyQDNB/H8N5pl
	EGJeJFzDAyEujo/Z3ZTNJrfpg32yyFsmoqQMUyR0rngydv2hlmjcTeI7MInKis7UF5VuLHvQWrL
	QempJTmlRLv7Ge7d4ryeqFCDtTgoDrJTMAwovxEWeDUB6hq6F3ufXtB153F75KUWLFBTEZIhMXt
	/N5Q==
X-Google-Smtp-Source: AGHT+IEeghXw0m6JDZS1d5MhVcQIQaVDe3djwuj01U6mfo4wAkk3Pv0FB0hXUATB2KRJRFAtHH/lOg==
X-Received: by 2002:a05:600c:4584:b0:455:f59e:fd9b with SMTP id 5b1f17b1804b1-45b479f3a13mr15577625e9.24.1755682854663;
        Wed, 20 Aug 2025 02:40:54 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:620a:8b00:70df:79b5:b54c:4e1a? ([2a02:2f04:620a:8b00:70df:79b5:b54c:4e1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c4bd0asm24800545e9.14.2025.08.20.02.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 02:40:54 -0700 (PDT)
Message-ID: <31361b5c-32de-4618-bb89-f550f03b47d1@tuxon.dev>
Date: Wed, 20 Aug 2025 12:40:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: phy: renesas,usb2-phy: Mark resets as
 required for RZ/G3S
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, biju.das.jz@bp.renesas.com,
 krzk+dt@kernel.org, geert+renesas@glider.be, kishon@kernel.org,
 linux-phy@lists.infradead.org, yoshihiro.shimoda.uh@renesas.com,
 conor+dt@kernel.org, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, p.zabel@pengutronix.de, vkoul@kernel.org
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
 <20250819054212.486426-2-claudiu.beznea.uj@bp.renesas.com>
 <175558495459.3265640.2032619822487575179.robh@kernel.org>
 <20250819133744.GA87211-robh@kernel.org>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250819133744.GA87211-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Rob,

On 8/19/25 16:37, Rob Herring wrote:
> On Tue, Aug 19, 2025 at 01:29:17AM -0500, Rob Herring (Arm) wrote:
>>
>> On Tue, 19 Aug 2025 08:42:06 +0300, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The reset lines are mandatory for the Renesas RZ/G3S platform and must be
>>> explicitly defined in device tree.
>>>
>>> Fixes: f3c849855114 ("dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings")
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>
>>> Changes in v5:
>>> - none
>>>
>>> Changes in v4:
>>> - none
>>>
>>> Changes in v3:
>>> - collected tags
>>> - rebased on top of latest version of renesas,usb2-phy.yaml;
>>>    Conor, Geert: I kept your tags; please let me know if you consider it
>>>    otherwise
>>>
>>> Changes in v2:
>>> - none; this patch is new
>>>
>>>   Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>>
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819054212.486426-2-claudiu.beznea.uj@bp.renesas.com
> 
> No issue here. The QCom folks have broken "make dt_binding_check" in
> linux-next...

Is patch 3/7 in this series still good? I can't find any issue with it locally.

Thank you,
Claudiu

