Return-Path: <linux-kernel+bounces-720386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70059AFBAEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43526188914E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45538264A7C;
	Mon,  7 Jul 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6REVKvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93004262FF8;
	Mon,  7 Jul 2025 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913718; cv=none; b=Y/zlLl4T13uM7YO27bMnb/adTZQeo8KOYzghHd/XM9qEeraLxkmEmp0EgBsGZoLWaq26mKG428rWqWQQg52AuclZD8HmzlrVIkW7lRgAdGbjV6PF7rmpiI1UhOR85DkMtJgJq+kNyVsuQkMWpr+jZGJjlfoGyXCsEx28xZJ0/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913718; c=relaxed/simple;
	bh=VyGs5PKx52yoiBVtgnovPQ07XxMfBUWsD+MHEUA48vU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=B765s+abcZ91zUvEbjUsCcb4PkNhvbJi7abdIcQ5ExTtCMeQrEtkoBah79nl0dkxiHqC1A4/zqWAzA7Vw4EQ5FRFSyt9V9osYh/4j54ia0ORotG1/C2HYree4+MHp8w7tMDHdFdquIhSLfBxu7O5zzwi27Evo1iKlRd9MEUElBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6REVKvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E0CC4CEE3;
	Mon,  7 Jul 2025 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913718;
	bh=VyGs5PKx52yoiBVtgnovPQ07XxMfBUWsD+MHEUA48vU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=C6REVKvtCYc7MWdRfIeluPdb/GOwgKpsiMcDFbZDmLAfD860z8iRtTy814Z/iAGPc
	 DLaJmNcZnktYDXI4S2ZKzUP/knaF8HvyRehoxUGBeSlgDFG1C89JsQJcfCrNwERkUu
	 4iwSWfm8m8ar7jE7B0MJXuaHrnD7GqDb1sxTMKkOHxSKTrcHZuiNfSJYoxx2+xIwA0
	 8thR3svEA84jQ09mrNDGbuHpbyfSx3rSrNf2yRuCbyGvHxXE3Yph58CdARkEsjCdm2
	 HO8paJBrX5C/4gEsO8Pp6vaEomFb46lPi54TBQR7VF1Mr3vwuRwGMD9CQQhueyle6b
	 uo6THNVeB8Gxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 20:41:52 +0200
Message-Id: <DB61KWU2AA5I.1UJPI77S2BSFL@kernel.org>
Subject: Re: [PATCH v4 2/7] drm/gpuvm: Kill drm_gpuva_init()
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank
 Binns" <frank.binns@imgtec.com>, "Matt Coster" <matt.coster@imgtec.com>,
 "Karol Herbst" <kherbst@redhat.com>, "Lyude Paul" <lyude@redhat.com>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, "Steven Price"
 <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Lucas De
 Marchi" <lucas.demarchi@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <asahi@lists.linux.dev>, "Asahi Lina"
 <lina@asahilina.net>
To: "Caterina Shablia" <caterina.shablia@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
 <20250707170442.1437009-3-caterina.shablia@collabora.com>
In-Reply-To: <20250707170442.1437009-3-caterina.shablia@collabora.com>

On Mon Jul 7, 2025 at 7:04 PM CEST, Caterina Shablia wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
>
> drm_gpuva_init() only has one internal user, and given we are about to
> add new optional fields, it only add maintenance burden for no real
> benefit, so let's kill the thing now.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

