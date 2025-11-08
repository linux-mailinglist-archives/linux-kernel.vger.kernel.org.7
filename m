Return-Path: <linux-kernel+bounces-891677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7630C433BB
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 477C94E28B0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56D27B50F;
	Sat,  8 Nov 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="MplrY2sw"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5F33E7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630224; cv=none; b=FpFmj9PpwRjIwQ/CzKRNLBYaOKB5TnHM9l61Iq0GCL4MA+ApSS2U7mdzsQ8h7O5USJs9fBYNu3I5uYO1xNx0LQq7nqSjM2YyS8Cf/buGB2dWBKVxoq/vnR1yTeb0W+QTV55EOXpfivL3/AVPf/sWFgB4WhIcHKrpJg4j+GX4zKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630224; c=relaxed/simple;
	bh=KyRJZiWrQiGWx3CFD7wgOdd2jyZ0NCxb1AABBCZa0vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpgV7KFnl+UCaWaPTS9pmaq3ZJvJjHHabRujDfsLyzHd+MMG7/kTJ2l7ra5SgGcpQQS6A/EAtQDceNMr128nCJ1x070kIRjZkEhQJUidoinFI8YErebI8xF2cECoK198N8gcl0rQFUCuTT/TiN9juyST4bcu/rJwfJsZl7HWqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=MplrY2sw; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-781014f4e12so16639287b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1762630220; x=1763235020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyRJZiWrQiGWx3CFD7wgOdd2jyZ0NCxb1AABBCZa0vs=;
        b=MplrY2swZcqtvXFvuCJksnpsKGziVaMgdzqvWF7NpfWc6YwkzVPJslBHQgoKpQFrYg
         KWvv8CpMIxjFyPCBjeHHQvYWinPpKefp+a8V1Rz/ZMZmgB/w/v/ka+KCDQBqF49yIe9B
         W2qa1lBhxb+whaOs+gQEshoV4ROiJqQbswJUgmcMSK7rqU/TeXAPZHMmwb3RCdZwg2QQ
         11tieFlb/2CtLjFyfZg0C2ev33cJkVyP6fbPblpX8ddGInUP6Gg+XjFl2tx9MPoQtYsC
         Nmm2V86Cv0WU6Al7SgxhkshyAl4rCNM3tR5vHaroL+PN8UlUozv3voA5kiRUhiEEDS4J
         33lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630220; x=1763235020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyRJZiWrQiGWx3CFD7wgOdd2jyZ0NCxb1AABBCZa0vs=;
        b=k0AQeombWKgPyS0+t31lVANHC8/SXPzQ8aklaIPo/+zLEIsEWBgJu5nxNyR0nzanui
         7sNGF+fdrjjcp94eawedilXfRavl7u524lLsCmvdikS4iFhZLEtmwjykkprTTK7OIilH
         usmjUE/1TfaZrz3ngxUI34YUhvMMP/Q3+JFwXLLWIqTp1jWSpRT8hBbClDYkd6fpVKgZ
         +NoaPwzJ857rujV4KrrWTXdEZCmvB9W6tAgEH79q2T5XVYVB6TDNVffprU9ol4IySe7w
         uvF1rypYGvPf8Ol3O7UI0figcTdqjzLhTnLVFKLZ+WiXiznOmtrN5z+LgFM/8Gj9CPpC
         vg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLQsvDjNb5YtxadYLW2p49YlFj5DViRYgw6Ili+SK2HIJl8M1molhdw2BwIacjJt+e1dJ3fezO2WBZRU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Xe3HO7eSEUrKmaVZ1yS5C5BX6uOaSlOVkKwKjm+Uen4FGxrp
	L5lWR719w55i+h2uO+44Z0NXI1JfASpgTn8U1O3w3pLqXL9N/c2WjL2PwDLz/iKtL4pj0GwTuYo
	tswpKOoITPwHStiH9TX2CjSEaLV3TecGKr9QSVCjFUA==
X-Gm-Gg: ASbGnctYS0PH6vrUDqVgEDPfUGGtYYHpt5J1RYJsok5Lf2I4c4B5s8vXcylXbFrMGPu
	w1uNlsjZYyUWWeruqaGrfSOGApECcbtowfWO7Tdf+qO6ooRJZknyJNBS8GS1R4o4zcuQmcPFH4z
	SWGRfb2IsPpeFr3SXmpBq6AcoH/16HPeYx8SjXCE4NaxANyjFbpfJ//x8VUPOJslIJI+/hRx8Pw
	UUK+BzkRLjhRcN16SjpY8AZGw396FlODa69jzvMVr6DCY3exJtn5JE54e9nnED5qqIjq2JGZ0EJ
	/wH8zjsk8sO+9rz9gqgxk/KWwwU=
X-Google-Smtp-Source: AGHT+IGIYT+SUHEWS8jwXTJD4hh40k1duU3pvKoIO6/tM9I7kWkKHb17WkBAF0kaIdPn4lajaFC8l3EQAoBHjvEIEk4=
X-Received: by 2002:a05:690c:a4c1:10b0:785:fd34:a355 with SMTP id
 00721157ae682-787d53fccf1mr27702217b3.40.1762630219745; Sat, 08 Nov 2025
 11:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
 <20251031104924.10631-3-mohamedahmedegypt2001@gmail.com> <0bffd718-3659-4add-90fc-fb0e098f2897@nvidia.com>
 <CAA+WOBtmbPHigscFQCFgDo=9WSM6V-JMXGCO7orP=01XOqTPHQ@mail.gmail.com> <4d07932e-8b53-4ee3-8d08-6f49d433f005@kernel.org>
In-Reply-To: <4d07932e-8b53-4ee3-8d08-6f49d433f005@kernel.org>
From: Mary Guillemard <mary@mary.zone>
Date: Sat, 8 Nov 2025 20:30:09 +0100
X-Gm-Features: AWmQ_bmUShDzVgDbCjXaRk8KzGqVzibLvo1soC_Ryl9pqm71yycsphufLLwaE8g
Message-ID: <CAPv6GL3+Fs-7DCHGgk-rBpJjNHBLYvubbcBK-0U_Ew93_ka3Og@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm/nouveau/uvmm: Allow larger pages
To: Danilo Krummrich <dakr@kernel.org>
Cc: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, James Jones <jajones@nvidia.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 5, 2025 at 11:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 11/4/25 12:53 AM, Mohamed Ahmed wrote:
> > Thanks a lot for the shout out! Looking more at things, the logic here
> > is actually redundant. It was originally copied over directly from the
> > bo allocation code to stay on the safer side (basically the idea back
> > then was to make both the bo and vmm sides match exactly). We aren't
> > at risk of having an aligned address that is in the wrong memory type
> > because the bo allocation code (nouveau_bo.c:321) forces anything that
> > has the GART flag to have a page size of 4K. Anything getting a page
> > size higher than that is exclusively VRAM only. Additionally,
> > currently things marked VRAM only don't get evicted to host memory
> > except under high memory pressure and in that case, the context is
> > paused until the objects in question are paged back in, so we also
> > don't have to worry about memory placement there.
> >
> > The memory placement check in the vmm code could be removed but I am
> > leaning more towards leaving it as is just to stay on the safer side.
>
> If it is not necessary, please remove it. We should not carry dead code.
>

For correctness, this code path needs to refuse incompatible domains
to decide the appropriate page size.
As such those checks should remain.

Regards,
Mary

