Return-Path: <linux-kernel+bounces-818300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F8B58F97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EC41BC55E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AEA22A4E5;
	Tue, 16 Sep 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KIXSyMCa"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144062797BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008874; cv=none; b=qZScqKIp8gvMagUot25+v71XzwKI0y0ChylzMN0yKYuIiKebm9F6HVz0qWTtS74hRWSuzJszf7Ryyc5gAguMV3ZXrblNOVJuJWGvj/M2zdFWOCy2osOs2FRPWZHpFkTzSdO6dwU2zIUyEIkz1EJ4lTZp0eSnD2/b+i1Pnqq2S4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008874; c=relaxed/simple;
	bh=rPVACG4lvxH9WkjbStd0UG12aS32ehrvjsNs440hf14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikK9DhG1ZFTYszVvoSEiwNQPWY377GOsh/bT4mnWUJmDZrh8xRiqnnCAchnrsSZcHYeeXjp2PRrirTy1f/LEDN6FiqGLanuf2JIws5ZEwV2MkVdthQ73ao5k9OiYZ9FDHub+lbKd/I6aJy1cGfIGKUb+zVFcbXPB/JlI6IA6ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KIXSyMCa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e9042021faso1777664f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758008869; x=1758613669; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtKFlQh+rgS2OBNXT81z/HpP/1PZSXgKCEKufgx4uds=;
        b=KIXSyMCa1R0m0YmwkecFAcuxvkrogE0vzXkd2PR7fi132CcDNNPBRAoKaHp12JbSyN
         sWVGeXMFrEvyP/0SZPXhCu7wY6q0xbvG8D3LT9iGAPu2ZQ4a2sarXQ8InQAyr70d42X3
         EXaycx2HVgH/3aQ76Q4sqPTrh9Nt6fzqexa8X7q1/w2cZQrEO9stOxEUkYHT6+lN8HzY
         DfRkEPx3zb6SMYFxZ6EsH2bTBcfLpeyGvFn8Lr3s2eGpQpjvRo7C6rIg7J2JNkK6Wg73
         0r/v26k48GD0YwsXt2sjNyLjjllXdBiCleblQIj1eb4UGH+Wm3MhArxFiIR0P8Iol6tt
         JMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008869; x=1758613669;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtKFlQh+rgS2OBNXT81z/HpP/1PZSXgKCEKufgx4uds=;
        b=gJf9zEuoYQLEnitdlkucSJn+vjfuSsTHirB2bZSFnIaQDxfwV8+IpKAxj32zIqnh/d
         QMls8KRZ4xJwyq0nrDUk5B1lSGzBRnZvEs1OlOZfJ+aKzGqolPdcTTWBGIWaeOT3UBwC
         8xgoQwtQgFapUCgulpKApfyarl8HgZeaQ5LOA40lPZt2d3b167WbTfYOmiZUSkOQrw+/
         mUKrMU4fD7L7J0LbmLcxJwwCkhfdxqnI0S1M25T1edVvYQOSFdheaAow2mR0He0L8c5P
         9AD2n8WdZLCQYldp9wumVPkTQI7rS6e2Yi1QGCmzA9mqYJ9aG5O5WJmJpTqdc990Yf/v
         maBA==
X-Forwarded-Encrypted: i=1; AJvYcCXBfyEzDfd17UJCoMHYPLcaijf08undbsf5gh83/KinS6ezjvIGyIymt9LbnZRBNPFJUerk3RDlDVmpf/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5OizpLrEDuaHSv08Kz86sRUN9oK8dhwke/5yuI1kx2GXvU+L
	k3UMeHli4RRltY46M5f3zzW6yb820DSkEdwd53xaqDMoQIUMLFmFa9RqNFem7MY2iL4=
X-Gm-Gg: ASbGncv0C76A2eHJU/xWQ0yFZUFiHh2W05hkEkM/bj4pwvXQd9r4yK0wOJ9NgJyHQxX
	uUqwaJGmFsT05WewgZNrQXezO7y4zLDbMFAvP3fsW8nNkYhumTdxEBFKE7hSZBavG8HDjMQ2uy+
	MYmUPXUn9A3pZpp9WKx9JaA/V+71K84shHtun28DGm+tX5JPGnYVkYmfMN72FfbUVEBPaIqVFO4
	aX1v9VCvptQUjj561LIn7N4/o996I6RdkNUPgtWrIvNo6sOPW4KP6ZpyWa+Cb5WJy65WDHZvbiR
	CLPz+grY9UvS910hteL3POSbKoWlTKjxgqNJJjaSk4rygjaWjNZAn4VDURqF07M/HUrvDdzzqey
	xns0TV7EubrMx8y2mNECg
X-Google-Smtp-Source: AGHT+IHFvGzslxXy4KwOm1ooC56uMKQXwQ1Zj1Upo1YdNgdF6b6Vs+dYtvJRY+alye5YC/5QpkTOXw==
X-Received: by 2002:a05:6000:24c7:b0:3d1:e1b1:9640 with SMTP id ffacd0b85a97d-3e7659f3afbmr10403889f8f.30.1758008869244;
        Tue, 16 Sep 2025 00:47:49 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a6cd:21af:56e0:521])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7d369ea3bsm15452393f8f.0.2025.09.16.00.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:47:48 -0700 (PDT)
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
Subject: Re: [PATCH v5 2/2] clk: amlogic: add video-related clocks for S4 SoC
In-Reply-To: <20250916-add_video_clk-v5-2-e25293589601@amlogic.com> (Chuan Liu
	via's message of "Tue, 16 Sep 2025 10:06:07 +0800")
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
	<20250916-add_video_clk-v5-2-e25293589601@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 16 Sep 2025 09:47:47 +0200
Message-ID: <1j5xdij0t8.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 16 Sep 2025 at 10:06, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add video encoder, demodulator and CVBS clocks.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/s4-peripherals.c | 206 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 202 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index 6d69b132d1e1..ba41fcd90588 100644
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
> @@ -1106,7 +1107,6 @@ static struct clk_regmap s4_cts_enci_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_cts_parents,
>  		.num_parents = ARRAY_SIZE(s4_cts_parents),
> -		.flags = CLK_SET_RATE_PARENT,

Change unrelated to the description.

>  	},
>  };
>  
> @@ -1122,7 +1122,21 @@ static struct clk_regmap s4_cts_encp_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_cts_parents,
>  		.num_parents = ARRAY_SIZE(s4_cts_parents),
> -		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
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
>  	},
>  };
>  
> @@ -1138,7 +1152,6 @@ static struct clk_regmap s4_cts_vdac_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_cts_parents,
>  		.num_parents = ARRAY_SIZE(s4_cts_parents),
> -		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -1169,7 +1182,6 @@ static struct clk_regmap s4_hdmi_tx_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = s4_hdmi_tx_parents,
>  		.num_parents = ARRAY_SIZE(s4_hdmi_tx_parents),
> -		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -1205,6 +1217,22 @@ static struct clk_regmap s4_cts_encp = {
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
> @@ -2735,6 +2763,165 @@ static struct clk_regmap s4_gen_clk = {
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
> @@ -3028,6 +3215,17 @@ static struct clk_hw *s4_peripherals_hw_clks[] = {
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

