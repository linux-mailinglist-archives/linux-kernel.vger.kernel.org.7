Return-Path: <linux-kernel+bounces-788814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE1B38A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2387B3413
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6A428314A;
	Wed, 27 Aug 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVe4QBtc"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B261A9FB8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324978; cv=none; b=LodaQ150ZAv+XWWLsoymujonvAvncC63l3PkJtJeTvMt8BbzIjuXWtsBhkPxLor5SShgvfxrjT45uNp9QfPQUsWd+NsMk0ZTDSmFjEKQYCxccMqE0O3tbW4CaGfHRq4edbEASfkAMGaW+LV1vRYCJMyqo2Q6wb8lSXmZhaGfO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324978; c=relaxed/simple;
	bh=098gPNuQNqgbt02tHBbfUhvP2c9XiLv6PG0XNmzJ/aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R732BZpjrnug8Tc7qW7jBwN75CgdmyDUpNvEiQRNV4sizYH/qU5Z9+ImN7rumpS4aY9SgVAQJNeBFoAuW2WaQvJqGhISxJZEAD9a+MmOeDPmiqXbjoDC4R55qCLUYbWfOn4IzyKQlNMJ+DUvoc60XE/ZeU1+Rfc+FVfrkMOWMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVe4QBtc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47174b335bso41382a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756324976; x=1756929776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03D+2LYm7zurX8AnYGu/wk2IacpBPh1XUHSL4lr1KJE=;
        b=IVe4QBtcij2xqm7W/irK2kp+MFj1iSKPil/hDTBd9+Fqk8qY60NVbV98kkqlI7ai5R
         cXBtxpaOPkrC+K71p8Iqhbf9iB3mk+dbRjTKFEJmK8LlM+N/OL88kQ7c3uOAwurutInO
         tA+U4wwIQ2PU78KRMjKjzLT+3N+KZm9klQOug/fWavvaqCwCbDvg9L+Tuk98LuZjdgET
         zv9GTo5ak6zcRC2wamfZWX5rkM0cGI2HK75+PMMPMHzVPj0V42avpt293JQSbwuk2ksL
         Rahh+ou5cN8XmcYXwXd4xVKVWnDFrY9nIcaQeUUvKtAS5RrI6TY0oJ+xQsCq3hsNFpOs
         Zflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324976; x=1756929776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03D+2LYm7zurX8AnYGu/wk2IacpBPh1XUHSL4lr1KJE=;
        b=GcNdrxxd+QmD72IKOu1c+ljye3xe9OPaGeqtXu0MTh3yo/PQ3HAl/vtl5ue9D/1Iip
         L89/MI6XyMHRzMF3U7IcBJwDI+Azhr7de7GCujRcmgv4EVy4lsN5UQAkTZvY6+NMtl4L
         mH1GCy+dSxggaMavA0b6Uj4pOfP550OCK6Yc3p5evLZl2kRt8yzYjY27u32rhMpaf0C2
         TPLxj2hEs7ZAliLOIY93nh1LvcLK/BSVspMb+9ox+R2SkBIlkcf6mGxZe6H/3LJ+bs9l
         RMy4GsInKC6Go0PAkhAOXQOoXpLfAMQHE6TP6DgnGuNZTviJLFZu346lMSyVjDByF5U0
         SQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNdRs7C+zzjv9ckE4GgVILb9xXf5q/cr7oTGr1j9+PqsXKtfXCz+PVTEVKDb5QL7267tddwI5FQlnV+Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7QyX8Qkp9CpV+kTs9LtYtwUmnu5dhY5OaMcoNbweIqdcxx+N
	c9VFKcUBmmxWYqW7No8RAP6yNBk3Naj7FlOQP7pczs3MasLPmX9loLipG4iyNW+iA+znUCKAgAQ
	8WzK0e1tmi/t4IYcMDyKK4IKbdrVI2zw=
X-Gm-Gg: ASbGncsrp1xfwMWviquAUXKHEdNWAvRqwHiNYMf7hHh+RrKXN3odZHTrSq/2rE3/kqW
	MAavOqNc5JkD0tFCrd5SVql4nVu1tlSDidrBoaIq5TBoODVa1FuiUguHIjN1WGf8UosKJNk/shD
	UNdoU0kiUnNsHdi438m7lNdVzfxHPEdnbV455U9puOMnLUkh6VL6a6179LmhsY9TT5G+nud/ZW2
	52i8Ek=
X-Google-Smtp-Source: AGHT+IEYFxWIgkdasxQf+IqktH7EkiNxyQfhIsOS91kQxAAB+MMtmKC9Wu0UsNftG/lyhfkhu87LrER8trGcFO7AX10=
X-Received: by 2002:a17:90b:1d09:b0:325:33ac:bbef with SMTP id
 98e67ed59e1d1-32533acd3b4mr12840525a91.6.1756324976307; Wed, 27 Aug 2025
 13:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823202540.487616-1-kavitheshnitt@gmail.com>
In-Reply-To: <20250823202540.487616-1-kavitheshnitt@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 16:02:43 -0400
X-Gm-Features: Ac12FXy8O47figQjWLIUNnDA1-9CpOu-ir6quXNMsaj0Pv3UTLbQ2ytf5uUvHIU
Message-ID: <CADnq5_Onr6rR12NVagwMHURPfuQxBoVq8Qhui6heH_m-5eHsXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Document num_rmcm_3dluts in mpc_color_caps
To: "Kavithesh A.S" <kavitheshnitt@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sat, Aug 23, 2025 at 4:25=E2=80=AFPM Kavithesh A.S <kavitheshnitt@gmail.=
com> wrote:
>
> Fix a kernel-doc warning by documenting the num_rmcm_3dluts member of str=
uct mpc_color_caps.
>
> This is my first patch submission to the kernel, feedback is welcome
>
> Signed-off-by: Kavithesh A.S <kavitheshnitt@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 59c077561..06f05979b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -234,6 +234,7 @@ struct lut3d_caps {
>   * @ogam_ram: programmable out gamma LUT
>   * @ocsc: output color space conversion matrix
>   * @num_3dluts: MPC 3D LUT; always assumes a preceding shaper LUT
> + * @num_rmcm_3dluts: number of RMCM 3D LUTS supported
>   * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but sin=
gle
>   * instance
>   * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
> --
> 2.43.0

