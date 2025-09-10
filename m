Return-Path: <linux-kernel+bounces-811122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C5B524AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5409917FDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF226E708;
	Wed, 10 Sep 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDZjflnT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546926F280
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546826; cv=none; b=FjoLVvTokqpq/HEtkLfxLnWNM+UkGjTkm51soQDcHPlpKAEAVioLufLSqUru3o/40qBYNXaSFu/YygXUGC7P/NfZTjiAHxMhRK0T0FmhFAQh+yDI3eN7mme48L1NUpzXLll2tzM/Vm5BgAzZLEVS+AfP9v4IEtWbfonOlwlbNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546826; c=relaxed/simple;
	bh=Rso4kMNY++0mX+1Zk731FKkeDHtrEi4q28Veb4zHENY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRlQxBgmg5FgE9SfGpYxI+HCCeScAc2T6oTkzetd0oHpV6kcRVGxyKMXYHSIjZ2WUzJ6eY7OmnhNGotDsMi/invu/ePOz1PQa5RYlejIX6qi6QQ2ZqMYxXq9wxHsV7dVVL82KqKfUQue9LAWnfc89fIMt5UApbWxXYIgvbBoP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDZjflnT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso132497b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757546824; x=1758151624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z00uyoYaPpbnnyjTQiKQAeAb5AJf67lVttafJphDMJg=;
        b=XDZjflnTJn4qE5VdkvpfubzrBvIxzx5tJhsrqJYv6IvCWhH+pAwALxZErqNkzPuTrL
         ojtHVlFS1w3dCINqZPDK0sz9IIBHRMga9V1mLk1AKnIJkLC0iQ4enoqrn75GbcssgsT3
         oXcH7ZDAyuJ/OrtpyDTIc+nNhKdnpT9FSf59QQuza3FXaeOulu4oYyPMPF8S1ITrJ17Y
         l0uMzoBKq/muNdYfYrsEoCP5qCA0nxgvZXP5T5lu3loDXMMuJxuJQUULB8dBZ84Im2aQ
         J50JtYlnQIURqXs7wyZ9eiu8a9WFEkV7IFefBhDHLRWH9eTZKmhk08/P3A2Tp60ZYPzO
         U1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757546824; x=1758151624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z00uyoYaPpbnnyjTQiKQAeAb5AJf67lVttafJphDMJg=;
        b=ZS1h6wzWzCjxvm2eNPt8Ybmuu4F4vEeCdeHlRONO5nHha7byTZlaonVYrylqSdtqsj
         ilbBcsqVF9uqh9iFMsZicJ4/qarpdZgK/jwxVjS7z/r1+f+MDcmxpYz2pNHnTX0Nelm8
         4ywMpxE0AHbeS0DeI7+yRBTqlb3U8wo9Oh/3myutSc8BW4sPLjlrDSXDe4ByFFfWFxeS
         f1GCqwZapksMszGzXN6UyWBcZAQ3Hc1Cf3A+a8qE1mZJ+9RrZFmT28eD4mqjP0OxajDs
         HL6RamQLIepSSuBrZcaZAKqUpeYI/7Fg0MY2A5L/DS0uQFmcwZ6DIJ1KGE3l6kgd5OU2
         YMXg==
X-Forwarded-Encrypted: i=1; AJvYcCUANdcIxYEgerA9jCE3qNp9IOudv5ehXsdreEYadE+q1rRcOQ1EzatKkEx8EjmRLAGafIhRw84WTIaE3CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9bnwTMtEtFaGllevxV7YwZMYE+GxkUG5sCAT6+33OY5eANvw
	JX5cxl9oVgxl3VVnsQ9K9SJoQhn8uRcreRVqMQKlX37wtw8KgTVypseN
X-Gm-Gg: ASbGncuY7/fQMfkOke32b4KYkyNNJESJqHjCl9hijfYnt04IhV92R+SWsMshUsBB/tU
	NqnDiX00+XiM05zcPe+DGyI78yf4EHEt01ME1gyaOcXMwZONUn8sn3GRQ+bkyux+72Y0JYOLeEx
	ZoSjcuQCrYlbhGMAFXI630eqfj9z3LvT3WL7ke1cxfWRg9G7gdcCMw+Ig/MZMjrQkD29GpJ9C+H
	IQD0jNW4EEkm8YyVE7G2AZz+GqlGVuUVcl1kC9QaVTGruXyKFDeW8SEpIiDG5QKPt0+bqARt+jj
	Q1ASH24devFmKZ+prpIjIv5xZSgcgfS/bkHersKTXfeokv9d2S//3yV2vSiyB5Mr5FXTLOAgfK6
	AlSGwSPazrNKXjYvTQFEpS7O6NA==
X-Google-Smtp-Source: AGHT+IGSdFMet7QzaqJU44i0rtMUiewSHAuR0CqaJljLhbdxhTDCAcDD4IqcG5WSei/TU75yGs6IqA==
X-Received: by 2002:a05:6a00:8c11:b0:775:fab1:18ba with SMTP id d2e1a72fcca58-775fab11ae4mr3595184b3a.26.1757546824265;
        Wed, 10 Sep 2025 16:27:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662d2395sm6288491b3a.88.2025.09.10.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:27:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C7DC941FA3A1; Thu, 11 Sep 2025 06:27:00 +0700 (WIB)
Date: Thu, 11 Sep 2025 06:27:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <aMIJRB2-G6zZDZMV@archie.me>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
 <875xdqtp7m.fsf@trenco.lwn.net>
 <aMGq5tNNAk5DsJWo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dLjR6Upv5iA7nyab"
Content-Disposition: inline
In-Reply-To: <aMGq5tNNAk5DsJWo@slm.duckdns.org>


--dLjR6Upv5iA7nyab
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 06:44:22AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Wed, Sep 10, 2025 at 07:24:45AM -0600, Jonathan Corbet wrote:
> ...
> > I fairly routinely get patches fixing manual TOCs that are not updated
> > to match changes elsewhere.  We have a nice system that can manage the
> > TOC automatically for us, it seems best to me to use it.
> >=20
> > That said, if having the TOC in the plain-text version of the document
> > is deemed to be important, then it needs to be kept and manually
> > maintained.
>=20
> Wouldn't it be better to have some automated script which triggers on
> mismatching TOC so that these get fixed up. I think people (including me)=
 do
> read the plain text version, so it'd be a shame if we lose TOC in the sou=
rce
> file.

In that case, I think we need to standardize these manual toctrees (perhaps
using custom directive?).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--dLjR6Upv5iA7nyab
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMIJQAAKCRD2uYlJVVFO
o46MAP95YJS79Vxocx2+Wr21CjPGuK8+il4Kna7PGwSba9gVPQD8DKHHYG83I+XS
vgMpfToA++8RL+VVaRxBn/3LsveIfAg=
=iQTb
-----END PGP SIGNATURE-----

--dLjR6Upv5iA7nyab--

