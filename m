Return-Path: <linux-kernel+bounces-866517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F7BFFFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 619C73401A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B53019CE;
	Thu, 23 Oct 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJjFc9O5"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC042F3C26
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208998; cv=none; b=pRFGPtK2fSH0Hmixszr2kAKheBSMjfuZ3YHwhBtEuL2vMoIpGpOKoJQtB7XvyvCqMQ0BZQDLsqXDWaBnc1pLU79C4SBntHqr7lZ4e1BWZa0FMBPnyhcoi51H6ZMkXfYpV+j/ZbiE8XR+AMpOS+OGcM/zPNciHePEXk5rSB8dSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208998; c=relaxed/simple;
	bh=h277j0BdJAJJfrnn3LPaDfuaMi5C0Xtj1wAoSJszDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saHhopHsESQThpSGs5EBAtvisQogTfzkFjmD643Hvwm7Fdq4ESlW6iWHEMuVTYWF3Od2kJ7cbc2uPZdJ/7PUEm8FnLGJVuZGQ/xAAKRzjvLku5VM1KPUwr8ph9w6JuJNj6jtIXC36c4qz9kyfSDu6AkDWoMHAJ9iJHYGumqxPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJjFc9O5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5579235200so357571a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761208995; x=1761813795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqheznwEahoAcIc95fCF8gQr8sHNf2ct8iY0MfSeg6g=;
        b=AJjFc9O5UZLxwUqH5yBwCk4w0whgnAKEYXROjOGZwucwIMD8k04nBxjBxte0aZY8NL
         E1+oAJwO0iYWuzKZ45foqRGzebxOSm5+4M1koj0jxxDntetjG/en0wMr4Ufz5BczRs8t
         5e23RVZPdMjoDm/FW4u53FMltS0HHnImtwB21Hj2GE6B+sU7Ws85iTm7xNSFDRvW9tD/
         AeWa8yRnmsiyNM6ZKl26R59nDcWfllI9i5zYs1driEyPMLkc6SXVi3wuSbnfPI0FG95p
         CRHi9eY+JOWvlHLRgV73oDrvOHgRAPZqNHGigmFUYr5ib72OyLXpgi9NqyLPYDIuDsiV
         T8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208995; x=1761813795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqheznwEahoAcIc95fCF8gQr8sHNf2ct8iY0MfSeg6g=;
        b=G+cLxJwkfINZNZOwwT4scl51vkOwfc1lz5XLl5hljQcnjWmfQeOid3astPgkHykEMA
         iC7yVLku0IBU6fikAC8kxVbVGEQmnaim5zjw0DSFUDjx6Wqq7EByA8VxS/E8eL9uxHet
         DkHKxAD/GMXQGqohDjNO151R+9JzMg0sVkbE4HSz7+lMgQoHDSXN9XWQ11rDv9CznD16
         LK5EhgWqYOELZVzKSWm4Htxi+7L0bGyuDhqDSBElqLY1oxnXitRs4siDcbyN5gZRi8rM
         aNeaXQ5qgjMdM8aDNwyf1hmYqxOvqwRHT37nnfD43M4ETc3YJdotopMFEqEz/n1sXQB3
         2LOg==
X-Forwarded-Encrypted: i=1; AJvYcCWAFXYubjDjePJsA8lBuZyco8+p+bh8uAq3mNNuPEMPCk3ui34HPX05gLE3u9zSgS+5Ru3MQ4MO5+lFn6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+j4OaEgYgEvNweXAmxnz25MZtthNYjtEAE8zrT99O2XPA6HK
	sHc1WIXzJLpUzjZA4bI0RHFcUDE9IeEPHMb5aKrOL3QPMX/iX8FAQRtX
X-Gm-Gg: ASbGncsK5jNvxrjmtjLykINPf6D+yXb6/uv/xAlpfuo0p4uYw0FPk8L6rrY5ypsFXLM
	60IRNNY9e2sHErTj1BVosYvAiSGwJoRA2edTIhzS5l+Bc8G1WeHu9eWiNV937+wEm3WbwUyH81g
	V6q2sgDAzdl5ho1byiVKF9+kd4eA0ZEn/GXHMxcCJfifFepCRN469Jc4C6xQu0N6mGzDssDyYJo
	I3RS6LB8HXMYTy0nRkOKkB/PBI9HowoOTPTdBgUjzhLDDDJ6DLV6qKwZlOHoJZ5qGoG0lbzIdMd
	2oO0rdAM7efyu+/0g+3d7zMzsXjE2k/NTHKh/3+ZqRan2g6ASadNQUX1Ynos57Qb9jgIg5vtLzG
	IS3Qyx1yb7EksYayHSfgL+rxGs7aWRaCnDO/T5aMRnTlfxbCkbZDon68HdTbGe2a453bFoo8L7K
	rLlHxyFqvCsPI=
X-Google-Smtp-Source: AGHT+IHEOgGN5yNyJpbzAdkY2kAXHAbs03hm9RTq1jzAuwC08hoEOkO/K6ScXyZjbWhH2WaZz9e7+g==
X-Received: by 2002:a17:903:1c9:b0:278:9051:8ea9 with SMTP id d9443c01a7336-2946e117e69mr21542875ad.40.1761208994856;
        Thu, 23 Oct 2025 01:43:14 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e21fbbdsm15563255ad.99.2025.10.23.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:43:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 94D994206924; Thu, 23 Oct 2025 15:43:11 +0700 (WIB)
Date: Thu, 23 Oct 2025 15:43:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Avery Pennarun <apenwarr@worldvisions.ca>
Subject: Re: [PATCH net-next v2] Documentation: ARCnet: Update obsolete
 contact info
Message-ID: <aPnqn6jDiJkZiUfR@archie.me>
References: <20251023025506.23779-1-bagasdotme@gmail.com>
 <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sYkyoOFIpjBoikjz"
Content-Disposition: inline
In-Reply-To: <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>


--sYkyoOFIpjBoikjz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 09:21:43PM -0700, Randy Dunlap wrote:
> I'm wondering about one thing in arcnet-hardware.rst:
>   it refers to www.arcnet.com.
> Did you happen to try that web site?
> Looks like it is something about AIoT.

And it's membership application form, though. (I'm on the err side to not
enter my personal data there.)

> I found the ARCnet Trade Association at
>   www.arcnet.cc

That's ARCNET Resource Center.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--sYkyoOFIpjBoikjz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPnqmgAKCRD2uYlJVVFO
o1d3AQCRe0oF2MekWkvylVGpjC6ok/H13SiWxWu7yovWlHyVCAD/eYNUs9+dyZCa
NX/jHGU7SuQ8ikjpge0Y+EPxhi4V2Ac=
=jNqa
-----END PGP SIGNATURE-----

--sYkyoOFIpjBoikjz--

