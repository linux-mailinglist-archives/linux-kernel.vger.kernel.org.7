Return-Path: <linux-kernel+bounces-782787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F3B32557
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809623BEA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347A279915;
	Fri, 22 Aug 2025 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u29cAhBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F32E413
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904447; cv=none; b=Rr7gxofiAce3mwkPT5QavSEMBKQJ556j94+1vhHtvJCdRgSQ8lKSYdPGI81AR86i5qTWDs//WsYuCNy8IeVTHDMQMkoYGYuYdUDNbgvXdVfKwQi6acGH9Sly2hC3btxnPcMe65CEv/LV3cVd6MSivbFK6RWPtPzaIrFyH8hfL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904447; c=relaxed/simple;
	bh=FW2UlUHWBGIjYX/nRcZEwXb3PwT/VeIoEnBl3k5Bj5I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=rDdE9KFo5FkBL0CfkgtJoTnm0RliWPPJFf8zOBebLzGJPkDFZSmX4dxO45UT5JqxsERr3ZPr01IhuYD9MC2TAhm0Hiv7Fqi/hQNAsyU+nJ0uTgkmrYVgjCcTEViR/Y0JJGeu2FOgAsDgaeWHQtbv8a5pKgZEvU9rwP26I2+IVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u29cAhBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D75C4CEED;
	Fri, 22 Aug 2025 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755904446;
	bh=FW2UlUHWBGIjYX/nRcZEwXb3PwT/VeIoEnBl3k5Bj5I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=u29cAhBs+icIFmHq/CrbnR4BFguZMLeFfdShAziZuWk40Jw4Ijn2FcdgD3HgfknUV
	 qaidWALIH5FlovLlKxft/O2Q1j/DG6G64PXYjjcQ0DOljfYPbMeF8vGCBeqKvJDjpR
	 IIvl/rABJs0ZAgZBSuCd9Mo9yP+kaL0k9lpmN/2neiaSLY/XvMqFREs7KZWoALup5H
	 w+P08YwTK9id1mBZyuB/jr/mJcs859WR8IMO+uFdGDPflgmZJbt/hLG4iG+cUPE8YK
	 kFgi6QCGrIxAogGtw7fgnj9r6rc2zq1D3JSsPyd/gyxXLj0PuULVYT1Hd0PFYiLq2t
	 jEkTroc8UNXfg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 01:14:03 +0200
Message-Id: <DC9C6DFLG1PE.1AWR6TCF6800W@kernel.org>
Subject: Re: [PATCH 2/3] drm/nouveau/disp: Always accept linear modifier
Cc: "Lyude Paul" <lyude@redhat.com>, "Faith Ekstrand"
 <faith.ekstrand@collabora.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
To: "James Jones" <jajones@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811220017.1337-1-jajones@nvidia.com>
 <20250811220017.1337-3-jajones@nvidia.com>
In-Reply-To: <20250811220017.1337-3-jajones@nvidia.com>

On Tue Aug 12, 2025 at 12:00 AM CEST, James Jones wrote:
> On some chipsets, which block-linear modifiers are
> supported is format-specific. However, linear
> modifiers are always be supported. The prior
> modifier filtering logic was not accounting for
> the linear case.
>
> Fixes: c586f30bf74c ("drm/nouveau/kms: Add format mod prop to base/ovly/n=
vdisp")
> Signed-off-by: James Jones <jajones@nvidia.com>

Applied to drm-misc-fixes, thanks!

