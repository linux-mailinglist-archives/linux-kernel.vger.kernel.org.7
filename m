Return-Path: <linux-kernel+bounces-776294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CDB2CB79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5DC163815
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0E30DD3E;
	Tue, 19 Aug 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTxb3tTD"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91591D6DB5;
	Tue, 19 Aug 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625868; cv=none; b=M3Qs1wSY44Drtu2IXaEUw+9mviN2KoLW8qMv4f4uziqs7LdtK2N5+WRVm7xWibyir63UggDdG7sVYar+L1N5vfCL2/rM4r4dhfdp62kluODyQDjbNUq/nu10NJ/QFTQLyTPlZDtxjJfGylDBcAHGysbBnQ0ylaxOR4RBtlM1gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625868; c=relaxed/simple;
	bh=f0kmNC7ZkTwG3EKPjuZE4Izi+zvTTxFihBN9XnUr9Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOSqH9o3y33qvtx5oHFUscLzEjmIu9u20XlZPcryM0j1b2SaIwJcGycMPuYE5LRqJWhwqJlCOm4i7IHevMzG/7PgLa1GSoHwUgpz1sb0XaBb+prXRTlrckshHK1TOWa2aZMnVyX+PIToD5b1/qbLq/7MQePSdPZrp/NZT+MamBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTxb3tTD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so227958a12.1;
        Tue, 19 Aug 2025 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755625865; x=1756230665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmlcDpKD9YCg6XDWMZQyI3wgJy7zu34Qq/sxftvQ6ww=;
        b=JTxb3tTDwRsuP0SbOfx06x/Io9okl2s886bhxEQzEgpVY2mRrS60+L9PSLTGxs0uJ+
         o270Ftq5oIcduejrGDSrxH+fP98wE+XHXIoqQCxPooArtKRUEAZrqu0hdNBiAQPCM33N
         9XFYGVO8bXoI34A1kniRen6spUxaPpM95tnfN6ASrQSfonQhhzow3CYD6eN/0zDqK3ZI
         QoTI1n+fLsa3YqJTiXlQ9kSD4nMdEP3ZO4yBcbNqeQKPxMib26GGP1xLcya4mEUKdhcM
         1vSpRRRF9ndRj0yYsLQwdb+hA1bb9hy1Ed2b6fl36NL1Mao9mZ0ryLL/TyPwLrNSfm+K
         03sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625865; x=1756230665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmlcDpKD9YCg6XDWMZQyI3wgJy7zu34Qq/sxftvQ6ww=;
        b=tLy54rOTnNl83eIbBNca7rnIFHmNmgmG8Jx5zeGu+pbzKjvqSsqFHPhcklAPwvLs9g
         Gcgox/KeABlfLwHbgMgpd0Ryi7x4P4/wLJkNEhrxAETG75G7uMLKjEfsVSbqOISKlJYk
         YWfFJGORfI4rFoA2as6M4G7qFijXLg/j9DmjgGFa1AyAalUlz+Xch0l7MvEzRlpnLQ7y
         EbDDTXxGNVPPgIjy58hCBkkvy64Pq2V9Cj6DmUaFOGZbO38NkziE1nCf4Z0lm6+u+s6k
         MudAFgwtSO91q16c+WT5pE46mB6O3j2f+E9FIAhwvywXsGfzgnNHH9ufx1hLKQzzL61f
         YJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUC9lnCVgJCM9pZTKfSQzWLCc5hacaGG/kllD4cBSjDO3NMDBzUZQCryhGPa0pEqnJRXkq29H14EU53@vger.kernel.org, AJvYcCVl5orOJmetLCzOGJR9xid1P8p2L2AtJmki5flkcQvHqWZK2w1sSvSQDz5YQ0bEf8C7KZAnr/xUydJC@vger.kernel.org, AJvYcCWbl7homfAxK9d5bixeMAf2pPOdy/n9Nh/iXXr9SKn9hE4BRmeuhb5K/XuZ6cSz4DVzhkyo0hzwME82QYQ=@vger.kernel.org, AJvYcCXvFJ4jpSlxkeJMmP7gieU0/GAt32/fS9IkW0CoLr6t1hvT+NmKXF/v8pz+0mOpjeZPuhg6XLREAad/D4e4@vger.kernel.org
X-Gm-Message-State: AOJu0YyPnggERSMc1AUK4wYGoKcBd+wDIqKgkQSdaJmdZytKDIE71YwR
	iQdwa3yQT1BUF1vcYb72DvpZaG4CXh3eFh7t7ND3B5h9LZIp1dpMIpi0UFz9H/ypY+lhGktuAUQ
	AXEeNlgvOkC+UIFFNjHOmxf1V3Rl0sQ==
X-Gm-Gg: ASbGnctJs0QO5SNpt9zZBHAX/uUVfL62u+N2ftv5nWUF0k/naRusSEbxUYOaZfM1FVV
	POIv3i4wAMzyR0nqhsTFQA7q92zv2EYkGd6elxRYLt/EdECPz9lTYmNc5NPA/tMxchVbsE+wskI
	e+ghIMibvU2/B9C49RvFa8VCv8a3nC1yz1oJLNtqZkvL6j9Y97uEK0MZu6/yu0EfP1/UZcV1tQQ
	5nbrrdp
X-Google-Smtp-Source: AGHT+IGIn7OrCgxggr5EugvTj/Sse9SmV8lSb5a2wGootksUGazgLec5LF39WE585X64DXNcz/QNI34UrA6hniB8i/U=
X-Received: by 2002:a05:6402:21c6:b0:615:8b65:bfb6 with SMTP id
 4fb4d7f45d1cf-61a9762bdd9mr200792a12.13.1755625864642; Tue, 19 Aug 2025
 10:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
 <20250811-hwmon-tps23861-add-class-restrictions-v2-2-ebd122ec5e3b@gmail.com>
 <eab6d2d2-9337-40fe-81c7-95dc1956ce6f@kernel.org> <CAAcybusHjAR67N0rumb6M_uG1ct3aa=zv2XkpUjhSSxv0NdzFA@mail.gmail.com>
 <ff167728-a4a7-4f7d-a809-d0e482ab7dd6@kernel.org> <20250818173147.GA1496879-robh@kernel.org>
In-Reply-To: <20250818173147.GA1496879-robh@kernel.org>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Tue, 19 Aug 2025 10:50:27 -0700
X-Gm-Features: Ac12FXyAVHvUPA_M5rmxd1gHCRHGcX9U5-wyguctTXq3hq_2ENu30t339lVgjh8
Message-ID: <CAAcybuthoac8h1T8dm96eOn9NdSq_aR0_OD7UKcxqrpK-BExrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: update TI TPS23861 bindings
 with per-port schema
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Robert Marko <robert.marko@sartura.hr>, 
	Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 09:23:09AM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2025 05:00, Gregory Fuchedgi wrote:
> > On Tue, Aug 12, 2025 at 12:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>> +  shutdown-gpios:
> >> powerdown-gpios, see gpio-consumer-common.yaml
> > It is called shutdown in the datasheet, but seems like neither powerdow=
n nor
> > shutdown truly reflects its purpose. This pin doesn't power down the co=
ntroller
> > itself. It shuts down the ports while keeping the controller available =
for
> > configuration over i2c. Should I call it ti,ports-shutdown-gpios or may=
be
> > ti,shutdown-gpios? Any other suggestions?
> Feels more like enable-gpios.
Wouldn't that be confusing, since there's no enable pin in the datasheet? A=
lso
it doesn't enable/disable the controller itself, but its ports.
In my mind ti,ports-shutdown-gpios is the most meaningful name for it. That=
 said
I appreciate the guidance, since I do not know what's the usual way to do t=
his?
Happy to go with enable-gpios if that's the convention.

On Mon, Aug 18, 2025 at 10:31=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> > >>> +patternProperties:
> > >>> +  "^port@[0-3]$":
> > >> This goes to ports property.
> > > Do you mean I should add another DT node that groups all ports? such =
as:
> > > compatible =3D "ti,tps23861"; ports { port@0 {...} port@1 {...} }
> > Yes.
> Except this is not an OF graph. Don't re-use it when it is not that.
> Maybe 'poe-port@'? Is multiple ports/channels something common on PoE
> chips? I'd guess so. If so, then come up with something common.
poe-port@ sounds good to me. When you say come up with something common, do=
es
that imply adding it to a new file, like bindings/hwmon/poe-common.yaml? Or=
 just
using poe-port in this dt without the parent ports node?

> Whether you should have a container node like 'ports' is a separate
> question. You get exactly 1 address space for any given node. So if you
> ever might need to address multiple disjoint things, then you probably
> want a container node.
I do not want to address anything else in this case, so I'd keep it simple.
But let me know if I'm missing any important details.
Appreciate the guidance.

