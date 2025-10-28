Return-Path: <linux-kernel+bounces-873516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD88C141CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D4D3AEE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036072E8B83;
	Tue, 28 Oct 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0i92+p4J"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603A25A62E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647503; cv=none; b=aW1wu1JmVZNOP4EskPt9oPuvhWXOt8LCNrwLCOj3KDW70D1tR1gtie+TTfivqwlTHGH3ERXReB97lTYsSRc/4Zk3uWRCygpsB1Z521atpXVagsbXVTksJRT9gDOIWy7XnFrVFuZfBtMSC6MPHhyy6XzT2Tvc3QMsyuCDl3GebOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647503; c=relaxed/simple;
	bh=PgLkSm+8nuajnYYZynEaLqVHIx48cmzYRH7y5oW0Y0A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l0Jihse14CuMYy9DIe2uZbVP5CzZk2Lxe3H8ftrOK9o9Fru94JwDYbN2o+n0XtiYeNOdlNoxwgEeoTdwR7wGm9SgW+OdiIzP5gsUEGt1F7hUZM9YjMtqfHV8plitbsO001q2mbgCsLVO4A6qC7fyTJItWopCmvhrArlY3rEFJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0i92+p4J; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 585B44E41393;
	Tue, 28 Oct 2025 10:31:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AEC3606AB;
	Tue, 28 Oct 2025 10:31:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27FF31179C2E5;
	Tue, 28 Oct 2025 11:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761647498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+uY3+sIHhzL49uMZkTdNmvkZZS6TEOBGiAztDbiw/+Y=;
	b=0i92+p4JkeVY6u147fjVPtfkWhGbpfDe6ssbaFqu7WZEzB2Fud39xeLE3zmFVPYNIZajB/
	sQrWhVntow+EwdMcxMuvVQ6vK5glS2x5SL9Gfn+nOWxSsu6/pTkBXLhtWqpu0NMe1TYpmD
	4YeMusEbYSetkWsxv3I5WSfJQH9ZlStzEpU0zQyScP4tYTBtUW1j+WrYiLMEIp+XADFEHs
	vhyrBQ1HbuQxzS1Wu1N/g5P7M7fCxovk3Bp8mNNyDyWRuPwfc4RhOXVPfVyBUHqDQyGmUF
	q2XDt98c0IberEB9YpcxQZsai5KLV+8lmXwre+vIz1lkCptegwcJPvh/m7QQJA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 11:31:23 +0100
Message-Id: <DDTVWXIXAHWF.2CDJWTB5Z7MWT@bootlin.com>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] drm/bridge: enforce drm_bridge_add() before
 drm_bridge_attach()
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Raphael Gallais-Pou"
 <rgallaispou@gmail.com>, "Andy Yan" <andy.yan@rock-chips.com>
X-Mailer: aerc 0.20.1
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Tue Oct 28, 2025 at 11:15 AM CET, Luca Ceresoli wrote:
> Changes in v3:
> - Searched for any remaining drivers not calling drm_bridge_add(); found =
1,
>   added patch 6 to convert it

Just a note to mention that the leftover driver, fixed by the newly added
patch 6, was added very recently. Patches 3-5 would help a lot in avoiding
more cases to sneak in.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

