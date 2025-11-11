Return-Path: <linux-kernel+bounces-895549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C09C4E40C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3395E4E99CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B340359715;
	Tue, 11 Nov 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lc4EF7rX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E33590CD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869274; cv=none; b=hxhzbox1byBs71vrx/Jlo0CqbB67LuaSXVQKEpQ9bain+N1bwk/VfQ7H6IqkU8NiDLVLdUuwEXztpX6PJKcr0qLFesKPQJxUbVh3uKYhwUqhM8nhFaKJ3MJ+eN0ieDDU9FbXK7/vCkdXB/qB83n5FwFsIT07ueYbguLy1aQ9fSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869274; c=relaxed/simple;
	bh=P6GNFkzn8TcXRgWxzpOmWVxQL+x4LYS/awOpWtj3rLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0jOCHEQ9ASY5CPIR6Ew2zTMultRQz7HHt609nmWwTwmpmG6o68pc3q8gIMP4oyQwDEJTqC0ydJsP0JmTHtKqCVXDU8ssjGfTEqbJnCTFcciVH46TgR3d4X6XRzuO/R6iAYKBjA8g0iaD831HRtSF35oBs3hsJjoqqi3G2zAhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lc4EF7rX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775895d69cso22109075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762869271; x=1763474071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6GNFkzn8TcXRgWxzpOmWVxQL+x4LYS/awOpWtj3rLo=;
        b=Lc4EF7rXcN4CsD4RsUVl3OOq61QaHm0BkoNX5fv+U+nif72IulDQPsgiYoT7T9tj+I
         1oQK3GtKb9v/4BKDDqzPyZtrb3x71+9IFN91s+BkGNjlbWhy4swQ0eolq9ESZDgss6HB
         DRvYhiEeKqcYehzGoVxCH0GBEAp3xEwhULrJGvb2xpMb4A+IuEX0uELEcUQQDzer8C6T
         nxOH2GdMhNZgwdxZgiV5nL+OPPIOdzEpOxw3H4S6yUs9VFCW3l1e6XATcA0q9y+UxTmY
         tVmeIof/x6FdKMKIR/DlbO7FiW56qEJtajDRY6IWR/0sT4zfKfsRlZMA1v0M8uPQxI6i
         yZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869271; x=1763474071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6GNFkzn8TcXRgWxzpOmWVxQL+x4LYS/awOpWtj3rLo=;
        b=SEcZd5dmXkeErIcm55xxqdilMYV1sIvgVUFzptZCMV9sznBfO9eisQ6iNiGejKgGT6
         13SvJDcoAewPmNdAY7KBnSzTWtrfS8EeLhAh/88yQighjP7GDUeT0vrv3EqMn+2s6b3I
         v0rtntIUsP3jsPyDMwj6f6RlViccP7rXVaWza1moRvJ/Eq+MujR3D/b+XHr7BLatoecS
         3/lgKj6zJzBlP67u42vKCHwQf+84/de9uAZgku5c7OBVPC+xO+uMUY63N2XrtuWLaElI
         mhiZiIwXQ6CzpjNa3VqLJHI7wAL+DFFmStPgoDJ+DBNSGIdUJS802fUf1b7d5giXvxHi
         j+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXQN4Si9x7TZB6McJpnmwfl0ITVg5WQCHx7WV86TOSGd0zj8xiTAEDe7sCbYJaUpjZz2lYzZOU7VazeCPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnEWt1pw5c5S0GiB19G5Uzkb2uIQoIBzN+6U86FiRmMATniiO
	J4QPfSrX1L1UECTFdkB0G8my0oXSvqfmsfXvWlFmqwIMtbpUj/ezhEf+GcDSA5pI2FM=
X-Gm-Gg: ASbGnctUCznUvRYZyAXafd7ljhKOuDCVJM4HN2lSmpBiGjFbITmSmP6OR5YA1Xd7ms5
	DcWfz7itqRN+DED1ZQqarHWluvurC3wPqscMg9V1spQiZEBsatAd2sIlGDhVG6BBa5meCb99/h/
	Go/8uyoTFlOlg3FHGFMSyli3X18SzhXN+OSBPWT2RbQddbMsArdHqeutqqRvKIK5DBC/29MAbKX
	9NxkoeNWw+3NI3jtNRUL4y0CAJVRPsaI5PgGIwIBYWzNaV13KFeWJZ1G0DM/VqStMT6N1fpXDUW
	o6bE4P+e9lxZQULE7nU8PwCGn97x7PdiXfve5j6aBAnxN81rwXW8oIoUj5RHsaJLd672mIBLBF+
	3q/ufdgvvKMlcqrDVTBepF0EP893mR7PuTtI+7aQFaHmCP9mzi/BnFOpEujUh1FjKoeQ7Ymehj3
	8nWgIA1MMq0B/ZFP0uF3LDbjBksdVxdzg=
X-Google-Smtp-Source: AGHT+IHMToJMTHnk0Sjr4OhFA30NqCu+I6pfjVpcEXbS9ImlNQd/QJ6+y0oX5fqt6AJuI1o5RGkDjg==
X-Received: by 2002:a05:600c:4594:b0:477:942:7521 with SMTP id 5b1f17b1804b1-4777323eeb7mr91052805e9.14.1762869270698;
        Tue, 11 Nov 2025 05:54:30 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47782ceb0f9sm32628105e9.4.2025.11.11.05.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:54:30 -0800 (PST)
Date: Tue, 11 Nov 2025 14:54:28 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Wenyu Liu <liuwenyu.0311@bytedance.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
Message-ID: <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
References: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvlhdmpdiubfdwdh"
Content-Disposition: inline
In-Reply-To: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>


--wvlhdmpdiubfdwdh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
MIME-Version: 1.0

Hi Wenyu.

On Tue, Nov 11, 2025 at 09:44:27PM +0800, Wenyu Liu <liuwenyu.0311@bytedance.com> wrote:
> Consider this situation: if we have two cftype arrays A and B
> which contain the exact same files, and we add this two cftypes
> with cgroup_add_cftypes().

Do you have more details about this situation?
Does this happen with any of the mainline controllers?

Thanks,
Michal

--wvlhdmpdiubfdwdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRNAEBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai/EwEA9e6PnEEBOoLhC0CzLK86
2RY/swr1ksmy+r9aHBwrZd4BAMMsmAU+h+i/JmiGtCaXwilw8j0HOOIp2mJFJjyL
SDcB
=dvQ2
-----END PGP SIGNATURE-----

--wvlhdmpdiubfdwdh--

