Return-Path: <linux-kernel+bounces-778390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F61B2E4EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90641CC210F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F7279DC6;
	Wed, 20 Aug 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="yFKNgzIz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16217274650
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714479; cv=none; b=Dgn214PUyIoX3/StV3355igLqJXZGg0wxXpsl4h3H6RgaVx4TIXXhMIlL3GS/BthX8L/c28roW9HVpGxOB8jUSo0vWf8V00KZGW0D40hyRrmhU2CSvmikY08VczXcLuwkeXbBKKHMhk7TyT1RiBcCPlJOjOydfQYd7oEDRQkBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714479; c=relaxed/simple;
	bh=epICB6jVv4l91QaSUZCtYLQ+aCm+xHSlUTQPeCzhx+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUiyN0zZ7ZwPHSKBN9D40uh47NW92lnMVoW8fLeLBLk59hHVWP+Es6EGHQ+Rk26gLXfNGQm+/YsiMxmBRZ+3ZxwIqD2U0q090mIov/K0B9n3ttEIKghaMKtzhNguYkuqO0ztmD9oreDwsL2Unm8L+v9G1edZBLx64hlb5QWHHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=yFKNgzIz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so970705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755714475; x=1756319275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NPVQBMSrrf3jhmLLcgVMSadSNRoC9cJI1+fcHorCmY=;
        b=yFKNgzIzGMLu58HxIBl+pwfGwhBNqpn8/1CfyIE7wCzDFDo1ds+PAnFco75EH5eRp+
         BTQHWvaoiLNI0vsRSO6ti1k+NprtN+F0wT1I4bQlNj5jngJMj7xzuRz+LVlUHBjC4G7X
         mvTFhq9WVIdrZaNtDniWOKW+s5Nw55UzU5i8l4Fvctk4cMSAVdFZsu3KpL4iVBvtn4o1
         rnJyfmlOncsP3yoY+j76TjSp4aJ7VvRr4c7fkE0fdzqVZuvycjWHJ4GVVydALaF5NJiF
         +WF6iJkHG6x8T7XlWui9Mt90OswPTti3U6S4vtmkcp2c/Q9bQGV/NnHYh6miBfI/TzlK
         CvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755714475; x=1756319275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NPVQBMSrrf3jhmLLcgVMSadSNRoC9cJI1+fcHorCmY=;
        b=RwzLtp8dt5D8r5SoHCeEVFKgdsLin3mOhRr8X37ZtQg4W/M1+agRjhYKhBU6OAoVos
         SO6jPPlrRQpW5Ornuq0Rd1SSMsjQTg709YlBwK7U7YjKOYjt0l+g7AAM3g2bZQat/FR9
         JQKNMDhsd+Bsa3xn5O8l4kT+d5mCemStDdRlpvWxBC+dI62hNDZ9R8T1Q/EkMgAAckF1
         5rzLwb3sMgndExhtvFVt0Stxo14axzczjg8uocluG3xfGKLIQhdQTa6Yxo/jAeUNEeWo
         P62mqdoQOxZmc0WEJIUrBBAs2CFM4IWWlaOUjcNQ2OK6cR1eqLSWYWQuLuR8iT0CdjZE
         Z9fw==
X-Forwarded-Encrypted: i=1; AJvYcCXghWe1BxIqVxs7NHAwI9eVlJtsmS+rtuXNrgQAmTp3hM1mFp2xk2t8ojkeg2kF845b/IDHzfo7GX5Lh+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVGEjNmeYiigKjveDfnTO0fXyUs7cmzXBhsvDmhbgnlc0JLuw
	uVEJQLCuyPuTpo+ah+MTaUq8tNzl9ldwn6nCA9nG26gzqVBhEmvHjkepX42i/Tdn9hM=
X-Gm-Gg: ASbGncslzHT6DJjxw02P9uMibYsGZo64XA6/IAQmcVAgiauTPOV65eWX7Sk3KUhfvDp
	NjGsIW7UlUenhXeCCalxYK8zjmKlC7PETyf89o2gLVdYfG5RaTS0hCMuraGT+rO6PaaY2JaiBo8
	brxG79OHDlmSrO/FEgKOms0FyuyFKAvforjbn/b3z6SJmXIrcQGBuN7mmkOQ5CHyPXG7mlmrHTT
	wzEgajwr20Ev0D83RtjLONx6iVrhI6XOSium3A3x2h4PcISwPowAkm3n4+66Y/98fKYGhEf3ODU
	jEkSbYIYHFIkHsEwFWhKMgLRM8xi/RHtwJnhd2d1RDPu/REFk+7q1j0O/Ybaqd32rUSvtFb9czJ
	trxNVFNSRCJlrenqSHwTP4OHMjMBmvH0MJ1mfbUC/iEdhQoAITUVfhO0o4PDcD58s2GwFz7A9Qd
	Sxoy3OorvuWCYLhNn2SXRCSCc=
X-Google-Smtp-Source: AGHT+IGQKS3XqM+4Wd++Np9yalKPfzEFkK54upvYWtNTNYRTddwvhBFV5n3bYbpZpN+GCnzAAC724g==
X-Received: by 2002:a05:600c:4a06:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45b47ab2420mr21491235e9.8.1755714475079;
        Wed, 20 Aug 2025 11:27:55 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:7e73:cf38:ddee:2b1d? ([2a02:1807:2a00:3400:7e73:cf38:ddee:2b1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c310efsm46093025e9.7.2025.08.20.11.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 11:27:54 -0700 (PDT)
Message-ID: <1a4a25d2-25a1-4d06-bba6-50f51cfbb619@hammernet.be>
Date: Wed, 20 Aug 2025 20:27:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: spacemit: add UART resets for Soc K1
To: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, elder@riscstar.com
References: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/7/25 21:18, Hendrik Hamerlinck wrote:
> Add reset control entries for all UARTs in the SpaceMIT K1 SoC Device Tree.
> UART0 was functional as it did not need a reset. But the other UARTs were
> unable to access their registers without the reset being applied.
>
> Although perhaps not needed I did add the reset for UART0 as well,
> to ensure consistency across all UARTs. With the current-speed set to
> 112500 baud rate, it matches the factory U-Boot settings.
> This should not give issues with early console usage. But perhaps it could
> be a good idea to let somebody else confirm this as well.
I have tested this version for a while and no longer see the need for
additional confirmation.

>
> Tested this locally on both Orange Pi RV2 and Banana Pi BPI-F3 boards. 
> I enabled the UART9 and was able to use it successfully.
>
Just a gentle reminder about this patch.

All UARTs are listed in the K1 device tree and probed by the 8250_of driver,
but without reset lines most of them are non-functional. Adding the resets
makes them usable when mapped to devices.

This patch is limited to DTS reset handling, so UARTs are usable in the
current state. I’m aware Alex Elder is assigned to the UART peripheral on
the wiki and will likely handle the broader driver improvements (DMA,
clock updates, full baud-rate support), so this should not interfere with
that work.

Thanks for taking a look!

Kind regards,
Hendrik


