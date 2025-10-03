Return-Path: <linux-kernel+bounces-841318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C054BB705A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7783C0558
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB7B1DC994;
	Fri,  3 Oct 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgTfYbBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2A1C6B4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498390; cv=none; b=BD2PV0OLXWXY0rli7wH/N5MPliS0Ajxx/xFJZpuD7V04vIoTNyC7Z3nzTFvtPSTju43WG/9w+PG6viUrZepWiF9rYMs8x9S6OvZejAUzILUDgdZfxx3t8Z0BROfbbGdmnyGB1CnVB0j9WogvgljFzt+wBEzpUW+TKmEhhhc3hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498390; c=relaxed/simple;
	bh=C0IfBPyV7UBF2PDQ6o0zMb4JYo7b3LeT2lZxvzwA1zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIq7tFACFGc8zKyQHK0c94+FM87rBJkQqdU7lesrdumy8Il/BP75KfvxJzFvs4nEkCeNAu4XcUMUJYqS0fx+7ElMt5IC3KMBcKMF/UZ7LR812Ti0K/6PQACW7RAba8vDNeI2YXHmNnkoujb0YFrdgaJJrGBSBXEaZGelvVtEtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgTfYbBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509E5C113D0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759498390;
	bh=C0IfBPyV7UBF2PDQ6o0zMb4JYo7b3LeT2lZxvzwA1zo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hgTfYbBj1Bf8IDVz126EWVCUWqOjd7ddVb6RNVV6y/wXj98nXkZlaTK970C+QRa5D
	 aAsD17JkeksYxzGVhfK9RR6lJXqWU9AN2LXnU3eLYryX4pzKoU2QTTi5qDYjrcSe30
	 ykOGkdZnP5JnoZAw/g2wMFIl1JfHgakD3d73aP0dgfLv5On1Erpq1CI8bwCH7T65ST
	 Mdl9kZyQuBXz1kBs7mZ2QmjxRHUJs7N9DS445xMBCQrRZ/gXekLCKjoW5053LCU6oE
	 dIwOk1NB72snQee0rSpRpBAt7FFJceP85+7R7Ize9rJISNfLYSiNi9H8mEn8n8Siq1
	 OlCnotycrfmNA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b48d8deafaeso423568666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:33:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHYuyUF4jhw2oDhq/cc2AI1s+PQWbyoyI1ukxX3XQFAiu8T2OjG4Mf31p9Lw6BUG0zPeOd5zsToZ2Z2nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmj9esF1luFdpUr0nA+Hnje+1WAjOHk+B7n6by572Kl/FsYZZE
	CS1DB8SgpGNV/A0CUqDbmATuzwDttgpNZXkOBP620yPwOCEYpag6DLznFx1cm7hf8VstygelDN9
	Z3Vy6Av/T/FyBNMz8fH9w4k1iH79W8Q==
X-Google-Smtp-Source: AGHT+IGaUVVXIqhC9lovJbOg6iFmKgFvDhzHqwsGL+BfWqtS/NinqS+uML7tkmyQ2x8FtOpCPjCiO9PBD+v4XaQbRRE=
X-Received: by 2002:a17:906:c146:b0:b04:5e64:d7cd with SMTP id
 a640c23a62f3a-b49c4cde217mr381764366b.46.1759498388819; Fri, 03 Oct 2025
 06:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759485668.git.geert+renesas@glider.be> <98e13934d06116d5c116bd2b2187842ec3a8c11a.1759485668.git.geert+renesas@glider.be>
In-Reply-To: <98e13934d06116d5c116bd2b2187842ec3a8c11a.1759485668.git.geert+renesas@glider.be>
From: Rob Herring <robh@kernel.org>
Date: Fri, 3 Oct 2025 08:32:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJACXgfgLBn4bpz9uG2zEsoH+FX+8wHmTSj2rLVV59=hg@mail.gmail.com>
X-Gm-Features: AS18NWCJ1lihSi5v5QI8_-KXwh5QzGMdW1l0dkB9L36RcYjtaMnOS5EVXEekAWI
Message-ID: <CAL_JsqJACXgfgLBn4bpz9uG2zEsoH+FX+8wHmTSj2rLVV59=hg@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/2] of/irq: Ignore interrupt parent for nodes without interrupts
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 5:08=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Devicetree Specification states:
>
>     The root of the interrupt tree is determined when traversal of the
>     interrupt tree reaches an interrupt controller node without an
>     interrupts property and thus no explicit interrupt parent.
>
> However, of_irq_init() gratuitously assumes that a node without
> interrupts has an actual interrupt parent if it finds an
> interrupt-parent property higher up in the device tree.  Hence when such
> a property is present (e.g. in the root node), the root interrupt
> controller may not be detected as such, causing a panic:
>
>     OF: of_irq_init: children remain, but no parents
>     Kernel panic - not syncing: No interrupt controller found.
>
> Commit e91033621d56e055 ("of/irq: Use interrupts-extended to find
> parent") already fixed a first part, by checking for the presence of an
> interrupts-extended property.  Fix the second part by only calling
> of_irq_find_parent() when an interrupts property is present.

Seems reasonable. Why the RFC tag?

Normally I'd worry about some ancient PPC or Sparc system, but they
don't use of_irq_init().

Rob

