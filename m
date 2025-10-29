Return-Path: <linux-kernel+bounces-877249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33533C1D8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881B73B3F09
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2931691D;
	Wed, 29 Oct 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hihwOsXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF52580E2;
	Wed, 29 Oct 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775665; cv=none; b=kX/sIJ6rZ4LINEFfN/vKimbJgrftN/i1E3Pk946ZW5X/If1xJKkG665Ob2p6T5TWaNASstc1ABp/WfGZY6mzx0u+k2lePgdSTyNCXEPDkdwcdQ0IMFA4TwBB3mldSnXc9N3tcYb7o4PIqQmbCeDs0WuR0mbYNHZyghXGptLNZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775665; c=relaxed/simple;
	bh=WDkOUQsc/GNM02IItNB/fO+zB61bn/RMRYCt5QAMnvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/da0YJT2RFSGQaSKFU6mBvo2f/x2hTWrX6teasPXpwmCdwO77osJTWkP9aTDa3xncorMHV06umpKvRDVghbxUOipK09mt5i5mlGKdV5+Mf4jcmzRp748hmaiPMeCASC3OZQK5y62J2nCHdGF3nA4bcAkRZSQDsLPspAclqFqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hihwOsXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5CC4CEF7;
	Wed, 29 Oct 2025 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761775665;
	bh=WDkOUQsc/GNM02IItNB/fO+zB61bn/RMRYCt5QAMnvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hihwOsXllSzaiRpSiqfqNcIgwNBnOs9CSG7YYPEBxXs9DhGh2zWxbMYpKpMwsMBdo
	 Q0gQo+Z4xhrSkFYvbuj+0Tw7EVnknX09mmeIHy8JAV0D8rAzuMsWGvRLJI5s2rE0lD
	 At068wNIE5vnhzGqsPCA+lFSvQPgKRle3fFPmsEfsMlM2pMmxxO/MBxgS/GG8If9me
	 liyr0feFzMz3NghWylYnApgI5JQo56Mm/L58El9iX+k79RBNYHzfAtZ4zFO6xGqRvJ
	 UWER+WjT+5ePoeDb0ZGOweKMiN8raX6yyHt9h9DkgJy31PM+geU1K1aEVjc5xzVV6P
	 gAMuYVqjIxJ+w==
Date: Wed, 29 Oct 2025 17:07:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	Matt Coster <matt.coster@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>
Subject: Re: [PATCH] dt-bindings: gpu: img,powervr-rogue: Drop duplicate
 newline
Message-ID: <176177565555.3093261.18405131754587729535.robh@kernel.org>
References: <20251029194210.129326-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029194210.129326-1-marek.vasut+renesas@mailbox.org>


On Wed, 29 Oct 2025 20:42:02 +0100, Marek Vasut wrote:
> Fix the following DT schema check warning:
> 
> ./Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml:103:1: [warning] too many blank lines (2 > 1) (empty-lines)
> 
> One newline is enough. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Frank Binns <frank.binns@imgtec.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Matt Coster <matt.coster@imgtec.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


