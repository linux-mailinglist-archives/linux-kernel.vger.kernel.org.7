Return-Path: <linux-kernel+bounces-763319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE7B21322
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39364E3BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A32D3EC2;
	Mon, 11 Aug 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9bsAZhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E51F3FF8;
	Mon, 11 Aug 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933320; cv=none; b=QGJq6O3xt1rg3BrdzgfuyFHwK68C74FRKhiHY86KXZqYtnyImRr6PfdhUd62Z3jef2t/tXImaEVL++I9/9x84DKiQBp0Xma/qUZG0WVZmNFfXAyy8YUGvLH4DC5WLv0j0wUJ3F9vmMcriK7JmE2nN4xwkd1aN5yaZwM072AZppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933320; c=relaxed/simple;
	bh=ozftjYGg6KRXVk8Tffssj9tV6jZy2Xak99c5Z0Pqxbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad/gTO9I0tbxF0EhCpyiA3xarNQkJKkZZb+cK5oHaH41EYIqe2ZigOEk3EwkasaQhoG+oeXDppkm6OVzFWOCaIJD9tiUC758GYEyp6TnuYnwiZkCGqZLmaiAFwjodsXiveM6g71/Fru0KBGYxqznG+tlpMqpQMHQOgp1du6Z708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9bsAZhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A40CC4CEED;
	Mon, 11 Aug 2025 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933316;
	bh=ozftjYGg6KRXVk8Tffssj9tV6jZy2Xak99c5Z0Pqxbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9bsAZheShltLvsuWA16dHtP+DlziyeiWeIAck9cdvqTdF0NXy0NuUKGcKc/7eKPW
	 k8cBmAZ/OEFXLoFUHLS2XjEv2qEx8TKNlqfLdVmMezc+X46g5uJAOWsD3qrik7mlB4
	 +C6LsMe8ZImrHF46++fsFioDAA5lrXgS4S03HgkzHq72W0IVJKLOkAkNsQz623MGE6
	 jNH4hFoyP42GCSpCqxBDjezeIzGRc1hkh/Fdgl8z5b49eAtpo5JgFZ9nK70LFh6pSD
	 LXD7Omow46foUKFlorkWwyfAMZOw0YobeUuQYIzNl56KcfodcokOPVb9uSYfFrtKHx
	 csWN9IrDfkEsA==
Date: Mon, 11 Aug 2025 12:28:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: Drop obsolete cavium-thunder2.txt
Message-ID: <175493331520.3842001.17150965831517887163.robh@kernel.org>
References: <20250806212812.1634740-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806212812.1634740-1-robh@kernel.org>


On Wed, 06 Aug 2025 16:28:11 -0500, Rob Herring (Arm) wrote:
> The binding is already converted to schema and is located in
> Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 8 --------
>  MAINTAINERS                                               | 2 +-
>  2 files changed, 1 insertion(+), 9 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
> 

Applied, thanks!


