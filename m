Return-Path: <linux-kernel+bounces-884842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF18C31487
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2663F1890BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBF328B60;
	Tue,  4 Nov 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdXPn4Bi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMHt/x+V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C131E115
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263965; cv=none; b=A/74CROgE/TWfDURCVcbgbcSlxh3KE4lBkVMH5IXcgbSqJyUdvL6hTZ/iVcxQz/4eC2/ywDIbqO9wxx9VLz9VGp2DE3XS4Z0EUxAUfzBTJucC2DVJyf3YjjFkMiZEKza93TQd6DzlP/YIrCK/v9OdNe0Yx9Lm1JEaRWUYlTNddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263965; c=relaxed/simple;
	bh=6ox1zLtoIs3WHKjGHBqzO0nCO9DbDq7atxZ/hCyqdAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UW05j5LjxE3WzWzfgGt7fW4nZWYcKPxSdjHXBVKWC8tmOKVHIpZELV61Zj6e2eCFHMlYqYwgrr7e9MVge8+6de5xyrFUFU14Clm96BKkG1y/kMk0yROvXC3KIyIExS8P+qC60Q4k8whrH/0RVLz5JE3xzNo1hdCn+MJ3wW/rMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdXPn4Bi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMHt/x+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762263963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
	b=cdXPn4BiheZehvRQV5G5TL3atlV5pq+uCVrZVVoNrOrRag88PHqIG8ii98twd5ioLWgfg6
	nScOjySFscMDOM7VBmOCunZbG7Ujnb4b2+iJgv1gr9pCLhMNw0/AQRPTAG69367iVdMlqb
	N04lWcdlzYmbbL8e5m5JPgCWM2iVgS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-M8AiYmmrNHCBlJ77cfx1lA-1; Tue, 04 Nov 2025 08:46:01 -0500
X-MC-Unique: M8AiYmmrNHCBlJ77cfx1lA-1
X-Mimecast-MFC-AGG-ID: M8AiYmmrNHCBlJ77cfx1lA_1762263960
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c521cf2aso3356873f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762263960; x=1762868760; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=NMHt/x+VCxgooirjQLCDYJGfq8eGEc+jKFlWyvmdixqj96mNwWuU4Omudek9PMSfdE
         tV4V1t799ZzjfSAgaIwzl4L34z3/dUL5Wb0Z3U9vifro98PyB3buEXmKMgqci9aZzBiK
         PePyAZ6mTZU1uAgenNEPT1bpOp6lYZTXrBvN58KrDF1n6vytzFIHN70Pmj5U4ESIVg8a
         94TRVqT6L4ar/Y/7euFJDAoXZxmJtLdOBdDO6xNAUng+3PjwwBCPLrUsHPWgGSFQDs1e
         WeHAUBAxR9BGWj26DV75bCuu2KGI/PYpGhbRbawb6cl9j8o2lxWtIyniVd9ntxLNVr+R
         AW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263960; x=1762868760;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=l/GlJ1Rg+ncHiMe6FO6qhAyfvdn3HYOMHObJ6GUY5I7ZvqNL7rBAHZzq/fr5TDjWbN
         h7Unyr6nPtKKqbmmG9gUaFXBky+oy4WJQmMnN+N7FLP252sFi2b3gWyPaqbKR7lHVWQV
         enh9k1eNeYXc5l/7TbnKJavxFQ5osU6IyjBnCeRTCH66+OgvQbjOcYlu/kH5TeGrA2yd
         GbQEoW0TZphw8J80BueHTLAtZzgwN7U48rgJFD4VHi8BLMBIqJ+/UiUuw3vG9tCNomCQ
         QM4JkDdebnCH3tukD3n9pChJhG2tGo0pYDPR7/4EB/VqJW+js3KGJ1mUNSl8u269uy/U
         Y+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCOfgh0s0aZafbBfVIMKgksFDQ1Go4HLlTdspmSq2nR9iX1J0CgZV+taa3P8WFnRiZHHYe4R515J/gf4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPchvKzQ5vsHPrYn2821DLknco2fnLwldPHdehOkOoBYJEWd0
	1fy6Op19aoXpt/1xIqsBoSxkt9Ix/vPe0wsj5bI8O2U1HlwKb4VRP/t257fT8nb49yycnV9PyaC
	EIC5FyGoRc+LY+JeZNllUPsutaHnfysK8R4LUbP6eP+O6XTBpS+Af90dGZeUK6uBNAw==
X-Gm-Gg: ASbGncu5AwuugKee/pDDZ6xs3OYIgN06oN8GkdfvHywyQ1g6SCmY4UzQEC7V28c6w8s
	jFy5AgGmP6rtYCZ2PwKjE7VtUU3lDWJM9+UjtfFK42GsiVBbos0WTaAQM5GGZ3AvgWxjD5E7ZpC
	Nhl8G+Nv6iVfIkvprD5OgMbInLrhSyg7WjfYdSNvODshkVHG/8HhHgtj4MRi03Go0cINe3TKRnx
	hfFgClU5Eqtz2CgnyGuepot+6YU4+yj++axW+JzQEZBiWqTY//mnuwpKl8ZTVBZAfVGBzPqQI7l
	rJp6jsGOi7y98tpRA5idN3vzXGFVLhwkDHBOWVoLIIamsxfZLig4v5iF+5NsXBbX379duUCdytH
	m9QxM39t/+o0SVIGda+GNZV4ePgSU7/4Z12I=
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284626f8f.41.1762263959606;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRnKz3y+r5XoY3ls/nBZPt8sht5PzwdeS+jf9m1q52xASXswgB53muxrTyL7Mvrv/sZwgkKw==
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284574f8f.41.1762263959010;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a01:e0a:36d:2b80:e937:44f0:a96a:94f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1a8528sm4959089f8f.21.2025.11.04.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:45:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
Date: Tue, 04 Nov 2025 14:45:56 +0100
Message-ID: <xhsmhjz05ud0r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/11/25 14:02, Shrikanth Hegde wrote:
> Hi Valentin.
>
> On 10/10/25 9:08 PM, Valentin Schneider wrote:
>> +++ b/include/linux/context_tracking_work.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
>> +#define _LINUX_CONTEXT_TRACKING_WORK_H
>> +
>> +#include <linux/bitops.h>
>> +
>> +enum {
>> +	CT_WORK_n_OFFSET,
>> +	CT_WORK_MAX_OFFSET
>> +};
>> +
>> +enum ct_work {
>> +	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
>> +	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
>> +};
>> +
>> +#include <asm/context_tracking_work.h>
>> +
>
> It fails to compile on powerpc (likey any arch other than x86)
>

Woops, thanks for testing!

> In file included from ./include/linux/context_tracking_state.h:8,
>                   from ./include/linux/hardirq.h:5,
>                   from ./include/linux/interrupt.h:11,
>                   from ./include/linux/kernel_stat.h:8,
>                   from ./include/linux/cgroup.h:27,
>                   from ./include/linux/memcontrol.h:13,
>                   from ./include/linux/swap.h:9,
>                   from ./include/linux/suspend.h:5,
>                   from arch/powerpc/kernel/asm-offsets.c:21:
> ./include/linux/context_tracking_work.h:17:10: fatal error:
> asm/context_tracking_work.h: No such file or directory
>     17 | #include <asm/context_tracking_work.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> Gating works for compile, but no benefit of the series.
>
> +#ifdef HAVE_CONTEXT_TRACKING_WORK
>   #include <asm/context_tracking_work.h>
> +#endif
>

Huh, looking at this I wonder why I shoved that here. That include belongs
in context_tracking.c itself; I'll fix that.

>
> I have been trying to debug/understand the issue seen with isolcpus= and
> nohz_full=. system is idle, even then it occasionally woken up to do
> some work. So I was interesting if this series can help.

Is there some ongoing thread for this particular issue or is this just
something you're experimenting with?

If you suspect stray IPIs hitting isolated CPUs I'd recommend tracing with
these events enabled:
  ipi_send_cpu
  ipi_send_cpumask


