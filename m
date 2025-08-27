Return-Path: <linux-kernel+bounces-787960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61556B37E15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF191626D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595B2F60DF;
	Wed, 27 Aug 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EvHjPhgu"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63781FF1C7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284418; cv=none; b=pDzrGLFlpXlnQAn0mcG4QnO+3PCGKCbsdgMch14g9STf1i6bMXb8T2TVSEjWKEaBW+ID7pKvHF4cRWDJmhEwHcPdiZrZofEXLTl3JZnfWGWnwm+3Zk+D4DK9BFawPKuLghooUyVqjCkg/fc31/fr76MRnX169N9c7NT/fb+ZPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284418; c=relaxed/simple;
	bh=SuhyOnXQXcyL8UMuSG06qdRFA+YF/PQe9SePBTnntkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9vy56/80t3z0BF0jTEt0/zouFtgOk3Xo73EadaRDUqkaIRi3m63CLUvy3efoyPK79GaGJSPlDl29+qIRKeNnFmTxfCCSQrcuxieQQvymWNjFqfJfKSRM/POCkSOTKuI7mKBafd3cGZdff7IjcBxGLJlxYCQDMeRVKybhtPyJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EvHjPhgu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3cc95b0cc21so298980f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756284415; x=1756889215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuhyOnXQXcyL8UMuSG06qdRFA+YF/PQe9SePBTnntkM=;
        b=EvHjPhguCY/2VLWmvm0YiMknrilOvSufERrv1iwYlk9jKgotrQ1iuHKhvZUA+LfUpV
         rwvCbT7ByicuqjhH64DvBdZtzbgHnZN9H0LmQwyDFxfcM/sNtvhPkb7uBJaCWyHzQtCb
         5+SiqVSsXi6eIJHuoOufYtYBe+UVeSYHwbPWiTT/nD49dJ7fff1MUHpqOnq+bZrESx16
         FSgMvnI/BSYCQkC61bZqkkH5TPYUMnG19AmNd3OjEMPbNkhYXkaukb91NdqJGqLI5+QL
         cu4I1NVPU7wcBbJHFcN4D2PxiyzvE+yxtxV1DwwbdfqC0lY9C1+GkTnrVMFFOwErV5ct
         k9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756284415; x=1756889215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuhyOnXQXcyL8UMuSG06qdRFA+YF/PQe9SePBTnntkM=;
        b=nktsAfmv3xPDQy7dS91I5Gte0qBfRY6jvshugJ1fQWiIv1sWYNjKckVE5ZgNEjgVsQ
         wFVrL4tHR7pEWdJ3NDxQkYatSi59JocxlMnFWgnvPf7ogY1wJ7W+5pvxr7KMqWExpcsn
         q6Oo6ls8NDZl+rVRTmGp6YisqqCfYY5rPTHI9lo4/c370Sf5quTDXhxqERE1AyoUNH10
         e+9VR/zBpSG0r9A4cRFtW/9SNNYpys1Dos+7bt0FwBrOE2uQNbYjOlUy4+3f/zT+bZzx
         VGobatke1LBPVvaskeVF35T24yNmmb+xSmQYeRirRv29nBZ3JZYiKKBrzqy8SqtLSfwD
         1otQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpX/DXkV6iwPneVebtDM7YDU9lvIjGw0Tn5J74ZN73fLhwXjZpf1T0qx+wVXv6YbxRMbzSpS3nr6snbxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMHRIULpbq67vqgEqIcVYJhqj5YCNN7WNtd7JlmQDz1837eMg
	axTkx6pd4qmYDLSj74z6YIHD4shG2YSloUnBGsLipWjWverKXR0lppxGTWK/BBSs/7M=
X-Gm-Gg: ASbGncuURcfWZHLYzJTK0GYddKriIvgxIqxrVx2oW0qjwh/iPnb0iTQmiyBLl19e5Ri
	fHk1leqSeU7OdrrFNNcwFLLeDYU2998d/bDuJ4UqhMCHPF5l7v0YaRtlWfGodHmkQdzMbEjQhZO
	rKVwRI8FfTjHBX7d7dX380qJUchADInPUJpFoVfgOYtVFM35plGZ+EepFuaMZsChl7B6qdDNtDH
	3+hYPgqEyTePgi/jQYPZdOApt7mnSU0lOfwqUb9LzVB58M7aAiTOcAkOvQQykDe83Mv7yljQoIF
	LuKJIzjNRSXXTqEAhvcpwty7sq1a2IqoZoiRZluCqsdi5R3If1ahCiml1BnfxRpH1YsIUdVsizq
	WgTCu9VnIwMnbIk+mhGWWBrGm/ybaZda+WTEAazEV5Ew=
X-Google-Smtp-Source: AGHT+IGWJOxOH3ZMIayAV4TyQG/sUUI7Zg8meNLV3mNl1YmrdY37vT4tdwxDKqJDDJN36lilsBHIPw==
X-Received: by 2002:a05:6000:2888:b0:3b8:d4c5:686f with SMTP id ffacd0b85a97d-3c5dc540a3fmr14446073f8f.39.1756284414821;
        Wed, 27 Aug 2025 01:46:54 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7720e184090sm330370b3a.82.2025.08.27.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:46:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:46:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
Message-ID: <vel3zxgvbrqfvw6drqrtbski7xwe2thn3bfeo6ahifuncvjxvu@kegptpfird5l>
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-4-chenridong@huaweicloud.com>
 <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
 <312f3e07-0eb9-4bdf-b5bd-24c84ef5fcc1@redhat.com>
 <2b574bb7-0192-4a91-8925-bd4c6cc8a407@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="blzwcny5j2erdyph"
Content-Disposition: inline
In-Reply-To: <2b574bb7-0192-4a91-8925-bd4c6cc8a407@huaweicloud.com>


--blzwcny5j2erdyph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
MIME-Version: 1.0

On Wed, Aug 27, 2025 at 02:23:17PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:

> It was suggested to use a do-while construct for proper scoping. but it could not work if we define as:

Perhaps like this:
DEFINE_LOCK_GUARD_0(cpuset_full, cpuset_full_lock(), cpuset_full_unlock())

> So I sent this patch version.

No probs, it's a minor issue.

Michal

--blzwcny5j2erdyph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK7F8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhxAQD/TPj5lcZRSj2QqDEtK3Vs
ISmUxmn/7ofiqLpD0ZC90lMA/RWl+pfZ5TV51vTO9dx4bKAaMgu2WfXPCW4le927
vroJ
=12gP
-----END PGP SIGNATURE-----

--blzwcny5j2erdyph--

