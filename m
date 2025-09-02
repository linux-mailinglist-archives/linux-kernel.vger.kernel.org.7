Return-Path: <linux-kernel+bounces-796962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB418B40A14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D99F1BA0CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D6B324B11;
	Tue,  2 Sep 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzbY+U4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7003126DC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828976; cv=none; b=h3CnD8VjUkyCEVZFFC3qP5e349612eRggfC4WxsNpcBPtO5rGmkVoybGL6SxAEwIOe0EPsLbEsuzOK0iqgs9Iy06DktHYKAuxCuEP8yqs4Spb8MTstu8Xy5k0ZAww3BRbCwvtcSYIYYzOM/5PWOdR49cfBZ/Bm6i+rVSh6sPg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828976; c=relaxed/simple;
	bh=WD5QoiSFvm8FXaT2EJFv8YYAQhHRSKqn05M5i5Mz+EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP2jBOFFzXrjH7oUkcKo3c8tUKd/smhG/I/Namf4kgRlJISlORd4x8wArhrcDSi3lpCVS0SaEIHTmlQ64rzIPNhzX509GLiWZ58c3OhFuptdVvXXQ77g28k7YDXkeBt5FCT1qBjOQ9r9yktH4/Aq7rsm97vpxszpArD4JURFL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzbY+U4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC43C4CEED;
	Tue,  2 Sep 2025 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756828976;
	bh=WD5QoiSFvm8FXaT2EJFv8YYAQhHRSKqn05M5i5Mz+EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzbY+U4j6voVv+KrLHsqxwrKrTfsLH6REHFC5I2RRYxOH/WP8K0++Sy0O/YAykah6
	 NZKkHnJskDv2qURIqXSnFeVb5fH4CYSNotm821tH2cwfdSStUXgjBbKRYkQ6lE4z5x
	 S1E3nSuVZ8dhJsTORh3jpibyuRvDrQguAx64h883ziwg5NW8Ez+U7Sr5VfQhBFFUKU
	 ZQMkEr5WUXUYofZQu66e6uub6ETpz23h3V7Xe8cq4MJYD85+FX/VNvabx1fxRQF5uS
	 N2jDOQI6j63kxatcqHZYYPQt9pJJz2m4m/A0hpgXQRV0ejuvwHJ8YTSh1prd5K6XO2
	 J8YPQT7Hhpvbg==
Date: Tue, 2 Sep 2025 18:02:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nitin Gote <nitin.r.gote@intel.com>, 
	=?utf-8?Q?Miko=C5=82aj?= Wasiak <mikolaj.wasiak@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Replace kmalloc() + copy_from_user() with
 memdup_user()
Message-ID: <xbqfj4owftg2fwbxhj6zgajzzb2kgmgzk7dr6xcn2nudojl7sp@rulvri7zbwdf>
References: <20250902081046.35463-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902081046.35463-2-thorsten.blum@linux.dev>

Hi Thorsten,

On Tue, Sep 02, 2025 at 10:10:42AM +0200, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify set_context_image(), and to silence the following
> Coccinelle/coccicheck warning reported by memdup_user.cocci:
> 
>   WARNING opportunity for memdup_user
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

