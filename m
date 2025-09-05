Return-Path: <linux-kernel+bounces-803107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12626B45AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CB3188FF61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104213705B9;
	Fri,  5 Sep 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsVuBqLc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5242D77E6;
	Fri,  5 Sep 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082867; cv=none; b=IW3nlayW6jYSGaPA1Wt1u53pALWQdcSq9LVlPiZP5vNj0nPa65YND1WmmquC0QCS6V/UTpjFGSJyEbNFqXnY+VLH2X4eSFjH6MLtTlE5SQHiPwGpundUYkbG5lUBsUBbnm0Kk69Z9q0dsmtPQGjT8r8qyK1gS2mtov80Mr57qxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082867; c=relaxed/simple;
	bh=3vsfFRct25KlREEmsU8jBgqZdaBgVs7QzNQNTr2VZJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHtPn7abL4+rwIhxja+2VE9SmSON74VRIL0q1YPtW99v8/fpibApgzZj+jAQW5PDLQSxLXCf504TXZiaJALOl09ta9uJ9h3VmQwqxBsPTVndCjx1MWx+C8Pd2xmu0ag7s7H0GjCcFZt1xZqWFm5XKt3iF0tlxuKzL+R12e3DAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsVuBqLc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c784130e6so25932125ad.3;
        Fri, 05 Sep 2025 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082865; x=1757687665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OoEqh9IVTkOosF1m/shamjcNQUhzlafUdY/KyvB+oqc=;
        b=CsVuBqLc/Zw4qGDRPR13shEts52NU01AMHRr2NRcrbU6b/DnQmbuWCTRXqXKn0d+UJ
         m5TrfBn5cgewypX9bwEThtz6Aoj/CTqPNGtraX6l1xDLajW8Gkc7P+/cQCSgC++zThoO
         uk5nFqt012cLJ7kPJ4Ng56AJ0QRXNga83LyGLg3OX/UvHp7WTpSl6+Le53oBOX+3Oa2n
         Hv1uZ0HWFRsYTho6MTAT1TkGBNtLzgQ02aNjInRq0ObJpOXR52kDafUoBavFBiiavjhW
         l31mYLWvxm7mNm1hvtlfn8nigvBXxGPjecKexFzSC0tfF62vjrv3xiLPS4HHpRVBirXl
         zIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082865; x=1757687665;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoEqh9IVTkOosF1m/shamjcNQUhzlafUdY/KyvB+oqc=;
        b=c/afM5JDZjjGOUfFB+bZvUSX/5a1ccDNgbEzZVqngY6c1/KO9zKPwAWrrWAKbFEGtp
         thJuO5kkRw2i85FtFVbA/fAD4cVBqVL7uzJLxnnultaK23TGBFRgpqHu0d5P7LkgPtzG
         /u7PtDguZHC156e7raFIj8sQrytYyrozAuNUBbgDvBv2pyq1pcNOYX83dw8tJ4kHoBnx
         fIfJWTmoSxqY9YgHXr5KcaDBgYkKo5ZB7c2yinzLCQ+fLZ2NrG9wkCf0+Sf3ZhVHthVv
         YG9cJoj+CQYSVST4PDKQHWddEkDkEemj8T2MBEWYWa+sVH6b2aJw8T1vQUyjt2wojpYZ
         /ooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPbfEnlRE2S1XSJHAMDYpx4JaEmp1uk37iXZTlyM4Y/02nABnLaA3Y2xyYvM20/cXeWn1PuENCxnKXTw==@vger.kernel.org, AJvYcCWEP9jkYFEheB+BorBnkXNQFecc4kNP6XkTgURhrWd1tUieuZt9Xx6EF2W/o5EwKpx2rKrK42MuP3zP2mdE@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOlQi/NyM40XySNXeOHvaXwN9wUZTCjgFFv2iAU19lTPXnPqW
	ENOrqKhEnxSkKrfQf0p7FsmEzWiPJGb++8qledZ/xi2SVv1TjuOo6NQy
X-Gm-Gg: ASbGncu7eeZHv72V8fbuv5gNv8csSuEDN18ZHjgNxYhpQyFVPBscL8TZ/k7aNtIp8B4
	F3TBHj7msiLv3/yblzSmmbaVxxf9JB8EV5mgxHfWSGSXFKCp3EaVqg+B1ApHlTfRRmwi8+Xcmj6
	UrP5QJGAa6m+Dqvel3qyGWpNpkgTi8eMvRHEapcKbCrMhOcfooBqB8l/yrXgTV0aauUby+AJots
	K4/xf7W3gk5ZI2IbLTULXI9qOwzap37r6Aq1WvFErihPLZjLGg+RRkfsIVgMoFwnlsyJimSXfc+
	Vz0BLmmYGcS2n1m+FC0gcaTvbJioxXKr0pg6tRc3Fw4jBve1Xx0XbrAdHp3oxWV9LHfkeRbHnEO
	xJii+JR9skCYhrRXFfLFoBpCEefG5Evv0xhy7cvFbOz7oNQARjpoE+C7BwzxmELsZGyiymZWQNT
	zux+wSdg==
X-Google-Smtp-Source: AGHT+IGG5X0IQ83/EqRxZIzsN9RJAqPXXxGFJyViBUR4gwyKve4CrCNmU+x2wSEcEqF5NeQOOTNopA==
X-Received: by 2002:a17:903:1252:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-24944b62e7amr250599645ad.51.1757082865006;
        Fri, 05 Sep 2025 07:34:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm211077715ad.112.2025.09.05.07.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:34:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b8df4ddd-f86b-41db-b420-2656addf2ccd@roeck-us.net>
Date: Fri, 5 Sep 2025 07:34:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] platform/x86: portwell-ec: Add hwmon support for
 voltage and temperature
To: Yen-Chi Huang <jesse.huang@portwell.com.tw>, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, jay.chen@canonical.com
References: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>
 <07ff2b26-5518-4ccd-8509-75aab8989d24@roeck-us.net>
 <bca8aa38-af39-4c8d-b3c8-5d452120dd77@portwell.com.tw>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <bca8aa38-af39-4c8d-b3c8-5d452120dd77@portwell.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 22:35, Yen-Chi Huang wrote:
> Hi Guenter,
> 
> Apologies for the error.
> 
> In v4 I mistakenly removed '.is_visible' while simplifying and then
> incorrectly tested against an older tree.
> 
> A corrected '.is_visible' will be restored in v5.
> 

I don't know what the function does. If it sets a constant value,
you could use .visible instead.

Guenter


