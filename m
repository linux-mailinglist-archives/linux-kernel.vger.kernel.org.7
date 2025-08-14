Return-Path: <linux-kernel+bounces-769721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF1B272D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066A26272EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083628751A;
	Thu, 14 Aug 2025 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X4Zqo9C0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3C2857F0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213050; cv=none; b=WhUKQaw8LgHEaRBBzbO6Q9z4eGNTlrWn4OJBBnPwcnLc53OZBjNKiMGceRJ0tQ1Zsm2jCU6JgpS2Z0VyZPDXMrwyj3fDs/2NaZhplmZMrhWMLmUuUlkXUax39Ox0lJS+JbOnuesZh+/GXjtvUGi53SEcWNqFQ4YeGIr0FMrE4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213050; c=relaxed/simple;
	bh=pfH/iOggbGrqSeQ8kTed0p2KPGpZKgg81d7pIa3+X7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLrEvsSiPeklblAeZ2/Pi2GQkkXmkt2DMivquZ/Os+mO4u7FA/SgNUIkCER4cMmEjkJh8OINbhcF3w1qV6Vi5QyGAry1F36elnXyMA457IOxnTOVZcymRBWV+vz6kQTFrjj+gaEBw6G23+ztExfD0Fg39AiepbIFA/YMZ+dcP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X4Zqo9C0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445818eb6eso12208765ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755213047; x=1755817847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60PL/oxrejEGqmONPWLHGxzqkl5vemphiufOxPK6tJg=;
        b=X4Zqo9C0fjK5NdiSURybnhA+gMEvyx3RsvryP9fdfN2cisSgiq5MuC9KnC8Go8SE//
         RtsJbaVZtHIdGj38YlPWwglumzT5Jo7lZ2JWGlxOrp9RQk5VQPkjJwa1OZQe4miTl6Z0
         VpyNvPAJBYBVfRkZTbzavRjsLrZkykvP7bMw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755213047; x=1755817847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60PL/oxrejEGqmONPWLHGxzqkl5vemphiufOxPK6tJg=;
        b=XOaOpO/LxOBUhborFUxqoif/mdl5QKaFG+LraOTgt8qa/3g8PAdjt0LetdOGwf3AjV
         RsazDCRmqRSbkd/vvhUxi/6gqgfMjPUR99/fFdjv+EQeWR8yA8WW1ciGUranhqI4X06h
         0I5GBC8kPXk4JalVOYVRT+9jxo8uXOGpiviLJetWqbdUy4y9v9UPSRMuHKluzLHxp6kA
         SYnXZ8TQ4kVZ2swJRWARlr9iMElnpvdfpmYceRhW4vj3prfJtDSrou9U9FNJIr4FHGf6
         wyTgePY8iu7LhOomQ89o6J3UZhoqHyyWoB6HvsGkXE4EwpQsUQCv3cOnvPV5/RQNy4Y3
         lqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ9EOXkfqTg5OuBicDN2nChBPPsQdYnOJ0B4BOkWmA2yLtxkjyM2L2ow0mSMjpZbnMRznF/p23UWON/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoALkDrTSsqjHMW2qwWaaRBp4m17XoaCLN7EILE8N8WhcdzYC
	Q8LKNW2BdOuVhGuyiG0hyWdxBHCegYHB7Cy63/l7bLHsvoSTuR4sdZcO29jwo+ZsEBNzpOz730A
	Nbv8=
X-Gm-Gg: ASbGnctKmCCeJ7dEst9n14QRLJFTvqdcgrjJouJV8LcNhFEy/QcL5cbx+MTHR7524JH
	eDQmUpDDIPJmvUKZw1QNrIOR5Vzsdew79qGVxVu4FlAikvKvtO0b29kaTNz8x9smAF8v7hV/xna
	prv+4T3DgMJwTGrRuwni0Yq2C2kqcxEsKs2HiuN03fahWZWHjb/iMtg/YmCTlGBnHorfOQcDJ0l
	AfF6P1MfsvOHuXeCF7GI2eC3jPAKnkpf2lj9Bn/kE2QJ98kGuX364oknA8/Z5JHSOBd1Jf0vJZA
	gQlsASFUy6xmNI4BuFgTj7pPojwToAC5xezvkFBtC2tdaRxjQuEW/ejFWp2TmVyPYvSbQKg96xQ
	0/CxfgZ+FdBsJQEljoZqDFw8vdxo9OnVPivUlgMHuTZlfXI6JWPVuKBtvyqLV8Hk9lQ==
X-Google-Smtp-Source: AGHT+IFrpaZEJs1NnVV18Q2C7b5xz8uG6t9Jfc1iR9gQE7Mv/LknX0whv5uPYIQxwRxTYCoZ7G7YyA==
X-Received: by 2002:a17:902:ef46:b0:240:5c75:4d47 with SMTP id d9443c01a7336-244582c6a88mr73498445ad.0.1755213047391;
        Thu, 14 Aug 2025 16:10:47 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm30750640a12.15.2025.08.14.16.10.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 16:10:43 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b471756592cso1002104a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:10:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+OftoRJ5Uzfnld2YrLYTKgGRxPdhqyvaOcwOdTLCMHyj2vvvO2p2obwPXoEkZzdmOb7Gclm80Myf1nmM=@vger.kernel.org
X-Received: by 2002:a17:902:f78d:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-244586d8e16mr79147325ad.49.1755213036298; Thu, 14 Aug 2025
 16:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731032343.1258366-1-me@brighamcampbell.com> <20250731032343.1258366-4-me@brighamcampbell.com>
In-Reply-To: <20250731032343.1258366-4-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Aug 2025 16:10:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XiOspYS2TdDy6Ww2EgxTUVKgC9Bx56WU1y6a2wQVXmUQ@mail.gmail.com>
X-Gm-Features: Ac12FXxi9RkgHR4pMbyFh3pFNLJh60xWsgOW_dQYqmDelZcW1Vg0aa7a75_0dco
Message-ID: <CAD=FV=XiOspYS2TdDy6Ww2EgxTUVKgC9Bx56WU1y6a2wQVXmUQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel: novatek-nt35560: Clean up driver
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 30, 2025 at 8:23=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Update driver to use the "multi" variants of MIPI functions which
> facilitate improved error handling and cleaner driver code.
>
> Remove information from a comment which was made obsolete by commit
> 994ea402c767 ("drm/panel: Rename Sony ACX424 to Novatek NT35560"), which
> determined that this driver supports the Novatek NT35560 panel
> controller.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt35560.c | 198 ++++++------------
>  1 file changed, 60 insertions(+), 138 deletions(-)

Pushed to drm-misc-next:

[3/3] drm/panel: novatek-nt35560: Clean up driver
      commit: 5fbc0dbb92d639d10a5386ad0ae87a54680a04be

