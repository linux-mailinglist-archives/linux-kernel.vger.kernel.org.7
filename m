Return-Path: <linux-kernel+bounces-786565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0599CB35D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558753B5F77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450692FD7C8;
	Tue, 26 Aug 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="JWNY/jY9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDC29D273
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208391; cv=pass; b=DeqoAr7lvcrIq8CNM3MrP7m5PTUhDQVDJUmHfCwBPdPCMI8kNSrDyfKNFE0pqJcIUl++hF7dAme0zBOzRxMpVySyJE+6WPQ/vLznnRRioqyNK8H5Fpch9jSJcj8lg+n9WjkIzOe3brK1c3AIxzt05bx0kQEbtTLlAQFZs8f3gHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208391; c=relaxed/simple;
	bh=COoVxgfHA8MCBpi6yucVlKYbKVe+CtBebhfveNnP1gQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XJJYKcrGzIx7kj1By0OwZnhUkayhXm2C11PV/OlvW0PAug409GgtiJ9kHOhoBHDK5SD5rAbYiafQfnaPWAnUcDmIUINwI8odNBaoBzfrZP/o1oaICLKepEFDe7Xza4YQOS9zE0Ey7rh6qOSKCxtTJlLFGhy4AKOCGHcdI6S7elg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=JWNY/jY9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756208370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rb9xn2fTOKKaWYDTKVtb6tXJcRftlBOsdEJhPIKiwlcSXev+MfNP2sCtFS3Ys/K86r9vwfOaX3rBGNgjJ48t36fkB03crSEnD+eORHec7H5CdtsdpNuXKTy4Z4gAvGZp7q+0Y7HSekphh7W9bQxMpUbNIbWnHErJjMgZGbb87R8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756208370; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2HU9eUcc8WGG2gaX/M8M9tjRaoa9qsJqLwJNN74sr4M=; 
	b=LsBJTlzMZu8Iu0jCTvKkH6cyF2JefFj2Y0PfwQopHt2KsGjjLmqkDLUsJEQlz55UTkuvZR2xBKLTLxCe6qEMvdCorS1pOgXAQrVvMp7a8JblWSMCfZ1RuO4UgP6e+2Fd01bRKBkuxNONJdh+6clb3vR+va0uEvvRYcFI3w+GkCc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756208370;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2HU9eUcc8WGG2gaX/M8M9tjRaoa9qsJqLwJNN74sr4M=;
	b=JWNY/jY95QR9At+berP4+i2NTg7PoyEZjJVW+Ey+tiEUa10e0H29Sbf/comqeIw0
	bEuz0uA+GWzyA+Houh7/Ot2K1oMHkxe+eRu3CEmEo1U2jv7lBqw6VtA0PB9cuo0456g
	9rGNCm2UKkrpRXP7aV9AQwDsa0fQMJbHhh+yWpXg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17562083275301017.6621271839762; Tue, 26 Aug 2025 04:38:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:38:47 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Antheas Kapenekakis" <lkml@antheas.dev>
Cc: "amd-gfx" <amd-gfx@lists.freedesktop.org>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"philm" <philm@manjaro.org>,
	"Alex Deucher" <alexander.deucher@amd.com>,
	=?UTF-8?Q?=22Christian_K=C3=B6nig=22?= <christian.koenig@amd.com>,
	"Mario Limonciello" <mario.limonciello@amd.com>
Message-ID: <198e62c6b4d.895a68a41708589.706102196190635345@collabora.com>
In-Reply-To: <20250824200202.1744335-6-lkml@antheas.dev>
References: <20250824200202.1744335-1-lkml@antheas.dev> <20250824200202.1744335-6-lkml@antheas.dev>
Subject: Re: [PATCH v1 5/5] drm: panel-backlight-quirks: Add Steam Decks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


 ---- On Sun, 24 Aug 2025 21:02:02 +0100  Antheas Kapenekakis <lkml@antheas.dev> wrote --- 
 > On the SteamOS kernel, Valve universally makes minimum brightness 0
 > for all devices. SteamOS is (was?) meant for the Steam Deck, so
 > enabling it universally is reasonable. However, it causes issues in
 > certain devices. Therefore, introduce it just for the Steam Deck here.
 > 
 > SteamOS kernel does not have a public mirror, but this replaces commit
 > 806dd74bb225 ("amd/drm: override backlight min value from 12 -> 0")
 > in the latest, as of this writing, SteamOS kernel (6.11.11-valve24).
 > See unofficial mirror reconstructed from sources below.
 > 
 > Link: https://gitlab.com/evlaV/linux-integration/-/commit/806dd74bb225
 > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
 > ---
 >  drivers/gpu/drm/drm_panel_backlight_quirks.c | 17 ++++++++++++++++-
 >  1 file changed, 16 insertions(+), 1 deletion(-)
 > 
 > diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
 > index 78c430b07d6a..5c24f4a86519 100644
 > --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
 > +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
 > @@ -73,7 +73,22 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 >          .dmi_match_other.field = DMI_PRODUCT_NAME,
 >          .dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
 >          .quirk = { .brightness_mask = 3, },
 > -    }
 > +    },
 > +    /* Steam Deck models */
 > +    {
 > +        .dmi_match.field = DMI_SYS_VENDOR,
 > +        .dmi_match.value = "Valve",
 > +        .dmi_match_other.field = DMI_PRODUCT_NAME,
 > +        .dmi_match_other.value = "Jupiter",
 > +        .quirk = { .min_brightness = 1, },
 > +    },
 > +    {
 > +        .dmi_match.field = DMI_SYS_VENDOR,
 > +        .dmi_match.value = "Valve",
 > +        .dmi_match_other.field = DMI_PRODUCT_NAME,
 > +        .dmi_match_other.value = "Galileo",
 > +        .quirk = { .min_brightness = 1, },
 > +    },
 >  };
 >  
 >  static bool drm_panel_min_backlight_quirk_matches(
 > -- 
 > 2.50.1
 > 

Reviewed-by: Robert Beckett <bob.beckett@collabora.com>
 


