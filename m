Return-Path: <linux-kernel+bounces-811060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21933B52392
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370E31C802B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA2311C20;
	Wed, 10 Sep 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgJSU0K2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B3260587;
	Wed, 10 Sep 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540229; cv=none; b=BkN64BZnIzoUKnJfaXKfc15MUV08WVl8WZ3CfifULYZUQijmHtWuT0OF4NUXmwVCjmx+6pWPerdTN3rRXBTRkSP+4c4JfUXnVG7TyqCQTjeGOzt0oCEVFaqp4FNEkd0BYgaN1vWRTIzNPIAk/Cu2nA4SjBnbf7qy5yTmArNaOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540229; c=relaxed/simple;
	bh=A93YtdEOI/AAYDWJZk4hc8HIpFAjpOSMLPRF6Urmkn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0WajI2c54to6dIRAtSXqYERH756NvIUPVf0qSH6YparaAiUVxPZMr8xUwoFJnS5iJgQ7VSVlSI/n5HpYWMhJMN8TEU9QGtdL0iYI+OXczS+oBa+GcG1u2Lk44W7v6e2IiTJECSqTHvfM2t/thVfUI2tKGDPZn/YiUyZdh4Uk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgJSU0K2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so7527387e87.2;
        Wed, 10 Sep 2025 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757540226; x=1758145026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm4kTYERBB4pA5rR/atZvPgHbgG3iGEIeYGNqcCGxv8=;
        b=VgJSU0K2inm4A/Mjr3dBjWwEVtR16ybaT+Kv4wtPMlrAq8CjE/pGY1m3mmGDKSDqbc
         oIZ4A3GvXKqC78PxyB1oby0+xaNZxVt1p5Kdt4Lo/KT15ScelqWgCB86Dt5Ic1K4FKYw
         Zq8q3jxsCNpByu6zrubWjfM2uUe1G5mfpCFekaAdsKZiafNCsW1/TDK/gjPh4s4Io50o
         Jbx+bS+tf7du/D1DFKYXoQP9VCd8NQI79r8mOO4yc5+Df6K23j3Ts3wyaL64btKNL1mT
         OGX2MKPFc5c84MFRHjNNFdH9b76czTbq+y2zne7VvU2MsPVx2NgZ4VhN8bIa6H6/BnPB
         Ccpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540226; x=1758145026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm4kTYERBB4pA5rR/atZvPgHbgG3iGEIeYGNqcCGxv8=;
        b=njn6ln9nv83LtYHgeV+HEVUfapG2ySrG/R4QS0Sp0NiiAHxryWk8tmLp9WgplxPIKP
         OJ1MVsxObXwXs0DiEclDlSYe7ZEVruyAEjrscYmn2l303RkBGdmpcPlgC8+rKqAprgi3
         bRlbpHiHvRzenPPQkJxLmAB2/iUuoUKoV7AlgonOjDwyJ49HnxVnXciFpY26gHy4JM90
         POJnkb6gONDkA3A1XCNCskg265UrdufiLhVuihb201XomnhO1ED36R0YX0lyLDpK2nXo
         fO2hpjy63nYwaRGCojKZ5OuIUS+0Y7BahX6CgHQ3+rpXBSuFDyNY6kkqdXStJa3qe5gH
         lBww==
X-Forwarded-Encrypted: i=1; AJvYcCWY3Cp7LU/rjQ8rEyyM6NcGwYjOcb4fkJBKADbWEFWvs4Jy5NNIXLnPbo+mdkRdDHWs+PvE/DGfIUSAboA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigGgisPqkKB4UotLQSrlb2/8VCJwn/l4Va4FrW4JY5GqR6kop
	Av2niskqQBkfJu7z0+64XUV+wwjSOqDQB4A7KCRHkNyO/Ji57d4GuA6fzCrjdQ==
X-Gm-Gg: ASbGnctcAjN3fulc0yCcE4++Vszy/LAjyl+zIMeQe8sFa0h8YZUE1HMUh8TqgNA84eP
	0qLgeAzFP05/nlJKQhQjHTVvfM4APUuUq8qd5AaOiXPe447kzwyrJCH571tRAYU20oFGWhJCA/V
	g2W7fJ3lrCRxUkyYDQt8+f/mmOWIK3K7jriTMHNWwZhR/V1teYre5CjuuZQh2NgKI3wognm8Kb+
	DYT801xyWyS+ZJETRQ/qvAoDMkZ4NnPCs1eXK2b5Nz8O56SkgGIL/+Duh+aEM0CRfSCQ+2b1H2X
	w5mU8Bqkp463yMAAHLScOwpe4IxwUCTpK7w4Y6dXWnMRM4R28lXMKkX9nNd2GDPL2yqD8bWVFGi
	drY+Plwu90tMbUzU+qr0NDhWeFYRnb1fSoEE=
X-Google-Smtp-Source: AGHT+IET1a3jfKjhnlCiZYjEfIN5JZuKPSjNxY+X6Z0sbe1gj3t0dL3k7IVB3FzKJCRBI/rqmUL2kQ==
X-Received: by 2002:a05:6512:12ca:b0:55f:4b01:30a6 with SMTP id 2adb3069b0e04-5625c9e9e74mr5250459e87.0.1757540225546;
        Wed, 10 Sep 2025 14:37:05 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e23e8891bsm9116e87.86.2025.09.10.14.37.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Sep 2025 14:37:05 -0700 (PDT)
Date: Wed, 10 Sep 2025 23:37:00 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250910233700.506a81a0.michal.pecio@gmail.com>
In-Reply-To: <20250910021519.13f78e21.michal.pecio@gmail.com>
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
	<6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
	<20250909193859.73127f85.michal.pecio@gmail.com>
	<e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
	<20250910020306.1d77d7e5.michal.pecio@gmail.com>
	<20250910021519.13f78e21.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 02:15:19 +0200, Michal Pecio wrote:
> Generally, I tried running this with wMaxPacket=3D64, TRB length reduced
> to 64B (patched xhci_hcd) to force multiple TRBs in the first TD and
> with transfer lengths of 32, 64, 96, 128, 192, 256. It worked.
>=20
> I can run it again tomorrow and send event-ring/trbs and epXX/trbs.

I found that my rtw88 WiFi dongle actually uses URB_ZERO_PACKET.
And it needs it - if the driver is patched to ignore the flag, ping at
certain packet size simply stops working, unless there is additional
traffic with random packet sizes to produce short transfers on the USB.

This is a high speed device. I also patched xhci to split TRBs on 512
rather than 65536 byte boundaries to get more TRBs per TD.

Result is OK I think, completion events as expected, the device works.
Note: the class driver submits URBs with misaligned data buffers.

 1 0x00000000ffed8f20: Buffer 00000000ffe9a80e length 498 TD size 2 intr 0 =
type 'Normal' flags b:i:i:C:s:i:e:C
 1 0x00000000ffed8f30: Buffer 00000000ffe9aa00 length 512 TD size 1 intr 0 =
type 'Normal' flags b:i:i:C:s:i:e:C
 1 0x00000000ffed8f40: Buffer 00000000ffe9ac00 length 14 TD size 0 intr 0 t=
ype 'Normal' flags b:i:i:c:s:i:e:C
 1 0x00000000ffed8f50: Buffer 0000000000000000 length 0 TD size 0 intr 0 ty=
pe 'Normal' flags b:i:I:c:s:i:e:C
=3D>  0 0x00000000ff988c60: TRB 00000000ffed8f50 status 'Success' len 0 slo=
t 2 ep 16 type 'Transfer Event' flags e:c=20
 1 0x00000000ffed8f60: Buffer 00000000fff0e80e length 498 TD size 2 intr 0 =
type 'Normal' flags b:i:i:C:s:i:e:C
 1 0x00000000ffed8f70: Buffer 00000000fff0ea00 length 512 TD size 1 intr 0 =
type 'Normal' flags b:i:i:C:s:i:e:C
 1 0x00000000ffed8f80: Buffer 00000000fff0ec00 length 14 TD size 0 intr 0 t=
ype 'Normal' flags b:i:i:c:s:i:e:C
 1 0x00000000ffed8f90: Buffer 0000000000000000 length 0 TD size 0 intr 0 ty=
pe 'Normal' flags b:i:I:c:s:i:e:C
=3D>  0 0x00000000ff988e20: TRB 00000000ffed8f90 status 'Success' len 0 slo=
t 2 ep 16 type 'Transfer Event' flags e:c=20

This was tested on some AMD, ASMedia, Renesas, NEC, VIA and Fresco.

=C3=85nd then there is Etron. This old junk doesn't support zero-length TDs
at all, neither my version nor mainline works. No events and apparently
no USB packets either, because even if xhci is patched to "skip missed
TDs" to keep the class driver happy, ping is still getting stuck.

Maybe something to keep in mind if there is ever a bug about it.
I hope not too many people are still using this horrible HW.

Regards,
Michal

