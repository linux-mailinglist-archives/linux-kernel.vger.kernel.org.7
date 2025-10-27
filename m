Return-Path: <linux-kernel+bounces-872399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58AC10BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9837504803
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C0B32A3C5;
	Mon, 27 Oct 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVDAqVFe"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF032D7F1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592139; cv=none; b=BB4tzzHTD4YMtBHhUY7n9OLNu531NSGGHQlSSlS+516CrpM+Jnn+DXKplXsOP0TB/mv2c4PfnpLGSJ99mBF44NHfCgBE+CzfEN3YwvzHyXBn19L3iPwXY8OQSSPN0GA+7nSmlG/EON63617mdo/ZG0Te+HSwJzjEXDJmXxHe4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592139; c=relaxed/simple;
	bh=QxAPAArJ2hq4vlV57zKRp02JLjE4TuXvuBh4ghAfuXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARvGU5V1k7eXwsMPfGl43c9cEmSPCq6N4AYCw7rH8CRCU1w9CFA6u79RkyqsnDPYQTgqjp6HjTN/7DjAp+kuJUMqB2+lwdPK7u4uLS/DBjzUhutJGGYeLSPcKb2shEz0mWZEmY71gUcmnUuKJMSad6e1Y2SbgKmjoY+zG1BtkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVDAqVFe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47103b6058fso37111625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761592136; x=1762196936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrrBuaV/kWzQy3h0bP5iIsIcB+cyHk6dwoM0ppsVeCg=;
        b=AVDAqVFexAXuywH6VVGtaRJVIJi2WR+acsspYhpLIhrthz3pfUqj3mM8XULAofhDRl
         qgaxXrfU91EClNffpX0sk/uSm7110B6UbZ92j3KmKmreZ9eyi8lciaQ7Ub5NyBy/9pbv
         Qqkg64Jtb57Z87Rv39efksoK0Lur3wLKIWcqCVPPANkpJCQansOznMFnuj+U7PQ8iTca
         Ka0h9aMVhN6cyClwuU6keEnuW48Dh5qi64tNGIoJzTunUt0gYdczcJtSbj/aSSpluJOe
         PpXzAYC4NmOUOPoDVvnsza3MfySQAi/3QnrU+SSH0JqZiSsLi0D28nqZ3bvhWj0Pet/s
         e0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761592136; x=1762196936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrrBuaV/kWzQy3h0bP5iIsIcB+cyHk6dwoM0ppsVeCg=;
        b=sG5Dirk//k0svtllWUTTHMqroxJATSbEnipSGRltcXvc2aaOJ6qJVqQkRmg/fecyJq
         UrPx1Q5DVoxXj0alX5oDgoTwiDsvSvUN+aTnOkX7C34xe9eqUcGVyrQwFtRs4+T3RAJc
         MvRChH/aTtb0RDRms9nCSHkHHfNqsI6lkTGJc3E4jKK8jeiUSmUPMNkdp1oBkc8jtV51
         eN3byi15ui7CxVnIWOjEIhHIZZi+r8aa4zMCnlLueiFWTaNxrfLemvwi/Pi8FLT3Eu/s
         l1hb3HBHAj+VHadtKs56HvdidJ+MQszBpdTjkTQjioUMy8CqLmYuGLJxV3P2lVkX7EC3
         wnFg==
X-Forwarded-Encrypted: i=1; AJvYcCXfnvJpp/XXpCZg68mxPGGHFJsmq12FDfRQM4UKjpaoT9MT6aCsufOybOyQsY5lTc32ifniNhnxqw9M1QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDMQ8HtaUPBeVDfvZzJIB9RAJOPGu6mQHmNP9PqLoUOvHejat
	45JkdyXWhFBinfb5pOJK2BhQTeLf1Zw0SmO5Fsf77gj2RGrAmMGel6iR
X-Gm-Gg: ASbGncvhYCldV5BybxdCfzcz5OMM535Ve4LwFuXLl0k2/ZzwhugixuArca4BnaNQZMv
	0mRNnHWWq8d7UmSCu/wCz5Z/ZM+KsPki/O6FJnSDtEpNs38c26zWTkxtK24jJNnaJ8A3ejzVx0t
	ixYYxcOKxd572YouTC+pVw57AJFZTWPcWQ8/XQIyOCnLMjoBSsIyOrqGLrggjBi1NB6NZW8p1bj
	3UCG1D07l2CQvSHvsZY+q1Z30wplAouCDTzPIu9oJtbEfIYg+VaF6d+6/q/tiCF28kmg189iLu9
	j/PTCUKPfM032rB0PvSWo7KsV3gBGBeu/3eNXwFS7bYCyVlXRI6u0IaQ9oJb5dw5fjuPxZ9/vDW
	uiD6AZpLL8xgahlauzrvnITEjzo0nArLYJ4HH4/5KAkYZRiC7mqS8Q5T7JeQQk59Ddt8+zXhmXQ
	xSfNEr0LKGxmVZNEVdZlisSmH7s9lNGl3wREF5EamURkIrXefIZ7rJeebZC8QRHFX2F+X+L4TSH
	6pwgAeDixrZUoipjLVa
X-Google-Smtp-Source: AGHT+IHQpujKOrXJVzT+iAH4rHZKqaP7yZUXY5b+4r1SO7Gypfz170ZMy3c7//TDLo+TKI0txclzNA==
X-Received: by 2002:a05:600c:871b:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-47718d7bfa0mr665135e9.7.1761592136000;
        Mon, 27 Oct 2025 12:08:56 -0700 (PDT)
Received: from ?IPV6:2a02:8010:6606:0:1cb3:1c74:2f0b:e9ac? ([2a02:8010:6606:0:1cb3:1c74:2f0b:e9ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477184e4006sm2064515e9.5.2025.10.27.12.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 12:08:55 -0700 (PDT)
Message-ID: <d583ee43-38c4-40fb-b33b-ce3153c9723b@gmail.com>
Date: Mon, 27 Oct 2025 19:08:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: pwm-fan overlay for NanoPC-T6
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251026194858.92461-1-sigmaris@gmail.com>
 <CABjd4YxsfxwEbic8QEabX1h9j0B3DBw9LWwctJx7SzdvXZdDhA@mail.gmail.com>
Content-Language: en-GB
From: Hugh Cole-Baker <sigmaris@gmail.com>
In-Reply-To: <CABjd4YxsfxwEbic8QEabX1h9j0B3DBw9LWwctJx7SzdvXZdDhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/2025 09:14, Alexey Charkov wrote:
> Hi Hugh,
> 
> On Mon, Oct 27, 2025 at 1:09 PM Hugh Cole-Baker <sigmaris@gmail.com> wrote:
>>
>> FriendlyELEC offers an optional heatsink and fan addon for the NanoPC-T6
>> and T6 LTS. Add an overlay which can be applied if the fan is fitted and
>> configures the fan as an active cooling device for the SoC package.
>>
>> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
>> ---
>> FriendlyELEC heatsink with fan addon:
>> https://www.friendlyelec.com/index.php?route=product/product&product_id=305
>> Vendor DT with trip points and PWM duty cycle values:
>> https://github.com/friendlyarm/kernel-rockchip/blob/4944602540b62f5aad139fe602a76cf7c3176128/arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev01.dts#L75-L90

Hi Alexey,

> Is there any downside to enabling this unconditionally in the board
> .dts?

Only that it goes against the principle that the DT should describe the
hardware; the board .dts would describe a cooling device that doesn't
actually exist on the base board.

I guess then in theory, an OS might allow the SoC to reach undesirably high
temperatures if it's relying on the nonexistent fan to cool it down. But I
don't think this would be an issue on Linux, at least, in practice.

> Overlays require more user configuration, and not all
> bootloaders support them directly (e.g. systemd-boot users would
> struggle). Compiling with overlays enabled also makes .dtb's a lot
> larger due to added symbols information.

Nowadays (on Debian at least) using overlays is pretty easy, I'm using the
u-boot-menu package in Debian, I just copy the overlay(s) to /boot/dtbo/ and
it detects them automatically and adds them to extlinux.conf for u-boot to
apply.

Couldn't systemd-boot users just use rk3588-nanopc-t6-(lts-)with-fan.dtb as
their single DT to load, if it doesn't support applying overlays and they
want to use the fan addon?

FWIW, I haven't noticed any problems with having a larger .dtb (using mainline
U-Boot to load it) and several other RK3588 boards are also compiled with
symbols enabled already, and I haven't seen any issues reported with them.

Best regards,
Hugh

