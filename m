Return-Path: <linux-kernel+bounces-614217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D93A967A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 13:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4623BE2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8827C87E;
	Tue, 22 Apr 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QZ1snwZ5"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4027BF93
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321593; cv=none; b=e+6knmkd/p9OwY6sr1SGAYy5cOUYJZcywoX+bai87JT3Sq4pYWaKMX959+cGo1z1uFCtEOTuFFtpWHk5qG8FxcLAqNofCerDa5pWkdi9Db+Oxmi/pq+7uE4ah807X7JZdKjlvBM/OB40HGE+I1I5nBY4+qFXXaIDqxuZipZi7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321593; c=relaxed/simple;
	bh=swXdo5WTFyUveaDD4FdBrlz7MLIpvKV09PKmtqVM05M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GX+XZT3K5SOd0sJoXkfZ0dxkEgUoNwoCtK4ZlBwn1dlu7TmUOUb+XA800NJJ9uvwph2FTl6iLBBrjIMT1xmshLS6ZSaFOoAa6VnSYUEQ4Bze85yICLo0LP3y1InUzC2e0BwOcxSiw9yQD94lsa/h4FNqbsZKljf9ZsByddPXyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QZ1snwZ5; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60402c94319so2477420eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745321591; x=1745926391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kien1E6NXfuh9WSrzcsf7mcHGt6hb8YIHCWfjMjSq1c=;
        b=QZ1snwZ5cxRxhqN6gOdbekk7VFJqnrfJxo3Y45jGy4lm9FmwYBzI4Vq9d98JJs/72/
         tckmIkmxUE7DF9oH125aJjO4yYnEtVRaWtx5W8TP07oyzBU5OpAalb0HDasl5ALXylfF
         jq1zSO5Dju/ygS6rYEsFdhLfboKhWHdaHlBQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745321591; x=1745926391;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kien1E6NXfuh9WSrzcsf7mcHGt6hb8YIHCWfjMjSq1c=;
        b=BqdeOOls7mH1vcv2KYgsxWkJSQHRps+kfICpkgAa/00Inc8+xv8qlYdxlYuuniUKxD
         TWYIDRC2CFZc7eD7Pdo3Uj7UloC3C1sQnIL1AcdyIa7NzeoqTu/IPP2eeQjmYZG3CZQ5
         t6QIIHZ9sJIoo2JN+MGnqq1sJweNLd8h0YeGsWEj6AfEF8lLTQnNBM5a1SH+ZjQhXL0H
         PXTcCaa9rEq8DQVQbvS2CVSE23v+UexVbY7q6oNJACz5dSVGNqbY3G9WwcQPaeVAi6bI
         CdfeBitlM5KzWfnmp72zL4fC3Byy11URp70uX8lksHYPnL2CnRRH7vqXA6JKg+kCS4Da
         XrFw==
X-Forwarded-Encrypted: i=1; AJvYcCVdpZtT5Z1RpMete5+2iv/x4knmvi8G8r4E2GK0te7tnTz4BoOw+7zBU2XlVn7ApdjK8yXUkYt7fONdoiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtStlwPfDpnEiwVPxbnDaDgRqzCarT0KV5VXpnJWnThxfgx2Z
	tucxgKqeGQ5gLciBq/Eq6GfaBkI9gpeLan7jnJoRkN5liyWbA8J61pMws4j81g==
X-Gm-Gg: ASbGncvsQy5kcxHUclpVESN9Lx3c+HHzKZOVVSQIw+ZdND6ReK2AgXqIHrw8KXS3fOY
	RBPUmTYgMj362nJx7jcgHKmXVGxu/wLrisKIKuwy3KLykw65SsTO4Ph1LHvTqfUmO8GwR3V9A1J
	eHrTbCvhb8JpxBX+HcMr/aDr+UfkKRqX2QRkbv3RPcBnW0D7eDJ7iOFs7W1OlebgmRBgf0LPo53
	qd6IVx5AgzVJw+BnXfpRdugeEcRebRANB9Ig2CFuwNMNk97hH50970HL0Ee103owiMYb4YNtGFA
	5scnGfTtM/u2KfzBCb/UNeL2GyHcMGUBPH3OAVQ2haH9yLPi1j+gj+iGsFq+udUKQ5vG
X-Google-Smtp-Source: AGHT+IFP3RTjlUoFEHxnRHm6KflCnpgwTa5sp1adjIx3axcHU+iEAMSUrT+cuI0TJ7NYGjdh1oj8JQ==
X-Received: by 2002:a05:6820:4b0d:b0:601:d224:5213 with SMTP id 006d021491bc7-606004d3dcdmr7574121eaf.1.1745321591034;
        Tue, 22 Apr 2025 04:33:11 -0700 (PDT)
Received: from [10.176.68.112] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5f790fsm2036150eaf.18.2025.04.22.04.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:33:09 -0700 (PDT)
Message-ID: <c8a78b36-6d24-42bd-b9aa-2a03cd7a01db@broadcom.com>
Date: Tue, 22 Apr 2025 13:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] brcm80211: fmac: Add error handling for
 brcmf_usb_dl_writeimage()
To: Markus Elfring <Markus.Elfring@web.de>, vulab@iscas.ac.cn,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Erick Archer <erick.archer@outlook.com>, Jacobe Zang
 <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20250422042203.2259-1-vulab@iscas.ac.cn>
 <d4de3f9d-5748-4969-98c6-7d17395eef4b@web.de>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <d4de3f9d-5748-4969-98c6-7d17395eef4b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/2025 12:43 PM, Markus Elfring wrote:
> …
>> brcmf_usb_dl_cmd() but dose not check its return value. The
> …
> 
> Please avoid typos in such a change description.

Please avoid such a stupid comment and just indicate what you think is 
wrong and give a proper suggestion to what is should be.

> 
>> Add error handling for brcmf_usb_dl_cmd() to jump to error
>> handling path if the brcmf_usb_dl_cmd() fails and the
>> 'state.state' and the 'state.bytes' are uninitialized.
> 
> This wording is improvable.

That is quite a generic wording you use there. Speak your mind and come 
up with improved feedback.

>> Improve the error message to report more detailed error
>> information.
> 
> Please offer such an adjustment by a separate update step.
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15-rc3#n81

Nah. The changes are small and within context. The patch is small enough 
to assure the bar is low enough for swift review. Splitting it up only 
increases the burden.

Regards,
Arend

