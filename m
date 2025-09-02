Return-Path: <linux-kernel+bounces-796246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61596B3FDC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182082C5014
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201A2F744C;
	Tue,  2 Sep 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0y4y5mT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1C2F548D;
	Tue,  2 Sep 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812341; cv=none; b=t3wtR7DLhwh342LgoTRXgBuz5sJGnJP61PUs4kF2GUcwO9unJ7dxZkj5EPhwMNDsTZIqjLiXrFfaYp0Ua/AJdo63uiaZIcrhsec4hY21NI9YE7P7rxCip64z/JsYnCSuuFtkdO/fEC1J76N0W6n61uPVLH+FBboECPEetRiNxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812341; c=relaxed/simple;
	bh=KgkXvq/Kwm0i59OA/L9F82jp/XH8ItOhe4rUC1nXarM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pL5PpoiO6WBr7DQFxWXLVKKvWFtPisz1ktb/oxDDkv4DJN536vqYzWclCQNpVARF1qCQxhx5ekQ9F9ulascUM0bLGkhAn2uoYehSMCun4371C4VWK7lGRo/j7hW2jXkMQRe+2qAzMU2iTmhqume6H+yv+T0rN5so5dECWh9rRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0y4y5mT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756812340; x=1788348340;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KgkXvq/Kwm0i59OA/L9F82jp/XH8ItOhe4rUC1nXarM=;
  b=m0y4y5mT9X1/J3anNIZONf3AuTYMkiWOAXTVNzekm3G7Dtxn3w9Q+zS3
   tHAg6R3vupfGNrJbDxdXXCNZGz9mxaZbT2b2ZAvXqozKNklYmh2/wNj2e
   qqdNVukuKTNnUY0RJHhFV3bPNw+gtch4Vkt2dC04aQ3nkf7V9IhWa7+Fy
   XM/hlU/akT+S3JY85fcN622ofs8ycw8y4h3n7dL3goc256N7TWG43NQIe
   30eBDaRlYJO8FOlXp7Mo3oEHZYGaEya90KOK0ueI/mX6gnj/LVn/Fsr5Z
   ubG5bFNAad2hVUamPgcqksK/CadEARxTmmYPBKGLqPpDcbnQzHfIey70V
   w==;
X-CSE-ConnectionGUID: 07pfb5KqTnqHzcJZQU7P4w==
X-CSE-MsgGUID: uti9Bm6DRaeitoW8mrdlAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59191169"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59191169"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:25:38 -0700
X-CSE-ConnectionGUID: gLaloIneSDWCu+PFy+wPpw==
X-CSE-MsgGUID: SHdFKG38T/ipttA3hiX0eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176567428"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.193])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:25:34 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, acourbot@nvidia.com,
 daniel.almeida@collabora.com
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
In-Reply-To: <20250901202850.208116-1-dakr@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250901202850.208116-1-dakr@kernel.org>
Date: Tue, 02 Sep 2025 14:25:30 +0300
Message-ID: <d27ffc705bd1ea3925084bb53ac3b0dd57e4b1e2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 01 Sep 2025, Danilo Krummrich <dakr@kernel.org> wrote:
> Multiple DRM Rust drivers (e.g. nova-core, nova-drm, Tyr, rvkms) are in
> development, with at least Nova and (soon) Tyr already upstream. Having a
> shared tree will ease and accelerate development, since all drivers can
> consume new infrastructure in the same release cycle.
>
> This includes infrastructure shared with other subsystem trees (e.g. Rust
> or driver-core). By consolidating in drm-rust, we avoid adding extra
> burden to drm-misc maintainers, e.g. dealing with cross-tree topic
> branches.
>
> The drm-misc tree is not a good fit for this stage of development, since
> its documented scope is small drivers with occasional large series.
>
> Rust drivers in development upstream, however, regularly involve large
> patch series, new infrastructure, and shared topic branches, which may
> not align well with drm-misc at this stage.
>
> The drm-rust tree may not be a permanent solution. Once the core Rust,
> DRM, and KMS infrastructure have stabilized, drivers and infrastructure
> changes are expected to transition into drm-misc or standalone driver
> trees respectively. Until then, drm-rust provides a dedicated place to
> coordinate development without disrupting existing workflows too much.
>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..1cd6597c7f1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
>  F:	Documentation/gpu/
>  F:	drivers/gpu/drm/
>  F:	drivers/gpu/vga/
> -F:	rust/kernel/drm/
>  F:	include/drm/drm
>  F:	include/linux/vga*
>  F:	include/uapi/drm/
> @@ -8096,6 +8095,16 @@ X:	drivers/gpu/drm/radeon/
>  X:	drivers/gpu/drm/tegra/
>  X:	drivers/gpu/drm/xe/
>  
> +DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +M:	Alice Ryhl <aliceryhl@google.com>
> +S:	Supported
> +W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
> +T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
> +F:	drivers/gpu/drm/nova/
> +F:	drivers/gpu/nova-core/
> +F:	rust/kernel/drm/
> +
>  DRM DRIVERS FOR ALLWINNER A10
>  M:	Maxime Ripard <mripard@kernel.org>
>  M:	Chen-Yu Tsai <wens@csie.org>
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585

-- 
Jani Nikula, Intel

