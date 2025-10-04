Return-Path: <linux-kernel+bounces-842179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DABB9297
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 00:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285963BF7B2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F2238D54;
	Sat,  4 Oct 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5IqzDYe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C81448E0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759618465; cv=none; b=Sf5/HhxUbpCVCqNIOoD9f2NrQ5R/kCn3pTR8+AfvgqssKv/L0Ddcace+XGqf9l1jxeqGy4JEy0xf5CvmA/gvRj963Ht/Wybn+P/92XVZ7iV+nmM+DAQdCJ1o5VECx9r/9wOp71UnyPFA9AMzM7DiewxVx5c/s4OgNbhepV4mh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759618465; c=relaxed/simple;
	bh=VB0qTfWUIlKPkznUy6vm8Owu7ZyEP7S0mVb0raiN/VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsKw6Ep0FoZROUR4vU0RfeXkb86UprKU88ESmPE+zReCmHVGeOPCVZZ7euDybDKOE+vByCmPLk6uGmhLKPS/ZtfFR12NFRxZzf0CLIfy3sb13bujSYMUAYDFaWsl9Ikw9KAoj7MBQLUB42bzI65O/vsFyO5fA/SzmegtBwoNrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d5IqzDYe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ujT45zKa5is3+8neivqZuFX3zu1g7WFWJ9dwConA+qY=; b=d5IqzDYe+HXRidEcWznZzwC/4f
	5kRWZwuFXUEVgtUB8JiBrYzNeMp0dHGKbOGpTGN2UYlBYMEFYuYbP2j3lwT4xYVNMYZpwnlzLCI2K
	Woh1QqOBjv5v3PXKJVbqGv72E053WYacalKFdg19OJ9in5Jt2Lq01UzCaFdLCX0UivvgrTrgUPUwM
	kNnPQZRKuKAScSTFv6BFsiqiTTe1XJZaqE2AVQZZPejK38XCxmZRvmHzradrxsVW2WwRIvxLohU0u
	I2eRM1xnKZiT8IimYKpEJLuQ0hGhXSMjje+kYwKXCoWIDtUohnBzGXH/SLeXtW/q3OS6sNCpHUkUo
	kkaA3ByQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5B8W-0000000DL0J-0gTh;
	Sat, 04 Oct 2025 22:53:56 +0000
Date: Sat, 4 Oct 2025 23:53:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?iso-8859-1?Q?Lo=EFc?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?utf-8?Q?Miko=C5=82aj?= Wasiak <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Christopher Healy <healych@amazon.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
	kernel@collabora.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 01/10] drm/shmem-helper: Add huge page fault handler
Message-ID: <aOGlgz3E3kzK1_BH@casper.infradead.org>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
 <20251004093054.21388-2-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251004093054.21388-2-loic.molinari@collabora.com>

On Sat, Oct 04, 2025 at 11:30:44AM +0200, Loïc Molinari wrote:
> -static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> +static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
> +					   unsigned int order)

From the mm side, we'd much rather you implemented ->map_pages than
->huge_fault.  It's far more flexible; for example it'll support ARM's
contpte which ->huge_fault() doesn't.


