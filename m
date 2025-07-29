Return-Path: <linux-kernel+bounces-749593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F8B15056
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754867B11C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658A293C73;
	Tue, 29 Jul 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zo28KwRp"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600D46B8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803794; cv=none; b=C6bOm0h2aUp/VJnumzq6RtsmTF4HI647OUoPxOSTWGHY3latCgkdmvLmp3vLVBsQ7s9Cy1Z+j2N2C9xvdMYo+V5Q7tsWC85WGQLb1lUl1mD/v4EQzVazHGlYrSfhul+zDA+8Fe0IrziI3hfOcTnvxtB1i+mCTHTuA/fKpYcGBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803794; c=relaxed/simple;
	bh=yyzHQv1Wv65hNemtjtxzhBXFqLoOaBEA9TmxWX2IOg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+/wxXvNoakVwb0XZysrwdH6NoLgzJW3uhM7Hnqovsa+3rehhnWEHtwFR+73YP1C0978bGGDwu9l/pU+Bqhs7GM/BO/90BENgRw5vd2RzY4m5BinI9gL3svZA4GoU4wMKQEVLCzscRUDMwxjdEfD/60eSHpPSkjvkrhGzMqeEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zo28KwRp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso4738380a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753803792; x=1754408592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSpJIgrdIeIOJjhVwTw0EcGlPuzf6kCVL4Vd0HFeqjc=;
        b=Zo28KwRpuyR2RkCvSziQ3MWriqRZpo2YR39NbaFSvBwC+FLa8bGyldowJQaO9fQe7w
         djlHxc5J9JPZBqryn4cBfp8eu+CJ1s2Yng8vWwxZGx7JQtUw92Hfv1PtVfXJt4VpUqJI
         BIPBL6oEGDNBrw0Px/vQTTE6DadVlVtIMx6GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803792; x=1754408592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSpJIgrdIeIOJjhVwTw0EcGlPuzf6kCVL4Vd0HFeqjc=;
        b=FtHigTS/Gdg8fF1gkLosLvP/zxqzliMsSz8RfJh/XYMl+E6D+UzUN34pyXQeBokXLr
         FdKwK7HSrd1v7dL3UZdkjIVyo0AXcb/FjRB0beTQN4DNXQDHRcxRjJmF14XLpCCpxBuv
         WJ0rEnm7MGp2Tk761Oz+Uqr9ihKQMh1J9v+7no35+EDvvzedwMN0kbSeET89MG+u5pT6
         b2fRH1UT6p0kFg2tnbeUDYFnAyaPzuSUYKVIitH+GEXGP9MM9RGpWfLAy38/EZTYFfLY
         nUjcIt3ZV8lIf8h7DuGwB6VmIw8jNo29E3Cd+BaucwWYBQEeHYxIjoWJkjb3GCvbVBYb
         phzw==
X-Forwarded-Encrypted: i=1; AJvYcCWeZ90SVVUe7DxUlH8KF1LD767g4lsOQbg/qEVrkfrlZ5IsZC2k2vCe4XY1ORP/3gLfH9xtNuKq3CP6jjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/S0PREC4JgPn0zTrKTlWToT+OfFJjV/pmkgBS+AOhqvyXIUM
	2bAF4LAkJPoa4c9dxiBSyvpD/cx8ENS4onaOogIbx3MJ6ujbXXFDhrPJZporx9uJG3oU2DXqufV
	JjuI=
X-Gm-Gg: ASbGncsPYt+Z3818x2ZLd9Acamy9BQG2oX9Y3FfC5ITyfBLYa8x8/h7u2BRDS0AFO3h
	d66u+y8E31UPEIwVSOoxkh3FHjtxsBGSMyxNL6sf0068tzWkNOWSNA52+L/dQKjPJn7lhq0VwUm
	yKRmzTeJOjqgkm5GoOIMeuPJNTfGEI/et1gNfgjKjrJMYqUUIcCd27BvW13ewZT5iFIGhg+uReB
	euPHrQZb08maHkJDkDtX9vVyJ1IxlI8IxsJlKOmHDagN0PzpyfMKCzeJcN5i+b9E+Hp2zwcfHYo
	enSxilIblJQq9eUzLLwgebyWKALJXbzMCPBB2Rbxkc78ndZrytw6Y5ATOVgz7kWdiPezy1n1cHa
	I/5+NPS3dTvZ2KFiVyaNp3iuRCm6Qoou26GquXmXeVbl33b8i2ww1OBOKr1op124Muw==
X-Google-Smtp-Source: AGHT+IERBFq1SZ2c8zQUYHg3RKGLC1XhMZ8DszywH549xaeZJcKNjpJ8OxOVyR8prpyIYp7D4AXVlA==
X-Received: by 2002:a17:90b:616:b0:31e:c62b:477b with SMTP id 98e67ed59e1d1-31ec62b48a8mr13109719a91.11.1753803791733;
        Tue, 29 Jul 2025 08:43:11 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f0ec93069sm4001390a91.37.2025.07.29.08.43.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:43:10 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso4738343a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXddJkcjMSlcWUgt4ZgrBOXZEuWgj3zEx2jXxh6H+T3aaybSlgKlIq+x+IO8dChpvscOl3fkVYb3FBB9Nk=@vger.kernel.org
X-Received: by 2002:a17:90b:4e8d:b0:31f:2558:46cb with SMTP id
 98e67ed59e1d1-31f25584712mr6855560a91.16.1753803789967; Tue, 29 Jul 2025
 08:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722015313.561966-1-me@brighamcampbell.com>
In-Reply-To: <20250722015313.561966-1-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jul 2025 08:42:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vpk+sWt6n5+OFrOSa9bUf=5xbcGH6TA2D58HnDcrzArw@mail.gmail.com>
X-Gm-Features: Ac12FXy2DrlKwozrm4Lh8eKlO3PrClRoMybwweQhMtq-dXfeG8sVqMiOcJ65aGQ
Message-ID: <CAD=FV=Vpk+sWt6n5+OFrOSa9bUf=5xbcGH6TA2D58HnDcrzArw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] drm: Fix bug in panel driver, update MIPI support macros
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 6:53=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> This series removes the unintuitive mipi_dsi_generic_write_seq() macro
> and related mipi_dsi_generic_write_chatty() method from the drm
> subsystem. This is in accordance with a TODO item from Douglas Anderson
> in the drm subsystem documentation. Tejas Vipin (among others) has
> largely spearheaded this effort up until now, converting MIPI panel
> drivers one at a time.
>
> The second patch of the series removes the last remaining references to
> mipi_dsi_generic_write_seq() in the jdi-lpm102a188a driver and updates
> the driver to use the undeprecated _multi variants of MIPI functions. It
> fixes a bug in the driver's unprepare function and cleans up duplicated
> code using the new mipi_dsi_dual* macros introduced in the first patch.
>
> changes to v6:
>  - Fix various style and kerneldoc issues in patch 1/4
>  - Fix typo mpi_dsi_dual... -> mipi_dsi_dual...
>  - Fix incorrectly named "data" and "len" variables
>  - Make _seq argument of mipi_dsi_dual_dcs_write_seq_multi macro
>    variadic
>  - Remove duplicate definition of mipi_dsi_dual_dcs_write_seq_multi
>    macro from novatek display driver
>
> changes to v5:
>  - Rework mipi_dsi_dual to explicitly not support passing macros into
>    _func and add "dual" variants of the generic and dcs write macros.
>  - Make jdi-lpm102a188a use the new
>    mipi_dsi_dual_generic_write_seq_multi macro.
>  - Make local struct variable in jdi-lpm102a188a conform to reverse
>    christmas tree order.
>
> changes to v4:
>  - Fix whitespace (I forgot to run checkpatch. Thanks for your patience
>    as I familiarize myself with the kernel development process)
>  - Initialize mipi_dsi_multi_context struct
>
> changes to v3:
>  - Define new mipi_dsi_dual macro in drm_mipi_dsi.h to reduce code
>    duplication.
>  - Fix bug in lpm102a188a panel driver's unprepare function which causes
>    it to return a nonsensical value.
>  - Make lpm102a188a panel driver's unprepare function send "display off"
>    and "enter sleep mode" commands to both serial interfaces regardless
>    of whether an error occurred when sending the last command.
>
> changes to v2:
>  - Remove all usages of deprecated MIPI functions from jdi-lpm102a188a
>    driver instead of just mipi_dsi_generic_write_seq().
>  - Update TODO item in drm documentation instead of removing it
>    entirely.
>
> Brigham Campbell (4):
>   drm: Create mipi_dsi_dual* macros
>   drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
>   drm: Remove unused MIPI write seq and chatty functions
>   drm: docs: Update task from drm TODO list
>
>  Documentation/gpu/todo.rst                    |  22 +-
>  drivers/gpu/drm/drm_mipi_dsi.c                |  82 +-
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 196 ++---
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 804 +++++++++---------
>  include/drm/drm_mipi_dsi.h                    | 118 ++-
>  5 files changed, 614 insertions(+), 608 deletions(-)

Pushed all 4 to drm-misc-next. Technically one of them has a minor
bugfix as mentioned in the commit message, but it's VERY minor (I
didn't even think it needed a Fixes tag) so I didn't worry about
trying to get it into drm-misc-fixes...

[1/4] drm: Create mipi_dsi_dual* macros
      commit: d94a2a00d2b8878678607c2969fee3b4e59126cb
[2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
      commit: a6adf47d30cccaf3c1936ac9de94948c140e17dd
[3/4] drm: Remove unused MIPI write seq and chatty functions
      commit: 79b6bb18f849818140dd351f6e76a097efe99e9f
[4/4] drm: docs: Update task from drm TODO list
      commit: 85c23f28905cf20a86ceec3cfd7a0a5572c9eb13

-Doug

