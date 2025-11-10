Return-Path: <linux-kernel+bounces-893369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA29C47322
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E5F3ADE42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540C307AEA;
	Mon, 10 Nov 2025 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRYkGJix"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C518A956
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784859; cv=none; b=b5gsqk4mwfh0VgJXZWx69p1NvhccLjsEontBD7xZXNi4iuIFPEAhOVcivna4s/8zPnYpLH1BjpYcve4vIz7yN7YUZ+srCDk0org+rmeTw3HUVCK1n8sK5PJseiF9y6b2msx0SGvn5HzmYnLWKFJaPFIuJ2T9XU9e4JS7qkrLdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784859; c=relaxed/simple;
	bh=ihoIGUSl5KG1eENwxR/j5csfH6FTtQ5eoSNs9oJA6Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AorDeGn9HQGr3yCW6/LhvCcjzlsgZOn4+8afoLjBc1xJ1bPWIRh8jlWHihXp7cmGKvA6nNE1wMDLPu7f3hVCENg1u+iQL7qqUGYq2spO03dlJlCsYVBRkuwChC5x4re69cNcVyU+VNJKJwe7rz2MtO101SyJA1MxklB2Lyqjccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRYkGJix; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477775d3728so14858025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762784855; x=1763389655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Kg3vBr5eIV1bhiU84P8YOC4pYEYEClLlaacpCw0wZo=;
        b=SRYkGJixCHOd9/Arbun0EwNmU+4bb5C90UQJ1GDHKLanUCCs81mj/owXVdVjpomwxp
         Mc3My3CUwSe3B94SJciG2Rc5peVIFORE21gU3zUGbMuwK7wBNaVd5mf0cD2DhWoRDTOp
         htAHD0cYaQgQOFAkK4j+wi3pMFc/H5oLrd0RoVZto7GV4HYF8GfuvVPm7juMLxUfYyvB
         2VeVtM+rmvpm1n9gAtzavK6F0ejRMkSW7UWdl384HFeCPP+XRQRVJCZzfTPdoL4NT08j
         e3PkJjEOSHR6GNp2+Cjzajx3rH5Si7yPXOKH9efJ4K/lMd3lIsQ2zY32mU9yJ6OIV4Qz
         f3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784855; x=1763389655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kg3vBr5eIV1bhiU84P8YOC4pYEYEClLlaacpCw0wZo=;
        b=nZXu2pMmGawI4Yd6a9SB9FM8hi9JA7VOCS2GvvsbdSgu8t1QB6vR8b4/EGR0FIVNfx
         VZf1kblq7Gb5A+zC+49wr6PxOLj1FcyWX0sy4BcbDQIg3Vx1hIqPqpeSJCyQmFAO8uJm
         qCN0LPGQ9DN//yssjByC7dLqsKbiA8mNJ+3HMRNxgMquMqho3aUtooD+50f67SKQ0IiT
         9HM8btnuQDHqFhKDsyQrbxLa/klOPrTtCSY6ZhYEb4xO4D6Kn2s2y/RqI3ePOQhtaz9i
         YgEl58J6KDM4I6GmlVkH4mrpWw01bE3D9CvwavU0JupXdnKtqHc1+kqfgV5sa4JSIEPt
         RqLA==
X-Forwarded-Encrypted: i=1; AJvYcCX9IolhL2HPi0hqXd88zLQPWdvH4oeY2gUceKoyXwWDueSEO/1lTclnP0fXNIBaACGVtVx7wBPlhiO8F2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC70rc/7sItI9v8XNvs7FIOhxH2c3QNZaL0vnmeU30h+YQ6fWS
	MSA2aqVULeV/Yt8ilrE+rO/oJTkQarGXktkZTLT/D+C3o8VTv/TO+m6jxtcD+CANGsE=
X-Gm-Gg: ASbGncvjAyFqsVorpT/tCOVpP+PFpJag8GxhI9BqohZY316YVWCkZbK20SnCIZ39oOj
	OLt9nP6pRs/wRYidkSWpUA0gBrYHdE/ztYDXAIAAqv3bGbJzevgh1lc2N+L0sH9vWn1qX/K4R7t
	rlyRu/bysUIu5xgwnEFqqYDQFYZK4HyNdK+TZlMSc79OWawT9jsnF2sSfzdjrwrzkTbJ3s8Ezy4
	BJ0F6yEIPY2XncgRI/DeCafrWxqXLkDimGj5kJjfjnJ5iQ98pY6ecEbGtabjjQzd6D/+BUHMRhr
	x4MBnm+AzOSpfihW2VkO+9DoJOsHGqQCfa/Iq0awnjUO0ocPo4kEWOe2Wr009C/w4OrXcnbrCcB
	H2mmrKJ6JjTDUmTD3M13aQdCnE0iioBIgbCig6mOuUHE9/2Qrk9jyg4zsdng/zB8YT3hBmrDrXu
	h4BGg1dpNDN5aCfY5eFRf/
X-Google-Smtp-Source: AGHT+IHML8MOqcOYXtiQH3128zZ7cQFznn5BzWZ/x/UpuzVV3JHCT24/iF1D8qaKQPfZa4W9/kkUDg==
X-Received: by 2002:a05:600c:4f4c:b0:477:7f4a:44a8 with SMTP id 5b1f17b1804b1-4777f4a4945mr17710055e9.29.1762784854868;
        Mon, 10 Nov 2025 06:27:34 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm116549665e9.3.2025.11.10.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:27:34 -0800 (PST)
Date: Mon, 10 Nov 2025 15:27:32 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
Message-ID: <o3daj3fasq66buthgl3rherobjqwkemjge5xlrgfzfyvcjxyme@anbppjgrj77h>
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncajuq6cdkyono22"
Content-Disposition: inline
In-Reply-To: <20251110015228.897736-2-chenridong@huaweicloud.com>


--ncajuq6cdkyono22
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
MIME-Version: 1.0

On Mon, Nov 10, 2025 at 01:52:26AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> There is no need to jump to the 'done' label upon failure, as no cleanup
> is required. Return the error code directly instead.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--ncajuq6cdkyono22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRH2UhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjC9wEA3+kvpJFNdj+cvbVOFOqf
Mdoc4b5dv+sH20VJyQfNcTQBAI6c/7vhNcZfsC3tkOPJETcbP9dC+sU+F8uUm7aq
jcII
=MKFE
-----END PGP SIGNATURE-----

--ncajuq6cdkyono22--

