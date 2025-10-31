Return-Path: <linux-kernel+bounces-880046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98361C24BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04A34350B95
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99F34403D;
	Fri, 31 Oct 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFIeE/g3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C731D377
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909378; cv=none; b=UXcTXo8kAMiLn3fLJu0vDdi0mluCRGkWjySwRt38MTXzsU6H8DHFsX4lzUi8MQD0X82gjrjSkL4jgTLvOdVm3csr+DzfmCIj/2CRWlN47Y54pIuy1MdyPCa25Mc6SQSmko6OptqJ1VTM0V//zjo79Xl/iHdmRKmRzE90gtEHghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909378; c=relaxed/simple;
	bh=MN2xaDVwCUdlanpNizsByKz0+be9U+2kboQP6A6ka+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD2IB4mNaRti1zi2G1NDnzLg5igWi3f6lMhTLvyFvVyUO2gnzrOi5oqvk6gxnU05OtoojlaKgmYaiB2Ruv7hZIzKDnnD0w7R9kdzhCbYSloRtgqa+1Q51MFvhfsaOeI8251xlU2HjQz+5lkWqZkj1v4A20sVMysSnVxqFm+i+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFIeE/g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E57FC2BC9E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761909378;
	bh=MN2xaDVwCUdlanpNizsByKz0+be9U+2kboQP6A6ka+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PFIeE/g3Xz3yEobHpJCFwU7z+FC5bcfhAzW88pUAHVRd90Ga8Z++6zBv5gL9XFiRx
	 YQvG8wuTB9oJJStvqTmj/U9funN9hqtZ1BUapoQeHOLNsf3QgNlVhsnOTHrkT6Vw5B
	 5HkHVsh89sqc5cGKkhBUDPHrCrJuQd3lIZoN2p67d0p/Ss+gLOd4gf0jSJH9kd1FvZ
	 6RdJpa6jGWGgrRfANpGazb5v57i9PV5tp4hN1SeuavHjVve9Bo5KW50NRsaTjStjfn
	 MRGclCdEwtoclnMEEYCAXdXwd4rbgNAmOkhJ8tvNhnpIbF5VWqFcpjMx4xSNSEVYCz
	 D1gVo2rQgridA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso4488769a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:16:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr6pl6OwDEKNimQRrfN7OdE4dZDHhRGK8bD6XC3Q3uVL8FW8kh2MKJAlsngKsyyX3ffWzB7cReYX0qEHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnkUJmj7/PWCx6otMuxVnVul8RBnN4lcYkiQG9TjrbidIgulM
	q8QU/YPloRx0lo81dBACUY7ZR6Gn0woTlPSTYrWa4lQ74HPbyvLvAWlRjXuTEdO1JPcTBxG0xI+
	uM79rR5JWl5d/Avy/rm5PA9xsrCMP1w==
X-Google-Smtp-Source: AGHT+IFy0NbXlcnXpyCvGbtSasVfYk1W9RDOglxfcqh8P6vYA81B6Yle+fdZVj41g52eOJdNAj3qOy2YCWw8vpUheb0=
X-Received: by 2002:a05:6402:518b:b0:639:dd3f:f265 with SMTP id
 4fb4d7f45d1cf-640771ceb67mr2656760a12.25.1761909376763; Fri, 31 Oct 2025
 04:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031084101.701159-1-adriana@arista.com> <20251031101009.704759-1-adriana@arista.com>
 <20251031101009.704759-2-adriana@arista.com>
In-Reply-To: <20251031101009.704759-2-adriana@arista.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 31 Oct 2025 06:15:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJn+vG=FJEnBT2rMQ9Jf+JE2u_j-JpEb=mnWPuTsuz_4w@mail.gmail.com>
X-Gm-Features: AWmQ_bk1oTvQggG1qKqU7kkYKnnYBwVScBkS83XY6BPVibiHe_igBZftju1dB8c
Message-ID: <CAL_JsqJn+vG=FJEnBT2rMQ9Jf+JE2u_j-JpEb=mnWPuTsuz_4w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: firmware: Add binding for SMBIOS
 /chosen properties
To: adriana <adriana@arista.com>
Cc: ilias.apalodimas@linaro.org, ardb@kernel.org, trini@konsulko.com, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:10=E2=80=AFAM adriana <adriana@arista.com> wrote:
>
> Signed-off-by: adriana <adriana@arista.com>
> ---
>  .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbi=
os3-entrypoint.yaml
>
> diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios3-ent=
rypoint.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios3-ent=
rypoint.yaml
> new file mode 100644
> index 000000000000..4d1521c685ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint=
.yaml
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Arista Networks
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/linux,smbios3-entrypoint.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Memory location for SMBIOS entry point
> +
> +description: |
> +  This property is used in the /chosen node to pass the physical address
> +  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interfac=
e)
> +  tables from firmware to the kernel. This is typically used on non-EFI.
> +
> +maintainers:
> +  - Adriana Nicolae <adriana@arista.com>
> +  - Rob Herring <robh+dt@kernel.org>
> +
> +properties:
> +  linux,smbios3-entrypoint:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description:
> +      The 64-bit physical address of the SMBIOSv3 entry point structure.

This needs to go in the chosen binding instead:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chos=
en.yaml

