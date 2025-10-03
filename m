Return-Path: <linux-kernel+bounces-841569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ED3BB7AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037AE4EE2CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C762D8DA3;
	Fri,  3 Oct 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NYINhqs+"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB42D8783
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511539; cv=none; b=Iwm1IDrWZiZf2o6S7fv4bkB1rLtQSe7PyuFapQFFx2n9x5BS4BCzt/eWplXgbRkgbTdQj8wNixisCo4Z1qWZPBJ26AI7YywYjn6b/WOFCZEBTKa/QhfNIZZ7MWbTMK6sffZ+r0fE55ZKoxQ+glTVyVtrONb7o9f/aj0B7FoHxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511539; c=relaxed/simple;
	bh=9SlwudKfjm2H6CDBihaHiwrvhvQGx05mbbKqjmzJGt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5LdjitfPXbnzNQ5ucwr8/ENm+dRkXt5SMKElOPeMxCACCKafw43QensSTc/ACA2FzDvJtx5huq/380NvsbHiOv4CegooUO1kJnCbIPLx/9YeBA/M34isWHIOWWKwUTBVFTo/MyCUvr+WoalIMafzR3rp9Zr/cdGaF2XKTuIBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NYINhqs+; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-92790f12293so112093339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511536; x=1760116336;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+rEM9+wzhaFVPN9JNs7nDiRdjo8ZbQobpK1PNdub44=;
        b=d8swcLtccC8susx2y02HtYtwXfo42vezaSppSl07tRrwai9DhBAf5n2igZvb7iUPaO
         vw7wDDZq2b6CC1VtbMmYuqHduhIgZQm+XaAVXfwmQiPh+WjKR8wVmgQTp88dEQwqbQdL
         EEDT85EEOG/Ljiqka6O0ihddpqlTMnBz5Tu+f5ayYdxN7bUkN0sAswPZeGgwo4y5DS6f
         GcPT7Y3JPZ9USdB/uVYOrBMDahec/hVv5aGpchov50CqmMn5++ViIhwFsi75SVnqwI8q
         KckMtreQdVLsXZrn7BQSD0Qvn4GAVcEIBKlDPMDhVA6TdGM/LVik6xx+rGx5EBvgBu4E
         srkw==
X-Forwarded-Encrypted: i=1; AJvYcCVYlBeVQtBSyJ75qrA4B3rpOcRJuhNygVHhVRQ0/yz+3dNf2lP0MsVUdx5Y1j611vxU5dS7Kkyx2f/NM2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtymnj1kVyzDbvoFW2bCNZQ8UCkwsFOKCQz9U70VMeecMMM0VS
	biFkrZJruEHksiUKwpYE2jK7BD9Mn/OOhNQ4RR+7FVwiBX9Q2L1XwVuz1HwBJhU+9urlLX6KyRT
	zUgtcX6ObQFZiBu7e3/IG3Rab2Pubj9iLYe6tVP3hcX/VEYoAYBozo3ep9eMqPV74uX2nq1qx6h
	3U5IFqAe9KJsf4s3iYBJWL2Px6XLvknElKKhurScMNAHWX+YVOHbUr/auBd55XlLvslRXfYsgQ9
	ZewhtWnu5xh8ZVhDOzCS1Xa
X-Gm-Gg: ASbGncsdzf5g8UYoM+u3KoJI4WQTZ0+UimmHSjpO0GVUTog/lq1yNd4lVnVvJSU9uAQ
	EKOCrUjuk8lJuUcIkOFsuLAc2pMYM+U3BeDv6WdzEFNGz8UXxYGx5usnl1UE2xLQGLyvBf1myjI
	2Db6ircCG95m49o3oIJ5Gn96MIS5Liaop9ZrDfyVhvp761NTDFEUTLFMZcZ+Rt6JfqbIrH1SEik
	nXW3XP7u22X026jYOjCRgOaVh81+e73zsd8QT5kakANLIUhlpD2wWTdUNI1XfiUpAyjBJIHgNAN
	DX5OIXxGCAW/yhWpdFZozOGj2pJ/DiKwdit2Cr/OyfcnYcGhR9wpvTulfjyNB/pq45WRapu7xzJ
	udM4zuODRKdRgcoQvcV+f2jUW3W/GvWrw9+3l93Q/WG4zd3sVLgWvrUKjJMoD9omwCarEltEObS
	6p90hM2N4bOw==
X-Google-Smtp-Source: AGHT+IExXLuqnjsTfdCxuy8qLLRrrMLxa413a+cGAg2uTP8z9W1yIZc/Tl276ZHZBJEFgApMI+o1JAPFMaKt
X-Received: by 2002:a05:6602:14c2:b0:8b6:6784:1bb0 with SMTP id ca18e2360f4ac-93b96a4f061mr511232039f.10.1759511535826;
        Fri, 03 Oct 2025 10:12:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-93a7d53aa6bsm23748939f.3.2025.10.03.10.12.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:12:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28e90fe10feso36209675ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511533; x=1760116333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+rEM9+wzhaFVPN9JNs7nDiRdjo8ZbQobpK1PNdub44=;
        b=NYINhqs+6dDF1OLfX75bQPD7k3YogbGvBygDhXYak8GJGSzPJ79GRnBGhTlqMvkJqN
         69tEOhf8e9wm0pWMYIjk9aYWiFiY3RnyL2f08uZIXTQqAMBxzEfcHCc5r0fhBO5mpdV2
         1PSMx3GaMdyV0A4x9q8QYUxtCMkvtp25y4fSo=
X-Forwarded-Encrypted: i=1; AJvYcCV9X/u3ou6kMGuUnXsQadcSrcoGVwquTM9s3Asb8SxhK8DuwR9N900QCMAS+Wj+J/hzBvvLaTFx6PvDjEE=@vger.kernel.org
X-Received: by 2002:a17:903:2f04:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-28e9a67faadmr48169835ad.47.1759511532901;
        Fri, 03 Oct 2025 10:12:12 -0700 (PDT)
X-Received: by 2002:a17:903:2f04:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-28e9a67faadmr48169525ad.47.1759511532505;
        Fri, 03 Oct 2025 10:12:12 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba1e3sm55227475ad.75.2025.10.03.10.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:12:11 -0700 (PDT)
Message-ID: <196ccd66-18fc-4e0b-9672-7adaec550449@broadcom.com>
Date: Fri, 3 Oct 2025 10:12:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-4-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251002210426.2490368-4-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/2/2025 2:04 PM, Kamal Dasu wrote:
> Added support to save and restore registers that are critical
> during PM.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


