Return-Path: <linux-kernel+bounces-842159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC11BB91C8
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DE01899862
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3F284B42;
	Sat,  4 Oct 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rKdqfEqL"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643F1A4F3C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759610061; cv=none; b=ZlthAjKVnDpb6qsxs1+UbjON+6CKvuU2FWj3Nw3OClKFYu1NNPfvQBrOWuFfk/ws9JP1IR2Nlco0V4L/wjXwdS1e7wSKYaLzcpbyll1OGtaCJJ1j5OQug3U5H37gs0XopxVVpmvZwSFBmdpEybPWyC7IFhenpUkDvPhrACrD6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759610061; c=relaxed/simple;
	bh=47n+RK07txufgmOe5WeymYW/s2IktzWPba2hQ7/FQDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ2S0I4uUtIOtf/312c+PdJx0PmhW3+Jq06vXitT4Lo8gGdXqfQfHiEGm6OGlv6WmAQel2agLForEsaP0Z5covNY8LP4V1YzPY07wrrb5nxjcNU/VlQvtG+XwLasvW/mvtrVPy7QPCIOHPR8TNBaDWUIk2Vo3Cp0SqldTxdF7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rKdqfEqL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ZggFdLpD3/YFEeibxFg+TFexkOTsM2GqMFAjK3D+I0c=; b=rKdqfEqL1u6x8IASpFEV80tLr2
	Ieb7Fe3/0iosGk8pIjvFqVQyNyLnXwbCSsC/BqzkHy1YIY/RZ3NRqeP5hLHGKrm5BA5iMVR37JsyY
	mMIKPcUjQ5+f1RTJww28Zz0jCRqmvFwNoE++LDMcNl8nJuqcF9uL5ejyvTVyqmca7DOAkSRg4rvXm
	sOt+R2bgDmNoPSAa8dBv1MVRJAd6kIFEJqZhqgG/RfKhKmAoAr7Kf9NkZx/V4QH6xbMWMw5EWkc0E
	mpfGyvSSK4PT3q/eEZVVr+393aflnTMd00+P2ge797A0PRSl3VC5JtLgyo22i7prZRpo84NQRVRv7
	9gTqWDcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v58x8-0000000F0jq-1sVy;
	Sat, 04 Oct 2025 20:34:02 +0000
Date: Sat, 4 Oct 2025 21:34:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
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
	=?utf-8?Q?Miko=C5=82aj?= Wasiak <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Christopher Healy <healych@amazon.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
	kernel@collabora.com
Subject: Re: [PATCH v3 03/10] drm/gem: Add huge tmpfs mount point helper
Message-ID: <20251004203402.GC2441659@ZenIV>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
 <20251004093054.21388-4-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251004093054.21388-4-loic.molinari@collabora.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 04, 2025 at 11:30:46AM +0200, Loïc Molinari wrote:

> +static int drm_gem_add_fc_param(struct fs_context *fc, const char *key,
> +				const char *value)
> +{
> +	return vfs_parse_fs_string(fc, key, value, strlen(value));
> +}

Documentation/filesystems/porting.rst:
 
**mandatory**
  
Calling conventions for vfs_parse_fs_string() have changed; it does *not*
take length anymore (value ? strlen(value) : 0 is used).  If you want
a different length, use
   
	vfs_parse_fs_qstr(fc, key, &QSTR_LEN(value, len))
	    
instead.

IOW, your drm_gem_add_fc_param(fc, key, value) is an exact equivalent
of vfs_parse_fs_string(fc, key, value) now.

