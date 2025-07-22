Return-Path: <linux-kernel+bounces-741244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390BB0E1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E7C5652C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BF27CCC4;
	Tue, 22 Jul 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mW/rTHPG"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34058185E4A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201933; cv=none; b=GlmUc3Ot7HJRd8GN31cCHABPIRT4+ns2PO7Pao0pYfssaBJenxEecohvaph3cT2fqM8Y0Tu2ySbJO//aMQz91Kg54E4Db/J8EJwTRIO5ESMFGP9f6EqGLBn8dpF7lVkSUbJseAbPwCTGJ9IYgpdaO/2aBXAeEEdNi6tYhUAZ18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201933; c=relaxed/simple;
	bh=Pqs4E5LUI8mWz/IsLr+Bi09UwKTqd2EriMVrdlnD4Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhzV1HYAkWypydIQ0TgmV+X4c+PVzqCt9wq8Xv7c5Fyl+wS6mFXe0aONrZOqbZNgMbWM7FQOsIT2dDoPIXpDTqeNyB4kyJ/+y+2M8mKxSKkvSnskqPPx9Fbb+IG3dzUzzZ1iUnQbRx4OpPaJIoBVpAj6KkpBPfVp1C15UlqlQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mW/rTHPG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso4720592a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753201931; x=1753806731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5dIDnAxZOX8ng1HhpeNVCkuVrJFpRO5masWNAnQ3RE=;
        b=mW/rTHPGNeUnOiOWBv0MaBy+sML7w7kb2oYMREJQDhYK3cPQoihcXSZBaDVtVBtFZT
         z8gMocSw+NQ5XYAmDqFaPoPTPaCovzQil+3a/2MG+hRkdiDVdGvNItxo55KRf8GnslfW
         PG6GuE66CBQTM9utFnPrOl1VWMC3n7dszWvkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201931; x=1753806731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5dIDnAxZOX8ng1HhpeNVCkuVrJFpRO5masWNAnQ3RE=;
        b=Ec91jnMvoY25AUKZYdjjn3iHkq+fsdczkSuO+5Bj9jhp9BRbz9vDRtuNRlG2T3b+Q9
         PzB0Ai+yyNWtKEI/he7x4wbEt1zpI59cOX9beDhUsLR315HdlKMHGjB7kz+kqMNRnZNQ
         zqOF+MYjS39YGU9vVkpM/xeOLPzHc1Db4eComFcJZLx7q0dq6v53SkK8O4LIKL6HcuM/
         84xDOiuzHqPZutbVjhYftMsrQWpsh4KVcuI+LQmKJa31DnOkGrKfkPP3ZpDTDD33mByV
         9TeUu+y6NXdl2KbA8Nr92K1tyDUnn61M+iZjYl0rJ1L/yLumfTMGF48dDawqny5xYJ0v
         5Tqw==
X-Forwarded-Encrypted: i=1; AJvYcCVAqn/0xL66wUoK0tmOgyIbPsxCWUuPW/3zI3XxxehIotrIBneJ9fres6YJUZNOINFhv7Ry3zEhkwWiDag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyEaRywkWrrz47ellzXb+mg2A6GLHrmeikSdZEw6DW11kvNJr
	JpLxreVwppDDTcc4HsNjFzJh7oKOQtW5O0SLDVB9Kc6iOAouPkFvSAFaV5v2ekGC4dI8RJP4EWj
	Fspg=
X-Gm-Gg: ASbGncswicap7LfdZwN2/sQ1pzWaNjaZvWnS2e+Z2A1WolrxHJT9TWWq0+kN2eQIsLq
	rDKtIPjKW2xqLFbZtiiKwLxHRmTLzD78tkXO58YpF2YPYK24G2WVe3I+jJOwPjGWRLfNQfEX5p+
	k3QLvfr4wWBFe1VvaC1Z49k9GqfJWtJqYUQs68PxzWF2kveNy8T7eflrr6ZYlDERG0VFBxEouYU
	5qW1hAZbqH+uZMBUVgloiQeGiKQ09X4IOCGOMVoPxKAwlDhbvPoWypjGSgn7mHACg4QrFdG/mga
	axHYm7zLuk+ZNCEjLwEZcKKV0KgaSkIlTLXUquXlXyswSZ8asHnAvoCRkPd/0sZPT7aNJhryoMw
	+u8F5aJnT7WcjpmWAngAy9iEiVHGBsVlIuOnFmXGlm2wg6z0HYRxJPt1vL9EhTA==
X-Google-Smtp-Source: AGHT+IF8sARU+bJr13E3F61qZHCZ6kvxf2Kto48EdGtgKIZXOtWC3p42R6aBqDdJD867OS1swy+n6g==
X-Received: by 2002:a17:90b:58ec:b0:311:c5d9:2c79 with SMTP id 98e67ed59e1d1-31c9f42e84dmr34933862a91.21.1753201931520;
        Tue, 22 Jul 2025 09:32:11 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e4571asm8444751a91.6.2025.07.22.09.32.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:32:11 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso4720561a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpOjRH/rdDujCTxCuGfarn0riM1xe+JfcYIPWy5grsDcVL4OuKrEcAOhR2UvVmggyXtzKdwQEMBpHtGU0=@vger.kernel.org
X-Received: by 2002:a17:90b:2247:b0:313:283e:e881 with SMTP id
 98e67ed59e1d1-31c9f3ded05mr36938957a91.11.1753201930387; Tue, 22 Jul 2025
 09:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722015313.561966-1-me@brighamcampbell.com> <20250722015313.561966-3-me@brighamcampbell.com>
In-Reply-To: <20250722015313.561966-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jul 2025 09:31:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vg6LoPzOHRj=XzCcSb7rPb=vPuCZngrf4hROZNwfj2Pg@mail.gmail.com>
X-Gm-Features: Ac12FXxeoQ5h83qTRHx6WqFmrhVxXb5TjaxOWmVQAou0S7ba7bXolm4shfJMxPI
Message-ID: <CAD=FV=Vg6LoPzOHRj=XzCcSb7rPb=vPuCZngrf4hROZNwfj2Pg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 6:53=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Fix bug in unprepare() which causes the function's return value to be
> that of the last mipi "enter sleep mode" command.
>
> Update driver to use the "multi" variant of MIPI functions in order to
> facilitate improved error handling and remove the panel's dependency on
> deprecated MIPI functions.
>
> Use the new mipi_dsi_dual macro to reduce code duplication.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> Tested-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 196 ++++++------------
>  1 file changed, 59 insertions(+), 137 deletions(-)

Just for fun, I ran bloat-o-meter to compare before and after.

add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-217 (-217)
Function                                     old     new   delta
jdi_write_dcdc_registers.d                    10       5      -5
jdi_panel_unprepare                          312     260     -52
jdi_panel_prepare                           1020     860    -160
Total: Before=3D4908, After=3D4691, chg -4.42%

...not as big of a savings, but that's not too surprising in this case
since we don't have the whole pile of "seq" functions. Still the point
was making the driver cleaner and the space savings is just an extra
bonus!

-Doug

