Return-Path: <linux-kernel+bounces-751736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CDB16CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705411AA6F41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400CD24676F;
	Thu, 31 Jul 2025 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV4KJm9O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D641DE2BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948039; cv=none; b=OEtveOe2HN6lLAFAHd2xEsBgWf0hfnOe1y8o5HYoGSqQnY4Lo01kBAo31wP2XQq0z9mwpvxpWynpR+cQKGmJwe1m2DIdTa4yzQXUmhKm3c06HEPHUOgTOkiRfkEqYsSObCt2pZvz7MREGvIudNTgUsYKE2wNBXFWGD6o67niCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948039; c=relaxed/simple;
	bh=hDoP1W10jNqo9qA3kMnOqdZgkIrOXdnTsP7q7OohY3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoaAfa9hjdoILyNDSVHnG+pJVyN7fV3aeRv4VcuY3zCBPZQxo2+doq5sW//V3avLELgPSKuoFqQCBxropRsg+VTsOY4L42BSaf9ELRf6whMU+g74hDVRTntHbeXw2aa9jm+QgIBom/NTN3KIE7B6DE/+w03iO40awdarpqLprrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV4KJm9O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753948036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u4WTc+jWAbHGbFb5VbfFSzMl/4GvLeocQH3Zr49ewVE=;
	b=CV4KJm9O4YIZnf2NyP8BqQ/bAQPMP2Oxs0DKw+2ujHVtoyvPHZl3GiXHEVZOipyO5tn/mm
	pG8bjTUHniY9jbW0dY+Kjr4H8gmougS+CwOEfvDlnNaWd53hl36rg2Gop3nJQZ7ShYgw/R
	LPWUcwBl87kKJ/uso1+fpAVtKBwhMTQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-awDHeyhBO1G4LansheHfKQ-1; Thu, 31 Jul 2025 03:47:14 -0400
X-MC-Unique: awDHeyhBO1G4LansheHfKQ-1
X-Mimecast-MFC-AGG-ID: awDHeyhBO1G4LansheHfKQ_1753948033
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7891afb31so392953f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753948033; x=1754552833;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4WTc+jWAbHGbFb5VbfFSzMl/4GvLeocQH3Zr49ewVE=;
        b=herMMpEqBy3CeFD8Fzc9ub3V1FPWPdA+GXoMh7ohZjhGVoPl5zx8z/PfEJyzEx9nJn
         S8kUJHuQdeAktqDz0O+xOgHkSBTvEN/UMPUXe07g/6yfYMwVug6h+yPuyvjglibSDaso
         qqoCCdItZqXnY+qscFGw8ZEnQYSHB1gKagApXWP35CYJza0/uM0hrwxTtK026my5UJun
         KKo1jYIrvx2wc26SaAclPjVcjtxPvkxwuH63OvYwGAmMwHn7bX2DYJW0bEy3CJXshM/t
         9lhOjMLB4DpCe9eAgT3QdL63PuB7B2uH8ay2Yjz/lzXS5XWz1t4Q+tBDt7R2quXCMypB
         w1rg==
X-Forwarded-Encrypted: i=1; AJvYcCVb7IjeJ7/LEMMi7qzyWQdMmiIZS6KGeZVEGvw0bqUJXpjwBu3gAdZrwOiW5Io1sxbqW8AQyBLdW514ePA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywuajynaw7E9gXdKP48grsaRrOZPfRHqj/+o1Gi2afGVyfv6mc
	VyINlWdfsWJbwacMopR0gzoALnQfKYwpSnTsqmzavMiNz+l+5iSfKgxhGiwm1zGvjoExcIPalUW
	u+KdZYem8DCtRZMrlshWZy2zII+bKjXXxsDWs+Xtk8FjGLvOpP/v7aPg7oWrLR1N8/g==
X-Gm-Gg: ASbGncvZgIyb2gp2v4BuqCI06vhauEbh5b6AmDZClw2Di9AHtiv7Nz+a71hHYHvBWVa
	0oX8TwfjeK2aFcIGrvytwNobf8yaFkJT+8ldYN25FMnMJ62BmpNA/bM7aPSmWEJXPUfNI2FHd2u
	hXxyq7zCxpKG/kbtIkHKHcBcGcn7ig1LekvNbYxc40/RBfmjpUw8DKDTL9Q92yy9HfrsqeHl2Zl
	X6MlhwQFP4L4V417zFeg9d2qrcfmrYF++NchEsY5GFf4+v4X98ODTtXRF/MjlqE7vbmYajA7ng9
	6mw85HWNvF2qhBkyXZOqVQ51lpuePCZTDlOIeomXXftIgMaPmg5vvQNfsi6zZuBTFQ==
X-Received: by 2002:a05:6000:2210:b0:3b7:8a03:4b6f with SMTP id ffacd0b85a97d-3b794ffe6cemr4815808f8f.29.1753948033117;
        Thu, 31 Jul 2025 00:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0VQ95ntO8SN9nuejm/0tmsYLQ70eiLWLUlihGZM4cQBz/RjxhjCLEWGFz2CqM4EEiVZW7yg==
X-Received: by 2002:a05:6000:2210:b0:3b7:8a03:4b6f with SMTP id ffacd0b85a97d-3b794ffe6cemr4815778f8f.29.1753948032655;
        Thu, 31 Jul 2025 00:47:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c75sm1476735f8f.41.2025.07.31.00.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:47:12 -0700 (PDT)
Message-ID: <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Date: Thu, 31 Jul 2025 09:47:10 +0200
In-Reply-To: <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
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

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and
> extensible
> scheduling policies
>=20

Looks a very interesting monitor!
A few questions:

I assume this works with rt-throttle because it implies a dequeue,
right?
And you probably won't see that without explicit tracepoints..

> +	/*
> +	 * This may not be accurate, there may be enqueued RT tasks.
> But
> that's
> +	 * okay, the worst we get is a false negative. It will be
> accurate
> as
> +	 * soon as the CPU no longer has any queued RT task.
> +	 */
> +	ltl_atom_set(mon, LTL_RT_TASK_ENQUEUED, false);
>=20

As far as I understand here the monitor would just miss RT tasks
already running but would perfectly enforce the ones starting after
initialisation, right?

> +RULE =3D always (RT_TASK_ENQUEUED imply SCHEDULE_RT_NEXT)
> +
> +SCHEDULE_RT_NEXT =3D (not SCHED_SWITCH) until (SCHED_SWITCH_RT or
> EXCEPTIONS)
> +
> +EXCEPTIONS =3D SCHED_SWITCH_DL or not RT_TASK_ENQUEUED

This monitor allows non-RT tasks to run indefinitely before the switch,
only when it happens, RT must run, right?
Not sure you can do much about it though. (without falling into the
need resched rabbithole I was trying to untangle)

Thanks,
Gabriele


