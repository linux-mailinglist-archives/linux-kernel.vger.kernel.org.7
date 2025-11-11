Return-Path: <linux-kernel+bounces-896080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97EC4F983
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC03454D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735C325708;
	Tue, 11 Nov 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TW2LZWqL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B43AA1AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889149; cv=none; b=Dx3vWXdT3yQpYnT4xaH2ge2Gi9sKAhRenx3ksyRtiZPwszabkYs3F81wtHDCCwq6iY/siiF2JkpEYnAGWzKburOE+PQkSiBEjWIKxAqBF+pkASx7VVZXWLoFXrwSBl8gtG7jktxkfAK0Z2nttr6kjzQgwTS57PrYPg2UHPcD10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889149; c=relaxed/simple;
	bh=DgsqQNap0feVYlCkdJ8GVil6gBGlQ9IiKSKSA1vgS78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liao6S4Zhiq2iPy7Z7jjXgFxcBKQF5/2qSb5KE5IQP20SM2rtwxY8YgHsUqTjPirkYNkWb1olPfCl0u8YTu/URC7dxxIZlvAJCwrVpwHEZuJufGTUuc2Uv6YdKy1IVVTiGCqeaxC4vECg+FSvWDozxQKimwUkWsXesP4Y65EkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TW2LZWqL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso583845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762889146; x=1763493946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgsqQNap0feVYlCkdJ8GVil6gBGlQ9IiKSKSA1vgS78=;
        b=TW2LZWqLsng4T8jh6y7yEI3YeoANn8hKUphuWUlIDr8N/HR2Y85CHKGKQnBPKExnqx
         IvtHjnHMQ3KsiwaGptUgC0MFNMjqE0BukPCVYtvcsfCgtyfN/N5snRKbu/hTfWhaf8ZN
         1YaoXU/JJ+cg+qQRHF32wouanP7zji6HW94MJutA2BmeBof0ZoLXM2m+XXJKjV1vvje/
         srKmnac3RL6e1QUxrZfkl+x8pgOlnSkEHsyqVqrFcTOv1XJsBufTuZgeqgS6BPaKjme6
         hO36bL3GBwwbLi6Id1uP3JFW4bvPbX9HbVeEW1csvLbgmX7AaMGbz09Qd5zZtihTS1qG
         uTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889146; x=1763493946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgsqQNap0feVYlCkdJ8GVil6gBGlQ9IiKSKSA1vgS78=;
        b=ZoKdtL2yxXTcvdlDt+2kFuuLH+sHmAYQF5aiQX/eQasbZeEbHVEPuGQRCF9UWG8t8Q
         8kndu1BQvlL1k+kuQQmuDtoJ7QO8kKqBUJcEuUWV/CEVILvAvA+ReSWkLt9hiLjuoHGk
         wjXXTw/d9Zgn3HUwe/XbsBiHd+a0Nzk6O01fnZdO150nPpV34sio5sCyUcylZpyug7ib
         5s+EMGndOtuflQqNcnlpm5zYB4Hp8CyoV4dIEfWP08Horqq2Ir489kno2eh3t/wYLXYQ
         RnYYX0SucqmTroQgUvwiJge0i9SJRYh85tkI0dtBeeaWDSak67voPh/hzSqlmlMPs9NH
         h4kw==
X-Forwarded-Encrypted: i=1; AJvYcCU2sB4N/edsXQKSi94MpI+9qYe41FUQkV/iU37+TzZhckj4b1dX4c+a73RSJzD4mrdnbA+HIZpZA21GH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpSECkDoBaRk64MW7Ip5i+Pc9mO50Rfq4vuxuOp0ZNar3QJBXh
	OWuGOaNR5JldEqa4MfB3J/k+eteRVyHF3QM39kzvBWLFkSOeLHAL3z/VPWp74Vb41xE=
X-Gm-Gg: ASbGncuhlD8HQQkeaC4FjsAJq5oZ3N9K0gjFxWVDR7wepHKX9hRLc/M43gcZhORl4zI
	WKQe+z2toUbizvW76g6XuBDoGb0ReXXY+bmp+btaQTd7EXKVqtQBxwbtN96MfozV0UcgILE5FQb
	Vda40C6chPH00taC4HE8o1h6XdWZhhHDaSTgZ2p0AEJ0m8zHL5eMtfyn81R9FLFQv2oTYIDYZmp
	zR4z2zIpwSqCcyP1+9P1dZEPPQ0ONlAZqijLDSIaWHoeDTFfBAJZSHFUKqXnqvcyUzS4A6okfCi
	1OqyPYs+vOk3yXIOmEHiVaTtBx6sDDTCJM7Pi0UtIHwYviDIkgL0UQn8UqW3CS91crsyyZMcMb+
	/tdDF4ZomTyXz+r+d1E90rT1Vreh3muRy2PaI00To7zqd7cJzyfWFgTdacwin2xNeRFWGcm/ohi
	cQVTWP6R8xlo1SJngFhdPPzM9dT/qq96g=
X-Google-Smtp-Source: AGHT+IHZU628pAQZAAnaDo67q6kzqKxyu+R+dz906SsaPb/vvBufNcxi/AkBkAwdXNlsyQ0HAiMCOA==
X-Received: by 2002:a05:600c:4714:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-4778704ea68mr4696785e9.18.1762889145924;
        Tue, 11 Nov 2025 11:25:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm397981995e9.7.2025.11.11.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:25:45 -0800 (PST)
Date: Tue, 11 Nov 2025 20:25:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
Message-ID: <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvxxsanga2y5s6vi"
Content-Disposition: inline
In-Reply-To: <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>


--fvxxsanga2y5s6vi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
MIME-Version: 1.0

On Tue, Nov 11, 2025 at 10:16:33AM -0500, Waiman Long <llong@redhat.com> wrote:
> For internal helper like this one, we may not really need that as
> almost all the code in cpuset.c are within either a cpuset_mutex or
> callback_lock critical sections. So I am fine with or without it.

OK, cpuset_mutex and callback_lock are close but cgroup_is_populated()
that caught my eye would also need cgroup_mutex otherwise "the result
can only be used as a hint" (quote from cgroup.h).

Or is it safe to assume that cpuset_mutex inside cpuset_attach() is
sufficient to always (incl. exits) ensure stability of
cgroup_is_populated() result?

Anyway, I'd find some clarifications in the commit message or the
surrounding code about this helpful. (Judgment call, whether with a
lockdep macro. My opinion is -- why not.)

Thanks,
Michal

--fvxxsanga2y5s6vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRONtRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ahc7QEA5UPtVb+rnzLNsHbbUVJF
jcpVPCYID/X0o4LSGY1becwBANqmtiU88ZCjE1AEHTo+l0lM4C2vXDmymf0fBSlI
m54E
=MaQ3
-----END PGP SIGNATURE-----

--fvxxsanga2y5s6vi--

