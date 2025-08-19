Return-Path: <linux-kernel+bounces-775560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B53B2C09C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8635C17A018
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4532BF25;
	Tue, 19 Aug 2025 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdfrPF0L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CD32A3F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603227; cv=none; b=DNwr3HeA8/G0Omdxy7eRbgOXe4eyrq/4qZ8yCPuUw1yBSORr71TQvXeUBR0DfLqUUozjsXigvZxrmUW7DasPAmo5Iq6icdHFsJiAJdh+bL1UpqUiJqy8Ed3aeBJ6bLaxG3ScFCw7NIspYmLXyos/1NeLTHLlqSPex8l697mdO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603227; c=relaxed/simple;
	bh=CIH7yJkvh3/ZYJwCY/qi2Mlqf8m99Z7mxVV0RImGheY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IA8ujib5xEV7tJpgIeUytxoxxJJh3y8jBpCGYnXqx/cT/mIQcIwJXesAkxROdTxTRvEL74yk0nR0qNlGZ61sFNXwtxERTXIFee4DmrrUebweA95ldyxUce74MKOOBRiQS5errJ+pizelP5i+QhrqH/EMoE5Z8tAnO6+Mbgs+GyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdfrPF0L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755603226; x=1787139226;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CIH7yJkvh3/ZYJwCY/qi2Mlqf8m99Z7mxVV0RImGheY=;
  b=fdfrPF0L1Hj970wtgEHqnmB2DXRcsX+1rS+PpSDmcEwL9M6LApXXuUJQ
   93xBxnStBqVvHGVwcZPKCnNjlCFPU/TtC7/dy6mpRrlpcNTPisUfCPmlI
   yrXpcSqTxMywU4LMi/NoVUYsQ9oZ9/Tina83b3Ol8nFS+7hJ1PO3gm+v+
   Aunm9+4TOA7cLlZ2KwdQCPlAlgATNiNWElXtRly2kZhIb8eUIJWEZYr7H
   g6RNNFyW6+BvkHfbUG+8Fsp3XqeK+lB6MlnW8gHIt6B5kiAngWOOlIeAf
   Z+Ha6TFwg9voh+TK6R6QwYRCghLZAq8grB23XwAHTqNKWUWnPZsbSL0te
   Q==;
X-CSE-ConnectionGUID: QEYRHsT9Si6lynbc74LMow==
X-CSE-MsgGUID: VnSG4cOfTCSnuuDO5CC8Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61653777"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="61653777"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 04:33:45 -0700
X-CSE-ConnectionGUID: 9h5gT3AbRN+Hotu/iwO0Rw==
X-CSE-MsgGUID: pw3f4t59THSX7xndiXJpeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="191520115"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.175]) ([10.245.244.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 04:33:43 -0700
Message-ID: <e96dcfd4ce7c84a5b66ff9d5f082ea209266ce48.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] mm/mmu_notifier: Allow multiple struct
 mmu_interval_notifier passes
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
  Andrew Morton <akpm@linux-foundation.org>, Simona Vetter
 <simona.vetter@ffwll.ch>, Dave Airlie	 <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Date: Tue, 19 Aug 2025 13:33:40 +0200
In-Reply-To: <4lsv2lcd7lssyvcjvkqe4t2foubxbhuxrt2ptzee3csymz5gg3@jwrg3xow72lm>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
	 <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>
	 <20250818160726.GH599331@ziepe.ca>
	 <aKNT8GUu0r3i4Ikq@lstrano-desk.jf.intel.com>
	 <20250818163617.GI599331@ziepe.ca>
	 <aKNYUaPS0PiRk/yj@lstrano-desk.jf.intel.com>
	 <20250818164655.GJ599331@ziepe.ca>
	 <4lsv2lcd7lssyvcjvkqe4t2foubxbhuxrt2ptzee3csymz5gg3@jwrg3xow72lm>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 19:55 +1000, Alistair Popple wrote:
> On Mon, Aug 18, 2025 at 01:46:55PM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 18, 2025 at 09:44:01AM -0700, Matthew Brost wrote:
> > > On Mon, Aug 18, 2025 at 01:36:17PM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Aug 18, 2025 at 09:25:20AM -0700, Matthew Brost wrote:
> > > > > I think this choice makes sense: it allows embedding the wait
> > > > > state from
> > > > > the initial notifier call into the pass structure. Patch [6]
> > > > > shows this
> > > > > by attaching the issued TLB invalidation fences to the pass.
> > > > > Since a
> > > > > single notifier may be invoked multiple times with different
> > > > > ranges but
> > > > > the same seqno,
> > > >=20
> > > > That should be explained, but also seems to be a bit of a
> > > > different
> > > > issue..
> > > >=20
> > > > If the design is really to only have two passes and this linked
> > > > list
> > > > is about retaining state then there should not be so much
> > > > freedom to
> > > > have more passes.
> > >=20
> > > I=E2=80=99ll let Thomas weigh in on whether we really need more than =
two
> > > passes;
> > > my feeling is that two passes are likely sufficient. It=E2=80=99s als=
o
> > > worth
> > > noting that the linked list has an added benefit: the notifier
> > > tree only
> > > needs to be walked once (a small time-complexity win).
> >=20
> > You may end up keeping the linked list just with no way to add a
> > third
> > pass.
>=20
> It seems to me though that linked list still adds unnecessary
> complexity. I
> think this would all be much easier to follow if we just added two
> new callbacks
> - invalidate_start() and invalidate_end() say.

One thing that the linked list avoids, though, is traversing the
interval tree two times. It has O(n*log(n)) whereas the linked list
overhead is just O(n_2pass).

>=20
> Admitedly that would still require the linked list (or something
> similar) to
> retain the ability to hold/pass a context between the start and end
> callbacks.
> Which is bit annoying, it's a pity we need to allocate memory in a
> performance
> sensitive path to effectively pass (at least in this case) a single
> pointer. I
> can't think of any obvious solutions to that though.

One idea is for any two-pass notifier implementation to use a small
pool. That would also to some extent mitigate the risk of out-of-memory
with GFP_NOWAIT.

/Thomas


>=20
> > Jason
> >=20


