Return-Path: <linux-kernel+bounces-879293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC23C22C48
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4D1A6143E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F13EA8D;
	Fri, 31 Oct 2025 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klJP2Vhk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D52E401
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869384; cv=none; b=vAd95SAcG9179eCMCewX1AA+vy395+8SiBXf8hN+vrA3JqZt0r0i6k4ntJH2wlL5ORrorD0DJ4KtTmXr8C0dPMTDehYyssjUMeRkLyMxgEywtTfKS/BPSHvM/QmfrQtJtFnBG76IdD6dMyefDBAYoTPsl+n76tdqDQVIi23yeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869384; c=relaxed/simple;
	bh=tOqji4svVFYnjsJuuwJe072kmFQ3eEB6odRukox2PW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmgRmjXtKfj4VL/4Ykkh0/xOsnl/t0bx5dj6oKPO+Tq6AXGuv5MvHgyQ4DNq8nyA+0hOLl5Pnj1QJ8TwIyHrR53j2+00IckD6/xcFWT8s6bDkolRieDGyOVFc04BHrhNBiLqHlsEUzamZGP+fqW6HG+4lwvQbYHQJERi9ES/bYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klJP2Vhk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2951a817541so6075675ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761869382; x=1762474182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOqji4svVFYnjsJuuwJe072kmFQ3eEB6odRukox2PW8=;
        b=klJP2Vhkcdbr8tQPOQhgfvgEmrP7vsg+2k81HHP9P/tTtuBIPewkleOebXI+v2cxRI
         iB3nLjiW6+7ZVLdFK2W9yHGd7qeg1FAnAteUpBzo2/KoqUOWZfVKnIeJUuzSZJi0UoxV
         SjI2OjKVg/97+XoQTI8+0/mrKW1zsrZj1x6xkNtRKbgL7krn5Q55m1Yzcvz/VlhuDCuy
         oqPSVeoHZMmdAoDQOrctInu23kK8Yp5wyIZUPj5PgjBc3DQWG/wQu0tAvODnDP1lOx8r
         Li/9tj4L5oWoYA+AkUcLRJ0682zcpVrs0zah+Mh5p905Du5n1m3TGWMDW6chWKaopJc7
         to8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869382; x=1762474182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOqji4svVFYnjsJuuwJe072kmFQ3eEB6odRukox2PW8=;
        b=ds/sB333luTD/bWWVgUxBXQDWD5QoQ0MHcbNCh6Y+9lCK4YbZXrU8mv24Z2tun6pEM
         37Kut8ZznX4qRo8y/1LwHQWwO6fKN/dKbqMUZVgyH9BTwft7J+o4YxDed4+VOw5EJIP/
         aBwEsuw1sJ7xuiXpl7qQeAImatNyNDlBQg9fIaPWCnbljFxISe/56tpgrHBcMiJR4dIZ
         GTBRkgbPIvauqoH1S9AywY5YQ/+OHu0k+fB7YJtZVn65UgEwEl91XYiIa+BfCTdR7jl1
         h60b+aRPrtp/ZCceP7LEeheAwXJdDi/xfwxKhC6AugijSuMT/UTS5/n3BInY6+e9XNC3
         4dZg==
X-Forwarded-Encrypted: i=1; AJvYcCXsgamgOqnFZze8azxhkXDzK0etSmINEdBzHuEpKjIqS6luYA6JHMf6LAXsJCwzqVYhWb4EucklwQxd1rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6ALxGfQzf1VD2SH6960W3KMf49KSb/kaGeyUhHSXC+aHfgJV
	IMQo+XiLdWjJGOom+pmc5BwU5xQ5GJ3KAruejhbKbFYz6LV/nYqxz6GxkhGfhUQ2RGc=
X-Gm-Gg: ASbGncuumhbJscThV4SvtOldIZ5i2dporPWo0OUJnhvCV2LZbU7FZD68n3eCkCaabsH
	rqmq3w2RVC2pPc8oS4IZryL+QR2RjwAxHi9Htagfcs3raj027AxRkCkm0JOzf5z68YqDBu9zW8F
	0XyhRreRlvvQBg6cZTczZWPTp1sSASBAlHWcmGyIQJ3CJwpbGwxSA76h404FO+1FQ4HlTMGxv8D
	fbCP9tarnjH6f8ElpNTmPpKEOVr2ne1VnMpjZ8vpiw0ZAQmtNgdkxJENS2EJMBeI3lDBT9CDtAs
	BVBfa/lKzVJJJFeBWYRXQcUNI0ImQC8UFi3fSKfhevtAZYWXb8yYNW8e5alMD6I185KpmlwaFZx
	I9BZQBoQbhjSDYMmhqzkQzXamRoi8/v7YgnCBchA8iLo+86hbHXEHu+oojQ87rBlcQTsejYBV1i
	TZ
X-Google-Smtp-Source: AGHT+IEXVNb2H7WFZFLBuvMGoO23i051th+3XKdx2cHyPS895ioXoRXcS0lzDT9ZxeAWygJirg3ebw==
X-Received: by 2002:a17:902:e78d:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-2951a52a946mr19593005ad.45.1761869381941;
        Thu, 30 Oct 2025 17:09:41 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696f6d6sm1785865ad.68.2025.10.30.17.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 17:09:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D67E64209E4A; Fri, 31 Oct 2025 07:09:38 +0700 (WIB)
Date: Fri, 31 Oct 2025 07:09:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Document a virtualization gap for GIF on AMD
 CPUs
Message-ID: <aQP-Qv1SOi0cy-nO@archie.me>
References: <20251030223757.2950309-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esF5ABbH8ZFy2Hrc"
Content-Disposition: inline
In-Reply-To: <20251030223757.2950309-1-yosry.ahmed@linux.dev>


--esF5ABbH8ZFy2Hrc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:37:57PM +0000, Yosry Ahmed wrote:
> -TBD
> +On AMD CPUs, when GIF is cleared, #DB exceptions or traps due to a break=
point
> +register match are ignored and discarded by the CPU. The CPU relies on t=
he VMM
> +to fully virtualize this behavior, even when vGIF is enabled for the gue=
st
> +(i.e. vGIF=3D0 does not cause the CPU to drop #DBs when the guest is run=
ning).
> +KVM does not virtualize this behavior as the complexity is unjustified g=
iven
> +the rarity of the use case. One way to handle this would be for KVM to
> +intercept the #DB, temporarily disable the breakpoint, single-step over =
the
> +instruction, then re-enable the breakpoint.

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--esF5ABbH8ZFy2Hrc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQP+OgAKCRD2uYlJVVFO
o1/xAQDRkpadriLgvvT/+503xXuvsaiKT53xVLXmZHvTe/ghwwEAvNOeC1nXPtHQ
lC6ze9NwfECTfuCk+ZlAYKbSvm0Svgo=
=2fXT
-----END PGP SIGNATURE-----

--esF5ABbH8ZFy2Hrc--

