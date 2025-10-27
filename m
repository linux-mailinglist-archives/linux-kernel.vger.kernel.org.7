Return-Path: <linux-kernel+bounces-872530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A5C1162E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B153A4E79FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D93E20B212;
	Mon, 27 Oct 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWofA5oh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE5221DAC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596776; cv=none; b=a/2daUsNB0WjKeakpZPb7pQZiw/rL7vZP70PS9Sj+Vq/H0A63QEuroLGaBResrLVXLnQ7TnPD2PeIoPFnSz5bZBvFLD1IfcztQcep6SCRIwr69Getqza0un8/XGT/5VryCge2jhm3BwevimmCJe9V/R0eWxPs+gpoGORGDAC4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596776; c=relaxed/simple;
	bh=UJ6MmkxbwNihwhAWkFRhdgi3rLiRJ5FOlBCHopS8LMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1mCWDFUin8YBSYT5G0EpObLwRX2siVA7Nx5THRBbMpOl8FQC4nJaC8BuAXo3L+r6Vv2LTiv/4/h2QRhjdg92oRDbhHb1Ypoc6D/zjlhIt6cd7A3EjO8qBVS76wLFazu4aCDG5svqldCPUaJJZjWl4wJzzt3bowvhz7YCA3AYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWofA5oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4F4C116C6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761596776;
	bh=UJ6MmkxbwNihwhAWkFRhdgi3rLiRJ5FOlBCHopS8LMM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hWofA5ohRf0zlap1Yx3dfPfsYAjFHzHmbkX0tchEDP0SMA2VI3/S5vBr5tIh1P0VO
	 pBWM8yvcCg/dtESJVC70AHbbbMXK5/3iqrVM41GVXFq0118s2iFoTpDHv0/pmX38GD
	 B7aJdXXKxbNsVCoxq+uDxYE6fFE3FJKUTXxbdPHAFXEF52Hm78AnNNc5V8Q69pTMi4
	 tvRqSPZVQXx0cdOSg+97j6RsKnM9lFXONa56a2i6DrqxlXjk2xHs7WT9Bbs9NjRAd1
	 2L5+gAZnlbyC7PankEHxeqm2E6MElh6zr21HbbfZrOVzMQIBgn3ctswlFpNI9KewXT
	 jAWHncaNYzMiQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c53908e8b5so1217450a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSKA2hSVOIUG7CBIl5ikduN69J9iUHMzjo8EDvH8y0yuF5rUJnGugN2g/MmM5Op/f+EHt0HSwR1FleJLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpcACZReH7894xSK0zi8Prf4qaf/lDBVRzP0PjLsAJRx2MwXSt
	8fHaurkFArlAD8kEcSEJlfLkQbSSodjIwBJ8ETtdi9R7mwdIJ+frIilPExjXc+A0SMOubZy5DQF
	oIhAabmvF15LjnMtj5sC+aj+MrwEJ5vQ=
X-Google-Smtp-Source: AGHT+IE9D/Es2uxgo0RZaaHln7lBhFVmUzdgDvDqUNNXq/SfZLMveyNlMgTOcnrqhFYu2i1d8G63X4JEoe5CjH+wt1s=
X-Received: by 2002:a05:6808:4fcd:b0:44d:b8fb:53cb with SMTP id
 5614622812f47-44f6b9a9313mr491212b6e.6.1761596775578; Mon, 27 Oct 2025
 13:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026164422.58128-1-linmq006@gmail.com>
In-Reply-To: <20251026164422.58128-1-linmq006@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 21:26:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hsJaK1DkNu7bRTBDH3U5seT2fmceg=CVpekK_QsVtS0w@mail.gmail.com>
X-Gm-Features: AWmQ_bkTU4NdICPyyaKCzsC2sDArHDgS5akUzg9xK_GdVIhm4dNrpn04nphu_7U
Message-ID: <CAJZ5v0hsJaK1DkNu7bRTBDH3U5seT2fmceg=CVpekK_QsVtS0w@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Fix reference count leak in thermal_of_cm_lookup
To: Miaoqian Lin <linmq006@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yu-Che Cheng <giver@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 5:44=E2=80=AFPM Miaoqian Lin <linmq006@gmail.com> w=
rote:
>
> The function calls of_parse_phandle() to get a
> device node, which increments the reference count of the node. However,
> the function fails to call of_node_put() to decrement the reference.
> This leads to a reference count leak.
>
> This is found by static analysis and similar to the commit a508e33956b5
> ("ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe")
>
> Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bi=
nd()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/thermal/thermal_of.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1a51a4d240ff..932291648683 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -284,8 +284,12 @@ static bool thermal_of_cm_lookup(struct device_node =
*cm_np,
>                 int count, i;
>
>                 tr_np =3D of_parse_phandle(child, "trip", 0);
> -               if (tr_np !=3D trip->priv)
> +               if (tr_np !=3D trip->priv) {
> +                       of_node_put(tr_np);
>                         continue;
> +               }
> +
> +               of_node_put(tr_np);

If it can be done here, it may as well be done before the check above.

>
>                 /* The trip has been found, look up the cdev. */
>                 count =3D of_count_phandle_with_args(child, "cooling-devi=
ce",
> --

It would be more prudent to hold this reference throughout the scope
though and release it when the scope is left.

