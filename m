Return-Path: <linux-kernel+bounces-786775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27594B3693F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF81E9862D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C39352FEE;
	Tue, 26 Aug 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J+Y6zHij"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88A352FE3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217458; cv=none; b=CH3IePNfSmUS8cTr+Al/qfyYreX6izXkfidDrdlDGZ57zVWA+ob7xaon+Xu2Wl7D2yeDS429eH3QAgHZuWioOBlgo0b5rY57IGXTy6goM6S/NItSFpVkyRR5NvUe0DKdPdd7wBMYZIE4le+kMRxkS0naJNdzL/I5Iu4WDSG0T7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217458; c=relaxed/simple;
	bh=9lBitOXWidiKqzYs84cGVMi2/gsDE6J/R9jGj3wSYso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnykP4ICbz+lC/f5grZmPR56DPf04j+I9Bxe6t3gS9gQQsmDMFOdKSU5myAxBIrc2M7TV2y7YZH4DKIDEHY3kOTaS6ZS0jbWQe2jaFnI6dhy6xgz8dbhP1LbuT7sP2LcgHRt67/iNJYSBy9hJ+xWc+PXCGmDP1WkjzL/MnXbAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J+Y6zHij; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cc3600e5d1so129361f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756217455; x=1756822255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFSslua+c5uY0Ih+tbwJrDHl/bNj7B6iUfsDxPOebnU=;
        b=J+Y6zHijvM2tOowEWPeJKUyhjWFtFSZxiW4aMKIGDCBj/uohGmNlD23jgS/IQir0/B
         jafvlb46dPaL/sQxSaBif5NJpRqLJ5RPnq20LjE1Oc9qQaPLrgfq4MOFsT/QX/Gs/HAv
         0xpjsErsefEnc96eDNO4svYLPS9flAc+c8db/BYZnkIZS6fB5+q4ze4iFn8R4kxilDmA
         lZI44TZFqlWs7RI7ER7kyyT7hCY0KzSCNfQFLFw2TB7TrYtvVCDHvO5/8Q63fBNg8e4E
         +7U2eHQW6+XU4fLOK3FYh+xuE1zEsJkfWVtYyqut9wi1QAw2kO+zbHkqfZLxyT+qfLzJ
         tmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217455; x=1756822255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFSslua+c5uY0Ih+tbwJrDHl/bNj7B6iUfsDxPOebnU=;
        b=aIJuSP1DaXGHW8wx8vJ3MqxipcAeK2/yiSf1J3FF5mMm99APKDDFdaqllQbQJKq8sa
         csOPJDWK+a1c+hAn0J4QwpzZM3g7txCo1X4hLJx2i9rj7943ZKnVaiRGnZr378YytYt6
         afwwyKzaJMwtzNN62sH7vnafEPw7B6LxLZcW3HLkMcBiQSTXxrV09K1wqkE3GFsJnVLg
         Be0kg4SAOiMvY9Vp3Ktu1VJF/COZw4hosnwh+LiZaf8a/a5cvUEacAr1HUpa7PDK/qKC
         52FsYpCHs/sCEQR2LEZkIf7C7xuDQKbI9nKdxxv8TsfHdnZumc/LoOVTwl8Y6UmTGNy8
         gqBA==
X-Forwarded-Encrypted: i=1; AJvYcCUCQj6iqgaPK9S97J2wTmB4nu62Ikmkvs9bULL8PZa2YcZmtwf6TOBvCj9ZSpN+jbbo27HFKcL9kKye9t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCVfL8KwueBxTe6XgKKX/pqUcTmCbVSZM9xIx35BDH8Lj8t3P
	x1d42nKSX7LqWIT8gHpuXmovwqDrjKcy6+ZNcgTSBqhILlr/TE3y1o1t/zLOEmIxAV0=
X-Gm-Gg: ASbGncsmF2kWTSyy7eqvE+ddwq5e//6kuWRprMLMI9By5XTfVx31gcF7PHNkNLGnAfI
	MLAewIaPoiPH55ZMKYBf0hpjmZyoa/ra2qBGhhXiZVZS0fCzUSEwSNpbNN51tK4OVMUvLo4s9uM
	01+Ix+bxHbzbgUVSbNYttKAe4t+daPYgSjo70mTy13omH2o50J/KGtx+sSZSbPNpZMpxM/oendS
	ejP1tA15MDE5Tgh5u8mZ3KKA76nYlBaZDDUEdZ2Ir1wc7+qqu1VxwW9aMb+i8BeevPyYiLBEggW
	gyIsoQfuoY1hjYJA38kCRJdngOfEkwyXEdBanxeL6MmHjp6QaaoB/bmWarSgeCw8f/YqUV0N3c1
	wkImdNqPdm0/U/X3qmzKjpIWXjM1bPwc+Lo+CLz0HjdI=
X-Google-Smtp-Source: AGHT+IFOXvgNi4WoPVgeBrpd9uKq0qBST3D6sFgmnscCYDmdzYyPO7yMhXOsxiTA5Ii5YmQYnKGABg==
X-Received: by 2002:a05:6000:25c6:b0:3ca:4e3:6ea6 with SMTP id ffacd0b85a97d-3ca04e3768amr4648639f8f.46.1756217454652;
        Tue, 26 Aug 2025 07:10:54 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401adf58sm10587387b3a.71.2025.08.26.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:10:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:10:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, 
	Ben Segall <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu <liusongtang@bytedance.com>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
Message-ID: <u2ri72fqvzlyvwxmaez3l6mbgtkvzmg36ylzc4k2qhvjcdiup5@7ogshyljqoot>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
 <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250819093427.GC38@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6jmliwdaurax3yj"
Content-Disposition: inline
In-Reply-To: <20250819093427.GC38@bytedance>


--j6jmliwdaurax3yj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
MIME-Version: 1.0

Hello.

On Tue, Aug 19, 2025 at 05:34:27PM +0800, Aaron Lu <ziqianlu@bytedance.com>=
 wrote:
> Got it, does the below added words make this clear?
>=20
>     With task based throttle model, the previous way to check cfs_rq's
>     nr_queued to decide if throttled time should be accounted doesn't work
>     as expected, e.g. when a cfs_rq which has a single task is throttled,
>     that task could later block in kernel mode instead of being dequeued =
on
>     limbo list and account this as throttled time is not accurate.
>=20
>     Rework throttle time accounting for a cfs_rq as follows:
>     - start accounting when the first task gets throttled in its hierarch=
y;
>     - stop accounting on unthrottle.
>=20
>     Note that there will be a time gap between when a cfs_rq is throttled
>     and when a task in its hierarchy is actually throttled. This accounti=
ng
>     mechanism only started accounting in the latter case.

Do I understand it correctly that this rework doesn't change the
cumulative amount of throttled_time in cpu.stat.local but the value gets
updated only later?

I'd say such little shifts are OK [1]. What should be avoided is
changing the semantics so that throttled_time time would scale with the
number of tasks inside the cgroup (assuming a single cfs_rq, i.e. number
of tasks on the cfs_rq).

0.02=E2=82=AC,
Michal

[1] Maybe not even shifts -- in that case of a cfs_rq with a task, it
can manage to run in kernel almost for the whole period, so it gets
dequeued on return to userspace only to be re-enqueued when its cfs_rq
is unthrottled. It apparently escaped throttling, so the reported
throttled_time would be rightfully lower.

--j6jmliwdaurax3yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3AWxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai8eAD9H04DgaLUIdHoCKgvmmpU
u5lNE4vyfS4iiqk+aed2stcA/0KqutladOu1UUh6URZ6sX2KlYugULiw90ZkKGP/
V3oF
=XO3/
-----END PGP SIGNATURE-----

--j6jmliwdaurax3yj--

