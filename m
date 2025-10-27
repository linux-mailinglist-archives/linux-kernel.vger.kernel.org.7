Return-Path: <linux-kernel+bounces-871406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76958C0D27E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F5B1898256
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A902E093B;
	Mon, 27 Oct 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aiZpBWl8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F81C6A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564712; cv=none; b=h5vKBiWi0T6Mv78izBqK3pjSEjEKgrzqSxFnkjMFGIDJPa19/JcXFzzwumLRpoW+LykTpqjULnwIktT6M2Qv69kNnNfJUvGwme10QLs9CPo/nbIC0OX8VzvnuIB0Ht/lOnqB2Jf98fGrBdsj2qZN9MLRobslJ0IAYqVwGEGxX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564712; c=relaxed/simple;
	bh=JaOev6RH5sKDkCyOnhMzD01pkFcy+37y3Uaf6kblozw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF70Owt/ec3LXLcIz/vE8XxzVKwaM3gEJRQ+IWYMtL/K3l1WopVbwl1YQdS/XmLCGHhyLBfcmOlpPldwldK42pVTn58DY+CRYPOst67GLqJxsjLzVEjE+rEBYw+kzHwuo4oQ6hwO9yZrEBlKxUBs/kD1eXa7p35SoIlYWSaQ8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aiZpBWl8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761564708;
	bh=JaOev6RH5sKDkCyOnhMzD01pkFcy+37y3Uaf6kblozw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aiZpBWl8iKR0t8FCiqI+2BWJK86Rbc0FvAjzovQyGgXA2B7Fvhz+UiyYNEagTcSkR
	 F7D0FPOfvGcLG4ppUXrEFmICHUrZ8Hw7KTuM+ySXt/o/IeF/assHegqLXJEdURA4Bp
	 y5C1pCsdylTwXOQM7S3iGUuEcULqCZHM7BE0GxAOJXPxxmN4FzoPKEX/ABlmNQAEsK
	 Mu3tsEEV6XgyGqtntPgUw9LGVf2RZOTxK04DhwFcShZDSdMvzLPK/xF0k/vqNgYmo2
	 scf7hAtu3a4vE1hxGlBhINBrJDoRVGDkfQGfRrDkrk7tjYkHbELBcMQtIN0F4sQC8z
	 jX5EG9J9Q8oKQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ECAD817E10F4;
	Mon, 27 Oct 2025 12:31:47 +0100 (CET)
Date: Mon, 27 Oct 2025 12:31:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] drm/panthor: Support GLB_REQ.STATE field for
 Mali-G1 GPUs
Message-ID: <20251027123141.089c5a97@fedora>
In-Reply-To: <6c301d19-7f80-471d-a431-8b936d7eb362@arm.com>
References: <20251024202117.3241292-1-karunika.choo@arm.com>
	<20251024202117.3241292-7-karunika.choo@arm.com>
	<20251026092717.3aae3679@fedora>
	<6c301d19-7f80-471d-a431-8b936d7eb362@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 10:43:42 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> On 26/10/2025 08:27, Boris Brezillon wrote:
> > On Fri, 24 Oct 2025 21:21:15 +0100
> > Karunika Choo <karunika.choo@arm.com> wrote:
> >   
> >> +static bool panthor_fw_has_glb_state(struct panthor_device *ptdev)
> >> +{
> >> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> >> +
> >> +	return glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0);
> >> +}  
> > 
> > It's okay for now, but if we start having more of these, we probably
> > want to automate the generation of those has_<featurex>() helpers with
> > something like:
> > 
> > #define FW_FEATURE(feat_name, major, minor)						\
> > static bool panthor_fw_has_ ## feat_name(struct panthor_device *ptdev) 			\
> > {											\
> > 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev); 	\
> > 											\
> > 	return glb_iface->control->version >= CSF_IFACE_VERSION(major, minor, 0);	\
> > }
> > 
> > Same goes for the HW features BTW.
> >   
> 
> I wonder if at that point, would a bitmask as previously proposed be a
> cleaner solution? I have a minor bone to pick with MACROs that generate
> functions as they make finding its definition unnecessarily complicated
> and obtuse. Not to mention if the conditions for a feature changes and
> is disjoint from all the others, updating the macro to handle these
> would cause additional churn that I would really hope to avoid.

Let's do without the macros for now.

