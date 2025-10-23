Return-Path: <linux-kernel+bounces-866840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DAC00C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D3619A6F25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8EB3016F4;
	Thu, 23 Oct 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i751N5XN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47B2DECB1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219307; cv=none; b=dn9d3um9V/r7l8I5XMHc7GgsiZRtvso+npe89iqtnKTY9WHMM2aVBWXNXrIv0UkoxuJ3ataI+psi/QLZBqdnmyHTUKbfgmueAdKXKh3iBcKZxNERgotfrQgWK025uGNg1K8rCrx32b80OvSzYYkkWMMMYNdswqH56oLzKlc5cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219307; c=relaxed/simple;
	bh=UFVCPRofApNYLXoEiB0EWJeZKw7KAl9ZbfbTyLnEy8g=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=UtTpJbjpE5zNYdAyP4ghRIB6VLwRT8zStVwDoiZq4CXGOv6QPeNBEKQej0SorhqqkkYQLE45tQXQuQJsQjSQlfzq6kldCdZsZTUyEtzUC1ceS9VjPRdyhh07BavX3BnwFTzNd+ibyGqTbVstCR6bDhNM/TktA1zrNe6Y7Sb9Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i751N5XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294F9C4CEE7;
	Thu, 23 Oct 2025 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761219306;
	bh=UFVCPRofApNYLXoEiB0EWJeZKw7KAl9ZbfbTyLnEy8g=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=i751N5XNkGObtoCHaZ17UaflhbXg4RHhNGF/kHWkHwUfwbZG19HR7AvW+VIH48am9
	 +mFlZvWCgMgFz7V2Cs+lQerQCJfpzmPHb6G9JUhvQ429fu9v/+wDouL5Iqm1NZSy9J
	 BQz4vVJZkhnwJGjmRfBD18P+QsGMlJSevuWsMgfY8nVb7c1pt+L7L3HLp/3bgIR+Kc
	 c23NGMvi24taknXvtLTOXCaysB+izLNWYORZxhNxuF0KieL1MJusmoHqPRrRKqZO+R
	 DIFrIpdOmOh4hePNBYtx+KV/9MOeZ00PWw2pq+aFzTFewX3BjqKomeRD9SaNQDZNpL
	 CgyWvVMwGn/pw==
Message-ID: <4dec6866040cd2f7f234e5e76879d4d5@kernel.org>
Date: Thu, 23 Oct 2025 11:35:03 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH 2/2] drm/tests: Handle EDEADLK in set_up_atomic_state()
In-Reply-To: <20251023054614.6267-2-jose.exposito89@gmail.com>
References: <20251023054614.6267-2-jose.exposito89@gmail.com>
Cc: airlied@gmail.com, dan.carpenter@linaro.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, simona@ffwll.ch, tzimmermann@suse.de, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 23 Oct 2025 07:46:06 +0200, Jos=C3=A9 Exp=C3=B3sito wrote:
> Fedora/CentOS/RHEL CI is reporting intermittent failures while running
> the drm_validate_modeset test [1]:
>=20
>     # drm_test_check_connector_changed_modeset: EXPECTATION FAILED at
>     # drivers/gpu/drm/tests/drm_atomic_state_test.c:162
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

