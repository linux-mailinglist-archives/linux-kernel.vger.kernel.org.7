Return-Path: <linux-kernel+bounces-855373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD446BE10A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0CCE4E2C96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540D31690E;
	Wed, 15 Oct 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZl6ziQE"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73323200BAE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571583; cv=none; b=ENnQox1p8T2vfw2lccESjwnLlTikR+mj6ylq34mA9Z/x4iNpTo7h4T6gdcDg0WmOdsNDw/EuETyPETrCed77EE4rQy0rwfqEpjwpSK1mUqZswLzEKGaNLNfTEXHJzuKP1UjZHw8liIoZDPWMGbtbNkbphqUlGOAcBrP1Rc5cK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571583; c=relaxed/simple;
	bh=pbGnn886v9/iV6WNOEHWo9MCWG5V952opqaZM9xYSd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcQoke62WnLhASusURPuFss6ArI+tYeyQsaoP5B/qVonWupFKHvafXln8jYqlxGcukMi+AS3WqitXoAESX7KJoyl44ZT4O6eVsiFR0DAPGfTntpWnqizfDYd5lK0P7FD0bSWGAQbWnOnzcrOUS/qA5YdXaNTZTJWLIjyNccVHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZl6ziQE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-92aee734585so4457439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760571580; x=1761176380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk+SQ0nV/xTHl/QRiiwtWRlkyDcwisMEuXdFP5NTe7Q=;
        b=CZl6ziQE/Mpo2IeyW1kiX9ukEnjG+OPjUUgGzKE+ixxpy2UWMcx/45isNm+84GJ+OU
         yNbvO/6hH6CnpVPzMx2CYWS+E5S5lQCwSPivuSCB7zRsrFrtdvhK5F14bf4Ofoh5vqrI
         YxE8opEsC/LiyPX0LRCfNVnKs9EEILW5bPJtPPxW+QHnCGZs1WISgOJ7By/ZLy0qVQoN
         t/ElXyy+MR8ZqTykXOc83BvfPG9dJt/nvawiGHN3Pt6T6rb8+maR464Dj4sQ+aIb9uY9
         paFlMcOmTGrmgsl+FxyvCIl+Wa9XHMRyu91gWx5gw8eUcFTVd81nlxoUcvtlDwOa04XD
         mbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571580; x=1761176380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk+SQ0nV/xTHl/QRiiwtWRlkyDcwisMEuXdFP5NTe7Q=;
        b=HRtqmTp9eIEDfePgX1liWbOPF/XH0LufOl/TKh5p7ZU7piiGCOPnk5LNDvS0hP0Eis
         gDK6lnBIkVPmbFMkyzp3xxT9nFkTVkSuL8ZNqBcfZ7xhGzejQfaJB7iNvWewohn5JUOs
         qM5uTYbYKVH3pEB4IySBTMpzmBzmOaY9C4OJqvrwA47RU1+F/PR+VGegeHBJOWjVLZAZ
         jnjY42abs9zwMYKRG3p+M/1ujcoO0ZhrJVquXqI74FI18Edb0SV5SOi4va+W37W+HDPZ
         lNWWxFPLFWAvx+e9D7KFvQb6BgmvixebOaTkrn0IRwkMNqeEdlIomqUQ3lvnG48JGkSi
         OrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzEirPYqEPxJTWjndsGPMPfSxnUyJO8jz8TAH/BFebDdEw+aCITfSy0HDmvt5PrvKy1b6ChCkWs3d2EGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIk0xe0zCuSTlpyk2F0X7mswN+MxhFBPLleq15JiyGq5UuAodE
	kIy1Xrzg9mj6iLf9EFMJ/rnO6+M9bXZ9QqIhnZew5jJhtQkiojT4m1Z3VhkzPHpQDKLJ3GiXnKA
	NC1jeYnucb9MGoEAPyL7qn6SbL1zG/DE=
X-Gm-Gg: ASbGncva/ZsweYQyflgsbpzT1g1uK39Y8Ds22w8FkgGHfpR/CNfUHp3JPxjQ16U/toS
	FvPoXP/PVMSlZgPQxE++ZWEgDIiWWo6drzc1jfWPBxak/ZSFnD0JUDaKAZPGBR8x3Qmzd5tA/wb
	Psu1ZlpMlXyzlRAtyMhs9tlcqulknUQd2fpLbZOFsN9jbrJVbk2MODE4XhgE9RvloZKbKb46G8Q
	PF3NSu74KH9D9fBQNOcJ+r3+V9/Lxrbg+gsdfdQKerRecIB02994Ja9NVTj5aGXJxYZ/A==
X-Google-Smtp-Source: AGHT+IEcIxNtTE95uIryf8Gym7Y7/YyBX/ZIPEjsuX/aV24yOVx1CHemVjFnhpAjtmhcscO6wWghMWqGt0NHWRxNo4o=
X-Received: by 2002:a05:6e02:1c26:b0:430:9fde:33d5 with SMTP id
 e9e14a558f8ab-4309fde35famr126566775ab.11.1760571580464; Wed, 15 Oct 2025
 16:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-rk3588s-cm5-io-dts-upstream-v5-0-8d96854a5bbd@gmail.com> <57969F385B5AF318+653dac83-8227-4987-84c6-f3e08b10085c@radxa.com>
In-Reply-To: <57969F385B5AF318+653dac83-8227-4987-84c6-f3e08b10085c@radxa.com>
From: Joseph Kogut <joseph.kogut@gmail.com>
Date: Wed, 15 Oct 2025 16:39:04 -0700
X-Gm-Features: AS18NWC8PAl5JzrjFfy3LdnbAMpDuCQdDlF0Mf4nMlDHPoRQzsSdRAuL39arfdo
Message-ID: <CAMWSM7iHtAxewW4JkRqRsifVnccqeFviaCgeOyprKDr92FOurg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add Radxa CM5 module and IO board dts
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Steve deRosier <derosier@cal-sierra.com>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Naoki,


On Wed, Sep 3, 2025 at 1:28=E2=80=AFAM FUKAUMI Naoki <naoki@radxa.com> wrot=
e:
>
> Hi Joseph,
>
> I'm thinking of continuing your work, so if you've already done
> something, please let me know.
>

I've not followed up on this series yet, but I'm planning on picking
it back up this week. I'm happy to collaborate with you, do let me
know if you've made any progress or improvements, and thank you for
your review earlier.

Best,
Joseph

> Best regards,
>
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
>
> On 6/18/25 07:11, Joseph Kogut wrote:
> > This patch series adds initial device tree support for the Radxa CM5 So=
M
> > and accompanying IO board.
> >
> > V4 -> V5:
> >    Patch (2/3), per Jimmy:
> >    - Alias eMMC to mmc0
> >    - Remove unused sdio alias
> >    - Move gmac, hdmi0 nodes to carrier board dts
> >
> >    Patch (3/3), per Jimmy:
> >    - Enable hdmi0_sound and i2s5_8ch
> >    - Remove redundant enablement of sdhci
> >    - Enable usb_host2_xhci
> >
> >    - Tested HDMI audio
> >
> > V3 -> V4:
> >    - Fixed XHCI initialization bug by changing try-power-role from sour=
ce
> >      to sink
> >
> > V2 -> V3:
> >    - Addressed YAML syntax error in dt binding (per Rob)
> >    - Fixed whitespace issue in dts reported by checkpatch.pl
> >    - Split base SoM and carrier board into separate patches
> >    - Added further details about the SoM and carrier to the commit
> >      messages
> >
> > V1 -> V2:
> >    - Added copyright header and data sheet links
> >    - Removed non-existent property
> >    - Sorted alphabetically
> >    - Removed errant whitespace
> >    - Moved status to the end of each node
> >    - Removed pinctrl-names property from leds (indicated by CHECK_DTBS)
> >    - Removed delays from gmac with internal delay
> >
> > - Link to v4: https://lore.kernel.org/r/20250605-rk3588s-cm5-io-dts-ups=
tream-v4-0-8445db5ca6b0@gmail.com
> >
> > Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
> > ---
> > Joseph Kogut (3):
> >        dt-bindings: arm: rockchip: Add Radxa CM5 IO board
> >        arm64: dts: rockchip: Add rk3588 based Radxa CM5
> >        arm64: dts: rockchip: Add support for CM5 IO carrier
> >
> >   .../devicetree/bindings/arm/rockchip.yaml          |   7 +
> >   arch/arm64/boot/dts/rockchip/Makefile              |   1 +
> >   .../boot/dts/rockchip/rk3588s-radxa-cm5-io.dts     | 486 ++++++++++++=
+++++++++
> >   .../arm64/boot/dts/rockchip/rk3588s-radxa-cm5.dtsi | 135 ++++++
> >   4 files changed, 629 insertions(+)
> > ---
> > base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> > change-id: 20250605-rk3588s-cm5-io-dts-upstream-f4d1e853977e
> >
> > Best regards,
>

