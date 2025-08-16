Return-Path: <linux-kernel+bounces-771806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F5EB28BB9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8541B65D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0F233D9E;
	Sat, 16 Aug 2025 08:11:17 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E021B918
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331876; cv=none; b=jfUSroJf6VB/v9/8TOwjG/b3VBjL+3T3zXAr8wzkzu2zcSM9JLBAlNuyoEbzAXBYcFKW2nhM8Sq+zMvFPX+wDmjI4Lb5Dvr/z+4Lh+aIvCBo4OKQL4K2szlfWkpZERW82fAGblzxJYSAoNvJqzuQ6TN0qRTiCcYU/EFsBChcR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331876; c=relaxed/simple;
	bh=1ukBIYs52+ZeauQb8QmRC59urr7wyrzkqub/q9F5gkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpUO5oDhio9XbZgTPKjr+2wfDOUoe8w+N5B8CaMm6g7lKsp5Aqdej5P5Sk815ZC+eda8XYV5aAsqrDFynCcwXnmLgB+Rp1CGGgCN17dt0QMdOQ+QH1XL2LqEC0ZvZYk7bOgKbCSJlYW/4lAblYS/AvtwvjnkkO3ln6oZMA9YFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 258BE2005BAC;
	Sat, 16 Aug 2025 10:11:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1527A2E6C8F; Sat, 16 Aug 2025 10:11:06 +0200 (CEST)
Date: Sat, 16 Aug 2025 10:11:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Avizrat, Yaron" <yaron.avizrat@intel.com>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Elbaz, Koby" <koby.elbaz@intel.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>,
	"Levi, Ilia" <ilia.levi@intel.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Change habanalabs maintainers
Message-ID: <aKA9GhFD29AJkuX0@wunner.de>
References: <20250814095556.5424-1-koby.elbaz@intel.com>
 <20250814095556.5424-2-koby.elbaz@intel.com>
 <DS0PR11MB77675D0ED3C78DF853B9A6CB8E35A@DS0PR11MB7767.namprd11.prod.outlook.com>
 <DM4PR11MB55491ACAA33DF29CEF3C67DAE935A@DM4PR11MB5549.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB55491ACAA33DF29CEF3C67DAE935A@DM4PR11MB5549.namprd11.prod.outlook.com>

On Thu, Aug 14, 2025 at 10:44:07AM +0000, Avizrat, Yaron wrote:
> I will be leaving Intel soon, Koby Elbaz & Konstantin Sinyuk will take the role of habanalabs driver maintainers.
> 
> Signed-off-by: Yaron Avizrat <yaron.avizrat@intel.com>
> Reviewed-by: Koby Elbaz <koby.elbaz@intel.com>
> Reviewed-by: Konstantin Sinyuk <konstantin.sinyuk@intel.com>

Applied to drm-misc-fixes (with the commit message wrapped to 72 chars),
thanks!

Lukas

