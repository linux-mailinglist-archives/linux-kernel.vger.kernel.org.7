Return-Path: <linux-kernel+bounces-809858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D865B512E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DDC189FD45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BA3148B7;
	Wed, 10 Sep 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OuRMaL9S"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E2313E2E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497320; cv=none; b=OfHiLjhiGCgSoQf48mcviEfu1CVC9B4iuraESSY8FTYTzfr4Qp25wTN+d197fOvDT99/5+zOtdlUGVKpwC6bRQinL7Wbnuy/yEK6Z/crF1ZB6Nshf7hV1ji0K4u0STNopxYTQ6GFkFAPsOrbbFh/oMuQpBVtupN1oDZDzIJvA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497320; c=relaxed/simple;
	bh=TBOyz5XF2Xafm9XcIDOjhJZALVaCDkLt8Lqpf+qFVvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBUEt3+Ku4qQy68itzi6I3+nI+WccyNXpcEKmrbIBRIaMvUXsiuiyDjPCzvYZFYjqRGhmtogge5zf00WYZLBNyVj0rLpKdxLwIcRlMXPNdsZBH3EEziGLcPnn4w2zTs5UHyjApbzqfuhL0CNmQ6/HtYgVXCcdl0md/4cLHAj6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OuRMaL9S; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dad6252eacso3008286f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757497317; x=1758102117; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OBSNMCSZFkYoD+gDD6u3qKCw6C8XYzkirO4cLs6lbo=;
        b=OuRMaL9Ss7DmGq7Fi3lxLmbR0YOoaPzATo+OhzBAWM3GaF4Xptx443uaeIHllmFTI7
         rVNFWkkdgTq79C829ISDxVDigjpkQep5ep/hxCbAm3KhyMyoNGw5yGPcaPSy3xPcCPaV
         iGUfhq3t+YWzvFSUFwvK7P/nGhOPoOwqyRBR7mjHVkJQh/B85KB/VB3U/4jCKY+qW5KJ
         RjMKyWQcvfaNA8k+NEiMMfucfKLkpbSlsmOxhqmjfB5EbCSVQwvCytLEvxHuPq8v2nU4
         EArvSiCf9FEi48EhaZ8iZwEEJzQBlP+s+iEIQgvy1YddLar5npn7Vt0+8p5LwCmYnFIA
         6TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497317; x=1758102117;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OBSNMCSZFkYoD+gDD6u3qKCw6C8XYzkirO4cLs6lbo=;
        b=W46Jm6mXY4zbeay5rx6nBNMD1MFDCGCRoJNup8It9Uo/Yxyiew/TxFejZU/PdJC1sN
         4swcpoblXT5SrvgDxAF9iV4L5jLe78U1FdX4AEn6vzdSG1pcb4o7w7jxVJ83JJaJtQCJ
         ZF5unjICvzMhTe6nUkUvH6qXfM0kHmmS6SeS55u90jkLWq5peBcMljWBogyVY5XLJIXY
         8PZdn71tNfIsqYRs5UfU6tSQmMAnPyQOGuiK3qSVDIBJPQ9zU7BAANzdkIIFNqI+AgGM
         T79GUTR8l6ggGaHbxsE3QFdNBE4ruabaa09sqKo/wqaHVEjY7eyCG7wbtfEAxLVEDTBF
         JaiA==
X-Forwarded-Encrypted: i=1; AJvYcCUItB3hmz5l1Wm91PqPst0M+xtfDwLEpYCjF2ba8XuObi4wNmAOOHCZa83tqjImGD9DH/tP1ZmslbpkOqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqVFQFWnhKWQqt0yFhyxiJD9VpOhdFNWnULAFcT1pfdWrufjS
	aVEwQsLIIdTKc/zB51rY3pwxAOSKquC8uMskH0QxJeZlDWCLcyzu09E4yf6BqSL/FDQ=
X-Gm-Gg: ASbGncuZ0LbtKGo+Paq6JU+gc8bdohMq4u+h6v3+Gsx9Lvs8Yag8V0EIUJp3oeXfUPC
	e4GQ6pfb0SLP2D3pnSWR5wXeoE5z0YQ0C7W+GBeFSGdnbW2g1CE8LjCQy1IVjwmp5P+aDwvpqwG
	0lnN10UPS+g7wtvAeeB+WJLVrrdFyg1xXnzNSkMDnoah+K5N+Xvnu6Hp1h+zGtGsdaD6UprOPYS
	GXp8nAndZHAPcnn3Lbt28GbEczkVQkfW94XP60/TZ4bnE/cRh4Wn6WwB1/vG4JxLpGf+7he7zfT
	1XsCdfCl3PZ0u+nqu1M8uSsH4oePtBn0kNc18jUB6ZQQ6jl/RHUrM/xLXG/2Ll5LMu7+pNhVWgF
	rVhpG3PXlqOjBTp5K/IpclQLa+bdLNUGZ
X-Google-Smtp-Source: AGHT+IFhJUYuLbSMnUTSqjS1CD9WH9ciAuMmnQkgVDBas13o9m9uUxWF1IbevCk3GCBXb/HsRxReFw==
X-Received: by 2002:a05:6000:18a4:b0:3cc:8d94:1108 with SMTP id ffacd0b85a97d-3e641e3cffemr11252957f8f.22.1757497316478;
        Wed, 10 Sep 2025 02:41:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:c75e:f70c:b449:e087])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521bf85esm6365253f8f.1.2025.09.10.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:41:55 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] clk: amlogic: add video-related clocks for S4 SoC
In-Reply-To: <20250909-add_video_clk-v4-2-5e0c01d47aa8@amlogic.com> (Chuan Liu
	via's message of "Tue, 09 Sep 2025 15:29:12 +0800")
References: <20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com>
	<20250909-add_video_clk-v4-2-5e0c01d47aa8@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 10 Sep 2025 11:41:55 +0200
Message-ID: <1jv7lqiqzg.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 09 Sep 2025 at 15:29, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add video encoder, demodulator and CVBS clocks.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/s4-peripherals.c | 203 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index 6d69b132d1e1..b855e8f1fc04 100644
> --- a/drivers/clk/meson/s4-peripherals.c
> +++ b/drivers/clk/meson/s4-peripherals.c
> @@ -44,6 +44,7 @@
>  #define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
>  #define CLKCTRL_VAPBCLK_CTRL                       0x0fc
>  #define CLKCTRL_HDCP22_CTRL                        0x100
> +#define CLKCTRL_CDAC_CLK_CTRL                      0x108
>  #define CLKCTRL_VDEC_CLK_CTRL                      0x140
>  #define CLKCTRL_VDEC2_CLK_CTRL                     0x144
>  #define CLKCTRL_VDEC3_CLK_CTRL                     0x148
> @@ -1126,6 +1127,22 @@ static struct clk_regmap s4_cts_encp_sel = {
>  	},
>  };
>  
> +static struct clk_regmap s4_cts_encl_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VIID_CLK_DIV,
> +		.mask = 0xf,
> +		.shift = 12,
> +		.table = s4_cts_parents_val_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cts_encl_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = s4_cts_parents,
> +		.num_parents = ARRAY_SIZE(s4_cts_parents),
> +		.flags = CLK_SET_RATE_PARENT,

Do you really expect the rate of the parents to be adjusted when calling
set_rate() on this clock ?

It all trickle down to vclks which are shared with enci encp and vdac
clocks, so maybe not such a good idea, don't you think ?

> +	},
> +};
> +
>  static struct clk_regmap s4_cts_vdac_sel = {
>  	.data = &(struct clk_regmap_mux_data){
>  		.offset = CLKCTRL_VIID_CLK_DIV,
> @@ -1205,6 +1222,22 @@ static struct clk_regmap s4_cts_encp = {
>  	},
>  };
>  
> +static struct clk_regmap s4_cts_encl = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = CLKCTRL_VID_CLK_CTRL2,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_encl",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cts_encl_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static struct clk_regmap s4_cts_vdac = {
>  	.data = &(struct clk_regmap_gate_data){
>  		.offset = CLKCTRL_VID_CLK_CTRL2,
> @@ -2735,6 +2768,165 @@ static struct clk_regmap s4_gen_clk = {
>  	},
>  };
>  
> +/* CVBS DAC */
> +static struct clk_regmap s4_cdac_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_CDAC_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 16,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cdac_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", },
> +			{ .fw_name = "fclk_div5" },
> +		},
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap s4_cdac_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_CDAC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 16,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cdac_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cdac_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_cdac = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_CDAC_CLK_CTRL,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cdac",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_cdac_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_demod_core_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "demod_core_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal" },
> +			{ .fw_name = "fclk_div7" },
> +			{ .fw_name = "fclk_div4" }
> +		},
> +		.num_parents = 3,
> +	},
> +};
> +
> +static struct clk_regmap s4_demod_core_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "demod_core_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_demod_core_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_demod_core = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.bit_idx = 8
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "demod_core",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_demod_core_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* CVBS ADC */
> +static struct clk_regmap s4_adc_extclk_in_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "adc_extclk_in_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal" },
> +			{ .fw_name = "fclk_div4" },
> +			{ .fw_name = "fclk_div3" },
> +			{ .fw_name = "fclk_div5" },
> +			{ .fw_name = "fclk_div7" },
> +			{ .fw_name = "mpll2" },
> +			{ .fw_name = "gp0_pll" },
> +			{ .fw_name = "hifi_pll" }
> +		},
> +		.num_parents = 8,
> +	},
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "adc_extclk_in_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_adc_extclk_in_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
> +		.bit_idx = 24
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "adc_extclk_in",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_adc_extclk_in_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static const struct clk_parent_data s4_pclk_parents = { .hw = &s4_sys_clk.hw };
>  
>  #define S4_PCLK(_name, _reg, _bit, _flags) \
> @@ -3028,6 +3220,17 @@ static struct clk_hw *s4_peripherals_hw_clks[] = {
>  	[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_sel.hw,
>  	[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
>  	[CLKID_HDCP22_SKPCLK]		= &s4_hdcp22_skpclk.hw,
> +	[CLKID_CTS_ENCL_SEL]		= &s4_cts_encl_sel.hw,
> +	[CLKID_CTS_ENCL]		= &s4_cts_encl.hw,
> +	[CLKID_CDAC_SEL]		= &s4_cdac_sel.hw,
> +	[CLKID_CDAC_DIV]		= &s4_cdac_div.hw,
> +	[CLKID_CDAC]			= &s4_cdac.hw,
> +	[CLKID_DEMOD_CORE_SEL]		= &s4_demod_core_sel.hw,
> +	[CLKID_DEMOD_CORE_DIV]		= &s4_demod_core_div.hw,
> +	[CLKID_DEMOD_CORE]		= &s4_demod_core.hw,
> +	[CLKID_ADC_EXTCLK_IN_SEL]	= &s4_adc_extclk_in_sel.hw,
> +	[CLKID_ADC_EXTCLK_IN_DIV]	= &s4_adc_extclk_in_div.hw,
> +	[CLKID_ADC_EXTCLK_IN]		= &s4_adc_extclk_in.hw,
>  };
>  
>  static const struct meson_clkc_data s4_peripherals_clkc_data = {

-- 
Jerome

