Return-Path: <linux-kernel+bounces-876961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC05C1CDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A001887D70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A83590AB;
	Wed, 29 Oct 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAOthhBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB33590A3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764432; cv=none; b=ORs16ordX+RonMwxf1n4IceL/WfY6Z3ifTBWiTjFhNDtrALEnbucSf02kLp6MZiVJv0vNVh2XzuAM20CbNZhXuABKditv74j8CMfRtPFscn3FnmrikxY9z/s4dWbDy8q2a0WME3gXvzzzcWI8qG1u9KAC+HH/GvB+CM0Yd+H7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764432; c=relaxed/simple;
	bh=7lyiAV1rqHRrNNC2mebu+0d6w0qgxZqfz9LsUM51/IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXQ1cW9EZK8kbWqIPJANtSJVfOlMIf6eThhChBNeAEehoYDSezYEPqs6URxea/hVfIvE+8YYEfpVtBRdpQ1hvN/VL7EoA+j7+hu4GAB/RtADFLZqdh79cDaCpxAQLXeEWQvQX+ck+k00BKOz+/+GHq51m/Upa85v6v0DPfvy+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAOthhBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9725C4CEFB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764431;
	bh=7lyiAV1rqHRrNNC2mebu+0d6w0qgxZqfz9LsUM51/IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GAOthhBd6bMTA9pSdD9Srtln8BBFYi6FILnkfNJInHsBD6IY/eiau6tl4ODlOb5Y3
	 tiMV2K86rUjhm4ADcWN7TiLwgx9PLwj3zhe1GujSPKFjXlgy/fqAYl2QJ677JLImae
	 GZdDct2prv8Z1bj9nMvf7/zii9cNqQOK2qRSJgcJP6Zyb/wt9fy0upA+X5OWRMzETE
	 3KnLdDaOY74yGG3H66N3pFRK97nKEYM+jNx9vM+xh7fWdzCH1TOVzTG93/VUgT8tp8
	 lJonO/hXNz06VfFgdSkCWBKVibnSXbvBCo5TYMLmUXS9RWM1zxpG1ljGHwRQitClfH
	 MxP6KWN+PQYiQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c2816c0495so71382a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:00:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7foxLs20GXAbKM1jUVN03AWLloKUj7Yk9+X67k3mSeuPLVShh
	bbh/E2O5HcBFJMpR7stAQlWxp/j8umRcp9fgPqEkqye3JyrOw1vC6Ie8U0ztYlspL0Xd6fgI655
	s6+w42nwzKBQmaIYgK9cS9gNj5QzA20Y=
X-Google-Smtp-Source: AGHT+IEM2thqrNFpWgW4GaxlYBwePV2dgOkn3wDq3C3a3TbN7GDItXTyZfYFUpWtpwDSnFCac7W45ElxoOHQJDadjYY=
X-Received: by 2002:a05:6808:3990:b0:44d:bf83:d7f8 with SMTP id
 5614622812f47-44f7a3d0652mr1972133b6e.4.1761764431301; Wed, 29 Oct 2025
 12:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026170527.262003-1-mrout@redhat.com>
In-Reply-To: <20251026170527.262003-1-mrout@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 20:00:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gtKTUAthA4OaCU-hV4j1OhRDuA10o-ZhXepFyq7J5L2g@mail.gmail.com>
X-Gm-Features: AWmQ_bk6EPvPp1ZojFQfUZnAvpOOabuA0STIcW3pcPHz9eAU0AO-Pz444iRTH1g
Message-ID: <CAJZ5v0gtKTUAthA4OaCU-hV4j1OhRDuA10o-ZhXepFyq7J5L2g@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: fix typos in runtime.c comments
To: Malaya Kumar Rout <mrout@redhat.com>
Cc: linux-kernel@vger.kernel.org, lyude@redhat.com, malayarout91@gmail.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:05=E2=80=AFPM Malaya Kumar Rout <mrout@redhat.com=
> wrote:
>
> Fix several typos in comments:
> - "timesptamp" -> "timestamp"
> - "involed" -> "involved"
> - "nonero" -> "nonzero"
>
> Fix typos in comments to improve code documentation clarity.
>
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>  drivers/base/power/runtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1b11a3cd4acc..7fe63cab2708 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -90,7 +90,7 @@ static void update_pm_runtime_accounting(struct device =
*dev)
>         /*
>          * Because ktime_get_mono_fast_ns() is not monotonic during
>          * timekeeping updates, ensure that 'now' is after the last saved
> -        * timesptamp.
> +        * timestamp.
>          */
>         if (now < last)
>                 return;
> @@ -217,7 +217,7 @@ static int dev_memalloc_noio(struct device *dev, void=
 *data)
>   *     resume/suspend callback of any one of its ancestors(or the
>   *     block device itself), the deadlock may be triggered inside the
>   *     memory allocation since it might not complete until the block
> - *     device becomes active and the involed page I/O finishes. The
> + *     device becomes active and the involved page I/O finishes. The
>   *     situation is pointed out first by Alan Stern. Network device
>   *     are involved in iSCSI kind of situation.
>   *
> @@ -1210,7 +1210,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>   *
>   * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage=
_count
>   * is set, or (2) @dev is not ignoring children and its active child cou=
nt is
> - * nonero, or (3) the runtime PM usage counter of @dev is not zero, incr=
ement
> + * nonzero, or (3) the runtime PM usage counter of @dev is not zero, inc=
rement
>   * the usage counter of @dev and return 1.
>   *
>   * Otherwise, return 0 without changing the usage counter.
> --

Applied as 6.19 material, thanks!

