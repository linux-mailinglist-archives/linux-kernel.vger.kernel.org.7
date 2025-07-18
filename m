Return-Path: <linux-kernel+bounces-736877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E7B0A487
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959DC7B6D50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1822DBF5B;
	Fri, 18 Jul 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTiAW9c+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510CCA4B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843327; cv=none; b=YQavnygZmW1wFy+5R6h9OVfHsrqxBJWbgOz0/7523KpU4sfaibU8UnCmQcTlrexxRMPRVwjN40EPkxvtOinGBWA0WMtey1STsNzdU1RdvMJ6Td3HVc5LtoqkuoF/Bxw+27rCLrsalNu3cB3fqmz+mlPKG+6H/tMm4yPI1fKUa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843327; c=relaxed/simple;
	bh=8IJKjEk55ePflG+iNS+MR2mxQCyHY4vH6f7Igu2l0dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn23w0SicWMHW0iynPx6wZ/3jNFJrH7zfdM7NHkornOAx9AkrxE+DnvZPeGrVYeHv7NXiN9PPa1hS513Pm3f7mUXptuYJ3NPjFtj8U0d19zHLfXsXzBOV8pmJ6z7eHV05/rZaNNNZ5MBNIcvTCQFEKfZ7YWekoS4f84udlioLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTiAW9c+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so3510353a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752843324; x=1753448124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCxzk14FWSwkmRa/OG1KGHyK6K9KE9Zr8Gq8f2yb4aw=;
        b=PTiAW9c+Lz+8SaSM5JJKfyprCZlu7ZMHjBvL4R8k2YYvTvEwFG9/eFoCUJqBz10yH7
         JedMKZNQcbRTd7ObmbYtXvzd3Qe6Mc/GpG0wWamth/mIJozVyhYj3MdrV/VZa/8YWB9t
         1edtZ6PFRHg08X9aZPFyQzATusZ7aEOA6PVQXFrnCNb0IuoN9KRiiqddpvC6amtFuaCM
         VgsHIADQVubd8JlyFjwHHGwR9sP5tsKj9YSNcrjZlWznw0XMIH+tapX+pW2VSCyF6gBQ
         ucFHNCPtivdleAuW2Rmfxte2/eIZ8U1B053R6mGglCEQ9Fhuly8CktUewIFgF8PuZgjp
         pdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843324; x=1753448124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCxzk14FWSwkmRa/OG1KGHyK6K9KE9Zr8Gq8f2yb4aw=;
        b=hO4QkVCJDvLGjWPJsnW+ONxslPhmlzqJY7yiBEhzdXO1YBxWCegfZGGs20Py5zF8rO
         mC2fYaJuIzQEi+vciLtRORjuNHaa8n/X+HPiLGfqFdYW6nxaAThaS2IV7eiCCOe+Zf/G
         Ii/h59asDuzE3xaK0B1V/a7bR2xhPOAAlyJiPA/bO1MRjlpAG40YAer6tdPNSg+KB6gR
         FpDZXKhOMkJ7jOseBT1Cmsc3XzlHjLXKwJvMmDet59DtZlaQbRUsulKPxv312TCwLIjP
         RnVnPYhCtbLICDE+doFoWm54hVy1gaxpIJjjyCzc3DaZcX5OyDIZD+GP8pnp0NveMv2O
         GkUg==
X-Forwarded-Encrypted: i=1; AJvYcCWaQLSXEztI7bFHPxAwlrpcwroCRly+ownKlkiPBaOADv/R2JdTQQHbPDU7LmET+qv+w3osmNl9/0n3Q3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZeTnKjyccWKUEom7tAJAUNKSh5nmAYpKxXgIeRstC+HkE3knN
	wcN8wG/TljRGWdUn2adwEZCjWA0Zl9Qm4FYkcOt+6fUwL2tGKzN6dZhC3V4EmzAk8F4=
X-Gm-Gg: ASbGnctzk/w3GtegQplFJfHBGo5U66wqMZHcg8sfUo3qwplsf0UtL9tFGHRGcx0SPZh
	VGjnJek/lAxinpjCN6/BUmFz64SIwIK3b+DDTaRNxy5EOuFEJdgV/p8CK7K0JApzHLd26UoeXEN
	bAVV7Hgy0JfymGf2RNph4e3l7w+7L6JRVrIxtZGHB9wVXzPqpDsLjhlyJ4c/bAowtEtJRfDI+og
	JW916HiP0nqJg5y+CKzKpUrnah1ZanmLNzfDzFBvOkltdjnMM+6o7EfG9PNkc/i73BZNPnPGp6L
	PLD9BLVxZ/SgmyhiibZyhtjgapSH8WCpHpoPQYiBQC8gemip6XGjV2/sMdfEBCm64TDBvH37ojK
	s0/QWl2VZLdN9N9ydZMSfTkHM+NuQ4+UYHPcVtHEm6g==
X-Google-Smtp-Source: AGHT+IHMdtSzyQu2KatLxBDlAQQxTotw8jfYZxlXV4WRCfZvX2AHS6thniTmI7PY59OB5DVyF71Ngw==
X-Received: by 2002:a17:907:c808:b0:ae3:a3f7:ad8e with SMTP id a640c23a62f3a-aec4fb05ee0mr708682966b.25.1752843323746;
        Fri, 18 Jul 2025 05:55:23 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf76bfsm116466566b.160.2025.07.18.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 05:55:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:55:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zijiang Huang <huangzjsmile@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijiang Huang <kerayhuang@tencent.com>, 
	Hao Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH 2/2] cgroup: Fix reference count leak when cft->open is
 NULL
Message-ID: <vlgk7nn72odfg4xk34yagrvtwlqb3qkq24wbsrvjctd4upa5vm@7jg2iy7pkqof>
References: <20250718115409.878122-1-kerayhuang@tencent.com>
 <20250718115409.878122-2-kerayhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uydoxl7wjkyfaz5w"
Content-Disposition: inline
In-Reply-To: <20250718115409.878122-2-kerayhuang@tencent.com>


--uydoxl7wjkyfaz5w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] cgroup: Fix reference count leak when cft->open is
 NULL
MIME-Version: 1.0

On Fri, Jul 18, 2025 at 07:54:09PM +0800, Zijiang Huang <huangzjsmile@gmail=
=2Ecom> wrote:
> @@ -4134,8 +4134,10 @@ static int cgroup_file_open(struct kernfs_open_fil=
e *of)
>  	get_cgroup_ns(ctx->ns);
>  	of->priv =3D ctx;
> =20
> -	if (!cft->open)
> +	if (!cft->open) {
> +		get_cgroup_ns(ctx->ns);
>  		return 0;
> +	}
> =20
>  	ret =3D cft->open(of);
>  	if (ret) {

1) You wanted to call put_cgroup_ns() instead of get_cgroup_ns()
2) The refernce needs to be kept during the whole lifetime of
   cgroup_file_ctx, this return path still leads to a valid ctx, so it's
   released in cgroup_file_release().

Or could you decribe more how could a release be missed?

Thanks,
Michal

--uydoxl7wjkyfaz5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHpENwAKCRB+PQLnlNv4
CJS6AP9o2W2dD9M35Rn+YDuf7/+TjAsjRe0hI78st/4KabFwfwEA4VyCxW3CCeJm
wPAo6jXhcovxRqkp7iAGgCzzl2oHzgo=
=X3JP
-----END PGP SIGNATURE-----

--uydoxl7wjkyfaz5w--

