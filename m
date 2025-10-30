Return-Path: <linux-kernel+bounces-878052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4393C1FAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2613A828B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C13546F5;
	Thu, 30 Oct 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXSjZRzF"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C233C53D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821780; cv=none; b=MJD/NzLi4BLHM/MWPbWjlUzLC5FL9nucMqkEH0rHpUADnPNeLX5inRELn7kgzBrY7PcSAlJl+btDU8SWM7tjklNb9pDg3LH+Hnyb8UiwQ11Mi+CSa+PLZLTjdl4Ch70K99ztYnoTlDCfwaAZCLzv70tiEajBWLsPVlgN0tq8Nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821780; c=relaxed/simple;
	bh=SwuMGNljv5YCmGFt8PONT+5bpED3M42Ze9Lf7j7Ukyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFk+M1U/dT9oPSJY9pSs1ozfP+sqCsqC3DeDoT+GxIUeIj66+ZAwhF9z4bXbweXi4ukNNxQFBUY8pqc/hGTWBZaMdnyIf6hfYTomvV0WqwzU/wBGHr2lgtfMTgpA9fg7KpZluOUOj+51OhEeZUVU+UOsUp9PoaW4XY21hNaxF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXSjZRzF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so534742f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761821776; x=1762426576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgtQ2g+dOWzWnvs0Qi9m2S1QHrl6yxD8lUWBkYgbzlk=;
        b=dXSjZRzFrpZmCtvrPJio384KIjqkBOfw88sM06qZVm5DsgJB9Rp+6wKa04P74hD1d7
         5cd8aO3GN7+M2llveTeHBYXvJNcIxI9JvJyK22ifmMxr014WrA4qNQR3AanlQJh1A5Rj
         Wdct/waP/JwkofJWetVKW0bXJgakJZPCpX8n8fETrwzaoNqRQTctyKCAljt7Cw9oRfwu
         ZntufYNcbEq0FNjRYNbOgWBLj8JadqWBOUxwJ2vr0xUqBHwlUjGMIXFzgAnezZEo6j4O
         K85U1Ug4uYT9LAiscAEvNnjjGAuf9kQEu7cPDbB+q2iW8+lmBELu+NBEsz+ys4iNQceH
         mflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821776; x=1762426576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgtQ2g+dOWzWnvs0Qi9m2S1QHrl6yxD8lUWBkYgbzlk=;
        b=H8OUWLuGGDx4Ja4lLOFEZhla4CiqwnlCabLUxrZ2wsw4mbPqDeEaFqbAoX874pxAxO
         7S3Q2AtFm3D8Irn7nXjJuRh1ElGELDoQ5NsaGxlA9MApEXMLjYrKiTuOjfTMx3Nv66XX
         RqL2OJSiV/9nsrGTH8lAzhCiBQ0ASgQsJmt3ua3UkLA5leS0rQvnPk7+cvRG7rXf//ZN
         rA+B87RVGJJW36mVOXOD7jdOG5fttj4Fs+mzURA+evaTFDdvy5+jEiqYuoRY+/xHnHBH
         X0775JSdtGSqkC57jjd7jGR06cGHHN+8e24mmUn8iTVclZS7ZMTBBOzWT36qdKG9klZ3
         x5tw==
X-Forwarded-Encrypted: i=1; AJvYcCVZwvyIP2xF+qzlyFG63RJ/eJo4X7Rx+z+AjYqjRRKjjdBoFSJ2QgYoiEBEn0yjGfiMIIfyEbO9ZBwFbGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWENnJajO+TmkSwTaBhpiKEU48SgfU9LYdNh3R7FQcKKTh0O9w
	iR7gcnQrMfNEQFjaKKQ8TYm3KXrxFcpj7r1gGbwiZ2+FUtYstoLuNYNBJD6s4kE363SnSOipHuB
	dY0wC
X-Gm-Gg: ASbGncvNM4NxDbSIp5SNgrqBNYw8p2c8EZlrrxU+JtASDFnBaSlLik4Zp1E2h1mm4oX
	F0ZMzoMw8+79vESHYeNvloPeNlge6Sxx7yKXS7WHHO4VrtKwnSx5/w7M3oH89fhXGMXugk7gaPA
	R1nRFVvr+2zjKUxcDj0gVtp5PiHrNG0/lTgzYO6CwyU+EePmEHGzUGGAo3Ff7spU2Wok3IMW0UG
	NfnnOEpMMKgvR61gIDmK9K1tBy51x0D09QKzbZpSrdzArl//6xUmYYnyk6ObiI9AaRY2eUVTACx
	zuKpqhBDTGUTO17YG5L/6NUOki28olGchQkB+nX8JIDeR1Pcz2IW+FV8OfiQ9eHONa7nZX7hk8Z
	gf8ETK9x+RKD8xzBtTRPqGvuwF44HaQj+UlZ7lWVHTrj6HBSV3MZuO2Iq8QYpPQikjknbBemCD7
	KmfBeYkwoONSlfi/7HlPJrbO/KtBM7i0E=
X-Google-Smtp-Source: AGHT+IHp9g+3GLV8nhOvZFlsBnzq22456ksW+u7Llq4jQZH1laxHnfyEWYwfZxT0X86+Kf7MqNOXqw==
X-Received: by 2002:a05:6000:2c06:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-429aef77a7cmr4631570f8f.4.1761821775776;
        Thu, 30 Oct 2025 03:56:15 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm30865202f8f.39.2025.10.30.03.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:56:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:56:13 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Chen Ridong <chenridong@huaweicloud.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RESEND PATCH v3] sched/core: Skip user_cpus_ptr masking if no
 online CPU left
Message-ID: <zvam3p6t6kdmegdbmziqzvwuynxkmeikmedyxmyflk6fxyrx3t@rmqed2h7geej>
References: <20250718164143.31338-1-longman@redhat.com>
 <20251029212724.1005063-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5s4bksgkambzrmqq"
Content-Disposition: inline
In-Reply-To: <20251029212724.1005063-1-longman@redhat.com>


--5s4bksgkambzrmqq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH v3] sched/core: Skip user_cpus_ptr masking if no
 online CPU left
MIME-Version: 1.0

Hi Waiman.

On Wed, Oct 29, 2025 at 05:27:24PM -0400, Waiman Long <longman@redhat.com> =
wrote:
=2E..
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@=
huaweicloud.com/
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

(I had looked at v2 back then and reached the conclusion such a fix had
made sense.)

--5s4bksgkambzrmqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaQNESxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjW1gD/ZVVDsDeg8i30BmkfLzuy
LU04a994MlPC6JPJXnsPJfoBAL+o5dW3wD3U6QQG6Dr7vgU94GZrzADRRx2J3NfJ
J1AG
=8TQJ
-----END PGP SIGNATURE-----

--5s4bksgkambzrmqq--

