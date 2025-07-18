Return-Path: <linux-kernel+bounces-737000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E38B0A67C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92BD587289
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E22DCBF7;
	Fri, 18 Jul 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j8vnW06/"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBE2AF07
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849724; cv=none; b=MgJweIEQDo/dTPMHJHruA+4VbQMz9vv2sl4HcZE4+IHp4cIOZTsmqUhNsXnm+3Y5AsY3cNNAU1uha6bh8At+HaPR1Z57jvBBASfpgeNirAZEqLQs4UuGD/2RVkI2NSj7OcPNdJe+L9CD92xg4ii1cbAYZV6sGdJN3jqGFiSWyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849724; c=relaxed/simple;
	bh=5y40b0yYev3hpWT0UJVA2F6x8wGj3RCt6raNkDrx1Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQHjNOcCLftrNLxQPq9MAevq2jyDCT749u6MtOvdXRW583nuV3rc0tCkLhpNXDk7PQgthPUkxUrVZ+4Msk45n/eqvwJPyJ3IBvnwVZoX3oXHMu5Dea9oBqunaa5wZ57vdH1Yyb0ooMiQVB6rqvUKPXnyeJaUhlAP2TQdInGg/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j8vnW06/; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1ECB442BC;
	Fri, 18 Jul 2025 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752849720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsYtbmooxUDXjhCY1Mg9PgyeqMVLQZ0GuWfwZm2GWIQ=;
	b=j8vnW06/rdawag7U0o4mbPPbEE4AUppKn2nCViLzLzLmQ3XhNDcNdNSvDOwYOWsFAO0pC9
	ZISoblQyImn3weKLV2mC7j2kXT0t/vDY9vR38jvEklJ2k7GvVxa8oDCzRlOlKP8uqMunto
	CPgVFACo+9KuCos34jwz2Xmct21DCyUu3zU5FzwZYnC2WKy6krk8V8RX2YgnFCEhnSBR0r
	LBUERi7CmQpx/dAutGjSS57kQFU3WxjdysJH9vfUGSmWO0fHEYDbbSPuSp3motdlheFpuQ
	4DLPHk7Ga9h0Lx/iMvGtDuSAQAenrZ+4yjIwNKALRuXMP5UeNVuCDi1Zs4HQRQ==
Date: Fri, 18 Jul 2025 16:41:56 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmitry
 Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v6 08/10] drm/display: bridge-connector: hook in CEC
 notifier support
Message-ID: <20250718164156.194702d9@booty>
In-Reply-To: <20250517-drm-hdmi-connector-cec-v6-8-35651db6f19b@oss.qualcomm.com>
References: <20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com>
	<20250517-drm-hdmi-connector-cec-v6-8-35651db6f19b@oss.qualcomm.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejtefftdelheeghfffffdukefhudejuedvfefhteelfeetgfffkeejteejtddvveenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhovhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhin
 hhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepuggrvhgvrdhsthgvvhgvnhhsohhnsehrrghsphgsvghrrhihphhirdgtohhmpdhrtghpthhtohepmhgtrghnrghlsehighgrlhhirgdrtghomh

Hi Dmitry,

On Sat, 17 May 2025 04:59:44 +0300
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:

> Allow HDMI DRM bridges to create CEC notifier. Physical address is
> handled automatically by drm_atomic_helper_connector_hdmi_hotplug()
> being called from .detect() path.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

While working on drm_bridge_connector_init() for unrelated changes I
stumbled upon something in this patch (now committed) which at a
cursory look appears wrong to me.  Even though I still haven't analyzed
in depth I'm reporting it ASAP so you are aware and can either correct
me or confirm there is a bug.

> @@ -662,6 +670,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  			bridge_connector->bridge_dp_audio = bridge;
>  		}
>  
> +		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
> +			if (bridge_connector->bridge_hdmi_cec)
> +				return ERR_PTR(-EBUSY);
> +
> +			bridge_connector->bridge_hdmi_cec = bridge;
> +		}
> +
>  		if (!drm_bridge_get_next_bridge(bridge))
>  			connector_type = bridge->type;
>  
> @@ -724,6 +739,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  			return ERR_PTR(ret);
>  	}
>  
> +	if (bridge_connector->bridge_hdmi_cec &&
> +	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
> +		ret = drmm_connector_hdmi_cec_notifier_register(connector,
> +								NULL,
> +								bridge->hdmi_cec_dev);

Here you are using the 'bridge' pointer, which is the variable used by
the long drm_for_each_bridge_in_chain() loop at the function top. The
same happens in the following patch. I am not sure this is what was
intended, but I don't understand all the details of your series.

In an older patch [0] you had added a similar change, dereferencing the
same 'bridge' variable after the drm_for_each_bridge_in_chain() loop.
That was a bug fixed by a later patch [1].

Superficially this change (as well as patch 9) appears equally wrong.

Basically the value of 'bridge' here could be NULL or
bridge_connector->bridge_hdmi, depending on the
bridge_connector->bridge_hdmi value.

Is this the what you'd expect?

And if it is, what is the correct fix? Maybe:

	ret = drmm_connector_hdmi_cec_notifier_register(connector,
						NULL,
-						bridge->hdmi_cec_dev);
+						bridge_connector->bridge_hdmi_cec->hdmi_cec_dev);

?

Removing unrelated lines, and adding a few comments, the code flow of
the function is:

struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
						struct drm_encoder *encoder)
{
	struct drm_bridge *bridge, *panel_bridge = NULL;

	drm_for_each_bridge_in_chain(encoder, bridge) {
		/* ...lots of stuff... */

		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
			bridge_connector->bridge_hdmi_cec = bridge;
		}
	}

/* now bridge == NULL */

	if (bridge_connector->bridge_hdmi) {
		bridge = bridge_connector->bridge_hdmi;
	} else {
	}

/* now bridge can be NULL or bridge_connector->bridge_hdmi */

	if (bridge_connector->bridge_hdmi_audio ||
	    bridge_connector->bridge_dp_audio) {
		/* this is the code that got changed by [0] ad fixed by [1] */
		if (bridge_connector->bridge_hdmi_audio)
			bridge = bridge_connector->bridge_hdmi_audio;
		else
			bridge = bridge_connector->bridge_dp_audio;

		dev = bridge->hdmi_audio_dev;

		ret = drm_connector_hdmi_audio_init(connector, dev,
						    &drm_bridge_connector_hdmi_audio_funcs,
						    bridge->hdmi_audio_max_i2s_playback_channels,
						    bridge->hdmi_audio_i2s_formats,
						    bridge->hdmi_audio_spdif_playback,
						    bridge->hdmi_audio_dai_port);
	}

/* This is the code added by this patch */
	if (bridge_connector->bridge_hdmi_cec &&
	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
		ret = drmm_connector_hdmi_cec_notifier_register(connector,
								NULL,
								bridge->hdmi_cec_dev);
		if (ret)
			return ERR_PTR(ret);
	}

/* This is the code added by patch 09/10 */
	if (bridge_connector->bridge_hdmi_cec &&
	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
		ret = drmm_connector_hdmi_cec_register(connector,
						       &drm_bridge_connector_hdmi_cec_funcs,
						       bridge->hdmi_cec_adapter_name,
						       bridge->hdmi_cec_available_las,
						       bridge->hdmi_cec_dev);
		if (ret)
			return ERR_PTR(ret);
	}
}

[0] https://cgit.freedesktop.org/drm-misc/commit/?id=231adeda9f67
    -> hunk @@ -641,11 +705,16 @@
[1] https://cgit.freedesktop.org/drm-misc/commit/?id=10357824151262636fda879845f8b64553541106

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

