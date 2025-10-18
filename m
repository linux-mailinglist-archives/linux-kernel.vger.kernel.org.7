Return-Path: <linux-kernel+bounces-859034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF218BEC856
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F96E0AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7E258ECA;
	Sat, 18 Oct 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmaLjMen"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65FA23E355
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760766548; cv=none; b=s7zlvgsOv/b4WcQQeck0jdGF+gGQ/227h5Pd9H9DmFxvZHMV5+OoJU/PRAwgWsFLfnOviwwZQgYy/t4fBb7TVEw/EvqTPXl0q61UbifB7dGW8efXNK0HADaVMQYgQ1FUsbgAV8mmd9el3mZKszKKQo9Yh/i0uXa/DPDxLxaG0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760766548; c=relaxed/simple;
	bh=1Vv6tHhTnCUCOqqa0sQAoxcLS2MLC5PRxzjfcelt2PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqf1T+eRfawn7+5R19X8IRXyy7yut+8/VgEQ42OIdqyy/lDZ2kwPmGl0RWu9IAJSqPpWl8tywNuaa4dN4SDyECC6lhclvhVmjIFq3KLoD+hWyXtcfBTIh1GK8o+DR6/rX+7jzI/gB5wWVVMcSwDIDVGyBp9pJBFckxEvXnXRvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmaLjMen; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b633b54d05dso1852781a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760766546; x=1761371346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vv6tHhTnCUCOqqa0sQAoxcLS2MLC5PRxzjfcelt2PM=;
        b=VmaLjMenvYjtMGE+sxS5Hf7p7iAAvSGw7cJzqDVL/p2IPJeZKtvUzF0KcoChzVwo6R
         z5BLBWO4ZbUqmguiAGHe2qfyvrmgftjApF3+ecl2YpYcdA9sIOfgjLZwYOlwkaMAq2aI
         0rQdYzGtD9vSwinVOCE9Iu/gd8lOnzPq+VtqD3Nvk32lPP99GSJbhUtHJGHXqk7OrnzR
         xrsmRg3scZByh/oy8W+VTtoHX5kDfuO3TA/WmuFbe4aDxenR8VMsqPqYMNFvAOVjtZJY
         ec664tUkf1l7pfMM0FClgLxEW9AMdamjGiV70ACBtpW1TI9QsfZeWf27CcxDi2kJXjx9
         rU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760766546; x=1761371346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Vv6tHhTnCUCOqqa0sQAoxcLS2MLC5PRxzjfcelt2PM=;
        b=tSalBRk6sVCmhJ3S7SaV15mq3WItjkxh0bpBBMSpVaXidqUBgRKtM2x4oyC5/HEwtb
         2m1Z+rMA/NzFkmSYJhsihE4IwCqZAcBybzibMXYdPRNtDNnrAp5NOWcXsBXsvjIasNWe
         tZHTc2vU+XWh7//MLqNyjLVolq6MBBaTdZjGwili3r1eMBtZrmIxLnjqi16uR4f/D5Uq
         Qvhf8pX9yT7huDEHqD4UDM4z98NkVl5ISJLsLJ3d8a78j/U58NBEJEe0SG8ER48zs4IS
         uVBsKzn3gjpXCHZ+cF/a8jlVpxwINT3mLz+UskoUNugzKuq8ifIs7lJ4Nb9ArYMClein
         jKkg==
X-Forwarded-Encrypted: i=1; AJvYcCUr8bl6kKW+lw6jYQEgmQC1cefs1qzaT7cZjw4Zv5ZKVkAXjfxszLjbhrM7ClRxiaVaX8q2urRkrRQ3IQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmocCihMFsez8onn9WRHZtIpMKaQtWE7/ReXH4+jO2qBGO1DF
	BGkPh6X6KxIVI52D969oaQ/THzhT+gP9ZZJBAagXh/Mfc03sULcCEWbL
X-Gm-Gg: ASbGncvufeGSJkstn+4HfDOTE+6Z5iqN6LpVXkg1/rnQ/3jAYaHCWTtm6ARpxXcglVu
	Ts1pF5UGW8qj68BzqMPXPZsoXBb2jAC8IB4db+iX/mKYMVABnMqIBsmBIKoiNKvy8iHO7rX5oTq
	RUDxWDns6wfOTyLvIzXsV5ujrS4O8vvSDLF7IMFY2YOuvObHTpsjpx5U2YL6JU7n4g7yiUeUuKU
	JtRRGayRagI54zVj1M/3gKgu4Jafy4/iTN056KE4tbanBE1vZ3aHApFGvKEyxbse9Os9IbFnBof
	PtPGqP0FnyH85fVW2IeJroFb1hJwwoo31ScbZs45ulo97zjwxp4y6OUNzZuv/KAZTb9CQVdU8MF
	bcJExaU8KpLxJrLJ8T7IScUdLPwpG1o7iZM+vnRR86w83sCLL672cHooxbo+9xJytoSPcD9gbXf
	Go8rE=
X-Google-Smtp-Source: AGHT+IEiDLeHEpWWG0W0/Txk7ybCtD0aFk0wRSHlk2Qyr7r4KJqzeEy+3Um8q3Il5qclHZ1JNtVeYQ==
X-Received: by 2002:a17:903:3bce:b0:269:aba0:f0a7 with SMTP id d9443c01a7336-290c9c8977amr74813915ad.2.1760766545842;
        Fri, 17 Oct 2025 22:49:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd8fbcsm14454955ad.41.2025.10.17.22.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:49:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0C5AA40995BC; Sat, 18 Oct 2025 12:49:01 +0700 (WIB)
Date: Sat, 18 Oct 2025 12:49:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gopi Krishna Menon <krishnagopi487@gmail.com>
Subject: Re: [PATCH] Documentation/rtla: rename common_xxx.rst files to
 common_xxx.txt
Message-ID: <aPMqTSbPucoqNhA1@archie.me>
References: <20251013092719.30780-2-bagasdotme@gmail.com>
 <87zf9pz33e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AA1YS2D2c75ozhj7"
Content-Disposition: inline
In-Reply-To: <87zf9pz33e.fsf@trenco.lwn.net>


--AA1YS2D2c75ozhj7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 02:27:01PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > From: Gopi Krishna Menon <krishnagopi487@gmail.com>
> >
> > Sphinx reports htmldocs errors:
> >
> > Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substi=
tution referenced: "threshold".
> > Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substi=
tution referenced: "tool".
> > Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substi=
tution referenced: "thresharg".
> > Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substi=
tution referenced: "tracer".
> > Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substi=
tution referenced: "tracer".
> > Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substi=
tution referenced: "actionsperf".
> > Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined subst=
itution referenced: "tool".
> >
> > common_*.rst files are snippets that are intended to be included by rtla
> > docs (rtla*.rst). common_options.rst in particular contains
> > substitutions which depend on other common_* includes, so building it
> > independently as reST source results in above errors.
> >
> > Rename all common_*.rst files to common_*.txt to prevent Sphinx from
> > building these snippets as standalone reST source and update all include
> > references accordingly.
>=20
> Applied, thanks.

Shouldn't this more appropriate as a fix for current cycle (6.18)? I see
the warnings on Linus's tree, though.

--=20
An old man doll... just what I always wanted! - Clara

--AA1YS2D2c75ozhj7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPMqSQAKCRD2uYlJVVFO
o4puAP9fICYO7e25rwE88sCE9s3B9E8bGfkqdqV8T+iWzpplOgEAxE7vJYfQ8DHo
G3ggxu0+rFveZJhSJqd1VejNrPNTQAo=
=rk8l
-----END PGP SIGNATURE-----

--AA1YS2D2c75ozhj7--

