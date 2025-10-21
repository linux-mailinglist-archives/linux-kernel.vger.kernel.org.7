Return-Path: <linux-kernel+bounces-863707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C37BF8E36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0B35445B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E4280A5A;
	Tue, 21 Oct 2025 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vh1guTcP"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52C27281C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080755; cv=none; b=qh4Rq+OeiTBchkt7vB3tdO8aNdu8nwmMNUhMpbg91GPl8N0QkBt1CrQrs/ryflfMvdwbHuE0B1WxeJTJw36/lWx3WgBInGMZOP/w443MtPem++Pt96pNg9A3OczQeXYNxsQsch6rUJSOB4+maX6j10waz2IUrRUZcRHPVYu6cL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080755; c=relaxed/simple;
	bh=lmgxMPK/b3rGKECnlJXXfebD4fVGZtbiAlKPc84ROo8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EQrKKAiJRC2V3kSUmhmr6x6r1vU3LxY+ITQOUbm8etBHc2V77ew+B9VaWIggiQb/snLWZ08nTLVxT0LwA/MiTw+BuolthYfVQOnwvedCIwXv+7CCre3Kwei8umLcWl6v6Si3e8xv1rQcOhdowtDOSHfko9CKm5rvnh+loQ4DWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vh1guTcP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 470B8C0B8A2;
	Tue, 21 Oct 2025 21:05:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7AEE60680;
	Tue, 21 Oct 2025 21:05:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63CB1102F2416;
	Tue, 21 Oct 2025 23:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761080750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lmgxMPK/b3rGKECnlJXXfebD4fVGZtbiAlKPc84ROo8=;
	b=Vh1guTcPS4hWMVnatliJa78v3xzxuw/wSvsuAO6vEwhYUsiF7o/Lmlk5NmxThHpnXbwAEc
	84LuPDG/YkHVEkiwTIfj17DST9tZ9grQzC846/36Hf8bWyNNPDlpLiAKHVGW+TiNgDW/qw
	UmXvgjKeoO0Th4LJKK+/6E14GbC70QLvyOuzmdFIgrxjKdR8DNqXlzeTRdmhsI9mNmjHeA
	IV41rZYCqYHSNz4JoDkXMFkWpK/qkSgULk0gRaiVoa+7rNJU/Ze75/cSUvhkuzcTBAh0rX
	ih1sAanMWRWiQDxBoWH3iTo1RAzDDHaL7sD4KTlTJ/E+W6VtXbkbReKCfKMzDg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 23:05:45 +0200
Message-Id: <DDOB0TVD1B9Z.23U6EH06F38NV@bootlin.com>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] drm/bridge: enforce drm_bridge_add() before
 drm_bridge_attach()
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: =?utf-8?q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com> <f3904ae1-bf1b-455f-b5ba-5d625b76222f@gmail.com>
In-Reply-To: <f3904ae1-bf1b-455f-b5ba-5d625b76222f@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Rapha=C3=ABl,

On Sat Oct 18, 2025 at 2:49 PM CEST, Rapha=C3=ABl Gallais-Pou wrote:
>
>
> Le 03/10/2025 =C3=A0 10:59, Luca Ceresoli a =C3=A9crit=C2=A0:
>> This small series enforces that DRM bridges must be added before they ar=
e
>> attached as discussed in [1].

Thanks for reviewing this series!

I just sent v2 which only adds a new patch with an additional check, which
I realized being useful after receiving a regression report.

All the details at
https://lore.kernel.org/r/20251021-b4-drm-bridge-alloc-add-before-attach-v2=
-0-c17cc1bbff72@bootlin.com

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

