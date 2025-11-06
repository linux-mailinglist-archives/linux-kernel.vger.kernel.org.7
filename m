Return-Path: <linux-kernel+bounces-888647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B03C3B82F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EF67508745
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49B274650;
	Thu,  6 Nov 2025 13:49:37 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E937494
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436976; cv=none; b=qrqp7wNbu2SJYFI8H9BcBy655AveAC0Vlthbz0Hsy1klEoXqNJUnxhOk18ntnJZPIWfVRWSEpBR5OY3QjI8/JiT+ESJUZiT5Ju/WoG0mtASoj2QDaCBMpIPX3rn2847YqR4eTjy39PFisV34aNOb7/upr1oWnBV02xHrwx691bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436976; c=relaxed/simple;
	bh=I3VUE6vhtWsWrhjiq89donvlpgI2hn86BAEVlUadz4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgFawvlxTxaEu+C3E8QxGG6C7QgKh2Ul+w3WMZWuKRXZTyWjRpijMUIMrQMhEUDlMK/n6Ai7RYnYnBaXRJlvFIYIZ1GALiUObV6ze6O1oefkDdTiAWEtILjH42Sn/hpQxBgwX0X2OSMpow94lmJYojCS1j3TQZAwqU9cvjsBsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295247a814bso13693495ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436974; x=1763041774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zvXQzHMZF+ClpmnJuOqJcZtH05R/CK4p6fsF3c0XaE=;
        b=sauTKrih5T4TYDqWpS+YGuC+2+LNACoozishKbwCppPMdQ2hXoit9LxPuwQXzPAYe7
         G+JONiQQIVPBJkjvEAz/SOEFO3Xk5TER3Lneuus6n6wb/fRtwFaUYU5ZsPFGfNd7DT/g
         7WMZle+u8CkQ3aE6XPk4uaPGTdA6K9kg00mw1hnzck09QawDz6vkmOXUx8oALg4oRMr+
         exovq/muHD/k/pCOcOOVRyEGvXAIgdCy63IV+eoZFRY9asTyxO7Rh0gF19YRhw2lQz3L
         l2uop+TwzLYaG89zXbF5f+aTuJj3Eem8weqJ4d7E4d4v7sE0dLOUYHTB3gz+4dQplTbV
         qtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxAXSKVDpR8dcebHMMbJeh29fZMBi21KxLazZTwHVcWemXGGTZF4620h8t7qlo+D/XhKuG1BLvWEbcyRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJPJr6OT0oHCxNMBZrbq2croPE8kO9KROi0UYewUQbRC/OQZ4
	0vLdYrChZjPysCgwuslYw/ftHxXEiF62bOU8QsKoHCoZQLzxeOAI9Z9ld34V1uhD
X-Gm-Gg: ASbGnctDgTXzFwaj4ekVtZ3MZq2xDFSXHrFFO/zhe7jqcvwf8ACJLjj5idYviGvRZpJ
	hLDGFOMnNlRAnxr7v0g5jnIxzp6vkudltLuHGHVjhPPZN0y28F1zNZzmfXVXMY5QIxLQ/qx8l4T
	F6dqeCehUxYKZh/AUajDk/N/vL13Ensf8ZdoCBiz/eWujcelDTO4+AKMXpuD9m7IygbYwDAW9Vr
	HpjAEfOUH0+zvCTNCB/oj9I5DZlmeI5sZfKEgoNL29c3tzg+MceeJYkgossuDconeNZWY/EVPXa
	xka25rb3NY+BS/ZDYwyEdamFz7VefdaSM3W8MsuiSVuSkF+IM7jME2IbcVwF0Pa37Wg9LyCqFRD
	61+5m9qH2po7/mLJa1/QIJYoANZdQ43zxFas48EoJF1mMo8yEzTWk2CcGrjDsW9sGV46oA4ad8n
	FvY3C4XU25okmaE1wl/7JEHjWZlZz07kaEeIBBnYMAPWnO62iLGb47kxh8TjZmhuM=
X-Google-Smtp-Source: AGHT+IHThlwdvHb/5M+OzAw9dOUR4ndm8dxVXEfYS3dZxrqP08b+HHpqxeoL20nedaqyq+Gq7U5gBA==
X-Received: by 2002:a17:903:2f0d:b0:295:5da6:600c with SMTP id d9443c01a7336-2962ad82c96mr110387555ad.2.1762436973822;
        Thu, 06 Nov 2025 05:49:33 -0800 (PST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f20dsm29254435ad.65.2025.11.06.05.49.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 05:49:33 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-294fb21b068so12213935ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:49:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXagXk2nghoWqH8Xw8o8iAMgUH24DBdVYIK/3r5Q7YrvL/5F8q9zryrVt8m0II5a5J6Ts0Pu8PwoH4xvIU=@vger.kernel.org
X-Received: by 2002:a05:6102:1620:b0:537:f1db:7695 with SMTP id
 ada2fe7eead31-5dd891f5d34mr2214888137.26.1762436493734; Thu, 06 Nov 2025
 05:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-add_l3_routing-v1-0-dcbb8368ca54@renesas.com> <20251106-add_l3_routing-v1-3-dcbb8368ca54@renesas.com>
In-Reply-To: <20251106-add_l3_routing-v1-3-dcbb8368ca54@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 14:41:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYzpJ8iqyPqbR7Bd=qpqDyV=GJ+Vw5fZ2G2S27gYO4+w@mail.gmail.com>
X-Gm-Features: AWmQ_bk8o_RbFEO18v2EcWGSAt2mahWgELrgaPK-1AkGfKDcrGdbiBTIxT5Zu7E
Message-ID: <CAMuHMdVYzpJ8iqyPqbR7Bd=qpqDyV=GJ+Vw5fZ2G2S27gYO4+w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] dt-bindings: net: renesas,r8a779f0-ether-switch.yaml:
 add optional property link-pin
To: Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Thu, 6 Nov 2025 at 13:56, Michael Dege <michael.dege@renesas.com> wrote:
> Add optional ether-port property link-pin <empty>
>
> Signed-off-by: Michael Dege <michael.dege@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
> @@ -126,6 +126,9 @@ properties:
>            - phys
>            - mdio
>
> +       optional:

Doesn't look like valid syntax to me...

$ make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:
ignoring, error parsing file
  CHKDT   /scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:129:1:
found a tab character that violates indentation
  LINT    /scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:129:1:
[error] syntax error: found character '\t' that cannot start any token
(syntax)
  DTEX    Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.example.dts
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:129:1:
found a tab character that violates indentation

> +         - link-pin

What does this mean?
Description?

> +
>  required:
>    - compatible
>    - reg
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

