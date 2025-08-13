Return-Path: <linux-kernel+bounces-766971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB15B24D44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA57188C1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8211FFC48;
	Wed, 13 Aug 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyTQjz51"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DECE552
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098474; cv=none; b=PHLELFzCUDjuQ5Xg91Qnwm6YuEA9cL//qddjSpu4hLYLUoEOVrgyVi7afK7eERS5ehJc81FxKUl06NYO7Y2ZxeIQ8WMM7wZYWwOpnWu3uOCj9Cm9SdwREz1JNxO0z5ERQxHLvLRToenoabkKr/TkUlGLGwGBteZThYkHjmF0Yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098474; c=relaxed/simple;
	bh=nFpRbMroKafM+dDm6nExWR7VozXay9T91wyChCitxz0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgaRb3scNog9Xr6HImVprdrssB2qy6VrsixXReK9FzlHOlntwoa6sLdLiAakncaQh7juKndv5pFpbcTbqKpo+79eVo+4xd2z+2M3xuUqLRmYNhYTuLupMLyoh0Un1vu8QpaCv98akpvOIeYqMIiY3VmWUB//mAnpq1PGprZIq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyTQjz51; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=flVnXsx44sh01X2C5wM+u4nowv0iTUk1RYQOxQaNj6I=;
	b=EyTQjz51at5JVIIoI3PH6SmgBLp2hxA2ODbVPCLJuFctj7wddaHckgmlBMuZQtkZn70mnW
	goTttwLHWK2WY1BN9v3KmiVnNstEwX5dwq2LYkYcv7azIVk8ULI3YoaV4ueWwthEikyfw4
	08m9LtH2Xy4F3nM35wpFxJESJQ8FSLk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-toQc-vjTNqm9RBxnaYT8rA-1; Wed, 13 Aug 2025 11:21:01 -0400
X-MC-Unique: toQc-vjTNqm9RBxnaYT8rA-1
X-Mimecast-MFC-AGG-ID: toQc-vjTNqm9RBxnaYT8rA_1755098461
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f55eb56so150966d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098461; x=1755703261;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flVnXsx44sh01X2C5wM+u4nowv0iTUk1RYQOxQaNj6I=;
        b=a1RNDkHN+xeb5Hw2r0kcZ7pf53lxdvJ9aVPqVJmm1l8YAL0oX+HAgFXO7Aenhu4ewU
         RVko89/f5DYKWU5X1TvzsvkP9L8DsLRIWNfyqLyOoCkOkU2CTTP9ovh6JgpkvnB/j/tK
         l3YI1g3kEO7PmycjmPd+dqs0alIEx48FcZOgUcZnDfSBzpfbv6xDTgF65ZAfnwY11l1o
         Mk/1kRz+RUQdSDwh2fV1aboh/d6FBZeeKcRYEBvB3z1SoEfNL87xLZ10XGfUE6kUj9kV
         zzNEoDIcqsa2BC17KIDOT1Y3lUBhIped5r5UI5U8oOrPnN3RXHpyOHCx4cvywhPSdD6Z
         n7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVGvTUDdKrag+szllyowYKg33V3Vf34FdLcO1NE5L+f2lyIq1erOLRwbqS3VUOz0e4/PIQ3FfuLupM3+EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEVN73FnHYQ62Z/+YZfHxWOGCtyHMOokJF9H+vowElujqHQ9m
	mcUosPONbUQgl7MT9Yv7QtDLfs34NKr1pVxktzu/FNseUmQw+Jl0uPfYukVUl08A/gAkB6gPWO5
	CyYM4J5K+kviC0E8g1KG/ZHZlZ1AHP1fQ6US85MFdUeLqPg3FtyNiIhrgURL4tVEcew==
X-Gm-Gg: ASbGncvLDnLCQ69CZiylzK2RLXGwktZ6diiUNB6SAFE7cEXlhxYS3ORnVX1b1aheb2c
	zb1p4ICua1Y9QZ5qHYtqufsyXtr4X0sLbHoykZsx/lec7zwYVbfDC72197d+bDqh+d1kPl9oo5T
	wC8QuJjGRhcXEPIoUa85AHGPNPRJN37H/GuavlG3kjpgRvv9mnqQC7ueDz1Uid/bhMRdBP/hL8s
	73uLSWNsMqncYJl4TovnaWkryd2oI0AZijkdyD5DyWU9StCgfNjk+zodN0hN7IjlZDmSZomiUWi
	/cmKsj4DQidcQK1f9YDgm5KOYptZq8l604EKEp77h1YjihB1aPEuefDD1+aghqEcFQ==
X-Received: by 2002:a05:6214:21ef:b0:707:4c65:e71c with SMTP id 6a1803df08f44-709e8919f97mr35262646d6.30.1755098460719;
        Wed, 13 Aug 2025 08:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGppVocx+5fz7SFJA6HUhKgHQSB4mOlN6d7H8+jpjQt3BMt+fBR8D+Znn60rS18V/0oWAdyGA==
X-Received: by 2002:a05:6214:21ef:b0:707:4c65:e71c with SMTP id 6a1803df08f44-709e8919f97mr35262216d6.30.1755098460119;
        Wed, 13 Aug 2025 08:21:00 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm197383136d6.70.2025.08.13.08.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:59 -0700 (PDT)
Message-ID: <b4e804c7f7b2661690144ae96a6526676d960a4c.camel@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner	 <tglx@linutronix.de>
Date: Wed, 13 Aug 2025 17:20:56 +0200
In-Reply-To: <4b99074a-af21-4d14-b995-a4e62275a62f@redhat.com>
References: <20250808160142.103852-1-gmonaco@redhat.com>
	 <20250808160142.103852-9-gmonaco@redhat.com>
	 <4b99074a-af21-4d14-b995-a4e62275a62f@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Tue, 2025-08-12 at 13:20 -0400, Waiman Long wrote:
> On 8/8/25 12:01 PM, Gabriele Monaco wrote:
> > +static bool tmigr_should_isolate_cpu(int cpu, void *ignored)
> > +{
> > +	/*
> > +	 * The tick CPU can be marked as isolated by the cpuset
> > code, however
> > +	 * we cannot mark it as unavailable to avoid having no
> > global migrator
> > +	 * for the nohz_full CPUs.
> > +	 */
> > +	return tick_nohz_cpu_hotpluggable(cpu);
> > +}
> We may have to update the cpuset code to fail isolated partition=20
> formation if it includes the nohz_full tick CPU as that CPU cannot be
> fully isolated. That will also make this patch simpler.

Good idea, I can check that!

[...]
> > =C2=A0 /*
> > =C2=A0=C2=A0 * NOHZ can only be enabled after clocksource_done_booting(=
).
> > Don't
> > =C2=A0=C2=A0 * bother trashing the cache in the tree before.
> > =C2=A0=C2=A0 */
> > =C2=A0 static int __init tmigr_late_init(void)
> > =C2=A0 {
> > -	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE,
> > "tmigr:online",
> > -				 tmigr_set_cpu_available,
> > tmigr_clear_cpu_available);
> > +	int cpu, ret;
> > +
> > +	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE,
> > "tmigr:online",
> > +				tmigr_set_cpu_available,
> > tmigr_clear_cpu_available);
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * The tick CPU may not be marked as available in the
> > above call, this
> > +	 * can occur only at boot as hotplug handlers are not
> > called on the
> > +	 * tick CPU. Force it enabled here.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		if (!tick_nohz_cpu_hotpluggable(cpu)) {
> > +			ret =3D smp_call_function_single(
> > +				cpu, tmigr_cpu_unisolate_force,
> > NULL, 1);
> > +			break;
> > +		}
> > +	}
> > +	return ret;
> > =C2=A0 }
> Can you integrate the
> tick_nohz_cpu_hotpluggable/tmigr_should_isolate_cpu check into=20
> tmigr_set_cpu_available() instead of special-casing the tick CPU
> here?


I could but I'm afraid Thomas won't like that [1]:
> This is really horribly confusing. This function is also invoked from
> the CPU offline hotplug callback and in context of CPU hotplug this
> check makes absolutely no sense at all.

The whole thing changed a bit since then, but I think his point still
stands, tick_nohz_cpu_hotpluggable is not meaningful from hotplug
callbacks besides that very first invocation.

Or am I missing your point?

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/875xgqqrel.ffs@tglx/


