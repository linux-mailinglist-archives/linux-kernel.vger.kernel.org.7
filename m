Return-Path: <linux-kernel+bounces-870251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4214C0A497
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78F414E3C99
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1944822CBD7;
	Sun, 26 Oct 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rb2GrXi6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641C17A2E8
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761467247; cv=none; b=FBymTu0AfFk5e4ugr03HQis1KMTMT3FX5ABklwQdhgfEr7BpAnmafcJtZNYPmHxQVlRx7ZaSC22gsgtSYFnynSol5jX7WPw88CBiQBlCS80JzacbHYCqqEIf0h4fqbJYkOgOlz3J4R9gyY4fDhK9kgrGleotAIk/vluklnV44VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761467247; c=relaxed/simple;
	bh=elSX9IbqQvW2SuUAYMHA/NTFtVw/y09OwjHI4aK+9Go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZ6W8hm7rkuDg29fJahL3O1Bn0nqutQ2/+7qBlvssAetcag1aJQAL2ADWZilhx5bthP/wjzmLg7Bm1ZEVful/3SzcKWXYOrow4w41q3sxhe2Zw+PjKoIftR0V8upqS5D+exQNElYZT9M5QVE8eb4+rj8BceAHAaC2rsisIM3o3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rb2GrXi6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761467243;
	bh=elSX9IbqQvW2SuUAYMHA/NTFtVw/y09OwjHI4aK+9Go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rb2GrXi6HpsLYx8ZrvSbgyAJlo2w3O/tfX6q40tcLizhEoYlqGL4gUKiWVT0OP/Sd
	 jaY4yTzWqaYwic2VHaW3S7XiTowwI8AERodX7pCPTjcdH/4SFJUpBP5CnsWwqOff0y
	 zpj7vW8bZtG3Ode8mE/TFZuWXqCH0fN8mz++01sqTHpD0sY5qdWiq5dcXr4/mq24J3
	 QpGTT4hOMsMFfXmXHKr+WwsL6DhqZs9QudT3FrrwDr1eHWTkYaoiQR7vnE/51RX1o9
	 M9r183MCBA+jScztgDTuRvUSPLDtEcc8YO2SVKBLTbtEWg4R02vCrVEWaeDWLkbTcw
	 lUo8o3w2V5eyw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 02AA117E139C;
	Sun, 26 Oct 2025 09:27:22 +0100 (CET)
Date: Sun, 26 Oct 2025 09:27:17 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] drm/panthor: Support GLB_REQ.STATE field for
 Mali-G1 GPUs
Message-ID: <20251026092717.3aae3679@fedora>
In-Reply-To: <20251024202117.3241292-7-karunika.choo@arm.com>
References: <20251024202117.3241292-1-karunika.choo@arm.com>
	<20251024202117.3241292-7-karunika.choo@arm.com>
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

On Fri, 24 Oct 2025 21:21:15 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> +static bool panthor_fw_has_glb_state(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +
> +	return glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0);
> +}

It's okay for now, but if we start having more of these, we probably
want to automate the generation of those has_<featurex>() helpers with
something like:

#define FW_FEATURE(feat_name, major, minor)						\
static bool panthor_fw_has_ ## feat_name(struct panthor_device *ptdev) 			\
{											\
	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev); 	\
											\
	return glb_iface->control->version >= CSF_IFACE_VERSION(major, minor, 0);	\
}

Same goes for the HW features BTW.

> +
>  /**
>   * panthor_fw_conv_timeout() - Convert a timeout into a cycle-count
>   * @ptdev: Device.
> @@ -995,6 +1003,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  					 GLB_IDLE_EN |
>  					 GLB_IDLE;
> 
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0))

	if (panthor_fw_has_glb_state(ptdev))

> +		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
> +
>  	panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN, GLB_IDLE_EN);
>  	panthor_fw_toggle_reqs(glb_iface, req, ack,
>  			       GLB_CFG_ALLOC_EN |
> @@ -1068,6 +1079,54 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
>  		drm_err(&ptdev->base, "Failed to stop MCU");
>  }


