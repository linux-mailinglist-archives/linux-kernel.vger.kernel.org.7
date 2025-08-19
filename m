Return-Path: <linux-kernel+bounces-775912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE0B2C661
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4CA17689A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23433EB1C;
	Tue, 19 Aug 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ipf3iXAC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC46202C2B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611711; cv=none; b=SrTto85DdBhLgsfBUZt2wF1/NoBIJJfqSAA3cZtp5v7McS7+Y1ACGunEr8ElEbZNpOB/54VtVvudag+26sqHJJ54T23iLVOnUyL0BZePjHJ0hRy0c8SLcpLhVwi+tfRoK3SNZDgX7OXtuiLWQ5s7usTW6vRbSHOt4btFRd1iP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611711; c=relaxed/simple;
	bh=rYkInfPDeD3YbZAfMy6VVIEu5RzfabMYKT/CYpyDQWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGsW+0Bg4MTO9cqsoLAk7zVfphPO9Bkd2oHO5J66J2aqzWkS5c8soBsYhciAU+SrBT0hfzMzXCcoNJtU0sNgu5A530jzcv561LWXY2ca7yvzIMSopMulCFEMTY6WMTJ+sFOgo2Z/idZaQQnRSNgHTx0sYghCEGQVyHVuC6Bz0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ipf3iXAC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=mR+LygLiM3tjzEG3sNes1cztsYd42swKHiX+HlwjBsQ=; b=Ipf3iXACMeP63TlIkUtssIENyi
	JiFG9iM5qg1r2kYffpIBJWNLk1YTfgyfzlWHkAq2wKgcPxO/FUfb6pDuiMqx3BNOSBUwYTyG2YqFG
	r9IfdJC+UcZ4Zwjna8q7ckcNYyPlr33DPGgcYN6Sew9nuLeH6VkgE5CUmxRhBjD8yTPBA9BGwv0e8
	mx8Cr1wMSW7wZMS6XeEuYDvMxSKSLwrfYC+tp4Gd4SxPgxFfCetiYoWNus5Nao8OxCFDoA33SPD/E
	ChAUWkxFsXWSkdX4ISQvmmkifEGM5Wnmof3tw7D+2GoIGgwgWp/URV1F/PjnzD9bC+2eHqKgzan04
	5YqfA4zA==;
Received: from i53875a31.versanet.de ([83.135.90.49] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uoMnr-00029R-53; Tue, 19 Aug 2025 15:55:07 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject:
 Re: [PATCH] nvmem: qnap-mcu-eeprom: swap header order to fix missing type
 definitions
Date: Tue, 19 Aug 2025 15:55:06 +0200
Message-ID: <2398168.22IY78Rhhi@diego>
In-Reply-To: <20250819111044.2714855-1-heiko@sntech.de>
References: <20250819111044.2714855-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 19. August 2025, 13:10:44 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Heiko Stuebner:
> The main header for the qnap-mcu uses types without (at the moment)
> including the necessary types.h header.
>=20
> While there is patch pending to fix that for every use:
>   https://lore.kernel.org/all/20250804130726.3180806-2-heiko@sntech.de/
> this does not help the nvmem driver right now.
>=20
> Swapping the order of module.h and qnap-mcu.h headers does fix the
> problem locally until the main change gets merged though.
>=20
> Fixes: 117c3f3014a9 ("nvmem: add driver for the eeprom in qnap-mcu contro=
llers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508191205.ROvIX7IA-lkp@i=
ntel.com/
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

The offending patch has been removed, so this patch is not necessary anymor=
e.


Heiko



