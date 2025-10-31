Return-Path: <linux-kernel+bounces-879751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CEAC23EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8726F4E68ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4831352A;
	Fri, 31 Oct 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6IRhU8M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6043115BD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900744; cv=none; b=hr9wgu+43JGkBIOrdUjAip3M8aSi6ZKjS2YZRw2EikeKt70bIhkaQ6Zg/8B+W5CroO+9uRPgiiduiNkcVq8tPD/Lx1PMmTzZq7QxqV0TxUQuCsJ6FG0AHgty46MEStPxkbtGzdvcSe6VwELKQS7KQnObz9szMOckKiSSeNf6H7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900744; c=relaxed/simple;
	bh=yBHEKyro5oSHQjdqIJfklMBmxOrhUsPLpF4GsNv9V7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNsMUFX8Euq3ixL8rTTm26cCztcF5G8Q/HlQg/NQJd3HA+/F4a3OcJNMNvMt69EdcEd2Y3QHbMSEOMXJTJnuwTYvMxjIiGCzp1xnW/awIFf/dmFS9BBrRJUsEXWWIwHCNBOAR49o371wU2lREYX7EjrRmFDPaYLRtiChz3zC+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6IRhU8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BEEC19422
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761900744;
	bh=yBHEKyro5oSHQjdqIJfklMBmxOrhUsPLpF4GsNv9V7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S6IRhU8MC/LkfgV7i3aYbH7v1lpZ5Eg6HVlCRO/X/FfZEpQ8irT5gfJ2gAPurLiMh
	 B6Glx3DZpIOGWo8N6UXAUUMyXVgkBGQdHntfegXDhhne0SXuklrx+O+aXfvUJPY3LP
	 ObakWbrDN69iJFsxz0WnuaQ8x5GxkiJUKxeWeUi82dVPgmTzcOtX1GE37I/RlMIyFx
	 ou/RSvHionW/323Xt5hN5CIivvLg7udoZvjzwhM0ZLNFm3qo3kokHELrIl0oDg5Qns
	 kmD+TlhRpP0+Ry/pjTQFhdX/yfys9nf+phF71U7CsM3q+C/9uQ9bICTagoa9n47FRX
	 c/l9sHZlKBJyQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso22261921fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTlnPLsF4i48G0Z/cn5NueJvv/RdIxxdAIElsn0jm5yqyY8lMxC3ploFCHFrwBopAKhBZzAdNYgE/CKhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEI4nL83vvM78c1cPng4gMXxky4Rlnt1BqqIwZbMP/cyffujOK
	ilzYYsRhkWI212xQhcezBhmm6i6LuQwYi1N4KcyKRB4nDt94U+AUWx6BeOSo2sC4RFH6uBhwCce
	K5VDmwAb/C5dIzsP+P5tFak0rUcqK1WE=
X-Google-Smtp-Source: AGHT+IF3eLXCVIf9bJ45/8tmBYViA7txp8YTYIzkWXhAp1gHzaHsoGjkLhC40CwJBYnMe5WSmoe4WPPfRYBlmdxrRL0=
X-Received: by 2002:a2e:a58a:0:b0:36c:259a:c921 with SMTP id
 38308e7fff4ca-37a18d90aaamr8187141fa.13.1761900742387; Fri, 31 Oct 2025
 01:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022114527.618908-1-adriana@arista.com> <20251031084101.701159-1-adriana@arista.com>
 <20251031084101.701159-2-adriana@arista.com>
In-Reply-To: <20251031084101.701159-2-adriana@arista.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 09:52:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG8hOMXzbbP2akJLB27hGJ_S28hcOL2c7k1uGA23hHUpA@mail.gmail.com>
X-Gm-Features: AWmQ_bmKmBrSf5cb6AuPz1Dk9hFugnQoYhQKLkzj1mga8zSR58yfxiAWzDM5eGQ
Message-ID: <CAMj1kXG8hOMXzbbP2akJLB27hGJ_S28hcOL2c7k1uGA23hHUpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: Add binding for SMBIOS
 /chosen properties
To: adriana <adriana@arista.com>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, robh@kernel.org, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 09:41, adriana <adriana@arista.com> wrote:
>
> From: Adriana Nicolae <adriana@arista.com>
>
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
>  .../bindings/firmware/linux,smbios-table.yaml | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
>
> diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
> new file mode 100644
> index 000000000000..b78d8ec6025f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Arista Networks
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/linux,smbios-table.yaml#

Should the file name reflect the property? I.e., linux,smbios3-table.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Memory location for SMBIOS table
> +
> +description: |
> +  This property is used in the /chosen node to pass the physical address
> +  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
> +  tables from firmware to the kernel. This is typically used on non-EFI
> +  platforms like ARM/ARM64.
> +

'like ARM/ARM64' is both unnecessary and inaccurate, so better to drop it.

> +maintainers:
> +  - Adriana Nicolae <adriana@arista.com>
> +  - Rob Herring <robh+dt@kernel.org>
> +
> +properties:
> +  linux,smbios3-table:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description:
> +      The 64-bit physical address of the SMBIOSv3 entry point structure.
> +
> +additionalProperties: true
> --
> 2.51.0
>

