Return-Path: <linux-kernel+bounces-816805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53190B57870
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2601B7AF386
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A432FE59E;
	Mon, 15 Sep 2025 11:30:51 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6921B532F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935850; cv=none; b=iSkqSonl/sbZ5DfJBYXOUSfD3OYDY1a31Dl09bh5yuJRy3t1+U0wiBG90fmUjtwqjPGMqYtBt6B/rFn3aimxXtsPWM/6LPVFWW2URZwa5lbMc9oe68xsjEeAB3SxvKxkchKbNVgNV7ZeYJs49OVnfm/qH4Pd6QYyUg4SZWQLgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935850; c=relaxed/simple;
	bh=UrRBcNgc2GxQFH5pIfqBkMg5GVTDP+gL8ZcwdqJeQ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b57cKaiNqHTB9iw3MuoX6WyPCjQ62xuAEBkstBrCN7bMSbjDjgzYt29hTELtl02an1T+eokHq06Gz7vSjIKSh+23ZS46kkk+8tVERo3wfR7Fri9XdXcgvnDNXLisQnEcNvDiuTFjUieBD/m2kFdZisYDa0Ec93QpCcQqPqiIFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a17fbd375so1463791e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935847; x=1758540647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQBIjgXfu6Gxi8be5ntWO50wYelw8C9JIsRhAGgfqf0=;
        b=b7k6/3q8lMg4pDpspp2tL5aOQ0W2atp00FVyPO6v8H46rJmzlSvB7mJrl4B5kEVDPi
         sNQqKeD1oM2zPyO3lN83Tb5fzECCu+dMoxDcNF/UhXzfmdUYP0sNi+xjbftLSr4MS36o
         6mL6pqxeWvhhkDkTddvDM98v88Lds93o1TnUwn7YRsu8uEEforVYx/wZlreoxBJ9LRl0
         C8dAziRylqQn/x9N44DUWVoU4WJYma07BnkdJUWAwVRlHosPy0cWCjcqJ6YJ0M5PstEx
         UyBJ6cpmjYexsgOIy5tqCMVKOE6JRREoUlzthOoxTzGJDuqR4nn8+IQAkzmuF65biZth
         vhXA==
X-Forwarded-Encrypted: i=1; AJvYcCXw5JjwdTHSd5QD/9fZ2DHQggLaRU4tUeL3qERpKmcAgWg6pG4E6Ty3ipdBj6+8mH4vYlSO5br2j7SbrWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyiJ+aoiEe5sQgJu+/MK2MDbMvkxjkF40dlKlnp19dLydbM40l
	ndXOSrhjn5n8awN0u9vDBJ0/dJvt2GtCaeXhtku98FQkjwj0DRrhqLsUednvzA96
X-Gm-Gg: ASbGncvQcmqk5YRBp7soJfYmBfTGrOJWZ/WOyZTwbcGNfEnY83GvdmZoYIRCX3zNqXJ
	t3+OP4vow2i55C7MD05duHA3pJEL0VNEuJolufRJ+BO9AqEmfBEErZNGGfgDlzzM45D7/OW7Yxq
	xzOd84hc0/cKP6Z3kUjuF6UPUvTrUZYdFUTiQsMEFoSlyZD/uDAa6uAFiLkFwy90DFDjP+xz56N
	Sbqqgo76cTdzJ0gGHM6N/vvotP7zGgWXjUdQdlYqpmQGY/oPaLnJsqnrkisNVuyDxS9+U3BbJwM
	sV1tPD8VOBG1o4556l1euqE75MPrq4u4clx5hfGGCo1Ye1badPowGgLBd/AU6mNiXMhs6Pt1ZO4
	4VdqFqD1SZp7xFfebhFyvTx8wbiRIQT8xqqFCa2BQZOg0XFNPOq1tUyspOBwX3eNAl6ABkktBh8
	+NE436zw==
X-Google-Smtp-Source: AGHT+IEBQC+hTzrYDWEoJn4X0dCR9PCTqL250lUCwnH4nlURtlWl2003m75inoxwykPbGVx255A6WA==
X-Received: by 2002:a05:6122:3bc8:b0:541:bf69:17ac with SMTP id 71dfb90a1353d-54a16d192f6mr4146945e0c.16.1757935847302;
        Mon, 15 Sep 2025 04:30:47 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d1bbddbsm2135772e0c.2.2025.09.15.04.30.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:30:46 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-552d3a17a26so1340692137.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYJscUuSRmA0MaWKHLLK4jvR+2KjVnURdo00w5HURaxIlH1q/ne05xZ6hAmmOI4wWKp735lLkyQdrUSyM=@vger.kernel.org
X-Received: by 2002:a05:6102:290c:b0:526:f807:b90a with SMTP id
 ada2fe7eead31-55607e2b975mr4729860137.8.1757935846600; Mon, 15 Sep 2025
 04:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com> <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 13:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4V7pG9X=sa8e+2oOT0HpR9FcD78c-e1x81g+qbUrypA@mail.gmail.com>
X-Gm-Features: AS18NWDvTIOpaxSS7-BC4gTDK_1rrdMWh5mlR7XCHFBxf0fUTl306c1znni9qEI
Message-ID: <CAMuHMdX4V7pG9X=sa8e+2oOT0HpR9FcD78c-e1x81g+qbUrypA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] can: rcar_canfd: Move enabling of RAM clk from probe()
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Fri, 12 Sept 2025 at 12:47, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RAM clk needs to be enabled in resume for proper operation in STR mode
> for RZ/G3E SoC. This change also result in less power consumption.

results

Note that after this patch, the amount of power consumption is
unchanged,  as the RAM clock is still enabled during probe, and disabled
during remove.

I suspect that on RZ/G3E the RAM clock was disabled after resume?

>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

For the code changes:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

