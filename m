Return-Path: <linux-kernel+bounces-844879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A5BC2FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2105D3C034B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AA25F998;
	Tue,  7 Oct 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWu2AdXP"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB6189B80
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880672; cv=none; b=l7qLJumBKl4VhRMEEDRxYtbBArpFwE5SMekNpNB0sVk0ra4sNEd+38Hz03lvFPjwbpx5W3+XVQrymI3YLWR+vdyHx7IFF3EK2usrhipKH0FWAF9KRTsTqyz2wnimFzuMTYcCYrUuFleVSM6IG92zZ0IGKEwLCadDtpG0r2S6Gdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880672; c=relaxed/simple;
	bh=LWJxA9v9v2ScNAsEI7ZemXtMQHe79nNOKWmzAuesTmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixDWsC+tOaTYHIMCE95WzH0jxz90OyJCx+Ya1SeuVY/hluP7VTjw3w5IE3y6W586/XN6ACQ8ishH/yti37Q4mQE8Bhc20QTeHs94w+ueGKjXVfwmsi3eSpEGkTChcfOgq8ZdE4nBSBY9iv1XH7t/soFq4PhfdY6Ykbj2jfiX2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uWu2AdXP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-58d29830058so6833027e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759880667; x=1760485467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdDPwXrUCndSUHvhfKd8OTKngDnEJjImy29CDVr9yNY=;
        b=uWu2AdXPaveVhZ0hUvgOqjmNfSNf2Uo2JdOZSsr8dz3gBDGXWZ/sJL93qcb+ChbFMs
         KCTMq/ZaV1VE3G7Rxwh9j1210SrBac373v+TvFyFMJBQem4Va0MICrUVHZkQj4HoGr5B
         LOm3KNuid7PYV4aea4i5PoyMv74/x2aCSFvAkCnE+pbbCmzhbejqoKw3b8zeDfmQksBF
         F7awmeg4JuvIRafaT638NxxjWTKCkxovWVzyLA+fjurWMFNdKMvMwvqR7HPslbSmguou
         FkpVTCkCXtByT/5CRFhqduThb+gp8UIuuTaD/ln2AgvV9HImgINB+qA5yQhJ/U1HaVLm
         7QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880667; x=1760485467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdDPwXrUCndSUHvhfKd8OTKngDnEJjImy29CDVr9yNY=;
        b=liQG8AvlAo62/x8YaYcBe9eFxXzj8s84SZhBlxG2VpP4Wg+wRjAAFQPTD8hvxZTRvN
         wot9SrcF9SqrruB/CHI1t7p3747bXIeli2EZOfXRU+dUk31WTpqyQefSZ/N0A7gyvPlG
         30WvkuJBPl8M3g5G1M+bedrrlGfO9QGvNCu0c6HsQTGapibkuwto0q/v1xBQ1s1p84P0
         7B5IchNrITZt8Y75r02++4dN0QH5EV1LhyGaRq9QW9wzMBxpsrlqSpdqCjJR68HneHii
         2+1hzUxZRHc/H6a6hOHuE1/DO4MUMi42nfWPE0Y8MmC7MkUtJ7W0hb/Guv7EDuXcCcES
         gKkA==
X-Forwarded-Encrypted: i=1; AJvYcCUnS6Zu4cXypir36IUjVEVq4DOXLSDgWaVEnkcMpZxOWWSNlTC70ww8rcn4mYlrUWRf8EhOZwUAa50rqhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHxPqQSLU+CZqHAIYOl6HLrdyLGSarzTAnsguxT+JSyVjhDgA
	/rkAcBFJ7ks4ig+M02iJ9dv2Je8NmsTbq2mlGvUM4oC0Do0DLGXvgZP1AtAnQYGBQVQE6pKaW/z
	kyC1d0pH5qgAICr3niPcMae15/Qa6i0tkS+GCNa48
X-Gm-Gg: ASbGncvDSkHgGI/6MRpnI+UBGs1AV0VY56sRYpl3WRX66tOka4Y/PZyvCDVMZmXewcf
	eCVkKSpZw3E4NQPK/7DtHuHcWiWSZot4mlvRgNN6lKqxrbuBuCRsOHT3yF76JkSEIOgMB75DaN7
	quTKQ3/sG6TzWYOojoiB73o4r+/8/7pw9mCXMIzUFf3a/YlM1NgwmqPCCTp0S+0NlYi89m4UOfX
	+g+poTqB/wrsF7ASf0nqR5HIZw2adHe3/jKn7iUDsqnzBacLLiJPJLMBGkMJAakcss=
X-Google-Smtp-Source: AGHT+IFdQL3eR/SOY67StQecANO2VnRWAmFtiPakOZFHiUlJOwj6Imv4TzH8+nP6L5X2EcxtVc6+58+BQM9eZ3HYWqg=
X-Received: by 2002:a05:6512:4026:b0:57e:c1e6:ba2 with SMTP id
 2adb3069b0e04-5906d77df4dmr344264e87.1.1759880667021; Tue, 07 Oct 2025
 16:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007094312.590819-1-ulf.hansson@linaro.org>
In-Reply-To: <20251007094312.590819-1-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 7 Oct 2025 16:43:48 -0700
X-Gm-Features: AS18NWCXcm6CMIZDapU-gXtRMN_nrbL2_9een9pVr80YceX_ze5s2D5g_553M3c
Message-ID: <CAGETcx_=_wAdozOvF6KcNiJj4NeGzBy6sXYQsJMLZLFb819Lrw@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about sync_state() pending
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:43=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Due to the wider deployment of the ->sync_state() support, for PM domains
> for example, we are receiving reports about the sync_state() pending
> message that is being logged in fw_devlink_dev_sync_state(). In particula=
r
> as it's printed at the warning level, which is questionable.
>
> Even if it certainly is useful to know that the ->sync_state() condition
> could not be met, there may be nothing wrong with it. For example, a driv=
er
> may be built as module and are still waiting to be initialized/probed. Fo=
r
> this reason let's move to the info level for now.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Sebin Francis <sebin.francis@ti.com>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Due to discussions on v1 and because the default Kconfig is to =
use the
>         FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be be=
st to
>         keep the warning level for the "Timed out.." print and only chang=
e the
>         "sync_state pending..." message.

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..c62e428b95b0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device =
*dev, void *data)
>                 return 0;
>
>         if (fw_devlink_sync_state =3D=3D FW_DEVLINK_SYNC_STATE_STRICT) {
> -               dev_warn(sup, "sync_state() pending due to %s\n",
> +               dev_info(sup, "sync_state() pending due to %s\n",
>                          dev_name(link->consumer));
>                 return 0;
>         }
> --
> 2.43.0
>

