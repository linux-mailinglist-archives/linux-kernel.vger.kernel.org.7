Return-Path: <linux-kernel+bounces-838846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0CBB0439
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837EC3B886F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58019DF4A;
	Wed,  1 Oct 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDaXI9bS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD517332C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320040; cv=none; b=MGr1J3Vp7n++BlVCtb5gHsTOVkM9KN3RFPUmK/jQVpd53d0DyC2Oabcx730G6cKZlAT9id73us6xVr59MzRlvzisIehpCdMWxpogqMJ+HyW5eFjE6ERq6BPAt0b8Rz2qT8MG5ahNVNNKbtx6aZKApEIK0qX8p37MIJF738t6sSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320040; c=relaxed/simple;
	bh=dRQcB8GLQBycqfRcHZl9UDpBlWs1DGUahFyZdAVFz2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMkLALhhcM4k/ue+j1si82X1ZVGV+Emy7DBD5fcTcXgP2IXeadP2OLIMEzEXVKjkHUfcSeKpWbbdjPIgafSpYYRDC7wY/RYPCPvqQUciTLWukcQbRNYJPeXxAEjvBa+FapVhEULxCus4gp6/qTx3hjqSa+mvI1IRtzmxXB6m5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDaXI9bS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759320038; x=1790856038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dRQcB8GLQBycqfRcHZl9UDpBlWs1DGUahFyZdAVFz2A=;
  b=nDaXI9bSAjiMzgjyFtuORoZQSjeXX7br2SovQ8/UE1gObQBxvLeh7QtN
   B9vi6G75IKBmB2kzXtbSLds+JH3xC7NH1SuaOd3wgniBeEjThwcssu4lZ
   FovAQ6bajMbyMARLnDPaSOOWVXi+l5Ifq2woDYZ6B8HAvizOi6zvmKGnI
   zLJmXAfASF80a3bz0IA/z32zpNuvxY+E5pAVL8YreKTWr8zBD0PZcUQA2
   EY5LmS4j6GRam4fXceQkskApGA6unqxcu+HR4AdP2361Z0Ft0fF3IEEfM
   meolNJF3sJrnpX4SZFo/VIVoyDSh4XF9IpIEW6cXDnjtgU0igAyIyvXbT
   g==;
X-CSE-ConnectionGUID: FLgBIt+iQkWJJb+CH/8yWg==
X-CSE-MsgGUID: cglZwH6pRqCWEwrevgCYXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65444691"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="65444691"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 05:00:38 -0700
X-CSE-ConnectionGUID: 17nQnyBlTUq5qFlD33DdIg==
X-CSE-MsgGUID: +AK7a2HgSZ+gn/1JPQrtxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178575408"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.98])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 05:00:32 -0700
Date: Wed, 1 Oct 2025 14:00:29 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: =?utf-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	simona@ffwll.ch, andi.shyti@linux.intel.com,
	ville.syrjala@linux.intel.com, nitin.r.gote@intel.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 eb_release_vmas
Message-ID: <aN0X3ck-egLMn_Xy@ashyti-mobl2.lan>
References: <CAGfirffPy5biFVLtSNEW60UCXa6_=-=NrQbU7iLQ8+BXnFQ=1A@mail.gmail.com>
 <175922381867.30706.10351894191632562572@jlahtine-mobl>
 <CAGfirfdDe879wFzABVZkTV7grEimpnc0XrrKpj2SX1w_TLtgNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGfirfdDe879wFzABVZkTV7grEimpnc0XrrKpj2SX1w_TLtgNg@mail.gmail.com>

On Wed, Oct 01, 2025 at 12:14:41AM +0900, 김강민 wrote:
> Ok, I will do it.

when you do, can you please paste the link here?

Thanks,
Andi

> Best Regards,
> GangMin Kim.
> 
> 2025년 9월 30일 (화) 오후 6:17, Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>님이 작성:
> >
> > Hi,
> >
> > Can you please open a bug as per the instructions in:
> >
> > https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
> >
> > Thanks in advance!
> >
> > Regards, Joonas

