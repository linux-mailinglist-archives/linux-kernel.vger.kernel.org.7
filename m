Return-Path: <linux-kernel+bounces-795155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC4B3ED94
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E53D4E012B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CE31986D;
	Mon,  1 Sep 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZG1gY2ut"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA8230E839
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749491; cv=none; b=R6RRm0mRnQct25bMu3kfwats5Vdsxwdf9dxSvHB9V7dbS3SOpjUdJNJptFjJ6O0zToHn+eHlbfMAurTb/YsrlulEsdlK116L78cufb42t+dJtSsX5w2kwTnLpHHHZ6CxfA7W7AbkXFaCgsILaniYFqIVBdTZM2cqFl6Xjj0fdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749491; c=relaxed/simple;
	bh=3byL/Fj0HJ/ZBpYR43St9uLQGKkKDjP2v7oMiVkvnmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8/1DYAZYZrT9W8+a/SvgUlWajSp8mrgquX8FiiYyXoPZjpeMdwx/5fxoLr0PYDEh/s1LVS1yck2SmIii//ICF18fsquswa6KY18291gxF4seRdHUXbE+IQ60cuYZauiQAWXxOacPDOrSH8P16NkktTgIVeS3wlsn8UiSi37WmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZG1gY2ut; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ceb830dd58so2536916f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756749488; x=1757354288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBrUlowGaoMISX9iJ5RVVV/ygG/eI+RUk2vTf+rH8qI=;
        b=ZG1gY2utY2Efkm9aWHKJRfTIui1Gpb1ubIUJp2PsMFnYGvHfo7FgdKlKFkMLwS12P6
         Q6tPJ+pQpOwa2CP4AkK9HSBhskatqOmM1ymsUHD7Dw0amPtUUIjwgMQ9MoHVxEX+yIN5
         X0oX1wTTonJmb5MYRiwHjaPuqmgRdmYXHvqhl2xG9iq8xc575YDtiKMqe3ID4VqlPQqA
         qNU28X+CUp8gUzVX3kXtoGHyYszGnLUu72AY4SuQhDun9NIKXM2Pjk3vTKE3eYDbFEjl
         xMP04CV710kMyP/EkIHiAzUJnsjg02lvE5fEkx/5CgAr5TGuwItnRkK30vUY7ILFnbHO
         pW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756749488; x=1757354288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBrUlowGaoMISX9iJ5RVVV/ygG/eI+RUk2vTf+rH8qI=;
        b=X+QEOrdULh7B8A+X0wfF7cBxA2VFrOPc1tv4iVVHtVmyuoFDE5OWh0EA5kTXcR2eLy
         naaujVYWHL6DAGrovvE/1UG9+P/7DCAa7TIrEpDJxM9gKBdj8zePOB2jU8EU/j6+7iDx
         Ivb3e/+CAbS6eTVkeh6kaq87V1Rxt7b1YnyDnCBg95xDLhXIFmaqxBsH7MqR0Owumuz8
         nbtJQHPUu0JxWOmFWAdfI2dOahZrfQ9nk4FY6solGOtJnIk6zR7Q1HLT1fGK7pnNtJf/
         b+jSS8LxcvkTAq3+4rwr07xlxogs6362SPl77nRj9mkPAK+h4oaQZeOuGvh+cvtsHhpQ
         U0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtFseVs9xaTuuym2+24kdYRwY82q7r18eA8WK1Yj8jUdt280RI8ySMzV84UQfElosaLFn7BWb/uYbulhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5U+8NDaNGJWR0AmWfRcC8sXu7fg1/xaJR0U4nMMNLM6ltyo/b
	0+tbjq2pisT0NVZ44sp1LXao7t68qOqSZiRtnyVrtSJYHIlgHkZ4enO+eL5EdLBnZ/A=
X-Gm-Gg: ASbGncs1sQugcYvG2Ozr+xavQ5wFWrVIp6YiGsCd7Skp0VurAwWDgXtLPqNzXEZTWEw
	1/RXCpFbjg/2aOx5XNLT+HKXEnhUpqCRmnuZUWjrsrszob1/d1M/vpprRLEm130WA3e3z+hhUOE
	WS7U6l4LB3Um2PEgI6eRflPReNG0OHOGgxolum2JjRpHPF0BCQsWIil1dCG7GxIHg4PBFrcLwmV
	3F0PdvdU1lDxWa4sRTt7dVlu/HYtVQRdu9meq82Ais6PQoqu72SWIYw6IFFyI148+TD/nu0Z/Px
	mlJ6RfWxH1vlsJUKJlRROzx9oDmXYh0H+3O5Nv1SO5FE7NGUjE1XXXy/WAuVaJdn2pFtbJ3QSyq
	3erTONya2oJVmReDm22TusfoQdJRY4uy3lCJxYMVIM/fJM1A8RoqcWw==
X-Google-Smtp-Source: AGHT+IEKDAoZsVvcs49zoW6IewZ0iCEshtHwmKL7QaW26/0FEP2utdDdAE4fZYnG+d5xmXCXfom+zA==
X-Received: by 2002:a05:6000:1ac8:b0:3c7:244:a4be with SMTP id ffacd0b85a97d-3d1dd04e24bmr7849050f8f.10.1756749487957;
        Mon, 01 Sep 2025 10:58:07 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a5asm15994104f8f.55.2025.09.01.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:58:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 19:58:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lkdsthcjr73q7k4e"
Content-Disposition: inline
In-Reply-To: <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>


--lkdsthcjr73q7k4e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 05:21:22PM +0200, "Gustavo A. R. Silva" <gustavo@em=
beddedor.com> wrote:
> Because struct cgroup ends in a flexible-array member `ancestors`.
> This triggers the -Wflex-array-member-not-at-end warns about. So,
> while `ancestors` is indeed a flexible array, any instance of
> cgroup embedded in another struct should be placed at the end.

Oh, so TRAILING_OVERLAP() won't work like that?
(I thought that it'd hide the FAM from the end of the union and thus it
could embedded when wrapped like this. On second thought, I realize
that's exclusive with the static validations.)

> However, if we change it to something like this (and of course
> updating any related code, accordingly):
>=20
> -       struct cgroup *ancestors[];
> +       struct cgroup **ancestors;
>=20
> Then the flex in the middle issue goes away, and we can have
> struct cgroup embedded in another struct anywhere.
>=20
> The question is if this would be an acceptable solution?
>=20
> I'd probably prefer this to remain a flexible-array member,
> but I'd like to hear people's opinions and feedback. :)

I'd prefer if cgroup_create could still work with one allocation only
both for struct cgroup and its ancestors array. (Cgroup allocation
happens many times in a day.)

The increase in struct cgroup_root size is IMO not that problematic.
(There are typically at most CGROUP_SUBSYS_COUNT roots with gradual
trend to only the single cgrp_dfl_root.)

Note that it'd be good to keep it enclosed within struct cgroup_root
(cgroup1_root_to_use could use struct_size()), however, the
cgrp_dfl_root would still need the storage somewhere.

HTH,
Michal

--lkdsthcjr73q7k4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLXeqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhNuAEAjKx0omIrhaMBlA3ec6KY
kqg6f5iLg7LyrRkia3U31fMBALYGUaC9K1uFILkO5S/s3uVVR4mEqpN44csiQoP0
Y/kP
=jkIf
-----END PGP SIGNATURE-----

--lkdsthcjr73q7k4e--

