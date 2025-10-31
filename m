Return-Path: <linux-kernel+bounces-880261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAFC25403
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF441A64030
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7863491F1;
	Fri, 31 Oct 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuuU4Hr4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B0336ECF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917066; cv=none; b=drky0rit3ZH8k5MeyMrXB0Jos+5DTiTN1bmBhwOhoDg+9SCpZKRdBOfClqOr080BBcpmH2FDCpArKAZGg+tjvBrvJEAw9LKe9NbK5NI5Gt/oj5kmnHIworhhCo6MI6V9VEVwG4UStsWqpJSPFXhjAk5OmgISf6twlI1xeQtHWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917066; c=relaxed/simple;
	bh=YOkDP+qVIV4paTYI+ssyb3hZgZ6aphTYjATCvddfS2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nyb+bWmNFL/w0+7oo7K/lCM7zDkyKDF6W24Jys4+B1YmRUVr3mNxG5sjSfzpRVNJ0r+WMVR28wiHeORyA0z4AlDsouxYZiSLWa6jzLsAQe6XzM+tP5cOgww/+tQYLyZyuL9/6vbxx8N+q43+mgKLZizFCsHtlQv/UxzMNI4Ywuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuuU4Hr4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761917063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y9hNhnsVfQ/o7oKsaCwjina8MCAM3H2USgkgOjsV1Tc=;
	b=OuuU4Hr45Pp5PHi9Ww3Yq+v6JZXEZDAELLJBsOp4AStTVrjFc1gvKGz7RcFg/smRJ9OyIv
	FlgfgFhoTvdNnHMrLlEmHaXCAcEBECauNvoQwlJB/hsE6HbBGWh/l3/Uxwx1PvIkt2Cgpy
	JulTgJxr0Zp3quUqUqrVHOp/R4W/rlA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-cxjgjzTuMH2fs3Hb50arpA-1; Fri, 31 Oct 2025 09:24:21 -0400
X-MC-Unique: cxjgjzTuMH2fs3Hb50arpA-1
X-Mimecast-MFC-AGG-ID: cxjgjzTuMH2fs3Hb50arpA_1761917060
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42851b6a659so1347840f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917060; x=1762521860;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9hNhnsVfQ/o7oKsaCwjina8MCAM3H2USgkgOjsV1Tc=;
        b=Q27H4dAsb6KTUtf2R68MBubCQ59GN34cLdVDky7nDsVwUfOJDTS1iAwOCo9v8OgaXb
         dQpO0fNRnfL0/MgIUd90JMTLHJUGKBFqGWdvir4vAqrmQOMZWxQVp4WeX7fS9gr/B/L8
         5/36DOsUKz3HofbpmaFZ598ETWZs0l1eEAWLqUEz+pDsXfHFZaqPToo6RfgryWsew9z5
         cUhUgRZCuSM4SYpC5OZ3N76mZwXFLxfuvs3muM9L35o0+x/6wa9tcrXhQIoa2YziLded
         lnWZNhJhOGuHSOymNzzu3lpzOaIyLs90tiL4A9HewERN+V4XrrwL6zfyEA8FwGhc9dap
         hQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWcTTvUjbmNNTLHrAGRkqByEVcum4In9ve3msycHM4a0nDEFXtWY3tpl264iRTKu6F1PgLJ5GRadiSPVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkuOkl2oYyrLKxrrjCxgxBPVeJrGaHR7c2jK8uw6h3pkotW4/
	tMTM16aM2teF717XBs7o2DWg2NgsJ/Os3DAgLXnzp7usEGuqKyiirgw86fHQdGqiVeV33oRUWxZ
	LeJYbKmSjV9O3eKe4Q139B2jhOWcxZ/qUAbfsm4CzLmM2CMkrgFVozmfig0ApWIu9uQ==
X-Gm-Gg: ASbGncuDHPKyyYXTLwh5T+mn6K4qXI8065Li59B5iEHxPbdTXo2148JOyjI1tSElT7G
	JrTJroNUowkpld5x5+Ab1kfFOXVjmYicHFWnQh1lSLf+3XG5NnmYEYVjQIC63m2umA8kbA/Nymg
	ZniTWHzbKi42GX3tLRyxiJtB4B2/Hvfo4QI2C2EmnLcxGwWHv2MAb269sALK1Mlzga5hFtbDp55
	VErLaXAEGI5VEadF5Nn+lG5IkaUNOIeGRq+9AxAQ4FSMupS+WEvN6o0GIAci7RmQr8NMW3q85pL
	Sz7tD5bCASJJHl9ml7lSpWTDN6SKDM18f3lZ+8BJW96pnXI2kfgeI6ayI9J7rJ2X+Qd4BdYsyak
	K047DPpLRbIpaOyTljDDNhH9E
X-Received: by 2002:a05:6000:400d:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429bd6be4e8mr3076931f8f.43.1761917060169;
        Fri, 31 Oct 2025 06:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqVRoZLyFdohFILCKqzfIeDD58WA0x5/1dU72Z7RWVsq+ULW6hP9uH2R1zpAMKyxSnpTTExg==
X-Received: by 2002:a05:6000:400d:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429bd6be4e8mr3076906f8f.43.1761917059704;
        Fri, 31 Oct 2025 06:24:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm106617895e9.7.2025.10.31.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:24:19 -0700 (PDT)
Message-ID: <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>,
 arighi@nvidia.com
Date: Fri, 31 Oct 2025 14:24:17 +0100
In-Reply-To: <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
References: <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
	 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
	 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
	 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
	 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
	 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
	 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
	 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
	 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
	 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
	 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 14:05 +0100, Peter Zijlstra wrote:
> On Thu, Oct 30, 2025 at 07:42:05PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 22, 2025 at 12:11:51PM +0200, Gabriele Monaco wrote:
> > >=20
> > > Is this expected?
> >=20
> > Sort of, that was next on the list. Let me see if I can make it stop a
> > little more.
>=20
> OK, so I've gone over things again and all I got was a comment.
>=20
> That is, today I think it all works as expected.
>=20
> The dl_server will stop once the fair class goes idle long enough. Can
> you confirm this?
>=20

I'm going to go through your comment more carefully, but what I can observe=
 now
is a bit different:

After this patch, consuming bandwidth in background on fair tasks and on id=
le is
equivalent. Updating idle time does effectively replenish after exhausting
runtime and we never stop the server (IMO this is correct behaviour only fo=
r
fair tasks, since there's potentially something to do).
At least this is the behaviour I get on a mostly idle system.

Different scenario if I have the CPU busy with other tasks (e.g. RT policie=
s),
there I can see the server stopping and starting again.
After I do this I seem to get a different behaviour (even some boosting aft=
er
idle), I'm trying to understand what's going on.

Does this behaviour make sense to you?

Thanks,
Gabriele

> ---
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1152,6 +1152,94 @@ static void __push_dl_task(struct rq *rq
> =C2=A0/* a defer timer will not be reset if the runtime consumed was <
> dl_server_min_res */
> =C2=A0static const u64 dl_server_min_res =3D 1 * NSEC_PER_MSEC;
> =C2=A0
> +
> +/*
> + * dl_server && dl_defer:
> + *=C2=A0=C2=A0 dl_defer_armed =3D 0
> + *=C2=A0=C2=A0 dl_defer_running =3D 0
> + *=C2=A0=C2=A0 dl_throttled =3D 0
> + *
> + * [1] dl_server_start()
> + *=C2=A0=C2=A0 dl_server_active =3D 1;
> + *=C2=A0=C2=A0 enqueue_dl_entity()
> + *=C2=A0=C2=A0=C2=A0=C2=A0 update_dl_entity(WAKEUP)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dl_defer_running)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_throttled =
=3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_throttled && start_dl_timer())
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // start server into waiting for =
zero-laxity
> + *
> + * // deplete server runtime from fair-class
> + * [2] update_curr_dl_se()
> + *=C2=A0=C2=A0 if (dl_defer && dl_throttled && dl_runtime_exceeded())
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();=C2=A0=C2=A0 // stop =
timer
> + *=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_new_period()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // advance period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_dl_timer();=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // restart timer
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // back into waiting for zero-lax=
ity
> + *
> + * // timer actually fires means we have runtime
> + * [4] dl_server_timer()
> + *=C2=A0=C2=A0 if (dl_defer_armed)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_running =3D 1;
> + *=C2=A0=C2=A0 enqueue_dl_entity(REPLENISH)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_entity()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt-fwd-period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_throttled)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_defer_armed)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 __enqueue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // server queued
> + *
> + * // schedule server
> + * [5] pick_task_dl()
> + *=C2=A0=C2=A0 p =3D server_pick_task();
> + *=C2=A0=C2=A0 if (!p)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_stop()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_try_to_cancel();
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_defer_armed =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_active =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // goto [1]
> + *
> + * // server running
> + * [6] update_curr_dl_se()
> + *=C2=A0=C2=A0 if (dl_runtime_exceeded())
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 1;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 start_dl_timer();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // replenish-timer
> + *
> + * // goto [2]
> + *
> + * [7] dl_server_timer()
> + *=C2=A0=C2=A0 enqueue_dl_entity(REPLENISH)
> + *=C2=A0=C2=A0=C2=A0=C2=A0 replenish_dl_entity()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwd-period
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_throttled)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_throttled =3D 0;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 __enqueue_dl_entity();
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // goto [5]
> + *
> + * Notes:
> + *
> + *=C2=A0 - When there are fair tasks running the most likely loop is [2]=
->[2].
> + *=C2=A0=C2=A0=C2=A0 the dl_server never actually runs, the timer never =
fires.
> + *
> + *=C2=A0 - When there is actual fair starvation; the timer fires and sta=
rts the
> + *=C2=A0=C2=A0=C2=A0 dl_server. This will then throttle and replenish li=
ke a normal DL
> + *=C2=A0=C2=A0=C2=A0 task. Notably it will not 'defer' again.
> + *
> + *=C2=A0 - When fair goes idle, it will not consume dl_server budget so =
the server
> + *=C2=A0=C2=A0=C2=A0 will start. However, it will find there are no fair=
 tasks to run and
> + *=C2=A0=C2=A0=C2=A0 stop itself.
> + */
> =C2=A0static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, =
struct
> sched_dl_entity *dl_se)
> =C2=A0{
> =C2=A0	struct rq *rq =3D rq_of_dl_se(dl_se);


