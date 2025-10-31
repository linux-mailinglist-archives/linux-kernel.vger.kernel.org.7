Return-Path: <linux-kernel+bounces-879350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A15C22E83
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2530834E05A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31790258EE0;
	Fri, 31 Oct 2025 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rphwQvhk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B45695;
	Fri, 31 Oct 2025 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875085; cv=none; b=R8E7fcy1hlesNIZS8g+rxi5sz7UY+C4VSBTIK3Mz0NoT0CwIUe2FZHFMLikIFFh+3wgePN8+3e6tzYYG5FxdD+qiFWwZUk3mpsCLVwBnRRuy0RAaEH9Tkhr00E6xIFq5Fx5m2RZHsfPk5DL47OJDr3d5cqgVyOM4eWT6Cj/KXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875085; c=relaxed/simple;
	bh=gZPdBg+cvU3r4Ij7rk3el37Hed8Mkm7gHzeBdSyqFAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m040bUX4y8qNFKjyXOz1twLib6mmNBdelZwna6PrHX6vZ8SrA05p2fg7ildkxP0T4Pun7in2ulVd82CO65JN0gePYjyoM5LDz6xL687c7ZCSl/4N6XDawSQgscnJYKS6/hHCl6qIwOFk695IwZYZ/RNsHJ8mgvSIoK6D0BZABx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rphwQvhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A292C4CEFD;
	Fri, 31 Oct 2025 01:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761875085;
	bh=gZPdBg+cvU3r4Ij7rk3el37Hed8Mkm7gHzeBdSyqFAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rphwQvhk1X00y2eGkPQdJN/wS5Ia9Q+bYlgutHPYa6KFKQl32+tj4m8On/9MoYhkf
	 3RPq3QTFOIymujOr2BbhldITde4QartYjRQ5ypKfncQkk50uHt98nnL1WPIJ/RQbiB
	 57g5EnDt0GCi6KO8Pj+31OHDZsBo7eZjhaBOvcfGJ+eX1+d9Fc4+ZhvaKgtQl9U9FP
	 dQv0GVsrhKZfWao0HnJJQ+HRy/nKNzsJbwIgxRfvLAOOiae/wabBPkbTMrUMjxz7Rh
	 +WKQe3X7GH/dqOi9MCFw1/Wz++q34+QpoJppDpm2QUpsuGz0+K1ZJOJ6d0b91Daf6B
	 gAL170STpxK0Q==
Date: Fri, 31 Oct 2025 01:44:42 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Brady Norander <bradynorander@gmail.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_lightbar: Check if ec
 supports suspend commands
Message-ID: <aQQUirAugpRHYJ_H@google.com>
References: <20251030195910.8625-2-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030195910.8625-2-bradynorander@gmail.com>

On Thu, Oct 30, 2025 at 03:59:11PM -0400, Brady Norander wrote:
> The Chromebook Pixel 2013 (Link)'s ec does not support the lightbar manual suspend commands.
> As a result, attempting to suspend the device fails and prints the following error:
> 
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: dpm_run_callback(): platform_pm_suspend returns -22
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: failed to suspend: error -22
>     PM: Some devices failed to suspend, or early wake event detected
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec_lightbar: Check if ec supports suspend commands
      commit: c862381bd03ad4d999e0f1b3f8d1119ed7aa2e96

Thanks!

