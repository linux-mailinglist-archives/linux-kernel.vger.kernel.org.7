Return-Path: <linux-kernel+bounces-777615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03014B2DBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E896B4E51B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49C2E62B9;
	Wed, 20 Aug 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpeH41Xj"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFB2E5B2F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690797; cv=none; b=phwkg/3oV2bYsTzJEfKDrkHiEMZwqlozCCULOxbQmTVRuMQ5Ng97mGt2O+170HzdoZGgR4hJDyhBzo0WAEAfUqLJkVvlRdN0811zjCEzfG4L2KpZ8fkOTS89dwdWDk1wg3hlZdBSEMS5YbddfXZlWcpWmaTCIDxXwNsT7gOqN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690797; c=relaxed/simple;
	bh=MmM1CnA+Lor+nEFLiAe+sbXE4PA+dY1hJjQ4Ly416Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekdlEgsEEJxCgSyJNHAOzhDfIMLFRejHqWhSa3iaz14/93EuPzsDrwy1Fldjd8i8G9pctwi/v3LVnpWXQmJhFkVyBXRH2Z3tQaCq1MnghFuu8eaMgvNnwfmKrHI1eVXyK3K+1s2hKU40scwBqic/1zu5FHvDNPEJRwge9fgMKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpeH41Xj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603a9cfaso51140987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755690795; x=1756295595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wfY8E6fJCADzHf1Bzi5Pgxw3WUb0pai7Lp/eq5DYsIM=;
        b=JpeH41Xj+XQiPsAXhvjdzDjk5JBMlqPNAbrCvJo2jv+tY9UpVXLLPljdMR8YbR/pbv
         2JV/uRWIMuaV57gs81MMwQAfC142oqDoAocP3jiSF4SG6UyrIr/XQPmFktAJGklCm2i8
         GcCTbQVQu5GhSafWiHTE8e394RVKuo4O2rhpob9gb2BrWuE73VB07AYEnbyLp5/JDEtc
         LXZ6XoxMD5KBcHoQpo26fOzIrTMQhDjg43VmDIvOHXPjIf7PjMjhkhT8J8Rv/tLP9P1y
         Uez+3zMXUfPPAocjZyljQPw7KxclRI2BifIoTwG2Ru/BzruM9OsuC9BwAvQC1oghvhYA
         3WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690795; x=1756295595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfY8E6fJCADzHf1Bzi5Pgxw3WUb0pai7Lp/eq5DYsIM=;
        b=Be/8rgALi5BvivD1lXzVQa+ZAosnxgr5mSEBFqxTGeetD76O95IakqLp+WEdOyak3L
         h1oAK8o2XJKKJTuvHXVseUm+xs5s7X1z74GBnR3NgGv1x/zJ/ekEd2qqi7tr8KDbtgO4
         yX0oldSkIwcnb+sZ/o7ek3kXpADylq2NE7Cq6fn/FcV8FHzf2JBr4gKOZTXSOs3Izfmf
         YTZMm/DYjJLltNHAh/2xHvRV25Il6iN1fEmeaLWbg7PLgqCVNW+NdWhAiMm6xtIRX+fg
         Uk6woJGTHJFQkk6EtljIi5PEQBUooDyoiVcwZRzZHkpAMZB9PRdDhg0RQWOPxYAbYm9K
         UTcg==
X-Forwarded-Encrypted: i=1; AJvYcCWpPGAJf5AJmlA5NauMsGWThawwL0KXrUX6u5IfDHNCb3IWvrl5g2BJV9VNoMfdiEBN9AJPfOp1Yf7sRIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDzNwj3gKk/60J+j3U4M4/1RwQljKbEYvSbl4/yRliaybo4tY
	U1lBLJXS39BPyavqAuGzKydfaJpBx94rnlo3yy5ljy2MjkuDqPqlLYHzc7u/70Kv9tnpIbRyK4p
	q9UwamOx9HWQnUBGFDr4CyphJcZQkdPw8gICz5IqKcA==
X-Gm-Gg: ASbGncsdbhT4CRUFqjRbGxs1CXD78t79MSd+w4BMNymEOCFQavRh7gd1+bbIf9y9C5U
	8Yt2awNG1ggg/meypSS7rRNW+14EMhLO8bepAZo0z53SGHXwxrI2KN1LW/NwWAhC2UHtZ33FyFY
	C8biA0LqR2yi8oA7Fngj5gP+PfrIupJdk2QSrggqOlE6vUsvfLOmUk3t3+rxtk4TaufFyGa+SfX
	B5XKcoS
X-Google-Smtp-Source: AGHT+IFjcS9cmVgaI4c6h6za/ZHS+/se2bsGoBeQs6x8QymSZGHT1jVZ61lTLCqqdXlZW30H6USeUxtBeOWYh/jv0yQ=
X-Received: by 2002:a05:690c:3684:b0:71e:8086:c9da with SMTP id
 00721157ae682-71fb3230d13mr28006737b3.31.1755690794740; Wed, 20 Aug 2025
 04:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814130705.326073-1-o.rempel@pengutronix.de> <20250814130705.326073-3-o.rempel@pengutronix.de>
In-Reply-To: <20250814130705.326073-3-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 13:52:38 +0200
X-Gm-Features: Ac12FXwzhsz92ch8tIMD-PG1qULef7_8F4arRRIauJobKzyL6ZBdAvs9a6BFjYY
Message-ID: <CAPDyKFo3SnqvxdD4C-ESFERPJNfRXWKxzX1Hh573DsxvVdPdnQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] mmc: core: add undervoltage handler for MMC/eMMC devices
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> @@ -2212,6 +2219,13 @@ static int mmc_shutdown(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       /*
> +        * In case of undervoltage, the card will be powered off (removed) by
> +        * _mmc_handle_undervoltage()
> +        */
> +       if (!host->card || mmc_card_removed(host->card))

There is no need to check for host->card here, as the shutdown ops
can't be called unless it exists.

> +               return 0;
> +

[...]

Kind regards
Uffe

