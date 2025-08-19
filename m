Return-Path: <linux-kernel+bounces-775354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D743B2BE48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21490162FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53D31CA65;
	Tue, 19 Aug 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbgofNDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6431CA4B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597553; cv=none; b=r7O+la2JY8HO1rapy/LIRI+iNqyYqO3zmNfl0DeztjPmfV8YWhdKwJVz+OECxQ5cWrsEjZeSePQ6hKFxEc4Jb97zR2CkW7MUoxk4SchOiV4F9HdCFuvwYyY3lUoC3FpvAKhGFzyUD9ZYPPfFEuXNnRXme7IJlTZ1bLnKf7Cpb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597553; c=relaxed/simple;
	bh=B53JZrnbg07EaqUFAyDTA9Cd8NUtD1jEcjDjdWc+x/Y=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=jGjrOerODNxzo6Xpzvzn5qvBfIUPpagaE99RA7ybrbb73rZGuZfmoboOEH77bBUyQnS43Nigs4Xfva8komQxFtBYztFWIHtbWvjHQlnlKFEDsgtQstdl5UjprvjMfffJDyl21rWWR0sJ8BkzudAiFScIECuvJ32mK6Q4i2g4ArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbgofNDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8979FC4CEF1;
	Tue, 19 Aug 2025 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755597553;
	bh=B53JZrnbg07EaqUFAyDTA9Cd8NUtD1jEcjDjdWc+x/Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=nbgofNDnIY2ixa6L9P8AMMAB2AJ103lOijag6QBikJnZYhJOrdWMuvaqZWQTkhVIN
	 8+04hCOdNyonn01NJ2S5/UBiwS5OBX+Uk273bPwp6zOH3vfLuSlw+z/yxlJC3t/Hqy
	 wR9iit25mXmHTHVCqMhwt2H42d/BHvT2OVrWlVmoIOWQMuEmpVGfujeEozZDB54myP
	 cdZ80qjPDSACpYz4Obs0UOAO/gUQx6XG96zqL2i7kXbQAmTKpmqhWSTp2In57BzGHg
	 9FUOGTZHedcOchdfccH3vSqMgn6AQD4ISsnRZ3eLh1JHrPV3i+NoGVz9jJ+vghv/Se
	 b2EZ6lZahCahA==
Message-ID: <a152e2be0a9bc57dff07616dda2e3d34@kernel.org>
Date: Tue, 19 Aug 2025 09:59:09 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v7 1/3] drm/debugfs: bridges_show: show refcount
In-Reply-To: <20250819-drm-bridge-debugfs-removed-v7-1-970702579978@bootlin.com>
References: <20250819-drm-bridge-debugfs-removed-v7-1-970702579978@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 19 Aug 2025 11:42:10 +0200, Luca Ceresoli wrote:
> Now that bridges are refcounted, exposing the refcount in debugfs can be
> useful.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

