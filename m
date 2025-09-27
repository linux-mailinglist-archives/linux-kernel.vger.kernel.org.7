Return-Path: <linux-kernel+bounces-835024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A4BA6121
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122B017C7AA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF902E1757;
	Sat, 27 Sep 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeIDa1nO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNGC4QJW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFB1DDC08;
	Sat, 27 Sep 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987915; cv=none; b=DNbOTXqubKtTarmUI5z1czEUm2gvRVERbJ+XXrws5tR2kaiTK89QC7gazKE4Y8diw0+69d7cv6hyigw2C8YOGWV5RsIjN9yDhBnV9UblydEKxfF+sSHpcUC8xcpko+qDck44Fi256Vic1bSzTUel4/ZA6wjc6Wk1nCTMLUIUjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987915; c=relaxed/simple;
	bh=06i685LcDNM6BzO58wldlV5tA/KtXEtqEukaMe+xteM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cxSEPaFKGqzgoyVcOeGUVKdzum8mMQFXBeRewp4Wd+3wH8+9tmclcghSRM7Hi7j/WjM+UCfrFPSIkTFoNmB4E0Rf+GLAprrsaAW4T9ce16nEXKXdALitxYXQhZuvb+WXb/mp/Fn3DvM86dT+FPE6VLDKPMLsk730knPMedz4zpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EeIDa1nO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNGC4QJW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758987904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFyUFesXh9jwAhNOq4uvsEBGZOdhiu9YWCnDE/iJlAY=;
	b=EeIDa1nOc6WSGzFtd1cyirs/Lweqy5WnPC0PgJRnWgVxw6FIqXyBUK1Wupx69Dr6hZSyy/
	2ElwuogEeTa0x89TB+qpXPYuF8OUjt/HtdH7rWdISnB6r7UEhTvY8/sCmJqxDsRaJsk7wj
	nRTpBSd3XO8WrBu9rV3ZKz6WJiGoFvQLJ/wfynFJOWMusmduSZU1dE3gLxv/cynYLpHEE7
	FD0T3xqBuUZ+KfgyVwZ/NyZIIqrM6koE/KVoARAvzFLxeHM07D3PkhAGkJiH6lK2nqoiMm
	wtyrY/xQcfMd52FIZFc5+7eAhoRd6Q9LMxB/+QuwuBvQLrUEmM5ORsc9jTcHGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758987904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFyUFesXh9jwAhNOq4uvsEBGZOdhiu9YWCnDE/iJlAY=;
	b=jNGC4QJWK1BzfHMkHlKKOzqENxqv9AUDhlFoRjwNjl1X4PSSeHWvjGv3prtvrccl5W6c/P
	O3pAuo1fhHpuYyBw==
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ciju
 Rajan K
 <crajank@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: christophe.jaillet@wanadoo.fr, platform-driver-x86@vger.kernel.org,
 vadimp@nvidia.com
Subject: Re: [PATCH platform-next 2/2] platform/mellanox: mlxreg-hotplug:
 Add support for handling interrupt storm
In-Reply-To: <34d028ac-f907-1505-a2fc-f455a10cfa5e@linux.intel.com>
References: <20250916054731.1412031-1-crajank@nvidia.com>
 <20250916054731.1412031-3-crajank@nvidia.com>
 <34d028ac-f907-1505-a2fc-f455a10cfa5e@linux.intel.com>
Date: Sat, 27 Sep 2025 17:45:02 +0200
Message-ID: <87zfaf3nnl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16 2025 at 13:00, Ilpo J=C3=A4rvinen wrote:
> On Tue, 16 Sep 2025, Ciju Rajan K wrote:
>> This patch provides a mechanism to detect device causing interrupt
>> flooding and mask interrupt for this specific device, to isolate
>> from interrupt handling flow. Use the following criteria: if the
>> specific interrupt was generated 'N' times during 'T' seconds,
>> such device is to be considered as broken and will be closed for
>> getting interrupts. User will be notified through the log error
>> and will be instructed to replace broken device.
>>=20
>> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
>> Signed-off-by: Ciju Rajan K <crajank@nvidia.com>
>
> I've a general question on this approach, probably more directed towards=
=20
> Hans, Thomas, or others who might have some insight.
>
> Are drivers expected to build their own workarounds for interrupt storms=
=20
> due to broken HW such as this? It sounds something that should be at leas=
t=20
> in part handled by something generic, while the lower-most level masking=
=20
> and detection might still need to be done by the driver to handle the HW=
=20
> specific aspects, there seems to be a generic aspect in all this.
>
> Is there something generic for this already? If not, should there be=20
> instead of adding this in full into an end-of-the-food-chain driver?

We don't have a generic mechanism for that. The core handles only the
case of unhandled runaway interrupts.

I agree, that there should be some generic infrastructure for that.

Something like the incomplete below, which obviously needs some thoughts
vs. shared interrupts and other details, but you get the idea.

Thanks,

        tglx
---
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1927,6 +1927,10 @@ static struct irqaction *__free_irq(stru
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
 		irq_remove_timings(desc);
+		if (desc->irq_storm) {
+			kfree(desc->irq_storm);
+			desc->irq_storm =3D NULL;
+		}
 	}
=20
 	mutex_unlock(&desc->request_mutex);
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -22,6 +22,44 @@ static DEFINE_TIMER(poll_spurious_irq_ti
 int irq_poll_cpu;
 static atomic_t irq_poll_active;
=20
+/* Runaway interrupt detection */
+struct irq_storm {
+	unsigned long		max_cnt;
+	unsigned long		last_cnt;
+	irq_storm_cb_t		cb;
+	void			*cb_arg;
+};
+
+bool irq_register_storm_detection(unsigned int irq, unsigned int max_freq,
+				  irq_storm_cb_t cb, void *cb_arg)
+{
+	struct irq_storm *is;
+	unsigned long cnt;
+	bool first;
+
+	if (max_freq < 500)
+		return false;
+
+	is =3D kzalloc(sizeof(*is), GFP_KERNEL);
+	if (!is)
+		return false;
+
+	/* Adjust to cnt/10ms */
+	is->max_cnt =3D max_freq / 100;
+	is->cb_arg =3D cb->arg;
+	is->cb =3D cb;
+
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		if (scoped_desc->action) {
+			is->last_cnt =3D scoped_desc->tot_cnt;
+			scoped_desc->irq_storm =3D is;
+			return true;
+		}
+	}
+	kfree(is);
+	return false;
+}
+
 /*
  * Recovery handler for misrouted interrupts.
  */
@@ -217,6 +255,19 @@ static inline bool try_misrouted_irq(uns
 	return action && (action->flags & IRQF_IRQPOLL);
 }
=20
+static void irq_storm_check(struct irq_desc *desc)
+{
+	unsigned long delta, now =3D jiffies;
+
+	if (!time_after_irq(now, desc->irq_storm.next_period))
+		return;
+	desc->irq_storm.next_period =3D now + msec_to_jiffies(10);
+	delta =3D desc->tot_cnt - desc->irq_storm.last_cnt;
+	desc->irq_storm.last_cnt =3D desc->tot_cnt;
+	if (delta > desc->irq_storm.max_cnt)
+		desc->irq_storm.cb(irq_desc_get_irq(desc), delta * 100, desc->irq_storm.=
dev_id);
+}
+
 #define SPURIOUS_DEFERRED	0x80000000
=20
 void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
@@ -231,6 +282,9 @@ void note_interrupt(struct irq_desc *des
 		return;
 	}
=20
+	if (desc->irq_storm && action_ret =3D=3D IRQ_HANDLED)
+		irq_storm_check(desc);
+
 	/*
 	 * We cannot call note_interrupt from the threaded handler
 	 * because we need to look at the compound of all handlers

