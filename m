Return-Path: <linux-kernel+bounces-706309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A28AEB4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D978B1C41567
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876CA262D14;
	Fri, 27 Jun 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ehkXgSfD"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4A264A83
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020313; cv=none; b=jBhtyvs1WLG2HVYDNIvUZMUmtAR6iFDobmr2JlYNjr/oAuEpUaMTUlN9qUJXZ5Y+uzmXo2hjx7HETDFqqd18TRVeRAtjsUpP/3mriXlmMV127q8Vj/GErZjhFe2LRIFw17oLhKvAUFA9x7joH+65QGgyBoo8kEoVjw3z9/sphu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020313; c=relaxed/simple;
	bh=UNpZ3FeVZSvkZA9sSSV65o6uo4BPpcch9WQyiYk8qns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZu144Mg0rE+qn9jLDPUkVAUUiBAFlbOKRhMlABD5c+0RvKacL4zLrGZvJ3KmZoyRRNuC6e2qCdaF73/0efpfJz06PDX9Atpr8uvCQYkhTSiQ8Zf6/AZso7kSGDsqpx1f3y0qiRyIMVcoLSaGCTfKkFVbHxNkRD0jS9OdViDdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ehkXgSfD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Pdto
	B2fLiH/LE1HGtoWY8dhCiyMSGf1v1rk5ANx6UNI=; b=ehkXgSfDFbX/XztMuoLY
	DZ+8o4l/H02gt+DX7n3Jl79ucniJUM/zn0R4twBf0u4flV7sJQoWdqhEVGIn6pBZ
	FmzRJDqKY49W5Ekg6j+hp9j7X8tjQtRPA9M9H+JNeGP0qLPhxrTYrQMo1ODZPYD8
	of2hjTMS48NyryQjfV08k+vwrYALpCmrELjC5fzvLETGNoUbJx2yOPSnRCreY+FS
	IOpUnwuKy9X4pASX7a8+Z362jX7d5FnnTeT1IJAYtxVH1hQOUdS8SzJwrV4kYlHt
	LK61ShKKF5avS5zkEhz9a/fxVRZk/pc4UMUSCU/z7M+jvyuFnd3+jhoC+wp6Wyte
	oQ==
Received: (qmail 1426905 invoked from network); 27 Jun 2025 12:31:48 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jun 2025 12:31:48 +0200
X-UD-Smtp-Session: l3s3148p1@LvVvL4s4KJMgAwDPXzuUAOCQSK0rM+sw
Date: Fri, 27 Jun 2025 12:31:47 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers: i2c: Geode ACCESS.bus depends on HAS_IOPORT
Message-ID: <aF5zE6PC5SO0nacS@shikoro>
References: <20250606075651.10883-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606075651.10883-2-johannes@sipsolutions.net>

On Fri, Jun 06, 2025 at 09:56:52AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> It already depends on X86_32, but that's also set for ARCH=um.
> Recent changes made UML no longer have IO port access since
> it's not needed, but this driver uses it. Build it only for
> HAS_IOPORT. This is pretty much the same as depending on X86,
> but on the off-chance that HAS_IOPORT will ever be optional
> on x86 HAS_IOPORT is the real prerequisite.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Applied to for-current, thanks!


