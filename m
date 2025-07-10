Return-Path: <linux-kernel+bounces-725277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7DAFFCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFD24E1BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964EA28C87C;
	Thu, 10 Jul 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df4LBgL8"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F31FAC48;
	Thu, 10 Jul 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137363; cv=none; b=Cd1vSvJnCkgILsJAn0YJR1N1dUPOW+/Em4RrD5ymvoaRJ2y0g9qk/aSwL91It5S/zq/UTP6VZOuX9oav2ULNOUE6s/3s3nSvLQ+fDwrmEm048E9RLTns3P726fGPa9n10eZId4H4V2tYq40dRKl9Y2lB38px4xNGtxG2cWUNT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137363; c=relaxed/simple;
	bh=3RHFIn5LzL5geguJnjASEbvN263YGxfFqRiUHFlsRjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjXD+mims0HAepEV+UL3xcX47KMfGf3xxuHl2TaAkmB+20IvPBzmQPfb2DdwS50bHixzQi39Qb3k0+k4dBAHrU+qBalZ1AZ39BmnXKKW45PMzmgTnm3LO1D5eqzidGFVYHEDZc3cUXWKO3KAcljKtb0csMmn8MrC6mLfL/1Nrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df4LBgL8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73972a54919so693996b3a.3;
        Thu, 10 Jul 2025 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137361; x=1752742161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4St8wiEewtafjCLkv95/UHopApTTK01r7uNxNA3DcqM=;
        b=Df4LBgL8odu6W1Xt4P8IZG93IvD0DUXg7RLxQ/0ksUr0k4dwryQKbQps4SouNr/x8x
         GtnvTkZC7VFXKnTOBMDVTxxhM1TLL73xLI3s0KWFwufjDofq0sv4iGt2V0XSabQp/ZwT
         ZXMfc6rqKOlcCZTOQtiustNdyxULDeuM4XdX5JuvYSudNiO0HL0GMr1qDiVOnrRgc8JR
         QPKCJHYRMethRZ1cTbKHPYGNVBeAp1GxONL7d297yKoJ8Bf2d7ox9iKG7tsuLHTH69f6
         Ly0Lnt2woYPdvPNm9XEFVdAVpFY1BmpjBcLSzCLFQRfGxOqxsmLOIg9W85h+7AlfDXqT
         uUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137361; x=1752742161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4St8wiEewtafjCLkv95/UHopApTTK01r7uNxNA3DcqM=;
        b=ACzrP3XGOSxAnXYUED4oJrwOtk734fa0ELllFHEP1i7PacHqqnp1uyAJs5pmh9m0OF
         oFu9qzChx8/e1W7IjZdBMuoApjFuE76zKrqFDglDIAKD1+dg9EDcl3wDabc6dxwOylRx
         VI+Ymd7pGm6k/Dkw/urmNDyMjL/P3tLeoWV94qnK0/7vFgGsqT8eg5qvQT0xW0Hh+AfH
         8twR3F09Y0Bshkec9FMkPJtneIVyd9tyrSdoYp8O1qQ5GxV6wj/dOqGig1ZZSwsF2GH5
         4pCqGEra8tcOK/05Vre3UBnQk7xn9JiOlHlBTy4/ChHlDIFl3w6XYyw4RmR+r8QXX6eM
         bzfg==
X-Forwarded-Encrypted: i=1; AJvYcCVSyuRlTHiDrSHknrwRQNSisnpsg+JhRfZ7WTbcIEKte7MdIKoTe9SyirQSkP7KQ0oWH7MBtLtk0D51IL0n@vger.kernel.org, AJvYcCW8Wv0/NDaPoDrq4eJn1XFNk0FaUH0Cf4HcPBZMvVrAmb0BtcJBFqh1EzqiMs3p9vEBLB+AdrqFj8o2@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvPp49uuo9XZYOWLhXv6Z2nu30WrPKw9ssmOIlYb6PLpL0nmt
	YccIO4apUK1ekmjLg3iDJmhYrom7/sU6oSMPlOUTU1/e/MPjy/pgyIgM5/76D/ay
X-Gm-Gg: ASbGncsLa+sF6xWg/yz6texEteHMSBw96gHwLDiHnqUXVsMk0p2t3//R+nE62GQm2vI
	aT+f8edFhXmZX6SYKQpFwkJOlMsllml+8gp2iXChe+X6ilTJTkPwI6exF+JnCqJCU8/FideGUAv
	kQAOalcQP5XvtI0srtc7uXqZs9wbTp5kBD4dD7enIeldPF07kO/IhiBKeZYIzr82iW7fQ00kzxP
	YTOuMxVlRVIPkSzzg+4ijfygOQ7AELf9omeiRalNat/+S8pJJQ2fUe/BmRY1oK76q+rNwwkBfQ/
	7hnRfsn9L6uN9ogS2gcmXBSIMmLv24odCgPSj5vqULdC8otCHnCFkONnjX7CeVy03A==
X-Google-Smtp-Source: AGHT+IELxBQvDmErAxf05p3FN8Jsp7n2KmWHwWb1Vm+hx7+9OCcdDHRpDaIZ2atC1291CnmVaO0fJw==
X-Received: by 2002:a05:6a20:2584:b0:215:f6ab:cf77 with SMTP id adf61e73a8af0-23005ab1ee6mr3246701637.23.1752137360945;
        Thu, 10 Jul 2025 01:49:20 -0700 (PDT)
Received: from ubu24.. ([2400:2410:dfca:c200:b9a1:a95c:e866:f34b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6c77basm1544702a12.40.2025.07.10.01.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:49:20 -0700 (PDT)
From: Taishi Shimizu <s.taishi14142@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Taishi Shimizu <s.taishi14142@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 2/2] ARM: dts: BCM5301X: Add support for Buffalo WXR-1750DHP
Date: Thu, 10 Jul 2025 17:49:08 +0900
Message-ID: <20250710084910.2093426-1-s.taishi14142@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708-elite-indigo-wombat-faa74f@krzk-bin>
References: <20250625154315.114139-1-s.taishi14142@gmail.com> <20250625154315.114139-2-s.taishi14142@gmail.com> <20250708-elite-indigo-wombat-faa74f@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 8, 2025 at 10:34 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Jun 26, 2025 at 12:43:15AM +0900, Taishi Shimizu wrote:
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200";
>
> Please use stdout path property.

Thanks for the review. Since `stdout-path` is already defined in
`bcm4708.dtsi`, I removed the `chosen` node from the board DTS.

> +		leds {
> +			compatible = "gpio-leds";
> +
> > +		led-power0 {
> > +			label = "bcm53xx:white:power";
>
> You should use rather color and function properties.

I replaced all `label` properties in the LED definitions with `color` and
`function` properties as appropriate.

I'll send v2 accordingly. Thanks!

Best regards,  
Taishi Shimizu

