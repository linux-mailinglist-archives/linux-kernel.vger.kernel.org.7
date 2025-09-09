Return-Path: <linux-kernel+bounces-807259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D0B4A230
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B5154E2273
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E103019B1;
	Tue,  9 Sep 2025 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nifieo0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DF1FDA92
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399183; cv=none; b=L7jSPRKcRN+GZqsuAYkldq+6sctKt1IPHajYC4YUEaSNJvQ5Bw332G1t6R1zOomxIs/xJNaaik457wQVKzb0z1hTPobyKMEj6bQyvh1YwIeiImDiqMG8NRIbukJcGE/CJ3whHBNYhIy5PqafDLL8ApO2cQoTqwjxl5W1S0zt1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399183; c=relaxed/simple;
	bh=BXnOiw61m5hTBa0ecyNKIQGio0tRoWPyjCB7/fyXK4Y=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=SQQvObBQlEbdMdGRgNG9xPb53xnS9C8mzCS34d91biwRLAUCLiPRhrB2stlu6YiaFo/nyO3dFineUnGluJ49/N2yb3DzuLNh4HPUdBzJx/5uFmBlyWjDVJN3+2thOuzb5ce5CB2rHOJxw6C1e7jXeEIcBrxoc5GzZ5GpaRXd0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nifieo0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A2DC4CEF4;
	Tue,  9 Sep 2025 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399183;
	bh=BXnOiw61m5hTBa0ecyNKIQGio0tRoWPyjCB7/fyXK4Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=nifieo0CutDBGFinD8ptVpc2HR0WvuImQsSsTWL2b7BTYq1/Ys3PG97cUFSxZ+6/p
	 +FpIGGdvBEcxbeJu/dt35Xo8TjyMCVBkCItb0kk43o8YMbVGeEhHDkGbpCy6Ao3uQw
	 T3O2x/maYOCh1og1lxSTiB4YwZd8UlS/bD/jnfkZptq/wAtjYifbgNvluvVsIThyNT
	 HNJJEuJCRn5MRDEhx95PfOKDrCqgfvce0+3YNkQYDcg10i0TFR5wyW7TXIKb4D1pJg
	 MR3zGEFETXsDIsDSx9Fm2V5tp6tI/umixBgUI2WKcUUuCHBk5YvKgWYgBE8RyZzGrV
	 7jz9Ru6brS5Jw==
Message-ID: <06910fafbc86721d8ea360f002b9f9d5@kernel.org>
Date: Tue, 09 Sep 2025 06:26:20 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] drm/bridge: adv7511: use update latch for AVI
 infoframes
In-Reply-To: <20250903-adv7511-audio-infoframe-v1-1-05b24459b9a4@oss.qualcomm.com>
References: <20250903-adv7511-audio-infoframe-v1-1-05b24459b9a4@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 3 Sep 2025 19:21:28 +0300, Dmitry Baryshkov wrote:
> Instead of disabling and then reenabling AVI infoframe, use the
> recommended way of updating it on the fly: latch current values using
> the ADV7511_REG_INFOFRAME_UPDATE register.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

