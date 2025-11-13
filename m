Return-Path: <linux-kernel+bounces-899469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845FC57D91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E14E77B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA526F2A0;
	Thu, 13 Nov 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6+wFIYU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0DB26ED48
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042842; cv=none; b=X/qGYt63hbdzdadtQQbbDZIcCGRHPBM9pgMOa3r8meJKu+M2qAE4hWQ2fFKzkgTzptWNL8cctyz6IoEqWvMCmjx/OjSF15Mato1ot9YKG7B5EUhOiAicm+WcEIsLpQRMYK8lwBr2m+WdlpAGPK5mqtNMy+8I8BZlxYNC59My+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042842; c=relaxed/simple;
	bh=g7KcdEGyxixL5QT0k7JFqTbfyy3dDyaQvKHJO9Ulru8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgbTq0WfiUrD7wSCInP5kh1j+xmcrE4CTZ//qXMTL1Mivo3/RIYG4HEjK56939IbJn4C1ApZB/FmJuPrK9LMRysFs98ARzAsh3rnueTa+HjZh7RaHQJikcrDrWYnM18yQ9ObQbP4SvE0AznZ8pu6yJmDkqnn3n0z+HWEbeftvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6+wFIYU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso4670785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763042839; x=1763647639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3cf0bJfE0DHgZ8cmT4vSAdpERQZSI+WOrcGvjTZDl8w=;
        b=B6+wFIYUhKb8uODtBvvMgZxRUNPVgg+MtD2jZxRaYOykMwdJeb4/nUOQFlPL8L6MWQ
         0k8jtor/OPmgmuXW+70imlrmY8bLAlykTD8IBwVDpuB05igRofi11AfCPDlomed9AIJl
         ivJP6jVCGZ8Zvc7VCWGS7wGdHGOL3N7hXch8oJ4xAvc6WefwZ6SjqnhSh1xfFXhu5HHn
         H1tm//aiDF1s0pDDYqP1YNrp3pqQDV5+N7g9G3fWe7Ib5i2YPTbFAlzjdBXzYaHzKZjT
         Gz4qNyWamLBM+MaBY5tezQSMj+3LaPHqAd5cMoaccI8qkUvvofH02T/lMTDex+c6oqj7
         363A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042839; x=1763647639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cf0bJfE0DHgZ8cmT4vSAdpERQZSI+WOrcGvjTZDl8w=;
        b=TI3pA7Yt3jorB2yAF/G5e8oHQdBT5tbuRDj7iM85aykm5IhorYj4mesJ5HIz/T4D38
         c9lW4u6T9YsnfrMSxVN5JO0gpBFqq/SxAy7brLNKXRAAb6VeKrTQ4TwlXJMZVh/iZDh9
         Gv3q9ZDQd7AqM/TD4p8n9o8wADtyz+6TSXE8rASvs6M2BI+ieKQ6RusKj2N/SCYUxAAd
         xBWj5XPHR47d7bBmu7S6EhnC4tGJSgfR9+o2bA/a8/Iz27cWtxy9jcTKFtzRn9dthDqC
         ka6Gg+OaCZ/8vdvOTXKj4i6h+47eNK39fXIMeYws1QKeFN4KxB7n6Mf4NvDAzNdhxZ25
         twYA==
X-Forwarded-Encrypted: i=1; AJvYcCUBjJ5b0gNCEGfG9y2YnoPldiD9lRJ8E+72XyZGlOVypSW4nmWvKX+vc3DkSsGbMhTiRiiSWun7kYXBaHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYvKIxX3/CqaalWbK/4pgkMUZs6rf7NjSLXAq7QKlUmVRD3yg
	GM7Sad/wG51USEK3OJm1+ajMnuXSo4Nse4GPdV4GoOct3ezFe007OA4o
X-Gm-Gg: ASbGncsXsuXn1U2dOsCWK+otfDOJVPfmOFKCUXDel4mLubm70glmf5WWVzWNI1o3GfF
	aBMWEWLgtc+DsjEWjAkIfg3qaI7eP0hBRyCkMP5/LErRu2ok8gvElXQmKFxxQcWTdvbZvmAAy/K
	QcjMv70Apv2bUAGJ5Mer1xXhd3rLdld/CgtoYhTZmzPgvIFZhIqc78uZhokMC+AOJ7SRtjS9vqq
	qa+ilNjeTUQWBFdsE52NT7hNKKx2Ngry2x8I48fjck55MLj9WZxQeszn5G50aZL1dmX3FC3TtBk
	vcDuLh0Q2gypnSPkPoVQYqVLmT/ba74cOUPugifGLuHzzyHAcnwwdyujDJJn70lI63t75mofY8B
	AALiYDmmbABciFHbqe9+KQBzDMU1YgJubUVtyBtkLJJVEcyLb59NGSysoOGORgu8rnhT+ywlj4Q
	==
X-Google-Smtp-Source: AGHT+IESPvGeYnNPQ2jFxLjtUUJRNV1uNh5/dmN4S/q8mZbuTNaMbF9v84Ad5WEPzh9SzlvoRQ6M+w==
X-Received: by 2002:a05:600c:c4a3:b0:477:6d96:b3dd with SMTP id 5b1f17b1804b1-47787070768mr75665415e9.1.1763042839195;
        Thu, 13 Nov 2025 06:07:19 -0800 (PST)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb2f9c8sm22460805e9.1.2025.11.13.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:07:18 -0800 (PST)
Date: Thu, 13 Nov 2025 15:07:15 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	victoria@system76.com, sebastian.wick@redhat.com,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RESEND v2 02/32] drm/vkms: Explicitly display plane type
Message-ID: <aRXmE0cBmjN1noyK@fedora>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
 <20251029-vkms-all-config-v2-2-a49a2d4cba26@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-vkms-all-config-v2-2-a49a2d4cba26@bootlin.com>

On Wed, Oct 29, 2025 at 03:36:39PM +0100, Louis Chauvet wrote:
> Debug information are mainly read by human, so use full name instead
> of values.

Reviewed-by: José Expósito <jose.exposito@redhat.com>

> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index f8394a063ecf..cfdd5f32f234 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -348,8 +348,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  
>  	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
>  		seq_puts(m, "plane:\n");
> -		seq_printf(m, "\ttype=%d\n",
> -			   vkms_config_plane_get_type(plane_cfg));
> +		seq_printf(m, "\ttype=%s\n",
> +			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
>  	}
>  
>  	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
> 
> -- 
> 2.51.0
> 

