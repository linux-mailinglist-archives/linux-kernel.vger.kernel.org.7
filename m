Return-Path: <linux-kernel+bounces-893961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC1C48F58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02073ABAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE532D0D3;
	Mon, 10 Nov 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW07MrFM"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C15329398
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801442; cv=none; b=smELFyJaNlN9IzjeIGUagOfNvvF5s7XI9uc+eiS7nr4XCu5N+mvCE5ooS+eXvgCABYWgR+kRQdxtc+DX/8ThjlgNrU3XBxBfUi1Q0maYww2+meWpctKShDGeEgzUMP21q5dsdXUoJeLnH/kCVI7e9qhy0b7PT28YxeJZ2Actac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801442; c=relaxed/simple;
	bh=LGjOA09bnTGrJVEPsadzP5+xYl8mEOeOa8jYDNOt07M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MBfecslm2dyyW7AxkrYC1JPxfVOY78L07pVcsYwlzp5IT57+DpTwskZb0yGll6bgiybA0gXfBmeCduEHhhb4W4HEGX9FXAVkC4BllwAuTX+rmAQc9BqtACZqOcfB3OD4qXbX9zFMock7EE9yz2xHb6zGmKEOw0+vnydZSYfcsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW07MrFM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso2539176b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762801440; x=1763406240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rdr73Hf6yD7F+vTTY+eqR8iFcL2w+R5f59ccxWMaVaA=;
        b=FW07MrFMe3iNc1NdgM9wcU9/dOcJiAy56H6UiPpiydn32B4IIStAaQNPz5H/wG613I
         QZQs0Vc7mgtnwyiGWnUPZh7fauvmBTGw5SlXxnEkijDKckdCpGQgkgxErqVXDdJi+eKo
         CZ+uD/Ksdye/axYVltqs0S4ziigGHNmsLDfGVlbflGFOMETzGsl8qQH+V5MDlsOKsKWc
         aAQKNH9wx4UpFRY2qatDjaodctE/Bc5GkFUvP3AxCt4ItewyFEx94xAvBI7bGXjWfsuc
         JJUtWohzIE76VNEaLGCFyGPylma8Eu+FXrezPe87QXK7MViWGgHqQhZ38Ci4+Tg374UA
         1jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801440; x=1763406240;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rdr73Hf6yD7F+vTTY+eqR8iFcL2w+R5f59ccxWMaVaA=;
        b=JHuczdQWA6wLmkp+GH7D7+Zqh2yRFSKGHqPv90m4RFYYWNvnG5XCUqPVWpCwObksBc
         xz/eAwvWewJDPRhklaM5Mgnr8g1WAX8RmJ3SdZJ3ZsbVSbaMaEvmX6fgk8bta730I/Bo
         jHq0XnJJw03JfvHS3cWqCH1ozvrOHQSlDxssnnXROzPFftRmuCuzuCGQMPfNza400tto
         eFNVPRQGHKA1nRmmUTgXZjcYttGxbWrZWPZc1fy5Urw3etF2d8oxGjNCIoPKT/1llH8g
         9PioIm6e56LVrBDShjQBmJLVrneWAViQpBe7+hTFMYu1/QOieAPYitvujxxxXyi5RaRM
         LAEg==
X-Forwarded-Encrypted: i=1; AJvYcCXesxwXm5qy042q/PV3fcyqrqKtBk1Lfx8exSdtkDF71iRaMHSmgm9n4pFJhL9FJNxh+QaEuoWlKjYhgI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1dSqiLJrZsnsrds5LERNr0ZvPYS28nm65Xgfdx1tRY3Tfe9C
	3TJEY2CYhJXqfwzHKC4Y4snwiV96ug1wlg6/H4uBh9fz/RU/RKcE0x4a
X-Gm-Gg: ASbGncuY5j8glMuQZB7gZksjk9fSB7LRWpe5ToVGaJqySRddss1KMl0phJjv+FM1fqS
	f7N63Y++ZHwE9Snryy81BmMorbPiD2g7fdH0+8fPRRejssoew1hueKSJw2O6yDngsCIf6qy9MqU
	zSOkNc9zl4aiItUo/z26+TpoV+fk6wy5YWZv/hlazIpQMq+21kUYvNyvaWCJp0GA1yvhqeuwKfi
	QgVY2uc365sg/IFOwJ+ZDTgcevwWbMJr88Mx9kRzNOxM4hvQ8Xqw2dsNWXlzgP5Z5b5+xTWk3wd
	1R6DcVvUsi0XmPjCSxCeXt+QlDLhmYmLuq7WrM0tMYB90x2eKpP1mFwFANpAGr9Y8viqrKNd+vy
	CyAn2zi/2oIkuVp25jn/SIjpqTvKV4WfitLeyHpfuL5gPu86zHUtqVlPrHSs1mgFb0/Rl1qXQHZ
	e/pmf5bI13alAPSpHQDn6DVOgsXjqjyLWyixERUkbt7sQr
X-Google-Smtp-Source: AGHT+IHWdjktidRqLMlZy+27raRZ8vwSz7rzuoczgl7EjMb3laqTUYObvY0qN7E6lqkaVnfU2LzZRw==
X-Received: by 2002:a05:6a00:22d4:b0:7ad:11c9:d643 with SMTP id d2e1a72fcca58-7b2266a5203mr10847194b3a.21.1762801439938;
        Mon, 10 Nov 2025 11:03:59 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c062b6sm12506475b3a.18.2025.11.10.11.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:03:59 -0800 (PST)
Date: Mon, 10 Nov 2025 16:03:51 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION] TI SN65DSI83 is being reset making display to blink
 On/Off
Message-ID: <bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltcwexnrsjsdx@mgkdf6ztow42>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

After commit ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error
recovery mechanism"), our DSI display stopped working correctly. The
display internally uses a TI SN65DSI83 to convert DSI-to-LVDS, and with
the change, it keeps blinking on and off because the bridge is being
reset by the error recovery mechanism.

Even before the change, it was possible to see the message below from
the driver indicating that the bridge's internal PLL was not locked
(register 0xE5, bit 0 in [1]):

[ 11.198616] sn65dsi83 2-002c: Unexpected link status 0x01

However, it was working. After the change, it stopped working. Masking
the PLL error makes it work again:

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 033c44326552..89a0a2ab45b1 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -429,7 +429,7 @@ static void sn65dsi83_handle_errors(struct sn65dsi83 *ctx)
         */

        ret = regmap_read(ctx->regmap, REG_IRQ_STAT, &irq_stat);
-       if (ret || irq_stat) {
+       if (ret || (irq_stat & ~REG_IRQ_STAT_CHA_PLL_UNLOCK)) {
                /*
                 * IRQ acknowledged is not always possible (the bridge can be in
                 * a state where it doesn't answer anymore). To prevent an

Any suggestions on how to proceed here?

#regzbot introduced: ad5c6ecef27e

[1] https://www.ti.com/lit/ds/symlink/sn65dsi83.pdf

Best Regards,
João Paulo Gonçalves

