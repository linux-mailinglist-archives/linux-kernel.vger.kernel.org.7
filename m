Return-Path: <linux-kernel+bounces-819166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9508B59C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA9E173995
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65835FC05;
	Tue, 16 Sep 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TfjiF0Su"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2735E4CF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037460; cv=none; b=P6PYdzKoM4XcYicz3WddL7E2s+anR96xymhNtg5oURQDf15vHE8e5LxEsazVGeFRa5Lpb2yCTBxde98qUE1WsP2PSaZWs3PXsq1SuM9g/J98HK2GP1cBMghIvdFa6UoD40T1hMsxVDrrr/8GiY++itgyIApwhnix87Cr5xY1x8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037460; c=relaxed/simple;
	bh=4DMhthRfPrSpZQ7f509fZGJvSNqzyqNWpBJrQTR18+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQN5SuVoU2sR1dn1h2LL+oGGCEXXZKgehce/JpkYCrcTDv1qWQCwwTHHoCB1GYB1cuLOGfoCBwWQ6jn6OkJfXUNIeykzYmul7F4aqW7XOpeZ09GozvYMCqzYhXQskxUx8oVH/J4XxD7LKga6jyddWqMQ39YH0C14CRtErvHBwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TfjiF0Su; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e8ea11a325so3862365f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758037457; x=1758642257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht9itmudrJBcMJqhBs/AGltvQ0ltCkWotP+lHvXRSjo=;
        b=TfjiF0SuCLevuqkQmsIrzHDrO+AMNrW6j91Et/lXFVhgcJ5YdwFUtsRpVHZ9EW5n4/
         fSlVgDrIzP/G5c/YIC5T8eLyRpmYZ5cAICX11r8lFPVMh4LPcjO6a2quF2Gwuh5f2Tx0
         RWLBvaL/5AMXQQRT0d0oYb3HkNFIoYxqVHVySX56WK1ezMWu091jjjNtcC5CDOiaN+Af
         jX8I8v2RiE3iPLk2+8j02v5nHKj49U7W3YMwugsBeomAhm/gZ7qLHaAZ+WADEmK1NvU1
         owVMPDRyJh7RfJSxIlt6Imrzpf/X3Dc2vS4x2nv5qTg9CNgl27VPU3cZZ9zpSm33EAaa
         fpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037457; x=1758642257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht9itmudrJBcMJqhBs/AGltvQ0ltCkWotP+lHvXRSjo=;
        b=Hycxe6lv+G97OqQXrlrGifLZ6PnkafwKI4laV3p9v8cqoPzCG6rUIzpmf6iEiVS5mL
         p7z24Es47SMNRE6X94F7xY4JMSiPKFr5MrdVXhfUy03rDSBVmR6ZjjjoAr6AC8tQVRj+
         Ff9dcI7QvU23cEAJVl8V58+BlRL+/mycJ9eKP9MgSyatTu6cK+8a+9q1aJAgFvqBAA+Y
         2GyM6fv3h3M9MEdsQwxm1R4j86WYXrrfVMKx9ZOdHJdhLPWi2LER4XDHlMYEb0ymTnCO
         PF8ZZJ3CihAxfeLHlWI6zVo0V93bAqcD+e7Z+7VaIbSdrq3EJ/z1nYRG1lecbQNf502i
         8D7g==
X-Forwarded-Encrypted: i=1; AJvYcCWEez/6JATYQ4ysVFeqBb6EZ8Wr7lm5qPsmKs6d0HE0t33SGrrPVdhRvGX8QFSCS7TvIpx2Rm+OIYOW9a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnnSuyhTa0N1+3nLmfix/LW5tceK26nuql/mduIBvdhoCl6A9Y
	Idbyszu6/aaBTGFIQ/8SreYIoJ8AohqcEXm3YAqYY5M7dnyf51x6JgS3K3PvCOmQ5gk=
X-Gm-Gg: ASbGnct6VpgFMUDPf3voDvw6A2QUhRpIOnK/sa7uNCdjTf2VXeHlSCumr8OXL8SBHkl
	7YCVbSoXNno0OVZP/xreqTZON3QwRzw4Tzs+VurrwqEQH6yrGVP2KYOhBMLmhBvs1+lZxfW0bvU
	Jf3B3MSNLCeF3w2lyamIG3EyTQyElIudjHfmdQ8gVLasOUqz7rknjq6TupIuPqHVHYX9P9TyEdQ
	u9pGk0k6X0D52ZkZ6qNCmk1EnApyx5deBlCws2A88YjC4oQ0f+kfpy2UA/OVfb/Y5SxqDkHa3wC
	piCQnHR2EoeO0jp4GAs6vIEf8b0iK51QSnzjIlsBOiovOV54h3j54Yo4ggsO2UWBuKFu1zvPVNH
	oPLETJNSC45eUQaxh8vepl7jCzr8TVa7oDQhWDQsNb3dA
X-Google-Smtp-Source: AGHT+IGRW+NuPlYvkyjKXMinJ6uT+A7/q5AhqQfKbWY6ca3TBXtEZrJ7WQpMg154EvSM/xOsUDUdWg==
X-Received: by 2002:a5d:45d0:0:b0:3e7:ff70:1b41 with SMTP id ffacd0b85a97d-3e7ff701bebmr8988119f8f.25.1758037456749;
        Tue, 16 Sep 2025 08:44:16 -0700 (PDT)
Received: from blackbook2 (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32136cdasm20598405e9.4.2025.09.16.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:44:16 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:44:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvew4mk2lgwdy54p"
Content-Disposition: inline
In-Reply-To: <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>


--wvew4mk2lgwdy54p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
MIME-Version: 1.0

On Tue, Sep 16, 2025 at 10:47:56AM -0400, Aaron Tomlin <atomlin@atomlin.com=
> wrote:
> I would prefer not to take any action. However, is there a strong
> preference to demote the rt task so the CPU controller can be enabled in
> this context?

Maybe more context clarifies. The preference is not to end up in this
corner.

> > What setup do you envision for this message? (CONFIG_RT_GROUP_SCHED and
> > cgroup v2?)
>=20
> Yes. At this point, RT_GROUP_SCHED would be enabled at runtime.

I wonder does this combination come from a distro or is it your custom
setup?

I assume the latter (but I'm curious if there's such a distro), in that
case you likely want to have the cpu controller on v1 hierarchy. v1
usage is what the boottime switch is currently useful for, v2 de facto
doesn't support RT group scheduling as of today [1], v2 systems should
simply unset CONFIG_RT_GROUP_SCHED to avoid issues enabling cpu
controller.

HTH,
Michal

[1] This [2] didn't make it into tree thus I'd be reserved with the
    message printed in your patch too.
[2] https://lore.kernel.org/all/20250310170442.504716-11-mkoutny@suse.com/

--wvew4mk2lgwdy54p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMmFyxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiEKAD9EH2a9A9rXUSdwTPF9pvh
i/eE3iltJ2K53sOLQwO+QwkA/j4SGI8ffsqCC/4bPXazIOT6CxaB9GFYQNStJWbn
yvQK
=er3V
-----END PGP SIGNATURE-----

--wvew4mk2lgwdy54p--

