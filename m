Return-Path: <linux-kernel+bounces-801474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EDB44566
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CF716E524
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825F3451AF;
	Thu,  4 Sep 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DIORHLdp"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDE343D7C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010523; cv=none; b=lUyg4L8Z6MBA34LIWEYTsAPRj/AIS+3UE32lMEQtntvnj/JidPQxqA2HXtjDC9BEv6hyhWINfnRARiRZQvxS6jj8m8sL76i21k7z3aldnwOXXwGDoV4EbpVbmRDgFpTK9sw6xkM9ZHM876IgLJnkm0z3hQaZ8B5hPEQUp7ZNcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010523; c=relaxed/simple;
	bh=q8yl9UAC+xlFQzwRViDxyj79HGQ8dK/5g+KGtqUhusA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=msgZC0GZgt807Tj6jG3NwOlK23alXpnXp8YBdWPTNZunYHl//RhGmvJEN/scKteRZvAlrJwcCRA3NOXcWHjLR+OKCyFFD57N7QoHcJ9f7Cdk/eAdJ85kGI0rU4a4Cc20SG7cIMqRLmlrYAyydmIFWgW+bxeJ8MR+WVtiOTWU1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DIORHLdp; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-77269d19280so1221518b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010520; x=1757615320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqK97eCKaUkliEvZf9Ytd8do9pTcU9xExLvP6WCAzkE=;
        b=gW31tc8DWvxT3PjVXZBux05xM0VzAlvvH/hgnBa4E6aeD7JXYLWuVWzvT/Fccnr9tD
         S2tZZHTS+sgDeL4bCs522Ro3XFdrx9mpZ530GT5+dPvLksLimy8saGB//hlZHt2HqBa+
         CVQbZwMSL6LiZghQzRW4oBjgdjLLygkWrtqW1ejQi3RgJ922fF4U/NWgfsLWEIJHslSl
         xKGqYQrWR+BspQSYW+M67H8DaHLAh889AywdYNPoj9aWEmwGksu+pU8VvzrUTDuGj/Z8
         eNlAV1FSgYuR/Sk8Kb4m938lTuUXa26WR5I3SGG98BPcRgMtPfMZIgIGyyCkYywoRN/K
         jbGw==
X-Forwarded-Encrypted: i=1; AJvYcCXLFyqGDvtizlrFZtNlq0+Q0qW9Ky6vNzzp5kr/tu5DIy0gm0Bi43NdpUf2xWABEpvN78IG+6LaQ/M01rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJyFIlCOQZ6BHxyXHtHAkkHfiU3SCNwmBJ0eV1UAbvXSISNbF
	l1a0DBnhDZEwiVEDVwrkurSH0oJuC3HMik9dvV++gSSGhFmSbBUz+PQ8hq2orlD3yG9kiEtcwR/
	XaIz1XVRkedCmKksoCkIHwGQIlWuPatLSLljIl9cDyPAWcQrxjf9E6kYYZX4OkwEffgx4d+PhYt
	1BHMfxlvFL3sw93UQ1ixdkCPNxmxv7UmCkV4p7ml0vV3LmdAskXoAF7p8gXU7EYsgAxbir1vABs
	6TtvaI6al8nPnzG7pyr0gN6
X-Gm-Gg: ASbGncuPnLjNuuqugc0if5Mv3X+f5XQaUJUfIx9jghKHaclYNApkEJTU2BNYaWHUjqP
	17a9JtUbxePNdYubg/ec4QJAqHXztA2qMxUmgYA70odL/PhFVVGQBcbQ7A/H6Itd+iFAjrvwlxF
	OoeyXSab03op1L22Z6oNXxqY30X8xh7IF39J1VfFJB44pHZZBH4mwqw3zZEYg9F+5SvMaP3UqU2
	ZPzC882teY0XvIneqH9Qj1ilj1W4McItaBQ0URYZHapxlqV/yPFdwmU2ognNIJoGfGK0VcT93Jz
	XEplz6bMtn5AMXyu/diGXSGfVSeTzqeivVWWv17+Aa7+Pu0n6aaKXptaYlLUdNuH207xu4rH1vl
	VZvxGaenhiIGIFWpyj6C6yTl/hAAw
X-Google-Smtp-Source: AGHT+IEdA8akcTbnrWXc16cwn2sY8j+LBmPRCxsghWWCwXkXNa9PybcLNvz62VEC+y1QhSADWtsy1B7QGR9e
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa82 with SMTP id adf61e73a8af0-243f5bae85bmr18584319637.30.1757010520437;
        Thu, 04 Sep 2025 11:28:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4cd006da91sm1351427a12.3.2025.09.04.11.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:28:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-80584b42d15so291365285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757010519; x=1757615319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cqK97eCKaUkliEvZf9Ytd8do9pTcU9xExLvP6WCAzkE=;
        b=DIORHLdp/EqOZ0P5Qkl/kXd90YWjjSXRaqwmRhJqAzj4YVI7EPh2UR/V19EA45JlBg
         P6r76Ga4pcV6L8iw9YYDabV9PQ2rhtzmZcE1Heno+EJWNC5A37clW9A+qHF6teW3lBpv
         7glolW5kWzqQpHMa+L3gSoqW/PEz3GI/wtEwA=
X-Forwarded-Encrypted: i=1; AJvYcCXc6og+SvfVecAChgbpqOcy1Qay1HPaa4MnvMFpTDK8cyWPosaiPvqmmyfo+Wqka3hs9oytu6YUr8k1Cvk=@vger.kernel.org
X-Received: by 2002:a05:620a:4145:b0:7fd:6709:f091 with SMTP id af79cd13be357-7ff27b20401mr2095667485a.20.1757010519058;
        Thu, 04 Sep 2025 11:28:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4145:b0:7fd:6709:f091 with SMTP id af79cd13be357-7ff27b20401mr2095663485a.20.1757010518465;
        Thu, 04 Sep 2025 11:28:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa62c789esm322292485a.11.2025.09.04.11.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:28:37 -0700 (PDT)
Message-ID: <d36c5597-e26e-4ddc-93b3-222d8b40dab7@broadcom.com>
Date: Thu, 4 Sep 2025 11:28:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH RESEND v6 0/9] clk: bcm: kona: Add bus clock support, bus
 clocks for BCM21664/BCM281xx
To: Artur Weber <aweber.kernel@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek
 <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Elder <elder@riscstar.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
Content-Language: en-US
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
In-Reply-To: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/1/25 10:07, Artur Weber wrote:
> This patchset does the following:
> 
> - Introduce support for bus clocks. These are fairly similar to
>    peripheral clocks, but only implement policy, gate and hyst.
> 
> - Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
>    and update device tree bindings to match.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Stephen, are you OK with taking all of those patches through the clock 
tree? Patches #8 and #9 have a dependency on patches #2 and #3.

Thanks!
-- 
Florian

