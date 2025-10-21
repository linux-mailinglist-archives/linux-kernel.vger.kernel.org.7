Return-Path: <linux-kernel+bounces-863561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DDBF82C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23A2424637
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF934F25E;
	Tue, 21 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uc6eMg/z"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06B34C82F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072975; cv=none; b=MCJ9Pbp+81hVL8RIu+ZtwBQOGNKSfY4C04DvQX/xQDzejkRRq5zC3qK/IeHQyM5khod0Wq29M02rkweEBXeD7IBhjnBzJcCebHxiP8IFcSTrsaK79rn4dk0M8ImRq+IKubSGK/iXsaTvzDl+XcFUFybhN8vPHr+1x55mM1Qy/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072975; c=relaxed/simple;
	bh=iJqLIFVdRqsAJ9nTQozNmtTq5rkisBXmJuWmzMEKJUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nNVwR1BvKo904Yy9MjLoUkpl35tsGZYvXNPyYFkQIdqh1+lFBajJ0ceJdtgiJE55I32fNiigJKi4fmRr3Uq1W79CFH3V/6lU8U2htPeLswBvS0PTS0hop6EMt4FxtNna07BKjIblXlxiU5D/Mw6/WXDdp+taMQ2EiG9veKk5YfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uc6eMg/z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3573065f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761072972; x=1761677772; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJqLIFVdRqsAJ9nTQozNmtTq5rkisBXmJuWmzMEKJUk=;
        b=Uc6eMg/zUQ1W0PIiMFV4VrLKuQVpJwpqv3AcnhrLHppDH8MVBJxk+S9RjFAWYCFYoE
         gSHyBB0IQ1jjtaaQCKjBwbybiu+nwiYkguQSM5Yy7muwIzEVbFC2xOhir7e8XJ/d3hSA
         EAEH/uJeyPuGliTC7A07J0yvx89BOlU2bk/iTwSPvKwUkh06YfqlknrDl7aqVsQc1T9b
         PeX7c6KMlAIdSBkx7bIrbQz8u7M79kyfc8opLX1uBLT1stBR8Q8st9U+ablybebRg+AY
         blsCinHHvBWYdHKrZyTTm1M2k6W/W2fsQbbH0KcNcqp68OYVToKpWUZ/XeCAXJ5Q4FgB
         bsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072972; x=1761677772;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJqLIFVdRqsAJ9nTQozNmtTq5rkisBXmJuWmzMEKJUk=;
        b=QpVp6S/AxhU5w9lWjnH8dHTQ7lsPTQZ6Gakj7n/q8ph5A4AqzLlSuemL/MFqsUVpkM
         gBPcXSOsmUzdmWKH6gBv6cTFOqp8p8OKdB0qK6BWI8BU2c19WRrbEqnnBkwJYw+WNGH4
         Ixf0qvpHMiIP268kARind2sJl7LU4aMKRnTPDH6XCsXvr8h0Nu1mAI1848LeJYnSBFEk
         pKx6hK5UiFqQGPOoebhWe3X3dzOsoT0fiuVGpMascO1lybgdIqlTCG/Gh35491Yehnw5
         3BtRUqoO7Old0XNx6CzZcOcrx4K12tab4DLH+jakau59HTYWq0nguZRmbMIc2eblrOHe
         fTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmzHxFB7z1O21ye6CJPDODOBj18ePR9K4p70dVItpybCf0x7DVmthOrrjV5ssG4Sanp3HgIk5J6jNIqt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQZeB3cG2PhiVHu1tY8OA5QUpTdBbQ8sT+PJOE0Zrb/ZWrH4C
	5/AyXM7sphe6DqjzQju1G6sQQAKSOq7lxMVorr5Rh0/pzcClh92ygcG2TehMHuXLlI0=
X-Gm-Gg: ASbGnctARf3svx0dwHR9F4HXJ6+D1kOqfQKG7/cYKdFzC5tSN78lUDcHWzKaKsltYOD
	LvCyxUo0asEsxrqeOf9i3vjfR5J/0v5tA9hP2mWIL5K7cRBD/zuuhuThI6/Dg1TO2GVQxcdDYll
	Sek8AGN4yWdXMAd99de5fYjOQyQGVN+h/zCW3q5X/5hcIGpENOSDavCy/sbRaEY2igijwDGZ+GM
	uNka5SioJbz+40GVD0InxO58lXcIBn870zz0wpOwwbOpe0/BoA4+0O2jHwFO09O46LGosyYqF5c
	oAS+2sY+xzgLgvmqoO8XHeQN1dFt0d/YuUoILrccq5zYObBBe8HIxY2ub+DaF1KcW1FjERWUJlY
	c5qDY8v+tTu3Xc4UrI5GfoQRVjBaQu0Vp4sqA5yRERpbwG1js0HPiDu19YS+QQvIDTuFqHBFvXj
	VEmXtGdKSEk+q69Q==
X-Google-Smtp-Source: AGHT+IE8OGe8fEFLvfk5DNFLba6SYnev9wcr2pWlSh+j4b7Y5U5zyPSIaOk7L6voNwKVhoV6jsZ8gQ==
X-Received: by 2002:a05:6000:186a:b0:3ec:ea73:a91e with SMTP id ffacd0b85a97d-42704d1432amr12331874f8f.12.1761072971335;
        Tue, 21 Oct 2025 11:56:11 -0700 (PDT)
Received: from localhost ([195.52.63.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce178sm21529969f8f.46.2025.10.21.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 21 Oct 2025 20:56:01 +0200
Message-Id: <DDO89HU3O3J7.1OORIVD4XMXSL@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH 0/7] can: m_can: various cleanups
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol@kernel.org>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
 <20251017-fervent-encouraging-oxpecker-3b09d4-mkl@pengutronix.de>
In-Reply-To: <20251017-fervent-encouraging-oxpecker-3b09d4-mkl@pengutronix.de>

--356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Oct 17, 2025 at 4:22 PM CEST, Marc Kleine-Budde wrote:
> On 08.10.2025 21:07:35, Marc Kleine-Budde wrote:
>> While working on the m_can driver, I created several cleanups commits, m=
ake
>> m_can_init_ram() static, rename hrtimer function, convert debugging and
>> error output to netdev_(), replace open coded register write by
>> m_can_write(), remove not needed error messages and sanity checks and do=
n't
>> wake up hte controller during m_can_get_berr_counter() if the interface =
is
>> down.
>>=20
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Applied to linux-can-next.
>
> Marc

Sorry, a bit late due to vacation. The patches look good to me.

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

--356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaPfXQhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP2
XwEAiF2/0OQky25ZjBWmOlwnAMsOtFDfXv/7EOUwFS7iSn8BAPK5w81k7APIPc7F
wN6/kDeQIt8JfQH0Z8is5yOg75sG
=cCo2
-----END PGP SIGNATURE-----

--356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7--

