Return-Path: <linux-kernel+bounces-863343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB549BF798E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946B41888DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B8336ECD;
	Tue, 21 Oct 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EmgMJHjN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D33451B7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063011; cv=none; b=naRJVlCl91pwcpL4xPrXfidkYXHpAKUUPMH/OJgS60+PS5Z0m1ABJSYLrjYcZj3f5LOHAVb6w1fQQKD//oYFIGO/Ty2Vrlh8yUTGvj3cwcBlDMxuMEGjScUzk+w+EyRVRdHfq+aGvyq4DvbAs8IzYkqr1swWXScnTtWjcHyR3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063011; c=relaxed/simple;
	bh=BOLZET7uAD9zh+dubKf/A4hN7cOu6OCJzMG3H/wDM+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMv6lDt2jtQjLY4Ib3BSW83bFqq3NSEs9KOogMgQ+PnmN768kgqFPIezmeM97L0IG3zQc2TPeZgiT3uVl+Gcgc2wallU+Mn56euIiW8mEaX39SL7mfGOzMz6IWS8kgOH+bQr0oWV7GUmoIv3pU1VhTQrl9xeVinEXlmbGkCL4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EmgMJHjN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761063007;
	bh=BOLZET7uAD9zh+dubKf/A4hN7cOu6OCJzMG3H/wDM+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmgMJHjNFuBFEOTQ43z9I7IzqphKuFzwSymSQ1F0wsAiQiW32onhhVirZ9wwY0HyH
	 NyL6mMDtgymMZfx5KUSxBT2D28exAZe9n/8SkMzCKpsnpTdS0Rfwi28i/CwURhKzwq
	 MKDPOUit6EMsOz7bRzIRHPRGCDN6Vwep3MtvYhZXJf7Dd7YvaRFWKk7AlVdbR7yhUU
	 VKjU0jluctXIjr7cuS0mAU0tmMd2iYmPWm62y9ZMJUWcxuln50U3EDh9iVTwTGp9uu
	 43MQAcqqCRs2/53obHVlLt5I/l50XMgxAxiwiim/vbHK9XeYaig5GZqsjYmEU/gNGG
	 SpgnmrXETTThg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B1BA17E0CA3;
	Tue, 21 Oct 2025 18:10:07 +0200 (CEST)
Date: Tue, 21 Oct 2025 18:09:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven Price
 <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/panthor: Support partial unmaps of huge pages
Message-ID: <20251021180938.7a674618@fedora>
In-Reply-To: <bef0484d-8e17-477a-b4a2-f90d3204ff88@arm.com>
References: <20251019032108.3498086-1-adrian.larumbe@collabora.com>
	<bef0484d-8e17-477a-b4a2-f90d3204ff88@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Oct 2025 15:32:45 +0100
Akash Goel <akash.goel@arm.com> wrote:

> On 10/19/25 04:19, Adri=C3=A1n Larumbe wrote:
> > Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
> > behavior") did away with the treatment of partial unmaps of huge IOPTEs.
> >  =20
>=20
> Sorry have a doubt.
>=20
> Corresponding to the commit 33729a5fc0ca, can we now remove the code to=20
> pre-allocate L3 page table pages i.e. 'op_ctx->rsvd_page_tables.pages'=20
> inside panthor_vm_prepare_unmap_op_ctx() ?.

Well, not if we want to support partial unmaps of huge pages at a non-2M
boundary.

