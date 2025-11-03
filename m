Return-Path: <linux-kernel+bounces-883383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D75C2D4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04AB42050E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C327FB0E;
	Mon,  3 Nov 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeUb1BK1"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C03164A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188607; cv=none; b=m80nB8s5KcFzk+6iWuXW6n1vNrzQvSRgTI0G3Y2kKi1sJ2lfchww56MVaT1GNdixRe695JML33FEEnr/bXqmHNC+zIHbb7w6ytK+Cl0Yu936TJRm7v90Ii98uF9IV/bYWXp9dx0RuKMZPgpBRtpe9v959+cetdD92gIUhaqj33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188607; c=relaxed/simple;
	bh=ko7lB3r9pVr9dkY2BmFRFzraWZf018hcoS0HId+I4M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dc2TqcTWURqhYoL2UH7gJM+Hn3VtE5QpIIS6tv4wNEW2pjftZgVuOFxhNjAaOwYf8QnhvWolFIpZc/LcnGxcZiHXKfkkPpBJ3GnIBTbkfkQ0r/R4LI5N0y+HnFd6D2FupLQOFh2NuX1ESq6D4DB1ilpB3BDg5rMe1m4T2lQou4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeUb1BK1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88043139c35so31705576d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188603; x=1762793403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJCa++upS3Lwr+ZLn+k/k89isaF3M2n4b8YOGE+2huU=;
        b=UeUb1BK1WAnhvzAKtkI7B4IPTqQrNNExqAL9jJcWgda822sALW7i59fyVKRZubNluB
         3I4csk150vyMZ0OQnpZksrNsQAKgZyon0u3Wevr4mVxveb8nm8qJeIkJd4fA2p+ov3jv
         P5fncmTjhHVGeiL7dYpH9SA/TVJ2z6R4GSbeYYbt9RdFNtG0NQQWfPIkVgCT9lm5t8Ud
         sds4bfGzAJYVUolHkK6QK7Q33NbnyjHy+O3LV/jAfJFgI1Ivn8AzLY8ZV5YhIq07moLV
         HLYisbwbl/n9Ys2UOzLwsdYlliBW9LUUTzCzEIiKf29OWtcVe4NpIH4CW3zz+4Vql5Q0
         PKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188603; x=1762793403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJCa++upS3Lwr+ZLn+k/k89isaF3M2n4b8YOGE+2huU=;
        b=Lv8TjpcdRHSAVa7EHJ8TQohph/ZCY/fX1keFNaemluWfOs5LOVCxr00UNGbGue8YI0
         8/v9k5B4gM9Iqqm0v7uhm2H4M7s5OOIu5gu/DsUwdCobxHWkhi5Lli8GuQGnXyHrlO2x
         //W8RyUCk+yrfZkKK+CYjunkpNZoFZIoo5djPt6Lb04t/aXU+EcFZo/ZwG5tp6aofkc9
         ywswAPCy2gVFNIgQ9KaqUlANLeHFVP5D7VXmIZ2JIb2+bmTzd7ew9bdbaHMhNpLLGqT7
         KIgUHUHoy4N8uJ0GHHoJVXn2gxB+L+BshPfoYMXUtb02iifCyKI4/oZmOg3i+x1yXlv9
         XPAg==
X-Forwarded-Encrypted: i=1; AJvYcCWV7+sklwZjcncUYca9O+GNWCNrLoyn+ILhllUF4fbLDeKugKXIG8qdm2iW6jNZFd59N451fE6scvX9GG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLCaCqv03MGWubChLq5cDlN6LTHHScu0unNLIKZE/6zs3NTlS
	BvWUv20SZqzMoI9DdqFCnNWaWxMVL1rpOuxTgSPFLZcTqDyxdXHsdPgV
X-Gm-Gg: ASbGncvSdV17KD76G+2XGMjE/C4hEmnPj563YoF206vvdsKZVw0RB3LunOPI8atrES0
	LI7GZ/gtWedxJIKBg0HIIMYGU7VguPHOIMumVr98auB3OooYy02FHAwaGMcVFDVpG8Tu8sKW/tq
	IZQ80nY4EAH3boFQyoZ4VxJn+lPczDNFUdIxuVHUPw7/lnny8UmkljB+DB3udHpC5iJEyEvU+yT
	2XI+V+AFuai1pmYdVPd77z959xvzmDzKvPNITN10nDAN+xELFB9DY8AC/UkdEZPAoiamC0DYLHE
	rGVXG7Jr4YK3cxZ+MWix6zE2RvlKu43S519wScXydn6gBU8mQzgIevooFlh86vrFBT1qMdW+fDg
	NVtXDb6xSRrzjr+ZmigQabvaOQd/cYzuEQCtxjDSdkbPliBKEW/dPS8E79qsx7Khbfsp76PS9h/
	CSG1HkvUmU94abvhN5N3d7ntvIpwY=
X-Google-Smtp-Source: AGHT+IFni8jZUvZP39hkL45Jl+M1HXL8vO6F1udbgLnU65rMefyg3UKyqfPWUZEunlxBVuwBiSpv6w==
X-Received: by 2002:ad4:5944:0:b0:7d2:e1e6:f79f with SMTP id 6a1803df08f44-8802f4c82e8mr219322526d6.47.1762188603195;
        Mon, 03 Nov 2025 08:50:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060ded862sm4878056d6.25.2025.11.03.08.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:49:59 -0800 (PST)
Message-ID: <6edb4435-e641-454a-9722-70b25c775151@gmail.com>
Date: Mon, 3 Nov 2025 08:49:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: net: ethernet-phy: clarify when
 compatible must specify PHY ID
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
 <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 00:13, Buday Csaba wrote:
> Change PHY ID description in ethernet-phy.yaml to clarify that a
> PHY ID is required (may -> must) when the PHY requires special
> initialization sequence.
> 
> Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
> Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

