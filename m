Return-Path: <linux-kernel+bounces-758038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B3B1CA09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5F4E2D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F129ACF1;
	Wed,  6 Aug 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLZeppBQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D71273D94;
	Wed,  6 Aug 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499077; cv=none; b=T7xwmdphNInHuGVf7IdWDD4XsBffyweBZRnRtGrQm2NpAKC6aQU1PtiQ93MWWcn2Oa8bM7ODQ4m/ndpJG6RG9Rbu8dZv0FlL0dbLpelgv7/EKFj0ZiZMCmOLKpI/cUWDlRqn+UBOnBuF+qoAzd3rTTPqUG6vbp2OVfLnnUtpHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499077; c=relaxed/simple;
	bh=A0xa5i96PIllfGCTzfkXV4LSPt+MHLSdXHqImCTZmp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQVlwmv0GTiK1Rjwt2hniTRhYKxyzIIAa/FQQdX7t4HpTvPA6OUth20UOEKXH228KCrMa/+OzO0vxo6ncZguDcB7cnR0+8DCZR68oLGZfErA0lXfdM9n9RX6LqdeHfsvDSNzcX6tpymDago2Lm4ieLnVbtw/NgE9ru23ARPF48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLZeppBQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754499072; x=1786035072;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A0xa5i96PIllfGCTzfkXV4LSPt+MHLSdXHqImCTZmp4=;
  b=bLZeppBQshTLishvkd+mqccyb+QrF6wOHSqGKQqM1f955QNt1k/r3BCR
   vMPBqGOJi4LOv9C7m4Ch8Y+Dz44DwIkrms4qv9qCpl3RTOWzJDPV3wJlh
   s9sqDvGSRA70kQPo33JiK1EC6YjY+soXIek0Kg25gY58QWavHzMwFNvoG
   uDiw4LC9oRILxMrLgBneu03Lniem0z/QR5ocBHkwbI+NEV7QP0mtPtonA
   I3GCPoEEyqC+PD6aZET8jWU682WeMV4CU7tTh9YLKdWIN3wbhnNJwZbIv
   /v/ZoEcPwTEfDz4mdNVdI6/K6aZB5atzOK6ATWuuYlDCKASdanMBlyu16
   w==;
X-CSE-ConnectionGUID: YCYT/nibTWmyvoFg2/x0pA==
X-CSE-MsgGUID: BIa+NmHYSjm98dzZU++/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67412100"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67412100"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 09:51:09 -0700
X-CSE-ConnectionGUID: aEryVM7uRKGnlQ/A0jvnjw==
X-CSE-MsgGUID: BJcGohUGQeil1h6yXy9rZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195801861"
Received: from gabaabhi-mobl2.amr.corp.intel.com ([10.125.110.157])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 09:51:08 -0700
Message-ID: <32f7aef379b3dcc51c0bc91854b718abc9fbbe13.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Present unique domain
 ID per package
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>
Date: Wed, 06 Aug 2025 09:51:06 -0700
In-Reply-To: <f762f6a9-74cc-0299-0bea-6d1ab6c88e41@linux.intel.com>
References: <20250727211051.2898789-1-srinivas.pandruvada@linux.intel.com>
	 <f762f6a9-74cc-0299-0bea-6d1ab6c88e41@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 12:17 +0300, Ilpo J=C3=A4rvinen wrote:
> On Sun, 27 Jul 2025, Srinivas Pandruvada wrote:
>=20
> > In partitioned systems, the domain ID is unique in the partition
> > and a
> > package can have multiple partitions.
> >=20
> > Some user-space tools, such as turbostat, assume the domain ID is
> > unique
> > per package. These tools map CPU power domains, which are unique to
> > a
> > package. However, this approach does not work in partitioned
> > systems.
> >=20
> > There is no architectural definition of "partition" to present to
> > user
> > space.
> >=20
> > To support these tools, set the domain_id to be unique per package.
> > For
> > compute die IDs, uniqueness can be achieved using the platform info
> > cdie_mask, mirroring the behavior observed in non-partitioned
> > systems.
> >=20
> > For IO dies, which lack a direct CPU relationship, any unique
> > logical
> > ID can be assigned. Here domain IDs for IO dies are configured
> > after all
> > compute domain IDs. During the probe, keep the index of the next IO
> > domain ID after the last IO domain ID of the current partition.
> > Since
> > CPU packages are symmetric, partition information is same for all
> > packages.
> >=20
> > The Intel Speed Select driver has already implemented a similar
> > change
> > to make the domain ID unique, with compute dies listed first,
> > followed
> > by I/O dies.
> >=20

[...]

> > +	/* For non partitioned system or invalid partition number,
> > return */
>=20
> non-partitioned
>=20
Will correct that.

> > +	if (!plat_info->cdie_mask || max_dies <=3D 1 || plat_info-
> > >partition >=3D MAX_PARTITIONS)
> > +		return;
> > +
> > +	if (cluster_info->uncore_data.agent_type_mask &
> > AGENT_TYPE_CORE) {
> > +		cluster_info->uncore_data.domain_id =3D
> > cluster_info->cdie_id;
> > +		return;
> > +	}
> > +
> > +	cdie_cnt =3D fls(plat_info->cdie_mask) - ffs(plat_info-
> > >cdie_mask) + 1;
>=20
> Is it intentional that you didn't use hweight here? (unfortunately,
> I don't recall details of the cdie_mask).
>=20
Although unlikely but nothing stops of being holes in the die mask. But
for usage here it will not make difference.

> > +	guard(mutex)(&domain_lock)
> > +
> > +	if (!io_die_index_next)
> > +		io_die_index_next =3D max_dies;
> > +
> > +	if (!io_die_start[plat_info->partition]) {
> > +		io_die_start[plat_info->partition] =3D
> > io_die_index_next;
> > +		io_die_index_next +=3D (num_resource - cdie_cnt);
> > +	}
> > +
> > +	cluster_info->uncore_data.domain_id +=3D
> > (io_die_start[plat_info->partition] - cdie_cnt);
>=20
> I failed to wrap my head around what this math aims to do (mainly
> what=20
> cdie_cnt has to do with this). Can you explain (might be useful to
> have a=20
> comment if it's something particularly tricky / non-obvious)?
>=20
Seems not obvious but something like below in #if 0

#if 0
/*
Index from IO die start with in the partition

For example the current resource index 5 (cluster_info-
>uncore_data.domain_id) and compute dies end at index 3 (cdie_cnt =3D 4).
then the io only index 5 - 4 =3D 1
*/
u8 part_io_index =3D cluster_info->uncore_data.domain_id - cdie_cnt;

/* Add to the IO die start index for this partition in this package to
make unique in the package */
u8 pkg_io_index =3D io_die_start[plat_info->partition] + part_io_index;

/* Assign this to domain ID */
cluster_info->uncore_data.domain_id =3D pkg_io_index;
#endif

In one line the above whole #if block
"cluster_info->uncore_data.domain_id =3D io_die_start[plat_info-
>partition] + cluster_info->uncore_data.domain_id - cdie_cnt;"
which is
cluster_info->uncore_data.domain_id +=3D (io_die_start[plat_info-
>partition] - cdie_cnt)
}


> It could be that to make this simpler, one shouldn't assign value in=20
> uncore_probe() to .domain_id at all but pass the index here (and
> rename=20
> this function to set_domain_id()).
>=20
Can do if that is any simpler here.

Thanks,
Srinivas

> > +}
> > +
> > =C2=A0/* Callback for sysfs write for TPMI uncore data. Called under
> > mutex locks. */
> > =C2=A0static int uncore_write(struct uncore_data *data, unsigned int
> > value, enum uncore_index index)
> > =C2=A0{
> > @@ -614,6 +655,7 @@ static int uncore_probe(struct auxiliary_device
> > *auxdev, const struct auxiliary_
> > =C2=A0			cluster_info->uncore_data.cluster_id =3D j;
> > =C2=A0
> > =C2=A0			set_cdie_id(i, cluster_info, plat_info);
> > +			update_domain_id(cluster_info, plat_info,
> > num_resources);
> > =C2=A0
> > =C2=A0			cluster_info->uncore_root =3D tpmi_uncore;
> > =C2=A0
> >=20
>=20


