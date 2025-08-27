Return-Path: <linux-kernel+bounces-788239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC00B381AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C343C7B440F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB3303CBE;
	Wed, 27 Aug 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZOyE/BC"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED328153A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295061; cv=none; b=Po66N93xSU05/BTbg6W7j1mwrziOdJcziKFmrtzg/ZnQ2hkfgANmgVIchXCcdy2ote1hT7AoFJrW1sVcmllXBKYDDVTbzxjlt3hhAdMPJ1toxltWDwe7YXMY71HJNgQwY2AoznlJ/CGHD6psZ3k5LsTXGxyMTYhHob+uPytjAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295061; c=relaxed/simple;
	bh=DgftnOgSqGlketP4UMGvmVYbqYYngT40xQw3ED5YbgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/lkVDfBKgFA/5+jRGasjx/IDob6V2V4J9GJv767sYD+g04M5ZAvC8rg5CiKXqgRfjLCZVWUB6zgprfSoaJQp6pn9iPoh92y3ihlWHocdsihuXdyx/mism/qM/vtGPbrs9CHeBV26LzMIu8y1IyH76FXgs2MgPat9W8R0HxbWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZOyE/BC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54475262383so135422e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756295057; x=1756899857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lax/yZLDW+BMNpUyGj5bqEEnYweAdIf1ksQkW3Vvxs=;
        b=vZOyE/BCdmeZyDmfg2vLIyLlJzwHMg0ee0jIzW0blnMSdFeU68ArmRLXiue0AimRHH
         SXarYg2O3H3/TTX2E5jI+1+9pxZlHLQDlPDHJcaOTwlx4sgkSASv/Qdrgi0C857uMbS+
         H4LWukxHrQKzX+BSMMqjNv21R4YZ2KEQ6qdhXk7Drzkn1ffFnqEH9bZIsP5oCpc5t6um
         VK1VOzRfPNHA20RzCINXK+gw/dMc4tZuGcKtVbvng004OpZR6c8nwUnZNjW2zzzlthjv
         p53MhjhHXKJQFLjNuH0vu1q8Olzb0ea9ehwsAMm/JziC/Z83OthQ6f/6TFomgr30Fnnc
         ghfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756295057; x=1756899857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lax/yZLDW+BMNpUyGj5bqEEnYweAdIf1ksQkW3Vvxs=;
        b=ehZhskkDAeFDoq9KkebIX+YQQbs4CI3/byF9+hJlhRzA++9XN24+3gAuIUxsyN/jEY
         etrwgfmEBxRzbA4Hk+MsBp78GPy4yRfapQJjVx0JkgatAmb/bgNyZqWD59LSBBR66xUu
         eSwAmgiNkogXl7EWwvcQmLWbeVODe0MIlt3Vmkt/I+TIQlPR/Eo0gS8u/8fhuHAXvHOt
         /3BatdFmS7dgfsh7X0RQseBwkrEsEFxezaIjDvzjjmrtT53TCMWwi81waK0eH3ewpp+n
         EFNeSTwH1rEUJ2Of7h0y5x+WVBVlMQh3U4ND/ccGi8+HZfMsC6T/+UruQ8Hx/Z4Bijgj
         5FDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrWiKCCrH7yz8uZo0f/qaeuMBzuGcUvSoOHiB4/nbn46tAoRv3on0RnYM/VHqrXEwYCRPWdDUA2nyqS9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENDhL1bmw+wiIfq2BAUM9s24T29tPB0oDqU3GvdNGyxwtulX3
	3k6irHH+TaX4YnUWi0WVDTuD+7QR+NQ7R55hG5V/cx3fubKURx/bg0sZMyKg6sDVSwBYxpPHJJJ
	gSrpce2uumYNnx9/zcBDru3IRiWlX8qjx4EFMFIZ2J3UsvKRJBAyj
X-Gm-Gg: ASbGncuQ4u7dDp+0LMnWCEhk7xZsHXXuFvdkn8TzVB82nPISviSKrxqKMxSxlmaKzsd
	R89oFq/BFUWKNpxBhKsjiESXDcXwJWG/SCXNGCGHgJv23rA8i74qKfkft3L6XiyvE9k5aLZAsEn
	DFcLfzuzQRPFxwSzdfJvFxaRFQOjdPb44P5NPeQ5lby+9LKC3aHhGWj0oICfD4W99uABNal8hxx
	7B77jg=
X-Google-Smtp-Source: AGHT+IFngIUqyOrHPr1frhrJCq9eI3gBMm8y0Ik/Lf1DCEOhEB6QJoo4I7kdvXAvQYDz4lY+wIAEL2786J7bjWZOaCM=
X-Received: by 2002:a05:690c:9b0a:b0:71b:f712:2a2b with SMTP id
 00721157ae682-71fdc40b326mr235001117b3.36.1756294566868; Wed, 27 Aug 2025
 04:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100804.926672-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827100804.926672-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:31 +0200
X-Gm-Features: Ac12FXw9ifzNvvhtGWnIdShprfJ4vFejZRmHaL0F5QXMJQLyCmkChpqg3eMOhko
Message-ID: <CAPDyKFpRF_sQ8P8M16cTkBXmOjP6NkvpKxHgCm=1cY73qoZ7uw@mail.gmail.com>
Subject: Re: [PATCH] drm: display: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, claudiu.beznea.uj@bp.renesas.com, 
	saravanak@google.com, treding@nvidia.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:08, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
>
> Drop the explicit dev_pm_domain_detach() call and rely instead
> on the flags passed to dev_pm_domain_attach() to power off the
> domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> index 2d279e82922f..191664900ac7 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -58,13 +58,14 @@ static int dp_aux_ep_probe(struct device *dev)
>                 container_of(aux_ep, struct dp_aux_ep_device_with_data, aux_ep);
>         int ret;
>
> -       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                       PD_FLAG_DETACH_POWER_OFF);
>         if (ret)
>                 return dev_err_probe(dev, ret, "Failed to attach to PM Domain\n");
>
>         ret = aux_ep_drv->probe(aux_ep);
>         if (ret)
> -               goto err_attached;
> +               return ret;
>
>         if (aux_ep_with_data->done_probing) {
>                 ret = aux_ep_with_data->done_probing(aux_ep->aux);
> @@ -88,8 +89,6 @@ static int dp_aux_ep_probe(struct device *dev)
>  err_probed:
>         if (aux_ep_drv->remove)
>                 aux_ep_drv->remove(aux_ep);
> -err_attached:
> -       dev_pm_domain_detach(dev, true);
>
>         return ret;
>  }
> @@ -107,7 +106,6 @@ static void dp_aux_ep_remove(struct device *dev)
>
>         if (aux_ep_drv->remove)
>                 aux_ep_drv->remove(aux_ep);
> -       dev_pm_domain_detach(dev, true);
>  }
>
>  /**
> --
> 2.43.0
>

