Return-Path: <linux-kernel+bounces-745760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA7B11E11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E65E1C27C01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF16242D90;
	Fri, 25 Jul 2025 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEJ+cng8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985873F9C5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444979; cv=none; b=Fv3EA517T8bXoVG+aN0Qe69bx6vhc3InO7HS3Cjqb332O4CXonO7rY1ShRLiq9e9H+LC9TGYvslVZg6ouq+AoyzDg36iw+00C8CXK6CfAYjaPQizcFFKDbHXvnqYNB6DKmZBDrMniDAstB8sGq5UdjO4LbZwUgfvyOSLv+BYKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444979; c=relaxed/simple;
	bh=fqZHebi6Bkb5eNifT3yZFGVku7zV66aFMdE+I3t/4aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlDqFLoB/OhIGGtAHac7q6EMB4l+RZEO4irUFdnpjFsxMRnOSsnKJrCQl8Zs3D2ygrd/vyT5JI1mrO0lm9yHiWAo9DFqH8SSHLwDIU8IA2i/2+qUfM7PL3qQ8FvWLJoi3Rb6d007Vl/vCq7IoQJIvctevJ+1EN7nZkWcvmLjHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEJ+cng8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753444975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbQ/CoKfRcOyF5XiIEBvtnbaZCP8pb630WPcqbF6yL0=;
	b=TEJ+cng8MfgxdTCt+GwyAco0Ofme/j1bBHqnLu3z3Pefpl7TG1+5HLiaOo2LJ33ZVkzINt
	Tg5AqaO2WDue6TzhI2vm7JZLVO6xKHyEtyfHrdOuNOJcrxLMkiawf8d2qqGzqTOhzchg2O
	b2WxVQ+k2S1CIEKMkPf4PSosPcJWUdc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-3TotNayhMpS0L-VhGFjtXw-1; Fri, 25 Jul 2025 08:02:54 -0400
X-MC-Unique: 3TotNayhMpS0L-VhGFjtXw-1
X-Mimecast-MFC-AGG-ID: 3TotNayhMpS0L-VhGFjtXw_1753444973
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade5b98537dso253603466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444973; x=1754049773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbQ/CoKfRcOyF5XiIEBvtnbaZCP8pb630WPcqbF6yL0=;
        b=oAGGF6YAPgFsJ0GediVZ4ohsLhXWa6veuN+2K56hfKMb1C8vXW9bjUjT/cIUaPJnjU
         zuUzAP07RxNMrlrGF93Xipa7I4V9mcQwcRXkYvV9/LCig4/bcCOLvt4w0I8vShYWjbYA
         U8Hhb1Lb7ElMklf/ZqF941a1QTe5jDQgVrv165xpbHXjsXCfpYnev31Nov79feMuvZRH
         8E8U4wocy7z1fEIxEYMZBMUr88fBPrTS4npqypTCf+ozIMfXE1im2fJ7LXEALQk7xaEU
         aApDAoR9Zu8I7jNxlm88zgL1J4a/bJWgKuH677aOH+xEz78T3/8rjCIIDksxRAOtCIvD
         AGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxLanSsYYYHUG2VEx4ooCxGZK/hHBDyIP0NA67x+ZrnHIs7L3TPfQ7v1ngBaRNwLeOol0ch6HwRQfoX1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvkW71/m1Og9x2l+LVH17RiYCgQfcQYEnixvhcdsDJPjoi4zk
	pyrnM8d/9x6UD23ZSSxq4+UKCafGvgxDXShRIJYNGS4bmtjbX/Z1ZJcQWT4GXgBlZWSe/Bunt50
	EdEnfqu4oTD3YZVmmA+SgVJaUKF+vLIx+48ibJOUByjvSS9ALyjlAiv2evtyDX6FVYy09lG8sd9
	qSzgq5fkzf+Ak4SBXeihGeqsgbqmDkXf9Yb0kJ+kql
X-Gm-Gg: ASbGncuAkidTcQDQ6XqWhiNbI2fMJSO3XxoT7+Vph4u9ZcczwvgPD0xJ5oFJ22hXGUY
	lM8PVqUF+GthlOoyhi3nMhL+Ry0M07Uf8sfT1NrFLpbVIeG8NmEJ3KY+uKGwis0uS8WsqzTVta8
	T2jhxG84diCzsBdBpKkUBBJDZylLFYwGy9u99Ov/JdYFoarsoqhl0=
X-Received: by 2002:a17:906:9fcf:b0:ae4:1149:2cbc with SMTP id a640c23a62f3a-af6191fff1bmr211864666b.46.1753444971196;
        Fri, 25 Jul 2025 05:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3CxGIXlbxFP3lOtiuZkdJlIwaUJx81JfXJ3+HOkhXlu3QfRGy7bD/MWcI9pNg2Pb+acrpaFHuNWexg0NHk0=
X-Received: by 2002:a17:906:9fcf:b0:ae4:1149:2cbc with SMTP id
 a640c23a62f3a-af6191fff1bmr211838966b.46.1753444969189; Fri, 25 Jul 2025
 05:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701060337.648475-1-costa.shul@redhat.com>
In-Reply-To: <20250701060337.648475-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 25 Jul 2025 14:02:37 +0200
X-Gm-Features: Ac12FXwuR1pQjDETnTbqboRWzFRIjKwg3JsbDbHR5v4frWCm-lEfoXogMPmmqq8
Message-ID: <CAP4=nvQMyBMay9unMuz0TmkF7pSmHV39iwinSnc3UbuLvOVa=Q@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Consolidate common parameters into shared structure
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 1. 7. 2025 v 8:04 odes=C3=ADlatel Costa Shulyupin <costa.shul@redha=
t.com> napsal:
>
> timerlat_params and osnoise_params structures contain 17 identical
> fields.
>
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---

Thank you for the patch.

> +struct common_params {
> +       /* trace configuration */
> +       char                    *cpus;
> +       cpu_set_t               monitored_cpus;
> +       struct trace_events     *events;
> +       int                     buffer_size;
> +       char                    *trace_output;
> +
> +       /* Timing parameters */
> +       int                     warmup;
> +       unsigned long long      runtime;
> +       long long               stop_us;
> +       long long               stop_total_us;
> +       int                     sleep_time;
> +       int                     duration;
> +
> +       /* Scheduling parameters */
> +       int                     set_sched;
> +       struct sched_attr       sched_param;
> +       int                     cgroup;
> +       char                    *cgroup_name;
> +       int                     hk_cpus;
> +       cpu_set_t               hk_cpu_set;
> +};

Some of these could be cleaned up further. E.g. "runtime" is actually
only used by osnoise, even though it is declared in timerlat, too, and
"period" is also used by timerlat, but it's called
"timerlat_period_us" there.

Nevertheless, that is directly not related to this patch, and tests
pass. We can fix that later.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


Tomas


