Return-Path: <linux-kernel+bounces-846390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 839EBBC7D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D523B4F579B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6502D0C7A;
	Thu,  9 Oct 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sVVYuFPc"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AE2BEFE6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996767; cv=none; b=QP/xG5SgObZ+em+bYtIyom3RqQKEmV9WdK1D7PWQp2xnkvXneQod2OQIkOv+cKvDAV1TPJXNXlKx1IXP1xpl69hV7KsVy7MDYmY3/l/RiLjjSp2LfVeVmMbWINAxx2uqds954anha9OHyMj33/ljyaP/+PUCzkad+G3/h6qjY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996767; c=relaxed/simple;
	bh=r+EYS8LJHH5JzPOJqQR2JJIXOzlbTKM/eKWn1ocsvTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLSu+BR85LYH/AyAJT/aNLeXCW9Jw67BA7pQVbcKH/SZfdcAKP/dV73twJ3ZAtQfPsTOfuusW9HHRCOE6wkI1YwBEFz0Mh0LcIAlBe+bbz+pTWI6DF/YhzzLl+cVBcPYAbswjEQXaokxoIf/APqAobIr5aBf3LGeGw9Y7UQnGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sVVYuFPc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso617061f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759996763; x=1760601563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utVwjhO8Z9nfTT7T332+x9pXtf82IVN0SHJivYwFQFM=;
        b=sVVYuFPculI/UNQcEflmywDrpyCbr8lR1xv5hBdmnW5WdOWjiY26tYe5wDDO4lN0qO
         95TQDUEpgOH/wDss3vfVlT7ZhXWxzmXU1rJ4WU457wtdc0PIux0+MljPtDCXlzvq/KBy
         hVpS8orG4uPjQ86ZDFn1wPmGgk+GgLJEyQNcHw3L9u/2ThmmVHMnqIqVfTFWjKTCYeNO
         ucrfeuFrluMR0rXg1uJnq4ssXXzwK52f2hYzZRYUlXMqUyr8O0b70xYKvZiAteCD/dMu
         X5NMdr+HSF0dE+HbP37L2rh++2QMraOwr23n/F23tnKBOwYCNQkgj/FoG32LuXybCHe6
         c56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996763; x=1760601563;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utVwjhO8Z9nfTT7T332+x9pXtf82IVN0SHJivYwFQFM=;
        b=KswMOew85fdK8adaCMy5p+YjdB5Oyq45eIN6uIIm9G4mHmJPviNIGqCxYSA5we9CZl
         OtCTsGmMP7D+sXYCIfn91AziHeAMytxmUccNqL5b6EhFhm2ANWCfjPJ7qukKVL4VJrN+
         Z3PgWhviisNYP1HQZ7V7qPRF5yEzZ585X8QBVxLVFjryalMhjRyLLEMVhmmyF2AwDDNE
         hoLFejh9HaPqJMcChlNeGcX95MAVboFFWOvG/0IgbQ9SkmDyl2b3CNEVB2rV6bQ8fRgB
         EhMIDz7pGJI9xSP6/iW6LjXdnzh+K/tCGa/6ssupPAB5DhHYT0QVFMUXTHBXRzkeyD7i
         zOxw==
X-Forwarded-Encrypted: i=1; AJvYcCUeLAOGKRfmDg5Dg9WqGroGModJZJ4ORPsr+j8e2eh/i8C/SOc2V9z4Ks8XduJx3QdbeTZWPWJuopBc2bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qEmLk58J7RdFxBCDB3Ymlg+pdJC9Lu/udNXSlmrqyNea7bZz
	NCgbSJN5KKRkyjRDMKiiQe3eY6/ds7ycE4rKnVbcTqAjncTYNQTTURbUDOitBgLN1+I=
X-Gm-Gg: ASbGncsWayCBlTdLPYTi6y1z9qaK1rB67mw9aC7m7ISCCAWSVBuvhirb05nNUZwME6x
	ulRYKY5/D8XNUA1lz8VMrQi/KhDh3o4N6U40yBLkdXjZ7bY6h8+JzC0lt4YQ49KiENN6LzMBnB/
	qQOhrKIi70FFuprtDxlFFYRUazyY/hnv0ZDv9xUq1OOgXAaDdlO7P7pnF1L4DUh1qt9hd77ZFEP
	+wm/LUs1/+f3nSapVvE0MLCTbv4hc+wSSnSnAvlgnU06Dm+dW8LK1GyPltwtTmRyN+QIxtxbQcI
	04KbX+xjJZVaGBL02sd4gvII0pCYBOq21bGXtZ8uMZZU51yyNi6IskBZqLyBQENQHeT0g5IpghM
	8H08rGiecrcUamxRMitQkaP5gv7YB0Hmi2/cjhuKynJV/1Oty+Hg11tuY
X-Google-Smtp-Source: AGHT+IG5pvNgDMJPTKAtRd4veVO0FFUkU2pJXXO+YNn1lCJbx4D7Y9oh8jCMqxVVxc+i8Y4GbC2AVA==
X-Received: by 2002:a05:6000:2c02:b0:401:ae97:a1ab with SMTP id ffacd0b85a97d-42666aa67f9mr4871037f8f.10.1759996763143;
        Thu, 09 Oct 2025 00:59:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1753:6135:be55:f8ab])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8ab8fdsm32990864f8f.15.2025.10.09.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
  Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-kernel@vger.kernel.org,  linux-clk@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  Xianwei Zhao
 <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for
 A4 and A5 SoCs
In-Reply-To: <b8105d25-112c-4406-9f3a-8fbbd0754b26@amlogic.com> (Chuan Liu's
	message of "Thu, 9 Oct 2025 11:09:25 +0800")
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
	<1jv7kz3w1p.fsf@starbuckisacylon.baylibre.com>
	<b8105d25-112c-4406-9f3a-8fbbd0754b26@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 09 Oct 2025 09:59:22 +0200
Message-ID: <1jh5w84iat.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu 09 Oct 2025 at 11:09, Chuan Liu <chuan.liu@amlogic.com> wrote:

> Hi Jerome,
>
> =C2=A0 =C2=A0 Thanks for your review, because the national day holidays d=
id not
> timely feedback.
>
>
> On 10/1/2025 3:45 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Tue 30 Sep 2025 at 17:37, Chuan Liu via B4 Relay
>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>
>>> This patch series includes changes related to the PLL and peripheral
>>> clocks for both the A4 and A5 SoCs.
>>>
>>> The patches for A5 were previously submitted up to V3 by Xianwei.
>>> https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.c=
om/
>>> After friendly coordination, I=E2=80=99ve taken over and continued the
>>> submission as part of this series. The dt-bindings patch retains Rob's
>>> original "Reviewed-by" tag, and I hope this hasn=E2=80=99t caused any
>>> additional confusion.
>> ... and yet you restart the versioning of the series making it harder
>> for people to follow that
>
>
> Sorry for the inconvenience caused. The main changes compared to the
> previous version by Xianwei are in the driver part.
>
> The dt-bindings part only has minor modifications in [PATCH 14/19].
>
> The driver part has relatively larger changes because it needs to be
> based on the code base you previously submitted.

I'm not seeing a justification for the mess introduced and I'm not
looking for one to be honest

>
>>> Both A4 and A5 belong to the Audio series. Judging by their names, one
>>> might assume that A5 is an upgrade to A4, but in fact, A5 was released
>>> a year earlier than A4.
>>>
>>> Since there are differences in the PLLs and peripheral clocks between
>>> the A4 and A5 SoCs (especially the PLL), and taking into account factors
>>> such as memory footprint and maintainability, this series does not
>>> attempt to merge the two into a shared driver as was done for
>>> G12A/G12B/SM1.
>> ... and we end up with 19 patches series while it could be splitted into
>> manageable series, for each controller of each SoC
>
>
> I'm not sure if I understood you correctly.
>
> Do you mean that I should split this series of 19 patches into multiple
> patch series and send them separately? For example:
> serie 1: A4 SCMI clock controller (dt-bindings)
> serie 2: A4 PLL clock controller (dt-bindings, driver, dts)
> serie 3: A4 peripherals clock controller (dt-bindings, driver, dts)
> ... A5 similarly?

Things that do not actually depends on each other or which are not
merged through the same tree should not be sent together. There is
nothing new here. Same basic reminders on each submission.

>
>
>>> This patch series includes all related dt-bindings, driver, and dts
>>> changes for the PLLs and peripheral clocks. Following our past conventi=
on
>>> for clock-related submissions, the dts changes are placed at the end
>>> and submitted separately. If this ordering makes it harder for
>>> maintainers to review or pick patches, please feel free to point it out.
>>>
>>> Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>> ---
>>> Chuan Liu (19):
>>>        dt-bindings: clock: Add Amlogic A4 SCMI clock controller
>>>        dt-bindings: clock: Add Amlogic A4 PLL clock controller
>>>        dt-bindings: clock: Add Amlogic A4 peripherals clock controller
>>>        clk: amlogic: Optimize PLL enable timing
>>>        clk: amlogic: Correct l_detect bit control
>>>        clk: amlogic: Fix out-of-range PLL frequency setting
>>>        clk: amlogic: Add A4 PLL clock controller driver
>>>        clk: amlogic: Add A4 clock peripherals controller driver
>>>        arm64: dts: amlogic: A4: Add scmi-clk node
>>>        arm64: dts: amlogic: A4: Add PLL controller node
>>>        arm64: dts: amlogic: A4: Add peripherals clock controller node
>>>        dt-bindings: clock: Add Amlogic A5 SCMI clock controller support
>>>        dt-bindings: clock: Add Amlogic A5 PLL clock controller
>>>        dt-bindings: clock: Add Amlogic A5 peripherals clock controller
>>>        clk: amlogic: Add A5 PLL clock controller driver
>>>        clk: amlogic: Add A5 clock peripherals controller driver
>>>        arm64: dts: amlogic: A5: Add scmi-clk node
>>>        arm64: dts: amlogic: A5: Add PLL controller node
>>>        arm64: dts: amlogic: A5: Add peripheral clock controller node
>>>
>>>   .../clock/amlogic,a4-peripherals-clkc.yaml         | 122 +++
>>>   .../bindings/clock/amlogic,a4-pll-clkc.yaml        |  61 ++
>>>   .../clock/amlogic,a5-peripherals-clkc.yaml         | 134 ++++
>>>   .../bindings/clock/amlogic,a5-pll-clkc.yaml        |  63 ++
>>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  80 ++
>>>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  87 ++
>>>   drivers/clk/meson/Kconfig                          |  53 ++
>>>   drivers/clk/meson/Makefile                         |   4 +
>>>   drivers/clk/meson/a1-pll.c                         |   1 +
>>>   drivers/clk/meson/a4-peripherals.c                 | 764 ++++++++++++=
++++++
>>>   drivers/clk/meson/a4-pll.c                         | 242 ++++++
>>>   drivers/clk/meson/a5-peripherals.c                 | 883 ++++++++++++=
+++++++++
>>>   drivers/clk/meson/a5-pll.c                         | 476 +++++++++++
>>>   drivers/clk/meson/clk-pll.c                        |  76 +-
>>>   drivers/clk/meson/clk-pll.h                        |   2 +
>>>   .../clock/amlogic,a4-peripherals-clkc.h            | 129 +++
>>>   include/dt-bindings/clock/amlogic,a4-pll-clkc.h    |  15 +
>>>   include/dt-bindings/clock/amlogic,a4-scmi-clkc.h   |  42 +
>>>   .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++
>>>   include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |  24 +
>>>   include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |  44 +
>>>   21 files changed, 3406 insertions(+), 28 deletions(-)
>>> ---
>>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>>> change-id: 20250928-a4_a5_add_clock_driver-2b7c9d695633
>>>
>>> Best regards,
>> --
>> Jerome

--=20
Jerome

