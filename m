Return-Path: <linux-kernel+bounces-860913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C584BF14DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4766518844D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4C131E49;
	Mon, 20 Oct 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NdX3w7kU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A33C465;
	Mon, 20 Oct 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964375; cv=none; b=THn3406ExpxD6BWGv93271oIX3MEWdgzSiL8F/9vSqLnhH7+vWYa5BQNuXJFsdF3oGV1M5MdqB9IyApRn0v7BnCJw8vY5qnt33kZXUkt5gsjRo+jU64asiTZc/30VthaLEUMWGDAbFNim5vFHDWW0fOrvy0rOHXqC+C780STLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964375; c=relaxed/simple;
	bh=iCETLYsFibjq+CsukzViDDTORlacs1ZM9GueRkvBoiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebLrk4pEiSxOEdEp4a2AHYg8Qt6f5p4FBPZh8Tghun8+SFeeyZeuURk8F8rq/u7RtsGR1kHSOwZs3CynIkC2RitvntdVFyZYtUTJbFVmu9Vh+f5VDDIP7cBC1KbQbqxZJ4NgEdIVmlK/ipnLPi8Wa3YIcW2N+9PyuRmQAYxCdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NdX3w7kU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=iCETLYsFibjq+CsukzViDDTORlacs1ZM9GueRkvBoiQ=; b=NdX3w7kUUi40I3knc1H3016F0j
	Yag6eG4tQ09/7ItC9tkDkRTOL9esr2bm8Q/ox54JUnDMGCdGrWFNvznVSQJm2nHjvlme+o9RwtJaG
	449+bJJqQ7F+DqQRoPrcuK9a7mhGZMDOm3FtAOSgl7Nen101eMV4Bk7ruKrwXTKNXisau5my3ijnl
	KvKnS8P4XLWuinHMB5DWh+JI4fj+uFXM0njHMhpRgZIeyZPsVA8kwlchpyydJZecgGM2VLjs/scFX
	qTxBRI6xSpwtmu9dE06F2qRSa3B7VxOi8IBv+vMe3Li1Bz6j6G7C4TeXNjpG4NU+v18UuE8JzImiV
	W3jLpg3A==;
Received: from [141.76.253.240] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vApGZ-0001AI-NB; Mon, 20 Oct 2025 14:45:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: dmitry.baryshkov@oss.qualcomm.com, Andy Yan <andyshrk@163.com>,
 neil.armstrong@linaro.org, andrzej.hajda@intel.com
Cc: mripard@kernel.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, knaerzche@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v8 1/2] drm/rockchip: inno-hdmi: Convert to drm bridge
Date: Mon, 20 Oct 2025 14:45:34 +0200
Message-ID: <8913609.MhkbZ0Pkbq@phil>
In-Reply-To: <20251016083843.76675-2-andyshrk@163.com>
References:
 <20251016083843.76675-1-andyshrk@163.com>
 <20251016083843.76675-2-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 16. Oktober 2025, 10:38:31 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
>=20
> Convert it to drm bridge driver, it will be convenient for us to
> migrate the connector part to the display driver later.
>=20
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

But of course I would be really happy if someone with more experience
on general bridges could also take a look.


Heiko



