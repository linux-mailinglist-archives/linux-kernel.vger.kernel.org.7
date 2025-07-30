Return-Path: <linux-kernel+bounces-750255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A779B15929
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CB2545F44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FDD1F5435;
	Wed, 30 Jul 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="op0fk3a6"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E523741
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858500; cv=none; b=LhrfupJwtKlSD7eV9JxRE9FPbKxKdbYBVhm7CLxMIEFpQfW7TVhlxoBOCMsSOkw0dilZ0o5KrwkXN1s+OhxZYZN5VMcJQZ7gKuUU/PtjFeJKwSRWJmhi3SEYGwv8BA6Jm38nUeiXKx6QPBJJNsGsUBymR0oilz+0gcJvw6R43q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858500; c=relaxed/simple;
	bh=Rq34rctAyfwWtDTGvNUB7biVZ/HQfQ2mLqYrw/Jygj4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GSAP5PpTd5Z2C/p/415Up/wyXQGraBKhCyamva/WBMeYbV/OAuVnOaG7lXnBmJLYo9AKwIkAbs6tOvUbtsehd7itC4AMdN01El+AG26wOIfWvReQNcsAIdEQUSkf/PseReekR/aQL8dGU3dc6JRZh/pCsrLKguuUOi+h4BjTWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=op0fk3a6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70f862dbeaeso58623597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753858498; x=1754463298; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xb9lxccqqzV/HuE6IBjo5UmOhzvTQ7eGMAvIhyfuiTI=;
        b=op0fk3a6CIgIM8KclP96oGI+lQAL6DyBI+tbvp0cALdGi3CDRoL6Xw+rjZCsHkZhgc
         j3J3/fON459jagXwzj+6ujFxqqbSAvCqQAP25XHSHt+DbigLLgiNemHISTwrh2Gi0UmN
         L/mttv6qkiepG95CZdJk+WfXEAGaNCDTi1T+hrg9QKxtMXdicqX4v8W11KShN8qpZJ9m
         VvAXNFebdL7EUbAgY0vp/XDOlSGBVc3SBGGEqUEgxy9ZxA/0FqzYr18LBvPNMmtF3gGb
         XLbW1bRDRzYnPfrFuf5zkYJtWc0xtnJOr7h10Oa9X/bJByAaoZbTMtUR8n2/O6FPBbei
         Izjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753858498; x=1754463298;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb9lxccqqzV/HuE6IBjo5UmOhzvTQ7eGMAvIhyfuiTI=;
        b=sr8dJwc6TWHCMMlrGPLvJL8BTWWYFh2diiUoSQYbnQrx7bkBtaXXlm0FHfXhi4fIxQ
         nsGeKBEQ6uCvVsVYgv5P3yisW/3PxpIqczAR2P3a2JTiqLxn//JMeck4INYowQH8ORMU
         qQ8KL7EOlhgDHwUUD/GGS4ggs+qxSy3+VDLLBtEavpmyTzRMfZGlfcTjWSNUNyr9BJXg
         0Ny5AAoUdnSen+xwm9QFd6UbmDsFeyFPOAWVtZ4yuulRs+iiS13uYaSVUzOOg4u0Xc4m
         4WV5nZ6iEEn9CjaJY02r/fa2RG7Nb+iUsyJEuOJGSVcAQgt7iHfELO4EN7PF0qMLbxzh
         0oLg==
X-Forwarded-Encrypted: i=1; AJvYcCXDz1dj1m8BsK0oTbee7A8aSdWFmjx/mFuB607x89OnCLCW/l73fVLlClIAePdhcfBIuMDUqiy+DoeNdE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWQBddnEL04Ou0jAH+k2uv+QLcD1kxEkUuEuxLFz0YVHQoJdK
	Dp7CZtSFuzQnHUyRzIeYrXPS0FNPCgUn04Dvs4UrDrs+xgmTNbbpoTTNBrCtURXwPg==
X-Gm-Gg: ASbGnctaXp/QF6DDBxLeR+XFrlr0hQQLkNLMfXCu08rIC5bYm2+SURxrVzarZG+6aC2
	Cx2ziQFiVNWMmCkRXvC5ZZMjdqaROdG+HqccdtKTzYU1S+a6XCAJEnIm9A0DaWqo+k1mCPI9tjT
	7pV93z0wx2SKg3djwayfIMComLjfcxWFJOYETN+34+dSR1MlsZqdqNPG37liD7ErN47DayK5yNy
	dO3IhEPMy2jwVb2GAEWTrT0zKWrjVF6MY9iWFVN9Cl2qpe0ktLTi9ZtvZNR1WtmCpRpqRBmP936
	Y2XmvxhPCgntSoFk4q5Hm2g9FmSUMGdYXwGAJx5jPSYNGeKxmvYnRRDZCpcmyqOVCo+tEaxA4Ew
	d51ttjQdsEK7Op7Bvo/78D+OB9V1T85GwLESdj5he3OwjLDH6kuoI1k/X1jajbgN5MgYO7aMlYR
	xMfr1lGhg=
X-Google-Smtp-Source: AGHT+IFRrK4i6oO1zKk7GnmCX4K+vLePl7LTsNrBKA6nlwjLECThBMqUufa7+jqHJdcW9Ic1/5Dy+A==
X-Received: by 2002:a05:6902:921:b0:e8d:7451:d738 with SMTP id 3f1490d57ef6-e8e315bfb59mr2626997276.35.1753858497592;
        Tue, 29 Jul 2025 23:54:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8e3f3a46b3sm504319276.27.2025.07.29.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:54:55 -0700 (PDT)
Date: Tue, 29 Jul 2025 23:54:43 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: akpm@linux-foundation.org, hughd@google.com, patryk@kowalczyk.ws, 
    ville.syrjala@linux.intel.com, david@redhat.com, willy@infradead.org, 
    maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
    airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com, 
    joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
    tursulin@ursulin.net, christian.koenig@amd.com, ray.huang@amd.com, 
    matthew.auld@intel.com, matthew.brost@intel.com, 
    dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH] mm: shmem: fix the shmem large folio allocation for the
 i915 driver
In-Reply-To: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
Message-ID: <ff93c415-7ce8-a331-9568-7543c6a37992@google.com>
References: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1769646309-1753858495=:2474"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1769646309-1753858495=:2474
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Jul 2025, Baolin Wang wrote:

> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"=
),
> we extend the 'huge=3D' option to allow any sized large folios for tmpfs,
> which means tmpfs will allow getting a highest order hint based on the si=
ze
> of write() and fallocate() paths, and then will try each allowable large =
order.
>=20
> However, when the i915 driver allocates shmem memory, it doesn't provide =
hint
> information about the size of the large folio to be allocated, resulting =
in
> the inability to allocate PMD-sized shmem, which in turn affects GPU perf=
ormance.
>=20
> To fix this issue, add the 'end' information for shmem_read_folio_gfp()  =
to help
> allocate PMD-sized large folios. Additionally, use the maximum allocation=
 chunk
> (via mapping_max_folio_size()) to determine the size of the large folios =
to
> allocate in the i915 driver.
>=20
> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/gpu/drm/drm_gem.c                 | 2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 7 ++++++-
>  drivers/gpu/drm/ttm/ttm_backup.c          | 2 +-
>  include/linux/shmem_fs.h                  | 4 ++--
>  mm/shmem.c                                | 7 ++++---
>  5 files changed, 14 insertions(+), 8 deletions(-)

I know I said "I shall not object to a temporary workaround to suit the
i915 driver", but really, I have to question this patch.  Why should any
change be required at the drivers/gpu/drm end?

And in drivers/gpu/drm/{i915,v3d} I find they are using huge=3Dwithin_size:
I had been complaining about the userspace regression in huge=3Dalways,
and thought it had been changed to behave like huge=3Dwithin_size,
but apparently huge=3Dwithin_size has itself regressed too.

Please explain why the below is not a better patch for i915 and v3d
(but still a temporary workaround, because the root of the within_size
regression must lie deeper, in the handling of write_end versus i_size).

Hugh

---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3a5a65b1f41a..c67dfc17a819 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5928,8 +5928,8 @@ struct folio *shmem_read_folio_gfp(struct address_spa=
ce *mapping,
 =09struct folio *folio;
 =09int error;
=20
-=09error =3D shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
-=09=09=09=09    gfp, NULL, NULL);
+=09error =3D shmem_get_folio_gfp(inode, index, i_size_read(inode),
+=09=09=09=09    &folio, SGP_CACHE, gfp, NULL, NULL);
 =09if (error)
 =09=09return ERR_PTR(error);
=20
---1463770367-1769646309-1753858495=:2474--

