Return-Path: <linux-kernel+bounces-870249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2EBC0A487
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C6814E5BDD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C818254AFF;
	Sun, 26 Oct 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RE6XywIx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9693223DF9
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466406; cv=none; b=teRJKbcSugM2wc6OVGlSUyzIKwdWH+uJ4W94TQEUTLfGVhwplwtfnWS2hR1mIDJIKJqya7VzN4xps1Iwy6eEsKsjlio7cRzO1cRYVlbPIyzXsjA/HekHV3JgU4e7kn6trFwNnbHPhgcAGWOTUK61S/juq5AhKGJo6lkyYEGEqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466406; c=relaxed/simple;
	bh=od6ChUUR+8/ACM0Q9cUVA9gbg9IV6GRMIjrKhyw5AEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFc2YtFsce/Z8O9c52ZVsQpaOa5CDyXKO7HGG0/TY6qIE2WQe4EHunJrO5bXwJWvjOuNopwu9vNoV08wRSxUT6UmYobhy2v+0QnYd9YB9yLTdEDm++izfXkh0Jnd2yfsFfIAtQ+tdzZD6uwupAVLbjpewxACFGz6seZT2ftLpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RE6XywIx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761466397;
	bh=od6ChUUR+8/ACM0Q9cUVA9gbg9IV6GRMIjrKhyw5AEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RE6XywIxAuMfSxG2mdTNpFGV7lCjjogAjgW/ix07HTwa0yNzBAIkKCcpJNJDui3zr
	 lZIt53PM35whuJSlW+PJ93j5sqGESA9+8H/S97Fs5sErzRkmGzVLi97Gt3VZf1PBLz
	 LPGAw7pxkNUJWcY7uYb4ZlosjcHhhViwJLjqxtSvRi/eshzghMSw+HQi3ww+Rsm0nw
	 fvNsSbk/xdje8+y2YTfwP+EnguDXdCzYVH1y0LgbF59HAtZ4oIZ+E20MpQBiilBh7v
	 E7oToM/7EgQ9qHdi/pl4potkuXC8rYP5qhnWVqrRlNhCfI+EtCD3OEpZN5aMZ9rQYf
	 awzAu1o5Vfopw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8473617E126B;
	Sun, 26 Oct 2025 09:13:16 +0100 (CET)
Date: Sun, 26 Oct 2025 09:13:10 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] drm/panthor: Introduce panthor_pwr API and power
 control framework
Message-ID: <20251026091310.4046f061@fedora>
In-Reply-To: <20251024202117.3241292-4-karunika.choo@arm.com>
References: <20251024202117.3241292-1-karunika.choo@arm.com>
	<20251024202117.3241292-4-karunika.choo@arm.com>
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

On Fri, 24 Oct 2025 21:21:12 +0100
Karunika Choo <karunika.choo@arm.com> wrote:
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 092962db5ccd..09aef34a6ce7 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -192,3 +192,8 @@ int panthor_hw_init(struct panthor_device *ptdev)
> 
>  	return 0;
>  }
> +
> +bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
> +{
> +	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 2665d6dde2e3..4c71f27d1c0b 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -32,4 +32,6 @@ struct panthor_hw {
> 
>  int panthor_hw_init(struct panthor_device *ptdev);
> 
> +bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev);

Let's make this a static inline function so the compiler can inline its
content at compile time.


