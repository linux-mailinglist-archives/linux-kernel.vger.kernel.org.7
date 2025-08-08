Return-Path: <linux-kernel+bounces-759853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D15B1E376
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992EA18A4372
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7523F412;
	Fri,  8 Aug 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwRYp6WN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AF2248A0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638219; cv=none; b=Im1s5LhHolMSBCEPk7mjvYe51OflQ3YmrjGEjpJB39WV8EZEMKoFf1dC+sVcK3FBoq7984gy4S06CL1U5Nd8bs/ICO7PIgNry2HySfXvTkKc0lDVA/jk9CcMH/8+XTz9csWaKls34rN5f+5Y/3acxdKtDpZsWKx+TiRxQmHOLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638219; c=relaxed/simple;
	bh=EHywBHd1OxRIzOjuUYWD29M8banbtxBweMpbfCeimSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFlcu68FjDgIqqH9n466sdKj6/LwE9EQMSCr65Q66AyWW5Hkzw4897TxO3dagL/DpCH3nZ8yTc02gD+Buu6ZrxdEtiH34RI8YivSQBvK0WaC9c6SUCSOx7X0jIngxApJLUQt8LcB/62sain3qnfjuVvs21LUkUmDYKGxcMG1S4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwRYp6WN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754638216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EHywBHd1OxRIzOjuUYWD29M8banbtxBweMpbfCeimSc=;
	b=NwRYp6WNk8oV8aCe+RFO+bN3GqJr8m4/SxHOqL5fog55nt+F1mBEpMkPyxAJGre3r0ipkQ
	t1sxNYQoi6kz+EI2QAiK0GI/HfHxvXscnQ3cd849cxMkoJs228Ey7gM625i3iw3eCI5R4A
	/q3TAzE9OAZJQBUypEipweVp3eR5++M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Z8yb4B8gMRyo2u6PEMTS3g-1; Fri, 08 Aug 2025 03:30:14 -0400
X-MC-Unique: Z8yb4B8gMRyo2u6PEMTS3g-1
X-Mimecast-MFC-AGG-ID: Z8yb4B8gMRyo2u6PEMTS3g_1754638214
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e69d69691fso197607385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754638214; x=1755243014;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHywBHd1OxRIzOjuUYWD29M8banbtxBweMpbfCeimSc=;
        b=EDoKC9OVaPfAHF4Odz7TlpvXcDrywhlXrV1WzGzQdyKYJ1IVTJCsnc0onO5FtlieNZ
         slvEAOWJzDT2c5qqhkAEoDQ2cQtEup9ZZZg4fbDkXQrO+OLgQSmq1s/cgKp80UUO/ucL
         V9XMK96ppE18HbA6rVI8VY7oBCWA8EFSUUYfxvBy9yNP8olgMo4zYRWWuueebKNBpAtT
         VAP3Xnuxsh7te9vWFp/OV7XA+RlZD0F74zGxhXIs0JzYAx/HmNni55gwNX44P5flVp/N
         PqS6NAqnTX8TJTWTgLWmM+0n9bqA6O/dmk8K9EbB2BgBaW9eWLkMZT0fYo4h5K2VK4gk
         DTzg==
X-Forwarded-Encrypted: i=1; AJvYcCWyrwZ8bYJDdOQ4NdPCtYo6t+SfJAd9bgb6ujm3tu0prm8BycM4ubUK/EoalyJSn8cQfVJ6bRt4NXinOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdVlkvUZ3R13GRdwH/DvJ0CELlt55hHscByvvyRyhBeXOeHV5
	20Db7YgUh0MI2o3v4Y1a4vfkIIwgK5HBLdmFBx6sqfc9SepDZO5sQp5+jFrs/HS3ofh9Av8wIFE
	+docEDwtxddOiu2UqlA3DBCVt0dhqLGJ96dbl8qJcXi7o9P7YzHX1U3OwBDY2mywp7Q==
X-Gm-Gg: ASbGncun92NgLZxzifRwMauhfhEp2IbC4X5a0iiNtCIG76GY+BkaLI3B56UKXkOoSXu
	45ZFqYL4/QStGCmvCBqUaQEzWmW8DgZLu2n4uKszp+7tQkRJGtTbeEsTQfVH/kWMhEStSTZNIQE
	BKOUPpHLPZKkf7swgxmNZshAFHjwrJe/Th+lTVhBUSmrKHkFgE4vYF4YuVWr9kZarIJZ8KFZaAY
	ruw7BIcTQFWVZIwu5zfJmbfK7yb+eOLrHgw9DZKQCcPSF+gCDprbVYyMhegdnlUJ5AT7+cQ1yX+
	+aoTuFwTaCBHFmNIWCsMETwg/gO+Hq80hJhV4QOpZNZZswlL5EhEPeYCWKkELSoVOA==
X-Received: by 2002:a05:620a:880d:b0:7e6:7083:e2b3 with SMTP id af79cd13be357-7e82c63c8e2mr261238285a.9.1754638213855;
        Fri, 08 Aug 2025 00:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaEv0CLI3Nwa//Oy5W/et3N8C/QGGdQvh8aoP6RMedjZnqPNG2uAHc2P7KdnkPU1kElEOLcA==
X-Received: by 2002:a05:620a:880d:b0:7e6:7083:e2b3 with SMTP id af79cd13be357-7e82c63c8e2mr261235185a.9.1754638213434;
        Fri, 08 Aug 2025 00:30:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm823957785a.80.2025.08.08.00.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:30:13 -0700 (PDT)
Message-ID: <c0ae826c9a3d828ac8ab2088495e671cd9384a86.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak	 <kprateek.nayak@amd.com>
Date: Fri, 08 Aug 2025 09:30:09 +0200
In-Reply-To: <87ikiypei8.fsf@yellow.woof>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
	 <ecd720a0b971658a915473f0f864668cd6e1ef1a.camel@redhat.com>
	 <87ikiypei8.fsf@yellow.woof>
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

On Fri, 2025-08-08 at 07:29 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The monitor shows a violation also in case of priority inversion
> > boosting, e.g.:
> >=20
> > =C2=A0stress-ng --prio-inv 2
>=20
> This looks like something that would trigger the fair deadline server
> or RT throttling. Can you please try disabling both of them:
>=20
> =C2=A0=C2=A0=C2=A0 echo 0 | tee /sys/kernel/debug/sched/fair_server/cpu*/=
runtime
> =C2=A0=C2=A0=C2=A0 sysctl -w kernel.sched_rt_runtime_us=3D-1
>=20
> and see if the problem persists?

My bad, that was the fair server's doing, ignore what I said.

>=20
> > It seems perfectly reasonable from the monitor description but it's
> > actually a behaviour meant to improve real time response.
> > Is the user seeing this type of violation supposed to make sure all
> > locks held by RT tasks are never shared by fair tasks? If that's
> > the case I'd mention it in the description.
>=20
> Boosted fair tasks are treated as RT tasks ;)
>=20
> > Also very rarely I see failures while cleaning up the monitor, not
> > sure exactly what caused it but I could reproduce it with something
> > like:
> >=20
> > =C2=A0 for i in $(seq 100); do timeout -s INT 2 rv mon rts -r printk;
> > done
> >=20
> > Running the monitor without stopping for the same amount of time
> > doesn't seem to show violations (until I terminate it).
>=20
> This one is strange, I cannot reproduce this issue. Did you run only
> that command, or did you have other things running as well?
>=20
> And does the problem still appears after disabling the fair deadline
> server and RT throttling?

Also here, I don't seem to reproduce it with both disabled..
Sorry for that, looks good for me then.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele


