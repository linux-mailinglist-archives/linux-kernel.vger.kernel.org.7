Return-Path: <linux-kernel+bounces-838790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43458BB0288
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5362A31EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA272C3242;
	Wed,  1 Oct 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMvQo1k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939ED2C3261;
	Wed,  1 Oct 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318025; cv=none; b=abOdvJJu/yQz5VdC2rlaD2/zClxFybztkprjqUFOsEZnP7TUdY4ZRhH8lezjArdDtE3zWPNlT61JK0a1oiakayGetzZzKi9mvsIgO9WGcLZvGizUi2vK90tYz7Fb3VIdrOyfw886TBW/5G2E4akaOmgqc5tDiudlCVWOA8muc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318025; c=relaxed/simple;
	bh=KTLrfs+OBSfLF4jeL4qpi7SZ73bkxAT24m74IJRu1pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0KQEfagnmK9lbu+N8krzxpR7mTWLofUiv5QGUybldsSXNVZr0GoTRUEFZYoXBmiXQL3JFJ2mYt70W8vMQg1RXStPInOfS4cBfIuzUTtYUaCw5OX7EdLryi0rO2q56EI5ULO70QhoPUWiNg7oti4MjW4HALj5v5u08FlaCuOhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMvQo1k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFF4C4AF0B;
	Wed,  1 Oct 2025 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759318025;
	bh=KTLrfs+OBSfLF4jeL4qpi7SZ73bkxAT24m74IJRu1pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMvQo1k2A8JApYUAiDclZ7v20e9ph4Ab8jnOPP0cvAidISvN0mUhgAITSgCnZk0ae
	 TyZm/pEjxIk0OpzKPsbUL/cRkeBG1bnK+mUvf29Q9TQK6zktNHQYXt3t4rbJ/6ScQ2
	 dEJrMYzhSO/opHzZi49mvjhQab3W9CMhZepY8Nq5sT+o/wb6xLphEAQI7qxgavDCDV
	 A9de9TILc/nFjv6lFDoYpDVPsCLPMynCZG1nnOBDas/lXljRvCFUQg2iZsY2vh7ULB
	 m1BUPUDWJxpbqv5jbtB6/V8Dwi8Gey1AdtM+6rjAbVxkuCtSUU76G644lTBGjJLmCv
	 XvY7au0EYi0Qg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81A5EF40066;
	Wed,  1 Oct 2025 07:27:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Oct 2025 07:27:03 -0400
X-ME-Sender: <xms:BxDdaBe06lHla2P2NiIifm_duMJU4lHlgxqeSMPM1s5-G_XGTd4ySg>
    <xme:BxDdaLIWNP99nIvY8jkXvLdm67Qz5rWvj2o84tQsaRNz5XUTg0Hy3BaOr_pe-oasy
    bMvumJbVNAOsypPkw7KPiD7Z1IflRK6nKDAmp56gc9cpfX-NUHIP3Hk>
X-ME-Received: <xmr:BxDdaAoyi4DHkt6Qfq23cOBWXKHMM_dK1fQfmCbllVVx6UrlITs_oTGcqFQ-LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhheevkedujeevgfelfedtvdetvdevgfeuhfevieehleduleefuedthffhkeehgfen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghp
    thhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrjhdrfihilh
    hlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohephihilhhunhdrgihusehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinh
    hugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:BxDdaBUjF7oyI5y5dbMCUSYxQcjqVeJwKmgIkELvyeLKVFr1392EyA>
    <xmx:BxDdaL2Aep_gwzseAllTVTq1mQ9BoM4X83N3AeSlTKEr5iQBT_1_-Q>
    <xmx:BxDdaC06NyjanhBjUg3XMKtfQ_1-68vh9RNcl20n7d-CEpeHyeEWEQ>
    <xmx:BxDdaKlS468uNuEo57mBbPL9jlUhzMWS_Y829hjnQg2CM_2RVfk7hA>
    <xmx:BxDdaDOf9ENx_KPx4lw9-gyHwEhG57QeFhmuCXvF-S-C9X4djYgyB4DC>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 07:27:02 -0400 (EDT)
Date: Wed, 1 Oct 2025 12:27:00 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/2] coco/tdx-host: Expose TDX module version
Message-ID: <4ukjpckzgbfyef7wrajivc6qzw4ycdudmqdr55rbcz6fsecv5c@yovyjdmhs4tg>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-3-chao.gao@intel.com>
 <e4041d4706fe55d3d012144680d9be33acdda19f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4041d4706fe55d3d012144680d9be33acdda19f.camel@intel.com>

On Wed, Oct 01, 2025 at 04:12:10AM +0000, Huang, Kai wrote:
> On Tue, 2025-09-30 at 19:22 -0700, Chao Gao wrote:
> > Currently these is no way to know the TDX module version from the
> 	    ^
> 	    there is
> 
> > userspace. such information is helpful for bug reporting or
> 	     ^
> 	     Such
> 
> > debugging.
> > 
> > 
> 
> [...]
> 
> > +static ssize_t version_show(struct device *dev, struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
> > +	const struct tdx_sys_info_version *ver;
> > +
> > +	if (!tdx_sysinfo)
> > +		return -ENXIO;
> > +
> > +	ver = &tdx_sysinfo->version;
> > +
> > +	return sysfs_emit(buf, "%u.%u.%02u\n", ver->major_version,
> > +					       ver->minor_version,
> > +					       ver->update_version);
> 
> Nit: not sure whether the "%u.%u.%02u" needs a comment, e.g., why the %02u
> is used for the update_version?

That's how TDX module version formatted:

https://github.com/intel/tdx-module/tags

I think it is good idea to match it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

