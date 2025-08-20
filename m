Return-Path: <linux-kernel+bounces-777875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABCB2DEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856DBA0405C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B8262815;
	Wed, 20 Aug 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO4cLoCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C6261388
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698601; cv=none; b=S/syGQBfnk56aYy0kn+PWzOBgrxiJiGo6+T1gJ0eF1KtmCd9xxD5xRhb7Yx+hTA4irboy9jNBDIlmvq6Mw7+lhrUbldi6yb6CksG1mTFO0/R7as8VvQoz8+PYqgGo0nCkLBTD68W251QI14gsrCvKZx97u9gusJFPweALZLG6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698601; c=relaxed/simple;
	bh=IccV/Q9ra7VHQK1y01z+Z3/M29farXhVNSHqvsySnjs=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=XOzf780MkHVahW/6WEqG7QllOHlsWkZrqqTqN1ahyKuklN1Ijziw4i/kSgZzyUanhMApovxm46L6X8um+do/hiEzfZvtnRccwQjlTs7ZJ51DYvPHdnvoZ/hz5x8vnsc53H6nEDO2NKd08kvaRth35e4R+h2w6L4Bw4xRoW4VSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO4cLoCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A73C4CEE7;
	Wed, 20 Aug 2025 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698601;
	bh=IccV/Q9ra7VHQK1y01z+Z3/M29farXhVNSHqvsySnjs=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=GO4cLoCjoSf0WPd0gwApMmk5skpyMxHQevzmoYwUFa/51uZiW0znA/PPk0aQccW3D
	 W/3mSnGkOg4vl9uNS2z8Alu6ZJDWhdU/jBwyZqceGtUj95QmXF419X9HzDjLhl/U6r
	 2RaIw4senGIhyenM90bsPUcczDwLKe0qLm+7cqVFxVkBBUQEvu6GCfbjPIpjTXpnaj
	 yzuuVW8B/4QfEcVB7S1cnaW+QxxZTZ3MYnIrHM8ZZ4pZneCIzht9ZbfX7htn0zcb/B
	 Gy4RmQYl9gIZG9GgKq1bPpiIGqkuWlzpcgcScMWEa2RS/FTQED+eS0VOm7bz6G4cFN
	 qZI12tW0TcSWQ==
Message-ID: <48178acdbc14a3a73ab2e04a6ab7346b@kernel.org>
Date: Wed, 20 Aug 2025 14:03:18 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Xiaolei Wang" <xiaolei.wang@windriver.com>
Subject: Re: [PATCH] drm/tests: modeset: Add drm connector
 atomic_[duplicate/destroy]_state
In-Reply-To: <20250811063403.98739-1-xiaolei.wang@windriver.com>
References: <20250811063403.98739-1-xiaolei.wang@windriver.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, jani.nikula@intel.com, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, ville.syrjala@linux.intel.com, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 11 Aug 2025 14:34:03 +0800, Xiaolei Wang wrote:
> Commit 66671944e176 ("drm/tests: helpers: Add atomic helpers")
> added the atomic state path, so adding the drm connector
> atomic_[duplicate/destroy]_state is also necessary.
>=20
> WARNING: CPU: 0 PID: 96 at drivers/gpu/drm/drm_connector.c:234 drm_connec=
tor_init_only+0x934/0xee0
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

