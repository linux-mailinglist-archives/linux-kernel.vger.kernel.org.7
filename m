Return-Path: <linux-kernel+bounces-840470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E684BB4814
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D2D7A21AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC45258EE1;
	Thu,  2 Oct 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntM32JZY"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8320259C94
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421914; cv=none; b=XA2On2Br+JYm+6Y3+Kw4doohbW6OeH0i9zgMQ2hjd9ncixdOfmCMS7lVcsg+d68Lvfn9yzog1J5n7ZHDxrzCGRmOnIX4yTdVvv0CyWJfcNvHQKXre1VgwhfAf9KE55ednv6cIHjp0iQIco3Rz9N7ZMqAZ2sSY8tZLDh4iZ6Y45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421914; c=relaxed/simple;
	bh=aLH9BCUCK6JFkv6xyUlkoPUhsi1r/cg0UwxlEtbgTww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otk8bNo7JxEhYK7JEtaWj3DPpZsE/Hu7hmmOkOdzeB8j/zM10GI0sYeWX3ZYm5UueOm7lgNBZeFdgdhLpM0vRWOQPQ43cK8n5j+aQLaMXYR9Fg5bPuNNsuf1+WPk/dOPnJTDaNQ0UoDiHyvisqzeRI69U4Y88HROwLDk23O/UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntM32JZY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1372482a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421912; x=1760026712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs0gCH7mhvaO1qaWvoNXBT3MrPhbI+ZP4G1QowHi4cU=;
        b=ntM32JZYOV98CQiB502TF5RPc4tOmcxVgck7M3aKAkGVn8suHkcjzqF1vYEpMKx/ZZ
         InqoKTdJdCMrbk11L2bdhuT4o028GnExmDvdRscX8TD/9kM3PklVSFRoevRT9bgqUnDz
         z5joPOlpMf9YcjWXSk7VCxv7wpkQbCUJZ7/efW6P/W1w5QYdT+fzWt3DKY2B9CiI9k0u
         v2B7hZIOzGvcujxPnnGL/ZGJR92Fp2knXa7wNed4bsmTfZ2v7+f6eKX9thDP+i/IJlMW
         EjNvHYxEpMxs+0zsQHDA9I/6MtAa1FHQlqVVT/B/1mEwJL39OhDL2osCnf4Dx3K5Idnr
         Mn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421912; x=1760026712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs0gCH7mhvaO1qaWvoNXBT3MrPhbI+ZP4G1QowHi4cU=;
        b=sSvdkSg+TZPAfAztwsv1bMMdu1cXFf6pBH4COsqdPNMEIbvbuwMHKf1GNIvd0Pzx9B
         UE5Q8XzdQO6MrOKMYYKQ7t8X7dYAR2d9vU965XW8KIumwd8nDiaaMQtL1PMvP/3RsbQG
         JegI+mccHftOK8w5fwUORpgWpAFd/fA5DHJ+5FgLLXO5XblWB0HHvLIUO5ypCFJgn8hy
         eLwmmyMuWshilH1COHPUDnmKq7m9RRhrYVvI+Px5e7yTyAftZL6MbFEPX1wTmrdzMv2l
         TiwPR8SPQZSBFBqCbo81whik3FAZuBJyUHM5QiLAhNT6rhOSiOftJkc2ojb0+Ti0en75
         iSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSh84nsh5+1KMKgs6+zyJChmacTVjSkjERfq3iod2MkENDaEvRKuHyAfS38G2DmTiZx5n+yYy6zstj1SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpHWtLXoM3GRhiCa/U6d7i8reKdO9hlB2E78u0+0k0mVNhgTL
	/Ah7485J+1GVHIfVnfso0Gro8DZyQdGluww2iWsLutk3aJywUZ9QbEvaeFlDfjNepzaMH1r6SuE
	XdFE3tiPFAqUe3za7PWJDlkN66ZpxALo=
X-Gm-Gg: ASbGncv6cJMVx+kyrn+uU/PD/mq9UwHfH/bWTGSvvM7jx2OG/yz3fQlkLohGf21FObG
	63Uy78NGVMlzQ2mStY8yyfGwSKX+BA62Vx/04Lp3EpS3XuEiyzTjGGndlXMMfdwQvUp+8nDi/DM
	TQvzXpyHYlunelcDiXUpQkGceXn/B23IcC/LdYzRmESS6FAU0LsrlDhwb6AA3pCjoTgWRn+9xo4
	zLYq+XzOhDk0gdjy+RN2L76G27JXmw=
X-Google-Smtp-Source: AGHT+IFg+PLUyWcoSsUAUf4htH875wDYY+hRdnGTted2LRpK1PJKUcMRnSKqqpUMk+z7FMvgEMVUAaitgkdEcJV3rx8=
X-Received: by 2002:a17:90b:38cb:b0:32e:ca03:3ba with SMTP id
 98e67ed59e1d1-339a6f2e679mr8142326a91.22.1759421910494; Thu, 02 Oct 2025
 09:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
 <20250821-qcs8300_mdss-v8-5-e9be853938f9@oss.qualcomm.com> <iza3iyj6ztuudm5rqfrxtalwxfghzsguf3pieulylebdblq7sw@divpjvwwvmsg>
In-Reply-To: <iza3iyj6ztuudm5rqfrxtalwxfghzsguf3pieulylebdblq7sw@divpjvwwvmsg>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:23:27 -0400
X-Gm-Features: AS18NWDwyTbNJJLg_4zVrM-EyYlDVd5QGpchaU4fwAQ38Pf7WEw2ME2yXmyyL7Q
Message-ID: <CALC8CXfTA6bBN-ZthgRoPXvv-BZQtvL7w7a+6bgTe_GTWnnfHg@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] drm/msm: mdss: Add QCS8300 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yoongxing the Chinaman, and Dmitry the RUSSKIE; Conspiring.

On Fri, Aug 22, 2025 at 6:39=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Aug 21, 2025 at 11:36:00AM +0800, Yongxing Mou wrote:
> > Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.
> >
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_mdss.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
>
> --
> With best wishes
> Dmitry
>

