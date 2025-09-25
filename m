Return-Path: <linux-kernel+bounces-833413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D55BA1E26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B453B7D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2D28E579;
	Thu, 25 Sep 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtNme6bA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1376944F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840392; cv=none; b=EagYlkU4q+613bWRMKjbZHLzHQAlMxCvSyTxCpPMuaBUNPBpGYInSJI4oKsWQO2y+nTkH/v3grL/O0Np7Z0K50uFr1ZphFLbtZYfEXLjm276XqL71NF3JsxVoEONsWfflRQ/o+GbNKtLtZlK9qT3lB+zRctwsB/IT/DjOEG/ecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840392; c=relaxed/simple;
	bh=t2DsUEPm6qWKRIYXsk51iv6HWgPNGA/4bnVm6JkTUTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIiCyzG4+Oh1SWHec4XyCYbOsQ6aXNPXDYIwWy2FrsmzF7BONKgbw997zAJMzjn4ApyrcKfKHaQe0XBS+q8X3Gu4d/KoW2UMvysPdQ3cwWoKoCFJRbDmE4N8AHcpBLd5nTVGwUW7TDpYXobdgv3Ywht/a9PkdLp2CpYehOiVDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtNme6bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02007C4CEF0;
	Thu, 25 Sep 2025 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758840391;
	bh=t2DsUEPm6qWKRIYXsk51iv6HWgPNGA/4bnVm6JkTUTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtNme6bAqZ56DljVoyNeIFX9xfpuzXxAfvWBuYPk2rj6v4yjbt69eZiBKDpKuusFb
	 1kJxMaN+j0MWG9SFHMM41jBVEFO3yaN3FktUcQ4E8agnwnCmQtNPzX8qLYrgVhWDWP
	 wUa0IRM+oCfQld/PFMjYaI/BhxQyLKmlJOywoH6M3aMciDwdCGz6s+uV/CQ/RxwTqJ
	 cl8qnVONtxuN7T4fu7qCKy4nIWvCqnDy/KidHWne+5iECjmjK+X4uoMFmQg6GqMTqF
	 dPapGfb6LF4I4vPdmZr2kbTs6cyq09wBw0QSoatCmVUTsRnHBDCszfwhLgm3PdtTGB
	 hAIknYjcy4gPA==
Date: Fri, 26 Sep 2025 00:46:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: i915_pmu: Use sysfs_emit() instead of sprintf()
Message-ID: <wg5yvklahbnicpywephsnqaktzuqji2hkekaeztsrtsvlta3fe@emjicnigcmpo>
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

merged to drm-intel-next.

Thank you,
Andi

