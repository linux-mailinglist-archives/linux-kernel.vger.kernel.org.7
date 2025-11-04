Return-Path: <linux-kernel+bounces-885133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF3DC32104
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93C7189B785
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15151330B03;
	Tue,  4 Nov 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="owN4HpcT"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9E32E13D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273854; cv=none; b=IrcqTIazL9rtOB6TTGLqQgCXlJno+MJxwDxhyE+Jf2fAOAvdf9Z8J4tqBRcfTE5BE55KZE1otiWPmN8qiFahLuaEGV4uW/3l86Y3aMAkTL43Orf4S5kNzATNyAYq3+m7oTE3r/fdNbkGb2vkQvCDA7PvkzB9+QvYSsxA9cFGMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273854; c=relaxed/simple;
	bh=ydXIsLmfUSB94agjmgKYcaRKq9ovCyLllNi8aS0nWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEsDcJAVOdSGbxZnirA6yuuIQen+QcsQDaVERrUtwme1j5IX8HUQ+sEn9vyXsZ7C1KvtllqhEj0riFEfBEUtuWOZXwvX1+ewbRo+dZVHoclDIyY7BRijGNfBonZUBQndDC9nhilQFNwE43XjicJAO3hnz5cKr1FStzxLEdVI+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=owN4HpcT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so4109303a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1762273852; x=1762878652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d31+LDw3yFV8ld/t7W3tLHwlIZVxgW+LoH7NOfugl48=;
        b=owN4HpcT0GfTC5dGYS39sdIOqFOR895Xb4Ol86/Bcy/U5xhI86+1Xi8lAVDsEa/web
         biOZfkoUgkDMPM+XaoaX6NwOp059JP5k3H9g5gfzfBf1Y7cgnL9/Ltj2JZDpwclCoPep
         dnHCbVIPU3GNauVFirnMica0C+swHGjnwXzLdZD2iAEYbueAlWABcYeghzOvpdtgp/OH
         4+xrTlFPTzXChnWA0VwwGA/duT3XfVUKmuO1H/j3Zije21FQqbNAfJlCAg1Y35OOHJQG
         gTD9x9C7bOJztROup9+mHaGT61DD73rok9jfyyU46qrUT4dtPg82O7cj+sqCU9ZHJuB3
         RgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273852; x=1762878652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d31+LDw3yFV8ld/t7W3tLHwlIZVxgW+LoH7NOfugl48=;
        b=CfCXFKoxxwLdJ4dkEbBeIzAwzTuLhYkW6BF4px4+LZgVQT/JtbTMzMUBXWcbNfqnJu
         8ENK8ZhCihKsGMfvmdsKdFdKT0kiX+C8E5oeIjmMuz4Sk5CvvGqgKZTzCJl38DwuUFRQ
         1V2FwwaSFwn1qHofW8auXrxt/MFxDDyaFolKG0dOBrnOIMURgBxLFFlhG12XMHSZ/Vt4
         gfc9NLPgsoCSTCDm2xntM5hCA8oxpcAgfa+nzXSuv6l0ARQos6KddWDNBz/mgMGQaJVQ
         690DSiPOrzgOyaptGIJMXcXnfNHezw/0jwuVeKLdC5/9surjndCjzdWq5xkCAAfY/cWy
         Emwg==
X-Forwarded-Encrypted: i=1; AJvYcCWVyBHpVyY3j2s+ttU34NxRO4/FhnPZ/A7tsO1Gvz11XqZq4P48uurkWkcj1XIrgfTJOchkpCAlARcZkkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyI810Y2WmLh5tt772DK70cIBLwjnba0oz1huTY69ggsCUBS3
	o+vmOj88oFhT5hjkbjrQ3k9j5c6D8y7p8mffKZeGjXTHaMNWjqV0w/1e/p6FCQMKBAM=
X-Gm-Gg: ASbGncuwm66qyc7z4Xl3XHobgK0B1+5Nov9yFPugTLAoQY5/IIUhxmvaP9KYQslpS99
	PYrWbJEsKID+Dk9LByPmCc7bdlvd1FJe3g5EUhNUroirbVRqKms7upE6ibkTKr0ZPodhc19E0VD
	BprXHqfJInZlIZ6h44urG7wn3YGYBSH5nFFmvhtgyMvt56cXo9+trzU9hE+9j89k7qG+iEubnwB
	W0vKJIqTj9QzjVX61FXgv+PPHNW0JlMJ+l42jq1d+hSTuabICpzx67wm7XK7nFS29L5D9lAvPGr
	ypz93Q5D1BoxXdLNNhp16kg+Aj/6JduHqfEvM1qzCGuc1EOzbjxZ76KdLtLfm4g5sJrx6BI7ikK
	+CUqPaNgBh3yvSR4nX9gjIKgi2HdzAiZwNehpsmTt45CPfnBILtAOAjvgEfaUHxZySRhhJoByvH
	CKfAmxdRnPcBe1i41Fxg==
X-Google-Smtp-Source: AGHT+IHbaudmm3cpw/JwLUVFx3dKgg5E1mpsgsGgzUDgg+to2aXDhn3Bml2DCn+xajZ3lSmEZpKKPQ==
X-Received: by 2002:a17:90b:2249:b0:340:f05a:3ec3 with SMTP id 98e67ed59e1d1-340f05a4045mr13294027a91.33.1762273851997;
        Tue, 04 Nov 2025 08:30:51 -0800 (PST)
Received: from z440.. ([2601:1c0:4502:2d00:dd6d:728b:493b:482e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c4aa89asm5024650a91.11.2025.11.04.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:30:51 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: ST TSC1641 power monitor 
Date: Tue,  4 Nov 2025 08:30:48 -0800
Message-ID: <20251104163048.1130482-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104-ruddy-tuna-of-efficiency-3321d3@kuoka>
References: <20251104-ruddy-tuna-of-efficiency-3321d3@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        power-sensor@40 {
>> +            compatible = "st,tsc1641";
>> +            reg = <0x40>;
>> +            interrupt-parent = <&gpio1>;
>> +            interrupts = <1 IRQ_TYPE_LEVEL_LOW>; /* Polarity board dependent */
>> +            shunt-resistor-micro-ohms = <1000>;
>> +            st,alert-polarity-active-high;
>
>That's wrong IMO. Either you use it as SMBus alert or as CPU interrupt.
>If you use as CPU interrupt, then the flag in "interrupts" defines what
>is the level of this interrupt. That flag is a combination of both
>CPU/SoC side and any inverters on the device. And actually you wrote it
>already - "Polarity board dependent" - so why do you:
>1. Provide polarity twice
>2. Provide inconsistent values - alert interrupt is level low, but
>alert interrupt is also active (level) high. So level low or level high?

I tried to illustrate both in one example, but I can see how this is confusing.
Will it work if I split the interrupt part into separate example?

Thanks, Igor

