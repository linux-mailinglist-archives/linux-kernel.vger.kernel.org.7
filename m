Return-Path: <linux-kernel+bounces-865920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439ABFE551
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F04335436F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F030216F;
	Wed, 22 Oct 2025 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="Qej/k9Qr"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375C2D0601
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169195; cv=none; b=Q5iBD+Nd3o4f6TbvAgz2Q7ywEcaFx7Nh2TOyD7nZW4632hOGreCqf6DbMoQIWH+idiUMuUuhQZplfQR3xRJnSVv/5E3M4NOR0VJDwmXWa6eLmdKAk5XdUDT2Y/58NDLPT4GyZt+TgGtzWnTbKqmxmiG1gDYyt7s6PR08XOq1YJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169195; c=relaxed/simple;
	bh=XY/fVzl28BJXNG49hJlcZcehSDNURMQ7FS8BdFDQScQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqLZnAjb3uC9xys13eSarGXUe9B+8SVzONPNR2O+1/3H3IEOmaRGvf5OmRgpxyOdsU6QP1PjeJW/mUjZIgn9y5Qf4J0OPCDs6vX2tfTpoiUdUqqks8pQQNWBH/zEAQgiR6om87DVaJeehnTH5mqgfBxVGNG50sv26E/E3laollE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=Qej/k9Qr; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e1e1bf882so83372d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1761169191; x=1761773991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY/fVzl28BJXNG49hJlcZcehSDNURMQ7FS8BdFDQScQ=;
        b=Qej/k9QrMzUWcdY4zLY6+cbgSJxDys9C2DtCnZDNDU9kxqETXOd5U9xVtmpjQOCIBV
         eFG0D4tNzsI4f7kCf5KLX3CZJMwQqejqjm1UKFaRckJ+h4gvB9JuCdVULS783xkwggIb
         GLa9vWDsJeX56dMGYBdrOxSqkK7Pk1pfUT5drEJ5a4wnMA7Q3wsTgpBe4V8JOrhHGRN1
         e+x3u/Fngjz19hvKLF4RJARo32XrWS7X1oqi6kvDVZl9Mvp0DWIIJTyrtRxRhS8UOTUd
         8/4Q6OyYXVSdGafA3c4IDo9j3m2InrfPs4FAZQHy3YNHZ2il2sko43g1FvqUzApyWzuh
         /BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761169191; x=1761773991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XY/fVzl28BJXNG49hJlcZcehSDNURMQ7FS8BdFDQScQ=;
        b=g3lppQApxHeBtpjti/nHmiNj6rOH59xGCNEMjiJBY1Qq7sBKbH02aO3S+FwpB/ETDs
         oprTBcpXk81fGy/7yxvF0orWmxZyFm61uaJZ8R273AaA/sWMGKQirH+1qvpKVSoJDLcr
         rCPLpJpVCTTlZ+I7TtfwjtT43v3ogOHuBGsU9Z8BLlNrutCJIj49dE2IPKz7lkugrKCV
         x/WrEgEaBMDCpY3dRuPNO4sTOA30CTOEX4tst4fzS8+KLUoBX27v0gomAsR0rKxSj/PS
         sXurdke10RoTPPxJUfhMsGiXUh+24X9eCiHmzDWh9oPQ3ZTtqZb2rJEDYEddz/SRWbM7
         eWCg==
X-Forwarded-Encrypted: i=1; AJvYcCWYcz95xL0xUrL/gmRd14DRC8xESj8cKX7AKL4tU6MFNMz+b38bsiKGfLsasfRjW99jQDuz9oOLuEhLIG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfeYzrsXSaAMHe0K/M5uuoY1JFfYGJek5htuE8DKCYo/p1O/X
	heEKZP26YtBviKshRfzkGaGVPemsb+A547zXduyo6dmWkp6NbLji5r1LXp2wOjw5feHlJhHfdyJ
	dN3KhuuMV6ZZW3Hu8Rh3NJjmMNgKLgNKtZfdmmwAzl115ELkLY+dXwTO2XaiC
X-Gm-Gg: ASbGncugBZ03sVFeDS6NtODonquncw7h8Be3cAltKmfvA8HHZiA6deFeoWmfvEA0hte
	CWYcWsJIPBP+lKDX0fgAdtP+mnHIuqI98H3xaMbnhrsJs36PwtXcFK1YL1rrHCHmaapRpqDi2S4
	Ud9tDO5UfNQQALbnuyjPT5ygpbnrn6DOCrfbySgG3V9BxOOeyg3Zlygb6o/kv3c0FfxEee1Bmq2
	zfYFtJsWx8RmnQryHLOIhfosiKIm1A95Q0Nw2TJfS83e0mqK0ONcdEI/I7KXSXnyxsC1K2I4SBL
	cdfHmlAcX9h2P4EELO4pDZQTSyLV
X-Google-Smtp-Source: AGHT+IHLticEoUHzz+5YlBnUoC99gaUTyPszn1BD+u/JBN5hlfiJhQmAcF37pUbO0+8+V7Ij2JZoZtpIzB/MD40J78o=
X-Received: by 2002:a05:690c:25c6:b0:780:fdbb:5265 with SMTP id
 00721157ae682-7836d1c62b1mr345947707b3.19.1761169191371; Wed, 22 Oct 2025
 14:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
 <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com> <CAA+WOBvVasy2wRP_wmP-R6Q8y5B4sN08jNYfHuDVjiWXV+m23Q@mail.gmail.com>
 <904ba70f-b1bf-4745-8e92-d27a6c903673@kernel.org>
In-Reply-To: <904ba70f-b1bf-4745-8e92-d27a6c903673@kernel.org>
From: Mary Guillemard <mary@mary.zone>
Date: Wed, 22 Oct 2025 23:39:40 +0200
X-Gm-Features: AS18NWBm422X6XetKOPBkLZPJQB9QiYJm8O_YbBTYHKPk9yZbZPBR3qyH8LezJU
Message-ID: <CAPv6GL2DQ_wY=r4eV_V=nBGaj20HtYzRfJg==rQJtuO8Fo+HAg@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: Danilo Krummrich <dakr@kernel.org>
Cc: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:56=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On 10/22/25 12:16 PM, Mohamed Ahmed wrote:
> > Pinging again re: review and also was asking if we can revert the
> > select_page_shift() handling back to v1 behavior with a fall-back
> > path, as it looks like there are some cases where
> > nouveau_bo_fixup_align() isn't enough;
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450#note_31=
59199.
>
> I don't think we should add a fallback for something that is expected to =
be
> sufficient.
>
> Instead we should figure out in which exact case the WARN_ON() was hit an=
d why.

The reason I wrote this code initially was to handle addresses
provided by userspace that aren't aligned to the page size selected
during BO creation.
This is something I did trigger when typing this patch initially with
my distro provided version of mesa (likely 25.0.x but it has been a
while)
Thomas Andersen also confirmed on nouveau irc channel that he did hit
this case with an old version of NVK and this patchset.

I think we could just remove the WARN_ON and properly document that
this was previously allowed and is there for backward compatibility.

Regards,
Mary Guillemard

