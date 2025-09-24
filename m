Return-Path: <linux-kernel+bounces-830489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB097B99D03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D0E4A8425
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077C302150;
	Wed, 24 Sep 2025 12:22:32 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467973019AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716551; cv=none; b=kkRuvvqWgU4FtOq7Sm3WHvAqvo9zB3tOWOaFowe9CJ7/PcPZ+PkXHLihQ/+/eqLCnTpX1jBhnwbuO0S/xl2TTQqG+/5G8P+9qKsvfUufh9WXlQCgVXDZQa0vSJXv59/FiuTdz4mPZDcI6HoV2ZJ4jwRBHbV7FioXNe9idjTyyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716551; c=relaxed/simple;
	bh=J+bHTCrNvT6JUuzJJC8KJ5RBgdPM1Xs3UX01bYjGbnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcOCwpw6eBOy6AJNtUGstAxSYLEzvfPb20Ymeo/HBOY1FchJteakNb5O3pWm29B1hZ+CVhJ0Ja/UYeLmqQueKe88f7/9ucGUOj/2o0Xi1aRmRyTsAEW4ZSBgCrCewXvGaKEPt1WOvL/9x8PbiFxRhGy5RTWYMBF+0g/LPqfx82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-50f8bf5c518so4861242137.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716548; x=1759321348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXklmRbRcjEr8jgTuTVa6QuOaAAvv4IbKTLeIHUSW68=;
        b=FLXKr61fMqb8WFsT1Ix3oOZqJLTcqTqBBsaQ982pES74ztSYKgei7/7LYIIvz7SbsL
         YxYnUQdAL7a4c8RODbhSZlO1QvwFJJoeKsvmjPHP8W1Tx794oVs2B0nmMPEao7IuHeR3
         HVJZhBOn5UgfxIInz7TqUgmiEP1YC0bzZJHgt4sfzVGXdeahRREX7vV8EHty1v2HHlNN
         JCnP40TsIkLWYERJlSZYayM6LmJaoPbKSB+5ltTDqlnklPHUCbrpLD4Rh/u8XOU3BGwV
         CqYDMKkAE4sI110HNAgFV1I1Lf5mpaET0jbw3V0HvzCKKP2/7108YSeNcl9A5CW0foK1
         08EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnWzSN6LeHv5P9Sit079JiJ1HrHyMqf6Qmljq8zPpwxKKyfdSz9puiz6tElrHXf+MNNm5SEwsPIrkmk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04g18Yr0zpUV2ADpXE/zu04M+Bd9W02MJeLf9QwLZPkb+oYwG
	0zTHqDcZQrSKQmv+XFXj9RAp0BZZCG/0wAaMfYUmwg6mz78o9OOH8O3EA7JM1zPv
X-Gm-Gg: ASbGnct5ujbwx6ry0N9nmwFcF+NtgJYu6OBRAJ4pLY0h4Pe3MX589Iy2dfr9YQZ6Tuf
	/fY/k7a47f4m8mY4KuV/vPTE0yH2tejs3UuWm74RoXHUwUzQf4rlrrTGRw8keei6wCpBb7/S7Aj
	TTvzan8L+8ns01N1hgTOGpcen0+xXjG7UzOmxZGl0J0py1OBrmWUZgsDQ+/tu1lqxTmEOcCTnCR
	gdFSSm8QmlkVftHZLA90n/Dg7AoCHgSp1ZxMvhbpjj1/xRwG8jdUpdBDxRZQvlVPSa8F35OCzG+
	451s2vVo5scdaYp2MseJQixZ6nMTBH2BSSiEmsDn9HLNJqmUKU1ptlK+bMKSJW8N5r0AEjsLhA4
	VgOo9utiHIhZ2Xguz1MJW/CIcYAcjGlNdguUUmF4xmo8QWaK3pBBdNoGh1cRFERcJlofEKpGZCJ
	s=
X-Google-Smtp-Source: AGHT+IHfyihAWVzF8pHEkPjUbhklPTdq1aAEaD9jhLigcQ4M/reYU/uV29tIuYCyJm5EllzXBTfkbQ==
X-Received: by 2002:a05:6102:1586:b0:529:4cf5:8aee with SMTP id ada2fe7eead31-5a575f8b907mr2302924137.12.1758716547752;
        Wed, 24 Sep 2025 05:22:27 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-57a02676c33sm4614528137.10.2025.09.24.05.22.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:22:27 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54a786ed57cso5156894e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:22:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK14ZSitsFjAUBpEnKyj/sw4F/GwwZ62qP7yhaKfzh4BetNu3XbqaJl+QRoLjq4Mm5WylRi8IaLguNhFo=@vger.kernel.org
X-Received: by 2002:a05:6122:1d45:b0:54a:9433:2aa9 with SMTP id
 71dfb90a1353d-54bcb0d4fc2mr2193731e0c.2.1758716546950; Wed, 24 Sep 2025
 05:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916150255.4231-1-biju.das.jz@bp.renesas.com> <20250916150255.4231-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250916150255.4231-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 14:22:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6+ckjLwZ0Bf1F-JcOUs1PU64vosv_bBkjcekE+b+VzA@mail.gmail.com>
X-Gm-Features: AS18NWA93dITivbXBnRhyAUt72W9JLfoCXO5SKCmeeTaB-m6uWGCJUFKL32jSiw
Message-ID: <CAMuHMdX6+ckjLwZ0Bf1F-JcOUs1PU64vosv_bBkjcekE+b+VzA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: r9a09g047: Add USB3 PHY/Host nodes
To: Biju <biju.das.au@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 17:03, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add USB3 PHY/Host nodes to RZ/G3E ("R9A09G047") SoC DTSI.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

