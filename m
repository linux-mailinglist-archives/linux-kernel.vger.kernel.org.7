Return-Path: <linux-kernel+bounces-852433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C899FBD8FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9984D4F80C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C773074B7;
	Tue, 14 Oct 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLtaCswH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851D2FD7DA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440815; cv=none; b=Zqo3uu5ubAxaGDWqRKXrInsO1s/Ms/OG1vAUoqLZtqb9CxhfPX7YYI3/L2HuvT73tTZVGWuNssZVdUaM+AAw9ubUg/JceZ0oti/QbAZyXI3svJr0mdt332dwrVyrGIK4IjcvQW2qWaUkA9Bi3b5o3UisD05X8zYW1wQaixVtdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440815; c=relaxed/simple;
	bh=yX5dyBuNEa2OXACHjn8fnbGsDn2mXnkquyRkiu3aCD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBNsfGlOGUqeFCl9ifZHmEfD7+vzxiCYe358edEosUYXjj5Y4tvoiB3U0y5a34QN0Go16iQtth5LywfdNp+bu8A5aawPUco0p8m5EMusZ+LXSX+Gf8PbHn6kYzFmw8KOsr359A2GBjAtPerbPF/p6b1dQ2FTtc9lBaYuM+OHKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLtaCswH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760440811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Imuve1iPcSxB4uVU/yFQsIzQ6zKzpq/61jJo3KbkM2Y=;
	b=JLtaCswHk/AW7ow1AFK8jpTTCTDmRdtWf4uRPQp+yJ+Cxgn9K2tK3EJ3EGx3Yxyuv5VOvW
	8MeIBKkAvdUbrmjYWsS33vur/yPGKfntdccd+N0/n4Jaz5s7kZS2eR6PLLvt3t0j3RlMxC
	JICyHnc66knRbsr4oO8lRpKs7rDX7So=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Ux4aw0vOPRG_k8GZL0yj6Q-1; Tue, 14 Oct 2025 07:20:09 -0400
X-MC-Unique: Ux4aw0vOPRG_k8GZL0yj6Q-1
X-Mimecast-MFC-AGG-ID: Ux4aw0vOPRG_k8GZL0yj6Q_1760440808
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e41c32209so30235465e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440808; x=1761045608;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imuve1iPcSxB4uVU/yFQsIzQ6zKzpq/61jJo3KbkM2Y=;
        b=Bkv+1STpowTp8KqKHO13AP5fueq7C9L+oGTTY1L7ZQpKrfri+pcReI1vtXnGbAB+6D
         k2oq4YATtPWG+OxmXeHWqCjVhcVan4IULLW8KIJ7PShPz0FVue3k43Ho3jGQ5C07ylyv
         5r6zXRvx2nngpkRog136Zg7B/0d1XHVX2s1rpLC1opNftrWtAoFN7cv4wtw1OWT0PG8l
         MPgJ/Dc9oKdZgI4GtinxO0MjYJ+Fj/8+i6fvF4Yh0Ikhq9fqUL+rVoLvi6JOKDNr74fj
         Hv+LANYCbhtDKZN7AHwLgyRWXsOr5NVeTWUVEwNadyP7//XJXRjKCjlE8Zd3dY+M7vrt
         u3Zg==
X-Gm-Message-State: AOJu0Yw9+OTU9hRU0huQJEu5Dwwjvgj/S+W1d8MCfpDpdxZohOfKUZAd
	h9+yrbb1NeXyl7mIL60TolB52TDJKm8AVG/+nXS9K1s8nx6xw5tIvSFPlvGgsr7S3FjkOAgpC+2
	G5+U7g303LDE+hfOf6SQGh6cv6fG4yJ8LDl99nz22kWotozDpW4x41tDcgftCSeNqqA==
X-Gm-Gg: ASbGncs9yvK2clbyF51gvxX5tGJC+di5eyFW9mSWt6onQu5lpUAX7Wc8kE7C04vmNCJ
	uLNoLB0nVIkOpDcNd9Pwa7acnOI/TDk0gs+3arhN2gky2dMAPz8w9lt2WtT9vIP5rMCENL13Ln+
	AUgayx6vLUwZgKPqkVWFxlkeCRtVEUo1eSV0WpJgETY36nVhqNKXGJsNxPY0IsFgEvuOyjTSlQR
	QXPaHWTuJFjf7XwecBCo6Edqy5xalKR6QVX8fx/nQtt29p7bVgCZvXEJXJA1dUB+Lu5sCipmePw
	vuHkwLofwLpHuykKMk3lMphhcj3USRFxZRIXHA8YR+Or1DxmBPk3ppfmR4PAY2UIdVjX8EGRFiK
	ve6Eln+0WH5/WBE3rPDjoi1ylyg==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr175576655e9.36.1760440808236;
        Tue, 14 Oct 2025 04:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPNHhJVacE21hOu+c1s40cKBm99NOdKTbqBsl6lzaW/V++U98Y1cwp6CoRkBLGlZny7BSyXQ==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr175576075e9.36.1760440807708;
        Tue, 14 Oct 2025 04:20:07 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265506695e9.0.2025.10.14.04.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:20:07 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
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
Subject: Re: [PATCH v6 16/29] KVM: VMX: Mark __kvm_is_using_evmcs static key
 as __ro_after_init
In-Reply-To: <aO2TKOY5JV9OoRUg@google.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-17-vschneid@redhat.com>
 <aO2TKOY5JV9OoRUg@google.com>
Date: Tue, 14 Oct 2025 13:20:05 +0200
Message-ID: <xhsmhtt01pw62.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 17:02, Sean Christopherson wrote:
> On Fri, Oct 10, 2025, Valentin Schneider wrote:
>> The static key is only ever enabled in
>>
>>   __init hv_init_evmcs()
>>
>> so mark it appropriately as __ro_after_init.
>>
>> Reported-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>
> Acked-by: Sean Christopherson <seanjc@google.com>
>
> Holler if you want me to grab this for 6.19.  I assume the plan is to try and
> take the whole series through tip?

Thanks! At the very least getting all the __ro_after_init patches in would
be good since they're standalone, I'll wait a bit to see how this goes :)


