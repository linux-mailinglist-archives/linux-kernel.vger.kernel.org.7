Return-Path: <linux-kernel+bounces-725273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA2AFFCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D493A2863
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34E28BAB0;
	Thu, 10 Jul 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtKgxgR2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6E221FC0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137186; cv=none; b=rH1VHyURHLPBgDfFaoFVJ2atb1bo9ZbiXDn5CACsDd0hvFqFbyUQxBOCLvB3H215h8Bn8qfE1zwULd2549oUGQUW90tGA/Z0TKnF+9KxJoZ8CoziwrH4K7nV9Gr0vO8b0ioKGwRXXlYFNOj2dSP4430qhVuqAKdnyPhwMGZ8P5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137186; c=relaxed/simple;
	bh=EztoCdmnN/TXMn+viX2gSXCCexeXv26zbr8Y3UvqK/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ak8i+OwEq5WzuNrOui5UhIOsnOdQwP6bMbwjr0ZlWTjUHf5lbQXdPeIOsiZ7q72hv2v6mrnmq7as9kNe/pv416jq65/6aVoq4BfAx/vxmCcPb/vXIzdRgf6JK1jgJRjo2KyV9PYCaafgiObbhORdA43qrLtbwSZzUEtnCopjE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtKgxgR2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752137180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcvUi1eWySw/QvrSjzTNvr0wq6k0z0sn5FSsYfU//w0=;
	b=TtKgxgR2MRq4/kloNCkX/7392Q7idXug8aUeTGFn7GEejE1oYmQgNur7sF+Tp58kv24HVq
	40ArWu/1McmW+ysLoWHEZK+WBdC+hrdQngrvI9iabEXTPgJ+5D7w4pmZFdPWpbz9yiVF+B
	qMpy5mEbyWuMrudgG6RSl5za3MN09tc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-E8cbXnTZPVi4QM3DFR2FTA-1; Thu, 10 Jul 2025 04:46:18 -0400
X-MC-Unique: E8cbXnTZPVi4QM3DFR2FTA-1
X-Mimecast-MFC-AGG-ID: E8cbXnTZPVi4QM3DFR2FTA_1752137178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso4209535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137174; x=1752741974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcvUi1eWySw/QvrSjzTNvr0wq6k0z0sn5FSsYfU//w0=;
        b=Jj6hpcl2DHZthYytA4+9wAipVorPcEUtOsnlCuZF+WjwizAk+WG2ZjjW9BRXKQgBBs
         BHFqfoPz1KXD1L1BnpISgjTLuGahOgZO4W2dOBGee+iq/IrxsU4zIuiUJmI2e1jQhFFt
         TFaOEeoPF8r6ecpAEcJPldAtxvo7Svcn9wllYlyYhkLWGewOtzHCtEGMfytIM/N3qFBU
         5kJwXjlxKs/Ozdo+f7ya4IDRVPi11GG7OD4oIIv5DmIp3KSd5kK2NTg7s29NhRKinQhC
         LZAvHLsLwTqQXJGccqDrU0MTvPY4E1ldQmbhwmLG3dm2cbzos/X8kyh/8OgiK+QQEQMg
         0piQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXLBv+/TDJYDDEUFPbft8dsffFAwkMTV78QBwE99AE2LarO2jNyS+dyzMasYkyQytHvQdNn+mkKbSEhwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpNVLnSHyUAgEl7JKZwrYpMWsXEy9sNEe61RnFuYrsrqvDdtP
	hZEtglPbiCukjMXPWPcvpwE+CftN9zD18yC3CAoPcaXt5yvYAjDGqfBmQk5lQ4KADHQKdr/rr0a
	ZfdhtxiACQjn2t/R2qJBSZQOa5g4vHfp4vI7xoQZ3+QkxXSv5NDPEaH4d08SrMGLhsQ==
X-Gm-Gg: ASbGncsAFjb2xkTnODV5i4dkzvKe+zY4jkN9r1l5PenoZ36aVZ1Iup9u0Ufd/GXFb2I
	YwJdMA4R76cvkvUvN3gaKX0ccTURF+MLHOu2VdONP2ulOlBjcwQOK3gBVRImCnYaDkp4FdHkicr
	CF7+3GEbQ8pBXOA7PCTg7sHbZxRcMs9/qFJtpQ9orCK+ujHYjWqBnkdiZxmR9toHgUNb/oAhOJz
	BgcwawIxs58ujc825n/uo5cFoxYLOwQIDaRDKyub/c51nIkQs07wjzASbqgAjBiygiWkbh+7H0j
	R16SpHRK/3trnJ7Xl9vJlgk6Ea5oIk1ZsAcOL/tgUR5HUmhK+G2dHmWXCoypKoIV6YudSw==
X-Received: by 2002:a05:600c:3484:b0:453:b1c:442a with SMTP id 5b1f17b1804b1-454dd2da8e3mr16078105e9.27.1752137174101;
        Thu, 10 Jul 2025 01:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9XyxMXdYoZpn8IIlQVwQGwj+KmG1H3Io1MO0RxQQcPIweg50djQVKai1ZJSnE6gFubwUIA==
X-Received: by 2002:a05:600c:3484:b0:453:b1c:442a with SMTP id 5b1f17b1804b1-454dd2da8e3mr16077765e9.27.1752137173686;
        Thu, 10 Jul 2025 01:46:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50def1fsm50985345e9.21.2025.07.10.01.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:46:13 -0700 (PDT)
Message-ID: <a965baaa-c4e9-4d99-9143-466b11bc19f8@redhat.com>
Date: Thu, 10 Jul 2025 10:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: Convert Marvell Armada NETA and BM to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702222626.2761199-1-robh@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702222626.2761199-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 12:26 AM, Rob Herring (Arm) wrote:
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 5d2a7a8d3ac6..741b545e3ab0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -21,6 +21,7 @@ patternProperties:
>    "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
>    "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
>    "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
> +  "^pool[0-3],.*": true

The 'DO NOT ADD NEW PROPERTIES TO THIS LIST' comment just above this
block is a bit scaring, even if the list has been indeed updated a few
times. @Rob: can you please confirm this chunk is intended?

Also I understand you want this patch to go through the net-next tree,
could you please confirm?

Thanks,

/P


