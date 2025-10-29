Return-Path: <linux-kernel+bounces-875286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A89C18994
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 140EF34B565
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252E30DEC0;
	Wed, 29 Oct 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE8pU5fB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229429CE9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721991; cv=none; b=gt4/Ic6JiP7oKFGswxLQDbrJZgdlU1D6MDpEdR2MqH99OExVSy4fC5HC3R4tqP4jjTP8Lp8lWfxSHovMraslzlhxd2XGlI1VU60LvTtiJngbU1/yPsCcOmj/TaKsT2FLc1joS1coJ6QoOiKEManjH68CwibLu0Cfq/9ScSfpDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721991; c=relaxed/simple;
	bh=2kyOxJJWwjPVbI6PfmUjNp+QaO4Rel2HqvBjPB08TAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FERr8XAQuFenENXsVjSZmk0Aa4ZOAbW6lFbqzQbaEMNUoD3Wi09sZplJZBeIcJ4OgvljRHs7cYfGIQSgx9lLhnUPTnJTWaILk4XapcqgjL+TfchvwaFJuX/I7ct8m4m40bs/vaAz5p3NJaU0Y2X7lNsmQQJYLRk8J/w6G/uJg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE8pU5fB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710683a644so5911105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721988; x=1762326788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrkuTRXdhrUwPkZ8oJK1F0pLoaivBeR5il7sP7DvySs=;
        b=cE8pU5fBLqAs4RdUskJYqkWQwXrYJjCX3bhDdw5/ZAGrvFnjOZCfi2g+vgtpJmMmAS
         K6I2aG/NaMoN32lmfhftEshgnVuPIE/zmBQ13Uz0eMj0ZAj0r18Gi0sayHn6/KlKkP0n
         /n2ec+YVrIExVgDfEqNsAq7NFZLQ0nyqTuKzg3KNtSIlf+drAEMzYUT0GmW1JXZ5c+ii
         OMe281AnOSEpIprYCP3dN4/rKqkPihSX1fu3ujtQbeWg4dgtYVsmMiHWAYBzEVEGZWUZ
         +wt5W3iCKRXwees3gQI1HVB/O0Z71wkkSlvGGEcrQ48Df3l96ggwvruNe0/wl6gOQBiC
         Cy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721988; x=1762326788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrkuTRXdhrUwPkZ8oJK1F0pLoaivBeR5il7sP7DvySs=;
        b=nnl2g+HcedfUA2Kwzbjf94lSQkvr6QISSu6/J9KntShNhOovWei0ejTUtLVCk0Tl2t
         STHplHKur5t/IsbyONJh4OOH1u5JdmqHGwigvRM6xWPKUha3+mjHezcsV4J7pyy9KvCe
         bgTrLQDZo50DAPMrhlfLtCbj8yOHyjmVFu3QwLaDtJd09oZirVxd7yzaoFbncLsHPAtn
         gc4HDYxORh7Auw8pClzejl2+9HwArvCPKs0uErYO/vBjo7sv0fONbmsEAqayMBzhZDPM
         GGxarSbC918oKcXIIEHHvEye8d6TT+N2U2SUATnJeiKS36ix7pQ/Z3Q7NkU4uqUrmZuD
         1r8A==
X-Forwarded-Encrypted: i=1; AJvYcCUdWlVyoZ8oK+0uRJduALxfZwGKEA12mzcvk+iaGvPReIs5MPMK+q3dMsiTBYIQALVVPe6BH4jIx6abSho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQewxrkT/MuuQ0EYAzJG0mYFCw19KKlMTGDSZsI4MefS8N9S8k
	mgrjVPVa4Mhx0Ri56OWAnLG4rfucXFkFY1p9eHDDzvGFs1a71AhKdRIL
X-Gm-Gg: ASbGncuDd+eXIR1jA2gti3/xFYa3oICt/5jnuEmARRkDNCFJ/PABJD18vKHVBoTpJc0
	txs6eA87q77eiWuaHtV2Vw3gq4RVtBdiwkT5a0xV+5syN8VSS+6GFGK5Fo/SwWIcTFgTlt7FAR9
	gXNCDQyDbjwdPJDkrh/GCnDe9lc/Xu+aN3Dzu2nZTm8GBpx09/OVqUNTdfOmT9eQYXDzXCvFva9
	y2Ej7gH/YaY9ARvHSZ4ScN0a3yb8w9vQKjxE1fKtxAA2QQJ3Md8phH/uIVTJQF+JrmR71RMX9u8
	sKpj4ZGmnSR1VrXOt8Qh0ChQzEiIUGUMNJDWWyZj9OIXKpuLGPOvYINnoarGRYKwygJ6P7LORNM
	BzYBBWMnfDHjcycYtUN89JOPrceMZS9u8ZheSrn0NhtwPt2pwBJl0ufAKtuaR0OzH7TArej6g0F
	yHdO51NnIORDg=
X-Google-Smtp-Source: AGHT+IGEGOsE2OrnbbcDCdmAgcn7mj3aZWx7j5UssiM3k3nBBvBv+aa77XTfyn5OWYHEU6eg94BWQQ==
X-Received: by 2002:a05:600c:534f:b0:477:e8c:923a with SMTP id 5b1f17b1804b1-4771813941emr35517865e9.8.1761721988174;
        Wed, 29 Oct 2025 00:13:08 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm36243085e9.14.2025.10.29.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:13:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 37B954206925; Wed, 29 Oct 2025 14:13:00 +0700 (WIB)
Date: Wed, 29 Oct 2025 14:12:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH net-next] Doucmentation: netconsole: Separate literal
 code blocks for full netcat command name versions
Message-ID: <aQG-exiysk7_oX_c@archie.me>
References: <20251029015940.10350-1-bagasdotme@gmail.com>
 <4521c29e-e6c3-4d9b-bbce-8ada0dd2065c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYZiC5WpAgVKy3eC"
Content-Disposition: inline
In-Reply-To: <4521c29e-e6c3-4d9b-bbce-8ada0dd2065c@infradead.org>


--mYZiC5WpAgVKy3eC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 09:58:07PM -0700, Randy Dunlap wrote:
>=20
> (typo in Subject: "Doucmentation")
>=20
> On 10/28/25 6:59 PM, Bagas Sanjaya wrote:
> > Both full and short (abbreviated) command name versions of netcat
> > example are combined in single literal code block due to 'or::'
> > paragraph being indented. Unindent it to separate the versions.
>=20
>             being indented one more space than the preceding
> 	    paragraph (before the command example).

Thanks for the wording suggestion! I'll apply it in v2.

--=20
An old man doll... just what I always wanted! - Clara

--mYZiC5WpAgVKy3eC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQG+dgAKCRD2uYlJVVFO
o054AQD43ZwtXso0ovYwZpCUIfBKSjxyG6/LhxxzQMEwtIJDigD/cgyISKbGmv37
2eNL99Mpl+HBiBw/qLw7pZhWoPi9Kww=
=KvAw
-----END PGP SIGNATURE-----

--mYZiC5WpAgVKy3eC--

