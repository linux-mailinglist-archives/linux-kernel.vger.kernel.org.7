Return-Path: <linux-kernel+bounces-771055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B20CB2824A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06AE1888F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC5233D85;
	Fri, 15 Aug 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yl07bti9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4F22A7E4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268944; cv=none; b=NlX0Rzj/81NYWoPXqGNn/XwG9W762SfXM7VkjfYktEEijs274LqCAGFP4VMoFfrvwT1XqV5E9DP4c/aNizSz8t0I/9QKBlEnGah/iV+sL3Il8E+ZKCBeQtaNwMMj23sENG5WH8BAw2ioGwDYmRb24IWI1IwHHQEIZkX3xzfYI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268944; c=relaxed/simple;
	bh=E08Z/Gjpe/x4ncuy1dWHOIFHunMG31GwZdhkHJ+i07k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT6EFrRL/03T+BgWsptzpnUhf3vX2SyeKYuU01+vibzrNezt75PWHBg46X2dLTcL4NEEsmhAz2XBvLTg2NvcZ7V17IldtO91gvUyGNXy5/4RPD1Rc7mBaFUmo9h4a/2mfR8zl5szXCBvmSLeAah71cESzdp70/U3ZnePXAVom8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yl07bti9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so13020945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755268939; x=1755873739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrhhDUhBgNZopwv3/8XFWlqe8JuQPPvnbL7V1VwKS8A=;
        b=Yl07bti9GmLGELAJ98oVI/87ptjER5vdh9ZFtLCrQMRtggMKYkLGEFJEpDZPY2XDLx
         ZfThpATH9vsN4F27NDF8uRcPuEYGoYrRiQSlr1MtVea6LpxmfFSBPV42qDy5zZoC93N/
         jsUb3m2MVcuBMwL68sHW6HZ9g2OEElu/Otmsdru1lh8KOZCduOSQmGKfnhCTm4U679tg
         TV1r1bq8BB/6VlYzHrHY0Z6GVNuYSfKKc0jDlsZs9/4/CQ8RePqGK+9/hGRsfkMMG4B9
         nwumMY1hDcNdqo3qW/urct5BhrW0YLVhSP7ddbgTq2Xzhcqu2WrkO3J0nTNPD0d4iE2l
         RCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268939; x=1755873739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrhhDUhBgNZopwv3/8XFWlqe8JuQPPvnbL7V1VwKS8A=;
        b=DagbmhaTxA2JxX6Ko165+BLbJdcYVvcAh1o4Y9dDnXY+IIFn+Plqy/E5IzLNrwN/cT
         MinNqjp4cEOMNGJgwOUiFCLB4hqP+d+ahiaBMIban3jJZ7ZGxBOzi1FWneK41IP5XN/2
         dp31b2CV+WOCn8LJMyhJn00dIO2j9zr1/+yN/lpVejTCA3zz05Y6pq9qNlXk//+n+bkC
         Te1DYCRjB7v3IW6JaucMBIu72ec0kzPH18Q6r4Krwp0TEtU3HSRsLXK/GwL+QACZ5Cwa
         Z4nxS8bqzzBTRtYh5Ct65fbna7fKy60ENEdp10J3St5va0uY8tcoCETvqpKMBu7+atVj
         8VTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8hixq14xV1dibCktPhu9SVwkwhmT9FWyXE9loOHz2LtB5SY9Tr8VH4JQu3f3oZw6iGr9+CAYVgZb3Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8ItDVozCjF2+mnj57RE4bUYhGcfH3t9IZCAegRWs7L2A3JO0
	5LNxc9oSpf6Q7N8+eynDl6oLEy1ycD3vFnAkRkht30OcabjaVjx2n5VL8/OwkndBaiQ=
X-Gm-Gg: ASbGncsVSQK7w51UHmRKmaqdz8n1dbZoSPWaLyjxEVqy3/AyC8V95gCJOFUOcQDboL3
	/omriVhhFRGhqCUFAQAE0vjCJN0K2kXC5DDfsEE8AKVX/geZZXw6Glqm3yI3rOUbXSHByQ/qBZR
	JjcPX97I1ujXFYFPR0VN7M6c8n6aRt5gK7WSuaPlbsGuzMKQrfBUxdKDa+O3vE3P9ZCs+Eyywbs
	vFCl4LWq2JnwjspPxMvk9KKSqZRS+Kp+YxLekgUmF7Zrq9FEjfHMqp0Y7KsWBE2TzZu9kRhRqil
	L441wWmdNBof9jJNDsP/wTzAoAZmavDdA+AO9XHiZ8DcwAsyLNXgHSDoqR03LG/aQj1hUUu6IKR
	kffEA518i3FxlF3zKb19VHcK456RtvFS+1/0ntxZsaQ==
X-Google-Smtp-Source: AGHT+IEboWaeHkNlU+m2U6Jyj7/6NzkEInnD8P8sG3Rh85pdmSXQEYsAqvzgLOG7UNxq/mqhuQwxUA==
X-Received: by 2002:a05:6000:2508:b0:3bb:2fb3:9dc3 with SMTP id ffacd0b85a97d-3bb6646e1c7mr2044697f8f.5.1755268939165;
        Fri, 15 Aug 2025 07:42:19 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566fafsm1288877b3a.73.2025.08.15.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:42:18 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:42:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org, 
	hannes@cmpxchg.org, peterz@infradead.org, zhouchengming@bytedance.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
Message-ID: <ql5573r2nbex53fyygwczyjipmtalc22n3hxxzmqwi2sgadodt@a5pesn5gunf2>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <2025081526-skeptic-cough-7fda@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7waogckkrlgxbmqz"
Content-Disposition: inline
In-Reply-To: <2025081526-skeptic-cough-7fda@gregkh>


--7waogckkrlgxbmqz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
MIME-Version: 1.0

On Fri, Aug 15, 2025 at 08:11:39AM +0200, Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index a6c692cac616..d5d01f0b9392 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -852,7 +852,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, =
poll_table *wait)
> >  	struct kernfs_node *kn =3D kernfs_dentry_node(filp->f_path.dentry);
> >  	__poll_t ret;
> > =20
> > -	if (!kernfs_get_active(kn))
> > +	if (of->released || !kernfs_get_active(kn))
>=20
> I can see why the cgroup change is needed,

I don't see it that much. of->priv isn't checked in cgroup code anywhere
so it isn't helpful zeroing. As Ridong writes it may trade UaF for NULL
pointer deref :-/ (Additionally, same zeroing would be needed in error
path in cgroup_file_open().)

I _think_ the place to cleanup would be in
@@ -3978,6 +3978,8 @@ static ssize_t cgroup_pressure_write(struct kernfs_op=
en_file *of,
                psi->enabled =3D enable;
                if (enable)
                        psi_cgroup_restart(psi);
+               else
+                       psi_trigger_destroy(???);
        }

        cgroup_kn_unlock(of->kn);

The issue is that cgroup_pressure_write doesn't know all possible
triggers to be cancelled. (The fix with of->released would only
sanitize effect but not the cause IMO.)

HTH,
Michal

--7waogckkrlgxbmqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ9HPAAKCRB+PQLnlNv4
CBaBAP43oVsG9hvpd+fisul1x1+rwolSV58J9LSb7n7VoAz80QEAm+hxMRFwmmMB
7V7Z15dEzI3wqk/GDvXimj5mD3Im8QY=
=9lzv
-----END PGP SIGNATURE-----

--7waogckkrlgxbmqz--

