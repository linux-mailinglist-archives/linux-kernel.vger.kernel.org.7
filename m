Return-Path: <linux-kernel+bounces-896901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24159C518A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160254F1DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4989C2FDC5B;
	Wed, 12 Nov 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcA1OF57"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEF2F7ACD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940907; cv=none; b=UpKr5UjRMr7H2+OGodx8P17f7h+RVr0hTAPlA/4+t+bT5iOGgG8gcxYrUCRBigeIUoJQckYP+Fe/8YXqbR8219gggnDZWtCLMmxWUYhMzvkC3omOulQXxxKikM+kwB6LH4LWj4bYsH0gPSp0LeM1Qgpix9mLYClWlTrZYZ59MBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940907; c=relaxed/simple;
	bh=FZaKAzW/vY9CawKPggx0eM/2zQUi+zNnpG9P++Oknl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEerQNAkSgtoBuZsGy75IHLfBp1jaS9bmM+jkQge0Geiv0/tSJtQnuAIPw9sjXqyg130jMfa/PMKewYd1FH4r3X1u4snTUMDkIyBTQe5IW4cU/4I+LnxybX8iJ/eQWw3t6JxCstGpIB5Qt87xSPgpcYsXCd3wXvuqRJI5jnPxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hcA1OF57; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso3556005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762940904; x=1763545704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGiVPBxfjJETvv38y4sygDFTv/a5RQlo7NJSBA76ZZg=;
        b=hcA1OF57VpQam8yQcglsVGu32jpVrK63d17ZvinKg4N5sUjhhEcJe97GdFZmP+ztKC
         D295YgIwT4VSD6snaNnZCQDOMnPEE8fNiedy/v/VZK5r229l/AVFGJjqlA0CVLj6QH+J
         TKYv4t51NTYzpIDxoHS95P9TX/twBNI6/P4QAzVdKWWqKd0Cg8XpBSz1+hR+vwjBAaeq
         XvifRqOlzV95DmgCAqaM2m3Noz/vQ6xVAYOKNm0bhsHr8CdhWFnybo7tG2qQnEPW0R3C
         pNUOTbtT8g8NWx6MaoOaOydHswqNK6fzEhoJhTDx882lhxYlgvWFLXi230IjJkqxupXL
         LT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940904; x=1763545704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGiVPBxfjJETvv38y4sygDFTv/a5RQlo7NJSBA76ZZg=;
        b=wplznxjZ7R284M843xSlG6nvGc8+qeh5z/BdxPrM4twu77N8ueFd0ikJV637dc9lN2
         ILnPEyMuWNLIwvFolZM/kK6Lt9RHp1MClUheZK4Mil13k2DZsGgn7SIlwSADYrulu/0S
         g6wVdaaMYhA+Zvo6eO2tBajTmdqK2yM0GFfO9hCLPQr6fB//n3SzbcqSK+W7DfXoN2rk
         eEDyfuPdUBsRUBNrjgiCMdX/3cfEY6jfu3JvjsjNlaIbwM0MO3VSqBI3RxjJM7w2xG4G
         QRTl/LCgHH10el5COLVg20pMfuJGRO5Cz8NfgmijzJULtFTILR0kbMKHEpnQKE7mbYDS
         eNwg==
X-Gm-Message-State: AOJu0YxRekyv0uM5t2reKAcJJ72w07TKXfFiOyTjr+aiykeT01LdIetz
	8pIG/8O8yON3dbhXG+pKbR0R++GB/xl6aey+m8ZY1dR6ZzS+Rkumx7GqMiZ9V8KzcEQ=
X-Gm-Gg: ASbGncv3jpPBVeiNejWDGomEuT1WgVZyZ0R6OsG1Jg25mdFHJEBWDsvJqKwGoa1Gv/4
	5kTUl4sgjf0KB9HRgoHGZvQGeeeVScu/II6FIQD0GndQjBzTL2fqF0DYg8jYTRe92lJLuByrQUO
	FqsuiibYmB01DZ2hmPz/4KKw0lH0T0utBxS+lwkXR1MMF2w7E8OP36iw6vuFdyJW3BCWhmU2sXQ
	cQuJGqsZO2c7dghBZrYqIloV8dLF+ThfbSMcr1z3DxmjdnIaUHQh9OJ1BYyxPAtJTXN85uJawNn
	REyM3ZNW1xFItauTidsqbsdXrLGs551sfzgyGY20cJ7lOgsS0bw07r9K7USi/xkEAfUsSt/AoAL
	ojjfP4yExPKaQA0m36lf342PVNGc6kEcLhVSuHlp0fZXTUd4alcfCU1HZTp39eHINRQKCIe24vH
	BsXBM6/B11Bhy+cRqxTJD9Ks0oTLI4i7l+drsn1UekwfthyhGKvKN/
X-Google-Smtp-Source: AGHT+IHnVJPGFzp6Edt1h2VBnU9ppv0U8IjejWOTOVD003GxkoSZcS4GHB8JGWLtcOfzCEC+GuZvIQ==
X-Received: by 2002:a05:600c:450d:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-47787001e8emr17159535e9.0.1762940904213;
        Wed, 12 Nov 2025 01:48:24 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d? ([2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm33789428f8f.5.2025.11.12.01.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:48:23 -0800 (PST)
Message-ID: <a728c035-d37c-4e75-89ba-b8081241314f@linaro.org>
Date: Wed, 12 Nov 2025 10:48:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] clocksource/drivers: Prevent clockevent driver unbind
To: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20251111153226.579-1-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251111153226.579-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Johan,

On 11/11/25 16:32, Johan Hovold wrote:
> Clockevents cannot be deregistered so suppress driver bind attributes to
> prevent drivers from being unbound and, for example, releasing
> underlying resources after registration.

For non architected timers, we want to be able to convert the timers as 
modules.

That's an on-going work [1].

Your series assumes we won't convert that into modules, so you do the 
conversion to builtin. But actually, there is a slow move to module 
conversion.

However, given a clockevent can not be unregistered, the 
'suppress_bind_attrs' flag makes sense for those registering one.

   -- Daniel


[1] 
https://lore.kernel.org/all/20250602151853.1942521-1-daniel.lezcano@linaro.org/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

