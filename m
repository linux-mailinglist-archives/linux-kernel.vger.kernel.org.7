Return-Path: <linux-kernel+bounces-794701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3908B3E5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735B816D5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74AD30F538;
	Mon,  1 Sep 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC3tky4O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640103D994
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734503; cv=none; b=iydfh6sCVnrgCM2vg2xcl2Q2vMqmaSuUvAdbCcv76A5v4IdTabbx1RftVjwybfGD7E/QWC0LbdCBAG3g3obobvOVh6Be2W4zMvvxOPqTYHoqlIA05OTybomSsz4ueYXqvbcr0ppvj+M0p4fUq7qVxo1/y1Inl34A/Cjoa5c2Bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734503; c=relaxed/simple;
	bh=AHszT23Huh2XjYc2STiC7WVfHQ8zKN1BCtLtD2/0uHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJvDxgj8TkQevIMiT9K7VlfSpSm9BOJTTEol5T+mgvwN9SnYcfl1AYWKz2PSOuymtIgghnO9O0XUyZOY0gAJbIJbrNEw0AkcwVYxusA2Dj/0ue+OKQ7hlHKy5nDmYI4lDNUjYMabJsykmVMgmMFOTHgfLckT32cMmTvWZBOm870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bC3tky4O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GIeV4lcIY/O5JTSGrX0U6lNL9nd3EIBWIkkKW9NsO10=;
	b=bC3tky4OWiP4VyBUVxuxthSMF8i0B8ikkytHGmyoVUGrjoImVB880tXn3S+l9vYWoRLtt3
	/NtjRQORqlmFuX/vQbFTrfmhiNqjhXRTbgzFFg8MCFEkNSoYT2Jse4gQV0UkvFpA54PEoU
	lfoMJ2hrlFZ12Ntp4RKc/Kn9+t+z67o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ed1NiieQOXWtljTKq2myjA-1; Mon, 01 Sep 2025 09:48:19 -0400
X-MC-Unique: ed1NiieQOXWtljTKq2myjA-1
X-Mimecast-MFC-AGG-ID: ed1NiieQOXWtljTKq2myjA_1756734498
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b87609538so17901555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734498; x=1757339298;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIeV4lcIY/O5JTSGrX0U6lNL9nd3EIBWIkkKW9NsO10=;
        b=WNpjzYTBfi2SvXCq95JXzeEs2dmjcwf/+TUep2BrngOlvbkur/RD0IKWwxXrKrlZfP
         WDFSJuU/qX+K3eVhHhOD+1kSjlK5S4s+jLvb3hqrd8UideeoLAXzvJ+U8FpQrnqMQDAJ
         OV7dvuSxEzB4ZPHtLvgo4shHJBqK0hlK5Z1oGi8R/F2fhVj26nRi/h3FFLPXLMpq9H5d
         IaRTxoMUNY6z/UfYfPt0VIfYcwAxwqDgbkKBV93U5p9xo8YRxSUDpVC7FkYywNfI4iry
         if3jEY23fgvJqIFuA7zkTdSzF6TUTZaJNWvajM8Ng2AeTv9cpgniCZHvqK9TepUFHATm
         KMWA==
X-Gm-Message-State: AOJu0Yz25vL7uTtVPqhkR/d3Z/6ut5qgfrCJ1AOExR92VAGIZjUqjM9t
	tks+CNQcLuo13Muba8owV1q6HVYWCVoXkWcDvh6dJSWHirlYvAl5saOBFWIN0QOy58yfnHGRqW8
	zgWrUN8XGabhg6yz4STkPc+HKfeiKpKWy9xNQn+j9GV1E6v+li7bqwU0om9xSavnkiA==
X-Gm-Gg: ASbGncvuXjMAobCtqSMebXsgIoz6yTHbuXgkThrE7OnyfSP19uNtunmifqlj/KNid3z
	mVWTJfMUczQqEaVjJRio2Os/Nii4wCRmqkTLb6KnuWAOhkt9ltAEYILFv0XEg1JYbkVgvTrg8Jy
	PSQZyL2jwQ6NwpjjTF4hxHF0tjtdCDjUEgrkYqRIEwb1mdI6JtI2spkK2mC9i3pSqkdQJ48kF4O
	Fkxk885qW8iGCxs9JS2zeY3PQd5Soo+w79SL7eG7LFQqpaV7s/YmkUFofERtSrXGt9nqIprmg9T
	zUKPSBZ0s6plYPFxqfo6Lm29TeMuOXoRZtuYBWsJIbjAlgGh/5RToL/e/uJe2AfVWA==
X-Received: by 2002:a05:600c:1e89:b0:45b:88ed:957c with SMTP id 5b1f17b1804b1-45b88ed9c1dmr47009375e9.25.1756734497777;
        Mon, 01 Sep 2025 06:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/a1pUlLase+ftUjbIS0dVQ9muNjHuBvoCtq3c4ffBwG7ejChRrkHGZz9RNqtDd7lskj9krg==
X-Received: by 2002:a05:600c:1e89:b0:45b:88ed:957c with SMTP id 5b1f17b1804b1-45b88ed9c1dmr47009225e9.25.1756734497324;
        Mon, 01 Sep 2025 06:48:17 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm157741835e9.3.2025.09.01.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:48:16 -0700 (PDT)
Message-ID: <d001f1bc9a87e031cf4f8721d6843013c766c28a.camel@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>, Waiman
 Long <longman@redhat.com>
Date: Mon, 01 Sep 2025 15:48:15 +0200
In-Reply-To: <aLWUkpKgFFVr_TEx@localhost.localdomain>
References: <20250808160142.103852-1-gmonaco@redhat.com>
	 <20250808160142.103852-9-gmonaco@redhat.com>
	 <aLWUkpKgFFVr_TEx@localhost.localdomain>
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

On Mon, 2025-09-01 at 14:41 +0200, Frederic Weisbecker wrote:
> Le Fri, Aug 08, 2025 at 06:01:42PM +0200, Gabriele Monaco a =C3=A9crit :
> > =C2=A0/*
> > =C2=A0 * NOHZ can only be enabled after clocksource_done_booting().
> > Don't
> > =C2=A0 * bother trashing the cache in the tree before.
> > =C2=A0 */
> > =C2=A0static int __init tmigr_late_init(void)
> > =C2=A0{
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
>=20
> Why not evaluate tick_nohz_cpu_hotpluggable() from
> tmigr_clear_cpu_available() instead of this force IPI?

The idea is that this IPI runs once during late boot only for the tick
CPU, while the call to tick_nohz_cpu_hotpluggable() would be running at
every hotplug event if I move it to tmigr_clear_cpu_available.
In that scenario, it's guaranteed to return true (besides the very
first call).

I don't have a strong opinion against running that check every time
although it's needed only at boot time and remove this IPI, but in my
understanding that's one of the thing Thomas was finding confusing [1].

Am I missing anything here?

> But if I understand correctly, this will be handled by cpuset, right?

Currently tick_nohz_cpu_hotpluggable() is called by
tmigr_should_isolate_cpu() and that is called by cpuset code, changing
cpuset would save that call but won't deal with the tick CPU not
enabled at boot time, unless I'm misunderstanding what Waiman implied.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/875xgqqrel.ffs@tglx


