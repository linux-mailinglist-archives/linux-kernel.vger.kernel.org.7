Return-Path: <linux-kernel+bounces-880032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21274C24B55
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA51882C54
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E543446A3;
	Fri, 31 Oct 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V8PFmfsy"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EF3271FA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909067; cv=none; b=YZO5Es6NXmOQCTIN9YknZQafiU6RYREw2mCGo0qsmfZV3LhSsePWnSKXY9qpE7Z1J9D4xOzh2gBD7JjTsE5TZ0/T+hG3Hjh3v6hs3EEu1y161EdW+wK0QklokCX+r6L0d7V14zz3/Y/RtcfpAA358IWu0in1wApl+mMLqWKA+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909067; c=relaxed/simple;
	bh=h4b1OvbD8AqbOQNQaFkHX5Rf6eQ5ZGeAM4YGA3EbqzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADnhN8IpndBSMKySDLYgzhdowum8pmAkHTH0/m4cwnhxxcNIVBO7qzfi0dFkp4Ta5GwsmDgU3IkOpbho8cYuHS4A+ZjyicWUerhgbXNtS7iWsr5qC2JWFL63i//bBjAiDN/+djqZifbUOQ4bNhCvCRpXE8YIZnG8ibT5O70ARTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V8PFmfsy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so772917a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761909063; x=1762513863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4b1OvbD8AqbOQNQaFkHX5Rf6eQ5ZGeAM4YGA3EbqzU=;
        b=V8PFmfsyFu4rxcP0DmndC8zVKwDrqsIcwvS0nKfErS74qlI0hvn0eypcx+Z8npsInU
         wFxWVWTH4ZocOfdtE8/qUPPXVrzJwj1UZsr2o2Ta1cDx3ZQmsrmeu54PQ8wcwzUIhVwQ
         sJ90sKIR4hIDv8dhmCbCians+bnlLYWl7DTd5WBYOJlNbg/iwhWq2M3WXg6K44Y6hxeo
         6AwmuZPMGD5o2B/+qehNMX0P4r1pJloVkcz7zn6nzBo+kYs3N7AFMpDEWM1SoH/Sivpu
         ky+6TuXM/WypaC3HJVcVb+N/LCXo4TMMK4vuh8mDtqHZ+ahKv/pfsIb1putdmdl/DT48
         mdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909063; x=1762513863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4b1OvbD8AqbOQNQaFkHX5Rf6eQ5ZGeAM4YGA3EbqzU=;
        b=l758jO2YGfA3pyBvvxQzrJq55JNDnhNPi+jjf1DtvbFkxI8F/NY+oCTCbhNDEO4tuL
         fE/3ocQVFcpItu99RV+EDPCrnhJF0EuI22mrkQKMN8Fc0f3tzLRTgZDTQ8bofK62Fwbg
         VZCRPTw5cphfxxvrQujDjtGYCxWhP0pFR26Xk1UGyqYg+C6xV1/uZgFZlf5eKH99cuaN
         QzjCh5j025lgYJQxbogbsvhO3ApaDJdeD9mh4eqN0tBY6bUSMW+v/kIe9gHAxekZZg78
         zWMX2grYNS+LBS5fJcA7EEqwou3inphUIc5+j+QoerNaf7L7nlQ2fbnyioWbDjbFkxY7
         R9hA==
X-Forwarded-Encrypted: i=1; AJvYcCXdH2arTqX6LYLJ4xr5bIhXjYJ4F+68x8TzOCC4JlwsttGp8Ru+/y6Z9ncB8vYkzsEKxHSTZcCxL50ZwC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1jSJDlE0/j+77AInyRe2WmMXer0D/WgPIZL+oF+fe6B+Br+O
	ihIgxPZxNNPCmH8a4q7Z+5h4deWVh9kNh6BmbPXnG1e03ls2sF8oXQJl55ePQjwDPvs=
X-Gm-Gg: ASbGncsrpuDFsAskYf+5tS0eVcL3i/WL/dQUCpsASwEevq1nPm5JuumxqBZy39claMy
	HF2/MySZY06HTx+46Pd0RVfYX5mJ/PplJrJv9IdUbuUgpkCA2iBUbhqcpSDetlVHzWbFMSPBEsp
	l+2IKf/xZrfFAHZI5SmEC579BeBVhva81oX/wzNCF5yEXcuGWd6S226A3xJbcgWxz5fBIP8eXzn
	xAfldvl53jZnGKhceurz1hJ98oepgffh+GqAkb8YEtYfjM91BoCtAi6BnhXRYA0nIn66ttdV4ai
	dJSXGBUeVe4EIWUX4Cb5WN879UA1K2PoTCenH/dc6EmYLUUtR918NSCIWes96a6Yqu5FZkjIrIU
	ZqSOjNpPzRmNCzVZI4ppvXqcFZAPiNuNfCYiJJtmpJDz2kzYJlh7LlTuC7Y1mF53Umtrx5vwYwT
	hElHZV6Swhm2aAf4qPTUoJ417qt9Tfd+yKJ20=
X-Google-Smtp-Source: AGHT+IEjms4qrB4LmCYAXPaycpxI8yZMVC22mnbEDh4Pi0tNLAsk57VjXYG/l+laWrQ2KLiFhiONkg==
X-Received: by 2002:a05:6402:3488:b0:63c:32a6:e9ff with SMTP id 4fb4d7f45d1cf-64076f66bbfmr2677787a12.8.1761909063307;
        Fri, 31 Oct 2025 04:11:03 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b449fadsm1297395a12.36.2025.10.31.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:11:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:11:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: add phase-adjust-gran pin attribute
Message-ID: <55jjhdqtmuvhayhnehqguauw76z4awa6bebsw3odcvkiclda6y@dhl5kswtv374>
References: <20251029153207.178448-1-ivecera@redhat.com>
 <20251029153207.178448-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029153207.178448-2-ivecera@redhat.com>

Wed, Oct 29, 2025 at 04:32:06PM +0100, ivecera@redhat.com wrote:
>Phase-adjust values are currently limited by a min-max range. Some
>hardware requires, for certain pin types, that values be multiples of
>a specific granularity, as in the zl3073x driver.
>
>Add a `phase-adjust-gran` pin attribute and an appropriate field in
>dpll_pin_properties. If set by the driver, use its value to validate
>user-provided phase-adjust values.
>
>Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>Reviewed-by: Petr Oros <poros@redhat.com>
>Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

