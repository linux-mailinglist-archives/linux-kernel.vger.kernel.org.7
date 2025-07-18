Return-Path: <linux-kernel+bounces-737189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0974B0A8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C1CAA115E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB52E6D3A;
	Fri, 18 Jul 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K36cj58q"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB17D098
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857223; cv=none; b=OTeCTQek1uaFy60vsqhhHax9JWdNYLosrO0b9AVW/+TT8jzu6rPYuIBvlutiNEvh09/ra3VUXPQE4AdXH55JHQHTonRAhbUFuYnXXfG8O5iT38gqg1hSIAKmdAerHbX/WEpY57WuNt8WL+VZvHT3OPAqjeI9oAPk2hO6rcIaJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857223; c=relaxed/simple;
	bh=Yzvz/c2kozBYaPV4ut9MpazKx5SdGrl+oixR++PM6Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVZuAEzGedchkD8fWtZ/wF61z1j4cHuXO65wfhsvZ9mGVCdN2j4cLMDy9jcgkajP1NWpOL0nOP/9tytf74xaELYKMG279QF/IPMlyTCZfyj4nghzSttiZGMUaK/Ql/2Bi3lAsiPV3ck9rNKCT+mb2WbOXO4AixEYpVipdizppWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K36cj58q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8f163476so1863785ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752857221; x=1753462021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJsP/eoaDosNoXGwzPMM0imt30ENxWHLuIS9lVwxHA4=;
        b=K36cj58qwM/9qbrwR5TjkGy/UR7eOpaJj1PyC/pRJmy5+MVoA20eTJ2KKJM/960Bkj
         FU9CHJY6hkookg7fl4TwGRtZeiVRb8z3Mn3tIAdOcb1Lyet8du831bJ3TC9acvxS2qAI
         c7IKRtcwLg/ez8r57znZAG5wIg1PKpmoCPQMW8bGGmT7LPXP3bRIMCqtOg8s3CBiFhiT
         xZY5N3uj3FQEazTr+gj/4TpVSSDAZhm9LtXIfaBVqhJynOT+uK/+P3IEUR05grRYPBPk
         BWmKP/8J+TEqBWrszsbHFClxaA4UC89fohdwsEmCISUuKg7UHtsGV0ghtNel0J7VgfSu
         PCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857221; x=1753462021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJsP/eoaDosNoXGwzPMM0imt30ENxWHLuIS9lVwxHA4=;
        b=gOz1O0djZ2qCvPPbEkdpB7sPG9NTv2GNm/H3k9TOcvWQml6fP4oV5WqsQr3j8foLLf
         yg6eBWhxD0ZDRc65KDr3mmlixZ4x31+GhHI1vyNlPj+RKKF10dZ/eEp8DROxCQdTQzLz
         4CzswhtfVzf2JW4dyIuY3zVNh/wnwmflWxodI+AkbcODmIkM6SQj2iikA2FWwN4Y4Ca7
         DL+5qXEUzu1roGdsloDfM5q/C4QAqz197Vmh3P3Ue96is431PIaiz0qLPlUxgxL78rQX
         8M2MI4bedMlWpLtCM3Y7VClcJZVB+Zwqzlv9MF/jvSzjmkOEpSNF9d7O2qAE+Tciitam
         SYBA==
X-Forwarded-Encrypted: i=1; AJvYcCVnbX9csHybKubWlv8kS7tMffEAX77SwZRxMpR4Bcsjk6iVOZLjlLLzyzly+82H/6btpSrHOe8a8M1lilE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszLKZsDpb2VSy0qyL5y44S6Ay5KGW/Ft4/Z0RN4LzWfK+g76d
	redtaJr5Ge04kCX41RHFBZoLQqz3CWQQW9J5FPFlgaDrcrzmP+xj6kIfmUgokBNaUMPZnsoOOsc
	qdPGiITlXWeLb4R8fd8kZgvUGf5gcA7E=
X-Gm-Gg: ASbGncutZGTdQm9tSCAZkTaj7fkgfn2YyguxdNonB1hhJSbHCN96rCfBTEaaO74SWpQ
	8IINzEyMzvBDkMiazDvgawTBzlVtStP9tA9KB4EeQtslxqJ2Ehn6TQug5OhueLKMvQftYVoz5iW
	xdmXW1TQ83f92mOFm0WT00Pp0TB8DcpdaRhtnmc2eaOiiX0vciWuEG+vGLWJbCrDjI8O5PxYQ8P
	N8LgYg+
X-Google-Smtp-Source: AGHT+IFOuDMPJrT1YCbFfuqwvYmjK058Y/LsXdNCczy9B2FmndCQNYcZwQpniaR39y9/uG9+M4sTO5ZsP5LXB18KwA8=
X-Received: by 2002:a17:902:d4cb:b0:236:7165:6ed3 with SMTP id
 d9443c01a7336-23e24f4c2edmr64356245ad.10.1752857221373; Fri, 18 Jul 2025
 09:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717204819.731936-1-mustela@erminea.space>
In-Reply-To: <20250717204819.731936-1-mustela@erminea.space>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 12:46:49 -0400
X-Gm-Features: Ac12FXyn8h7SRjZg184zAY-fazXhgQky6QNND2dxKcl59Lhu--Q37Qp2D17REr4
Message-ID: <CADnq5_N++cfNqzaft003nJhqkyUbMQFYcM+ioM5yh_JNrnV5oA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check if hubbub is NULL in debugfs/amdgpu_dm_capabilities
To: Peter Shkenev <mustela@erminea.space>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Jul 17, 2025 at 4:58=E2=80=AFPM Peter Shkenev <mustela@erminea.spac=
e> wrote:
>
> HUBBUB structure is not initialized on DCE hardware, so check if it is NU=
LL
> to avoid null dereference while accessing amdgpu_dm_capabilities file in
> debugfs.
>
> Signed-off-by: Peter Shkenev <mustela@erminea.space>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index c7d13e743e6c..b726bcd18e29 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3988,7 +3988,7 @@ static int capabilities_show(struct seq_file *m, vo=
id *unused)
>
>         struct hubbub *hubbub =3D dc->res_pool->hubbub;
>
> -       if (hubbub->funcs->get_mall_en)
> +       if (hubbub && hubbub->funcs->get_mall_en)
>                 hubbub->funcs->get_mall_en(hubbub, &mall_in_use);
>
>         if (dc->cap_funcs.get_subvp_en)
> --
> 2.50.1
>

