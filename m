Return-Path: <linux-kernel+bounces-666190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA65AC73A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 00:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED20178569
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE222A1CB;
	Wed, 28 May 2025 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LQNuGP0m"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6322A1FA
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469675; cv=none; b=p3WNi2tmgm7G52YmHOybqMZM3qOpO781oxMYd4x2fdVH+HLcNI1kcKTpGFZSL/oXYOzATPM+lU5IHG+HV6OQM7WJJvrsRfWUz2yQZgHuBxMqeCyaXE25XV4pnYtRo7dP3LrKHQidPFL6ip0CxLyT8bIWnWF/tjaln2iRRMqzB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469675; c=relaxed/simple;
	bh=9xgovVByeRLDD7X8aQLb74zBQo1GfWHki0nfN4FrGTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5wdRAp86IHX012h5cqR8kHDrKPdRzLrtI/Zd6KdMG0gHDWz9FYqEU4/P+oRoPupYQ9/6ceHcgsaafbrNSLptHRo87h8cFzJckVE9rFOK9lJeB6qTHJv7SHpiFyb446rd4ZX1LRUVDUFHsyaToFAxlFcGQ2yhxkXP3R3HOWp7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LQNuGP0m; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376e311086so181573b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748469672; x=1749074472; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjdYBhiSCBBsPz/KYuGmvOv9MuA+IwckOxlrzQUqXbo=;
        b=LQNuGP0m9nIk02uBtC5M3DySgJKs6DZr2xcc5mn+2Q3g2QLuQHvsyAw8e5uweHBXaY
         lT/jwP4VOIldGcYT/KbwiksQGObXs594eplv4G8Mg4WEZP1Hk0GIkV1Kfy0quOO5KMUi
         8vjZiNLE/vmhWGshzUjhgOZBn8ahAO0cjHpl2bruaVCd41EyMfIiasl3buiVo9ylIkQL
         Xm5skiSrf+UmYHQjejQYNqt/kUP45+v+gs80GSROK4Jz9oGxyGu+cuJibFH9yQC3sBaz
         3GWI17QL+DCE9gKB5pZotMLVsnuEaErttj5xkFansF6rRaKUW6tVydaLaHbODhjRIvN5
         3Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469672; x=1749074472;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjdYBhiSCBBsPz/KYuGmvOv9MuA+IwckOxlrzQUqXbo=;
        b=cgNSBKvlYHMdpoOe/wqtcpDvoWMVmEv0I1L0mC7fvFPII6+VX441HMTh0a4IP0S68v
         DYL0KLpQbwBfbdM50iMF//nwXdKlArZfBrrFR6UH/fb1jjuIzVxGoGxCeSedR+egrfxX
         TARI+XaSi/otQMjx89/dusGZP95YcIb+Nic2pbwJ4a2DfbeGvrpldFgld4eYylRF1xiy
         XemsCICUp8tESziixf/22ps30zzXkSPK5/TWWLWnIAifYhAywBHwsqfB0GzjvRy+LsKw
         JSQ8cBxuYdipNihcvcIlRR7qy+Aa+hxaK8mIulPn4wWg71sn999Ah7/9r6Rrvm/LMhbC
         uArw==
X-Forwarded-Encrypted: i=1; AJvYcCV352ymcipNs9rDw/12Y22MNwyZtgdUBdGTCtFnwu1o2wjsqkCh8dU4zlfJ75tOgxKXYVZxpXofk7mYJZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPo/1ZVFTIrhsec9Fp1oFo9IYU8uu9k6DtzJ9Q8EgJROxfcSF7
	rveixlh/f4RSfnziHrMycbYvqvQMIrXsrYrLUeYrYy720zq1yBO+T5Xmvtc5J8Nilxg=
X-Gm-Gg: ASbGncuhJQib/V+s/Cu/hsWR+6EfMqZwbV73BT9oVFZ1pplzowvZHF2Ib+lfwfRpxEs
	569yyzMUfzo3JvVZpKETLZBQXnvZmSN5EJ9vkEVXQ2Cuox+nlv26WtL8E2VITnEIS1WkFz060DO
	KGlXqXStNujvmKeB8yQBjwxK/KtTgSPuRzbgvxR0hWggGlHTwmM8VuosSapTWHvvfyhe3TBoKNs
	2LQzQ49L0Fcw0pKpOg6f8AAezoSSL804rUyzyaFgzp7irj7LS3ZLjwq9ztHiJRzPEzPAYsIfd7y
	K6xsVwXIiG6VXpY5UDRH+OdGhgckbblfWuXEinV5bIGh7ydg2w==
X-Google-Smtp-Source: AGHT+IH3nYX+eQxZgpfdAR9VsWy9q7cvVikszCvdqn9prU3U/FXQrdVyfMwztBrRoAEFZ+77rvYLjw==
X-Received: by 2002:a05:6a00:2e84:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-745fde797f3mr27897905b3a.3.1748469671777;
        Wed, 28 May 2025 15:01:11 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaad78sm75427b3a.46.2025.05.28.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:01:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org
Subject: Re: [PATCH RFC] pmdomain: core: add hierarchy support for onecell
 providers
In-Reply-To: <20250528203532.GA704342-robh@kernel.org>
References: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>
 <20250528203532.GA704342-robh@kernel.org>
Date: Wed, 28 May 2025 15:01:11 -0700
Message-ID: <7h8qmgpf88.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Rob,

Rob Herring <robh@kernel.org> writes:

> On Wed, May 28, 2025 at 01:03:43PM -0700, Kevin Hilman wrote:
>> Currently, PM domains can only support hierarchy for simple
>> providers (e.g. ones with #power-domain-cells = 0).
>> 
>> Add support for oncell providers as well by adding a new property
>> `power-domains-child-ids` to describe the parent/child relationship.
>> 
>> For example, an SCMI PM domain provider might be a subdomain of
>> multiple parent domains. In this example, the parent domains are
>> MAIN_PD and WKUP_PD:
>> 
>>     scmi_pds: protocol@11 {
>>         reg = <0x11>;
>>         #power-domain-cells = <1>;
>>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>>         power-domains-child-ids = <15>, <19>;
>>     };
>> 
>> With the new property, child domain 15 (scmi_pds 15) becomes a
>> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
>> subdomain of WKUP_PD.
>> 
>> Note: this idea was previously discussed on the arm-scmi mailing
>> list[1] where this approach was proposed by Ulf.  This is my initial
>> attempt at implementing it for discussion.  I'm definitely a noob at
>> adding support new DT properties, so I got some help from an AI friend
>> named Claude in writing this code, so feedback on the apprach is
>> welcomed.
>> 
>> [1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/power/power-domain.yaml |  39 ++++++++++++++++++++++++++++++++
>>  drivers/pmdomain/core.c                                   | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 150 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
>> index 8fdb529d560b..1db82013e407 100644
>> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
>> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
>> @@ -68,6 +68,21 @@ properties:
>>        by the given provider should be subdomains of the domain specified
>>        by this binding.
>>  
>> +  power-domains-child-ids:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      An array of child domain IDs that correspond to the power-domains
>> +      property. This property is only applicable to power domain providers
>> +      with #power-domain-cells > 0 (i.e., providers that supply multiple
>> +      power domains). It specifies which of the provider's child domains
>> +      should be associated with each parent domain listed in the power-domains
>> +      property. The number of elements in this array must match the number of
>> +      phandles in the power-domains property. Each element specifies the child
>> +      domain ID (index) that should be made a subdomain of the corresponding
>> +      parent domain. This enables hierarchical power domain structures where
>> +      different child domains from the same provider can have different
>> +      parent domains.
>> +
>>  required:
>>    - "#power-domain-cells"
>>  
>> @@ -133,3 +148,27 @@ examples:
>>              min-residency-us = <7000>;
>>          };
>>      };
>> +
>> +  - |
>> +    // Example of power-domains-child-ids usage
>> +    MAIN_PD: main-power-controller {
>> +        compatible = "foo,main-power-controller";
>> +        #power-domain-cells = <0>;
>> +    };
>> +
>> +    WKUP_PD: wkup-power-controller {
>> +        compatible = "foo,wkup-power-controller";
>> +        #power-domain-cells = <0>;
>> +    };
>> +
>> +    scmi_pds: protocol@11 {
>> +        reg = <0x11>;
>> +        #power-domain-cells = <1>;
>> +        power-domains = <&MAIN_PD>, <&WKUP_PD>;
>> +        power-domains-child-ids = <15>, <19>;
>> +    };
>
> This all looks like a nexus map which is defined in the DT spec. To 
> date, the only ones are interrupt-map and gpio-map. Here that would look 
> like this:
>
> power-domain-map = <15 &MAIN_PD>,
>                    <19 &WKUP_PD>;
>
> Quite simple in this case, but the general form of each entry is:
> <<child address> <provider specifier cells> <parent provider> <parent provider specifier cells>>
>
> <child address> is specific to interrupts dating back to the days when 
> interrupt and bus hierarchies were the same (e.g. ISA).
>
> For the existing cases, there's no s/w involvement by the child 
> provider. For example, with an interrupt, the device ends up with the 
> parent provider interrupt and there's no involvement by the child 
> provider to enable/disable/ack interrupts. That doesn't have to be the 
> case here if that's not desired.

Hmm, very interesting.  I wasn't aware of these nexus node map things.

I have respun a v2 using the nexus map:
https://lore.kernel.org/linux-pm/20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com/T/#t

Thanks for the review & suggestion,

Kevin

