Return-Path: <linux-kernel+bounces-786781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E945B3692E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E321C41112
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76F3570BB;
	Tue, 26 Aug 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fS7/0m0K"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA934DCCB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217702; cv=none; b=kVP+Ww0CpiEljHrsXKwLr1jC+LTiiffea6n3/JVPXMFWvNCrgdJmJPD4x8J1krQanCkzjryYnQAOTSfcaOh06mHf3+yil0cWbKjHdqmAdo3NOtBshz/ZiiWXOpMpX8t+w3HaLBe3nLHT3Nh1d2f1XrvpfeLcNzIaf68ATIZMzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217702; c=relaxed/simple;
	bh=j2v0A0q48Y+rP+Quw56cvQv25ire9TkxoJudb0SCErc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8ZUjOzHdLApBUa+t9ByBeAX6KfVGCWNM8wHowDn9L73QY3byqPOi//wp6smS9w/e5BD80JW+cVajLxPoOsxK3XzsnSsyjIh3fJoeVkWTGDneeYcgcGMIDT72PCsO/lGh8YFWg/bkMe5Hi4tUdpwmToyq+cP8lYGfqUWjZg6F0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fS7/0m0K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso3107060f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756217698; x=1756822498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7ulmsQD4oDI4yv3IfwObO4+vfM4yRrLpoBk1yyAumU=;
        b=fS7/0m0KgmlWPSmXys7DBPGSw5nPTe6B7sFZTRWnlXS+Hb53YuGa1AeO4KQVhUiO3O
         Cx13Gj02g/3D01TiOucK90tMKHIL3rsh4gPZrstmupOjdneGlPilH7/AzW7ZR07hR/Q3
         C6M/4wHv3ZKPOsiDMBzgw3hF2wpBJFAU5i3rvMZ8DwRxJ2YrYFxB645ZbI96odkMP0G8
         oqHXrIIrryKve6Z9lsR/Ie5VF1HkrnYvNEo5Y3geOpH4d3i+0mAI1zQ50iwKOkaYGQwx
         fwt6u5gm2U6jkrXl7LHPtUz70YAZzq/eLCMiIeUHooB8N/ekNhVrryole0MNbvzDy5KH
         CxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217698; x=1756822498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7ulmsQD4oDI4yv3IfwObO4+vfM4yRrLpoBk1yyAumU=;
        b=PmQiAc7PvsVTwkykidKXHw3gSvoaHNcX5kurt0dus6HpQ3UtWZPbJdLE3qtBL74t3e
         vPMxBWYI4+mE1YH2Ixl8V9jqejfjVODMTtUqygOb2gbG8i/nd1XusxIWPAXy6K8Bm7n6
         PMueFxScsXDJbQEnowkRNgTu6oMcQrOzmwd9O7CzOfMJbM1Ygcf2zxphpxfAChl2Lfn9
         ewhhJN08SUol9vdXnZ0ObyRkwV+oXTnCuSRSITjvyEYwlPkUfW3u8329dAcXdvuohL6H
         gMZYeNN8lTU0EDuPXyJXOIhOgcLad/WFzbCVIXxU64scFB1FEp9HLn/YMj721+KQaWu8
         AhJw==
X-Forwarded-Encrypted: i=1; AJvYcCVQgfsNRAoS4fBakMu5jlQz+/4safiFhW1DKTEMxpNpuSYhuw4JhIqzN0CUcHWqTKp7WgMUicnJxXAtglQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+wO63adDc58hU84cVyx4qgQa1QbTvvEyTynrgEDF24MmJXo7
	YRrBE6ob5kEBpVRh8wtYOhuGjtp6VHz7XrytuYS6154n4uaqK4AI5+0ZV67iSrueZFA=
X-Gm-Gg: ASbGncv2rOoF19o3y9zXAjlqlrTYv10QYrkmGWDqZxvdZx/9gz3+ObQDA4y169whNt3
	waHImpA+guRyMWWyBwBl3lOAJ3AF5zyr9erl+EgmyzqWUUJdeG+Yj137yo7/nrt6UsWWN/TIDjp
	HbFMg1EZ9x0Pzk6xKaZspOvHFI3NsMa8lwozmiWRRUTKk3TpaCUO3nxbb4ZWltVIW7dVh5Fp4XK
	6pMCFnwfR5fyY0nrUp7FTp6MMvvtnQnp2+IYAhuEVltgnd9uzj/MIkgNKZXydthMSYCU+wykUN4
	89R/U+H4UnEpW4LfsyBUZDfVmGoS5+RGNvlfT0x8SNI/xm/NSgTIrey28G+E3zrscJ7iaFeMYSh
	VH1ihUylb433uAPNuzyIcPdW7Ty/p11aRyHFMgxsWgKg=
X-Google-Smtp-Source: AGHT+IHY+9mOjFXN8yku9tMcb9AW0UGOczM9gh7nBsRlIIYCfLujOywpKW9tTNOB1kBIpa8Uxt5MFw==
X-Received: by 2002:a05:6000:2502:b0:3b4:9b82:d432 with SMTP id ffacd0b85a97d-3c5d7ac6ce9mr11774526f8f.0.1756217697872;
        Tue, 26 Aug 2025 07:14:57 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32549fe6c74sm10082400a91.6.2025.08.26.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:14:57 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:14:47 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH cgroup/for-next 1/3] cgroup: remove redundancy online_cnt
Message-ID: <zumtn2pez376u2xacibdd6eueeueh6ole5w6pqbgccg2bj7fgd@o2szr644a3om>
References: <20250826034022.1736249-1-chenridong@huaweicloud.com>
 <20250826034022.1736249-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e37cwfg4njgbpo5x"
Content-Disposition: inline
In-Reply-To: <20250826034022.1736249-2-chenridong@huaweicloud.com>


--e37cwfg4njgbpo5x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH cgroup/for-next 1/3] cgroup: remove redundancy online_cnt
MIME-Version: 1.0

Hello Ridong.

On Tue, Aug 26, 2025 at 03:40:20AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> @@ -5949,7 +5944,7 @@ static void css_killed_work_fn(struct work_struct *=
work)
>  		css_put(css);
>  		/* @css can't go away while we're holding cgroup_mutex */
>  		css =3D css->parent;
> -	} while (css && atomic_dec_and_test(&css->online_cnt));
> +	} while (css && css_is_dying(css) && !css->nr_descendants);

Here it's OK...

> =20
>  	cgroup_unlock();
>  }
> @@ -5960,7 +5955,7 @@ static void css_killed_ref_fn(struct percpu_ref *re=
f)
>  	struct cgroup_subsys_state *css =3D
>  		container_of(ref, struct cgroup_subsys_state, refcnt);
> =20
> -	if (atomic_dec_and_test(&css->online_cnt)) {
> +	if (!css->nr_descendants) {
>  		INIT_WORK(&css->destroy_work, css_killed_work_fn);
>  		queue_work(cgroup_offline_wq, &css->destroy_work);
>  	}

=2E.. but here in percpu_ref's confirm callback you're accessing
nr_descendants without cgroup_mutex where the atomic would have
prevented the data race.

Also the semantics of online_cnt and nr_descendants is slightly
different -- killed vs offlined. Or can you add a description why
they're same (after workqueue split)?

Thanks,
Michal

--e37cwfg4njgbpo5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3BVRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhMrAD9HaLehNCEvy9tY5TFCzK1
fhYL1r/LBmh6LZ69zkiz/coBALFvZYfRRnQz7gf8u6NLbLjSunueITfmuykfyiWJ
k6QB
=V09U
-----END PGP SIGNATURE-----

--e37cwfg4njgbpo5x--

