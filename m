Return-Path: <linux-kernel+bounces-858431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E284BEAC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9A5C122F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB52E2DEF;
	Fri, 17 Oct 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CGLM6GZt"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FE2E3B11
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718072; cv=none; b=VUTSEQo7cxEB23yRzczEqAajApuh1BzSwHRXOUvXw3QbER8RGeJokHO7xGmb8FUD00f0J/AmqbsjjbmkH6OZfx9DknHc0QW4QfwvYD/2L0rGkrxGvDQ+KbUPCl752dExfZUkKltHqhFUoAHaWsZTrQcu3f/+qkBMnqS5ZEIhgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718072; c=relaxed/simple;
	bh=tEvU+ZGklXk6f1uEc4h5SxgdbSc0WVQj3TxujSVBhtg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HdX1Q2k+N4pB2dxC+nLli01cbo8qk7itttmAo6shq1fknpnNXTLrX0wfwBtdkLBEszZ6KlQJz+DOpDJ4csyh/XO8gpYzkp7sdghC5D+TaSXSC6oJ4zKWxIxMdFcz+PfecQKpQGlTVRcoEPsHSVCOfXxcKJgKjH2sZSXX+ahJAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CGLM6GZt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 34AAD1A1483;
	Fri, 17 Oct 2025 16:21:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0AD6C606DB;
	Fri, 17 Oct 2025 16:21:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88B26102F235B;
	Fri, 17 Oct 2025 18:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760718066; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VxSK+5XE+aga45YMvC6DqmYr627wtrotg/fT7O4kNCs=;
	b=CGLM6GZtZgZ5vFMGBYMm/23ATANOo4N/p/yY2cTfm+uB8ChTqNB13NUCZgq+/IrIvHCNzq
	1Y6oDW02x71ZsYPihEVU0mWK5zjE43/BL13GfAj1/nf+LXxtMJ5RVfrzLmCYRJIzhfwdYw
	gwDBwfV7RsqS7jZWKVSZp4qRt4TbaBjzcdJwiQ/W2xnY3tn51zI/QAli+svjtG4klSKtDf
	VHf7ujHh+vzP/0yfkUIJJ1URcboqs18E8TgtwKkwd8FT5yMrb18C+XDLVCMlg6wm6W9jLB
	toz3822oDi9DHnOGMf8d8m7nlBl0dtYc8P5AKUGui9oufHEvHPpDdviCd2XmIg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 18:20:59 +0200
Message-Id: <DDKQGM8BPW8T.3PTC93J4GHUR5@bootlin.com>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/display: bridge_connector: get/put the stored
 bridges
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1
References: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com> <CGME20251015082254eucas1p23fc961e7a49f4a29ca7a18d3e2817f86@eucas1p2.samsung.com> <336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com> <DDJ623AGI83R.ESC0V9XXWXFN@bootlin.com>
In-Reply-To: <DDJ623AGI83R.ESC0V9XXWXFN@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Wed Oct 15, 2025 at 10:08 PM CEST, Luca Ceresoli wrote:
> Hello Marek,
>
> On Wed Oct 15, 2025 at 10:22 AM CEST, Marek Szyprowski wrote:
>> Hi Luca,
>>
>> On 26.09.2025 16:59, Luca Ceresoli wrote:
>>> drm_bridge_connector_init() takes eight pointers to various bridges, so=
me
>>> of which can be identical, and stores them in pointers inside struct
>>> drm_bridge_connector. Get a reference to each of the taken bridges and =
put
>>> it on cleanup.
>>>
>>> This is tricky because the pointers are currently stored directly in th=
e
>>> drm_bridge_connector in the loop, but there is no nice and clean way to=
 put
>>> those pointers on error return paths. To overcome this, store all point=
ers
>>> in temporary local variables with a cleanup action, and only on success
>>> copy them into struct drm_bridge_connector (getting another ref while
>>> copying).
>>>
>>> Additionally four of these pointers (edid, hpd, detect and modes) can b=
e
>>> written in multiple loop iterations, in order to eventually store the l=
ast
>>> matching bridge. However, when one of those pointers is overwritten, we
>>> need to put the reference that we got during the previous assignment. A=
dd a
>>> drm_bridge_put() before writing them to handle this.
>>>
>>> Finally, there is also a function-local panel_bridge pointer taken insi=
de
>>> the loop and used after the loop. Use a cleanup action as well to ensur=
e it
>>> is put on return.
>>>
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>
>> This patch landed recently in linux-next as commit 2be300f9a0b6
>> ("drm/display: bridge_connector: get/put the stored bridges"). In my
>> tests I found that it causes the following NULL pointer dereference on
>> DragonBoard410c (arch/arm64/boot/dts/qcom/apq8016-sbc.dts):

...

> Thanks for testing and reporting.
>
> I'm afraid I have no hardware where the same bug can be reproduced, but b=
y
> code inspection the root cause is clear given the call chain:
>
>   drm_bridge_connector_init() [1]
>    -> drmm_connector_hdmi_cec_register() [2]
>        -> funcs->init() =3D drm_bridge_connector_hdmi_cec_init() [3]
>
> [1] used to set bridge_connector->bridge_hdmi_cec before calling [2], now
> it does it afterwards. But [3] expects it to be set already.
>
> I have overlooked this when writing the patch. My apologies.

...

> I'm looking at how to properly fix this bug ASAP.

Here it is:
https://lore.kernel.org/lkml/20251017-drm-bridge-alloc-getput-bridge-connec=
tor-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

