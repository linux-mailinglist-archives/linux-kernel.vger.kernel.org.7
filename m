Return-Path: <linux-kernel+bounces-637985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680CAAE005
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 15:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC21BA0DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC942165EA;
	Wed,  7 May 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uatWKlfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B8278F2B;
	Wed,  7 May 2025 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623113; cv=none; b=uC4B6hLg/KehbdiKLosDfXQo3hN/nsDobNxAi2Rzw1EXU4+hSLzdZ7gRIgIP7r8I4pmuKJVBnHtkQiqlIwFfJu0GdTbWdycmwwpl62SYsO+Zv+Mr2N48tmar8TzZ8xS274g0L7EYYnFiQ40d7xtRTdoEokETPpZ7zWMN6UXx5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623113; c=relaxed/simple;
	bh=cOphO8kdIIdjDJfxtzOIl/hmgUWGRqUT9UT27a8b/EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMaDT5P3ANW+BYXivQzcr86+m0YUcN8Cyo4Y4+pN3To1aV0nfGD5uqFiIufD5O551fFQXAY+GHYxgF/gPwlLXgQN5Bstybidy4HujpVQbohu1Xzf+jv+r6Qd9mI59Bm3lGSDQELU1GZaSfUiQ2CGa7wLaI9GxQRbS7yWOAAUFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uatWKlfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA24C4CEE7;
	Wed,  7 May 2025 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623112;
	bh=cOphO8kdIIdjDJfxtzOIl/hmgUWGRqUT9UT27a8b/EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uatWKlfenxOYO4eAFxV9xnzAZqD7v38oUoRy++yzo2iZcwvmcwFUVYDPdsfw2lyZH
	 8FDJJxHGP5FVcjaZrNDHBDX6+dFGcMGi3ap85yRyVZjVspJe0MvmtoBCCSs2u2yd5D
	 f6N6Trmhb3Wpe1wfDYpvLIeulX+XS2XYOqi2HC8KD36hnSqtDz40QvPt9laljO8sF5
	 vz4F1PbarwAVh/tH/5MeYTa6xJRwNw0ksEHeLQ4W3qv9bwX6PHeljLpkOEdv29WZXF
	 RUxPX1XvuB0Yne8z8ZWe4EwKm+PvtH5KD3eQsrhFDcPlZj5g4AIQ69B85Itj1kLUYB
	 ilD7NjcAbOkjw==
Date: Wed, 7 May 2025 15:05:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>, 
	Gustavo Sousa <gustavo.sousa@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Gnattu OC <gnattuoc@me.com>, Nitin Gote <nitin.r.gote@intel.com>, 
	Ranu Maurya <ranu.maurya@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Angus Chen <angus.chen@intel.com>, Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>, 
	Yu Jiaoliang <yujiaoliang@vivo.com>, Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Remove const from struct i915_wa list
 allocation
Message-ID: <yafhn4afqcwki3mbcozixqa2xqcd5d7crbn6guyb5zlxt3z7h6@riboytoxpcp4>
References: <20250426061357.work.749-kees@kernel.org>
 <874iy8y0nz.fsf@intel.com>
 <202504301356.CB1EEC719@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504301356.CB1EEC719@keescook>

Hi,

On Wed, Apr 30, 2025 at 01:56:51PM -0700, Kees Cook wrote:
> On Mon, Apr 28, 2025 at 02:40:16PM +0300, Jani Nikula wrote:
> > On Fri, 25 Apr 2025, Kees Cook <kees@kernel.org> wrote:
> > > In preparation for making the kmalloc family of allocators type aware,
> > > we need to make sure that the returned type from the allocation matches
> > > the type of the variable being assigned. (Before, the allocator would
> > > always return "void *", which can be implicitly cast to any pointer type.)
> > >
> > > The assigned type is "struct i915_wa *". The returned type, while
> > > technically matching, will be const qualified. As there is no general
> > > way to remove const qualifiers, adjust the allocation type to match
> > > the assignment.
> > >
> > > Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

...

> > for merging via whichever tree you find best; please let us know if you
> > want us to pick this up via drm-intel.
> 
> I was figuring each subsystem would want these individually, so please
> take this via drm-intel. (Or I can take it if you'd rather not.)

Because I don't see this patch applied anywhere, and, given the
file changed, I am merging it in drm-intel-gt-next.

Andi

