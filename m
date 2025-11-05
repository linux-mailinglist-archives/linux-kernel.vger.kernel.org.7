Return-Path: <linux-kernel+bounces-886915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4635AC36BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62125686076
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12769331A53;
	Wed,  5 Nov 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmopsFdP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sx6xZJAe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49D32ED57
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359879; cv=none; b=MO4TpjotW0vp+xTSCPBXRa+cYtaoa/melBUagLXNdHUiaSU48xO24B7UT+DkEqXVMqb4vmmYDSkwXBBWMJo7y+VR2+vlP0TbVCoUaX/GeVjWWo/aHomE58x6PNUnIGOJVMgBCaI09tXvEE1HCOKu7MYKUpkyMUCg0wQZX+Var80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359879; c=relaxed/simple;
	bh=Fflidx7xTzSLnI3Prwh+YYynUZ15M7y2pcYRBHfDZ5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQDmMWLm9NVcgKXPHMFn2tFBWagt84sJHKfNE95NDikV1FOTiWxHu384kjWPdguBaCjR2y7R1JpBrLvOW3zHk56029SDDlGLhyRMUSuAVIOx57lrYbLQ4ANEoCenY7kspCECK8Y0dQ0fzU3ERPuNpCogWA/GRlEJ27FvfAJGs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmopsFdP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sx6xZJAe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
	b=DmopsFdP1EdJvoClL2S9EALuNLiB8sEYj6RifbSP342V8EqpKpo92ULT+JyUdn7Iw5/veS
	bGzK1sb03J0NXHZb6wyERWVbWOPgPRCVsC63KkaOejukzp+hQUQNcmw2QFHgBwU1pw3aUX
	bVc1JwRV53e/4rMfD5FTM7nbqzdG3PM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Hwv9NntBN0CneF5DeQqJlw-1; Wed, 05 Nov 2025 11:24:35 -0500
X-MC-Unique: Hwv9NntBN0CneF5DeQqJlw-1
X-Mimecast-MFC-AGG-ID: Hwv9NntBN0CneF5DeQqJlw_1762359874
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c9024a1dso6128f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762359874; x=1762964674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
        b=sx6xZJAeWrJ/FWhIlpDsmLBxNiEwg6dZsXRmYP89t7A7X5KvvdMQYT8Q+MwbJn4WSK
         aT4ju4OaijoBFmIm+9c+1uBX4ZGZ8Qg1Yhw+b/crCs1w2Y2IQ6C1W8qD6n60Ilw6ITC3
         6Qrr9JRj4RZfl+zK4vdIuwZU1erqE3/AVavL5Xxj7wFN7qaz5aPKmVn42F226+xT/xmL
         ULdENN5+HnRXPllvNPHiO8yJrS0Giw/rClOLNfA7k4jPi52T0wqrYLsYGytdkkQBr4hO
         AIlmKzvr04NTHDh/rmZkjws+PFqwQEwvjd73eGjLK+JACoepuI/3y+bDNZdCQeTqhhHM
         gZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359874; x=1762964674;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
        b=K1mq60868PF1hq+/1nreRz2vA9YCeFvTzeVXGjHAbbsb6kZL1J3AxnqDa/FgZdQRUX
         8ulI4bLtMnV1lJH7wRW7sRgm6/be+iDDEj+KqsTDhR7UYF7N5Rd9yJWSI1yxdABv3MKJ
         3KahU2Ro1BOahWZnrIOGYiUeddVbK3OCqrsg79hAn3DWERJ28bKAr3veaV7dutHD7mpZ
         EkHZ2zN19Qh/fBQHZm6uCFm2wM8cvHhqVvrVtzRFVlNQBh3n1Brg1CEEC/fcfjTf87he
         3HNmpJNZC0OgkVd+mwtdiXIJQFEwsvkdby4C68aqCFXcEpefManFCD+VoCo1vbUAvO5E
         xY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLTV5DFMhNBIo0vrr0mxiVSGDq4IXetU2lIQ/mB6VWXLboDF2YYVi63bxpkYKYqEBLd2qtbNfaaZC6vPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CtpqcK8DueRNN/dVDJh9q0KpHwiT3unPh00f5Nq5enf7fGE8
	M4fRN6LcMv7vqFbcndHh9U9tJUO/jWGYd+zl0Jbvi1m5rR41RIC7uiVAMQ+vsCoW7m0KbFMqRBH
	vwuQrYBbvI+unN7EI8Z2vwpHakRgolAA/oBksoAq3x5VvuMpIvZe5XkaPATjs8GhaXQ==
X-Gm-Gg: ASbGncvYtEDO70oVfG+2I9EKhb9hPkdma/z0Sv0sc1mRyWJoC9/QHgqFWF2q177ydIJ
	/n46PdpoH7iDngiWGYTKE/nNFAF66T2TtkVTAsmEyMlGGbenruPoUyAA5PbRmOf8ljurtvAEv9i
	KhCaBhJbWTwd5ERUCRJyFSe/XNhXakvi1CiQ3IF/kTyhW+7r0fctm2YkuHrfbzNWO1muNi2SuEj
	lxDKQ5JmObb77Wl970mBwh9JmgwGkiwzLCFyS4c3VeCtE+l1ikUsnhs2lLb98Xx7yWbWsVgfGCk
	QoSkNcVuDkO1BZOFsC8VVwgcdRpML+EtkhTUZFMqOdnw4zEFKykiNdUK37dUvyO7lXk/VBec0z3
	DZndc+zembe4zC0/BGI5oacvB32Eph4vmYPDt4mWQrUCszHBGA32+3RmLaMqn
X-Received: by 2002:a05:6000:2907:b0:429:d4c2:cadb with SMTP id ffacd0b85a97d-429e3311ac6mr3563238f8f.58.1762359873635;
        Wed, 05 Nov 2025 08:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL75fsQ0H2l1YahgWByyszuFW6670iMBa0il80FwPsU0pgmLcV2khMdpXTiSamLH801kgv9g==
X-Received: by 2002:a05:6000:2907:b0:429:d4c2:cadb with SMTP id ffacd0b85a97d-429e3311ac6mr3563132f8f.58.1762359872637;
        Wed, 05 Nov 2025 08:24:32 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fd2a7sm11003113f8f.39.2025.11.05.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:24:31 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQJLpSYz3jdazzdb@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQJLpSYz3jdazzdb@localhost.localdomain>
Date: Wed, 05 Nov 2025 17:24:29 +0100
Message-ID: <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 18:15, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a =C3=A9crit=
 :
>> I need to have a think about that one; one pain point I see is the conte=
xt
>> tracking work has to be NMI safe since e.g. an NMI can take us out of
>> userspace. Another is that NOHZ-full CPUs need to be special cased in the
>> stop machine queueing / completion.
>>
>> /me goes fetch a new notebook
>
> Something like the below (untested) ?
>

Some minor nits below but otherwise that looks promising.

One problem I'm having however is reasoning about the danger zone; what
forbidden actions could a NO_HZ_FULL CPU take when entering the kernel
while take_cpu_down() is happening?

I'm actually not familiar with why we actually use stop_machine() for CPU
hotplug; I see things like CPUHP_AP_SMPCFD_DYING::smpcfd_dying_cpu() or
CPUHP_AP_TICK_DYING::tick_cpu_dying() expect other CPUs to be patiently
spinning in multi_cpu_stop(), and I *think* nothing in the entry code up to
context_tracking entry would disrupt that, but it's not a small thing to
reason about.

AFAICT we need to reason about every .teardown callback from
CPUHP_TEARDOWN_CPU to CPUHP_AP_OFFLINE and their explicit & implicit
dependencies on other CPUs being STOP'd.

> @@ -176,6 +177,68 @@ struct multi_stop_data {
>       atomic_t		thread_ack;
>  };
>
> +static DEFINE_PER_CPU(int, stop_machine_poll);
> +
> +void stop_machine_poll_wait(void)

That needs to be noinstr, and AFAICT there's no problem with doing just tha=
t.

> +{
> +	int *poll =3D this_cpu_ptr(&stop_machine_poll);
> +
> +	while (*poll)
> +		cpu_relax();
> +	/* Enforce the work in stop machine to be visible */
> +	smp_mb();
> +}
> +
> +static void stop_machine_poll_start(struct multi_stop_data *msdata)
> +{
> +	int cpu;
> +
> +	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))

I think that wants a negation

> +		return;
> +
> +	/* Random target can't be known in advance */
> +	if (!msdata->active_cpus)
> +		return;


