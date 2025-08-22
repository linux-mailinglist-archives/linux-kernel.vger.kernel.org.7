Return-Path: <linux-kernel+bounces-782694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78230B323C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C448B05AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA892D838F;
	Fri, 22 Aug 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b="K3K2zKD/"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38A2D1F42
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895466; cv=none; b=UfDdnfl9PNTnoRgujJB3vTgz1X4SURb/MzgZajqWOQ/3723WCNaff54IJo68d+ooZFcc1EgxXRw9e+bow+hVBCwbhZtRDX3gJPHeRv+gbYmF8FKCEksWhHQP+5G3NHlDWWmTCYFurbxMCMZFYCWVp7HSKNaS+T3/TLvZvXqRYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895466; c=relaxed/simple;
	bh=ZOqglHGNAfTTYJ7NDuA/b8Wo2BY73y7roGqiI7tuX7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF7QEo9gj7fONFfpdVGbyciFqt5ehdtV9Ao63u56G5aHgnKq6Yi0c/M2YpfdfmzTF3dwOLC+kZnUFuD5MxUVon03PnUI3MlI5uVTvHdd9spAbBYAClvaL/Z0gf0C4/xWe88mcSSRjyj7AEDSxYi7it4o/5Pk6qviLLQyGUFezVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net; spf=fail smtp.mailfrom=gfxstrand.net; dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b=K3K2zKD/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gfxstrand.net
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e69f1dso2763667a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gfxstrand-net.20230601.gappssmtp.com; s=20230601; t=1755895464; x=1756500264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ITqkT50q+m4T1anWHEezwcrjeL1XAGQxsPrHmnZXE=;
        b=K3K2zKD/xKNjr0SL2DVjNkRCgZ2K/t7gOAKZWFCP6I1cNeQJqMMlaVf3CpKtmELQ4u
         QPAHVkIWCKFF9bVO4TK/nlDrDs67U8J4bztdoEIKu+TKT1H5/gI9DkkeaCZXTuCIFt9R
         rv/pFto5NvZoBlppibmSn/t47s7SMBTxb3BCbaYxIq1GZW30eqZFAJUvEsyOx56xEEvl
         dBLdILuH6Om7XTEsDa2mRwk74c6Wa6E5qngMOebfiWZBQNAK1F+xbAEsfGGwZNn9o7iF
         9dZh+83E2CbPCqSA6WitDPxtxBuKHWpsBS1PyqiY5JWND/CNIkOwTlRVBu+BlYca3QpL
         M2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755895464; x=1756500264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5ITqkT50q+m4T1anWHEezwcrjeL1XAGQxsPrHmnZXE=;
        b=Am7VctksUGS7wI4rv7ePXBb++qh4oVH3kPJ1wMfDY2fednkAHrpJnt2S/5Xwypslt4
         b0Z9jAvoAtAxhw3a6CShwXTJ1zLI4lG17ErYsNVRTgguCkOGTlS1sQq+uEMgHN0TtRiD
         vhrNMNobCvl3k0dxMuEG/js//tmbcb90/HnksEQmK0EFSgOdbeVo6clXhGVgstjfzfUu
         bn/QulGRQf+XZ51j9r7+6zW8nU4r5khWhPNVsn2Ml59p9FNN/oVsmyx79YYS3E03Bfxa
         7mmrZY424+0TelXvtee1fw28/deA9vdgfWg6NYrC5nYG11EHwXi4GTYsg0U4VQ3kKS2e
         iDyw==
X-Forwarded-Encrypted: i=1; AJvYcCWhVa0mY1KqZw+Ra2rh78uJE/OrNzUIXVRNrg3hl5ss85K42KfH3Ar2s2dHwigbBj8TVsw8DGnHu9siC3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegKBQGrhA3v3LHJmAmnp5Mc5tFEZxZ0AlStQpDSpGj+xkpEkt
	96FpbS5BXxiHyf0+Ix2lQSuxWVsgwlfkRX0/ugcaWPc+scAoH4X/EpmIIFiGJFgMe0A3JSLCE18
	3cBaTTkohtDbsgeUIkyoWlwHnkNlXZZ5QWSyyN+HSc4zgCGmZwm9xGhM=
X-Gm-Gg: ASbGncv1aLpTQDCY2fIwPTUnmQlGrH2Bmy60EijDadFaNuIzMNcf2P9dlvdt2uiKQFB
	cufhXTjeOZfDfBNbtou83h7zSD/6hdtE2XhQgQ1mlOQ1vGHUIwiFrzjSmZVXE2HLH+9xSFvXALu
	FGuHqh5TTPwuq2iHBCov0pSwR5Ok6Mm/IbO3DlxNckFNct7ZgKMD85YG6mdqAPZDNcMwHaVJdd/
	+fc5+Q=
X-Google-Smtp-Source: AGHT+IFTpzOZWfzIfZ6aN86j5dGy9+t8X2AWl9e5HS+Cov9GjFJp/s0Sqsh+erThOaCtBqoKlWVXVAsBpE/sHdqOctw=
X-Received: by 2002:a17:90b:1d51:b0:311:e605:f60e with SMTP id
 98e67ed59e1d1-3251774b34bmr6269470a91.20.1755895463766; Fri, 22 Aug 2025
 13:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811220017.1337-1-jajones@nvidia.com>
In-Reply-To: <20250811220017.1337-1-jajones@nvidia.com>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Fri, 22 Aug 2025 16:44:11 -0400
X-Gm-Features: Ac12FXzMjozDkVA5Izgtx2pdN-ajBpFeBw-jnrsAAZtPGCcPbJCcjgOt-BOScks
Message-ID: <CAOFGe972S7S23LGKxEmVq_beyRMpDJE-2rMt0aobPj4HnmWSXw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/nouveau: Advertise correct modifiers on GB20x
To: James Jones <jajones@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:57=E2=80=AFPM James Jones <jajones@nvidia.com> wr=
ote:
>
> This series adds new format modifiers for 8 and 16-bit formats on GB20x
> GPUs, preventing them from mistakenly sharing block-linear surfaces
> using these formats with prior GPUs that use a different layout.
>
> There are a few ways the parameteric format modifier definition
> could have been altered to handle the new layouts:
>
> -The GOB Height and Page Kind field has a reserved value that could
>  have been used. However, the GOB height and page kind enums did
>  not change relative to prior chips, so this is sort of a lie.
>  However, this is the least-invasive change.
>
> -An entirely new field could have been added. This seems
>  inappropriate given the presence of an existing appropriate field.
>  The advantage here is it avoids splitting the sector layout field
>  across two bitfields.
>
> The chosen approach is the logically consistent one, but has the
> downside of being the most complex, and that it causes the
> DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro to evaluate its 's'
> parameter twice. However, utilizing simple helper functions in
> client code when accessing the parameteric format modifier fields
> easily addresses the complexity, and I have audited the relevant code
> and do not believe the double evaluation should cause any problems in
> practice.
>
> Tested on GB20x and TU10x cards using the following:
>
> -kmscube w/NVK+Zink built with these patches applied:
>
>    https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36336

Both the Mesa and kernel pieces are now reviewed so I think we're good
to start landing. I've independently tested with kmscube to verify.

~Faith

>
>  with various manually specified formats
>  and both manually specified and automatically
>  selected modifiers.
>
> -drmfmtmods, a tiny test program that lists modifiers:
>
>    https://github.com/cubanismo/drmfmtmods
>
> Changes since the RFC version here:
>
>   https://lore.kernel.org/nouveau/20250703223658.1457-1-jajones@nvidia.co=
m/
>
> -Dropped the helper macros & static inlines in
>  drm_fourcc.h as requested by Faith Ekstrand,
>  who noted these aren't helpful for UMD code,
>  which is all written in rust now. I may re-
>  introduce some of these in a subsequent series,
>  but we both agreed we do not want to delay
>  progress on the modifiers themselves while we
>  debate the details of those cometic details.
>
> -Reserved an extra bit for future sector
>  layouts.
>
> -Fixed handling of linear modifiers on GB20x
>  and NV5x/G8x/G9x/GT2xx chips.
>
> James Jones (3):
>   drm: define NVIDIA DRM format modifiers for GB20x
>   drm/nouveau/disp: Always accept linear modifier
>   drm/nouveau: Advertise correct modifiers on GB20x
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  3 ++
>  drivers/gpu/drm/nouveau/dispnv50/disp.h     |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 25 ++++++++++++++--
>  drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c | 33 +++++++++++++++++++++
>  include/uapi/drm/drm_fourcc.h               | 25 ++++++++++------
>  5 files changed, 76 insertions(+), 11 deletions(-)
>
> --
> 2.50.1
>

