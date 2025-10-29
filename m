Return-Path: <linux-kernel+bounces-875682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F0C19979
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C99034E2478
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9B62F5496;
	Wed, 29 Oct 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDeN95tO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AA23E342
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732600; cv=none; b=ChrECIL27if1jfT5hx6mhbZ4YOoNbi+mKLNLo6kFuNI5ZpyrT6H29+ifUG5V4FHANtbaWnJY/+Zgj6P3rnZGswkuZzcg45Qm7Kb7uBAxN2qLpBv6d3up29FMPNBc2XKRVxIkbT1HPN9l/K3/rzz4CiN3Di4Fzst7Sdvdq+TDiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732600; c=relaxed/simple;
	bh=Q+xHtZ6LCUfDVi4zhyxd0pSM1tPgfsgGrZ8Ux4ie/xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ev1AKhwAWX1xiBmLrnjWJxiCyIEpsy2cQ4juzhuZzzOaVfygzuJ1FMu+rsVXunBDrgyflz2mksB6QCOSpCGZIthlRfbjEiIWYFzuxRa8OoPcgf1HZc3YTbmO5zbvf+J3SCV28FwCY9+NfXc4sq1kDjuTmMkRj13w+wMlGK4he4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDeN95tO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7va99Zg9nu4+XxtsT3y+i0Qg89ua4ByIHfysL3F+F4=;
	b=VDeN95tOHiAf5nLj+XF/8L2OMAhP13w8G/DDQel8bmKmlWTDkwwLEFxGaLv8QHhri+Islz
	ClSDlFMhn62ZWJRiRAIzX6xBfCni1aWEQhOtIVuWs8Rx8s6/kC1ihI4u7aGF7zvdeSxlnW
	BUDU9OkeHYJpCW3utqFQuKluGXM/3RY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-tJiY9DE8O3ugeiiLWlvOeA-1; Wed, 29 Oct 2025 06:09:55 -0400
X-MC-Unique: tJiY9DE8O3ugeiiLWlvOeA-1
X-Mimecast-MFC-AGG-ID: tJiY9DE8O3ugeiiLWlvOeA_1761732594
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4298da9effcso4895619f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732594; x=1762337394;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7va99Zg9nu4+XxtsT3y+i0Qg89ua4ByIHfysL3F+F4=;
        b=eC+vUkbCpR7/G93F0IMWIdgGyUcaIMbAEW7YiOfQr91L8nFexbzvaePhD3QOOZvp8F
         jXRB8aMvVLgyiMxbHo3HMPC1dYNszrIVBmM9o0iLCMpLb/k2COfbXRBz0SeeQCt2iAul
         sFAcKr3wRHiC85XSsjrjicSJwlpBgHOnmJx5A/trznqlHdSc75FJPjXPyu/9qZKaPqC9
         j7ya0t7oD1wse0bF+ttCPzLYmWHY0OB5y3ssNZeRsr959dH6+qr3xr3hLP05njxkdUxB
         /mEdwuKxHOM2UfMNMM1Dd0H4oPAazgCIzSEbFAPXXb970iwcbVZ8LpSzR2YZEocn5WJT
         /R1g==
X-Gm-Message-State: AOJu0YybV4ft6OGOjiQZG3/I4ORb1xaH8Ko2KQFkkP6b+uADuYMY2lTU
	g+pD5mHfjoUVdPr7YPu4vpQepOdQlIhU8jPnna1M0Ecyg+AlpVfWyBr01SYY3UDXPaAjPEoYspU
	W5ddjapJwdYlYRfgD83VGH/Uykd8Wju/XphZ0c+a6+HE967vSOUY4MLtObIRHIHjIfw==
X-Gm-Gg: ASbGncujc+ewNuMgFRzAJKbMGWP1yMkEQcU9jIXc9cjj70cFkgzfSogdS5hpQzmZ/Y3
	L8LIzY/PZZqS18eqw39wyRYrtSekGM3Xd4u5cz5Nht2D3F/mNcjCwlQaITDWrlCDJVGfpMtECsB
	6ahu7tmd+eC64gugquQKllK6TmfwpRjMX4UZLytF5tyQtwIrhwaEQDOK1QEXgbHNJjQyX79bD04
	EHmJE8rkEDEZ5HUdIINcOSrAUlfxpDo7Nyn7OnFK341wjCRzcNZxdNmfbqSPsdg8BLmVSVPjb8E
	teyV06wD8CN2PNW9ISj2ItG6Ad1lyLAzHlcXe0Ui8/RJDueR5gKjC4HPrMPawWJolMgCtd79p8I
	6tl+tikBvUIUoKx/RYSJ6S98O54suHRfcA42QexAZgV2kzSohcNNuR+rTCrGH
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1733928f8f.18.1761732594344;
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMwZOd1Sm4LKIO70Dn8iCGAQm9z32hncQVtTx+dFITCY/jcrLahS/V2gOWr58H4oqqEmvh5w==
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1733872f8f.18.1761732593822;
        Wed, 29 Oct 2025 03:09:53 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm25467518f8f.47.2025.10.29.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:09:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Nicolas
 Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
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
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <aQDMfu0tzecFzoGr@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <aQDMfu0tzecFzoGr@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:09:50 +0100
Message-ID: <xhsmh5xbyqas1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 15:00, Frederic Weisbecker wrote:
> Le Fri, Oct 10, 2025 at 05:38:33PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> +	old =3D atomic_read(&ct->state);
>> +
>> +	/*
>> +	 * The work bit must only be set if the target CPU is not executing
>> +	 * in kernelspace.
>> +	 * CT_RCU_WATCHING is used as a proxy for that - if the bit is set, we
>> +	 * know for sure the CPU is executing in the kernel whether that be in
>> +	 * NMI, IRQ or process context.
>> +	 * Set CT_RCU_WATCHING here and let the cmpxchg do the check for us;
>> +	 * the state could change between the atomic_read() and the cmpxchg().
>> +	 */
>> +	old |=3D CT_RCU_WATCHING;
>
> Most of the time, the task should be either idle or in userspace. I'm sti=
ll not
> sure why you start with a bet that the CPU is in the kernel with RCU watc=
hing.
>

Right I think I got that the wrong way around when I switched to using
CT_RCU_WATCHING vs CT_STATE_KERNEL. That wants to be

  old &=3D ~CT_RCU_WATCHING;

i.e. bet the CPU is NOHZ-idle, if it's not the cmpxchg fails and we don't
store the work bit.

>> +	/*
>> +	 * Try setting the work until either
>> +	 * - the target CPU has entered kernelspace
>> +	 * - the work has been set
>> +	 */
>> +	do {
>> +		ret =3D atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_S=
TART));
>> +	} while (!ret && !(old & CT_RCU_WATCHING));
>
> So this applies blindly to idle as well, right? It should work but note t=
hat
> idle entry code before RCU watches is also fragile.
>

Yeah I remember losing some hair trying to grok the idle entry situation;
we could keep this purely NOHZ_FULL and have the deferral condition be:

  (ct->state & CT_STATE_USER) && !(ct->state & CT_RCU_WATCHING)


