Return-Path: <linux-kernel+bounces-877759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93565C1EF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ED94237C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672EC30E0EA;
	Thu, 30 Oct 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je3Zp/tC"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FD37A3DF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812391; cv=none; b=uOKejCi8KqtPOJiQw1UD73RbeVX/SW8ug3IrL5lGXjp2pRO46b71OV7sKkk5jVfYRxycHBRI8n/U+YX9L8L6hMpVzmJuLW/yppUoj2GXZdGwg+/kpunORaBUGUPb7exSwKs4iXMBAUos8GEiVe1HaJmVs4Peq28kBh4yb7lq3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812391; c=relaxed/simple;
	bh=0u/aX8jowtOg91fEo02VTBOleA72XQG8pJM9OALYzgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXAPfN+E+b2niL3L3b3SnNfGZIvNqWAL+Qvwi6XacdG5raTTpW4k09QlVU6flU1K8s3OwPdnjxkvjwUbep47VOEhzwaQqwW7gkC3ElDKD1mDdSuTEWExxNu2WmxkDSuWivcbqSruRgegQidY8vdUcxdSbvaguNMuYJk6pwOlYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je3Zp/tC; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-81efcad9c90so8808926d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761812389; x=1762417189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4GGA8C+qC7scQxhEzEwo/Uv+6XLnYJQPV015WHzIvo=;
        b=Je3Zp/tCw62VjyyEL6PQUx5NmMESpG/vp0PZ4bSMeALpWIQV6q3LdUXtzHmx0Kz5Kh
         4SqS7t181eDjiAPqr4Gsg5AAimz0FfIQLrnSvOY9ioCHyzv/1hzOSWxqp9tE7lv3OB9/
         W7EYiXsmMLDXtSkIJOTPJPGn3mzXOCaPM0LZPN87rOLEzmw5oqUamVeVFFN0aXTYECIF
         xtUZHi5macLFzTJco0RKG055709YdPgqB0MGcH+9ibywaNgmgR+v6mnNt/KkD8Qc0g/T
         le29cmGcNi2X4pZLcpVTfhd3fWVG7ZWFXbK5kPa9gQaOzjuefP7rct46ory52u84LFso
         QGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812389; x=1762417189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4GGA8C+qC7scQxhEzEwo/Uv+6XLnYJQPV015WHzIvo=;
        b=CuUoIqGT95Ys/1mHznCK54z94yCQUDesHemH6cwU8BYXB2p3r5RkXta4MJIBM3uc6E
         gIYRJFkjoit7NbmderBqa4RdNlZpJHdLWkhdnzIS5e10oeaDlPinhDwy/LahhFgxA/B+
         lNWsakuNHFuYYlOci8lEoRJm84b9ad3BHOo+0ngtb2BEhuhn/7JrbaP7MC6sruyfvaKR
         5Hm90AwfXhKG+3z4sQ/NIoBVhmKdmJAOX9arqC8WA16EjpTz5wmFlCG89aGGSlmaLwhp
         1SL3hLzI/FxNbLGXRvliO3Q6QY0jN2kjqarMdBpJaMkHQxNIC7fmFwSpT3kaNf9cwHjT
         SCoQ==
X-Gm-Message-State: AOJu0YzPtyk4sBsy6oo7T6OlRrf76v/bRzJQ1vKQ/fXEdks2VSS0aP+M
	KP5F7duVuv1A+iwsOXOFj9qXSQUSaurXhkCCCKc5r97qWl24A5BXrim4Wpcf4HnpmfxXuUqhfuT
	/8yXds4E2P61dgfRdAAljWGcSiGCC+cyfdNJNQTJuYzGZ/h/8S4Y4vo4e+TN8
X-Gm-Gg: ASbGncsqCcoGI1B4iIXC7EvZwz7qOPMxQ9MuGUKVkPmfNTa8dHyQ29zmhy+q/D7SQw8
	rMvsSvdgaWL5Gfdhe2fe1DHIps+X5ODP2Yao3y3Z2pmcr4RqHCNq4E0AyI8Vqi7JOENd9n6e5sq
	wpPJ88OAlvK0PjX4uS6tfpAoqlEO0llsJkI4CYlp7wsG/A9IPD476Jb6u0otSRbAzqh9BfwvxIA
	4p1e+CUJx1/nutGqCsDiORDWzrsrCxa0747VSLa13A6HB8ZEFA5XVJPDxuRVg==
X-Google-Smtp-Source: AGHT+IHKzySlh2xWjemjoRxA6aM24KBgvKC6QJyiKtCgLvO8M5KIMZs6/sRSPGVe6C1H6y5uA+B4ZPDxG0J76bunyP0=
X-Received: by 2002:a05:6214:2023:b0:87c:2bb6:741 with SMTP id
 6a1803df08f44-88009b34e02mr75373716d6.29.1761812389033; Thu, 30 Oct 2025
 01:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com> <CAD=FV=X9hUxsrJ6o5yP0-bprfKgyQzZJnQRwQVYRo6G0yKWhCg@mail.gmail.com>
In-Reply-To: <CAD=FV=X9hUxsrJ6o5yP0-bprfKgyQzZJnQRwQVYRo6G0yKWhCg@mail.gmail.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Thu, 30 Oct 2025 16:19:38 +0800
X-Gm-Features: AWmQ_bn2Qk2jFJLn5w35Gc8DD2H6IZiJTPJVsyZgXXmXukoxzjMCmpAu4IXuxtU
Message-ID: <CALprXBYk5YE+bwKToKPez=QGv=KeJOwAgpCFxjhxdg4vAGNquQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel-edp: Add override bpc quirk for generic edp
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Oct 30, 2025 at 7:21=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:

> At first I was thinking that the quirks in "drm_edid.c" were probably
> just for "DP" display, but then I just realized that they probably
> also are for "eDP" panels. Specifically I think Intel hardware doesn't
> use panel-edp.c so I think the only place quirks could get applied (if
> an eDP panel was also used on Intel hardware) was from "drm_edid.c".
>
> Any chance you could confirm if EDID_QUIRK_FORCE_6BPC works for you?

The following quirks added in drm_edid.c is workable,
+       /* Sharp LQ116M1JW10 reports 8 bpc and it  will display noise,
but display noiseless as 6 bpc  */
+       EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),

I will send upstream a new patch for modifying the drm_edid.c , thank
you so much

