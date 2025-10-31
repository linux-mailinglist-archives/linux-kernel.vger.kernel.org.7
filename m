Return-Path: <linux-kernel+bounces-879692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9EC23BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46154188B270
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C74305E37;
	Fri, 31 Oct 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T1ygqf85"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C72F9D9A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898496; cv=none; b=u3kXWS9SDWAFbtxAp9G5SxrRAm0TSDuRB4xa6sVlygq7izSJOIzZUlXyOhyU8uRdld/XWwHmmxJ9MJnM7Kav+x2JFrAHsXaVJvoAXbSyomGDHnuA5SmYPpPRqlRSo08jaadoINrT7iNwQ87XIpBl0xwzCxRVosrdwrWdge4mOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898496; c=relaxed/simple;
	bh=/QnJcZUJ5qnAWkQ1qujlZ/10Xlu6j2TSKjRO9Yhs9zM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tD+WVIwFthG43TrWb5JGWAXMbgRw79Mq6RnfCH4LncNRXPzlIX10B3fs/zVz5GL6YyObTWOzhQvvDhQ6n5eIssxvaSpyrrUq6a28aCm4mIF6g+2oztrpE3Bv6XqNPSMuocRfsINyKDC4M/KuyC/JjvTNZZUSODLI6zeRIFwX72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T1ygqf85; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D640EC0E949;
	Fri, 31 Oct 2025 08:14:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3224F60704;
	Fri, 31 Oct 2025 08:14:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BCFC1180FC53;
	Fri, 31 Oct 2025 09:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761898491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5kqeQwCaBXcdDdY/fhWUYtRy6WjKsRWcRbvT6plygZk=;
	b=T1ygqf85lOMPWNIDgy20hrud9rCyd1xYGw6YtoFTSBH3pQHtW1WHik1l52Ilu0OT6lsl/L
	zHbQrU6Klq8WUqyjfkbqD9cE5v1+IHAHs3ioVdpqt4SZ+4sVt52p45QAqmqiNS4tAT6jN4
	JcFj+iG9CLwUNVoTsgr3/ZvFloNGRaGHDiWEJFsdStw7t0+V8b1u/1Cl4GZQUUToGmJ0Lj
	Aqk8f1rIgCxzN3KcXKmwhU9EE9CdtmRjNu8cIpT9LENVwKr1icISps9Ay8L6Yvp7cxG2ju
	K4FEKe9rAKcgYlnMBOvrU+XSh0Q0AWraH9ZR4sWbJefClS7Y3DjOAJX7nyVD2g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Oct 2025 09:14:45 +0100
Message-Id: <DDWCVYBQSV10.2MFZFEEHPYJY4@bootlin.com>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, <imx@lists.linux.dev>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Shawn Guo"
 <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>, "Sandor Yu" <sandor.yu@nxp.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 5/9] drm/imx: Add support for i.MX94 DCIF
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com>
 <20250911-dcif-upstreaming-v5-5-a1e8dab8ae40@oss.nxp.com>
In-Reply-To: <20250911-dcif-upstreaming-v5-5-a1e8dab8ae40@oss.nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Laurentiu,

On Thu Sep 11, 2025 at 1:37 PM CEST, Laurentiu Palcu wrote:

...

> +static struct drm_bridge *dcif_crtc_get_bridge(struct drm_crtc *crtc,
> +					       struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_connector_state *conn_state;
> +	struct drm_encoder *encoder;
> +	struct drm_connector *conn;
> +	struct drm_bridge *bridge;
> +	int i;
> +
> +	for_each_new_connector_in_state(crtc_state->state, conn, conn_state, i)=
 {
> +		if (crtc !=3D conn_state->crtc)
> +			continue;
> +
> +		encoder =3D conn_state->best_encoder;
> +
> +		bridge =3D drm_bridge_chain_get_first_bridge(encoder);

The bridge returned by drm_bridge_chain_get_first_bridge() is refcounted
since v6.18-rc1 [0], so you have to put that reference...

> +		if (bridge)
> +			return bridge;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void dcif_crtc_query_output_bus_format(struct drm_crtc *crtc,
> +					      struct drm_crtc_state *crtc_state)
> +{
> +	struct dcif_crtc_state *dcif_state =3D to_dcif_crtc_state(crtc_state);
> +	struct drm_bridge_state *bridge_state;
> +	struct drm_bridge *bridge;
> +
> +	dcif_state->bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> +	dcif_state->bus_flags =3D 0;
> +
> +	bridge =3D dcif_crtc_get_bridge(crtc, crtc_state);
> +	if (!bridge)
> +		return;
> +
> +	bridge_state =3D drm_atomic_get_new_bridge_state(crtc_state->state, bri=
dge);
> +	if (!bridge_state)
> +		return;
> +
> +	dcif_state->bus_format =3D bridge_state->input_bus_cfg.format;
> +	dcif_state->bus_flags =3D bridge_state->input_bus_cfg.flags;

...perhaps here, when both the bridge pointer and the bridge_state pointer
referencing it go out of scope.

> +}

You can just call drm_bridge_put(bridge) there, or (at your option) use a
cleanup action:

 static void dcif_crtc_query_output_bus_format(struct drm_crtc *crtc,
                                               struct drm_crtc_state *crtc_=
state)
 {
         struct dcif_crtc_state *dcif_state =3D to_dcif_crtc_state(crtc_sta=
te);
         struct drm_bridge_state *bridge_state;
-        struct drm_bridge *bridge;

         dcif_state->bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
         dcif_state->bus_flags =3D 0;

-        bridge =3D dcif_crtc_get_bridge(crtc, crtc_state);
+        struct drm_bridge *bridge __free(drm_bridge_put) =3D dcif_crtc_get=
_bridge(crtc, crtc_state);
         if (!bridge)
                 return;

         bridge_state =3D drm_atomic_get_new_bridge_state(crtc_state->state=
, bridge);
         if (!bridge_state)
                 return;

         dcif_state->bus_format =3D bridge_state->input_bus_cfg.format;
         dcif_state->bus_flags =3D bridge_state->input_bus_cfg.flags;
 }

This would call drm_bridge_put() at end of scope, i.e. end of function.

You can also have a look at recent commits involving drm_bridge_put (git
log -p -Gdrm_bridge_put v6.16..origin/master) to see how other parts of the
kernel have added drm_bridge_put().

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8fa5909400f3773=
51836419223c33f1131f0f7d3

Best regards,
Luca

---
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

