Return-Path: <linux-kernel+bounces-878525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE08C20EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3741E189F24F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4936335E;
	Thu, 30 Oct 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUQRY7t1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EA340A43
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837635; cv=none; b=jOku6WXWOE1hgm5gnI5VkDtZm6jOngifnynCdu0e4KbqMsPSmHrgiL07iSMvxP9qsYXJIT+dGYHV+0v6xZ/ewCDU5t4nmM/qoNUgE8Rraa9rKnwI9E8gfGXPzc+7nhMjtFvex+wacBoUH1mNt0nhv8fnx88To/YtjqlGf/USgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837635; c=relaxed/simple;
	bh=w4uB2bW2s6Cntxz/yJTQthIddw38Kx707i4y6i/lOSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN6v0atMKQ0G1dYBRo6Kqf0lt9RogrGhm24i/WJtKjaajqn4aL9/0Jw9m1kNKLB93MN0lm5VEZ2IwxsTyeewN7h2fSEbZLNs12ZANm70nfU6tKYruQC7Uk7OiMTGM0tDSVc1QvckF2c3HlujL8VHdVys7cmwvej1OqNeHyJkBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUQRY7t1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290aaff26c1so3344375ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761837633; x=1762442433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n2ZAbC/7CporyooiQ9y7Oblbi4ys3ElhAZOq431qrQ=;
        b=DUQRY7t1Ca8qhDMTmy/SPTGcQC8xbX40HFyvzi71RzUr29CieLvhSLiaWZFy294bq/
         dIulEW4VAiG2Q8rEPe0n1FGKBJlPW/PqCOdhLD7ywLIlkU/PrZzx9lc5Y0UL5kZvw+WN
         AJFcS556YD7VipT/cMMn+3sfLp31osnOUTSRfn1riHs/KmP8pdsaV1VshBoqtNg7FtEz
         CnGDRKGBU/pH0ACMjgbVjz0pBEoMFPHF6LmxtNVbuB9NvLyP3lqdOxghWsrc8+dVj0jS
         WinjsaY5W2+bcsK1y4tplIOVVcvLCvDT0f6kfB53NOIdC2Fjv0WwY2kMxmQa0ZSP+rks
         AfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837633; x=1762442433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n2ZAbC/7CporyooiQ9y7Oblbi4ys3ElhAZOq431qrQ=;
        b=YjqajPwg0pGYnXkr4Z0jg6SAL81UcMGJ72nmVVX4vxJ5FiJpnsxgejWXJsweDZ1k4u
         MM5z9Nk44RAR9SoqhNOA8vt6ZNWcbOlhNYkS12EuWn84z/8JFqn+Sk0FWsWQzQtpDMIu
         GoePrkc/VjrhJiv7nyCNYP7eH+PaX/Td1/Mh6IorMPzjPFFXlXhEDDPDYrCn41IURcJ1
         CuwjPMHbamEJRNxXE93n2U9vtEUja6PBCTGvxy4e3FYCnybgAL7oQasxuVdG6NkvIP0x
         Qxdd970wmvbBrn6t2UTWSideXFqcOqmCjUpXbZPyXJKe2Zx9LNWXeyDtrTcNqsKoD4qN
         GAxg==
X-Forwarded-Encrypted: i=1; AJvYcCU/UvZFtqZvwITG3UyhdDsd7gUUjefC70sMcMexPhfG9xoal1RpG6vUJhhCLtBJORVTCw0uDn0Uw5VN9ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YySvldWHqFBQfRD311Ro1d/U+c8SOh4jg7u+dLmZmMurwh1sWZl
	gLSBiCetE1ty2ALW5L1DtW0uFPNYEl6hqWuqprFt0EaVxIKezzK5p8sxvkwzcMrjlqBrFIXvfeB
	kIjGneLToNF5ZkHE8xDwWURIKsUO/w4w=
X-Gm-Gg: ASbGncutaPIip6kTMd7mGn7otgSdZk1ADRzijshvCA8dmOwPtH0Ck0qRd4/YZvpV93w
	B+5kh5BJUwU1L2//+riJsqYyMqQ8AmiOWhfbtLk5wZRkkzRcX+qu/QpnUxhtmhUqIU3ld4Yt8Xv
	2ofSJlwNHVLhPTjWntjw7sZezU49qWtxZFy7AuuekKuEbzY3DfjGcup5KP0vYN5x5kEqiYMjWAj
	BWWsI0M/rMRTA56EbQ2XAlO5rwh0BtoU1GirfLk0dL0X6+7fwyU/VS9IjkC
X-Google-Smtp-Source: AGHT+IFb9s2heQmxBOs16F9sJ4fOGsoBxkOFOsxPxU7gqSkUUjW9axA4peKPZGOc6kGJhiEtISZ7fWFZ7zDcJ9fzKU8=
X-Received: by 2002:a17:902:f395:b0:26c:3c15:f780 with SMTP id
 d9443c01a7336-2951a49dd38mr397265ad.8.1761837633262; Thu, 30 Oct 2025
 08:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030143737.136120-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20251030143737.136120-1-lukas.bulwahn@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 11:20:21 -0400
X-Gm-Features: AWmQ_bmVii5Alx1O5jsx56pQkAEpJlLlfevil6R4SK7ejJJXXuksGVL19-p25ec
Message-ID: <CADnq5_OR72MJvXHTGzzW-oP+z8X=7vQiCpytmuBJNsN7=Tw=pA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in AMD DISPLAY CORE - DML
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Austin Zheng <austin.zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>, 
	waynelin <Wayne.Lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Oct 30, 2025 at 10:46=E2=80=AFAM Lukas Bulwahn <lbulwahn@redhat.com=
> wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit e6a8a000cfe6 ("drm/amd/display: Rename dml2 to dml2_0 folder")
> renames the directory dml2 to dml2_0 in ./drivers/gpu/drm/amd/display/dc,
> but misses to adjust the file entry in AMD DISPLAY CORE - DML.
>
> Adjust the file entry after this directory renaming.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d739e18aab6..7031ee1e7cff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1080,7 +1080,7 @@ M:        Austin Zheng <austin.zheng@amd.com>
>  M:     Jun Lei <jun.lei@amd.com>
>  S:     Supported
>  F:     drivers/gpu/drm/amd/display/dc/dml/
> -F:     drivers/gpu/drm/amd/display/dc/dml2/
> +F:     drivers/gpu/drm/amd/display/dc/dml2_0/
>
>  AMD FAM15H PROCESSOR POWER MONITORING DRIVER
>  M:     Huang Rui <ray.huang@amd.com>
> --
> 2.51.0
>

