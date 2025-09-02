Return-Path: <linux-kernel+bounces-796190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF0B3FD20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741857A714F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580582F6188;
	Tue,  2 Sep 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNGDNomK"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A112F617B;
	Tue,  2 Sep 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810559; cv=none; b=r3etgc4oPp6Ply1vg+A5+zNSav+xrPs7ZAZwPefUenux/d0/wrdPL8X9vd2C1sc8H9tDIXP3CbPhGb3vkp1cqrYLaHU0H8sIZONWb4M2tD7t6cfr3h5UCgLjvcysqKA6nw0TLQkZ0CLGPdVJkYjRK2jEiXlVMUBU10ag34arPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810559; c=relaxed/simple;
	bh=/yv6wfMBCGauFEEG8NIOdTF35ZEmcQyAzbZ0UEyxGqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1Hld37Snl1g6sdHGQsv7rR2DgJNRVFAWp5fTIR7BbyFs8+ahTJRUNSg+Fz3Ajyf98BHP21TkqCYRRy3gkpYsmXLc7wtkNM39SWeby+X29S6JaNB74RKecCrEQYN+JU9RxEJubL/diJC91kiuKeex8ip6c/c3FQ+HA9EG8jlktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNGDNomK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336e44ca0e4so14828681fa.0;
        Tue, 02 Sep 2025 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756810556; x=1757415356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4z3tt/EVCscRadpcGAdkkLAF52cp5gwcdFwhvouaew=;
        b=aNGDNomKtNNflXcBf7BaDSmqLEn0WLTwmp9b88P7O4/Rnyj8Z1YWXOtM8BDiXAKFh0
         16LNKlWiCwPGsaJyfRavUCGdIQ+dhXUXGlNj87ppYVtXoVSBeCpAl1DWPe5IQVmF6xKy
         rpA1YT9ohgwlUkkV48PIHQ60VK8NT6yW0FdgfPDdkg7NVCWukPRuBb/jUXFH8A/Zvd2B
         QP9UN+t10TYuBLGk1eRCoLrNYQIyGPAJP6VXY4h0CjnmZlOXrXdahdgn/zWtv/1cG5Fd
         Fi94kqn/E7+b16+b14h6Q8bOjPlqwH2u+1b5DyEu2A3APTxsJkFNCa0FVZhUyCRGjHwL
         OEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810556; x=1757415356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4z3tt/EVCscRadpcGAdkkLAF52cp5gwcdFwhvouaew=;
        b=aoRiBYsTNz0GPQFT4rryMc/pAYuD5CQyRjdRd2O0EoEAKDkq/poaiURjtofBUO5aDV
         er2IUFFDGB0JyoKwU6oLADhzmqkBZ/IgYuD6s2nxqtnZmKR+2kMHAvnG9ztuQPEGvyDw
         GDUIu6NiO0rgwrud1nfUub3Hw06vh8JJ75+pHTWRx4Rb941aofnFXIEYha0kt8jofH4p
         1dUmOeG3kUy17FYiMyLnEjyo7u8WE5jF+jdenIpysoY4Izd67rKdI8T21zYtb4/WU5T5
         4wZFfL7hWlq2cFeL8hwWmnTI2IWq/MIzV+CKLtdefxsidYnxt5S9WlY2IG60q9DzGqH4
         TjXA==
X-Forwarded-Encrypted: i=1; AJvYcCUCyfRuzO50gTfyZhp2Bh9VXyhbALW5647BVtSe7TmXhVt+dmeS9H6V7AGV8NLC4oa4fdhjP4ZIvrPkTMA=@vger.kernel.org, AJvYcCVVRoOcQGFVh5KNHDdPwYG8cIE+4FxeLEGgi/wDaVZpskDLbyrelpgw+G2QOJ1qWLpiQ/pZ6/lGYh9z@vger.kernel.org
X-Gm-Message-State: AOJu0YzNrUaXWhRAiFD0hvmgjiQFkOXgyHBvuOvI/kddt2JGdiS/9RNf
	YRBlUFPbmc5sZ0vzp8AwSl5stTvJ/AnLKrVGl8BgszC2n+qi6uZAkBcm
X-Gm-Gg: ASbGncvMJWiCwNJRFBzex6u6cyzbpfLfYR8qkPrh2xIT31ixoIv0q7Z7MtDIxhiC5nk
	yWL+e45/G+mcx61LWFpQUZm/Oj041siLkeSJ9KZ5Ig2QhHvn4Gj43CkCxvHN97qJJrjfZGkumvU
	wMwB9JmJAE20VTR4Zt5VG79isdWazk5AwT6VMpXb3Fqooqq2WBTZXBFnUnECJHLvB1paKyNeSsB
	G6+hkrIL0bvNpEsABtUXkiHGBKVRgGUKuKHHac49g2TDhRKbJcfdLrfGnFPhQM3L0K3OJ4xPn7V
	pYWTYk60ynmNotDe5FlqJ5OOIHRUQz0AsONoKMGIBjR5uuvcF3/OVuo8v4AsenwxDlC8WYAKCZK
	7XeUlEwatdVPxACo2i4raK8PEOPk3dbJUO44FQii2iqzSvA==
X-Google-Smtp-Source: AGHT+IGFRu3XuFoSm3+DreztlNP5a2guSHIu9vPQibD3J7e0m7KGfv6NGgjaA6PXiAIVw8hDKcXQzw==
X-Received: by 2002:a2e:b889:0:b0:336:8228:29f7 with SMTP id 38308e7fff4ca-336caad86acmr35778241fa.27.1756810555583;
        Tue, 02 Sep 2025 03:55:55 -0700 (PDT)
Received: from foxbook (bey208.neoplus.adsl.tpnet.pl. [83.28.36.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d1188sm603738e87.31.2025.09.02.03.55.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Sep 2025 03:55:54 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:55:49 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: David Wang <00107082@163.com>, WeitaoWang-oc@zhaoxin.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 surenb@google.com, kent.overstreet@linux.dev
Subject: Re: [PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
Message-ID: <20250902125549.03f22bcf.michal.pecio@gmail.com>
In-Reply-To: <6042295b-8dad-4816-8505-b9b6c6f6049d@linux.intel.com>
References: <20250829181354.4450-1-00107082@163.com>
	<20250830114828.3dd8ed56.michal.pecio@gmail.com>
	<5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
	<f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
	<20250902093017.13d6c666.michal.pecio@gmail.com>
	<446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
	<20250902104630.6a9f088a.michal.pecio@gmail.com>
	<20250902110730.723a48a0.michal.pecio@gmail.com>
	<6042295b-8dad-4816-8505-b9b6c6f6049d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sep 2025 13:13:12 +0300, Mathias Nyman wrote:
> On 2.9.2025 12.07, Micha=C5=82 Pecio wrote:
> > On Tue, 2 Sep 2025 10:46:30 +0200, Micha=C5=82 Pecio wrote: =20
> >> On Tue, 2 Sep 2025 16:30:48 +0800 (CST), David Wang wrote: =20
> >>> About the change from "<" to "<=3D", I did not observe any difference=
 on my system. Is it because my system does not use up all slots? =20
> >>
> >> This too, you would need to fiddle with devices (or connect enough
> >> of them) to reach Slot ID 255 (probably the highest on most systems),
> >> depending on the xHCI controller and its ID allocation policy. =20
> >=20
> > This made me wonder what those policies are. I'm too lazy for thorough
> > testing, but I plugged and unplugged the same device a few times.
> >=20
> > Most HCs kept assigning ID 1, so they likely always pick the lowest.
> >=20
> > My AMD chipset, two ASMedia USB 3.1 controllers and a Fresco FL1100
> > kept assigning sequentially increasing IDs, so I suppose I could pump
> > it up near the top, connect two high speed hubs and trigger this bug.
> >  =20
> >> But also as explained, this bug doesn't make things go boom just yet.
> >>
> >> Except if combined with your bug in an obscure edge case:
> >>
> >> 1. A high speed hub has slot ID HCS_MAX_SLOTS-1 and some TT children.
> >> 2. Another high speed hub has slot ID HCS_MAX_SLOTS.
> >> 3. We start with freeing the second hub.
> >> 4. The loop is entered and leaves vdev pointing at the first hub.
> >> 5. The first hub is freed instead of the second one.
> >> 6. Then its children are freed and UAF its tt_info. =20
>=20
> I'm not sure I follow the above.
>=20
> I agree that changing the "<" to "<=3D" makes sense, but fortunately for =
us there shouldn't be any
> issue with current implementation as xhci_free_virt_devices_depth_first()=
 is called with highest possible
> slot_id value first:
>=20
> in xhci-memm.c:
>   for (i =3D HCS_MAX_SLOTS(xhci->hcs_params1); i > 0; i--)
>                  xhci_free_virt_devices_depth_first(xhci, i);
>=20
> if HCS_MAX_SLOTS slot_id is a hs-hub then all its children have slot_id <=
 HCS_MAX_SLOTS,
> and loop works fine.

The loop works fine, but it exists with vdev pointing at MAX_SLOTS-1
due to off by one and then this happens:

	xhci_free_virt_device(xhci, vdev, slot_id);

which means:

	xhci_free_virt_device(xhci, xhci->devs[MAX_SLOTS-1], MAX_SLOTS);

If MAX_SLOTS-1 is a high speed hub, it will be freed right now, without
freeing its children first.

And whatever this device is, it will be freed without nulling
xhci->devs[MAX_SLOTS-1], which might cause other UAF later (not sure).

I think it's possible, though I haven't tried actually triggering it.
The problem didn't exist before this recent patch.

