Return-Path: <linux-kernel+bounces-877705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F94C1ED1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C84E8679
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED84337BAD;
	Thu, 30 Oct 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDQfTdex"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F52F6569
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810053; cv=none; b=jbY06oeZuE886tzmVmb0rDx/5beuyWzKkZ92GfVMFTasGZLFY/AcP891gtJxG3WeBxeTErurTdnFyAVrKMFH7t6C9n26TakZ/wLbU8Z0saIya1e3aXZBfHz9b9tjO5R8SboLe5pxd4LKLgaxmfVjL4u3HCOZGiz3MJiYfz+kuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810053; c=relaxed/simple;
	bh=H1hjxQGjEC5L4T4UtQNNrJaSLGQSRQrdJRzQ9oj29ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9QBOuMLoxzBC5PnAJSPIhQBNhaeJbDNU7z2BLvvq5IMRCXkIJ7PnaiPTpOLSsx+rihTxkugEg51gT5zju5dpFIbYy1iCtku/UlG/SMV+R/nAsOyZEVcayqX3ApQyo/8fPbjF5AtmOuDwuA++/tA267PgFqSHMwvOtQvNKZC4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDQfTdex; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29292eca5dbso8886015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761810050; x=1762414850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1hjxQGjEC5L4T4UtQNNrJaSLGQSRQrdJRzQ9oj29ac=;
        b=DDQfTdex7r2tKhbvtJhdJQnl1VIYrxggBEO9A31p5H5dDCW8sMEVcFNI6M04Qnt2rj
         oGYweSn0EC8NNgEP+ip8ZKYbboivkpqdfWWGowk7tqnmGbBUP7zAoJ4jtIQFGEGGjzBU
         Vupgs3Jtkk1brsvOy6dF1bT1jquMLhUXUInk+LsTZsGouSuEdeYU5uwoD9F7SgCW6Qgx
         34AZbpZLSkw4+Ya0MS/iAwOfPTnrAETU2mjU+iLb90TkuzPnGk/eMXqycO0JWh/7xzvz
         4mvVkWw49Dh3r+ETaaLYWbdHVgrwoCAzqg5TV1U++AkLwzTsT5S8zvAkbiITH+gFdJH9
         Yj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810050; x=1762414850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1hjxQGjEC5L4T4UtQNNrJaSLGQSRQrdJRzQ9oj29ac=;
        b=kRQkO1i3kqssuCoFnWhLk7r32dLeimmf2bQx7T6V87hf9BKuL1kGfqkwW38QO6cI0+
         DeLekzB5o+MYN2tpn3r6ltoriFZkAJFej0DzuotpTseO8v2kJ8MpctPn7XcrU5+7Dl/Y
         5VXACp3onwB73AK97NHcVdk+L1V4Y/NImxcMhkOvRt25zZgMlUvrw+dorLkVmH3txZVc
         mAPmGSJW6YBrckBeHibUIkHU+Hzpo9yMvubNII5NpSpCN2fO7qI4PfZm+koiV0T9BKAD
         Tgqkl2/pJ/t8YF8G/ih5q45p56hITWF1617ilDoXblMnzvpAKOy0VfpiQvHlDijKQQFa
         sqrQ==
X-Gm-Message-State: AOJu0Yw4NmY8bK+W5ZUDXzwls6qxl0QG+RDC/9ZXnfrqwOkc2/ludjv+
	ktsxz/wNGQwbhZB3QoSzTA16Yo2ExOTgOxXgWzOFybGTqi3ou972lwt5vPvnj4x3K6k=
X-Gm-Gg: ASbGncvH0+PWZhiuSJbrYhvZ+r4GLicy16q9SnBITUv+mfL9oC9bA2GS9qlzUsHYhf9
	JDkMD6i09430gX+LzhyJr/W9aDo+D0nYm5DiP3Ot8TfLhsOpoCoZNEl7a9BHFRG/bIo+V63c/cJ
	Jxew3Nef2QFKJa0SAL/avtkdjg/T+G9ahvG2TIxEnaNrPpDvPMaTRi6wlG/ZEgQ23DDLiM5GmIK
	Ivr5qZKrCq0AKmA+gyNdGVgC/JBAgcMD+eeAK4wwjCzJl90UJuAo/cn7BWtIvJAV2V+Kxend5aa
	+TIeRzfXwRzXA4SPLYJOsUwsN+wAUB0C7le9QzjU8PRR3GcFiJn8mVmyfCK4YrttrCQGCpyqj9J
	ax/eaWkrej/GzZNG7w5VTYRnH9AR4AhkqGFvZ7t71yJybO2sGmWtgng0gQz/TRfdAf3e5qfxw2U
	poaNw6+Am+Uco=
X-Google-Smtp-Source: AGHT+IEhJrBVY2OU2QdJTvc4eWg0c6Su8jbKCtvPUTeYudGOdXSEj26zmCHIN6FgAx0W7VrJvvw/gw==
X-Received: by 2002:a17:902:f601:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-294ee479ab4mr28678895ad.58.1761810050370;
        Thu, 30 Oct 2025 00:40:50 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09a33sm174420525ad.32.2025.10.30.00.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:40:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 130774209E4B; Thu, 30 Oct 2025 14:40:41 +0700 (WIB)
Date: Thu, 30 Oct 2025 14:40:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: netconsole: Separate literal
 code blocks for full and short netcat command name versions
Message-ID: <aQMWeZyZoT2vV-Z3@archie.me>
References: <20251030072945.38686-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KqaALex6Sku4dIYk"
Content-Disposition: inline
In-Reply-To: <20251030072945.38686-1-bagasdotme@gmail.com>


--KqaALex6Sku4dIYk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 02:29:44PM +0700, Bagas Sanjaya wrote:
> Both full and short (abbreviated) command name versions of netcat
> example are combined in single literal code block due to 'or::'
> paragraph being indented one more space than the preceding paragraph
> (before the short version example).
>=20
> Unindent it to separate the versions.

Please ignore this patch (missing v2). I'll resend shortly.

--=20
pw-bot: changes-requested

--KqaALex6Sku4dIYk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQMWeQAKCRD2uYlJVVFO
o7SuAQC6Oq6KaPgD/blKnKE2tBWgL49wdzToS+7PXDDYHKZU1gD8DYRUeyiRXmJT
h5Qq9SRDuqwPzWA50zNlXOYlpQH/dg0=
=8ULH
-----END PGP SIGNATURE-----

--KqaALex6Sku4dIYk--

