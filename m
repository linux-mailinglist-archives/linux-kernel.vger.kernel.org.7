Return-Path: <linux-kernel+bounces-723653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2721AFE98A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8F01C81492
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21DB1E492;
	Wed,  9 Jul 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhzqrMYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11122D7B1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066099; cv=none; b=K1MqWF0SQ2XMB55iuM201y1xjPgAfE8Hwqr8F4HbGyUZUV8KAeTL24RTIhsq6+hra/1TbjI6joovPQyQSoLEyZBYXSYG4no7KBEn/Zswd6jNjaSd7NC6kwSCQzmCigpm/BApSxQK3QztY3ajCLWYrqrT0nxo8ICElLs1jOk6xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066099; c=relaxed/simple;
	bh=9CiQYJbM4mHCAINxqqFVjLp1AFAVtras+g0R0MqykTw=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=pRBK09mSM8OjBFTKUKgX/0ndJquW5I+JfaiYfSWB6AK4OnI5tCGhBjoFSN0kgC5E+VCtGu5oqa06QacMW7L1UtyvOEPcmqMesLRpORpfmN1GEs5EvpigMx9fmxgQp+guh6IygYyMjh/2dNqRfzV+BFBVJc65syB/axOpXlnPN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhzqrMYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F5FC4CEF4;
	Wed,  9 Jul 2025 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066099;
	bh=9CiQYJbM4mHCAINxqqFVjLp1AFAVtras+g0R0MqykTw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=bhzqrMYyK3kcHzUVAlYLoU38aR60SJ95eMraK9p1rp8dkIJlcMvcw6CWU2ZzlrFXM
	 W6RnzPyvZ3Xsm7uhwPdLknbXHhqhFk4iyqUd2e+XPr1clFuZ+Jxx9hhJVFNlMEqpVn
	 dvS3c6s+GakhE6QnVknP4bDK1mGfhrTFRHgoSQ1zNzsQlo8Tdzj5tKx/yDuS03ykkw
	 w+btKYNP2aiglXwZh2KOIS256QsNEr1DkVWaA+7+Oo4XCnXbXVwl6mTogsq40HRXwN
	 RRHVOyhETgxYjUdyNIR9jouqqPofruuPSIYvI0ftDY4eGOUfIq9m3IVH6YQ2pw/hBz
	 5oscMrUcsJ5Dw==
Message-ID: <cf3e500ce80951cbade17555a3f549c6@kernel.org>
Date: Wed, 09 Jul 2025 13:01:36 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 1/6] drm/panel/visionox-g2647fb105: Use refcounted
 allocation in place of devm_kzalloc()
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-1-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-1-630902123ea1@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Jessica
 Zhang" <jessica.zhang@oss.qualcomm.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 8 Jul 2025 15:35:13 -0500, Anusha Srivatsa wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

