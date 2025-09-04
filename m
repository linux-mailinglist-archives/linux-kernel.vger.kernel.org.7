Return-Path: <linux-kernel+bounces-801025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9939B43ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5C1619E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77E3090CA;
	Thu,  4 Sep 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JIZ0johu"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF83054CF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996239; cv=none; b=T7XiBUKAu8bncK4uhnmFCNzAh/52SO+og1Q18CzvgBTaWQ6oYQxz4i0x46ri3ag2T0L1w5ClxzS8JvbtiFxT0OKfqoNNUFfUar1Ue80GhFTBoKS+5jJH5CaA0IX0TTlOElQlHTR8IrDAZ2DII8cjBKe5mMmYFQ+PqPe7z5BLuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996239; c=relaxed/simple;
	bh=zJHIz3YRmxc+02v8bM4ziRUOLxTM2eTuBpEimmmwZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoeIaiVYVQF2W+7fZdZmjEktrRlnC8Szh5qHofI2hpzJXKljpv6qRpVrY5wM0CPi0JkNAIxExRxv2BwxlPsxnd7ZdweXE50kmJ2ZI2X2Unse/7lZ2KxMx5PKhZAtJAzHPGYpAsX22YXX2cHjMyllshGNQRSAmeDHCQAwqrx7UZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JIZ0johu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso999227f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756996235; x=1757601035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hX/bF6HxE9Anf1wDQ91C9LDHW5RaXiJsPIY3BAgxozQ=;
        b=JIZ0johuPRySIFt2/Hz9qmeM6U9yu6E6K5MjuTAWi+UvnyRJzg49bM6iT45GyuyZ1r
         aN2Ln23JVFKpk0q2IdTXPMKZkuy27sZ8un6klvt4Wzq5vT/M21P5S5IW5AlW5cHtqsCF
         rPtqF3sWoq/Kvwsa39uoO/xYT54/zcX8E/JJch/vfn7JlN3faH7uUvQEctBzjIRJLwYR
         MHLOhx6bgSCOI34f4ZHkFCfwOY/r+mZaFwvExfAFdWvzCiZnGXbZ9GqnjvEQSa8IJb9r
         TB5M9L9ohVDp798vBI/hEYna3tXuAECvFL11BY4fpc9/9umqpG0Z/YNm2Cn8EjC5u62O
         8FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996235; x=1757601035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX/bF6HxE9Anf1wDQ91C9LDHW5RaXiJsPIY3BAgxozQ=;
        b=hEJCPzyqCRtX+Mh3SYaxcmN4raH8Gp0wBrAgP1W0L/qYE9k/tYpM0+CBRrl1qR3s5I
         vBbex3otT+2yzkghv84Y+3fSTIXBYfPPqJ2MjzrX2gzUmo16BCqOpLyv1no+jRPbLDAD
         N3XSBrUxyPjKZw09DwT+NHaGPmzbk3Q766XX/HE1UlRZqueCOdJ1TybJiBhDL9CA+BJl
         gNMnpb4GMjpdUVj+TqZMIOHcwziiXEmliMzcUPh230f7MLDzm5KuJe3dCD43HBpM/E8H
         e4dTFuqItOZ/ydeAKKJRZSkDMJk/RaEbtU/Dh58EZS+6KPUpyaOzwaC3gAC3iK68fhx+
         Hikg==
X-Forwarded-Encrypted: i=1; AJvYcCVDO4Ihpj6cKXerl0jxAML9WzvD++DnSEi3TGxrMBDnhanNYr23S+YaD4GuKosJbvL0c/A1XfFRZH7s0pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4Q+1FV0HMdlSuVW+s8W8lBKIIAK/Xv6JqKuEU/c6K/w74bwR
	oPsYKRNV6HKsOkMrjCkt9s3ntBBrSLvfmkA9vI28ubnutK4N5LEm6Dgm4MYnKeqPGLR3Y+mktX3
	VhYlB
X-Gm-Gg: ASbGnctyeBZI74ACkcVUfAhXu9a+YrPPZ1I2+ElIrotkdWOWL6jLzTkQqqfftUPungR
	rgVnHgeelttfWYZUm+FeH08816sdifrfF4gbFv5m62szh5DnQwJ/k+vzumbcXeyVDd7s352tI7p
	p4X2IgMmGUNSnElThhVWo8ymqts3BoFX03D8fDKdHKFN5g4Hqz3zKtXIYx+qy5bS6POzg1IsDqB
	jGHkR7SfqXyFhzz1r05eiIyAAqpBjejsiafL2ZV09r5upeILyl2YP/Q/c1xxA+1c4wm68pfjV6Y
	R4exwAFRokHj2jgIdDgG2JxN85gY4+gTflqYJwYv5z5Oi12pRrEKT1JXbgOZcDXBBJ234085Kwk
	XNdEsp1voVkN8ZSZskl/pcagbWYejceleJqEkpFTgTkEX7W2VKtQEdA==
X-Google-Smtp-Source: AGHT+IE64SW0b9G4EriIgoQIx3IdJv0SdEU7rMWSMoetIGgaEqvORKKpydbxM9wZI32pmP+F6RLT1w==
X-Received: by 2002:a05:6000:4007:b0:3ca:4b59:2714 with SMTP id ffacd0b85a97d-3d1dc5a29dfmr13638077f8f.10.1756996234784;
        Thu, 04 Sep 2025 07:30:34 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b72c55c1bsm392552795e9.10.2025.09.04.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:30:34 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:30:32 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpuset: Don't always flush cpuset_migrate_mm_wq in
 cpuset_write_resmask
Message-ID: <3jopfa5deuncuvfjltop7qu5dvdak37imdtmkjmnd5alg2zc2s@wiaztnxwgavz>
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
 <20250904074505.1722678-2-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bu3pxxhfgyevwhcb"
Content-Disposition: inline
In-Reply-To: <20250904074505.1722678-2-zhouchuyi@bytedance.com>


--bu3pxxhfgyevwhcb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] cpuset: Don't always flush cpuset_migrate_mm_wq in
 cpuset_write_resmask
MIME-Version: 1.0

On Thu, Sep 04, 2025 at 03:45:03PM +0800, Chuyi Zhou <zhouchuyi@bytedance.c=
om> wrote:
> It is unnecessary to always wait for the flush operation of
> cpuset_migrate_mm_wq to complete in cpuset_write_resmask, as modifying
> cpuset.cpus or cpuset.exclusive does not trigger mm migrations. The
> flush_workqueue can be executed only when cpuset.mems is modified.
>=20
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/cgroup/cpuset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reasonable and AFAICT correct optimization.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--bu3pxxhfgyevwhcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLmihhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aj5GgD/VPKgsWOqzEtLK6zNV7T5
YOpZLkevhgWIbOrGsUIrf7cBAK24IkfPgyN5ApBXH/LsiWO6K8unvyZI8hqmPrtH
tPYF
=WtJn
-----END PGP SIGNATURE-----

--bu3pxxhfgyevwhcb--

