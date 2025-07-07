Return-Path: <linux-kernel+bounces-720413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B84AFBB3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A781AA2769
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3242265606;
	Mon,  7 Jul 2025 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0HnID7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D02641F8;
	Mon,  7 Jul 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914988; cv=none; b=Xi5gR6qfa4QU6/0SXPayHOtOk6k1WkutL07aO9KMEAPlrs5rLOXXJKfsln6Z3lRi62Y1gwzA1Eqtb1wuXr4HqMJ9rgFzF9O9+rn6d2o23f5Cl6yzofSQnX3hLrBWJqZr08CkQXuNhqa+gM2get2QqhHqLkcg7FH+nSc5P+EpT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914988; c=relaxed/simple;
	bh=6bFDsbEUVBNzSR9ajF+BKbCGB9T9fVPb634qXfqT65Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OP9ibimz2eoeY2MeO3pMFB37tMW2rwyULLl7GJZW1eI8UL9Y0FDAR6HIg2vbERxXIE1CStkox45sFAEgCX2Wq8YhL7/zwtz6svQWVFs7/FCjm0DnuYay+o8vdL5YJSj57GnqP/p7WfFKZtQxDtkbjMUrSu5SbzUusioHtp6TyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0HnID7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F89FC4CEE3;
	Mon,  7 Jul 2025 19:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751914987;
	bh=6bFDsbEUVBNzSR9ajF+BKbCGB9T9fVPb634qXfqT65Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=o0HnID7VenAgB8df0unUlsTSqTADzG9iKb7fMipe0ymMOq8PS9VmcbicQ4pOVl7xu
	 w2Wsvs8Y2GcVdeet/2FuIklLkB2F92fNph6k8eNx3I0Okc/M8f1D26iB0m9Ro88uGY
	 36ESOJkxn30LQA67kWMZUSbX7x+veJjqoUf9GmhES9IARNvUZtGRqwoNmkDCBQCYXz
	 znr37ofGAtliZGn5Qv5W3oKSZvWMvgE5YOfYLvTmOYMFBAw5jkihxHtdNY6d+t33T/
	 yt5kyeUUMv+pDAsJ6QU5HIAeEdzf0POMNltQ1PAXEeiSJx7pD3RADOHSU5xKPO1CIb
	 4zKZHidJrmyIA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 21:03:01 +0200
Message-Id: <DB6213ZIZKDJ.3M9W9W4HX1245@kernel.org>
Subject: Re: [PATCH v4 5/7] drm/gpuvm: Add a flags field to
 drm_gpuvm_map_req/drm_gpuva_op_map
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
 <20250707170442.1437009-6-caterina.shablia@collabora.com>
In-Reply-To: <20250707170442.1437009-6-caterina.shablia@collabora.com>

On Mon Jul 7, 2025 at 7:04 PM CEST, Caterina Shablia wrote:
> From: Asahi Lina <lina@asahilina.net>
>
> drm_gpuva objects have a flags field. Currently, this can be managed by
> drivers out-of-band, without any special handling in drm_gpuvm.
>
> To be able to introduce flags that do affect the logic in the drm_gpuvm
> core, we need to plumb it through the map calls. This will allow the
> core to check the flags on map and alter the merge/split logic depending
> on the requested flags and the flags of the existing drm_gpuva ranges
> that are being split.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

