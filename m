Return-Path: <linux-kernel+bounces-832515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EEEB9F916
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741767A4CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838F2773E6;
	Thu, 25 Sep 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhP2s1oU"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F96275852
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806467; cv=none; b=ckxQx0HYAIE6r5HP9MdHlA6HMXEYkmyv3sKcANZ3Wb09rz7wFQH+AtG9rWCl43c1chgdUjDsb/VWJ6V5NmVSvcpk5WDH+aH0bo1E4GbtVV25REe4k1n//HpIrSm0xOIS+sKUdqP5SX1snAtKPPmTIXzQ6aqKbuJXAmCrU1V0FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806467; c=relaxed/simple;
	bh=tyrQdtC54KPwmXubmBZv1Sfqbp1p1MiwVKd043bXTNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeoDBnLvj7McAbmQ8XWzw8x1o/YViHZpnkPnIRY02S8/J1EgHGTPb01Y2mtp6MhlRaKP/beq/LUVgnnAV7O/CUx00iPmkwM8FR7UKOyz4Oya+0L2NKJBI2+NIlVLXVt9yXeOq2bCNwpjsZ55mizkD0+ixBCHx+KwTXhqo1Ztj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhP2s1oU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-74f6974175dso13431277b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806463; x=1759411263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4VG4axCfxY2VruLkFskd43MY3X29CZllfJGqxG9KijI=;
        b=lhP2s1oUz3waXO/sajAnPLCUKMMZO13tNpHAMepg/b5giMPQ8SlO/4qMWWeDtv0c5z
         LthHYHaP/iFyHcVAKqbaMAEM/f+Q9XTcYZWZ/Ql5SApMP26QOeBWH5ArUuL2nPp+pm6Q
         NmSQ0W28pHcMcBKFhnlWNGY4cSDBNffcsGkQ7zKQMvca1povacH5k1H60Rjp2Wk69lQl
         dPEIAYxLW8bG63feWndm9TPkUh62UxgxXRLV0NvWnsLTu2IxuhtyyNw27iaM01eg6cEj
         kg5mghiA70VueqqqTJ1liKJuO8dPYp3dMjBkXz1kxE76obVdfVKtB58CY+9a/6jCzANp
         Z1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806463; x=1759411263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VG4axCfxY2VruLkFskd43MY3X29CZllfJGqxG9KijI=;
        b=FxHUsBSY6pX6XvLExYGoKRJVayWUNgaAxoFwfcPhDI7TATmDZzgvJY7PupwJQ75CvZ
         6b3A+gC2Zm75RRSyxaL/XizuDfOFj5s3D+A3fS5iHqVWFgQVy2LvDuI972IucWs3T/lx
         9PFTO0N6cyKQawGlWA6JZHnrl2pX22UxMgOiOfTSsburOyI92Q9Vb+CUQLiJBbHl/Ntx
         NPUUBYSpwWe4zmdkBaEtIeMTI/nx4pBU3vhxfNgJSfxYkRYoee+03D2DGpdvnC6OXHjO
         RzRIToUQYm3KtKVlrMqq/qkG/v9QMu3UKVO9Utlkrs/QsXto1Jq1rVZf5wa6kih4zKTS
         ydjA==
X-Forwarded-Encrypted: i=1; AJvYcCXvqj+iTNWMGZbyTgmhf+ILnwhUjtOYXKAHox1uG26vFNfdxWDsKg5kA3lov7mx1pvGW3/xoTcrcxq+who=@vger.kernel.org
X-Gm-Message-State: AOJu0YybtBTXt3Jeqdlhi8md6yL5g2xZQ8wg5BtEip0JqfNzr8vk8iGD
	lJEhrnamwj9kAK0C4r04HrvXpFNTKYYeq0l5YmNMf3akwLobah6FGaCVb/uUDxNUws7VLP+1nHd
	8IvzN6SWfJxgps484qbuJaZExEGEZTJTnjOmitpYHCA==
X-Gm-Gg: ASbGnct3GlnpmvnguMzFO5ZKlGj5BulSaJwDDXou4MJBKb6yKdh8YT9fQyqG2Tx4rYJ
	oNIAU94lg4wS2+tBA+yN9mSXaUWPcgF1VY3Uhc8nzsRHZAw6VW4C5k4h9fAIydHxnHUGJSao5ek
	PYxXNmHJ/PRmUdHDAnHP6aHrs4p+wrGa8iaMlHlzWbzDEJSR9SG6jU4qkjSkron3u/B+CnKANwK
	4Z2n7MB
X-Google-Smtp-Source: AGHT+IGZF84EGEcJ4wcONA3NS9+OZ2xh3iimMrOT8Psj642ZRdZzPsML4L6NnKLHVd29XW7oN/nkEmvMCvQcCrnK/Q4=
X-Received: by 2002:a05:690e:1583:10b0:636:bd92:b253 with SMTP id
 956f58d0204a3-636bd92b7b2mr527783d50.53.1758806463094; Thu, 25 Sep 2025
 06:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org> <55b41549-f5c4-4e83-ac1e-11dd068b1f5f@ideasonboard.com>
In-Reply-To: <55b41549-f5c4-4e83-ac1e-11dd068b1f5f@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 15:20:27 +0200
X-Gm-Features: AS18NWDgHhaPpJ-kJEdm5ZBKa_hqeUvNyG8N7Cy2NJLVKY_w8Ixa57gUB_BvF98
Message-ID: <CAPDyKFr3sXU4nXmQTH3+hfVN2P6nFVXRBPUgTPng1-j4m8+r6g@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Saravana Kannan <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 14:08, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
>
>
> On 25/09/2025 14:59, Ulf Hansson wrote:
> > Due to the wider deployment of the ->sync_state() support, for PM domains
> > for example, we are receiving reports about the messages that are being
> > logged in fw_devlink_dev_sync_state(). In particular as they are at the
> > warning level, which doesn't seem correct.
> >
> > Even if it certainly is useful to know that the ->sync_state() condition
> > could not be met, there may be nothing wrong with it. For example, a driver
> > may be built as module and are still waiting to be initialized/probed.
> >
> > Ideally these messages should be at the debug level, but since the
> > ->sync_state() feature is under an ongoing deployment and the prints
> > provides valuable information, let's move to the info level for now.
> >
> > Cc: Saravana Kannan <saravanak@google.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reported-by: Sebin Francis <sebin.francis@ti.com>
> > Reported-by: Diederik de Haas <didi.debian@cknow.org>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d22d6b23e758..97eab79c2f3b 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
> >               return 0;
> >
> >       if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
> > -             dev_warn(sup, "sync_state() pending due to %s\n",
> > +             dev_info(sup, "sync_state() pending due to %s\n",
> >                        dev_name(link->consumer));
> >               return 0;
> >       }
> > @@ -1792,7 +1792,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
> >       if (!list_empty(&sup->links.defer_sync))
> >               return 0;
> >
> > -     dev_warn(sup, "Timed out. Forcing sync_state()\n");
> > +     dev_info(sup, "Timed out. Forcing sync_state()\n");
>
> I have no issue with this, but I also think that while the pending print
> above could well be dev_dbg, this one is perhaps a bit more warning-ish.
> It may be harmless to get the time-out, but it would be better not to
> time-out (i.e. everything was already sync_stated, or startup scripts
> handled forcing the sync state).

I agree. Perhaps we should consider moving the above "sync_state()
pending.." to dev_dbg at some later point, then we should probably
keep the "Timed out..." print at dev_info().

Anyway, I don't think using dev_warn makes sense, at least for
configurations with CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT being set.

>
> >       sup->state_synced = true;
> >       get_device(sup);
> >       list_add_tail(&sup->links.defer_sync, data);
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
>  Tomi
>

Thanks for reviewing!

Kind regards
Uffe

