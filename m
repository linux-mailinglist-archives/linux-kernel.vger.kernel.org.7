Return-Path: <linux-kernel+bounces-830484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECEB99CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D7819C0EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF392FF67C;
	Wed, 24 Sep 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0sflKan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE414EC46
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716488; cv=none; b=BBV43AmEuIosWD+yxpYj50bPcV9+PVRciKPyLULf3jQXv9Nn+I1l7Wo5amwoUH0WBhNGLSAPGVgSIeAVuB0Im6TxVexI2VnyBdmgoqQcmxWENDgZUPvhvu71apCmJxM4SjOzrZHpKfdQLeDO2YWO/1hhanzrwiL6E4MX6FL16EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716488; c=relaxed/simple;
	bh=cg9tYmgUiVVW1uumNXt/D1iRzUoownQi8iUjG0i70yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGoQV2qD8co58ctvvM8cRiLDc0RVQTSfWF3qX0lbBWcYSAHIY0dagZXQ9PyLkEi9R5HrbbAxQLRjb9ZYsI6OGroS1aD1GfIjmOc/Kh+fIPen3j1s7VSFF9GIDE09hAKZ19jAsYewTulnIeu6hvdcR1JswzqefPFAeCMZ+l932Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0sflKan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7235C4CEE7;
	Wed, 24 Sep 2025 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758716487;
	bh=cg9tYmgUiVVW1uumNXt/D1iRzUoownQi8iUjG0i70yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0sflKanrsVC28RO9dbNQruISzbMYiXxZzT6SBvxD5jNpox2TzFkC4kHIeE6in8b/
	 muEyjTKXRQYoK9rY8DM1CYCoVexSDOrUXF4UaQP4kO4KhK1qP6AF6YeiGSUIM2T8gB
	 Hf+spIRlBDCQrxD6QRGcP7k82pyLoq9nBqr6pV8qaRGVIorEhh8SH200WWxvkA048Y
	 InGiISMKBwuxUdw/SeWb7XhpCD5fPFQNyfgBqHv2h3Y/7bRBpdWRpPDvXnBYg9fqK7
	 4EYVd2MBrfTM01rEL+nzFhb7JhvZaYmrq72uqjMFRZpFo1n5eL3HSI48mSgu8KWi8i
	 KO/KvlXkMH4Eg==
Date: Wed, 24 Sep 2025 14:21:24 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: i915_pmu: Use sysfs_emit() instead of sprintf()
Message-ID: <wd42hb6kriwk7wlunhlei5tnbslbckdaomsmhrcjx33wta3vga@ozds23vg7ez6>
References: <20250923195051.1277855-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923195051.1277855-1-madhurkumar004@gmail.com>

Hi Madhur,

On Wed, Sep 24, 2025 at 01:20:51AM +0530, Madhur Kumar wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

