Return-Path: <linux-kernel+bounces-730254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57578B041EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1064A78DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022125A2C4;
	Mon, 14 Jul 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFAjWZJb"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874D246BC5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503837; cv=none; b=L5j3m1Wcefoo7wWHAA5vIHT7KBC5yCkayRA9Qw8p6QdwTc/pollYNpWXFMGi9JKpLIkOeNefOZYViY1jQM+ypT//mX6efvwEoFNcfbTk3SH7g8MTiaVtTQn/bsKhVwFjjvYMYVykxR8LIpRQk1OnCwnByNV3WuKukMVPFPC4Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503837; c=relaxed/simple;
	bh=TRcpibRTLH9cseWylS1uM49SbJnEmrei1lux8cE11sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPyysjFwl3dQ4DMEXvIN/EnsPoiS6PLFU1TwBKBdYydHYs/JWunyR87y84UFkuP3FZhlh/xrf0MG9n4BZzLVuT02buCirsy3RNLP6k7D1bo4zTZedrwiYg0F7BiqRRyyG+fUD+XQPGWiT7TP6KN24D8NxvpmMIo86o5CDwx/fV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFAjWZJb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3085173a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752503835; x=1753108635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRw/NX+KklOoltNcYQ1FFnx+QWAS9ZeWaLliEu+hd3U=;
        b=YFAjWZJbri7WyStVubAZWla8N4Qz/VXHOrXjyK0c8J0cea6UfqQ8y6wpuWvtZBYnTC
         xVgEiM2vWxUaKWRZPvSGPUu+E201rEd/iyEBqAjvq7fH6nwLU3s028J0exf2/mG3L8f+
         8wS6QxGHV+rxRHDTO4ehhopMaHGEUumEEgIyfnYSz8JBLmzF6ikeVPp6jgpw2I9xWZ5N
         UP5dRTzCKjYQ4QosLPc2cjAHlptuaOQatTtbr4EmN9qSipOheaNOkXTHAdJKD9M/7zL9
         mpaEqnj25guZVZjp2QFzplYmU4EOGXBY8z9lFyW2Oi0t1CxlIiLYwOUOP1YLWL+I5rLa
         jtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503835; x=1753108635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRw/NX+KklOoltNcYQ1FFnx+QWAS9ZeWaLliEu+hd3U=;
        b=UEboZ0NPw9wAF5UZnSjcVBPO8ElQSs0A7PDJ1pRY7LUtQRcQy8Z0wDK4DzApMHyXdT
         I0WE2TyFNkVfKL9cmyOiUQ6efLeU0oubM0aeqrqghj+i39wIUAwou7mOs2gjsPL9O9f4
         gQajYwymF+DlV4V8ZMVMN45RYJ5s3CoOkT9NYA4iI0QU3kPF3tTSFqYZ7xmiSyrvTNRk
         UjasanIJcsTzASG2FKeug1F9jNsZxbZDzZfl3hL0psle3S3MyQ6HxsEXXbNR/v1Oh6GZ
         pfNWdC9U7PPJJqj0yDbJF/ebum/65yTJ6XiX1ctD4c9ZdHGDO7dyEgBwmjyjoVmN/B7M
         lbVw==
X-Forwarded-Encrypted: i=1; AJvYcCWoz8g9VO/UmtAeqb/0mQ65NREqYqsdFXSQISNTE3aO2nPxf7W7rSj4KIX4cY9GiXEToedLhYd/BTnknLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWW9SMjY+x/Ujk87f7ez/QVNQ7wCY/8P571GxOX2hc0KRqIJn8
	4eiTniAl2xfdt/QvuP29fxVxLz5/OnbX30cxzEyVe8qXUVBh7UefPhXxG+v7bKIaYX8YWmjZsYX
	3OCFSsJpqEkiKsLNDaRDFa7lQXxI3mPV9rVo7pen3ug==
X-Gm-Gg: ASbGncugijO8F/fk3aT9Ir0cCFXpN95qfeVPxg42UWtXWGw3CUU4mDeDn9OEcTmTx3r
	WinOFiD2gxU0a3HjWuWQwz22t8xoaMtA74ZSiI7c0HWUIulGxp1AC9cn/RG/KNGmh2im7RfQgrI
	9j71mw4BCrpfoVYMG1NosHHv/uZTH9xksx5nfMHuezNSjUeEFP1ageMX1H46lIft9EhIg0yRJvk
	KhBPGshUekziGsApAY=
X-Google-Smtp-Source: AGHT+IE9vli31u992ZT8kPqLb073rl0Qa9Fp1wDpRWfD+6c5waYC0lIxt4DAIY775EghGpjiJXOpIWCdhZUB6c4WwNM=
X-Received: by 2002:a17:90b:1643:b0:311:9c9a:58d7 with SMTP id
 98e67ed59e1d1-31c4ccdcce7mr20175039a91.19.1752503835123; Mon, 14 Jul 2025
 07:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624181320.2810521-1-raymond.mao@linaro.org> <20250710005821.GA94507-robh@kernel.org>
In-Reply-To: <20250710005821.GA94507-robh@kernel.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 14 Jul 2025 10:37:03 -0400
X-Gm-Features: Ac12FXwMK2ygdSLWZAPAf0rvYVKKrh58aGskfqls54bumEBc4Dr9Mohtz6UOLQI
Message-ID: <CAEfUkUKXskNxdsFG0htpmcgNnVeau7n4wtH2FOweEW7BxC3scA@mail.gmail.com>
Subject: Re: [PATCH] docs: devicetree: overlay-notes: recommend top-level
 compatible in DTSO
To: Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Wed, 9 Jul 2025 at 20:58, Rob Herring <robh@kernel.org> wrote:
>
> +devicetree-spec (because linux-doc doesn't really care)
>
> On Tue, Jun 24, 2025 at 11:13:20AM -0700, Raymond Mao wrote:
> > When managing multiple base device trees and overlays in a structured
> > way (e.g. bundled in firmware or tools), it is helpful to identify the
> > intended target base DT for each overlay, which can be done via a
> > top-level compatible string in the overlay.
>
> I think this should be more general and more specific at the same time.
>
> You might not want to match on a top-level board/soc compatible, but
> rather the compatible for a specific node. For example, you may have an
> overlay for a cape, hat, etc. that applies to a connector node and that
> connector node could be on any number of boards or even multiple
> connectors on 1 board. That's all under development, but so far in those
> cases we expect some sort of connector driver to apply the overlays. But
> I think you could have the same issue of identifying which overlay files
> are relevant. I don't think folks working on add-on boards have thought
> that far ahead.
>

The use case from the angle of a specific driver might be a completely
different scenario.
The motivation of this patch is to support handing over DTOs as
transfer entries across different boot stages via transfer list.
Unlike for a specific driver, a DTO within a transfer entry is usually
board-leveled and contains nodes for more than one driver.
The transfer list library in each boot stage does not have knowledge
on a single specific driver and which target base should be applied is
the only interest.
That is the common DTO use case in Firmware Handoff and why we need
the top-level compatible to be introduced.
For details, please see my PR for the Firmware Handoff spec update to
support DTO as transfer entries at:
https://github.com/FirmwareHandoff/firmware_handoff/pull/74

> And since we don't know the target-path up front, it is just left blank
> so far. It would be better if we expressed *something*. Perhaps
> 'target-compatible'? Something like that would work in your case I
> think.
>
> You'd have to be somewhat crazy, but you can bundle a bunch of
> mutually-exclusive or unrelated overlays within a single overlay file. I
> don't know that we want to prevent doing that. Someone might come up
> with some not crazy reason to do that...
>
> >
> > This patch updates the document with a note and example for this
> > practice.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  Documentation/devicetree/overlay-notes.rst | 28 ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> > index 35e79242af9a..30b142d1b2ee 100644
> > --- a/Documentation/devicetree/overlay-notes.rst
> > +++ b/Documentation/devicetree/overlay-notes.rst
> > @@ -103,6 +103,34 @@ The above bar.dtso example modified to use target path syntax is::
> >      ---- bar.dtso --------------------------------------------------------------
> >
> >
> > +Overlay identification
> > +----------------------
> > +
> > +When managing overlays dynamically or bundling multiple base device trees
> > +and overlays in a single system (e.g., in firmware, initramfs, or user-space
> > +tools), it becomes important to associate each overlay with its intended
> > +target base DT.
> > +
> > +To support this, overlays should include the top-level compatible string
> > +from its base DT.
>
> The base has multiple compatible strings, so which one? Has to match on
> any one or all of them?

Match only with base's top-level compatible, see above for the
explanation of the use case.

Regards,
Raymond

>
> > +This enables higher-level software or firmware to identify which base DT
> > +an overlay is compatible with and apply it accordingly.
> > +
> > +Example usage::
> > +
> > +    ---- bar.dtso - overlay with top-level compatible string -------------------
> > +     /dts-v1/;
> > +     /plugin/;
> > +     compatible = "corp,foo";
> > +
> > +     ...
> > +    ---- bar.dtso --------------------------------------------------------------
> > +
> > +This top-level compatible string is not required by the kernel overlay
> > +mechanism itself, but it is strongly recommended for managing overlays in
> > +scalable systems.
> > +
> > +
> >  Overlay in-kernel API
> >  --------------------------------
> >
> > --
> > 2.25.1
> >

