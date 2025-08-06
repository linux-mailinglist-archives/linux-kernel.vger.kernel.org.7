Return-Path: <linux-kernel+bounces-757401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4EB1C1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2883A7170
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191B21FF24;
	Wed,  6 Aug 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL+TN5Gb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984D21D3EC;
	Wed,  6 Aug 2025 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467316; cv=none; b=qpew18VS7hpQNgeDFeaVmxSZRINGUxyECeVq+8vS+R9HwbyUWWZMwzU24L0mUUS95aHCFFE6kwXEJzizgjxSFI5sMojB3jrrQms8gG9wtnnk9msMlWg0XhADjXDZfLn/synwE6tyhTAZ4bR5PYxkDRuq2t198d1RFPsC5clRbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467316; c=relaxed/simple;
	bh=KWNUw1uurBwbVYMMXqCSCxlKIRGI/xDpu4xRO6XnF68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQVyW11PyEBqTZfMzHmksl0C+lQUbbNenCwvtTJPJBUUqj7Jnl0WOkoKXvY7BHXrKkGfkUupbElmyOZQkWOkQdsT89U6cfs4HVndXl2jYBZYNQmakZAaw0KbASueYfzqsTxaS4biLRl0rmILIZ/CAmTNv7niKvkMOimw44CgxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL+TN5Gb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so11292899a12.1;
        Wed, 06 Aug 2025 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754467313; x=1755072113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iCzFRU8kKIqKUJirQf+HWWFYyGorAzIYLXfyzdGgPQ=;
        b=iL+TN5Gbm5RFofgoIadSAo6oCGXF50QLuiKr5AjQ0xrItbG6vKojz8DfG8OhoCJrAZ
         DuL/nTs3lkcVuUidoPBKTAkVpi27+dvUXLIS8dz6qyj+Xtqg0udDkhwaWakZFdzc0tiF
         VjHQj4C448pyCP+6iivK3YVLlu+Sj4iA+NwZ59KUeP3bq09Nb5KjM2QaPMD/N/cXAjjW
         KWCOze905fhRnIDTLokeHguNWdf3KDkmTtgi1Z58WJY1cPp79Ldoi2Djmo8qSiD2Zwxa
         kE2AEen+4JzpP9jmOW301aAQBxodRfKlNWuU6p8YIxAfmFSfVl9x6HGca51jhfvnq46H
         sayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467313; x=1755072113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iCzFRU8kKIqKUJirQf+HWWFYyGorAzIYLXfyzdGgPQ=;
        b=HapDwnZY4vwiL1n0O9u/L2KlA0f4e+szVI/KYi/GykZVlVqa+N+Y4oLNdyWrqSjK+8
         zOAddli+roQW3O90QprMcwAzc/3HoXUinZzHKUnwY0GsB/vUc3ZD/gehgLUFsuGtSdgX
         4Rb/F/sjQew/3KYwK6oDYJKr0K4+89EvZ0VHpW+Q/J6wXnsM2bsq2WX53u1ZQ01/BuYl
         1JmHulw9ao7NGVkvVc0GaPPSciHP5XQX4MkQVLFyfKxDZELkiBsIZB7FXgGfSjWH8P9M
         PzfjUQgLrEKRWSJ59wvwAa+KYb/fxSdrjDrTs6lNeQd1w5uLwEsnp2TiQx/Sxk3arWFa
         g7aA==
X-Forwarded-Encrypted: i=1; AJvYcCWf9sWQ8lM0QNtYXkkSjI6l5KlTWmEJcqPgtsNJd22lxXIB3f+jhml0OXMNbLeXbqSMAXA/fybOlt4Wf0Gw@vger.kernel.org, AJvYcCXMEablYGzZamcQdg6JTJv9Ot2QSTxWZr1lI+UbYeXRYH65WdGNiqcLTWTishym5h+WMC8wGVRuwanA@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlCK8PNWKZVXawm59k9OwGwaoDGO+rO4v8YcEKwO+suiZl8Qn
	s91caOMja8mcU0Ch0a9Py7an3d9tx+IlYdSkfwJ2c0FEv7Pym3CxNhZk9THeXgxidhk+3ViPj0M
	eHH9YNIlaZEW87w/cbucQKtRaKe0yo1Q=
X-Gm-Gg: ASbGncvnkRejtKDauLkrkh6sMZ7S5M2NKymiJ9hzQVtdDXfdgE2xN6EDFZeCQ55c/0Q
	0Z54AxGBh/fl9IQONJjz3jVp996nyqGfBGKwaG8fYDYfORaYwRUJzQLjgsWV+7ETJ5swdiNTfwF
	MwiTQk8lzH+3tzvKfDExEAgIdwu2AM/pf0t9S6Ac7b3UyJFjQ5Rce2jLgt2qCTrDD9tQ9EMXczC
	tbN1ervALb4aSRBzfvuKLUvD8JJBg==
X-Google-Smtp-Source: AGHT+IFLnS66PAFjbYXbRkE65+dBg7IT74rclUu90hts6vAYoZ9fqvLM2kqGkYBQPfmT60uh5xRuPSJY4tL4HkJ4oXs=
X-Received: by 2002:a50:baa6:0:b0:612:bfb2:386 with SMTP id
 4fb4d7f45d1cf-6179617bfefmr1195837a12.28.1754467312584; Wed, 06 Aug 2025
 01:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
 <20250731-ums9230-drm-v3-1-06d4f57c4b08@abscue.de> <175424000200.522677.10470224183997281701.robh@kernel.org>
In-Reply-To: <175424000200.522677.10470224183997281701.robh@kernel.org>
From: Cixi Geng <gengcixi@gmail.com>
Date: Wed, 6 Aug 2025 16:01:15 +0800
X-Gm-Features: Ac12FXwuP9GqGL7vRUeucDLGxlVViCM53h0qDTc6CYWtwi-PmaWkTPBHQBO-hmA
Message-ID: <CAF12kFsczEgNWY09A8PCSyVqSGwQ0xHqxthrqoHfX20q8x3HFg@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] dt-bindings: display: sprd: adapt for UMS9230 support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Tang <kevin3.tang@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Kevin Tang <kevin.tang@unisoc.com>, Liviu Dudau <Liviu.Dudau@arm.com>, 
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Eric Anholt <eric@anholt.net>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rob Herring (Arm) <robh@kernel.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=80 00:53=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Thu, 31 Jul 2025 17:51:14 +0200, Otto Pfl=C3=BCger wrote:
> > Add new compatible strings for the DPU and DSI controller found in the
> > UMS9230 SoC.
> >
> > Signed-off-by: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
> > ---
> >  .../devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml         | 7=
 ++++++-
> >  .../devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml    | 4=
 +++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>
>
Reviewed-by: Cixi Geng <cixi.geng@linux.dev>

