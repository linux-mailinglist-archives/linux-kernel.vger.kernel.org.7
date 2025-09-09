Return-Path: <linux-kernel+bounces-807958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E981B4AB5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31357B7CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E0321F33;
	Tue,  9 Sep 2025 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rqaep0ha"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECA3203B0;
	Tue,  9 Sep 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416267; cv=none; b=raU18kvZA2FxdRFcxXsdaLco7aTrD1QWSDTkhwtnVZUVMDrt0bBlN+JOyb/kRwXbXTjgUBHnibH1EK6wV7NfAYUWi+NZS4dLr5eQ0n9MtJopifhPML30gEMaQR4BC3xKzb0iPelcON85KHiLn1OPK5rBl7lZ75J9EyUEzf9itrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416267; c=relaxed/simple;
	bh=bOM0a0A+HB5LBofYI+3MTNno0SLEwnhQSFIL8qE1y+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAkINNSWpQOLtNMlSgzuzWSeh7mpce1fMdYGCybkzGOMm8lBM47J8vqUsMo6LgN+bbN461y2l1tTC1xgHpRyt35M3IlX7aOKKTSa9uRDsZKEZXrM8f+yXldJxRfkds9Jrl9C8hVqzALB8sOyEKEMBPGjwu38FGN6Jh/RE8dwyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rqaep0ha; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757416264; x=1788952264;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bOM0a0A+HB5LBofYI+3MTNno0SLEwnhQSFIL8qE1y+Q=;
  b=Rqaep0haG1h6esJfx3hQq7bXVXArUR/P0Zjp1GaFptq8a9+Go+kZf60O
   +MqE8f08r870Eb5mO3v4aV/IImbm183oU3gZ3E+bet4x76SqaGQduXpgY
   zCeTBXYrJMRwlZL++3z+MrvbXnv8miuMGn6PB0v+FUyfmGYxOYgMEZfWg
   gwQG5oncqzy9urSLL5QTXqg76rPWi1QmD7rbbPXETT/tqDqcMEMApWwyk
   zYOBkEBigRGdaEntZYMr9juui/1pcIPEr3eeD0FNjSsmFRoRxmKtIsEub
   vIv64PFZ2FAKPZwOUruP0Pq8Rqm6pWfwH/ikWDtfclLqqpKDWvwMoRkvR
   g==;
X-CSE-ConnectionGUID: 7BKBUH5aQ26QP2KadzocSQ==
X-CSE-MsgGUID: tIDQFZFfRhijYlgkPsIi8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62323931"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62323931"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:11:03 -0700
X-CSE-ConnectionGUID: Z7coOfXjRzyh+dC2z08F5A==
X-CSE-MsgGUID: SqhHfoc2QVKtI97PVE5nLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172936765"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.108]) ([10.245.244.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:11:00 -0700
Message-ID: <cbd5c99d2394335ac4aeb2740994ab14508e2553.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Alice Ryhl	
 <aliceryhl@google.com>, Matthew Brost <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Steven Price
 <steven.price@arm.com>, Daniel Almeida	 <daniel.almeida@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	rust-for-linux@vger.kernel.org
Date: Tue, 09 Sep 2025 13:10:59 +0200
In-Reply-To: <8078cad2-d5d3-4e20-9848-034c2a503f3d@kernel.org>
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
	 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com>
	 <20250905152505.005a610d@fedora>
	 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
	 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com>
	 <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org> <aL1u_YxOkuj1kIq6@google.com>
	 <20250908091140.44856fde@fedora> <aL6TJYRmWIkQXujj@google.com>
	 <DCNAE3CJMEJ0.JH1F0MJABXQI@kernel.org> <20250908122002.2c80dd3a@fedora>
	 <DCNDGFE7RR5Q.X3PCDW0KIX89@kernel.org> <20250908141156.3dbdea0b@fedora>
	 <7aa3f464-a3d0-47a0-b044-d8db93f45918@kernel.org>
	 <a2006f74-75bb-48ac-ac9c-0a71c8f9d510@linux.intel.com>
	 <8078cad2-d5d3-4e20-9848-034c2a503f3d@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-09 at 12:47 +0200, Danilo Krummrich wrote:
> On 9/9/25 12:39 PM, Thomas Hellstr=C3=B6m wrote:
> > On 9/8/25 14:20, Danilo Krummrich wrote:
> > > On 9/8/25 2:11 PM, Boris Brezillon wrote:
> > > > On Mon, 08 Sep 2025 13:11:32 +0200
> > > > "Danilo Krummrich" <dakr@kernel.org> wrote:
> > > > > I'm saying exactly what you say: "has to be a special unlink
> > > > > function" ->
> > > > > drm_gpuva_unlink_defer_put(). :)
> > > > I don't see how calling drm_gpuva_unlink() instead of
> > > > drm_gpuva_unlink_defer_put() would leak the vm_bo though.
> > > Initially (i.e. a few mails back), it sounded to me as if you'd
> > > propose to drop
> > > the drm_gpuva's vm_bo reference only when it is freed.
> > >=20
> > > > > No, drivers can't iterate the evict/extobj lists directly; or
> > > > > at least this is
> > > > > not intended by GPUVM's API and if drivers do so, this is
> > > > > considered peeking
> > > > > into GPUVM internals, so drivers are on their own anyways.
> > > > >=20
> > > > > Iterators, such as for_each_vm_bo_in_list() are not exposed
> > > > > to drivers.
> > > > Okay, that's a good thing. I thought Xe was doing some funky
> > > > stuff with
> > > > the list...
> > > Maybe, I don't know. If they do so, the should send patches
> > > adding the
> > > corresponding iterators and provide a rationale why drivers need
> > > to access those
> > > lists directly and why we can't provide an API that handles the
> > > overall
> > > use-case, such as drm_gpuvm_prepare_objects(), etc.
> >=20
> > We're using the drm_gpuvm_*for_each* macros in drm_gpuvm.h,
> > assuming from name
> > and docs they are driver api.
> >=20
> > Also the drm_gem_for_each_gpuvm_bo(), although this usage could
> > easily be
> > converted to a helper.
>=20
> We were talking about the extobj/evict lists, the ones you mention
> are fine of
> course. :)
>=20

Hmm. Now on closer inspection it looks like we're checking for evict
list empty, It looks like rebinding after validation may in theory
evict some bos to system memory and then we'd rerun the validation step
if the evict list was not empty.

We could of course add a helper for that or if there are better
suggestions to handle that situation, that'd be fine as well.

Thanks,
Thomas


