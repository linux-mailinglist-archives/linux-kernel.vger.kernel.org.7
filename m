Return-Path: <linux-kernel+bounces-820356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0AEB7C7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4191C038F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837793074BA;
	Wed, 17 Sep 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QDiIpYB4"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50225CC79
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101862; cv=none; b=V+6X078eOZwQj5zw12JHz+ZSaCRSyUoBp5pideCKtRNwoRwQhQfJoLSMGNpvgKI26wCtqIkZC2vjEvpqFa/Lcu/cv/3y3O0aOQhPgKVEfwhyEIESf8oYLAYEBzMZ3e18aGUnt/oZ/9n3F+CdX2gWTYO7jC+m8bVpEf4fjASxVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101862; c=relaxed/simple;
	bh=ei/vIH5Ms0usPE/o6u/ZpOOD2j0+lVfsYzp5rrs+xFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpFm2m9Ttu3NsBJht1jTk7cw4QPBFfmPn/W2GuwhhB9fX0m/3+YTawwFnLqwdZWcKPYBNcR9dEsfsM5hGqeDO902CQy/h3YB4uO55Yo1xnGPstca49Ua5o2uZ8tWxSXpPpF+MZHSUZwVCb77KbELqgnkeNxIruOl/ruQyaapqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QDiIpYB4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de56a042dso43831175e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758101859; x=1758706659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei/vIH5Ms0usPE/o6u/ZpOOD2j0+lVfsYzp5rrs+xFA=;
        b=QDiIpYB4TXSJLvGPvt97TR7MIl3qG11STLe+nYK5K6GZS59GxTjNlfJ67tccmmwcxK
         L8Ikz14uXjpQ+JxVo7we4jc3LKhfMaSM0I3mabGL/IWomhuSzMJS60ptm7V+OhNyzyqe
         qOt0ovstLVu6b1BqTziinqMGANdALRgH6MQpQSDfLTa2Yv5Fm5NiKHZS/DaJ0mwxY0Wo
         80joIjUQh3LuTz0hEHESpz7e4sU7CG4lwT0Ctw99Elxg7pItcUNx66b1/Bbchz08fLUP
         Rk1G8kc+S8ZkMWbxnIPTGe79UlPfI7CbuyKZsLoSF4lqpX4XtPPX799LZU2uXbsFyTF0
         Z3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101859; x=1758706659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei/vIH5Ms0usPE/o6u/ZpOOD2j0+lVfsYzp5rrs+xFA=;
        b=TzkwKIWrWoGmVCaTfW8q7sXgjyvtCXG4H1T4VKALAeHKv1R40Ss3nhAnZnm1W7mdcV
         FemTYVMYP1/Kjqcvs1izTEmymKSQj3fQh/8O77IhwG0fRHPcNI0Wb42zWzdMFJlHL+BS
         /FENx/tYlnlihvGQq7qr98cZoX8N9QUorYdaVvtlw9+2Ot/tcOakeVspGlPdDqxvsc8h
         qvvbHhpAa2vqdELK2iomjoBhB1PEXjY51sg7BizrSaDIvL6+7EUU/Sc9HRZ7A1Ogzypy
         UV/vPWU8vLlzNVXWmf9fMKlgpPApu3z7gNAeScoAERb5hrsnvhvyLf2P9OHExQTs5pXV
         qkvg==
X-Forwarded-Encrypted: i=1; AJvYcCXwvseuO4PoTlnESM57pF7sGtBJWZ5nomYRNDC9eQQxE6THOvEUq1t+7ecLseEt3dMhwtgkxPR6kuqbJHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zA+ozUFY3Ugt4D4NUHiF2ryuR8lgWXGkvSDlpSZuq5aeVlXw
	QFtj64CFnh4cF9xYX36jM+YiU4y2dsgIyXf8H4klyQp+VJYZeNXOA2qeESmogaGXvL4=
X-Gm-Gg: ASbGncuEP8uGTwC3+tAus7JasIjhytDvxv1RI+OXtfUE7/OQozlOIz0ObwNy6Rmsr+8
	IXAs1G8exN14So+kCJycGb1NxOtXCcZRbbj1rr/6yh6umJwlmBp1G9MiW99UWfYlydSjv+tZCso
	esEmC0/n/OLy0Lm1Rlu5u/KFFjq97uUekO/CkCpCu73ZqeWOkIod/AhG/HEG8c3Ks26aorUH+TV
	YijxmivvqjoOTw4dGXzYB1ZfdRZQBAobNAhvAMVVtVFa/zY286YNgM9f9b2LmNuaoT0HTciYz6i
	1neL0iXPzfdVhwmAjA/TNeG/fOTU1nxg4MIqpqP3NLojAennC2v0lE2D9uo+xb4SlQYBA+6XJ88
	liCvn8rQcdEyV+k9m8cxnu8a49PUEdF8xdcxhZYB5IxY=
X-Google-Smtp-Source: AGHT+IGJ0PqlKEQobxbgKxlTyDtIFiAznp1VKb6squimDj9lYj7QHzyDnTgU/3c3CJg8TAI/JxRn9g==
X-Received: by 2002:a05:600c:3147:b0:45b:9c93:d237 with SMTP id 5b1f17b1804b1-46202a0e89cmr13975885e9.14.1758101859074;
        Wed, 17 Sep 2025 02:37:39 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461eefee9f3sm19795285e9.1.2025.09.17.02.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:37:38 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:37:37 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <d7oxdqxfos3jiuoxckvth2hinhqks65exroxu2lipyopeuiz5c@v7jwxoltx7hf>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
 <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
 <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlokttwbe4q7s5rn"
Content-Disposition: inline
In-Reply-To: <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>


--vlokttwbe4q7s5rn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
MIME-Version: 1.0

On Tue, Sep 16, 2025 at 12:57:04PM -0400, Aaron Tomlin <atomlin@atomlin.com> wrote:
> I see. If I understand correctly, in this context, are you suggesting to
> modify the identified task's scheduling class (e.g. to SCHED_NORMAL) so the
> CPU controller can be enabled?

So I'd primarily suggest you to disable CONFIG_RT_GROUP_SCHED. It seems
you ran into a situation where you have kernel with
CONFIG_RT_GROUP_SCHED but userspace that'd like to use cgroup v2 and
these two are known not get well along. (Alternatively, you may switch
userspace to v1 if you really really need RT groups.)

Michal

--vlokttwbe4q7s5rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMqBXhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhEDwD/ShruzfmD+raOpYwR0e/r
Dy67vs1HoQ29F9MPEYO6Y/YBAIdK+klTbi9o4hWpJZFAiTmj2GrPgm8x4aoiQxHd
tocN
=DG0o
-----END PGP SIGNATURE-----

--vlokttwbe4q7s5rn--

