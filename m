Return-Path: <linux-kernel+bounces-839802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC2BB2726
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 05:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEA13AB6FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377A2641F9;
	Thu,  2 Oct 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZtgHK7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329322C0260;
	Thu,  2 Oct 2025 03:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759376271; cv=none; b=GlzLXWRL0DJOiJ9Fk18yC+3yrEZXMg/mFp9pSpvCBbIDWpCcPnmHWKIcCMRLXUh9IslPrabTqS8EpCqpD/wL9FRbtHmXPBPoi8YwzTEDePpr+Ftjg8uFU1ZCLM6vgbhahVWMxkFhGXcm52zpttlV22Br2GgN+9zGWNVVnkKJO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759376271; c=relaxed/simple;
	bh=5KafbAB7/NJXwoTixCHSHk43VoeUSel+4sYcOzmnuwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGMcvdHxToM204m4LvvSXN19AeaoyVEgDiuzzhPAvraPW7d7GnddseP7zAYlRTSd3FPP4NX0qNMlKhwOQXZs+1F36whgP7+DfL3StQgr1dkwa6oag4rTQkItMA9wBEOdZHVyAEmKt5+qId3WhcY/xAErOVdED3yUCZUSHefQmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZtgHK7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B69C4CEF9;
	Thu,  2 Oct 2025 03:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759376270;
	bh=5KafbAB7/NJXwoTixCHSHk43VoeUSel+4sYcOzmnuwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZtgHK7xZH4wEbt8+g2vs/Gwxt3MXurqW83BM26iTzuxi2Osb/Ufl5Il9gw0odhrE
	 1VtqiraAqUgDTAab6U/eak/zzZON3m54XCjqmLgrXNz3cnphQsu7TfCuUxvZhEEfWN
	 rKxkR77p8oJQaWXTo1co0vWvl9ytBjJQHy2q0BXxsVl3uPCtltgE9E3k49Q0TQCeT/
	 22E3LPZMZJb7NMJmXj65ruDKUwZUNY9f7VeMB/98FvHe4HocNhGokVHPzIwkQWRjHn
	 6YhxqQVBWWNBfI42PqvDbwGhNZ1Kd36F12ZFpPnRSPl4pY8LYqR1frRuz2xTdbaN6t
	 t7I7Pcnf80d2A==
Date: Wed, 1 Oct 2025 22:37:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: steven.price@arm.com, devicetree@vger.kernel.org, tzimmermann@suse.de,
	marek.vasut@mailbox.org, krzk+dt@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
	liviu.dudau@arm.com, conor+dt@kernel.org,
	Rain Yang <jiyu.yang@nxp.com>, simona@ffwll.ch, airlied@gmail.co,
	boris.brezillon@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall: make mali-supply
 optional
Message-ID: <175937626733.3023972.12745078904801093915.robh@kernel.org>
References: <20250928090334.35389-1-jiyu.yang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928090334.35389-1-jiyu.yang@oss.nxp.com>


On Sun, 28 Sep 2025 17:03:33 +0800, Rain Yang wrote:
> From: Rain Yang <jiyu.yang@nxp.com>
> 
> Not all platforms require the mali-supply regulator. This change removes
> it from the required list in the binding schema, and make mali-supply
> required for rk3588 only.
> 
> Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


