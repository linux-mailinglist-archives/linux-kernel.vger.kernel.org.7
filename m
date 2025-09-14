Return-Path: <linux-kernel+bounces-815577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47406B5686A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03EB189E18B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647426058D;
	Sun, 14 Sep 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB/Z2r8A"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACB13BC0C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852067; cv=none; b=Rcqp7Lf1NixEY7rNxJqDrVK81CDWD3fdOw9rBoQ7NxMEEtK+3xuUj7KmBDHkevJX6TM5I7rkcE/BqEXIUIOAhlQ9u9z5CLjjxtPX72xcI+/h5D8MMC+HmSlCs72FLFg8a7UKokAOP5BKYot115YLnaaGTzBFKUQDB7FXmCvorv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852067; c=relaxed/simple;
	bh=zAkRkiiSiQAUgj34uGfT/rECpdZmsr7OjRlV6ZLCxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hplxcq5f/+dgb64zJ8g0Ue0vwXxglzZDOINJ5ODtpX/JdKPPtqRKx6FTyqFftZXY+vxPVWBkZX2M6jNH+oR+ZvWPl4FQC7Ps7vUkYorx0ntp7qqmHdYKhC4DXOokLFquXaNmPgZrQIunE8hg/4hGL9xPoEnabypqrzapr8ThhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB/Z2r8A; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc39551so550346666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757852064; x=1758456864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAkRkiiSiQAUgj34uGfT/rECpdZmsr7OjRlV6ZLCxyE=;
        b=OB/Z2r8A5xo2vepT7jnk6VpUC1qIYwoM5I/8HXCBFy8Z32v3I6N9SLL2YJNXzCYryy
         O6VFOoGpt4epmj1o3Cf8x1ZjAItXP41g2xsFsS/MPWM9lCj15bmGzD4UoiB6XpldZdSS
         MsU0jOc77z+pTdkkIP6AFWwrSJrtw0rzLRmqJeC6HmfzTcWf0tyaNrxXzUhfS4l98Tn2
         TNv+QsvVQRcxwBejfUOJqFw/nk+aCZaSOlxPlznKh/IvGLLdJjpb3gbHUpQ4ph7lvY+W
         03TFGsG9q1tA98qbx3nQTbQxHyguZBUilwfXi2IZpHEwh1WylLLUD9tFjuhh6cUgaoY9
         JIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757852064; x=1758456864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAkRkiiSiQAUgj34uGfT/rECpdZmsr7OjRlV6ZLCxyE=;
        b=HeC3XjFGHQrayjTNl0qBXv7qIa8GHe37MLv3qHhe6DfA0h69mJ+TC3FoBJrsMGxF/V
         oEnt4mfR4LOycTPLBz/Jh5CxqWYNjuWtFzEQMe/Z5mF3kE1c38fs786Le5T2QUsEmEkV
         v5m7cUZ23y6H8hKDDAWQ/2Nbr8vWkTeEbdZYzzWfxDtIJp0b9dQ6dVD4dNoXsitd7xhA
         ADzXnYUsuY3DAVPJaHRuSD4DL54S1jEVmQr5KUE9CJigxwXh3iCFA2LQRqVlj8wUehAd
         xDZ+7Nl3Vtycij8tsiXjagh+P+MdWpHM56uHupdFSBYR6mB2rJr1m+PW9sHMpBDSZRIu
         zEZw==
X-Forwarded-Encrypted: i=1; AJvYcCX6L3b16ySXsgTaB1e/DozrSVEC3fhPjculP8+56Pnl8CFbnEs23/NEmUgVf7ZrSV+ja257OOyds1utmxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaWjvdfs92SGO6oMuqxe8j862pHwbTxdg5EW/3EmYtIKbisjx
	9RPCxp3S4zHjb0qm0ZgRFc5QHgiekrnZfFwa+Bk7LoABDSl4m7nbQLVB1t+0o7xC5fb5q7GEkBF
	l3W8gMl2aNd2R05FwWGxXP36adFWXUz0=
X-Gm-Gg: ASbGnctTbSo/bDJa9NXWUPkl1AQVYI2hyg2ip0xsld1518bNfYrRaCWLYHSmuIMKLdU
	hAcAEoQh3KvgzhjLLR+Vp5lqdISl7MZdWMJpYkgZFZD5VE26s2JppzQCD4rTtWfsoIBiMEY3eiT
	ahucIBmCpAEabsgEdORfC3KrU3xH10T2SW19J2SuTNZNgstaXqXTr/a3+RKihDck2/LcNr7yidP
	g3W7lB5hLPHTYAwbg==
X-Google-Smtp-Source: AGHT+IHodZKToXhvftGrPhwkbA9rZagoYrw+M780Ipaw/v/nz/SPOnfBcDWaVE5LmeVvnCDbA784u9htXO5Uk2mybzs=
X-Received: by 2002:a17:907:980c:b0:b07:6444:a6dc with SMTP id
 a640c23a62f3a-b07c3878986mr931756966b.56.1757852064281; Sun, 14 Sep 2025
 05:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-9-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-9-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:13:46 +0300
X-Gm-Features: Ac12FXyh8Ic7NJuVMAf9Mx5s1rDgXXEaNIA8zCEN_ZwQM9qRpXQCwZ8FIqIa6WY
Message-ID: <CAHp75VcV2tVeYT33sLdu08vH5XHi_AgNxykMuw6oam0n0DMjqA@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] iio: accel: bma220: relax constraints during probe()
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Allow compatible chips to work even if their identifier is different.

This looks to me like a candidate to be moved closer to the beginning
of the series (before even split).

--=20
With Best Regards,
Andy Shevchenko

