Return-Path: <linux-kernel+bounces-796047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8CB3FB57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CDE4E32FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B42ED86B;
	Tue,  2 Sep 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q38/ydlY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745E27702A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806718; cv=none; b=M7CJgKlRIRZztruERjd8dNIi5Mf66b/9qQ/5zGxXBP71TgifAAPR343sg8A7Badb6PAhp6iApnaJLszVmONag5kOqCxTGieWpPSXf+gVsfWTCpVjgRciEBTslnEnLXq/vHaSJ6oWywsn4ooCAm//ziIt2t4yyUUg/GQZeNEitQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806718; c=relaxed/simple;
	bh=OPuQMxOUMKmtd74yhuH3+ZoGiXX/Ej1X/m4lb4FXzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx+Ssu9D4wmypho3tA6xOZbTZl6Vu825JmMFwZr8BC/RT11FT9dCrOvr9VwHGXrDO6RoK3+x443H0XTWzAoKNtG3eyI5klv9TGjHBpoZuAT0L2HVwthnBimn4sayC0D8/aeVr6YbYoWelM/I/8N+9t7mWGt+6jPnnksW09l44cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q38/ydlY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so16879815e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756806715; x=1757411515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TFEg4KYcJYl/xMrj917lNsi+q1ru1ge+qdtty/yQZg=;
        b=Q38/ydlYzKPI84Xh7ggCDW4asKio8ouJrqHPCYErJ6gLYbkIfezrxwXpO5KCoMBQFb
         FXTdY0ZdYh7w4WzfIWJJuPomyjYoUuK0MSxav5kr7ZXZhnJC9FyndqnT8vKkGnlxserB
         TGY3A6LpFRBLqH5bu6k/WhDTKR7OG7OljYuS1feyhIP3SKLOELiAzmmaoJCOY8AEV8Ha
         gUDg4yK5VDuKqRAMFbaIQhGH1dfQ4lJ/FX0FkPVbgxrSWLEjtWN9M/DIj+dXZCY0iehU
         Job0s8C9bc6PWPvkw/l04LgfCXQx8iMj/mlM7lzaYcXUpeHes+yo+RpoLLsyxW96TO+b
         1Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806715; x=1757411515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TFEg4KYcJYl/xMrj917lNsi+q1ru1ge+qdtty/yQZg=;
        b=kveCVZ4vnh1eaHN900qNOo+h2AoyYniJXaNOw0xDwWEBgR0JhCGeIK9LK1XP+rJ/E/
         KtcR7hVyGy/Ve9vzsM+Fevd92c51cjKPu3OpSR8XNZL7qrErjjCp3+FNf7lWJ4zFQq0a
         mSKv4QGetPKb3gLPeLSO1NDC3scssvJsa7z4UCr2Q3KE61Aj28IcfNo355JFVDv5zeLY
         kN/R/xnO5SXWTfRwx9if8mJuytphfGrW+I3/M9VkD0Hn/mbxyIlcoirgrw9kowIk+NyO
         YBrx9meI8Gj5geUzonbOAi2JzG5KeS1/YQiUTaejL1TTXOCeR9pL4dZCPslSHkZmqhHi
         wxzA==
X-Forwarded-Encrypted: i=1; AJvYcCWZixakefdLspFi9QlMLMYcuGVYaW1JphqdQyiBwoHWIWNP8RukJSBxiRJyTRfNzyAUXQH/1OJOnmSzaMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXpzFjtz+wACkTIc+ova8MUB08A2n3rslHr7BtFUhe1d9qJxc
	HmId+rxmFzD/vCuc8D+NjjAzxLy+p1BR23ZYCbAW8UISGkLMBp9Q90E6FjE4PyQ4aXcMyFVxYbK
	rEkAZ
X-Gm-Gg: ASbGnctcMVKFf3T7y/qOfwtvn+KuXB4QMRVxF3DB90ssMPtbUD5WkwFAe9D2Y8lTGwV
	CxYfiDk3y65iunmwv68CfOd9Vwxl2Vn8COJcmUiX2J2dQfUYUTEasKi1gf4wUkN4YZr93pd3DbZ
	TSLzEAcq7KWLq59bQL6h0HDRdektRwb+7L+NpdVUmGreQ/3MqV4s6/zd4JqTw0xP/ujev96XkuV
	kmQGTZ7KRpRT3rvO2RE5X0wO5SyYQ9fMOMLvnKUfjqPZeDCA5HMeejiQx60v97eZrrai5iJC2tp
	LTaJy0sZv149OguZ3STC2x83yrnBaxj7PjMI4redHN/DfmcMot/ROtPSQVIk/WLaDLjH8uSf/nZ
	xL9Xlv/gphRDPkGv8TPSwrpDaHUDlDVlzyCiS9junBQo=
X-Google-Smtp-Source: AGHT+IGL74M/gnuKC4FyY3FBT30oTjIIJaIupFLaAOJ2PpkyzBPc3t2EA4S/LVebXzK30uxba3n03Q==
X-Received: by 2002:a05:600c:c48f:b0:45b:71ac:b45a with SMTP id 5b1f17b1804b1-45b85533650mr84695395e9.11.1756806714687;
        Tue, 02 Sep 2025 02:51:54 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d32a2sm295101005e9.9.2025.09.02.02.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:51:53 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:51:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
Message-ID: <wndxi6qoq6bq6lsovlpfutgx7jfummvipx7hhuu4khrdm35ls2@65nymtjs2q7w>
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5d55kat4d54zghq"
Content-Disposition: inline
In-Reply-To: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>


--z5d55kat4d54zghq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 09:56:17AM +0530, Ashay Jaiswal <quic_ashayj@quicin=
c.com> wrote:
> In cpuset hotplug handling, temporary cpumasks are allocated only when
> running under cgroup v2. The current code unconditionally frees these
> masks, which can lead to a crash on cgroup v1 case.
>=20
> Free the temporary cpumasks only when they were actually allocated.
>=20
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> ---
>  kernel/cgroup/cpuset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a=
5b0ae96c7dccbb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>  	if (force_sd_rebuild)
>  		rebuild_sched_domains_cpuslocked();
> =20
> -	free_tmpmasks(ptmp);
> +	if (on_dfl && ptmp)
> +		free_tmpmasks(ptmp);
>  }

Can you do=20
	if (ptmp)
		free_tmpmasks(ptmp);

so that v2 check in concentrated in one place only?

Thanks,
Michal

--z5d55kat4d54zghq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLa+KBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah3/wD/d3gKmwBoKu8zYX6KDBEq
a2AnLu103Jhxtbr7ASDeO10BANTgH2wmfZE7r24LBPVJCATLBptAqRmzsnsxgRKf
/n4F
=zZFz
-----END PGP SIGNATURE-----

--z5d55kat4d54zghq--

