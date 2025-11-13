Return-Path: <linux-kernel+bounces-899169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4195C56F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71A4E4E8679
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E49334C00;
	Thu, 13 Nov 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CxVTpbVX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58C334681
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030727; cv=none; b=YuS6jAKanXSO9RmbIg4bTT/QmZ21V6dtk9+luyVhlJibjIOjPdIk64IfsU/D6Lo6+4Wxg8F4dfjYbd+KztdyNOMat+KfzB60W/Z12QwpwAeaDaYU/p6/ROs038u19pLbq/A906RA1u/fWM3kxb/HIZWRGdRKXvAZU1SHXm3ffFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030727; c=relaxed/simple;
	bh=ncaOv8MzKaMpRo7yk3kmtFeKkc2V9ODYrJKEBcAlO8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4oE32FTKn0rZJQLUDDiWXsnBbSTwmmsTMT3bRYLZ5A0WDDMDmywVMxKkVELgY7wdZjZKrUecgK0h01rETipwkMMepEJe8OT3unXoIZ9BZIcdX1EjYnE/vojGw7G2EcdMJpoMYF+Y5IqDPLGUJV1h+hzAfK9BAksQtY8iQj/Vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CxVTpbVX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632cc932so2852325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763030723; x=1763635523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XupxkMVhJzCmHKi3TycOZh0SLqIfeWtCzXp2GzyeoR8=;
        b=CxVTpbVXZ8wKv6bdz5HndrHgHLMu3RsxudR3JiafeNf52GtwxG2NAuyzxM1H2uMiWc
         DlK2dl7iyiTpBD6zq4QUoTnVdMYYlb6xngG4XFeWgrDl95Y1Y5nOoYtP8bkvj/Xf2f1V
         jfQuWlbSKiExihybNCu5RgcUPPwPgtn/g3cTxNSMLGRMVkNs//xxdqsCu+KzeTS1NW5i
         bqnZZ15ZAEc8CO/ssEp8sHmDkLWFlwZhYbkTMguZ7TVYDBiHcCY8pNrER92IzcwOslsw
         xSVz4vCmyXV3jq6O6aOpPqNTrKgR1j3y8Q3efl5/trnWVyQ89f6RVqL4W5B/bjvoHCN8
         YPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030723; x=1763635523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XupxkMVhJzCmHKi3TycOZh0SLqIfeWtCzXp2GzyeoR8=;
        b=jKdNBEOS13oI6OPgZGuO12Dns8VaNyn+/RLzOIaL5QnIC0AUOurYVhWHNo0kXN2wwM
         ZH3ffivRgSxYO7DxnuYMVdI4TFB5moIu1iF8yYnBhhQsV4LwQZYw+KGKIrN0XFbTZJt7
         a2t/EK/Aii9wsRaJFB1lMBs7rahOTcSaPPzN+8iKzAF8rJSKDbFqEsC2gxPzJRcqTDb6
         sOPqzfTCYGOQX4bbcC7pq8ywCwCdnnUoeNA3wG+Jwp3mDVotZKcSoWFNynnEnRLmMPI0
         lsY28ZroDHJ1nG3HxV9Ybm/iTOCZLT4vNbS3Q5ElKAU1hppajCXWgOEf2FqRtNTekw1f
         dbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu9nW3dheenewkr35LwUD0AKgiFCK/15SDkQURRFyeijR1U5SDJ1MSfa+TEgCUZDLOKp3SAR++U5ic/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Si4Bz4DK/GPCSd7vDO2amfOfu3PRdV5mHwfr4WeX7PqFTtjP
	D0yAS/CLL/Dvzig3GOj7q3WdCsXDWu/Dpg/wJhfRzcYLxrPtt/pJUX7CjJoravXjqOtPepyGlLA
	QSCFk
X-Gm-Gg: ASbGncv94UYT7Jcf5Zq1Cw0bDRl8DbbRKpq9pjqd06yGiBTWhH/0RvUtE+iMjdbaCRL
	zuqjfWHLDEbbdPo7Ev3oJngN7my4c19mW/Pzi02/Fjl4ZtMwV/MGpUpg8gyGbfC7VJR5xsJ0Azq
	HxPSHeoQgqcrmWXONzODyE3ldl7io9iOm+9+OM2ygMiJsr4MRJQnbCqYePj9IpDVDtQjc3keESc
	0hgbRJ7Ok7S3SGwSE9nFVaJ2r/2BzDlmVhyRkdCu7UxhipEDtNQs2bCzDKFiLOBW8gEGEq2VAp2
	yzzeRV86olpBe2A2hoQOuKtwjja8iqa+6e+Ft33T0v3V60sKWaFkiBOG27FADXnIyfFGBU/s0w+
	QElUZbMr7wdHOShTuH5qE0iFDtAh4wGqn28skb1/KmR7zTsakkPV4tcaheBw6S1yhwjfntviOAa
	xfxofQ/lwXBdyHLNCTzTVY
X-Google-Smtp-Source: AGHT+IH5Ri8mJ/OLQa/2PlpPQAc2QP6Xlq29FlxULF7JNXRxiVvOKESy7Uus1gQMlIUWbYz2acAJkg==
X-Received: by 2002:a05:600c:3587:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-477870857f9mr50413565e9.16.1763030722534;
        Thu, 13 Nov 2025 02:45:22 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c897c3csm27893605e9.14.2025.11.13.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:22 -0800 (PST)
Date: Thu, 13 Nov 2025 11:45:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
Message-ID: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
References: <20251113095025.2811205-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3rqswcvswh4xq2b"
Content-Disposition: inline
In-Reply-To: <20251113095025.2811205-1-zhangguopeng@kylinos.cn>


--t3rqswcvswh4xq2b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
MIME-Version: 1.0

Hi.
Thanks for coming up with this.  I've brought up something similar just
yesterday [1].

On Thu, Nov 13, 2025 at 05:50:25PM +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
> Conform the layout, informational and status messages to TAP.  No

Could you please explain more why is the TAP layout beneficial?
(I understand selftest are for oneself, i.e. human readable only by default.)

Or is this part of some tree-wide effort?

I'm asking to better asses whether also the scripts listed in
Makefile:TEST_PROGS should be converted too.

Thanks,
Michal

[1] https://lore.kernel.org/all/rua6ubri67gh3b7atarbm5mggqgjyh6646mzkry2n2547jne4s@wvvpr3esi5es/

--t3rqswcvswh4xq2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRW2vRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhG2gD9EtnJzhyp5tB+MfoR06g6
QRHywZakcYP+V5BRS/MX/iQBAO7qgJH/sTH+CxzaT5tELVVVC6XAsVNg9ec1G/WR
zngJ
=Bid3
-----END PGP SIGNATURE-----

--t3rqswcvswh4xq2b--

