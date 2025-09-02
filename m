Return-Path: <linux-kernel+bounces-796210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5698B3FD59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A541B22DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D82F4A18;
	Tue,  2 Sep 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMAX9Yd9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B92765C5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811313; cv=none; b=C68GUpnr8xyUTd/d6U2Gq8PDp+pGXe7zWe6knX3eAgIOLqAYvaLiqBi6ovtFClfvlEuuEmR3KD+UjQ3AHa6X/4XOf0zK9U2v8XMmsxbrfscoM8QnweJWYu+llIX+iefowAIeU07cKtFpHPtOGTWlREexEP26NULVosbt7GkuHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811313; c=relaxed/simple;
	bh=KrUHaR5sq+BaEiyloFCV1nKdqjQ39qYRW4d4A828vT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqDyDvl1356CCD2Couw/YP46vp40VWKjef6Q5Xp8+IAavFOfAK6mHyiym5uD0ukp3KmCIgivWB40v2irF/RyK6qu2utWHGE9cWY2jIPLV9eBm5PC6YzToSpmt/LTLYgBnb7KCMGoINjRKpu9ibJRuvf0HN5GsP7SH1fBhdwoz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMAX9Yd9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756811310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KrUHaR5sq+BaEiyloFCV1nKdqjQ39qYRW4d4A828vT8=;
	b=JMAX9Yd9GjiWqswYDWFETLpaEi8lIceimKlmRWx0pce9V37Gy82Arn4tcC7P3fYS8FeTze
	lR5NtQu9jESrbeBG+Hn5TLX1eDvvkLOi4Wi7MRz/VyNmSd4z6jwq9luM5js1tDt2b8bRbg
	SWxkbsfjLQBGF+ayohSiG+NJjoRDPVU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-kOe_1_JPMOWqLTd3FhZ8zw-1; Tue, 02 Sep 2025 07:08:29 -0400
X-MC-Unique: kOe_1_JPMOWqLTd3FhZ8zw-1
X-Mimecast-MFC-AGG-ID: kOe_1_JPMOWqLTd3FhZ8zw_1756811308
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b869d3582so14658555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811308; x=1757416108;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrUHaR5sq+BaEiyloFCV1nKdqjQ39qYRW4d4A828vT8=;
        b=cNs97BIEdT7cu9swlBHHGe6JSTKwXm0HOG6BhYk6jx1bed5hOaAfOgAY2G4fnDO8BO
         AIydueOin3FDHLJBnfrqKemoNoEzCyvAyIdVif+f72TqAqJrB+afC0prDml18GcQ9D5V
         wurvCqx9vtKjdryS9gD9v2qUX8i5cwFhcgGqpQBsSkF7+DSLAEeCgOlmmPbfb8y9VMkX
         GwY53GxC+Go4vx3OLFAiKEDe98+f4I95NZASIE1vDA3n655wGRE/4Nz+APRruJH9bynU
         jeV/wQmfwxQ9Cq3GNON0i7zXn07N3izTUZ9bVWW+12TRj1Y1dY13TADaxGcLWIg06lKV
         7dow==
X-Gm-Message-State: AOJu0YyXTTo/ZvmqC/OgcmC3kHE9XQGy0DCTZu80T+Si5tZP35VOpeZS
	tkchfIWn4WfW6dTGRAxa8D7bqPbebb3fZFqmOpdDtMtO3CpkuHim2Sfoeeek6hBo0bwXQz8LvQV
	ZAYCcLTXECm8o0mwOzjNaDqzQ+pco9+mYdw0u3GQu+LfW9hKBHk2BZM/D3lESLQ0lbQ==
X-Gm-Gg: ASbGncvBs5FvlZu5mf+yhwHjumP6CynfIVuuXNCgCaEhdn7svQxdgwh5sRIxUv0YoXA
	cbfRgm3jETi93dpdYsw7ukdRUVqg0pRtAnhJANeR9py04YscEcTiRXEQ38x4UTC4N2Z/P0coQps
	V6LMw3Vj//2L5f7gyTYNNY57Cq8TLCDCMt5XT5kOH2iAG3p6Yp4ZuS7nR3KRTT3TDHlh5JKNOkd
	CJ3jC2LpoIFmdeIJa0lEcQnMz4kcs/GsNoVfjdlyZkjld5IuJRU55OIMxPBdEaMHN5h8GvaQCSr
	t75yc0U3bKsWZNuL7Qn0kkZ77pS1lYpgeWXUPvPd6x4iioZkNKnDgd3HEvmUAsJfQl1f
X-Received: by 2002:a05:600c:1396:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45b9615d7fbmr24426355e9.17.1756811307984;
        Tue, 02 Sep 2025 04:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkSIatHhKp0ujzwVlq7NycBLtJPQtQzxKLgJljItdPqMHTWaGCMKCYUaX3lOXYaKbucOFCIQ==
X-Received: by 2002:a05:600c:1396:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45b9615d7fbmr24425605e9.17.1756811306731;
        Tue, 02 Sep 2025 04:08:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm275090425e9.5.2025.09.02.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:08:26 -0700 (PDT)
Message-ID: <ab9348b0e67f36dea92922bf76aadb7fe9d1667a.camel@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>, Waiman
 Long <longman@redhat.com>
Date: Tue, 02 Sep 2025 13:08:25 +0200
In-Reply-To: <aLYMA8niL9Uxhu7G@pavilion.home>
References: <20250808160142.103852-1-gmonaco@redhat.com>
	 <20250808160142.103852-9-gmonaco@redhat.com>
	 <aLWUkpKgFFVr_TEx@localhost.localdomain>
	 <d001f1bc9a87e031cf4f8721d6843013c766c28a.camel@redhat.com>
	 <aLYMA8niL9Uxhu7G@pavilion.home>
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

On Mon, 2025-09-01 at 23:11 +0200, Frederic Weisbecker wrote:
> Le Mon, Sep 01, 2025 at 03:48:15PM +0200, Gabriele Monaco a =C3=A9crit :
> > On Mon, 2025-09-01 at 14:41 +0200, Frederic Weisbecker wrote:
> > > Why not evaluate tick_nohz_cpu_hotpluggable() from
> > > tmigr_clear_cpu_available() instead of this force IPI?
> >=20
> > The idea is that this IPI runs once during late boot only for the
> > tick CPU, while the call to tick_nohz_cpu_hotpluggable() would be
> > running at every hotplug event if I move it to
> > tmigr_clear_cpu_available. In that scenario, it's guaranteed to
> > return true (besides the very first call).
> >=20
> > I don't have a strong opinion against running that check every time
> > although it's needed only at boot time and remove this IPI, but in
> > my understanding that's one of the thing Thomas was finding
> > confusing [1].
> >=20
> > Am I missing anything here?
>=20
> Right, Thomas didn't like it, but the organization of the code has
> changed a bit since then with the late initcall. If the best we can
> do to workaround the situation is to make the CPU unavailable
> regardless and then undo that right after with an IPI, then it's a
> good sign that we should just simplify and eventually check
> tick_nohz_cpu_hotpluggable() from tmigr_is_isolated().

Makes sense.
I'd be tempted using a static branch but since the call to
tick_nohz_cpu_hotpluggable() isn't really heavy, we can just be fine
including it in the tmigr_is_isolated() check.


> > > But if I understand correctly, this will be handled by cpuset,
> > > right?
> >=20
> > Currently tick_nohz_cpu_hotpluggable() is called by
> > tmigr_should_isolate_cpu() and that is called by cpuset code,
> > changing cpuset would save that call but won't deal with the tick
> > CPU not enabled at boot time, unless I'm misunderstanding what
> > Waiman implied.
>=20
> Good point!

Here I'm a bit unsure how to proceed though. We want to fail any single
isolated cpuset that includes the tick CPU under nohz_full. I can do it
directly in isolcpus_nohz_conflict and that looks easy.

But is that going to be clear for the user?
Can the user even know what the tick CPU is? Besides /assuming/ 0.

Thanks,
Gabriele

> Thanks.
>=20
> >=20
> > Thanks,
> > Gabriele
> >=20
> > [1] - https://lore.kernel.org/lkml/875xgqqrel.ffs@tglx
> >=20


