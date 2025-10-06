Return-Path: <linux-kernel+bounces-842645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79790BBD396
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585E34E88FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A90257820;
	Mon,  6 Oct 2025 07:35:20 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D41DE4C2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736120; cv=none; b=PVHcs4klzKcpyXLYU7CVJXGzgaqj9nechSi7v41I9BIiP3agIcAvs7ZUftfU5RtShzV4nmIXwwz6mVGSPpbboS5oxjcbM5tjLrYyqhHn/LW1VX+gSHDwV/eIEeV2c1vUZqIIozhMYn6QdLv/FKDSALUTov2REQUK0F1pErZwxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736120; c=relaxed/simple;
	bh=Seg/zBB5psfsVpNwNUkdV6jEHpzqviCUZwoGlYe5ov8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtFFnV0+rpDKKPILarRXjQXGLrKMPzUvqfWH0zsqQDxKsyPhXw/QTdw77YQcwPsF4J28bSKN+d2ofb/7hF6ch8KsUz7w3Pp5BaTSX2oBzK6IAJKDXfPwPBSLFR3j7vE6bAO9OBnchcJh2FbYyVwW1q5AaINd5fOclpGOD02Wkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so1600023e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736117; x=1760340917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi/dIonYfUmmwW2Vuh6lMeec+QtJMKdHIzm0Sdbs67c=;
        b=pn5HGgU2k6VeJxWZM/mGw6J1nPJ1Mc4Pjvn+fqZglHoVBHI2Ni01ofIrh1bUQ/yydC
         aYEbaSdBRfWN8mMW0ZUuzWIVqlZtcXZ2Yi7nu8p8BLkeMWtJ9W5ZfEeUHJFbtq+8LAkD
         bKIHvsFH73nfFE1EF8zXjSf7H+eUtGT3vryc1xp5+9BvoctulKYi/t1T9IslgEvTihEt
         QUkdBQSNVYRDtGlQHCM3WopSlt9K9LvGzlc7YBPtjqvNGA+Vaso3SzNbdIFD0mam2gBH
         ljtiNTkusffrghI2ZKxUSFcIg5/J4JOw1WN+JN+X/92p8q/KELdu8iHAhkvdwmNDS2hs
         3Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCWyLDeY4+OqGbhmI/qjzpMm4vlLEDHtEW7zyOBuwOFgQb5TihQHZi0XyfupYrzrF6gnrR+wdxA3SyWswyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrgFF/LsmNUEPcDLHsWOZ1QXfG591+f9bblvQX0Rn9PQslkj8
	AK5Tlni8VGi+9lCEPF386ToO2wjLByDwmBaoHphSAcnqKtFTOaqgfGm4StUb6+2S
X-Gm-Gg: ASbGnctaQUJum6D2b2yg4v7+94uFc2U07HDYn8Z2VVi3wjOvSXUiEK8Jo6+DIC0Lmm0
	+EZ4oq7Ckv3pljqGwuqwsJAIiEeY7W/MVkoAqcIi7BQElCfjy0SLG4i5/NHNqqhptsRK4CUareX
	ARMvJlyOTlPgtyQkMzgo2iyuQcHiiihjFdrwEvIxMkpydRyfzw3q77FOy1cw7e3nz2wLHvckGMl
	nCy6yy7nfS7zS4dLvc7xriRWC3ziEQbfyQHSBq3cbvjSifKRaTMVeitkfuHLkxoHtSTcmn0wBIi
	lgtmJKG6+rtodZWScNQtlEbwdu1PF1bmg2zvHaS4PcR7V9VGixPTucy3x/VG7RhmPFCpTct3gV5
	zfTaJ/q5v1fPC2qHCfFHLxMktCFjbO/DaXU4MbV3RgBWgv65g7pgaOE1ozAXFzRi4czt/JWmszx
	2UksdY5TMV
X-Google-Smtp-Source: AGHT+IGT22HJo/eFHzRB2KxZJXzzbLBvPVw8h+TMajKOX8qceV4ldzr0EEvEvGrzvdQdpxFWen+UaQ==
X-Received: by 2002:a05:6122:134b:b0:54a:a782:47c5 with SMTP id 71dfb90a1353d-5524eae7490mr3786156e0c.15.1759736116890;
        Mon, 06 Oct 2025 00:35:16 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554a3b98ca8sm43753e0c.18.2025.10.06.00.35.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:35:16 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5c72dce3201so1904678137.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:35:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrXapdn9F6zcaUSS9TJOmAA0UtDzsixNooJUtQKYc4wzuNw4x9t3tnXJu6ZeKklTdo5zi/ZmYk7AAJEb4=@vger.kernel.org
X-Received: by 2002:a05:6102:3e2a:b0:528:d2ad:1f54 with SMTP id
 ada2fe7eead31-5d41d0491aemr3884804137.8.1759736116168; Mon, 06 Oct 2025
 00:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759485668.git.geert+renesas@glider.be> <98e13934d06116d5c116bd2b2187842ec3a8c11a.1759485668.git.geert+renesas@glider.be>
 <CAL_JsqJACXgfgLBn4bpz9uG2zEsoH+FX+8wHmTSj2rLVV59=hg@mail.gmail.com>
In-Reply-To: <CAL_JsqJACXgfgLBn4bpz9uG2zEsoH+FX+8wHmTSj2rLVV59=hg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 09:35:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBGzLmpNeYtSe7SW64X7EQ8chUxrjKQpfhBdz0tHTRdA@mail.gmail.com>
X-Gm-Features: AS18NWCQxcI8Hk_xi-9INpQRnbcE9GVTQoTyTKCepWEClduajoLppt0iBQuvTmQ
Message-ID: <CAMuHMdWBGzLmpNeYtSe7SW64X7EQ8chUxrjKQpfhBdz0tHTRdA@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/2] of/irq: Ignore interrupt parent for nodes without interrupts
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, 3 Oct 2025 at 15:33, Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 3, 2025 at 5:08=E2=80=AFAM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The Devicetree Specification states:
> >
> >     The root of the interrupt tree is determined when traversal of the
> >     interrupt tree reaches an interrupt controller node without an
> >     interrupts property and thus no explicit interrupt parent.
> >
> > However, of_irq_init() gratuitously assumes that a node without
> > interrupts has an actual interrupt parent if it finds an
> > interrupt-parent property higher up in the device tree.  Hence when suc=
h
> > a property is present (e.g. in the root node), the root interrupt
> > controller may not be detected as such, causing a panic:
> >
> >     OF: of_irq_init: children remain, but no parents
> >     Kernel panic - not syncing: No interrupt controller found.
> >
> > Commit e91033621d56e055 ("of/irq: Use interrupts-extended to find
> > parent") already fixed a first part, by checking for the presence of an
> > interrupts-extended property.  Fix the second part by only calling
> > of_irq_find_parent() when an interrupts property is present.
>
> Seems reasonable. Why the RFC tag?

Perhaps you might object to putting interrupt-parent in the root node
if it does not point to the root interrupt controller, or if it does
not help to simplify interrupts-extended to interrupts (like e.g. for
ARM arch timer)?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

