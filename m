Return-Path: <linux-kernel+bounces-867265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A2C02092
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A74188BD88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35CB33345D;
	Thu, 23 Oct 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLV15zP3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E8332EC8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232474; cv=none; b=d6T1hvGjNoYWOFJC3XTV11rciuQNmeg2zIJprFsJW9pkf2RF00h4O25GU/dwHjYs48Mvf/s38jRt5YtYDbKWBCSsxoVBrEZ34afUiD8Kmb7Hx1embNDbYT9JG8s8/Yyzg2zEy/58d7pKWNSkf6SHOfMDfjBB1BgGt9uyHU0HcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232474; c=relaxed/simple;
	bh=IlUUH9LIumXJC7hPJml9W0fQIcePXt8C72UdTwhHdhs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDXHmUu1vBNJcziYA/dl+/vm7eKArwZxp/6fYhr6DqHWYC2MVoMFKMokB76Z0gFlOEgm/otPZi0zCOy+YNp9ZTfsZtCxBjFDt8+C5NYeJYfYBeYaYPuqCZcBizWLi/VQzxhZuVJPrEcS79i03hJULsLG/tOGd26UzmeODGBAqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLV15zP3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so1095291a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761232471; x=1761837271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vkqLO4+M3z7w/Lrmi0Fd0kvLJlcc3V6C2w66dX/d/Xw=;
        b=FLV15zP3k8p+Ylipj9P2be1to839gkkbWuBHc7AF2ZzUTT50qplv2DhIA+5wNbhJvK
         QHlJ9Stru6EsBNm/IzR1XoKQY0u7r8ZE8ZOK6bdUKVdzcXo8VgGBEBLJJQtS1NndDmRG
         v1yDw0ZANnv+ja0EjnDRP7rWkKRcdIYcRVvfaqNVIzoBcwV7YEqLmmx6KQp5aeEXx4yG
         tIZT8nAWLcc0efFTWi7ghKFWdJAWXvzEgGu/30TK2PSYS/AccxOlfYWSZuDcCgTbbexO
         New1KMrI09iux4rf9VIvmy/2lrEOfHR/Hy4aXCeO2Eo+Mut45Uk3atXEHvOnrcee2nGs
         tmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232471; x=1761837271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkqLO4+M3z7w/Lrmi0Fd0kvLJlcc3V6C2w66dX/d/Xw=;
        b=I2oeR6u0kwyLfFATs3raWG7kYkgPSJWgo0t1WbWalRJ+GMOHZB+ERx+LFtWiO4n5Li
         /JldKODjgtpsfU72TffNU3LXFrNxtFOXZcuiFJELCCma3sTXL30C2YxrWFI/K9j5DhjP
         vsuvQrpLj4kAfSHK6nFUdEGytONd9u7V3Q5yBMMi3O7J3Sn+9UbELnRoA29d5YdTVmlI
         2yG4RkZX0vJWCMa8+X/DRG2tPqKwCNGAUTSq/PbAnNkoR76xMBkt8LdTa0JQg8JyNFZ4
         y3VqKKBcc7Fy/yQQ3xr9IN1TXYgn+9WpWkxtoKlrSJ4lYY3ajapmVcyqjYsSh3+GABJ3
         0OSw==
X-Forwarded-Encrypted: i=1; AJvYcCUjCKtQOF9v2fJ5ro8+ztED1+/kp2IQEvmsR6WOXlmSNbmdI/WpwUfiiyhAdbt5qciEp+vgapcf71MTO90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTpMrtRz6uZ/0DawrnP+UiStdNWPMo0RP88VTOdVyfBAViyuN
	qLy+VlCwItt+TFfXTSYAKJTZfbQFlFM8HRy+OYq1cqV3OBs2tya0iz90
X-Gm-Gg: ASbGncsrSOvPNxGewAMyfZ4InLT4iazeAzpzC7TUza1ZwDXXi5aE+XqSdEWoHlXeiHs
	meA0yudCUF6mvE7XbjxcrFNK4KUvHP/ImifDOWiW+kJdiU2Jiboo0kkjjLSM8EEPklRcPnqFzF9
	oLK/dh8jtCMixW4LDPcYmJsfGUK3s98QhYrfoExrDGnQUmmVidkveYwxkqifsW81BziiAOtqkNE
	/tteU7jwS8BPVEMUaMlNZ9/8UzOBZSDQ072m5EVewXvTcbjLe6od+tZMK5NsbAZAKjA3Pm9lkan
	fscGg4YvJ7/D2KFlLTlAPPgmoKY61DQWTNLm9e5Ms3UWxN6rLHoz5R4vDbHGox2jbfZY1HvusJy
	3vZoT2zMLez2aRYLjBn2i/s9bEo10tTqb1ifX282CsTncJ5F9cGvBSs8r+mpp7pnU3oDGK8Brdd
	C7oEMwNqJF+7a910KexOtge59yLm7aU4SzRDUZ72wb+smTPD6g7m2XlILR
X-Google-Smtp-Source: AGHT+IFxcOTWNeoO0U9x1abyfX1fIUDpLCIWWsm5Uw/xj/ptlbhHm2XiUrn0s7mXgS6AUwx9tm10+Q==
X-Received: by 2002:a17:90b:5623:b0:33b:d371:1131 with SMTP id 98e67ed59e1d1-33bd3711391mr30176242a91.34.1761232471346;
        Thu, 23 Oct 2025 08:14:31 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:3367:7bc9:63ec:e54:c1d0? ([2401:4900:88f6:3367:7bc9:63ec:e54:c1d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb00500b8sm2704496a91.6.2025.10.23.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:14:30 -0700 (PDT)
Message-ID: <a56a858531e86a456c3a6c213c9f562add517d83.camel@gmail.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
From: ally heev <allyheev@gmail.com>
To: Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Thu, 23 Oct 2025 20:44:23 +0530
In-Reply-To: <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
References: 
	<20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
	 <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 10:06 -0700, Joe Perches wrote:
> On Tue, 2025-10-21 at 17:00 +0530, Ally Heev wrote:
> > uninitialized pointers with __free attribute can cause undefined
> > behaviour as the memory allocated to the pointer is freed
> > automatically when the pointer goes out of scope.
> > add check in checkpatch to detect such issues
>=20
> Seems sensible.  Couple minor points below:
>=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7721,6 +7721,12 @@ sub process {
> >  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$her=
e\n$stat\n");
> >  			}
> >  		}
> > +
> > +# check for uninitialized pointers with __free attribute
> > +		if ($line =3D~ /\s*$Type\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*;/=
) {
>=20
> The leading \s* isn't useful, but \b should be used.

Sure

>=20
> Perhaps verify that $Type is a pointer as well
>=20
> 		if ($line =3D~ /\b($Type)\s*($Ident)\s*__free\s*\(\s*$Ident\s*\)\s*;/ &=
&
> 		    $1 =3D~ /\*\s*$/) {
>=20
> to avoid things like:
>=20
> drivers/net/ethernet/microsoft/mana/gdma_main.c:	cpumask_var_t cpus __fre=
e(free_cpumask_var);
>=20
>=20
> > +			WARN("UNINITIALIZED_PTR_WITH_FREE",
> > +			      "pointer '$1' with __free attribute should be initialized\n" =
. $herecurr);
>=20
> 			pointer '$2' etc
>=20

Nice find. Thanks!=20

> And this would not find uses like the below where another definition
> is done before a definition with __free on the same line:
>=20
> crypto/testmgr.c:       u8 *ptr, *key __free(kfree);

I will add the check for each pointer defined on the same line

