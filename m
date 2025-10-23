Return-Path: <linux-kernel+bounces-866838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB73C00CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E983AC2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B73F29AB05;
	Thu, 23 Oct 2025 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnbT5Fbl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030725785E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219289; cv=none; b=QFkmKaJlMm1pfbe5h9KkHuz5Srs9SmqLWYj6ybfpUbEC7/yqa1xqxRaM6cqoKEgbSx0t/HRUzHCLccIKWiPKT2h/6VNi6/Wom/W4M16KYvJnECSXNblgmqH1SJVocHB6MYILXs+yx3AVkYTp/kTqqouASgxbX5PZL7jpctY9z2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219289; c=relaxed/simple;
	bh=wZSFPlfJ5Wws9I4AlQE1HXuapFLuMLNmf+WneBD3X+M=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=aKXq8m3NIjvU9TxTkP+0IwY/whPHnLOJEFzGpSCTjLVAcwRJPra3KC6Zk57WUyTWdypaQWH0nsnuvjPxzrxOvvGSmFH6//HWsd/ccKxH94QB876UdDAE3vg+Qc0AeEAhbVO3mDZQZHL2R6RccwsdMqwZh8RjDG1RY4hvbD1YvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnbT5Fbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2FFC4CEE7;
	Thu, 23 Oct 2025 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761219288;
	bh=wZSFPlfJ5Wws9I4AlQE1HXuapFLuMLNmf+WneBD3X+M=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=GnbT5FblF+vK9H99mez4qb5fYxlyMnE098aehLMt0dIQS+ENW1HlEhk8B3b51CGlr
	 Cha4LKL1zNu+SkLb8NOhbfbLTyJGCpB4r0EEKf28zIUDcJnSdxVCXxbRWX2MaB1tnT
	 hrtt5Msb8eHZ5JIXidaGCK4tVdq5KGQZtF2g0JS2CwFLAbW5cGkSN7PWQfJOJn5a1Q
	 q5ExVQXpsk5VieslD1mHVGfUtG9Lr/f2qMJWIEiiMmqFlTe6u5zuVeL5zUn/4WE6nS
	 cU/enV3uIp9LGulBOs0FkfOpBLO2sxGN3NkyeBdQaZBopp0die3i3NW8174jd3pKVd
	 fRejx1GBRnu5w==
Message-ID: <adb145ba87ca8bb38c2edef1b1b275ed@kernel.org>
Date: Thu, 23 Oct 2025 11:34:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH 1/2] drm/tests: Handle EDEADLK in
 drm_test_check_valid_clones()
In-Reply-To: <20251023054614.6267-1-jose.exposito89@gmail.com>
References: <20251023054614.6267-1-jose.exposito89@gmail.com>
Cc: airlied@gmail.com, dan.carpenter@linaro.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, simona@ffwll.ch, tzimmermann@suse.de, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 23 Oct 2025 07:46:05 +0200, Jos=C3=A9 Exp=C3=B3sito wrote:
> Fedora/CentOS/RHEL CI is reporting intermittent failures while running
> the drm_test_check_valid_clones() KUnit test.
>=20
> The error log can be either [1]:
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

