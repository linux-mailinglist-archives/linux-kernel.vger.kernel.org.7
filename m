Return-Path: <linux-kernel+bounces-880163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34F6C25053
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA621463B50
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB76347BA7;
	Fri, 31 Oct 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fpIJ5k6j"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D357346FC3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913928; cv=none; b=SmySBIOflhaZxKdxzaOM+p5R34XNe57NvKHQoBEWrT0bdZA9+nJ+oTgKJifeXQ2f8P9AacjTlYq4rdKfVI9qf6z9IKydeyzVJBVxqyAuliuBCBLQLTNkY94FSZ1uRwuz/NRE2jHl+MLJ8lhbEw3jEwb6Ddb/B61NGi0nJXGGjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913928; c=relaxed/simple;
	bh=EyUdF6niWEd87pLWTbZVjn7rdZe1vDwhwIQZCMaj54A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5vz7z6vQYvvy+hPdV0sIjdrHl1Jn1kZUp12jQ1Jtasdzl3ClEbyNbSs5k4fCmrShf3UeILJ3zdcJszMfHekU3Wdu/4Rpd/Mqu5ob+U9OPR9pYDEghTUujnGYyr3lrkUFAgVI0vfq3APCPWBcyllCr1XDNI6G3VMnX6JHzMFGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=fpIJ5k6j; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-44f96b5401cso13469b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761913924; x=1762518724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlQXBrL6GJchLN0rsfCNDqviLGR3waoluveYLsj3WyU=;
        b=fpIJ5k6j+UjSLXI30bMS6EXrrW/4JKH/FEdXHbp2Xj35sEgQH6GH+Uj4P1aO/diTcx
         UA6KpJ06eI9WG39ygQX9prqjGuYZ8PSUS1A+XZDWFRlbfCiKJcumpfNXmrBm3+htAdPm
         H+wJ6ddgMQFgupf5uJcFBA7h1VxM4Fmd5TrPqnzbe4tRHovsH31mSS6s6hXKbcmg0WMo
         a21P8tQHOvmmnA66gXr2ta7wm3iTTZrbwPQD66K1CO3SXBF3oGi/I7oTLL3slsKcGORE
         AR7tJ30tP41Klm73MjOfo054a3fb9e2RASqpv63EmkX4BSTc8+1e0gJ8Btj/HOrv9PWs
         mXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913924; x=1762518724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlQXBrL6GJchLN0rsfCNDqviLGR3waoluveYLsj3WyU=;
        b=oZJqXreA2v+kL/RX7H1W5s04Au4hzD7MZj1WnOMtUag7GOxgUoU6BP7ecjm1iN2YLH
         B3CKJvu09P0yjfpj11XsLnD3T39AKbYZT/yi6/U+isni9MKjxayUJaesNX4H/05I0pOt
         TNei2ieo9y192lNgOmoAJAWjcT8HbAoJTun3y9wEMBK0j2eqoc8q6plWnWXAgsw51U9y
         p6ni7mwUJceXyWjgysJUBo866BrXA5ZuuP972H7AUiO5NofpG3umQH1/h5CDn6ioJJhm
         KJ87gar0Vxx7Wn53M9AjzR6JCNbKPUTzJFjRlGEa7uBkovvjAhvSanPlkuuY6E1GDhko
         gCOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYuyWNiMi2cJ9NZnh73rIz926kNd9nngujIb5WnME2KEcniu/34YOjeoYakTV5UCfk0JpSxUm8E9NHOOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqGiJYknjI0ScB5FqjC8ZgfkQ6ibJLRk6AuDzAqc0mntP5nKe
	qN52Sv/JtKBxc0AQr1vcn0YBsf5SaLV7eHd9Bl9fjDxPF0ghMQ8LnUtnGGs2a6k998OtmvJP3eJ
	l5iBWVvXFqunEy/rmyEEHxaypYeT/Jc8pOztE5/g2
X-Gm-Gg: ASbGncu7HOtesL0DS59O58T6UxctLwms3G/EIF3zCz1fgWXPz+kC3x/FgTpUzKLhd3t
	XGN7eLAg75jPlaUf2CSuweVIwJ+O6mkmJf7WwMrVJDUBV9FuDsXbLWD+iHzDqgCO+KYRkWke2hh
	USdtfrx35R0V/CsO1vGD8hH6qh5eFQ/QTru+RjvA+h4KpuDyaKp7hahpH0ycS8s3NvYPpD08qh1
	E7W0HVU1Ney7w9tp+H8/VRtkhkN5pq8heh3LWk4dsfonOF43bKDvLH6Suh0Vz8sYatPx9PN8d9n
	osF5Cel/RJPpqe6s
X-Google-Smtp-Source: AGHT+IGYh3c4p7Lro2vb/Mmkwo7ehq0fLSmv/FWy9Te4d7O0xi13T47Zh+2e4+y9v1m45TtVgV5OLaRslqisajSlViY=
X-Received: by 2002:a05:6808:1813:b0:443:9fe6:3bbd with SMTP id
 5614622812f47-44f96061dd0mr676165b6e.8.1761913923931; Fri, 31 Oct 2025
 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031084101.701159-1-adriana@arista.com> <20251031101009.704759-1-adriana@arista.com>
 <20251031101009.704759-2-adriana@arista.com> <CAL_JsqJn+vG=FJEnBT2rMQ9Jf+JE2u_j-JpEb=mnWPuTsuz_4w@mail.gmail.com>
 <CAL_Jsq+421HUCRQB5ua9p2UBPi+sq8L0aSYpxVGgJpbpWu2MUQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+421HUCRQB5ua9p2UBPi+sq8L0aSYpxVGgJpbpWu2MUQ@mail.gmail.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Fri, 31 Oct 2025 14:31:52 +0200
X-Gm-Features: AWmQ_bkNOnWH29heQ4utX5bqmSvBneb1mSwkOXqgWEYTPI_SWMnLMKu6rap9SuQ
Message-ID: <CAERbo5x3_+RVRsxY-BZseBPzR0Kkvn7SaSSdoC6fw8a5s5RtUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: firmware: Add binding for SMBIOS
 /chosen properties
To: Rob Herring <robh@kernel.org>
Cc: ilias.apalodimas@linaro.org, ardb@kernel.org, trini@konsulko.com, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 1:43=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 31, 2025 at 6:15=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Fri, Oct 31, 2025 at 5:10=E2=80=AFAM adriana <adriana@arista.com> wr=
ote:
> > >
> > > Signed-off-by: adriana <adriana@arista.com>
> > > ---
> > >  .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++++++++++=
++
> > >  1 file changed, 25 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/firmware/linux,=
smbios3-entrypoint.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios3=
-entrypoint.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios3=
-entrypoint.yaml
> > > new file mode 100644
> > > index 000000000000..4d1521c685ff
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/linux,smbios3-entryp=
oint.yaml
> > > @@ -0,0 +1,25 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2025 Arista Networks
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/firmware/linux,smbios3-entrypoint=
.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Memory location for SMBIOS entry point
> > > +
> > > +description: |
> > > +  This property is used in the /chosen node to pass the physical add=
ress
> > > +  of SMBIOS (System Management BIOS) or DMI (Desktop Management Inte=
rface)
> > > +  tables from firmware to the kernel. This is typically used on non-=
EFI.
> > > +
> > > +maintainers:
> > > +  - Adriana Nicolae <adriana@arista.com>
> > > +  - Rob Herring <robh+dt@kernel.org>
> > > +
> > > +properties:
> > > +  linux,smbios3-entrypoint:
> > > +    $ref: /schemas/types.yaml#/definitions/uint64
> > > +    description:
> > > +      The 64-bit physical address of the SMBIOSv3 entry point struct=
ure.
> >
> > This needs to go in the chosen binding instead:
> >
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
chosen.yaml
>
> Also, drop the 'linux,' prefix as SMBIOS is not a linux invention.
Thanks! I've renamed it to "smbios3-entrypoint" and opened a separate
PR for the binding:
https://github.com/devicetree-org/dt-schema/pull/177
>
> Rob

