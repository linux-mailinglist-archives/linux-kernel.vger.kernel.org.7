Return-Path: <linux-kernel+bounces-769239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712DFB26BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFD188D013
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20311199924;
	Thu, 14 Aug 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HhUKmSmR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C493199FD0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186906; cv=none; b=alGEXvGmkbccObyFIsmGS+9189JCbi9tymxYjhWV8+TVt38k5dPh8q3KhgbfLE9187+Zaqc5xvJCDpH7tXRs/QMcQrtW2crD5mCZhEN281tSAPgiZ0ewklI0tV2OSTY8PpDU7TQZLO84Vf36nNsbatKUbEOfK8/4t2vDaz+e718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186906; c=relaxed/simple;
	bh=XkpJgq+lIXUCppVHf15aiVr5Q8p7XI7C729dg+Vl3Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHQcF3bGXMuxuWHF2kOkCdOxOFwViaDGESTE7RxWuHVs990PX2z2mV8loKbyaakbq5eTn9GI/Y7IeN9reU2mpIv/nwh+tiZXNA3Z7ux2+vJhoBs719hZ0N9gq/UXNoM77g4lJL5BvZOHpZX+/UowZoQEeBBYlIscneMcdLK0y70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HhUKmSmR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso7342005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755186901; x=1755791701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SviimhcnBMLOVVMhOENj2J5Tfh1/NQV1XS5VZG0D3iQ=;
        b=HhUKmSmRpXmjZFZ5q/DoCDAPbLa89O1pAzxr9RG0pfEAMsY+VGEGPuPpus4BiNfK2f
         OP3UWnBLgTiFOCLKIOudw+RO+8dZhLZQVivsrnUqdRizT964W2XrjTDknJ7fbqSEdXCB
         yQMXKx/GosmiQWhAZd/aJRMxp7ySrXoZYphjtdkGbLVaI3vqu4tGWTrWRo1+ULQhcNeS
         nXBonXQaaLA5APE+I2oLRjaM1LBFz644LtblJhLyqsSDU9umKxA3xEqg5nmQOzS4o0Rf
         mnGGbtJDtkPowPQlKi/43B9xwTc04cJGX27HvfZ3NaBqROEu2Gl9OaqgX//qGncDXwlL
         R3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186901; x=1755791701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SviimhcnBMLOVVMhOENj2J5Tfh1/NQV1XS5VZG0D3iQ=;
        b=lXlClHPAzXuvN4UB+lAk041JVLAqNfAVCWaBeG701HjIpG9RIgt5C6xwQNJnvgEjo0
         tmE/eJz9cJSQQADBcMAXgomOg9BuDjwR1SLjbJyIw5OYhEMUmwoRD+oqtM3aqspQKbmY
         M17+91YO0xBamvMIZsVdAhWoX0SXCtO4svW+CrEZM8EFnbMvajYPNQHUgvTYuLNTn6MA
         2l31msNI4E0lekjtdUNvLRPIXE4HF4ePJQrM7mmTfOOqpsbCDYGRcdjWsculk5joGzep
         T42kNX263Pi3DNWx+j7dpBfSWbdmLtqWtNSelfWyW6Hbir0CrDD4x0yzF6Gtqczj8WmO
         uNzg==
X-Gm-Message-State: AOJu0YyXJhJ+Zd1UNUHDkGMqRluO6ByiegKhyeMqqWL0XQgchullxfau
	NUA8CiPbga3HmI2lgSczs4FBhP3TA+b91JfF/ODGbnsKR3CKuet+cvPsKhbRNPYNTW0=
X-Gm-Gg: ASbGncu8ijrS6rzlD6RUMzrb9r8JpRh3J0RLJ+zrMdswH09Y9VK1wYgyxdrSXMIn7Aa
	lzN/2vufzf5R5MaSSPkXq3dGRN2qZGNm0GVykaqX6wQe4yKDI+mSaejDyuEnfMXr6u7pOgGAb3o
	qFP8iZGI6mnYVIt52PUMrd1BwuvggmeoUBFNgIAp4ms3argisPpHmqdkNndjEB0c0GTxQgGHRtr
	sQL5+nAR18IMwU3GvZfRfBqurTAew0wlssGMeHhWkFWQQWEB0dhZNCK7WyrnFPiTe/qCNruf7V9
	mAYe6YgHh18pVPGNvNkEjbZUKI+5k+Qgfx4gWmc0hdiIqXKuHmtFjrIuWj+lvE28lFy7Gx4QlhU
	s+BpIcDVlPseavRDlwTB1bcg+FzDT2bK7tOQOQAzcyg==
X-Google-Smtp-Source: AGHT+IEg8KfFdsEWg4VePIf9NMFdjfj2YyB1TPJBwkQF8f3PI8g01heEQys1xj+KdL5pkHweD6cG9A==
X-Received: by 2002:a05:6000:2910:b0:3b8:d5cb:ae1c with SMTP id ffacd0b85a97d-3b9edf2d87dmr3225979f8f.28.1755186901323;
        Thu, 14 Aug 2025 08:55:01 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24302e028dcsm70954145ad.91.2025.08.14.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:55:00 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:54:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time
 accounting
Message-ID: <oel2dyzlyvzggpwxprhwbd7n2ye2bst32izjnzywjdilo4nena@p7bcxgy6lqyq>
References: <20250805032940.3587891-4-ynaffit@google.com>
 <20250805032940.3587891-5-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjtwomnmbus7efjt"
Content-Disposition: inline
In-Reply-To: <20250805032940.3587891-5-ynaffit@google.com>


--pjtwomnmbus7efjt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time
 accounting
MIME-Version: 1.0

Hello.

On Mon, Aug 04, 2025 at 08:29:41PM -0700, Tiffany Yang <ynaffit@google.com>=
 wrote:
> +  cgroup.freeze.stat.local
> +	A read-only flat-keyed file which exists in non-root cgroups.
> +	The following entry is defined:
> +
> +	  freeze_time_total
> +		Cumulative time that this cgroup has spent between freezing and
> +		thawing, regardless of whether by self or ancestor groups.
> +		NB: (not) reaching "frozen" state is not accounted here.
> +
> +		Using the following ASCII representation of a cgroup's freezer
> +		state, ::
> +
> +			       1    _____
> +			frozen 0 __/     \__
> +			          ab    cd
> +
> +		.. Originally contributed by Michal Koutn=FD <mkoutny@suse.com>
> +
> +		the duration being measured is the span between a and c.

This is so little "artwork" that a mere mention in commit message is OK
;-)

> +static int cgroup_freeze_local_stat_show(struct seq_file *seq, void *v)
> +{
> +	struct cgroup *cgrp =3D seq_css(seq)->cgroup;
> +	unsigned int sequence;
> +	u64 freeze_time;
> +
> +	do {
> +		sequence =3D read_seqcount_begin(&cgrp->freezer.freeze_seq);
> +		freeze_time =3D cgrp->freezer.freeze_time_total_ns;
> +		/* Add in current freezer interval if the task is now frozen */

Nit: cgrp is frozen, not a task here

> @@ -179,10 +179,16 @@ static void cgroup_do_freeze(struct cgroup *cgrp, b=
ool freeze)
>  	lockdep_assert_held(&cgroup_mutex);
> =20
>  	spin_lock_irq(&css_set_lock);
> -	if (freeze)
> +	write_seqcount_begin(&cgrp->freezer.freeze_seq);
> +	if (freeze) {
>  		set_bit(CGRP_FREEZE, &cgrp->flags);
> -	else
> +		cgrp->freezer.freeze_time_start_ns =3D ktime_get_ns();

I wonder whether it wouldn't achieve more stable results if the
reference timestamp was taken only once in cgroup_freeze().
Measuring the rate of cgroup traversal is rather noise in this case.

Thanks,
Michal

--pjtwomnmbus7efjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ4GwgAKCRB+PQLnlNv4
CNbxAP9FzlDCoVP1/jhXEaVA20T+mwq1x7BETTs7XxHWatYQTAD+OE7kYl0NbVYD
g6r21AfecI9/DXVLMsPPub/G82cpWwI=
=3Weh
-----END PGP SIGNATURE-----

--pjtwomnmbus7efjt--

