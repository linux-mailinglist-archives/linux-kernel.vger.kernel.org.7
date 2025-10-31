Return-Path: <linux-kernel+bounces-879335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E4C22DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7BB4EBD95
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869723BD1B;
	Fri, 31 Oct 2025 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1fk9hXQ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B672618
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873872; cv=none; b=K8Bfc6biQmPo684Luf6FXRUvAopsYFfoFg2oBWoHb9DkJc2sCNZrU8PNRE9yYfnadpNcaGJQG725Gtq0qRpocI4o6l3PQnsc2siDN59zHcr+X3hkVxe9EMbNQ9hpIT+EpIyyM7awsx4UYAqN2kvOoc8g04ZRYIbQ9YEgPMNanaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873872; c=relaxed/simple;
	bh=KcSBl+fombjs6jhb+boYVCpSv0fgyDJ8iOMAQkc0Fa8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAuQpvHVbJZjXWhtE1J+llE0vFcXMdG01F0xPfJrjezF0XBevXcqa2QNJkzIa6Qk5hsyHVuUM2t3C1dIES1B12sLN9mREZtkCx9yIbO8wdmrgDniokrci1f1tL+t/YmWTLGMb1KiUdDvcJWSFlimWxMrGAUV3gUASKmRzR0Jm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1fk9hXQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so2264273b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873870; x=1762478670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcSBl+fombjs6jhb+boYVCpSv0fgyDJ8iOMAQkc0Fa8=;
        b=J1fk9hXQMMPbl+P5vIrtlKv6x4mBGOX8ek9OXAs1sXoGCiaHEr2h+j9EvA5SYL1DO1
         Vg7ZTvj/9NZ2cOd341CFqpHUwr84dEfApghRa2AydFNH0fsdzY9iKJsah/kB/gCKTOoE
         sCG/7qBf4xmhnFsNJSIXKZwrebdU1B7ElvIz5NGNBYoKIItvGpUSbWHEDWQE5x//vyKe
         OYjV7drdMJDPyN1lbwoCs7HonfwR/OuUDCBDojh0bgC8Jow4oNyUC3qMio5TSmuCv4y+
         1l03TFkTC/eeT1QdyoqqL552wvmCssfL17xOjF8jSLb/9c9kCARtXQr1piZ1foySCy7M
         Lurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873870; x=1762478670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcSBl+fombjs6jhb+boYVCpSv0fgyDJ8iOMAQkc0Fa8=;
        b=TEKEHT4OPBa6S/j7C8fDBQycLzT7lJtn8SPacaCC2OxWUdYvTfhPKnJHLH4XIdu5cb
         R848xFWYT/4cX1ir2lQyrwhCxfiQuCWptiHHCJofx/02wW+BMPoPXeUAKHPvzBi5mLEj
         c3+JxBXAQfFQXp4K1AwCAHqzcrzzqSVJ89Uz0t6oB0/dd78QC3LPVP69vSAMz+/4LQvk
         l4CJwVIFSrCczmlQigKDbpDTp6wsxn5CV0Hwrfd5j2VqrjhEb8Ht4niHaVdMn0PKvKpg
         lkE5RfHBLq+lEQccBcaD1gN9YMDo+vuBmgYwkzos74hBjxiEhq2qVdSRiLqKcIhRpLqw
         uaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhVpWtNkuMxHjh/sV/whClQfPWYUc/TjDwiksRXXRRkp3S+01ldOnsvoAfw/xqAWvfBYegyeFhJEbtfGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BZ+/dsu7Jxv3IjUljKjOoZ/Wu0WjBh+b8IPtH0EGKniJjnto
	OanORHVqWlB7SBSjdmuP9ycoDJuZV6+/Ov9B41j0mfWyLfYVcJJYGReY
X-Gm-Gg: ASbGncsrTkP9/LNZ2xrJZSWRC1lk9qy/7ESbv3KtJTDZHodi0N7zDcFCIvKF5fgLGZG
	hHZjXUeX7RqvJ/yp9qRnUn481AnlPhpydcKGeMkdzUdrDFOGmEa+ZpLGgPhEvqdRUZVeLBm1gn3
	cCI0n+YxCZPzwBv5EokvJRszxskolqjyyRYNKdYG9kdfOnGEhctqR/VTU6ufx5K678CmXtSMzQn
	3Vhd7b2CfVRCa/18/cVvrcRX8k5OFpFg49mMXldfuQO6wfAMru71n0T/iY8IxBp58sm+Ei8XlLH
	5JV/CfAChiZpkAq3Wv4pQcKrW906i4PgFyTmv7RTskjkYab4ZQ4LWFV5jVZHSsW0XHbNM+d2uHh
	M/kMTpI4c5PElbcd1raUaJ4j80gWcRmG5IcJOyoPNqRT1/gAazRPAo1de4qm6C3W/Osg7iCHBmu
	R3umxQdL+LkW8=
X-Google-Smtp-Source: AGHT+IFmcP0ESU85vjNBrC9Xk91hvqDQ9l7Vj8fu5fIwvpUmwTv0sGAr8xsWOWJ1HNzSt9GGNxsHwg==
X-Received: by 2002:a05:6a21:3283:b0:340:4bb7:8d02 with SMTP id adf61e73a8af0-348cd211f18mr2293295637.60.1761873869735;
        Thu, 30 Oct 2025 18:24:29 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa3ff1sm223032a12.14.2025.10.30.18.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:24:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6D1FE4209E4A; Fri, 31 Oct 2025 08:24:25 +0700 (WIB)
Date: Fri, 31 Oct 2025 08:24:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Atish Patra <atish.patra@linux.dev>,
	Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	conor@kernel.org, luxu.kernel@bytedance.com, cleger@rivosinc.com,
	ajones@ventanamicro.com, apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	songshuaishuai@tinylab.org, bjorn@rivosinc.com,
	charlie@rivosinc.com, masahiroy@kernel.org,
	valentina.fernandezalanis@microchip.com, jassisinghbrar@gmail.com,
	conor.dooley@microchip.com
Subject: Re: [PATCH 3/3] riscv: crash: use NMI to stop the CPU
Message-ID: <aQQPyan9ifX84e4h@archie.me>
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
 <20251027133431.15321-4-cuiyunhui@bytedance.com>
 <e9c2021a-fa7f-4b01-9b48-afe5fa73135f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4Iyd7nhM5+T6dxQ"
Content-Disposition: inline
In-Reply-To: <e9c2021a-fa7f-4b01-9b48-afe5fa73135f@linux.dev>


--l4Iyd7nhM5+T6dxQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 01:46:40AM -0700, Atish Patra wrote:
> 1. Invoking SSE on this path may lead to some race conditions if
> interruption is enabled.

What race condition?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--l4Iyd7nhM5+T6dxQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQQPyQAKCRD2uYlJVVFO
oxE6AP9I4NFyMCoGzkBrmBIf+863ij8NRBMe873QzL81xOT7KgD9G1rHfUK7x3LI
SqjtNdTIOSPzqUUofHFp4CAjKdmkkQw=
=ejAp
-----END PGP SIGNATURE-----

--l4Iyd7nhM5+T6dxQ--

