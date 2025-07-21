Return-Path: <linux-kernel+bounces-739535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD7B0C77A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5F41AA4E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5675E27CB02;
	Mon, 21 Jul 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T54UiB+D"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268D28F95E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111455; cv=none; b=cijwP4fBcSWEowKlCJk+TnZOEzDYu1iJrKnzlsdHokjjEOvjR8x2cfYkKRlARMtb10pP13E1ccLwbnSFS/CuGY9+cej0ZNJ7EeYhEy/cwds2W2Trl+Vmn2+pLl6hlI5mnLIOlAf4ltLoqybzIWTHKWwLK04WI8/6lHusxdrmyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111455; c=relaxed/simple;
	bh=Qy70/fqwehYyhnpCdlSbnSfwh78on5RaQfFIrBgBX2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5youL0x1AxsvAq94++R9b5NJDOV6sVStF4pr7AUckDRUA/Z3Qj849SDwxvuFruqeK65TVcCt+LfWlGqty4kX9GanOP2sWcI0dImGhjvkVc2IxzhqiACTtuROAhe3Lh3dDS4e6cTAkHdCvyU34o68gJmz4PPeGfQnK34PGAJc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T54UiB+D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e81d37a7so2921361b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753111453; x=1753716253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prtXQzGwpDYewy3C/PL7YFCwjtX4giGSBgIkaPID8u8=;
        b=T54UiB+De+Uv/zTRlrt8wP6fjdeZ9/37AcPr3WZZR5/qB+FTyh6sCM/r95Cbe52Gfp
         MfllV1w9M2tsGt0wArqL704PqcZcAafMjtVhxdoC4bQ3F3Cb9d/X0B/3VbY2YIqDPr9N
         HoUFhQZQB1/q02OVVurTKafL4vBcGmEfwsiI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111453; x=1753716253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prtXQzGwpDYewy3C/PL7YFCwjtX4giGSBgIkaPID8u8=;
        b=StGJJQJSNc4MAgo1YjCFx8QlLY+cIYp0V9ykhPaubC/r0Y+La84krzKyh/txQQx4Uk
         /gbxDYZ07YU90x1QehkxOotutkO++Yf9wwS4oPm6BfxniFWKmVjcAtrKFsMdLqAkWSON
         va4/y9ICA4EXf6g6jI2X0AEwbD0PPJ3VFRUGOj4sCf/yq/0y63hlI8CuhFzU2BcI3Tfz
         1sQ0W2bMpG3WrZfsKJ02fMbLsUF/YLMoPThhwEJBFKM1pN7wa56hhi7160jGQjyZ89G8
         oou2GYjPM4qqswtg/jjHLicXheBCtLaFa6Nhk1YcuAqdRMPh26YGn0bYNFq9eS4NdPXF
         WcGg==
X-Forwarded-Encrypted: i=1; AJvYcCVwLkju6eT7pkS3lovKtVTU83GRlwiVzZWnOZpDVs+ym+MznP4Kzjo7UCh3TTs8bqZdHgyspWG9YT7oVWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VxwoJ87VCXxb9tm8rSYDmUJz66LbO0sxEFntvjCRcOfXxXvp
	vBFU9Ck3lLMfg7RoZau2pyjrifql/l957TA2DOMGVI9jcV5j2GmbglQgnqbW82G15bH1N+w1sVB
	CbTs=
X-Gm-Gg: ASbGncu0oMFaOzlrw6OCZ2sEPY2kyiXswUMxvOIb76d8dqUeHe2me/VozROG/MRYY/y
	N0TbTMF0YRD6Ybi1Q3LURMhCSuHAMeJIFqggA3B7Bm8f7UDWV3RlFD8F+sbghNpS0we2NqfyBmL
	k/ygm87tDmCa1soYn6ZfHSZZ3hTTNW70nCNsKmxaDr8sbLz4SBVuz9H6Q2e/phAeiN15fEliIqN
	rF46Ctyxv7cFtRQWdiPURZXkREFtlgEkrk7iiLJye28XCoGEYrYsx3cyAeBu/0PKyfxKX3PpZUL
	jSyRFeesDyn6kOUV9w2t4r3v2yhTTIJ1gXqtlYXjWUcBoWLzluEfj0l2I+wrlxV3C7FlaUbfHqF
	a77Tclx7SxQ/BNiCgMMw57fwUX0kNl14ZoPNiTl7u9/tu1uu4c8krQgPGkdfOXA==
X-Google-Smtp-Source: AGHT+IEm13cjiugy7XuAIW+P9b2o5Cd5XUd4XiK5q2lg0SVIDNo6FzyBDbmahI53s+ujJtYxlmkOUw==
X-Received: by 2002:a05:6a00:3e23:b0:748:e150:ac5c with SMTP id d2e1a72fcca58-759ae1e7120mr19076238b3a.23.1753111453429;
        Mon, 21 Jul 2025 08:24:13 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc680b6sm5852175b3a.133.2025.07.21.08.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:24:12 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so3708618a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwOpyDsoEkcMhRUFAbIqK9WTL5ELIDVeEwbydFvh0j0L0pulg1anY2og2PyVCQ/k5j59RTeHAZU/JYRZE=@vger.kernel.org
X-Received: by 2002:a17:90b:2d4d:b0:311:c1ec:7cfd with SMTP id
 98e67ed59e1d1-31cc25e7a85mr18598752a91.26.1753111452054; Mon, 21 Jul 2025
 08:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f7f3b5d636@changeid>
In-Reply-To: <20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f7f3b5d636@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 Jul 2025 08:23:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPdKK=AWBag=q8PitEfgkopOdACnaMaNhDeS7N54Vn9w@mail.gmail.com>
X-Gm-Features: Ac12FXx1Rt4jqey2hZlgCizXtfQmsGzgS11Zc1tzIdan8gitLdT714tk0LDKMMk
Message-ID: <CAD=FV=XPdKK=AWBag=q8PitEfgkopOdACnaMaNhDeS7N54Vn9w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()
To: dri-devel@lists.freedesktop.org, Jayesh Choudhary <j-choudhary@ti.com>
Cc: kernel test robot <lkp@intel.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 14, 2025 at 1:07=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> As report by the kernel test robot, a recent patch introduced an
> unnecessary semicolon. Remove it.
>
> Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort c=
onnector type")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506301704.0SBj6ply-lkp@i=
ntel.com/
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can't land this without some sort of Reviewed-by tag. Anyone care to
do the honors? Jayesh, maybe?

-Doug

