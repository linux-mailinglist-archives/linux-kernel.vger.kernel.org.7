Return-Path: <linux-kernel+bounces-844842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B0BC2E54
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0A189FFF1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC00226D02;
	Tue,  7 Oct 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4WPfsJ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0A1311AC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877226; cv=none; b=E6HDnuLsEUBXjvaKUQumsUbJ2bFIXsWVSVhRcci9Diu0XP8/nltPpJh4THY5lLLtDdZjiYzDmQiWkUV9eb3G43AJE5RnX3gaHmuHTnxxQvZHy4acYLlli30jSSwDVraA93gPA5azPBACZ12p0ByEoLR+kHToFcuXJZ8t4pNHySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877226; c=relaxed/simple;
	bh=y2rUAZo6AJmwPpgF6OOA0b4xm1fxFD7dX5bfe2GTvtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bG75lcD9WsvkRslNlTONYIZ9qxfphKg9rzF4F9D+oSFdWW8zfTITd7PEvN+OMX25iTJtdpEFvxUaTwS3O+LcVE3bGwbeU9xwPPB2uZ5mTMt+VWknfYidXtGPsRWg01wFMnqZa/vmGf7iumTtjHXU3I8/ZYhdbA3JzQCjJGlTctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4WPfsJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759877223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXX3OW5I6MBbCO96hdWxk+d8zv3VdehPL4VTnFFUYfA=;
	b=B4WPfsJ/vL5UzTXuJvFuf0oLFR2j7LdZqcsfHzz2bNOHeAnJQuxclkdnB0J1MaU2BtLwwk
	rBUVtMz6L8k+HV9NblY/hYOw44UamBRexv4dpDs1YL8zp7GJvRWxV99I1lHQrj3bdF1wah
	lmmesRuPXF0qZKzk9qkp+8+qFyvGaZI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-yrG21o8_MwyUkZKsA3ekEg-1; Tue, 07 Oct 2025 18:47:01 -0400
X-MC-Unique: yrG21o8_MwyUkZKsA3ekEg-1
X-Mimecast-MFC-AGG-ID: yrG21o8_MwyUkZKsA3ekEg_1759877220
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d91b91b6f8so89789131cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877220; x=1760482020;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXX3OW5I6MBbCO96hdWxk+d8zv3VdehPL4VTnFFUYfA=;
        b=JRhCW2mD4csxwi5j8su8EvDX6EioI3PlEVEoc/PymOY1OLqp3Nh48/cvwGiiXpxMuY
         2SUAjLPlr1zeoN01YhHgrz7OduKr60ozV0SJz0PGmIfNck/oD2nlRpcXFpkLN22vDItx
         y0EVQLk+IbYPgYTVpWYgdMYPxsRYc0qSnS0BTJaXsGqFU1j9gY+YjuMDRzsCaTUN1cUm
         LBo2C6C+wZ95XQx7w99u6H0e4qtyxBRQ908bml6UziBSenxMTwG3pusUvbbQtv34UGwk
         7IubxfsErKH4SHQXM/d+JcqnV9JG63thL2peOIRu7k5jQ9hTJHIcFGh22c5VMYOUH9pG
         0txA==
X-Forwarded-Encrypted: i=1; AJvYcCUjixQ7UtuP8DF1wRSy6D+c6fVahYPLnsuNPYMIK2DBEeGBxDX33ZSNd6OJuznUAEAYaRAsWRZaqRDOADw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwynyTuJAqQSCDEUcHvOrkzMfiY+/1Ez+DXkb3X25zqFGtCiP
	TvCiRt7IY6TIyHbOX0BZBrHhCS6p0q8DhyDzVKE/Okqte7B7qecMe65Xzn4XJO62dbdxyZzC0qL
	x0HZbLEx42lCWyrzXF7dqnU1x9MdHk1n9M0+EPx230RU7B2Njld/WGNKkdtygXn9gmQ==
X-Gm-Gg: ASbGnctWWO482i2xV3UfLXD501ZSQPmHo/AlqtMu/vQ8MCPYlmxb/Y3qaAj6AKiKcCR
	pplWZXn/s5Wmt2s+J0Ruw6d+XMtAfTPS/URiWHnkTH2+tJ/9qCDBUkmHkCSXVeG7ygf02T39L12
	LjhYnTFhj0J82aPiUgM42DGTvSvBMAHUk+llM0fDLK+ZpXAAj5II06qPL3WfOIRAX2VuH9azIDg
	9vL2+mUiDjynDRDkdgBlLxC2iG1SyFYUkqwswboL+YUBDjPWl1At/1rlA6aE0urLBVz/WDrnwHu
	ET850HUzdC4ruQcTGttvwC9ugyytn4Uyz941V6Nfr+D4xF0d1bw/2PMmVbkVn0fmw7J7+CU8SdY
	73j32SS41FQJC3JfwlqXi1ZcJwFgxKLxNMgQK
X-Received: by 2002:a05:622a:14c6:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e6ead7688cmr19213761cf.66.1759877220041;
        Tue, 07 Oct 2025 15:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnuELwL5QI73B4WVO5TE/YGXJBcH4wmy0usuPdmUVIeA6W22PrCCo4miVqp00SkzQZGoYLog==
X-Received: by 2002:a05:622a:14c6:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e6ead7688cmr19213401cf.66.1759877219503;
        Tue, 07 Oct 2025 15:46:59 -0700 (PDT)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cfd377asm153541471cf.34.2025.10.07.15.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:46:58 -0700 (PDT)
Message-ID: <d9b89d5342e4268ab908791b403b5eca61aabb5c.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] genirq: Add interrupt redirection infrastructure
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Manivannan Sadhasivam
	 <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?ISO-8859-1?Q?Beh=FAn?=	
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han	 <jingoohan1@gmail.com>,
 Brian Masney <bmasney@redhat.com>, Eric Chanudet	 <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas	
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 07 Oct 2025 18:46:57 -0400
In-Reply-To: <87ecre32dl.ffs@tglx>
References: <20251006223813.1688637-1-rrendec@redhat.com>
	 <20251006223813.1688637-2-rrendec@redhat.com> <87ecre32dl.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 22:04 +0200, Thomas Gleixner wrote:
> On Mon, Oct 06 2025 at 18:38, Radu Rendec wrote:
> > +
> > +static bool demux_redirect_remote(struct irq_desc *desc)
> > +{
> > +#ifdef CONFIG_SMP
>=20
> Please have a function and a stub for the !SMP case.

Will do.

> > +	const struct cpumask *m =3D irq_data_get_effective_affinity_mask(&des=
c->irq_data);
> > +	unsigned int target_cpu =3D READ_ONCE(desc->redirect.fallback_cpu);
>=20
> what means fallback_cpu in this context? That's confusing at best.

Please see below.

> > +	if (!cpumask_test_cpu(smp_processor_id(), m)) {
>=20
> Why cpumask_test?
>=20
> =C2=A0=C2=A0=C2=A0 if (target !=3D smp_processor_id()
>=20
> should be good enough and understandable :)

This is where I deviated from your initial implementation, and I tried
to explain it in the cover letter (text reproduced below).

  | Instead of keeping track of the parent interrupt's affinity setting (or
  | rather the first CPU in its affinity mask) and attempting to pick the
  | same CPU for the child (as the target CPU) if possible, I just check if
  | the child handler fires on a CPU that's part of its affinity mask (whic=
h
  | is already stored anyway). As an optimization for the case when the
  | current CPU is *not* part of the mask and the handler needs to be
  | redirected, I pre-calculate and store the first CPU in the mask, at the
  | time when the child affinity is set. In my opinion, this is simpler and
  | cleaner, at the expense of a cpumask_test_cpu() call on the fast path,
  | because:
  | - It no longer needs to keep track of the parent interrupt's affinity
  |   setting.
  | - If the parent interrupt can run on more than one CPU, the child can
  |   also run on any of those CPUs without being redirected (in case the
  |   child's affinity mask is the same as the parent's or a superset).

Let me provide an example.
- parent affinity is set to 0,1,2,3
- child affinity is set to 2,3
- parent (hardware) interrupt runs on cpu 3

In the original implementation, the child target would be pre-calculated=
=20
as cpu 2, and therefore in the scenario above, the child would be
redirected to cpu 2. But in reality there's no need to redirect because
cpu 3 is part of the child's affinity mask.

Now, to answer your previous question, "fallback_cpu" means the cpu
that we redirect to in case the current cpu is not part of the child's
affinity mask.

> > +		/* Protect against shutdown */
> > +		if (desc->action)
> > +			irq_work_queue_on(&desc->redirect.work, target_cpu);
>=20
> Can you please document why this is correct vs. CPU hotplug (especially u=
nplug)?
>=20
> I think it is, but I didn't look too carefully.

Sure. To be honest, left this unchanged from your original version and
didn't give it much thought. I'll look closer and document it in the
next version.

> > +/**
> > + * generic_handle_demux_domain_irq - Invoke the handler for a hardware=
 interrupt
> > + *				=C2=A0=C2=A0=C2=A0=C2=A0 of a demultiplexing domain.
> > + * @domain:	The domain where to perform the lookup
> > + * @hwirq:	The hardware interrupt number to convert to a logical one
> > + *
> > + * Returns:	True on success, or false if lookup has failed
> > + */
> > +bool generic_handle_demux_domain_irq(struct irq_domain *domain, unsign=
ed int hwirq)
> > +{
> > +	struct irq_desc *desc =3D irq_resolve_mapping(domain, hwirq);
> > +
> > +	if (unlikely(!desc))
> > +		return false;
> > +
> > +	scoped_guard(raw_spinlock, &desc->lock) {
> > +		if (desc->irq_data.chip->irq_pre_redirect)
> > +			desc->irq_data.chip->irq_pre_redirect(&desc->irq_data);
>=20
> I'd rather see that in the redirect function aboive.

What? The scoped_guard() and calling irq_pre_redirect()? Then, if
demux_redirect_remote() becomes a stub when CONFIG_SMP is not defined,
it means irq_pre_redirect() will not be called either, even if it's set
in struct irq_chip.

Now, I don't see any reason why irq_pre_redirect would be set for the
non-SMP case, and in fact it isn't if you look at (currently) the only
implementation, which is dwc PCI (patch 3). Redirection just doesn't
make sense if you have only one cpu.

Perhaps (struct irq_chip).irq_pre_redirect should not even exist (as a
field in the structure) unless CONFIG_SMP is defined?

> > +		if (demux_redirect_remote(desc))
> > +			return true;
> > +	}
> > +	return !handle_irq_desc(desc);
> > +}
> > +EXPORT_SYMBOL_GPL(generic_handle_demux_domain_irq);
> > +
> > =C2=A0#endif
> > =C2=A0
> > =C2=A0/* Dynamic interrupt handling */
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index c94837382037e..ed8f8b2667b0b 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -35,6 +35,16 @@ static int __init setup_forced_irqthreads(char *arg)
> > =C2=A0early_param("threadirqs", setup_forced_irqthreads);
> > =C2=A0#endif
> > =C2=A0
> > +#ifdef CONFIG_SMP
> > +static inline void synchronize_irqwork(struct irq_desc *desc)
> > +{
> > +	/* Synchronize pending or on the fly redirect work */
> > +	irq_work_sync(&desc->redirect.work);
> > +}
> > +#else
> > +static inline void synchronize_irqwork(struct irq_desc *desc) { }
> > +#endif
> > +
> > =C2=A0static int __irq_get_irqchip_state(struct irq_data *d, enum irqch=
ip_irq_state which, bool *state);
> > =C2=A0
> > =C2=A0static void __synchronize_hardirq(struct irq_desc *desc, bool syn=
c_chip)
> > @@ -43,6 +53,8 @@ static void __synchronize_hardirq(struct irq_desc *de=
sc, bool sync_chip)
> > =C2=A0	bool inprogress;
> > =C2=A0
> > =C2=A0	do {
> > +		synchronize_irqwork(desc);
>=20
> That can't work. irq_work_sync() requires interrupts and preemption
> enabled. But __synchronize_hardirq() can be invoked from interrupt or
> preemption disabled context.
>=20
> And it's not required at all beacuse that's not any different from a
> hardware device interrupt. Either it is already handled (IRQ_INPROGRESS)
> on some other CPU or not. That code can't anticipiate that there is a
> interrupt somewhere on the flight in the system and not yet raised and
> handled in a CPU.
>=20
> Though you want to invoke it in __synchronize_irq() _before_ invoking
> __synchronize_hardirq().

Same comment as before: I left this unchanged from your original
version and didn't give it much thought. This is definitely one of
those "back to the design board" cases. Thanks for the guidance, and I
will give it more thought and address it in the next version.

--=20

Thanks a lot for reviewing!

Best regards,
Radu


