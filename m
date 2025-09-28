Return-Path: <linux-kernel+bounces-835559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29FBA7721
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9067A2407
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C126A08A;
	Sun, 28 Sep 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1LxD8wj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE706C8FE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759088038; cv=none; b=P13uS6Ui8KsHshTMTnfKSwJpY9X6FTMlzT+HSguW1rmcG+wHCxCHxQLV8o6ibhi9zRv0VUh/a5WQPLceU9XkmhENBZ7ZpiKbJpsoTqVlvJIxC9yzbAYysMxCL7rZ09iZzhx4g9hQqhMs9HEMcec0kmP2/t/s8DwJK3T12nDY90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759088038; c=relaxed/simple;
	bh=SY2WQpP4TD98VH+yCLub/gCUkYNLxrDYyequyKHzXt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wdg73VlXv76KKVvQphEwxAJCoWfYZUPZhmSY3PRC+UkRroK/3q0+YxVfup0zXycfnc68+PdrOtpCmaoX+dU7OntJE5NyUgg0YJ8uaxhRtHmpH/jyog/nhs7JUZSflXU1l1OTv/bh8xrjiwWYKnPDSEWDWA09t+rlupg+acMm7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1LxD8wj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d50882cc2so123354566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759088034; x=1759692834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY2WQpP4TD98VH+yCLub/gCUkYNLxrDYyequyKHzXt8=;
        b=d1LxD8wjuw9nLarfwFKOJIFfFvrGgw/E2dsrVP8Ogmy8ygZ/j/KMOFkXJjwLtW00Nu
         0SOY5of7YQDgCmYg4WY7NKJJMIDwREU60O8sVmYJOKp3bXXSxv/vivgMP/20YBfYKrUl
         scdhEIcKARbZhEYOYD8R4gWspC8UlAEvHx6lUwwq4amPKc6xXstwr1cQ5TwuCOcyTJoX
         AiuqL+g41p8m/ugcNONdV0nCWIugc9tzkZM11jCeD7740UynR1Kg2wZoj5Mt+OJoYq/a
         SIEopqgbFvdEDdSBESOfhjXF5TfPDDCW75TQGlmuxbzko0JWe4V7pzGAQ1x4rKlGUezp
         sFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759088034; x=1759692834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY2WQpP4TD98VH+yCLub/gCUkYNLxrDYyequyKHzXt8=;
        b=g7HB6i9T30L0+PC37pUftJuCcWlIcixatURAtpokOU2vyZUQFVmSfs52J5lp3CiTtU
         YlAbPzVKDv6z2v6Y232bw5lSu+5V/yq5xY/NT4MTN7Wo289HzXHS93vg3p1b7k2tYQ/W
         l7Acz5krrXjI3p48hYuZfNLHPlLuMdVTJUSAJTJo/2NBTfE0pDnD83wNGOOX4ceDD/EE
         NKSKTEF1yKuKFgBlqLXmIPTyOZdfUH6NXbR99tljfDlWetmDgWQ+YB6O/jxnb3s7VA2a
         kyz0/53rbYuNyISPLzJwNP+e1wtqlrcYRZIYhrGQxa0i+LIKl/C1HX40ETGXmq6ZOSrr
         hGxw==
X-Forwarded-Encrypted: i=1; AJvYcCXjKZaaQeGngUUxhtM6YWlAkUWLEcErfX2Vgd3KsVOTIkpOi2rJjfThSzIIguXdQ0fN6PGk/rlDmqVAvbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTp2MYNVW88IadUYdPLM96OBqqdzXu88XeiOHSfB4nlkFOj4XQ
	UY6jZ9udlidyNCB2UnuDmj+WteFtnYg/juH4g9IhymeCqq6K+98AUpTL/3SvrkLw+P0XPfXnfcp
	xB86R65pPIoPfohbxsFY/ln76CvA/EZo=
X-Gm-Gg: ASbGnct0YfawLBSgdgKFL2bI6AN7tZjGOVu/LM3pKWbOi8DJDxujQ3FbwdjvAvbgikN
	Awkd+N/zT/qvifjPfcOatz+bQA/SDxKaU/kopJ1u06SaWXX+nD5oBTXvKjvhTsv3fdTIkC4xMMq
	rkYWbJm/3qOs3l2pGs/SyXs24wT4nCObzCuk0lDEGpat20FkJOoV73C37WzCAYeG10/kG9E2tlT
	xu7aj8hpuQmhUhkpQ==
X-Google-Smtp-Source: AGHT+IELSeCgCGyqnYFwLjpP9I/QUkSXTi30I9okuHYya2KnsNvX9kEtVC+RW54UOV7fvTUxJOJ9A57qSXR6SnQFGv0=
X-Received: by 2002:a17:906:c145:b0:b07:88ef:fe1a with SMTP id
 a640c23a62f3a-b34ba93ca8amr1820788166b.40.1759088034191; Sun, 28 Sep 2025
 12:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095229.2149740-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250923095229.2149740-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 28 Sep 2025 22:33:18 +0300
X-Gm-Features: AS18NWCwQng2zvXar3j9bvUGzv_wYAqN6A_8i_T4MH41majXCfzU6gFOBz8-dpw
Message-ID: <CAHp75VcEQ_14EY0Fd8GD17K7VBe29VN-bU5OtsFwKfpQHWrnYg@mail.gmail.com>
Subject: Re: [PATCH] lib/string_choices: Add str_assert_deassert() helper
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:52=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add str_assert_deassert() helper to return "assert" or "deassert"
> string literal depending on the boolean argument. Also add the
> inversed variant str_deassert_assert().

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> Note checkpatch complians about adding a new line before the macro
> definition. But this is the existing style in this file. So keeping
> it as is.

It's a checkpatch's problem. It's fine to ignore it in this case.

--=20
With Best Regards,
Andy Shevchenko

