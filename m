Return-Path: <linux-kernel+bounces-789968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83472B39D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62CE7B13BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FD30F944;
	Thu, 28 Aug 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6UUSVoF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194F307493;
	Thu, 28 Aug 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384821; cv=none; b=OolGtr1ZiMIKCG2Jbtj9wg7FdXmvnE+/uLRCXILxM6cCNNwBWGekwRlosUuAORFT47AtCQXmQuV5rMFu/gl/4oHdrWROnaPU/9raa1lHSG8nuvHEzJkMbNlHFxIJt+r+CuaLbrUvkf1XXG4Nygiv1U5O64UbZPLyqeh2fgqj4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384821; c=relaxed/simple;
	bh=2VmTLH+GUpJ9OuIxl1JVogVGrELPLutOGpHuVKBzArk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+084XHk6pjvTU8U6rZc6b4sOzFsthlG+C8MYlzwdESwDkKAM5oVfrUMXdoHMzX1kELTg0YKD8mOhiscwF2noAR1svy4fmF1bMxufCi/yb3m/MYXiGf9HeqoUgJQOctsy4IqT4iM0jp6h20SXoe7OceuKbUaLAbKE02E8zmDnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6UUSVoF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756384819; x=1787920819;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2VmTLH+GUpJ9OuIxl1JVogVGrELPLutOGpHuVKBzArk=;
  b=Y6UUSVoF5VmA4/pE7zZSxojleiROVDjNC0ZKag8CVhsAbEoNjQ/pRRJE
   B/+ykElTNmCcGqFhuNk97ThOUCFyJ7idqWJsOcpJZsZJzX2HU5NXTQJFT
   uadOf/ZH0c9cxDd5xjG/2fvo4wZjbsgsIf2KTqiCJPjoafEdrVZ21RANy
   ttk4oYPexJdNUOaci+dnJQ5I+fo+S0QKoMk8JBRBBkASXBV1yD+yQnKsl
   pF+rSH7y1VQ7NDLdz6r13Gvugt6TkM4tuwJmhWL7rsMl5xjclmf80o9ux
   xQi5i5JhGyFZUINsnPDpZEum+vf2Cy+GJEyqZgSY3cNeamrTOSkXOc0k2
   A==;
X-CSE-ConnectionGUID: p4PyXm5hSTCk6GccuJ2v8Q==
X-CSE-MsgGUID: PtI5XezbRuyq2ujh3qODTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="57850356"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="57850356"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:40:17 -0700
X-CSE-ConnectionGUID: usVPx47uS2y4byRhi9nU5A==
X-CSE-MsgGUID: RhTMv+oyQSaFJsHHsSXriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169350485"
Received: from puneetse-mobl.amr.corp.intel.com ([10.125.109.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:40:17 -0700
Message-ID: <f1d159766f721aa11ce4b989b91c96a89eed3eeb.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86/intel-uncore-freq: Present unique
 domain ID per package
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>
Date: Thu, 28 Aug 2025 05:40:14 -0700
In-Reply-To: <1fc59985-e56f-24dd-1015-95d4c2b8d6e7@linux.intel.com>
References: <20250825214336.410962-1-srinivas.pandruvada@linux.intel.com>
	 <1fc59985-e56f-24dd-1015-95d4c2b8d6e7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 13:36 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Aug 2025, Srinivas Pandruvada wrote:
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
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > v2:
> > - Add some comments
> > - Change update_domain_id() to set_domian_id() to set domain_id
> > instead of update
> > - cluster_info->uncore_data.domain_id +=3D * is changed to add
> > multiple steps to
> > get to this equation
> > - Handle case when only when no compute dies in partition=20
> >=20
> > =C2=A0.../uncore-frequency/uncore-frequency-tpmi.c=C2=A0 | 76
> > ++++++++++++++++++-
> > =C2=A01 file changed, 75 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency-tpmi.c b/drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-tpmi.c
> > index cb4905bad89b..a30a99048db9 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > tpmi.c
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > tpmi.c
> > @@ -369,6 +369,79 @@ static void uncore_set_agent_type(struct
> > tpmi_uncore_cluster_info *cluster_info)
> > =C2=A0	cluster_info->uncore_data.agent_type_mask =3D
> > FIELD_GET(UNCORE_AGENT_TYPES, status);
> > =C2=A0}
> > =C2=A0
> > +#define MAX_PARTITIONS	2
> > +
> > +/* IO domain ID start index for a partition */
> > +static u8 io_die_start[MAX_PARTITIONS];
> > +
> > +/* Next IO domain ID index after the current partition IO die IDs
> > */
> > +static u8 io_die_index_next;
> > +
> > +/* Lock to protect io_die_start, io_die_index_next */
> > +static DEFINE_MUTEX(domain_lock);
> > +
> > +static void set_domain_id(int id,=C2=A0 int num_resources,
> > +			=C2=A0 struct oobmsm_plat_info *plat_info,
> > +			=C2=A0 struct tpmi_uncore_cluster_info
> > *cluster_info)
> > +{
> > +	u8 part_io_index =3D 0, cdie_range, pkg_io_index, max_dies;
> > +
> > +	if (plat_info->partition >=3D MAX_PARTITIONS) {
> > +		cluster_info->uncore_data.domain_id =3D id;
> > +		return;
> > +	}
> > +
> > +	if (cluster_info->uncore_data.agent_type_mask &
> > AGENT_TYPE_CORE) {
> > +		cluster_info->uncore_data.domain_id =3D
> > cluster_info->cdie_id;
> > +		return;
> > +	}
> > +
> > +	/* Unlikely but cdie_mask may have holes, so take range */
> > +	cdie_range =3D fls(plat_info->cdie_mask) - ffs(plat_info-
> > >cdie_mask) + 1;
> > +	max_dies =3D topology_max_dies_per_package();
> > +
> > +	/*
> > +	 * If the CPU doesn't enumerate dies, then just current
> > cdie range
> > +	 * the max.
>=20
> This sound broken grammar to my non-native ear. Did you mean:
>=20
> ..., then just use current cdie range as the max.
>=20
> ?
Yes, I have swallowed "as" in my non native year!

>=20
>=20
> > +	 */
> > +	if (cdie_range > max_dies)
> > +		max_dies =3D cdie_range;
> > +
> > +	guard(mutex)(&domain_lock);
> > +
> > +	if (!io_die_index_next)
> > +		io_die_index_next =3D max_dies;
> > +
> > +	if (!io_die_start[plat_info->partition]) {
> > +		io_die_start[plat_info->partition] =3D
> > io_die_index_next;
> > +		/*
> > +		 * number of IO dies =3D num_resources - cdie_range.
> > Hence
> > +		 * next partition io_die_index_next is set after
> > IO dies
> > +		 * in the current partition.
> > +		 */
> > +		io_die_index_next +=3D (num_resources - cdie_range);
> > +	}
> > +
> > +	/*
> > +	 * Index from IO die start within the partition:
> > +	 * This is the first valid domain after the cdies. If
> > there are
> > +	 * no cdies in a partition just start from 0.
> > +	 * For example the current resource index 5 and cdies end
> > at
> > +	 * index 3 (cdie_cnt =3D 4). Then the io only index 5 - 4 =3D
> > 1.
> > +	 */
> > +	if (cdie_range)
>=20
> "start from 0" sounds a bit alarming to me as if that condition could
> happen also after starting, that is, more than once within a
> partition=20
> which would result in using part_io_index =3D 0 twice?
You are correct. This is possible to create configuration like this. I
will remove this check.

Thanks,
Srinivas

>=20
> > +		part_io_index =3D id - cdie_range;
> > +
> > +	/*
> > +	 * Add to the IO die start index for this partition in
> > this package
> > +	 * to make unique in the package.
> > +	 */
> > +	pkg_io_index =3D io_die_start[plat_info->partition] +
> > part_io_index;
> > +
> > +	/* Assign this to domain ID */
> > +	cluster_info->uncore_data.domain_id =3D pkg_io_index;
> > +}
> > +
> > =C2=A0/* Callback for sysfs read for TPMI uncore values. Called under
> > mutex locks. */
> > =C2=A0static int uncore_read(struct uncore_data *data, unsigned int
> > *value, enum uncore_index index)
> > =C2=A0{
> > @@ -605,11 +678,12 @@ static int uncore_probe(struct
> > auxiliary_device *auxdev, const struct auxiliary_
> > =C2=A0			cluster_info->uncore_data.package_id =3D
> > pkg;
> > =C2=A0			/* There are no dies like Cascade Lake */
> > =C2=A0			cluster_info->uncore_data.die_id =3D 0;
> > -			cluster_info->uncore_data.domain_id =3D i;
> > =C2=A0			cluster_info->uncore_data.cluster_id =3D j;
> > =C2=A0
> > =C2=A0			set_cdie_id(i, cluster_info, plat_info);
> > =C2=A0
> > +			set_domain_id(i, num_resources, plat_info,
> > cluster_info);
> > +
> > =C2=A0			cluster_info->uncore_root =3D tpmi_uncore;
> > =C2=A0
> > =C2=A0			if (TPMI_MINOR_VERSION(pd_info-
> > >ufs_header_ver) >=3D UNCORE_ELC_SUPPORTED_VERSION)
> >=20
>=20


