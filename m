Return-Path: <linux-kernel+bounces-875631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC8C19721
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4292F19C216C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833332E54D7;
	Wed, 29 Oct 2025 09:45:13 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813228507B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731113; cv=none; b=S38lzOavvSHNTuRJN3PFvfiFRtXinJ/khf17l2xuraj67q6Cy27dM1lJvWqtzaqSnQj0Wbr47O0heITmRIojJDGVDZqhAUoGt5BuBaehz42ywrAasOq7kTLd/imcD/OasXZ8h4c2B/DXN2UK44FIEKOaknRkNqOxThge/aSI02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731113; c=relaxed/simple;
	bh=ul7h+XS6GRSBMYFmPhQ6YeIMEuayPqL/cWHKXtbASjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obBOn+JxqrJblrPKwKrJ8huL3tof/0/htPTuaDzeaN1MsvkujMdvIzsMrWYaIJn8kP0FKCnh3HnZR0nTPFuXNTHppWeYhAByI5vD/hUxXks/yAPwTn1wLZg9YrFOU3ESUbJBJDHWlr9K3SZySuYDqUaB2Y+9LTjGP1y0a9K7ODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-932c411d355so3231380241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731110; x=1762335910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUXGCcljy1WS6CKdaLlHjT9lGZyhiLJv69Z5NYW430U=;
        b=lSd7/Z3CYEErR98bHVQkN9cOeACEh1VdNilxSdnqk7VFiNvvDOQnroYV1GUGRQAb5Y
         WfRiCb7sA37HQD4P16mzq/WZpW2XgwW3xFIIKjFtTa5sFILQYYnPtZPlgi8VuMqzLqpw
         OW9wGNqP7WO1fwNc7dSKX6he61ZrLBLrcHDQuOTSsGfoA8FIbmqp5sKLyUEfqLHb0IOL
         mUqgj7GyCbqaa6eStobYLkV0G7FrdUqaqYmeRIGDyS9NKwu+2GvLvJfjeztiyvj5iyYh
         d5VQN/TD2mo3veTG+JJkDAAmSjlx94qnGm/puPaz8OB6eo9dH9GrrHDQ2ZJE9lfmpeP2
         GJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYuYEtexpuah6zQTBgEnvIAYnKWQb9U8kz3S4fnswnR/+ydMqca5Gk1xN3PZO0A9FMWF14WQmoNZhuIvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69+OK1kYVpiTNkaFZ4rJZG3Dh98n0X8v/c3F/9mRu477UQ6Kp
	76X2NXlKJxbpMp3nh8zCVdeE6XvRBbFOybHQP4nB3Ywg1iN8uXHxoFWp7htb3rNc
X-Gm-Gg: ASbGncsugr8YDLTJdCPjV8gGqhT860D7lYJKuLnV08qqWWyYtNrhmZ1aR62dGB8i1s8
	7xVDt8QZMLdmIa9rit/LczNa6FJW9QHFcAdaYP0GZ1ropYpx1pmPqTzdsOwQGi1YnZFfxER4OE3
	7e2x9S/U9hO/eUK4vLyhla1qTgn5pJIli4xl9+LcG1mxYgOy0BaSq0yGucfAs3vpg1CUK9N7vSS
	xwV6G4cBJQozYtFm7Z1GLCYaXkBIDCrvxdC7Yj600qM0ZMxiN9AbIGih0bCeeEPAbXcrUPwnPLI
	8rDJ3jT1clwq5LDumQk89fNGy2/8rRqhU56VszmX9O98tu8PpkfnSKWtwF954imATh5U1UWF4Cj
	xN1UpkV9qSWZzPzyF+ZnTee2grPxvPaLCi9brpvW5MneGAjgTWLf0El7wQAc4sFbk6F5xoTjwfb
	x/8aA84mU6tTYfLOFKCMjlx/VvE7d3kGLgjBqD1w==
X-Google-Smtp-Source: AGHT+IGpYpfpzcs2itFEahqpjC0xTlTgyy/u37/lhNA5kTR7Zth1UwPbwt7uAPXfop+VNqA69PoSHA==
X-Received: by 2002:a05:6102:3e84:b0:5d5:f49b:fcd8 with SMTP id ada2fe7eead31-5db905c7918mr530470137.13.1761731110137;
        Wed, 29 Oct 2025 02:45:10 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e592e61sm4856736137.13.2025.10.29.02.45.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:45:09 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-932c3aa32f3so3528870241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:45:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc7AuKUTSEjXFl2j2IeX5rBeFxfc0eOqCsmcWqkRhv8h8ZGkMN2cvtvZCWXjPN9G08Phl8DckHeJNBRKE=@vger.kernel.org
X-Received: by 2002:a05:6102:2910:b0:5db:3111:9330 with SMTP id
 ada2fe7eead31-5db9066385fmr535126137.27.1761731109576; Wed, 29 Oct 2025
 02:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com> <20251029082101.92156-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251029082101.92156-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 10:44:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaxk5mEDFJ3uWwdZYqkhd_jCRjVB55MJmHRZxyWGE=Pw@mail.gmail.com>
X-Gm-Features: AWmQ_bkf4dSdvLrN2gk-FVgCqZ8SF2_j8HOolSnL2gtCu3wVMEe_dcdoAdns_ts
Message-ID: <CAMuHMdXaxk5mEDFJ3uWwdZYqkhd_jCRjVB55MJmHRZxyWGE=Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 09:21, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Drop "uart-has-rtscts: false" from binding as the IP supports hardware
> flow control on all SoCs.
>
> Cc: stable@kernel.org
> Fixes: 25422e8f46c1 ("dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated commit message to make it clear that hardware flow control
>    supported on all SoC
>  * Added Ack from Conor
>  * Added fixes tag

Yeah, this was introduced when renesas,rsci.yaml was split off
incorrectly from renesas,sci.yaml in v7.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

