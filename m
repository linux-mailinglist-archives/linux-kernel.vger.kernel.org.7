Return-Path: <linux-kernel+bounces-898486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A14C5562F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B83B7EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22B3B186;
	Thu, 13 Nov 2025 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2glekrH"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD629B775
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999386; cv=none; b=AfmtUy9xrhI4U8tpm6fQknu7orYjMeQTIsCr7o40WzkOQ5cb9XDxnk707nrGKPA9rI32vCZwLChf/8RO8uLVSBtGIy7lh1TnY+DhbmklexPkHvAWANzWU81YggRWpneyDIHkefUJb1gLrAejTkrbvyAWSJC7Ltf2MI7ywXrEO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999386; c=relaxed/simple;
	bh=7sagxwt3YOzXO5GtOUTkLWYm3rudvxzxUFEOh7+/8k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiH2zOV9Ld4Xhbogn5vxXueTd1h0ishsUEhXWI3eneuKmcJYHTTJ95M0m2xIszBNM26epZAp/MZttcbsXHZB/memhyvVJUCwO8Qai02IOe4cOwWKkxriigD9iAg8FWSpGMWgmVbTBBfiFHRgag733kgtyIv4u/I1yRijg0UR2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2glekrH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34361025290so269666a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762999384; x=1763604184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UjweUzZ22jKy+FdesM7fO6h9LCgM2UrGbdkfnRu72po=;
        b=D2glekrHFqeT0yPeelVgNhvC98HG+fPpgHEZI7nouqZayqIRe6psL548Yg952k9LXY
         ap8XZ0j151HcFuYoGfwOped5fmAyDQ+l4RIwQLhlKr5t+XgAFOTfRvfctJy6rsYUmaLE
         IVtwOOzIm21RnG5BopAIkdOG7W8loTGpbc0gcCdUGvpHhSsNCnNdw/TLotTmwKXLQf1g
         BQdcQ92VOahrAS5jPLitmPlRIDym3JRC3klqK/98wpKKrbTU/pB9pdfCjjSXwLvDx9q7
         CIesUu+HunioutEDfVFUwM35CzzOgmB6SH7AgEX4t/ychMjnQaRZ65c8Nu/7+tmLZPpI
         Wg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999384; x=1763604184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjweUzZ22jKy+FdesM7fO6h9LCgM2UrGbdkfnRu72po=;
        b=wKW7m1/dxpX79pzEy8HuU/ONgXczdIch1zg1Bu4WtXcS4HoAXQn6G4rr2qfa1QBwr/
         AzjajwIx/cCiaMsdoAdAPhF49Mo3qzYM+rm7k4zFcaIpZg/c95R4K69U7fK2/+5CI75P
         iad0+Rx5ywjUJQ7Mg/Qt7gNeUEZ4UApk6XK/Do/CIa1/lh5gt5fXsKbEhca/WVwxP/6x
         35cF2qbELuIY6nFcMQ4HvTkxB67zF4aCeMpmD8p+LconIg5/hBVjQt9B9CB0YemeDT3c
         jhNZyVeX9vxd3MpyIHt4VQSm5wt8DpyOZ9lpXHFMgBFA6RTI2cKlt3yvLkHRPExXW6g4
         ZAkg==
X-Forwarded-Encrypted: i=1; AJvYcCUEIIBPjizWZIuDEcdm2dMpBus7nDIIhh1JzKEXUy9VsE2TwlmySCgr5IvX0gbklTjfPviQC7/Ae98RT3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKz5fOd4q+6sPOBaYF4dGXWBpZHDx4P+knONoR8p8puzCOlayh
	6zZfCx5lNp2spAMFZu6l5ZfU+WCtNw2S9znV/b2bL2uHw2fLqO953PH7
X-Gm-Gg: ASbGncv2KDRgFhIKkGVcv8h4q7QXS/Vuroc9r3MzxW9fW1KrnVeHKNVdZyoMu5Rnh7z
	P8LH3EF38R3dOBQwe+mFNJwjHts5/6Wu2tE5xFsBFYxvI/cTSkkkcsgyF4FTZDHHfnbIxRc4VbB
	gzPtxRMhOZiGfXTCMXWwI2Z8zahD2zXFnVem5w3DdC65aWQrZlbILQwDfLX6WyNGvpmMc0er7m4
	Is/mwvJWeNL4eQBkUtBcWRaEWfGX9uiQzB9vpQmPLJMmKIwxJN/NkrAVX66VncGyHP++Y3Q8pOG
	+9dSuTesTEwG9wyNmVu3FFcS4S9znglSxY6MtE3xxBkyndENqa1ZZWhY+FxQnngO5Hq8HGTAAER
	dISpBZlfdcp4w9fekBdAEtL5vPHxh2FbV0AepofcTyh1Ic30lbzXSWlEOXDlLeGk5OJEaOjyr/s
	kig/X+oc5bhpxexaWX/jFeRm8Fk8EDt8dnWl6Dnzcb9F7EnxqR
X-Google-Smtp-Source: AGHT+IG1WS6e6A31ciU36x82nVcAmvDmiX6VuzUgSbYU6zLgxbRslxDpgz+YB6Vd+8ZB7Iy10zQcHQ==
X-Received: by 2002:a17:902:e80f:b0:295:6d30:e25f with SMTP id d9443c01a7336-2984edec6e3mr65136965ad.53.1762999383530;
        Wed, 12 Nov 2025 18:03:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36fa02c42sm435825a12.16.2025.11.12.18.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 18:03:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <50cb21bc-55e7-4bf3-9d05-0cbe10af46aa@roeck-us.net>
Date: Wed, 12 Nov 2025 18:03:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-binding:ti,ina3221:Add SQ52210
To: Wenliang Yan <wenliang202407@163.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: christophe.jaillet@wanadoo.fr, corbet@lwn.net,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251111080546.32421-1-wenliang202407@163.com>
 <20251111080546.32421-2-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251111080546.32421-2-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 00:05, Wenliang Yan wrote:
> Add a compatible string for sq52210, sq52210 is forward compatible
> with INA3221 and add alert register to implement four additional
> alert function.
> 
> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
> ---
>   .../devicetree/bindings/hwmon/ti,ina3221.yaml    | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
> index 5f10f1207d69..0fae82ca3ee1 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
> @@ -12,7 +12,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: ti,ina3221
> +    enum:
> +      - silergy,sq52210
> +      - ti,ina3221
>   
>     reg:
>       maxItems: 1
> @@ -77,6 +79,18 @@ patternProperties:
>             exclude specific channels from the summation control function.
>           type: boolean
>   
> +      alert-type:
> +        description: |
> +          The SQ52210 features a configurable alert function with four
> +          types: SUL, BOL, BUL, and POL. Each channel can be configured to
> +          select one of these types to enable the alert function. This alert
> +          function can operate concurrently with both Critical and Warning
> +          functions.
> +
> +          The configuration must use numerical values 0 through 3,
> +          0 corresponds to SUL, 1 to BOL, 2 to BUL, and 3 to POL.
> +        enum: [ 0, 1, 2, 3 ]
> +

Per datasheet, each of the alerts can be enabled independently. It is possible
to enable SUL, BOL, BUL, and POL on each channel at the same time. This is not
possible with the above property since it only permits enabling alerts for one
of the alert sources on each channel.

Also, I am not sure if it makes sense to have this as devicetree property.
It is not really a board property. It might make more sense to tie enabling
the alerts automatically if a channel is enabled and a limit is set for a
given channel.

Guenter


