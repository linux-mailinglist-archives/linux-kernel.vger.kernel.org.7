Return-Path: <linux-kernel+bounces-775717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE4B2C3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DBD7A4EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A473043D0;
	Tue, 19 Aug 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGCcAq80"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DF1E5714
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607026; cv=none; b=bINRbF0ZV4yDP7AAU26BCR32UTUU4LBZ5WBFxRn0Z1fmMNce9yfLZDkgjz7zQ6gQt593XSKkBuumfi4KSwFtMpcJVAr7f5KvjoDW5BjEFaZIPoEBe86hKaqAXYtIFvW+4qznAAVQKfPerk+qOIlehcCXZhLlspKVlOqf02VYw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607026; c=relaxed/simple;
	bh=kN8PO+yKJPtjoWwliqsS5UIbKU7Fz3RgcBRi7ndKNpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Janft8dZTxReoejqoTHaLzNZKsf+4o6N215lCPpXyYZaNyXqqb7PgSbnXnxzOn4hF5LFUjkHejaI7DMG68pqKtnX14GShsKU8Dqcw245M04qaTGGpdJbyAzFW1g/kJgsl0SSwci2DzqIYBtfirMKyR4iJTAKqKQ6g6v/TKDGzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BGCcAq80; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f7ebc44dso46315521fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755607023; x=1756211823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN8PO+yKJPtjoWwliqsS5UIbKU7Fz3RgcBRi7ndKNpc=;
        b=BGCcAq807utLEGokMXk9xTPzJ2PItinwPONnVrP7/PpnAc9Y7qVssUNIxhJvzDuTiE
         srgbAai4+DoRNGsxFpzoC/tVQYScCyT31uIKdMTCvgr3Mg8QEpQZe1GrBmmg2tCaeJD7
         Tol+Mhj9Pbh0FOs4NxaSE9I0FLiruWqPBAYM6FjSpgU8FGVBNAl2VKHfPtmwuqk/rTCs
         bFgwxI+Or7+bkUYpg7c0cGODH17Jh0Ejz5HK0uW1Wc+PhxLRe6RJIu9yPwSwzY0cwuXl
         R2umaS1ZoHl1FIvkS1GtJVZ1CJxyifpGvVFETgZE5ZhYh6TGUiuOeyeTl7GdSVLjJU7J
         5EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607023; x=1756211823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN8PO+yKJPtjoWwliqsS5UIbKU7Fz3RgcBRi7ndKNpc=;
        b=jhvJHdhq7eWv8QaUUW12AD1xa3IGUDoOcIhK4yjpqgedde5xqmV5uPl0BD1qVBDL1J
         GJ9oURqY84+yAHN9ZyHXDE9NVrrfHbMNhRcSc4HQSh5hxaae3RPFjdOuCwWBc1qrC0so
         qyZ0S+GZE8g2XuKJPigkP+1ZlFSPKaofB4PLHFBz9d+muKnfvN6On3SeHGlks9X79O4l
         d1hsvFsaPLijWHtgPzFPErc7rI25byawp7qQ8Qg0RqdQNEvf0vsNrs5rzAVp6LWgjg5o
         UkaYh4LRrMWqKy9sAuhM4Cvc30sMneblwl82rtaNdwoOfqo5MShAIpzX8jCIyq/PBDHU
         oMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU83XkSehwBDxc6gc86i7EivcoKEK5zpLGHy/449JU2CppmNhEx4Za3V5mp1t2rkqGZsbyuYuXHihBfJvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxRS88Si3YoOz0VDRh3LERT4U8MdRaP+3dZ8Mt+aHtZqxn5pJ
	wT3FieCHZqVWPoC7H8zM8e2W1TUrcgEhd3VPs7Yi0Qh/d2PqT9RjayIvGjGWwK5pP+ow++Tt0r+
	nJDzoBlK6sL45WoA7tUb1uedpUI9qhXR6mXWZtWE2Rg==
X-Gm-Gg: ASbGnctghRJywBfNZy5XhNg2UvpJWB9CqE+5CC0RecZqLlFBGWfXjcyGhZDwtfz2vtT
	rFlnuhB7bb4FXkl4CIdcffONGV0mLSE3mAn9Ka4UHkaE625FH3+fobuDrj2JkZXQYdOT3QV03xM
	nryPC+za5mmBT10yrxDzrju8Bj1AU1Up99hh0a8ZrUX3610AWg+evMdnSiucy0nJ2iq/n/ux5WF
	yQs2Cl4eU0G
X-Google-Smtp-Source: AGHT+IF60h4WVMQ3B1KL8q6jLUasLc8BlggUoJR4OlVpazMLoejvJn79GNV6qXgLhSQX6llyrVFMUqcEDHaass7Rvi4=
X-Received: by 2002:a05:651c:419c:b0:329:136e:300f with SMTP id
 38308e7fff4ca-33531447abemr5458501fa.13.1755607023091; Tue, 19 Aug 2025
 05:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-ltc4283-support-v1-0-88b2cef773f2@analog.com>
In-Reply-To: <20250814-ltc4283-support-v1-0-88b2cef773f2@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:36:52 +0200
X-Gm-Features: Ac12FXxreBRNMQ-2ir2X10nBf7B7qy9Abw0x-1rD12XgK0TSMm41kUIDeST3KoY
Message-ID: <CACRpkdYWNgU8PxVaxDe3F6Cbb15J5cgEV1-kgDooOHdBoXXs3g@mail.gmail.com>
Subject: Re: [PATCH 0/6] mfd: Add support for the LTC4283 Hot Swap Controller
To: nuno.sa@analog.com, Jonathan Cameron <jic23@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:52=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:

> The LTC4283 device features programmable current limit with foldback and
> independently adjustable inrush current to optimize the MOSFET safe
> operating area (SOA). The SOA timer limits MOSFET temperature rise for
> reliable protection against overstresses.
>
> An I2C interface and onboard ADC allow monitoring of board current, volta=
ge,
> power, energy, and fault status.
>
> It also features 8 pins that can be configured as GPIO devices. But since
> the main usage for this device is monitoring, the GPIO part is optional
> while the HWMON is being made as required.

This main device just screams Industrial I/O, IIO.

(I think it's fine to use an MFD core and split off GPIO to a
separate driver, and I suggest maybe you merge MFD and
GPIO ahead of the main driver.)

Jonathan (Cameron) will have the last word on it but IMO this firmly
belongs below drivers/iio.

Perhaps not in one of the existing subdirs there but then it is time to
be brave and create a new one.

It will take some time and consideration, but I think it would be better
for everyone.

Yours,
Linus Walleij

