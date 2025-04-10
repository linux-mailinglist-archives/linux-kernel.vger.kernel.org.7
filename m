Return-Path: <linux-kernel+bounces-598198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FAA84363
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5904B1B87CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076A28A3E0;
	Thu, 10 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SySSy58/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395672857D7;
	Thu, 10 Apr 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288628; cv=none; b=g51UzfiIMvINLZu/ZgZGlbLGmc1wihNPfr++d4HQry0QA9iYrFB22ghVqVeHRwnWDmJP9i2uWGWms1LVPs6R1hHuWjkC7h6RTmrkpb73ZXqWvqdvcYU5NM8ULQ/AjIPssBWHAMVT14L3fvmsPUWJyEi85G9p8XeE3nCsxggyqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288628; c=relaxed/simple;
	bh=siix8QxAUFHF9p1TCm1b1aqn9CeLG9tsCd6VcEJcBh0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mNmxatlsaX97sG1ye07uEacHdqexLy8fiB9eFd/Noz7jkPvdBh0xwyLOGkd5vrUZY4quc76sGU1Wi2jWlURRyAuErjV1yN8xaB2oqjtXm4tawivxBt/u3whnqSveb6c+ScOfuiVKkyMu7bOOL01egN/FgCVtUxMOYBqatBDZXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SySSy58/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4922C4CEF2;
	Thu, 10 Apr 2025 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744288627;
	bh=siix8QxAUFHF9p1TCm1b1aqn9CeLG9tsCd6VcEJcBh0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SySSy58/Eav1gMkPXW1S/wgI2Y22A2E5Hgn4LbjiVcp5TQESnRgdcxlpbr8nactGG
	 1XbzKgBbeGWfWKZ5lvme8/20HzFVyD709txXtKfPdlAe/4WcxYrxEiAF6KFMGnlAia
	 G3KImgwA9/05b8dLA0QtLSW/HbRIuCoxrs4fFs7wlM1sxqbW4sskrT7F5eO4W3DxmQ
	 +aZM2McNuKOO9xCCj51jUjsYWDxKdybe8rEGmrrSg9brhWQ1lNdb+0idsMuviJcPLb
	 T1GKrt0JIU3JslAF/tgJC8Fwq/hoWrY2CMs6UV8kp0uMhfqzufzvBdv/iJVHXee65o
	 n3uJRgwSUMeXQ==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id AB04F1200043;
	Thu, 10 Apr 2025 08:37:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 08:37:05 -0400
X-ME-Sender: <xms:cbv3Z5s9-gGAG3dDSWX3VomfzKKEubmWVa7mSbgVScgwNG2ybcxyKw>
    <xme:cbv3ZyeZvyecKTSujrReceM3Mn_sWrM--7k8w-pP_7rTHb9Pz4opP2nM0k31qxSoT
    SebmWxlrVZ7cptrDBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnh
    gvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfef
    feeitdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvg
    hlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohephh
    gvihhkohdrshhtuhgvsghnvghrsegthhgvrhhrhidruggvpdhrtghpthhtohepughirghn
    uggvrhhssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehsihhmohhnrgesfhhffi
    hllhdrtghhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphht
    thhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhope
    hnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhushhtihhnshhtihhtthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmh
    horhgsohesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:cbv3Z8yXgQnxLe6zI6FSbEhMDhg7qo02kR0rGIHDoIV4cs-GOcmEYA>
    <xmx:cbv3ZwNWgpeJJB32nMRE8jW4wrRNCrSdTloRJ26XBnbFQbpXUnOcYQ>
    <xmx:cbv3Z58VzbxJbvLlmYhmKrIm31t7guCvrDThcDyR3T-JVZ6jnsnUXA>
    <xmx:cbv3ZwWrOfavbBv_5zQw8c4RtSzPeof7iMRuwaPfuCE_ZyB2ws8lfg>
    <xmx:cbv3Z6fgbReSz6Dtcquvnp-KhRSvf8u1B7_cDeAq0UTPSrznMl7CKjAR>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71F202220073; Thu, 10 Apr 2025 08:37:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2c1dd8538360b27d
Date: Thu, 10 Apr 2025 14:36:45 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Nathan Chancellor" <nathan@kernel.org>,
 "Heiko Stuebner" <heiko.stuebner@cherry.de>,
 "Andy Yan" <andy.yan@rock-chips.com>
Cc: "laurent.pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Doug Anderson" <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <220ed0fb-1ccb-4371-9b5a-a99dfdc84984@app.fastmail.com>
In-Reply-To: <30e22523-216f-41a9-b931-e90136a45378@app.fastmail.com>
References: <20250408175116.1770876-1-arnd@kernel.org>
 <30e22523-216f-41a9-b931-e90136a45378@app.fastmail.com>
Subject: Re: [PATCH] drm/bridge/synopsys: avoid field overflow warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 9, 2025, at 09:07, Arnd Bergmann wrote:
> On Tue, Apr 8, 2025, at 19:51, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> clang-16 and earlier complain about what it thinks might be an out of
>> range number:
>>
>> drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:348:8: error: call to 
>> __compiletime_assert_579 declared with 'error' attribute: FIELD_PREP: 
>> value too large for the field
>>                      PHY_SYS_RATIO(tmp));
>>                      ^
>> drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c:90:27: note: expanded 
>> from macro 'PHY_SYS_RATIO'
>>  #define PHY_SYS_RATIO(x)                FIELD_PREP(GENMASK(16, 0), x)
>>
>
> I still see the same build failure in some other configurations even
> with this patch. Please disregard this version, I'll try to come
> up with a better one.

I couldn't come up with anything that actually worked, other than
the hack below, which just works around the compiletime error
in FIELD_PREP(), but doesn't look like a proper fix.

If anyone else has any ideas, I can test their patch.

       Arnd

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index c76f5f2e74d1..8ba528462ede 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -344,7 +344,7 @@ static void dw_mipi_dsi2_phy_ratio_cfg(struct dw_mipi_dsi2 *dsi2)
         */
        tmp = DIV_ROUND_CLOSEST_ULL(phy_hsclk << 16, sys_clk);
        regmap_write(dsi2->regmap, DSI2_PHY_SYS_RATIO_MAN_CFG,
-                    PHY_SYS_RATIO(tmp));
+                    PHY_SYS_RATIO(tmp & GENMASK(16, 0)));
 }
 
 static void dw_mipi_dsi2_lp2hs_or_hs2lp_cfg(struct dw_mipi_dsi2 *dsi2)

