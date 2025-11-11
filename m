Return-Path: <linux-kernel+bounces-894369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C7C49DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E7018807D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE561D86DC;
	Tue, 11 Nov 2025 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hljnO8dA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBE1DA62E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820789; cv=none; b=cOTHwRKNVEJvGxy/tX717K4dPY6I7oiLFWEWBZmebCF1ksoTgcbapddizRAomkGiwv9y7V7VTVxYj5AG82/NR4P9DVLB9PVWUDNJM6eySB6wtFcO985mAU+0J9EEyerdwQ9IELUEuzXAFXPDKe3bRB8m3YpdVEF6sSSNvCSqalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820789; c=relaxed/simple;
	bh=11B5OG3BFeIa+HSUN0j9ki26vjLC9RLJd5ssdki10k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIRsEyZ3Vml1gxo8ZrNUnScjgqkNx/ihJZm3T3ul0FeTbomX/fn5Np9xZWtguGwDuAQN+1Dqr1VIkj5VLNv8QwMTIb2RdQFlbDppcJlj1T5EIP9Hvv5KDhyVGfLRqlBTo7QgVVMMJHcBr1cqQ3p6XrCpL0APmKh+wsM0eaRX7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hljnO8dA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edb59dfda5so52601cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762820787; x=1763425587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrcExo6KTeTkOozMgCGJDk2ooOnRaj2e3VUWOrNKsaA=;
        b=hljnO8dAHlISIR6MKBLw/e9Nb8qnYunERmzz4znK5XCOYRgLL9OZ4FZ4aPDlljpqrD
         q0CJL8zpzoXZOc7HmqnBABLkF0Mp1dV+2kXE+WG+ORzSilsy0GYXZRXqyBnmZ9q/IUmK
         /aB4S8BGEjbP9hp56O19/BqTGNgourtZXdirFCJJLhTx5eQ2Q5de9ycciBzqIdh5gVG3
         dKRdC2z1RWLRGkucLK06QFmTQWn8La2r5oPTr101nnAuMnmY/wFNyZe1cOo57II603Fd
         +oqfzBVJQ9EakEXvK9+VSteUH2BulSn2j1ugZAGnWNUAQr1FRHChkvUL336M8fqr62DQ
         AVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820787; x=1763425587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WrcExo6KTeTkOozMgCGJDk2ooOnRaj2e3VUWOrNKsaA=;
        b=TomsvHv5/9sedend0sCMM/SDalaweH1HGDF7UyNE3SJk/dBbfuu3cUfy4e0bN3tlhi
         tE6ES0WT/LgDIWPj7tac5ChVHpAFr9nAgN5hgyRziQWEVaFYdI2S1xd22wxKF6f1YGpy
         Do9SJ1jDKnMn1YRhiDoDnuM3H2HOXyoC8pmuWCkaPiJRx35dXVXuuPttSQpYwbxTRoyi
         KjNabFobl2SZEzq7cCG3PIhTlRTueRtGNp+EA1Vq3TRwNt12M7Qjk8NvTys6tvxF/IAZ
         Qn9wdyTmMd99xPCqjGBlRdz/P9vNwupbqg+v5/ZJ/kbGY4224jtXYzpUPFdB6MwbCUN8
         ncRw==
X-Gm-Message-State: AOJu0YzmY1mVLaXN286us/TpztWaZCDX/AbrpGnRng/QtBzfQuxhKP/9
	IbsYvKuLO44IuF5qyJvTXRQwOaFbIP24toWFKns3bM/onF37Va+lbkUd2zusRR58s4GEoT1lUut
	Jx+ASWFR8745xF6peifSgpnpRWtmWZkMZcNtsRaUccHKNIHp7SSwzSgkd4hg=
X-Gm-Gg: ASbGnctaOZpoXTgpgxXmisGXodeH14BqR+JQG12OdRt7JglZeKwT5Et8NhwKUXkt/DD
	as3ffpxWSShFZzAQ/amIgROXB8yijWXd+GQ/ehgXyK+waEr/kA3zod3kYoLzkAczew90SFxDBCk
	PN7uGc7OObe02L5yz1AINxFJggc78HujE/6OMdDaZDuRDjYqm4Is2WiHR9RvAudaclI0vjcZR9b
	dyavQQG78EDdgo8dpQA7kyyPQzCjWOZb7256bXR7RLf8xPFB85XBNfIpXOTUoT3Sdtpe4sZHg4b
	8Zpn+w==
X-Google-Smtp-Source: AGHT+IGOZnRSg1Ss3tLeQex8z9s3XYcXM8YxVkDaSrS7HeaMPy0/ge2w1k+DM0HxJ8J//Clu520QCORr7D0Mp9ZPpso=
X-Received: by 2002:a05:622a:28b:b0:4ed:b665:3779 with SMTP id
 d75a77b69052e-4edcba56788mr2948691cf.16.1762820786810; Mon, 10 Nov 2025
 16:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMOZA0+TMC8FsFfboe5RKqYNRxYm=cg602p5FXAwpyA64Y4yHA@mail.gmail.com>
In-Reply-To: <CAMOZA0+TMC8FsFfboe5RKqYNRxYm=cg602p5FXAwpyA64Y4yHA@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 11 Nov 2025 01:25:50 +0100
X-Gm-Features: AWmQ_bkIx95-unvJTdifS3Jv_RrBOGnfjVLdDsV78uRj1Y597L3H-W4nWWtChlw
Message-ID: <CAMOZA0K1fh4Yb6ZhibE7u3gAqGQDA8V2kUPr0W3t+dNPa4EqVg@mail.gmail.com>
Subject: Re: [POSSIBLE BUG] behavior change in irq_can_handle_pm() introduced
 in 8d39d6ec4db5d
To: linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Sean Christopherson <seanjc@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 10:30=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wro=
te:
>
> BACKGROUND (just to explain how I found the issue; it may exist regardles=
s):
>
> I have some code (soon to be posted here) to implement interrupt moderati=
on
> in software using using per-CPU hrtimers. The basic logic is the followin=
g:
>
> - if the system decides an irq needs moderation, it calls disable_irq_nos=
ync(),
>   adds the irq_desc in a per-cpu list, and keeps IRQD_IRQ_INPROGRESS set
>   to prevent migration. The first desc inserted in the list also start
> an hrtimer;
>
> - when the timer fires, the callback clears the bit and calls enable_irq(=
)
>   on all linked irq_desc's
>
> The relevant code is the following:
>
> @@ -207,x +208,x @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
>
>         raw_spin_lock(&desc->lock);
> +       /* if moderation kicks in, disable_irq_nosync() and set an
> hrtimer. Keep the bit set to prevent migration */
> +       if (irq_moderation_has_started_timer_and_disabled_irq(desc))
> +               return ret;
>         irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>         return ret;
...

after further debugging, I found that the problem is that disable_irq_nosyn=
c()
operates lazily. It marks the interrupt as disabled but leaves it on, actin=
g on
the chip only at the next interrupt. With this change
8d39d6ec4db5d genirq: Prevent migration live lock in handle_edge_irq()
the next interrupt will find IRQD_IRQ_INPROGRESS set, and block
until the flag is clear, but that could only happen if the timer handler we=
re
allowed to run on the same CPU.

I guess the problem can be avoided by calling
    irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
on the interrupts where I want to use the my changes in handle_irq_event()

However I still wonder if the change  of behavior is intentional or an unde=
sired
side effect

thanks
luigi

