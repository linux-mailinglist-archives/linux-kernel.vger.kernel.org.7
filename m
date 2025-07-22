Return-Path: <linux-kernel+bounces-740488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F4B0D4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BDA1AA22CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1852D1F69;
	Tue, 22 Jul 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LrhmVXb/"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9672D3EDA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173686; cv=none; b=hebvV+Tnpsyaidyn1/tYVU3uaKlJzmj++omYltDzlW+wxGjkXVwD/6JUkC1oR38hdfvGK4fDOFavSrfiYxccATOCs543m11UaeRXenipKcb89Fa0QhhVzJyccU3jvqUfSqa+Uvrg9MtyiQCQQOPOGFEko9BYwTGfVwZE8HIWqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173686; c=relaxed/simple;
	bh=01w/qmnV+Ivw6/6VF3WZabXloociS3gJDlp39Lg8Lzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEOZbd4BHIZWHJdmevPAxpl6ISUiYO5SMUtvGpvv8dqRblLDWMODHLJzzI14Cc8+iW8HR1FnNFkjvnetij+LSWEEw4JlHeAFlPP6SmDaNZLbf3Bxhj2UbqiKRrPKC20bu4Y9mzuWBAdxbTAgKUhp1ifCImxpxSynAk6PxuBlqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LrhmVXb/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae9c2754a00so886575166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753173683; x=1753778483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRjs2dB89iP5QPdZHpfO+IIDPv1Lm2vrEdP8oJ8jq4I=;
        b=LrhmVXb/XPH7tXqWinP0MQ6s4b/7cZSRjfIHZlYXHQ2iOsEkhZ5Dnhy9XNBGnFVE41
         ICe5VhhQ8g+Yt1REDXYrqZcPyvdgjxy93EHe4szHxQu3eF26FtO0MKNJpmMaZi/pMCEp
         NfLK7zD2aTZWGF2ldpQ6bZQaELQAeOH7KgS+FEWjOSo1MfCOCOMznvSWwvifmiZfNNTI
         VbfnPXGzqQ1JJXNbvfy5iZ6XBYIpUSTn9DYtQVOSU0rKJlPAPLCg9AyjSisoKoCo8/IS
         lhz+k2Sfb0tNIdo0NcEOFPYebhjunoZ/jf8lcEhmZI+vcAmi/k2c6vapOwA3LmiiEV58
         SOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173683; x=1753778483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRjs2dB89iP5QPdZHpfO+IIDPv1Lm2vrEdP8oJ8jq4I=;
        b=qYIJMQZCnMD3IbPkho+lv8wHl/Ag7lo6M47BwzJPoQu0LTZXV9O9RTiyx3IiVhU28P
         zfvbJBY96IZkBW9oCjRpRZIVVffDdpVphMmJdJ7x91xIETe3x2pDz4xy7e7gAA4WWo6H
         V042Fud9bI0OJ0uWqgriYsWFNw4bjg2EGN9+zOb7WHRrQVqGd8SBrOV5LgAhsLkxgnQz
         IIoA3RtlKpAg7LTIoXXO3G2Ii+vwGLMkIB8VlP8VX0He1GkOWwRMkusnxoVzGozgKmuP
         BwNfRFPG/pIeBh2CG6q2eooti7iuyf1GOfzS7FZhB+7p786g0JJL568YD34QPfh07OVs
         HbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmd01gsTc9Z+RDFdhS09QtI7+RrfhkjZ721iCalpkqxeXoft0HRrfMNPplu0hf5ULYVUPtK0V3TwQ5WUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBEvoFFDrGZuOu0Qyk6kfKxJDuljBxTaKOhmPF178wvFSA3R6
	YdMmx3FfNtCc75GZDGZv+NI5Fl8Cy59iPEJkiEFzin3kcTSsyx5lBoIkOAdtGlI9Rv4=
X-Gm-Gg: ASbGncs3mV6hLMh5o+iN3SrH7lZnTjWB6iKyOUVGSMk1hXhJdyjHf/tkzhx3+2zERbi
	LWlyjW+Y599tJesnrVXrCE6+4KVdMB6FqVBJ0Kiv5PBJDL860hMi/ZLxr6m9q27DFXSj7ENJ9cz
	Xr3w5MErUif8u6v4ermydAfxcyALGt/9xm/6tKAZ9b6Gt4a//zFzmAkHdXbLoFoupGqBwVb69SP
	+a32kqZKNuszJ+euFcMF5g/S/jfYALkPm0LFe0SP72rkQzO7C2XlNWQ8iOb3RDZuwlt9Kpz9/ya
	s8HiX7HfMzs0TxhlpJEoXfpROl//MqE/prv80QMTBtOCkLro103d8z21zTXFJ7L3goD4DDy6ika
	NxnxwR3tyOqX56lfu4P70LaUZWt6upZLzr7/ttt+HJ9xOK+9koWSq
X-Google-Smtp-Source: AGHT+IGVTq5jQfcMBSU2EE35kS23f3MVVY0rKBzXyZk98SKg1l8+dLktQWM4sm1V77E9tsRIzM2T8Q==
X-Received: by 2002:a17:907:d89:b0:ad2:4b0c:ee8c with SMTP id a640c23a62f3a-aec4fbea8d9mr1823014466b.35.1753173683000;
        Tue, 22 Jul 2025 01:41:23 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf733fsm829032866b.159.2025.07.22.01.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:41:22 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:41:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gunho.lee@lge.com, iamjoonsoo.kim@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlnvw6uygziqhfah"
Content-Disposition: inline
In-Reply-To: <20250716202006.3640584-2-youngjun.park@lge.com>


--qlnvw6uygziqhfah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
MIME-Version: 1.0

On Thu, Jul 17, 2025 at 05:20:03AM +0900, Youngjun Park <youngjun.park@lge.=
com> wrote:
> +  memory.swap.priority
> +    A read-write flat-keyed file which exists on non-root cgroups.
> +    This interface allows you to set per-swap-device priorities for the =
current
> +    cgroup and to define how they differ from the global swap system.
> +
> +    To assign priorities or define specific behaviors for swap devices
> +    in the current cgroup, write one or more lines in the following
> +    formats:
> +
> +     - <swap_device_id> <priority>
> +     - <swap_device_id> disabled
> +     - <swap_device_id> none
> +     - default none
> +     - default disabled
> +
> +    Each <swap_device_id> refers to a unique swap device registered
> +    in the system. You can check the ID, device path, and current
> +    priority of active swap devices through the `/proc/swaps` file.

Do you mean row number as the ID? Or does this depend on some other
patches or API?


> +    This provides a clear mapping between swap devices and the IDs
> +    used in this interface.
> +
> +    The 'default' keyword sets the fallback priority behavior rule for
> +    this cgroup. If no specific entry matches a swap device, this default
> +    applies.
> +
> +    * 'default none': This is the default if no configuration
> +      is explicitly written. Swap devices follow the system-wide
> +      swap priorities.
> +
> +    * 'default disabled': All swap devices are excluded from this cgroup=
=E2=80=99s
> +      swap priority list and will not be used by this cgroup.

This duplicates memory.swap.max=3D0. I'm not sure it's thus necessary.
At the same time you don't accept 'default <priority>' (that's sane).


> +
> +    The priority semantics are consistent with the global swap system:
> +
> +      - Higher numerical values indicate higher preference.
> +      - See Documentation/admin-guide/mm/swap_numa.rst for details on
> +        swap NUMA autobinding and negative priority rules.
> +
> +    The handling of negative priorities in this cgroup interface
> +    has specific behaviors for assignment and restoration:
> +
> +    * Negative Priority Assignment

Even in Documentation/admin-guide/mm/swap_numa.rst it's part of "Implementa=
tion details".
I admit I'm daunted by this paragraphs. Is it important for this interface?


Thanks,
Michal

--qlnvw6uygziqhfah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH9OrgAKCRB+PQLnlNv4
CMRBAQDzCszk0ZJDxPwRBr0crrEo5Fn9310kn3KBAiLE3KInXgEA/or1joqEpYNt
8C29XY1pGwaogm1oWi9Qfn+sSCEoDQI=
=vEC+
-----END PGP SIGNATURE-----

--qlnvw6uygziqhfah--

