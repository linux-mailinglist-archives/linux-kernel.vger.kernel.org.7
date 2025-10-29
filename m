Return-Path: <linux-kernel+bounces-876451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF20C1B9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FF315C7191
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD1533B6EE;
	Wed, 29 Oct 2025 14:53:19 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E633CEA3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749598; cv=none; b=eehwswVjRCcCw9MQCfyFWxRftKf7fjipz+yYU3fyG/CzHpabM6iTE406p9QlhHfz59t05aZNQ7cFEratlSXKKaRZDRnmQNBTJQSwnGt0zDJy4JZ0STtVYKocyptItAF8xNUV/5psZ1dfmjK/ZXK0UmH00bL6r6lZc26ZKAF6W48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749598; c=relaxed/simple;
	bh=Bn3qdBMVV94+OQl3u4N/QcPiKWcf2tpN8VQjFewuPHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md95vJUzClX56x8Hy1lLs+ptqbik7TZk6xZG8h97FzsPuCtDFZ379H9QAF3RJw5+nMwE+cSd5P5GH8C/fOOAjUhQxnsCpgsWuw5OsGG8J1jt8T+9qP15XMxWvXkjuYPK0tXGbZrHElCeG8hZHyLJlu3EhWIkl/ui406UakApX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so3781638e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749595; x=1762354395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq7cfrs8fVaBcc2FW3QUnIn+7UcMac5CdGnA5tYXOqc=;
        b=vizeNnTZNTAspkpMDBxEAlA0ZRA1awLRIAhmvI1WeZxJKDcH48aEZ3doDVC2tofgaP
         yy2yx7JkAO5r1xpKqG5qjun/y5+RfPqJqaGldjUEUg95FaOM/M4vBbhPcmnMZjF5JKwc
         Vmz1Iaidiawzc6WgbKqStp5PHmAiTOgq0idjqyXZE8d2e8a5p7AeRYgGDaySRlcDXDNz
         lVsDINJC1b9kzCS+ctuYcQKwfhneD9Sy9xLjxSvTIXUitJ3Li4lvlKwY1OzBf09uiuW2
         LABrteD8oPF49Ko2wMCPsPo9Y1hA5PIMZA83N3ivfF6WHjoBSYgG8LlR9kv/GMLnF3eo
         pgYg==
X-Forwarded-Encrypted: i=1; AJvYcCX2ze0p/Rxk83pN60h9cDWMnCrkWmquoEymB4GKN4oeoGp9PWsrjmGdLE0CYylBYf6ObFLbYb+cYhUs10Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9elXvLEbFQ6C4+JIZS8NBkIPsUHztqtKqx8kA/TRvCmAWoxkH
	vfhL0ftLVc5CY0e3VncQ12NWbq0I5ykMA1YwYJqA3yNSWku+Krz6+6lR0lFsub4d
X-Gm-Gg: ASbGncsXyWDcghrmkEEH7axsbAUY2MAQMMnUCZdgJykAkbRedwfFYn5lNDaiHifV5nM
	nIA6VL05eHgxiqMQJovFVDqImkkxeRxrPIGDQ5CxzzJE+ZpIkUX2d20QdVx5nXR7Yb7ZOKOikIS
	8Cb/d5cGtJzQWkUa0ETwqOUkDJOwAgFSdT/EfPPy+YOv04u2kgQEGnC/5ARfAwGAH532D78SIRT
	EuzBHwWv7qOT9w45ShC4QYF9anUKa0FX8j35B74Zf/vUDKa2/dwq1BpYhLzhRX1eAqtAFBWVlld
	IeotbcsxSClU9QAAkW8IGxJGd3kPNzJ/mBHxwbXsA0Mf2IzHtheURgmkxNwOw5rNH5jO0d5pEL8
	C/iePXJ6DdVwQRMwnlr/Qy4MWa8RsegoUbzE8Nij293/YYJl73gcIBfX2Md7bFY1SxmujENAGBE
	f1i7GCLsqE4h/os6D3d/0Pj2bBJB/hLqiNTAqjiK8g4w==
X-Google-Smtp-Source: AGHT+IG67IcJT2UI7Fhpx3RDzzZ5yNhorEGbs95+P11U9uUiVwDItVlwaKOCSSuMIc1hVM09P7Ke0A==
X-Received: by 2002:a05:6122:1d89:b0:557:c743:e14c with SMTP id 71dfb90a1353d-55814235716mr1039407e0c.11.1761749594391;
        Wed, 29 Oct 2025 07:53:14 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb09e9dsm5487734e0c.7.2025.10.29.07.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:53:14 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5db308cddf0so7598285137.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWASAErUpzpUVuV0NzMu9FoaoV3my+yCVH7W9D3T37r++8hdVT0aZhvEFbOGGVcqfxQgvRVXds7u5pokp0=@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d6:221c:3dab with SMTP id
 ada2fe7eead31-5db9068d4abmr1045322137.39.1761749594055; Wed, 29 Oct 2025
 07:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org> <20251027211249.95826-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027211249.95826-4-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:53:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+vkj4KEyxmvSSi=Zw5KSXqJK=-7ZEYm4q_odn0sYv3Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkbcCJ5bca1fjv3psAbJaIosav5q9yqJotFzCTEHDUGlkGiEkRijKAzyWQ
Message-ID: <CAMuHMdU+vkj4KEyxmvSSi=Zw5KSXqJK=-7ZEYm4q_odn0sYv3Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r8a77961-ulcb: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 22:13, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on M3ULCB with R-Car M3-W+.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

