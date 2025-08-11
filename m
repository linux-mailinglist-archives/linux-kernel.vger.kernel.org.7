Return-Path: <linux-kernel+bounces-763634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13151B217F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3818623CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B92D94B0;
	Mon, 11 Aug 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKr7I6x1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D41DED7B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950216; cv=none; b=JY9OI+uupqONaj6eFHUhT1vfFy0yW8N3xmvx51eqj7U/CAppaQpCqPkvr4VZNUWKS1sRbmk95d2m916eaL/vqM4vn5qSQRPQNPStFw+j3puyVTcrnt4kWSZsyqPGsQ5Ax5VjzEEJVU86NGX/eyrkAoEqXc4AiScgRVhmHWhRvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950216; c=relaxed/simple;
	bh=PVgUqPGL6dYO01haslVGBOGEbGvA2UxjksdVK/+E/CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBOU5I3DaM2n/W9tcvtZHbRsttI3ewT7wtYx2pnjbMSAr3+HQG1IlZ8bOLtACzGAbP4WWFcnppbNWnFykIharp/U0P2SPc03ZhoyzRRQxgxTqK9AWZ2nvD5qDR7QAZqBcSp313xDEVw0TNHH8RQD0qJGUXBJChT//l8YleRPPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PKr7I6x1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24031a3e05cso32230435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754950209; x=1755555009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKoHHjT8yFfyfYeN+QtJgAeYV97GirwWW9p34VHnmmA=;
        b=PKr7I6x1Wl8KK1Lsa6aIvOaS/U2QeMsuAhbap3ITUl0P4cklLMdapQRhNd2ntObyjX
         wbKyFliBJzarAswTj84Jx1qC7ReSi19SnGBtkHzX3xziE9dHCBXktQ8xFSfy30WrXbjk
         JTTYMwYTVliRZWmeUzINM+ZDs70bCKislBwRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950209; x=1755555009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKoHHjT8yFfyfYeN+QtJgAeYV97GirwWW9p34VHnmmA=;
        b=Pq0NRw4GCm5buvag64oxmx4p0d4z9wEl4Rt/XQbj0zRsmKefisEv8cffujtFeE0d4d
         z8oU2vLRuw3Hi3Pn0ll0Vge/qfARnMGckM0TK2RRf6kjjpjO1aTLZnK86b6vo07sRZLp
         m02Ss5c1a4vu/FSb+H5tDVnmAXwdETJ7rNI7rgpMtr2BOs7rrEX9uD+QquAcSKelrTbg
         jWQBWjQbYK6RmkgrljkFtSBDPORwsxZqnLHUcjmLpdt0STOFebI0osdpQoz9VbTfw5vo
         2ZF1t8ZMBYOmOAogfO4IYbHOdPlB5ED+xzfaP0Sq4ssF3gCtQX+3Jm2XsShVZVlDqFrC
         6PyA==
X-Forwarded-Encrypted: i=1; AJvYcCXTvpLBDVc37tktKcrM5m+HJgJWNwow160H5IU1MVIHkYl9v9OLA/E9KGhnXJHeXtUhkbjSaF7Mq+pr/bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySG3Pu9hBbDatObvnNgBZpuz1UaNqvWJiTaBNxaAsI+Xw415nz
	bh2w7UbSJVCstjTG1v7q0M3AFxUsV5mz7fgPNS3jeSpXGmIy4vbbRKC6LT6I10UUXujBWMbr1YA
	3y90=
X-Gm-Gg: ASbGncu95u2td3kp5zV8S/y4aLW4RHUMK4NQ/FppANsMF7LOOaWjjiaGO9yWtM4BZkH
	9fSXL4JJ9axec+gfI8CiHTrrPdnvjtpgsEEwVHpv9XoM3FVAe+YAX6KvUmfGagQvGLDihFUF1qP
	JyhtMHpPTzkmt0U1XL9xTgY/kkwxWiva/IeEjoRJGp72VZc6XAVIN7KGyZNcEA89aVcs0pBjj3t
	aZDN3sc0k76wvEtZe2RHjbnEhfiNoOiGDgzf9UVIEuAX3IE0p1uP3H0++GwKn7JA1xoD1GqRXdq
	KyXe7zLkqvogjVF/DJMI0yjVIleKfllOg+umk6L7X6dYRBv2wJ9sfCPYIDAXy8q3uBGB6rZ4AA0
	sLfOjAvhY/ex9SIQr3tFBCOPW+rltTTXUaGuog284exjWpQkM9RBztmSS7ebMphAXDFF/GdNPqg
	Ly
X-Google-Smtp-Source: AGHT+IHxFUl7VqEXQ+E7NTVIuU/6tfoP4+qyrptLLzHPWW9iBfWAGGV4NYgn5dd4fcjT6lh3ZoR+nA==
X-Received: by 2002:a17:903:947:b0:231:9817:6ec1 with SMTP id d9443c01a7336-242fc36df0dmr17652105ad.17.1754950208438;
        Mon, 11 Aug 2025 15:10:08 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975acbsm283746385ad.85.2025.08.11.15.10.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 15:10:07 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23fe2be6061so30726825ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:10:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeIOHjR7wnmR3wt/P5I2aJlR/bODeCro4Dt7bSZgF0LtXJ/QJmaYa++dpzxEfKSmI6uf7rKDzMR8c2VlE=@vger.kernel.org
X-Received: by 2002:a17:903:22c1:b0:240:ac96:e054 with SMTP id
 d9443c01a7336-242fc39c707mr16059165ad.23.1754950206336; Mon, 11 Aug 2025
 15:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJKvm3SlhLGHW4qn@jander>
In-Reply-To: <aJKvm3SlhLGHW4qn@jander>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Aug 2025 15:09:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGVi0q2Vgp_JALjcBJMzw+C9uOfzfzGGE_YnJOgYVjAg@mail.gmail.com>
X-Gm-Features: Ac12FXyJsKrTSQ36G9lHnh52Fq9-wqIdM2Q0ZgO3RGoXAGLXCYzUVarebSqfLfA
Message-ID: <CAD=FV=UGVi0q2Vgp_JALjcBJMzw+C9uOfzfzGGE_YnJOgYVjAg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add SHP LQ134Z1 panel for Dell XPS 9345
To: Christopher Orr <chris.orr@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 5, 2025 at 6:28=E2=80=AFPM Christopher Orr <chris.orr@gmail.com=
> wrote:
>
> Introduce high-res OLED panel for the Dell XPS 9345
>
> These timings were selected based on Alex Vinarkskis' commit,
> (6b3815c6815f07acc7eeffa8ae734d1a1c0ee817) for the LQ134N1
> and seem to work fine for the high-res OLED panel on the 9345.
>
> The raw edid for this SHP panel is:
>
> 00 ff ff ff ff ff ff 00 4d 10 8f 15 00 00 00 00
> 2e 21 01 04 b5 1d 12 78 03 0f 95 ae 52 43 b0 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 fd d7 00 a0 a0 40 fc 66 30 20
> 36 00 20 b4 10 00 00 18 00 00 00 fd 00 1e 78 cc
> cc 38 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 37 31 4d 31 81 4c 51 31 33 34 5a 31 00 00 00 00
> 00 02 41 0c 32 01 01 00 00 0b 41 0a 20 20 01 ea
>
> 70 20 79 02 00 20 00 13 8c 52 19 8f 15 00 00 00
> 00 2e 17 07 4c 51 31 33 34 5a 31 21 00 1d 40 0b
> 08 07 00 0a 40 06 88 e1 fa 51 3d a4 b0 66 62 0f
> 02 45 54 d0 5f d0 5f 00 34 13 78 26 00 09 06 00
> 00 00 00 00 41 00 00 22 00 14 d9 6f 08 05 ff 09
> 9f 00 2f 00 1f 00 3f 06 5d 00 02 00 05 00 25 01
> 09 d9 6f 08 d9 6f 08 1e 78 80 81 00 0b e3 05 80
> 00 e6 06 05 01 6a 6a 39 00 00 00 00 00 00 58 90
>
> Signed-off-by: Christopher Orr <chris.orr@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add SHP LQ134Z1 panel for Dell XPS 9345
      commit: 754dbf164acd4d22dd7a5241b1880f54546d68f2

