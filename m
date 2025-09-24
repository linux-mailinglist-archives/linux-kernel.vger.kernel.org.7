Return-Path: <linux-kernel+bounces-830887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16412B9ACB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DAC2A3BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515D30F921;
	Wed, 24 Sep 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVwQsUWQ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991130BF77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729599; cv=none; b=hzPpPE1vO4BCCRM+SxM0SoRik7Sfs+BvxGf5IZUX5niogPVUdKRj5ld7dAC6S1SP1Qe3Y29hMyUZJpb0V6zI3FhcB7cPIruaQ35Pm74vv0j4DaT0Q/jSgmea4X5FD28P9DW2/0E2AG2dXTS6ZAexlxMLlnghAlh/hhcCURf76g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729599; c=relaxed/simple;
	bh=cPOvD0RWj5XRQ1X63jkqRBqkK//fpnkcUP8Ht39fsXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZZTKWU8NY55Qh25zBy+SFv7xEd47yRfgG3TZN6WJCUEnbALG7MxPdbcrp+4su9XG2umTE/y/GFc0CwjGBJVbqE0zaaqS3FZW3KFsIofBWpb3JZSYiC36CGwvF/YfhkkNdugu+kNiAyhsT4KZ/z7b+U5OI/P1O2YfB5fjXnmto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVwQsUWQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f0efd84abso3944231b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729597; x=1759334397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Axp+Y7n48EcMK3tr2yHFXpOpdW4+znYlp/0VpLugUQ0=;
        b=eVwQsUWQCcG86MsAxjTDg/0U5BkA0QjLR8XrjOmkQEXfzoo/FfsIFocWF8ZCzpwtxt
         0RL+7XtO0QDV+thFaUzb+9TDcXUFTxwBfTiNpzyVjHhSo22TDAAb+M8a1ftBmXfHKUXe
         zXKZhctPhjHa2KBHARtcwveg3+3entekV+AQfsXFK+Uvi2SAupTpElCc0zP04dQS4laF
         1oFsVbkRe22JTs289UmJk9Mg2IG+fIzBMe68yanw2vLrP3q92fqzA2LOZuf77kb1xy+A
         vF73L3qdnsKXHybHdDVyEZPbqBUfVH7AOrcMTU7AOwPd10GI7t0k4mPqVnhcZgVHkaan
         DAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729597; x=1759334397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Axp+Y7n48EcMK3tr2yHFXpOpdW4+znYlp/0VpLugUQ0=;
        b=eYucElaiFaesg/Ou5mg6s9r/Mm/+6Wc8nryVAZrYT4SU+Dkzn2ewC92DCNqrnCW7y2
         lI5CTutdxRrai5wb1QA83xg+wzdh0gkcA39g9ypXtt8c+JihaVvBrAtaLjKW6hkWqgVe
         7Lx9FANJL9IEqlZJwqnHEeZSnsPWkSAhJTPF1MFwRfLdtzmuDJA9fth7joMT8K4aSPGt
         RtWZ7BN/Y2ixGsxpM8/JPO2X8n2TVvgz2JsKYRRTvhNU7SEPadFPWA7Fqndqior/0nMc
         DWBllvYFER+JYGAp8NJ47r6La+2GFoyBAoaM9vcJeF7McPdb3LxfCMRqvGBt1q3Z1vN0
         kpdw==
X-Forwarded-Encrypted: i=1; AJvYcCX5N5K1GoJPLtysNb16DWKVlfbmivcnyZ968efrR7NMA2nDFI0Ih22n2FiCdmAXFn2RCHTX9Gh0bnRKMOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhy6um6kDscZDN1SN6SESXH7X0lE6na0hbnXqKKQGer6c2njc
	oVD8cvdXzFm9chl7YzP36uQchPWkBzcNCOhmpnIbrZVAWtkCfcRyo7dO
X-Gm-Gg: ASbGncs4jG1XEy4unE/lzvFkBYW7i+6SFbkgw00w1bF0o8C74pRYyVT2aqez7Jb3p/E
	ZUiQH7lP+VyceOCzpleuFSZFlhYfKA5oUGNf7mDuN3IhJ2BDXQwsdH4g5tYysgSMrL2GiTCWx0l
	ZXi1tKGVRpJGW/5RIKN+wksuZKbS/KMaNnS+LTc0opXriykIi17dpgr8PI/aMtS4HPeotNYomhA
	A0+Kjg5WrtP5+s9oKemYtfcauP3aiXNpTyz9AN2wZzE6qADiVPMaZU/Ej7HmkmqCMVSovv8zYH8
	IUhENGzBaVweA7RrWFITRpwHqDNHzLeKLaBnkWRJqyloXfEe0B7FFU3mZ0mhDn/Z5BSI+SLEdLk
	goaHf9jrOgN9uz6h6rYydoIOMFXTOvNlECGE=
X-Google-Smtp-Source: AGHT+IEaXCmea0lHklJdK2j0b9lkEP9FEm4EgHcCJQjQymM5qCQpNWQ5k2IXyH2sa8ZgsZ0NbBXZyg==
X-Received: by 2002:a05:6a00:3983:b0:77f:4c3e:c19d with SMTP id d2e1a72fcca58-780fce1f0a6mr534663b3a.12.1758729597476;
        Wed, 24 Sep 2025 08:59:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-780fc88c823sm416136b3a.54.2025.09.24.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:59:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 08:59:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: watchdog: add SMARC-sAM67 support
Message-ID: <93fa6a60-1a12-47b6-b777-0f6f7775d49c@roeck-us.net>
References: <20250912120745.2295115-1-mwalle@kernel.org>
 <20250912120745.2295115-6-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912120745.2295115-6-mwalle@kernel.org>

On Fri, Sep 12, 2025 at 02:07:43PM +0200, Michael Walle wrote:
> The SMARC-sAM67 board has an on-board uC which has the same register
> interface as the older CPLD implementation on the SMARC-sAL28 board.
> Although the MCU emulates the same behavior, be prepared for any quirks
> and add a board specific compatible.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> index 872a8471ef65..0821ba0e84a3 100644
> --- a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> @@ -18,7 +18,12 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: kontron,sl28cpld-wdt
> +    oneOf:
> +      - items:
> +          - enum:
> +              - kontron,sa67mcu-wdt
> +          - const: kontron,sl28cpld-wdt
> +      - const: kontron,sl28cpld-wdt
>  
>    reg:
>      maxItems: 1

