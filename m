Return-Path: <linux-kernel+bounces-835764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4ABA8011
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E1179B21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDA29BD91;
	Mon, 29 Sep 2025 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElpsDq2c"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CC34BA53
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124506; cv=none; b=NQOipxFofvsMZdLd2jabPvnL8WCk6BZbQfiPzUh6pRjgHpIq6X0o5wv58Ny6w3FGngdHn/Ra8a+fdni/oC/5bht9sgzFeebCiYi2qXa8xMVGj8XR9GTLqN0tT1hb3AaJK7fGY+9hLfhR+ZXN7sPYqFLFZDIlRrTU3ecvZrT//Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124506; c=relaxed/simple;
	bh=Lvn8T1wUKlrgTrrq99kvpCDXJ/g1SM5vpZu4qoHH1UE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e5IiYGU0VzKXgLbNSnTrU+SwO9vtrjTZ0VUgjvfXrYlc6xNPWBKIHPLqsoWyVJTTLMb2Qizp3X188rzx1seKV+iThDECaXcPA/uSZ29s319OhjV/+1/FyzoWC6ZgT32fhsYVDzwkPuC4y1VvtCuv1fRWE4CUzb/T0JMTx1d0/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElpsDq2c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso25286195e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759124501; x=1759729301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hgi0ZTEkhCBobMcksMg/fMrDzp6rhP+k5TYYLF7nLLU=;
        b=ElpsDq2cuVEc7E864ePCgL8SxKZzPPShg2JPt9JCxqYwwR/cAl9LACjMQwus4m5nEV
         H2lMz1+XqX0MhHHP7usuLEyKOevPCP5PcYlLUGIr5a1i+XO71D0pzCVungPKvCzfPIeR
         z/x/dviMACgkjPCjdj3gbsDJ/bjGn3BdE5FcjIqsF9Rk5L9lvMxe3PSyvLG+CcTOacur
         ctQdBDSCTFQHpZyn83lCsvN/b8fnFYUqJ81tJsNzS+Aq5k1abqcL28xqJdComzs2XH6P
         EPxEFKPqGyNMFjBIshyEhFWE9916yfsEFarErQSGBRjwahcdTOFVauUlHBZkiwKBg+nE
         j8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124501; x=1759729301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgi0ZTEkhCBobMcksMg/fMrDzp6rhP+k5TYYLF7nLLU=;
        b=n8awC4rbfJnN2WNI2D8cVcjFZ2XNmkrNdXkCIwHg1fz/eY0cvZGfPuUUv89oQcnNsI
         qfsD26sacxCxq1TSoYbOYaDXqclbVzc41p19dCRlY4/uTty2d1P2stJN782mIJTHOTk5
         qWC+QVjlEQ1RDBJXmJXalUdZiTnoSdYMWPN15ZDbbHd14c8m/AQNiemoCrBHBtXzdZ4k
         xPB86ynyOPZikHKo0FNGXX7FSP4UymcYm7nOEsiz6O2X3FJoHup6Be2xJz5QUqehZd+z
         0RKmQleABDFTrWchcJ+RNkzhvjUwtTAF7hlH3ghLzGih7qckKREIFL2gPMNRXFLDPXbn
         Ef9A==
X-Forwarded-Encrypted: i=1; AJvYcCUuCFTAvLdOd6p251WsJFsL1l1M5JBDgZL/3G5nHcKmK1LPogR7Nd//GmQzIDkzxoj5Kh3mfSyDu9zf6tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6qPS/pAEv6Fi65Lge942V7Ej6FiN9hlAJj09Gx5JX+0b0VCm
	VE5MjatOGebW9W2LnIQVrK1+xGqd6nVlz3BW+ixD81wR45S6TPFLBBUWKAfNwSHzpNA=
X-Gm-Gg: ASbGnctcuwPNgp7znSNSvawP7dLt9BUPgMfF+KheSPzh1JkSSZl8NoZ1WTUs4twwuET
	oL9V412i9wdHscUY05W3PI0zxQ+RYaLwuxAS9m06XSP2fEfT4aQraDCgHJxLTUtJNtfdDHudg48
	AQ+0ktkdtY6KmNBjnYIQQPRKBtVlJ60T629btCHSS3usDXNgsB7/Cntscy+7lHe1cbLZkGnUUFl
	Pg4URGVS8YaRYPYx2yiptu+3WCiiHJf3tcMN02TEYsRyVz1sruPrU4HjfMoarT8kvMCRTHsmn7y
	X6Q5aeBdLudSI/3z/S/C9lBm1U8O77ciPgyme/+p68P8X7U7RgVrJTuGiyu34goNA2NeJXg/HeU
	12xavhNbB8ktR2bvZbS87WHjr3ciwU/SN59Z+JDqfzuUkA3f0l6zQjjdjlRPY2YE2yEIscw==
X-Google-Smtp-Source: AGHT+IEaKb3g6sQ6remUeoL/AUn5TgHYVpNIer58FUutG2qpwQrKJqse5m9ODma5Lan4BZIkg1Txbw==
X-Received: by 2002:a05:600c:83c7:b0:45c:b5f7:c6e4 with SMTP id 5b1f17b1804b1-46e32a18479mr129257235e9.35.1759124500781;
        Sun, 28 Sep 2025 22:41:40 -0700 (PDT)
Received: from localhost (lfbn-nic-1-10-73.w2-15.abo.wanadoo.fr. [2.15.106.73])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33e3b300sm90269625e9.1.2025.09.28.22.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:41:40 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:41:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.18-rc1
Message-ID: <jeblxobrtuzcsgs3r7g5fxvpmauttof3qzrlvlaglueg4ls4ea@dk7kpwkplno2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kejepkqwbc4zpbkh"
Content-Disposition: inline


--kejepkqwbc4zpbkh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for v6.18-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.18-rc1

for you to fetch changes up to 8f2689f194b8d1bff41150ae316abdfccf191309:

  pwm: cros-ec: Avoid -Wflex-array-member-not-at-end warnings (2025-09-15 1=
1:39:47 +0200)

----------------------------------------------------------------
pwm: Changes for v6.18-rc1

The core highlights for this cycle are:

 - The pca9586 driver was converted to the waveform API.
 - Waveform drivers automatically provide a gpio chip to make PWMs
   usable as GPIOs. (The pca9586 driver did that in a driver specific
   implementation before.)

Otherwise it's the usual mix of fixes and device tree and driver changes
to support new hardware variants.

----------------------------------------------------------------

There is an immutable branch pending for this merge window that was
created by Lee at

	git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-inpu=
t-pinctrl-pwm-v6.18

=2E I didn't add it here because it merges cleanly into my tree; you'll get
it via Lee's PR and probably others, too. (For the next time such a
situation arises: Would you prefer me including such a merge anyhow?)

Otherwise this PR should be boring for you
(https://www.youtube.com/watch?v=3DV_ioxeU7Kpw). Diffstat below as usual.

Thanks to all contributors!

Best regards
Uwe

Colin Ian King (1):
      pwm: Fix incorrect variable used in error message

Daniel Lezcano (1):
      dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32=
g3

Ghennadi Procopciuc (1):
      pwm: Add the S32G support in the Freescale FTM driver

Gustavo A. R. Silva (1):
      pwm: cros-ec: Avoid -Wflex-array-member-not-at-end warnings

Ivaylo Ivanov (1):
      dt-bindings: pwm: samsung: add exynos8890 compatible

Janne Grunau (1):
      dt-bindings: pwm: apple,s5l-fpwm: Add t6020-fpwm compatible

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Krzysztof Kozlowski (1):
      dt-bindings: pwm: nxp,lpc1850-sct-pwm: Minor whitespace cleanup in ex=
ample

Uwe Kleine-K=F6nig (21):
      pwm: tiehrpwm: Don't drop runtime PM reference in .free()
      pwm: tiehrpwm: Make code comment in .free() more useful
      pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
      pwm: tiehrpwm: Fix corner case in clock divisor calculation
      dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells =3D <3>
      pwm: Disable PWM_DEBUG check for disabled states
      pwm: Check actual period and duty_cycle for ignored polarity test
      pwm: Provide a gpio device for waveform drivers
      pwm: tiecap: Document behaviour of hardware disable
      pwm: mediatek: Simplify representation of channel offsets
      pwm: mediatek: Introduce and use a few more register defines
      pwm: mediatek: Rework parameters for clk helper function
      pwm: mediatek: Initialize clks when the hardware is enabled at probe =
time
      pwm: mediatek: Implement .get_state() callback
      pwm: mediatek: Fix various issues in the .apply() callback
      pwm: mediatek: Lock and cache clock rate
      pwm: pca9685: Don't disable hardware in .free()
      pwm: pca9685: Use bulk write to atomicially update registers
      pwm: pca9685: Make use of register caching in regmap
      pwm: pca9685: Drop GPIO support
      pwm: pca9586: Convert to waveform API

Xi Ruoyao (1):
      pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT

 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |   3 +-
 .../devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml |  11 +-
 .../bindings/pwm/nxp,lpc1850-sct-pwm.yaml          |   2 +-
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |   1 +
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml |   7 +-
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/core.c                                 | 108 +++-
 drivers/pwm/pwm-berlin.c                           |   4 +-
 drivers/pwm/pwm-cros-ec.c                          |  10 +-
 drivers/pwm/pwm-fsl-ftm.c                          |  35 +-
 drivers/pwm/pwm-loongson.c                         |   2 +-
 drivers/pwm/pwm-mediatek.c                         | 312 ++++++++----
 drivers/pwm/pwm-pca9685.c                          | 555 +++++++++--------=
----
 drivers/pwm/pwm-tiecap.c                           |   4 +
 drivers/pwm/pwm-tiehrpwm.c                         | 154 +++---
 include/linux/pwm.h                                |   3 +
 16 files changed, 683 insertions(+), 537 deletions(-)

--kejepkqwbc4zpbkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjaHA8ACgkQj4D7WH0S
/k6QeAf/Y7JaZiqli26ZPUagiLUzmPPrf7ofqprB65lAS8MdzsufDsX/hq32McVa
Aps56clnG7/62+J8gvO/ZlkBioI4NbMeeKkGL1UAmL+/8jZfwbSz72d3nB6fN1rI
h++6YB5Zp+G4bHhEuV77ys4YRCbah6pOGgzxxHOX2V1Qdebqg+ZE1lf74l0XeBSn
5ugy/6ysbTkEKGrX2arlawRSrWF/5/WUqXXKmvUi5lM0lTfJZTLoO1E4n/vdX6Hw
ZYF8bJ8dn0P1PQTgNktBhOpf62C1w1pKKAqj4I1g40xYe4ccDGARKsd7qzdbtLs2
2K6pRMfvi/1qOneK+XI6uTEZdqurBw==
=YibB
-----END PGP SIGNATURE-----

--kejepkqwbc4zpbkh--

