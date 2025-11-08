Return-Path: <linux-kernel+bounces-891714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA1C434F5
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0406D4E10F6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8743281520;
	Sat,  8 Nov 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gh65WWLL"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441025FA2D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762637458; cv=none; b=VeAXDs2KBpBgCw1DGL9ckXlPD/gi9r6Z9097tPQDqeeWWdMq4oVaYFrjvFtzNZS6zBAH529aj5a0MHRSockZg1QMC5XB4jSXhHHUQdg1Wvr0g6G1dJchIxjxWRT9VcSptoSixFs6mNXTC8R1Bt9eTTql9RGVUBvA48jEEBSr0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762637458; c=relaxed/simple;
	bh=LOeeAX8k7I+OmVJz2InAQN5nfI2mlenWqq3TeCPY6jM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LaDh/95iDxyBrsrHA9LrYuoTcxQH17g/ZDeP6y2ZoZXJGZrX0QCFvJ677j0JSspwsis2EdbmUg+JBWcB08XDG7eN1ImNgH+ljWWxiQCO1BvrJDVXeLLDwEao10bOYQdKCydyP/J0X9F6/ymFJaO9QviAhISFBIrteNX3682H+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gh65WWLL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso230151cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 13:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762637455; x=1763242255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cSM2HJT6ViTM5VLEGlSV50ke0YFVBZ7XgHed58TyBfk=;
        b=gh65WWLLNeqSXSluxvt+PNEcq2U7tWxvmzjN69geWgaZDdQWU8PIEjorMcGoencAmd
         yIthU60nGE0w9eEGDoQhzgbLjmcTuV4MEwI4du8+/DFoPxLLoT1Yp5vzcKIiMWry9BbO
         Tzhp8y9fCuDe7rl7Gvth7HzGQsJC5lMWQK5lFKj1otI7EyNKVaTpLXQm0O3Uc1DBAvEa
         l+m3oJMjSxB2MH/n94+GahbFbATNlAfdpyHQ8QVW3DD1JOpaGTC2rl7QaR4ejBnd1z/l
         CyyrtbBd0oR+Zn0wLn7qvcnEMW8EDegrRPLCDOhIG984NW5I16C/JBDpwlEyH+RJOMO0
         F3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762637455; x=1763242255;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSM2HJT6ViTM5VLEGlSV50ke0YFVBZ7XgHed58TyBfk=;
        b=sUqMBmseBcn1k1q59qHkbWr4ZXoppHladIYKrvryw6l8cSK6OA1MJvv8gry445fddk
         uMbjiMiCbNCaVxwimJ4JpAZ6BFuZSzy2xvZEtgpQAtRjDc5JO9EbuMeN/0lm+1acWQ7b
         pOXxPxKapBZByBJSLA52NWFgf0FPH5TgVDY79Cj+A9yhk5j8O6J/zC48uZ73LnRWq8TT
         dO0J573MpQMBCIoQktyVNi9/FhNQUUm7VHmOuLAMftWlyGPZgBxBXZMS87PGN4sN7goP
         KUh8fNkQ6b5i6ZAfKWV9+0UlX5dsUSmIwG7TmbYbXR59Gv6IC32d6b1eQNgRDLWaT5Nq
         b5Dw==
X-Gm-Message-State: AOJu0YzUyUzWhzVDnccuJfsuoY13A2OuN6iUTTmxTeY+9rwOkaH2wRxz
	yZXis19SNOOB15fqe0UsihaoJ0S51VaKq3MepId71GwKqf0SCTg1rYyK6E7SwhKySp1ChjO6JoO
	iuFx1S7blO4nofMYNA35O5SDa0cisThxP1FdOIRLMsD/RpBuxX/uL9pFx0Ss=
X-Gm-Gg: ASbGncs2t98/VLheiCxX+m5vbHG20lbghG+zSL/lAcUuUOSJbGrROue3XzLeG+o7T4H
	YwKd4ISxQ8hicLWfuUhpv1P4pv9ZioEkyZGeiPOA6tP2PldB26imBcEbffQmyZXx+ZQrzQ95hdk
	61txD/gkw2fPuDqd6vfLyjO6BIPl3PnLFDhaXWGQnvrn4SICSL7gNF05Fty1YQUV9CLA3PKtFMs
	Va+vSYvcKcJgTUUowVmQ7fqqvwjijmsyquvat1TXxzstCX3EmSySJCAnfJridrDJrkXz7k4a+9g
	d03H5w==
X-Google-Smtp-Source: AGHT+IGBxYqc4FE7mr566zDKciraD0xJzMnnrm6ukrJ7kxT1YhABui9ZUiswtL0GfOEDUcM+AN2mafuN61Y+dKjtBiE=
X-Received: by 2002:a05:622a:205:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4eda4d8b6c3mr6137331cf.2.1762637455199; Sat, 08 Nov 2025
 13:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luigi Rizzo <lrizzo@google.com>
Date: Sat, 8 Nov 2025 22:30:18 +0100
X-Gm-Features: AWmQ_blb6VAzikiqW94qVMzinymsmRrKZA190uJPZYyH4L3sgss3geXVwG291sI
Message-ID: <CAMOZA0+TMC8FsFfboe5RKqYNRxYm=cg602p5FXAwpyA64Y4yHA@mail.gmail.com>
Subject: [POSSIBLE BUG] behavior change in irq_can_handle_pm() introduced in 8d39d6ec4db5d
To: linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Sean Christopherson <seanjc@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

BACKGROUND (just to explain how I found the issue; it may exist regardless):

I have some code (soon to be posted here) to implement interrupt moderation
in software using using per-CPU hrtimers. The basic logic is the following:

- if the system decides an irq needs moderation, it calls disable_irq_nosync(),
  adds the irq_desc in a per-cpu list, and keeps IRQD_IRQ_INPROGRESS set
  to prevent migration. The first desc inserted in the list also start
an hrtimer;

- when the timer fires, the callback clears the bit and calls enable_irq()
  on all linked irq_desc's

The relevant code is the following:

@@ -207,x +208,x @@ irqreturn_t handle_irq_event(struct irq_desc *desc)

        raw_spin_lock(&desc->lock);
+       /* if moderation kicks in, disable_irq_nosync() and set an
hrtimer. Keep the bit set to prevent migration */
+       if (irq_moderation_has_started_timer_and_disabled_irq(desc))
+               return ret;
        irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
        return ret;

and the timer callback does the following:

+       list_for_each_entry_safe(desc, next, &ms->descs, ms_node) {
+               list_del(&desc->ms_node);
+               INIT_LIST_HEAD(&desc->ms_node);
+               /* To prevent migration, IRQD_IRQ_INPROGRESS was left
on. Clear it now. */
+               raw_spin_lock(&desc->lock); /* maybe not necessary ? */
+               irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+               raw_spin_unlock(&desc->lock);
+               enable_irq(desc->irq_data.irq); /* valid if the chip
sync_lock/unlock are null */
+       }

ISSUE:
After the following change enable_irq() almost immediately causes a deadlock
(it used to work before):

8d39d6ec4db5d genirq: Prevent migration live lock in handle_edge_irq()
 kernel/irq/chip.c | 41 +++++++++++++++++++++++++++++++++++++++--

likely because the extra checks in irq_can_handle_pm(), specifically
the chunk below:

@@ -501,x +504,x @@ static bool irq_can_handle_pm(struct irq_desc *desc)
                        return false;
                return irq_wait_on_inprogress(desc);
        }
-       return false;
...
+        * If the interrupt affinity was moved to this CPU and the
+        * interrupt is currently handled on the previous target CPU, then
+        * busy wait for INPROGRESS to be cleared.
...
+       aff = irq_data_get_effective_affinity_mask(irqd);
+       if (cpumask_first(aff) != smp_processor_id())    <==== is this correct ?
+               return false;
+       return irq_wait_on_inprogress(desc);

QUESTION:
I am not sure the condition indicated by the arrow matches the comment.
Can someone clarify ?

Otherwise, for my use case, I have successfully tested the following change,
which reverts to the previous behavior at least for my specific use case:

@@ -501,x +504,x @@ static bool irq_can_handle_pm(struct irq_desc *desc)
                        return false;
                return irq_wait_on_inprogress(desc);
        }
+       if (irqd_irq_disabled(irqd))
+               return false;

thanks
luigi

