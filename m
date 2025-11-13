Return-Path: <linux-kernel+bounces-899077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5FC56B31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53CB134EAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A62DFA46;
	Thu, 13 Nov 2025 09:52:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFA2E092E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027522; cv=none; b=f8d9b4LxgHHtzn4AUV5gue5pCCi1+UrNU8psGTBHya8/wM6uoTnluoRidaervyn0VIlKf04ngVeJct/YAruitxKNoC/lM6SmP7giNy0miCjM6Uudapql057J22YDc+JHkJyyGKn20TLlNPGYxeeTG56UFRt+kryjDFL+tgYRw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027522; c=relaxed/simple;
	bh=5rji+7Dzx+i4SIsi8JQiW2hPQ5571hfwzOj6A9jI0S4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZV/VxELxgABhpS4Wd4am5XxzacSs05DPKBVidx7e+IMykvSGJn8BbelWlx3oB+dIhuNBjOToo6/4/3YDJXRdg8dlOusExZIvtS6Am/+DAK5oyuK93WKlFyIBIigcIJRTC2OmcgRJ3FphucH+XvlS6Cd9zE+nNKNYfWttFB/oy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJTzb-000185-JB; Thu, 13 Nov 2025 10:51:51 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJTza-000EZw-0b;
	Thu, 13 Nov 2025 10:51:50 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJTza-000000003jh-0Vws;
	Thu, 13 Nov 2025 10:51:50 +0100
Message-ID: <def3319117b2d2d71d0585e69d648b1a0f217bc4.camel@pengutronix.de>
Subject: Re: [PATCH -next] reset: Remove unused variables
From: Philipp Zabel <p.zabel@pengutronix.de>
To: paulmck@kernel.org, bartosz.golaszewski@linaro.org
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, bigeasy@linutronix.de
Date: Thu, 13 Nov 2025 10:51:50 +0100
In-Reply-To: <8e6ec20e-8965-4b42-99fc-0462269ff2f1@paulmck-laptop>
References: <8e6ec20e-8965-4b42-99fc-0462269ff2f1@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2025-11-12 at 12:59 -0800, Paul E. McKenney wrote:
> Neither reset_lookup_mutex nor reset_lookup_list are used anymore, which
> results in build errors, so remove them.  It would be best if this were
> to be folded into commit 205b261463ff ("reset: remove legacy reset lookup
> code"), the better for bisection efforts.
>=20
> Reproduce on armv8 with:
>=20
> tools/testing/selftests/rcutorture/bin/torture.sh --duration 10 --do-none=
 --do-rt
>=20
> Fixes: 205b261463ff ("reset: remove legacy reset lookup code") # -next
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 22f67fc77ae5..93575d5064a5 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -25,9 +25,6 @@
>  static DEFINE_MUTEX(reset_list_mutex);
>  static LIST_HEAD(reset_controller_list);
> =20
> -static DEFINE_MUTEX(reset_lookup_mutex);
> -static LIST_HEAD(reset_lookup_list);
> -
>  /* Protects reset_gpio_lookup_list */
>  static DEFINE_MUTEX(reset_gpio_lookup_mutex);
>  static LIST_HEAD(reset_gpio_lookup_list);

Thank you, just applied to reset/next for now:

[1/1] reset: Remove unused variables
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D3754bc97926e

I'll rebase this branch and squash this fix into 205b261463ff before
sending a pull request. There's also the 25d4d4604d01 / f5c877fb74f4
patch / revert pair that I should drop.

regards
Philipp

