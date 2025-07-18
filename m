Return-Path: <linux-kernel+bounces-736662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE31B0A023
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BDC4E4E71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1AD29C340;
	Fri, 18 Jul 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfMAu2qu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5F29B78C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832329; cv=none; b=AQLHzKp+W/L91JYNjddHeu084QsITDr4puXSUCb6QTXI82PNsWSIIy6RxCwqqYqfzhnhMAfNIDD/fGybaJKrxQUSczQXafqABsbyMwiIDhA9XRTYhjpBzCF2+YYhdIyAQfXMi9iYBIVrpYGSBK3dpMRoF2uoFRcOYFgdJV9tQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832329; c=relaxed/simple;
	bh=C1u3SeOfU8siLDJDWYdnGerVmJzUiHSnMZ8GmambVJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jp4mwBp71lhdl3LkPKbtBa43/CZVsxjAcEHD5qyF8qAHFFu2RdHtA8laKJLyWEAaQ/195qFy1R8Ynx6+Ig8ndtokRD6XFtryFx4UCx+y9wAtFpRUHcmT/qx15Y4Z+MOCSsZXcIizX3yx0oJcPRSS2iIWcHswlO6a3puRB4VriVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfMAu2qu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752832326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ux/hzx5C176HvRqmPS/Ipsjetu2RZl8NkYz5HyuD+7A=;
	b=PfMAu2qusihNSD8ApK22lLyhMlb0CpS0p1yH0QLIteWzoqFruki6FKzooGbQDLfSO1vIPN
	9Zv3ljf2C7Emt98tg18DLN+ceo1Hp5lTNPyLqh2u8XslaoNcLJy1UqkI0iCRgP52hlRVW4
	2kRUwgliUB0LBfb5GuODceZ5jIeqPaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-7sLOCPqpOAuhSUB0WoQ9ZQ-1; Fri, 18 Jul 2025 05:52:04 -0400
X-MC-Unique: 7sLOCPqpOAuhSUB0WoQ9ZQ-1
X-Mimecast-MFC-AGG-ID: 7sLOCPqpOAuhSUB0WoQ9ZQ_1752832323
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a579058758so833982f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752832323; x=1753437123;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux/hzx5C176HvRqmPS/Ipsjetu2RZl8NkYz5HyuD+7A=;
        b=TZmi9fBpIJujaZI6K0xMMEaMV0yuTzgS+Jnx6DQQ1AJYw9yiEw0zrCb+J5QxAF65Nt
         RujNO5r9RESMWshCn0VmnHwVlUT/1IJQ9cfwsQlcXAX1CzIacwPwIlEfXwInf1BP87Sn
         YL0yaSbOI1Ldbs5QGv0MgNqasNadti+bIGrz0TUC3U57ANrr23UsSGVTzFTLDJ57tfVG
         Ki26CFe6jSdGPgKua9/X5Nn5LvZZGPkIFkSc2mrrnKlXLTSP8vee/rlny+KZv5AQ+C5j
         LgARhTVOjruf9hrbjusTlQm7Pb3+hjrhAsu1/fNrOppv9SEhoSZIIYEs91r9a6wWZmmk
         UJkw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZGbtOwvZ5sSB19EuC8P4ilLMW9+ALDucaiSM2pVtM9NNhg9HHWwiJMzlW1nwk553/6kbgwqDAsDlIZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxH3FNjTMXOBKWx00dwMt/oGjHsPuHrv5iQ0715dxfAw/O3WqU
	cl1yEt+Ic7WZSEZHBETWa620dLoRTGt+rNEcjJpt6XonTTZX97eM2pBy1Zw9lW/hHOR0PVPPDc6
	HhieafSvaKsde8lijpIDbMYwUNSJf6xVKvKoS/EZkhF5aV+ehTh8FGDXt+Q34aRjX2A==
X-Gm-Gg: ASbGncvCVjkC356sNEe30ZASxWeVgTRS1rp+EToug3Ri/fi1FjwZOs1NYoG7P0ASWOY
	UQfqeMy4nZLJXXY4wAe/03pgkqd4KfFHv4uUmsL8OGHqbMN6C6AIF0ziCl4BlT7mLPnCsOZfgLp
	NqC5DuRb6/W8eGTqBosC5lt0kdutbrfNBwAd34JccYyJSxgJjRo9Za8HYDZ/+x4Wb3FrxZy5qIJ
	mijjclEWPEiKbOVjlW9n1pAXGKSgOnnXUqDNkObwhufdcuzpDpNf66ByIw0asL3FSgewyz6ySWR
	tRdzpt/Y6ZnoWAREVik7XjaTFYjyL84vhIm/fL/9m4t+vvxc8CjmrYgMd4YBIEpkZThDnAfPY+6
	GlTYt43oi99kPEaU6zQg8NWok
X-Received: by 2002:a05:6000:4028:b0:3a6:d967:380c with SMTP id ffacd0b85a97d-3b60e512866mr7457759f8f.36.1752832323466;
        Fri, 18 Jul 2025 02:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1SmrX8lGfL+0KhzfNKuD00GVP8Jo/phR2+TCQIYTwdF1q4Q4M8vr6EMgyQhgkZDbAylcJ7Q==
X-Received: by 2002:a05:6000:4028:b0:3a6:d967:380c with SMTP id ffacd0b85a97d-3b60e512866mr7457737f8f.36.1752832323102;
        Fri, 18 Jul 2025 02:52:03 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bcc3sm1376864f8f.27.2025.07.18.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:52:02 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Michal Hocko <mhocko@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org
Subject: Re: [PATCH 5/6] sched/isolation: Introduce isolated task work
In-Reply-To: <20250703140717.25703-6-frederic@kernel.org>
References: <20250703140717.25703-1-frederic@kernel.org>
 <20250703140717.25703-6-frederic@kernel.org>
Date: Fri, 18 Jul 2025 11:52:01 +0200
Message-ID: <xhsmh1pqdg726.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/07/25 16:07, Frederic Weisbecker wrote:
> @@ -77,4 +77,21 @@ static inline bool cpu_is_isolated(int cpu)
>              cpuset_cpu_is_isolated(cpu);
>  }
>
> +#if defined(CONFIG_NO_HZ_FULL_WORK)
> +extern int __isolated_task_work_queue(void);
> +
> +static inline int isolated_task_work_queue(void)
> +{
> +	if (!housekeeping_cpu(raw_smp_processor_id(), HK_TYPE_KERNEL_NOISE))
> +		return -ENOTSUPP;
> +

Am I being dense or this condition the opposite of what we want? That is,
AIUI we want isolated_task_work() to run on NOHZ_FULL/isolated CPUs'
resume-to-userspace path, so this should bail if the current CPU
*is* a housekeeping CPU.

> +	return __isolated_task_work_queue();
> +}
> +


