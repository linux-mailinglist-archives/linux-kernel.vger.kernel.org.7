Return-Path: <linux-kernel+bounces-788394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4FDB383C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB37C3D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77C352FF7;
	Wed, 27 Aug 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+DEheKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B5303C91
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301894; cv=none; b=E7d8nYQXFimOlPzOqxSE2Q/2rRi+ynFSD/7tdcXp+EmePUijoCVessLbDct/t1j/0aZT1GnPxXsZ6l33wJDh4E9VAYWOEHCSrsk8Fx+3nC2lAdqRgIvQ616jwIdpWJZW85Ae3FJa85oqF2uOQVEaWeIZjbOIgoGJgOyg715vu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301894; c=relaxed/simple;
	bh=ZvkD1iZHP8f7Zj7y83bmWIu90M9RBBdjGme4A0RgZV8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=irP7W5e2vla3QuEA7k5figAtU+BzLrk7JfqK81sweTgx2se01hBlpeTjja2xnsQ/Vt+jW89B20cRfDTvwqMVbnYoWbARHXiquIx7605yGcuBw7FwdkVTakJYq0USyYGoMZUEEl1SAtnE1al5U8zKsQgsO36j7+T3Bl9FCrwTTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+DEheKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA97C4CEEB;
	Wed, 27 Aug 2025 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756301893;
	bh=ZvkD1iZHP8f7Zj7y83bmWIu90M9RBBdjGme4A0RgZV8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Y+DEheKbmvLXnafSi+/Ba4g6nC0gywuOxSiBbJmwzQl4ja3q2CBHU86Nl0Z/dmLrG
	 gzeEdSh4b0vATLvDidVWE7K5/XKOAEmWkf2zCAeB1F+WNV1GDT4q0+2zw8TcTOAHs/
	 XL5R8PsWSw9lf8KNmS8YGR4/bkk04yzW9+WyCapH8IjU4Bi49NZpIV0VHQixE5vrH5
	 SZ0Mk42XaaunnWTwFPwqKreuMx6DqaD+0qwMVJit8qynDywQsPuriv8NSni/em+JfG
	 ErZxu/LNU4pKaERgxkWAIu3dlXKpRioCJ/4BTKgOlbte4FDMMtWwNJvVxViJNSJqEy
	 Xp30sRnrLxSsQ==
Message-ID: <56453203e188ecc563c58d6e9deedbce@kernel.org>
Date: Wed, 27 Aug 2025 13:38:10 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: adv7511: provide SPD and HDMI infoframes
In-Reply-To: <20250827-adv7511-infoframes-v1-1-f89b9690f89c@oss.qualcomm.com>
References: <20250827-adv7511-infoframes-v1-1-f89b9690f89c@oss.qualcomm.com>
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

On Wed, 27 Aug 2025 16:29:04 +0300, Dmitry Baryshkov wrote:
> ADV75xx hardware supports sending SPD InfoFrame over the HDMI link. Also
> it provides support for two generic (Spare) InfoFrames. Use those
> capabilities to be able to send SPD and HDMI Vendor-Specific Infoframes.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

