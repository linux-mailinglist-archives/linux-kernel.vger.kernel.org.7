Return-Path: <linux-kernel+bounces-733458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CB2B074EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8F01C2480C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A352F3C22;
	Wed, 16 Jul 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qBQkwml"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E33C33
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666007; cv=none; b=WLMuKUS5qbsCFAZien4vEpNcQGkTOyND+Wsc6lqp1s9pUSucEPG4HyYShvD22iC8VJtDcCBQoqR7hJ88BFP/FDq+DS5lid99ur+nX8bFP4rW1RumosTRxDzbU0i7Hd/QbF3mrabEtrLSEtv+eQwjrnPgXCpMcaW7IqPinpoj1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666007; c=relaxed/simple;
	bh=CH9JMm/EUP3n6sjw2ka/+bL8HgEp7EvOJleoVtviRmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvShfU/KpXErjbFi0MLWB/fUBnliRPtvU8Hl3H46XZU2jAbm0ficPOTOszU9zUMobONnNbECvHZ+hAnXz6SZvSCuB84c5kg4XL5G0YOHF4cNdH4w7bKnZglfJInFLoFhuLcFh+F9KCBdtY8Si8kPqabrl5k4jAolVjfdq3o+G0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qBQkwml; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-531426c7139so2779866e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752666004; x=1753270804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PveaVmPwkhZLYXMIoWYWTWMjMxo+ogQMIDtsdfI/JrY=;
        b=3qBQkwmlMAJquuT7XM4o+y5LbbHYec631V2beVLyXzNAHrBxaMuMBaGcBa3cijZHqr
         lgBt/HH5ywp89AYe1Wy/dmCY9w/2S53rXdR0YnqMqULomkql79lWK5ikrWrwr04oYRsk
         YMTcf/wRPmECdT/NVWiIt2iuZ/vsWfwpZgJebJxgbYiy02XSYL1tzl211HRdMVkko9Ns
         gEeJ/HEX04fV61lgriebVCueXsPXyVkYRK9LBzR0BsqtYXf7/liqNRpq6+fEhICy3/Ue
         9DcUhTynkv8BqsArCT8MvMlLPCTIFiZ9FiRqksSTEXyWzUgfE28BlPTl32j33cxaz3Kf
         ARRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666004; x=1753270804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PveaVmPwkhZLYXMIoWYWTWMjMxo+ogQMIDtsdfI/JrY=;
        b=J1Z5ekNJXq2lK7UFJmiRZ2uoo4QgG8elqfM0q7NQSy+JOTzVlLP/ZcX33c0nytHA23
         K1TPmnp83TiMI47OmBQzGi+sRNqk4f3nW3DAmj4zd0Z0doIEHfWZ2ivTF9bNwqXdfCOz
         wD6PTuPL3QD6zgdu/4+txQBrPSI64Bz1Q9nVEjsP74OA60eZPY2tYC35KG5ysu3v+pfU
         ydLi5CzBAoZFEUbCmIfPRbNULXDtwgZP8yaOZNYi9MqkQnMvX6krT0WD/UdACL0ozqHO
         55TO/fqrsobmREZymlA/lxMJ6l8UotY5EozDgvY+W5PCaZrsNe1QGSmudk2SDi/WwHBq
         Ie1w==
X-Forwarded-Encrypted: i=1; AJvYcCWNpmpXb/5sLCcCKdsDh7Mj6w2ujGlHoLSSbcKxXRDC8iRfwXjP5L8xUUHCUGEOX0NgZGbgiHT1ZZifOHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9c3WYhvvD+MO+WR1QFeT3Hgos1n+mtG7u6Q+UUsmahuqeJ29u
	R7bM+IX+EdbdXHGzY0cTZY+rq+sPrk2F1tQnvFc+TyD9rfAMkLByYtejCtg4e8FRXzhLgO+Yy2j
	NnOr6R1tU25c5dmNNegm3r0hicxItJjGUmzuHUHlb
X-Gm-Gg: ASbGnctG6ArkaKMESlcZi9m8mgp8HQJXHo01iEVndw2KA8NGScbCNLbCdRpzKbmiX6L
	nVJftrOkJsyMGcSK7moTXn5FGF1StuQmjtEwh7cjO+ZyL9ouVQl0PW3GBT3Ga/dCirZlk1dvldv
	tp9iDser7ZndsYSbYJkzEcIG9ogKRSDiDwpl59vlB3CeGaRcvcHIGqFn5dT/h8Xf+FFUa/jdXxr
	BLOAP8SAmkxkOz1Hb9MaNFrR6Gru0ytMto=
X-Google-Smtp-Source: AGHT+IGpIyGjdoXU8K/kqfT9EbCKuZ1P/UbxzuOZAFjAlSCrK9h8UYMlaZpSsyGq96eX7rkgH0LyBg6WuD8/+cT3P+Q=
X-Received: by 2002:a05:6122:1ac3:b0:530:7a17:88cc with SMTP id
 71dfb90a1353d-5373fcb8cc0mr947561e0c.8.1752666004344; Wed, 16 Jul 2025
 04:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711003502.857536-1-raduvele@google.com> <20250711003502.857536-2-raduvele@google.com>
 <aHCPDXonAevxkMho@google.com> <CACKy9TJHtA5K2YqdNdnMuTvOsz4OCkRds4Hbj8aZdK5VXpMgWw@mail.gmail.com>
 <aHXwOtrFpn-yRFvs@google.com>
In-Reply-To: <aHXwOtrFpn-yRFvs@google.com>
From: Radu Vele <raduvele@google.com>
Date: Wed, 16 Jul 2025 13:39:53 +0200
X-Gm-Features: Ac12FXwQS2VC3HS4Kj1qfSCAFYjKoS7ei57V4_5PTFoR4dFZbvp7wS5_4ppSKBo
Message-ID: <CACKy9TJvkx0Bi69pO187dxs8EUt3foc0seNYjn=vK4WCuTHYxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add lock per-port
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 8:07=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Jul 14, 2025 at 10:32:03AM +0200, Radu Vele wrote:
> > On Fri, Jul 11, 2025 at 6:12=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.o=
rg> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 12:35:02AM +0000, Radu Vele wrote:
> > > > Add a lock associated to each port to protect port data against
> > > > concurrent access. Concurrency may result from sysfs commands
> > > > and ec events.
> > >
> > > I realized the critical sections are way too large.  What exactly dat=
a the
> > > lock tries to protect?  Is the race possibility introduced by any pre=
vious
> > > commits?  Please provide more context.
> >
> > With the implementation of the role swap operations from the previous
> > commit (and also enter usb mode from another recent commit) we
> > introduce the possibility of concurrent access to the cros_ec_typec por=
t
> > data from the userspace (e.g. trigger a power role swap from sysfs) vs
> > from EC events (e.g. partner triggered a role swap that we accept).
> > This is the main reason to propose a per-port lock. This way we ensure
> > we protect the state of each port in the cros_ec_typec driver.
>
> To make sure I understand, did you mean the lock tries to prevent from
> sending multiple commands to EC at a time?  If yes, does it still need
> if the underlying ec_dev is guranteed that [1]?

Not really, as I noticed that both the ec and Type-C connector class
use their own mutexes.

My intention with the mutexes is to avoid race conditions in the case
when a role swap is in progress but at the same time there is a
`cros_port_update` that modifies the state of the port. Another
example I have in mind is when the port is being unregistered and
a role swap is issued.

Please let me know what you think.

>
> [1] https://elixir.bootlin.com/linux/v6.15/source/drivers/platform/chrome=
/cros_ec_proto.c#L661
>
> By taking the following hunk the patch adds as an example:
>
> @@ -54,6 +56,7 @@  static int cros_typec_enter_usb_mode(struct typec_port=
 *tc_port, enum usb_mode m
>                 .mode_to_enter =3D CROS_EC_ALTMODE_USB4
>         };
>
> +       guard(mutex)(&port->lock);
>         return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
>                           &req, sizeof(req), NULL, 0);
>
> It seems the lock doesn't protect any data but the command transfer.

Thanks for pointing that out, indeed I can remove the lock in this
function.

