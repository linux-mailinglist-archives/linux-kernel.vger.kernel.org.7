Return-Path: <linux-kernel+bounces-836563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D593BAA072
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B93D1898707
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1B30CD84;
	Mon, 29 Sep 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3Sxm8mq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3B3093BD;
	Mon, 29 Sep 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164034; cv=none; b=FIz/BU/EKwKoQvDaqyWcQh2zt9r1CTys/SzdF7qZDUMLxfKHIIENnu5mCzWJwqs8LyQ8MgJ5hNbtFvKz4ly7Q/3kY6nXQTVEwLeItQvuZ3OHSUpYZI7M43mYKiDZA4GsGV8pFKdAZNVE1RVzKcreOOqDKg2KAAYGUqiIPluOFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164034; c=relaxed/simple;
	bh=s25mEf5RQak/vr2ECi81WpkwymQbFav24miks5gwPY4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pWzUieUqCGCs162irqrx2a2oIphcOOSWoPYcnTKfnrz/INhtMbA5b+CTEJH3JGle7FqaYtJPFY5kKZZMNVG3/wX/YdS2Y3Y+CBy8X9GhsafqrZmPiSDDFxSjG5beQFChx79s8Gnbco8L6a+fQJn9Ou2viDlUG6MBEZMbdwxQrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3Sxm8mq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759164032; x=1790700032;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=s25mEf5RQak/vr2ECi81WpkwymQbFav24miks5gwPY4=;
  b=G3Sxm8mqBEggasZLa8FwQNymc8yYXeNUCKxKh1dR81r6aiP8Bt1J8Wqs
   YyfHbB5yF9qJ079JcXwfB2uTxGN3kr1SUKR2GPgG/QVic1/x5MXGzUjfh
   /zkY+3Uh2veuZ3rfFIlH8mWywHg1tcep3cBJY9Ol1XhcOUJwJOKvy4krb
   3MXhr/XRqHtNt8FOY94XMvrKLjQ3xGCwXOylmv8jSryjBi/LJC8Ti/IkJ
   7vPKgKvU7XnO0jZ/ZpvyMiKJy094WuAp4/jphwtXqO0q4D2WzN7gJu2Kj
   jDifwDtq8jXTnlFm8fa2gGGxLC5u+eqtCiXnfHV97c7FIFV0PbeFlywz7
   w==;
X-CSE-ConnectionGUID: EKQZZI7TSCO6esIUtWMGDg==
X-CSE-MsgGUID: Bus5h3hNT+CDWBTpebsNOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="48973983"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="48973983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:40:31 -0700
X-CSE-ConnectionGUID: UGtkYskKQRyD7eEZ/oLh9g==
X-CSE-MsgGUID: HD4/3RzySleexfSyhvPToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="178218018"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:40:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Sep 2025 19:40:21 +0300 (EEST)
To: Thomas Gleixner <tglx@linutronix.de>, Ciju Rajan K <crajank@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    christophe.jaillet@wanadoo.fr, platform-driver-x86@vger.kernel.org, 
    vadimp@nvidia.com
Subject: Re: [PATCH platform-next 2/2] platform/mellanox: mlxreg-hotplug:
 Add support for handling interrupt storm
In-Reply-To: <87zfaf3nnl.ffs@tglx>
Message-ID: <57573eee-8b8f-2399-0723-f6b68c9d779e@linux.intel.com>
References: <20250916054731.1412031-1-crajank@nvidia.com> <20250916054731.1412031-3-crajank@nvidia.com> <34d028ac-f907-1505-a2fc-f455a10cfa5e@linux.intel.com> <87zfaf3nnl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-519443350-1759163630=:943"
Content-ID: <7cd93e06-7fe0-af54-3707-92269222492b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-519443350-1759163630=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <296c21df-f8be-5696-5e79-2d4a022c2d7e@linux.intel.com>

On Sat, 27 Sep 2025, Thomas Gleixner wrote:

> On Tue, Sep 16 2025 at 13:00, Ilpo J=E4rvinen wrote:
> > On Tue, 16 Sep 2025, Ciju Rajan K wrote:
> >> This patch provides a mechanism to detect device causing interrupt
> >> flooding and mask interrupt for this specific device, to isolate
> >> from interrupt handling flow. Use the following criteria: if the
> >> specific interrupt was generated 'N' times during 'T' seconds,
> >> such device is to be considered as broken and will be closed for
> >> getting interrupts. User will be notified through the log error
> >> and will be instructed to replace broken device.
> >>=20
> >> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> >> Signed-off-by: Ciju Rajan K <crajank@nvidia.com>
> >
> > I've a general question on this approach, probably more directed toward=
s=20
> > Hans, Thomas, or others who might have some insight.
> >
> > Are drivers expected to build their own workarounds for interrupt storm=
s=20
> > due to broken HW such as this? It sounds something that should be at le=
ast=20
> > in part handled by something generic, while the lower-most level maskin=
g=20
> > and detection might still need to be done by the driver to handle the H=
W=20
> > specific aspects, there seems to be a generic aspect in all this.
> >
> > Is there something generic for this already? If not, should there be=20
> > instead of adding this in full into an end-of-the-food-chain driver?
>=20
> We don't have a generic mechanism for that. The core handles only the
> case of unhandled runaway interrupts.
>=20
> I agree, that there should be some generic infrastructure for that.
>=20
> Something like the incomplete below, which obviously needs some thoughts
> vs. shared interrupts and other details, but you get the idea.

Thanks Thomas!

Ciju, please base this storm detection on this kind of approach. I also=20
started to wonder could some non-storming bit end up being detect as=20
storming because your v3 approach doesn't do counters per asserted bits so=
=20
if unlucky, non-storming bits might be asserted on the very moment the=20
detection threshold was crossed and gets marked as storming even if it's=20
not?

--=20
 i.

> ---
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1927,6 +1927,10 @@ static struct irqaction *__free_irq(stru
>  =09=09irq_release_resources(desc);
>  =09=09chip_bus_sync_unlock(desc);
>  =09=09irq_remove_timings(desc);
> +=09=09if (desc->irq_storm) {
> +=09=09=09kfree(desc->irq_storm);
> +=09=09=09desc->irq_storm =3D NULL;
> +=09=09}
>  =09}
> =20
>  =09mutex_unlock(&desc->request_mutex);
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -22,6 +22,44 @@ static DEFINE_TIMER(poll_spurious_irq_ti
>  int irq_poll_cpu;
>  static atomic_t irq_poll_active;
> =20
> +/* Runaway interrupt detection */
> +struct irq_storm {
> +=09unsigned long=09=09max_cnt;
> +=09unsigned long=09=09last_cnt;
> +=09irq_storm_cb_t=09=09cb;
> +=09void=09=09=09*cb_arg;
> +};
> +
> +bool irq_register_storm_detection(unsigned int irq, unsigned int max_fre=
q,
> +=09=09=09=09  irq_storm_cb_t cb, void *cb_arg)
> +{
> +=09struct irq_storm *is;
> +=09unsigned long cnt;
> +=09bool first;
> +
> +=09if (max_freq < 500)
> +=09=09return false;
> +
> +=09is =3D kzalloc(sizeof(*is), GFP_KERNEL);
> +=09if (!is)
> +=09=09return false;
> +
> +=09/* Adjust to cnt/10ms */
> +=09is->max_cnt =3D max_freq / 100;
> +=09is->cb_arg =3D cb->arg;
> +=09is->cb =3D cb;
> +
> +=09scoped_irqdesc_get_and_buslock(irq, 0) {
> +=09=09if (scoped_desc->action) {
> +=09=09=09is->last_cnt =3D scoped_desc->tot_cnt;
> +=09=09=09scoped_desc->irq_storm =3D is;
> +=09=09=09return true;
> +=09=09}
> +=09}
> +=09kfree(is);
> +=09return false;
> +}
> +
>  /*
>   * Recovery handler for misrouted interrupts.
>   */
> @@ -217,6 +255,19 @@ static inline bool try_misrouted_irq(uns
>  =09return action && (action->flags & IRQF_IRQPOLL);
>  }
> =20
> +static void irq_storm_check(struct irq_desc *desc)
> +{
> +=09unsigned long delta, now =3D jiffies;
> +
> +=09if (!time_after_irq(now, desc->irq_storm.next_period))
> +=09=09return;
> +=09desc->irq_storm.next_period =3D now + msec_to_jiffies(10);
> +=09delta =3D desc->tot_cnt - desc->irq_storm.last_cnt;
> +=09desc->irq_storm.last_cnt =3D desc->tot_cnt;
> +=09if (delta > desc->irq_storm.max_cnt)
> +=09=09desc->irq_storm.cb(irq_desc_get_irq(desc), delta * 100, desc->irq_=
storm.dev_id);
> +}
> +
>  #define SPURIOUS_DEFERRED=090x80000000
> =20
>  void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
> @@ -231,6 +282,9 @@ void note_interrupt(struct irq_desc *des
>  =09=09return;
>  =09}
> =20
> +=09if (desc->irq_storm && action_ret =3D=3D IRQ_HANDLED)
> +=09=09irq_storm_check(desc);
> +
>  =09/*
>  =09 * We cannot call note_interrupt from the threaded handler
>  =09 * because we need to look at the compound of all handlers
>=20
--8323328-519443350-1759163630=:943--

