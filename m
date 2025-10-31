Return-Path: <linux-kernel+bounces-880456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39EEC25C70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E993BF99C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463E244677;
	Fri, 31 Oct 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZYCfMBM1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0323AE66
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923419; cv=none; b=UqrD+Go1ixKE/hLfjt9XPv3I+gVpBMikUgBszgM5ipruUJuoPxqqdPEokg4bKz4WuD+Ght8l9SDYWu+XwNMBIHiBJF6YDa20MAMb988YuSalyCJrA2Yb+6lnGSK0nSEDgUHT/Z8kKle0uOgXhM2YlyQAKc6Ta9dktJYsc4bnRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923419; c=relaxed/simple;
	bh=02uKFyjmhp/31Of469WNJVCBYJx1tJ2NJXz1wl4zDWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQ3JPs5SsIC00SnZaiwcRBkOGYkuLMaPhTwgRrLL+tz4iNzqF9ZeU+/jKjCSm9hp9irQ8cfNV1igW5b+2TPpG7D57s65wbOjw55gluBc0VQx2qyGHtmCohz5vSwDdjIEthvRwACCVHz7T5uKH2KKCz/1lz7Rf34qAjIWJ9tzYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZYCfMBM1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 101DF99F;
	Fri, 31 Oct 2025 16:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761923303;
	bh=02uKFyjmhp/31Of469WNJVCBYJx1tJ2NJXz1wl4zDWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZYCfMBM13ss1ybwr4VB/7vvoeR3b7JSAfTfPfiUOwM1LrgQQjk7R3FGCG4Xt7HMAl
	 fLmM5U38dY0kl9NIHNkYvm0CV6v7zR2tjXMGLTsXyrf7OeAeO8eSH3vbUXhldKNBO8
	 tM8nxLlh0+EG+DQaKOFveRcdL37CwBz/znm01xoo=
Message-ID: <138857f0-969d-4e99-aafd-d0c4e9aefb66@ideasonboard.com>
Date: Fri, 31 Oct 2025 17:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/bridge: sii902x: Fix HDMI detection with
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
To: Devarsh Thakkar <devarsht@ti.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, jani.nikula@intel.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Cc: praneeth@ti.com, vigneshr@ti.com, aradhya.bhatia@linux.dev,
 s-jain1@ti.com, s-wang12@ti.com, r-donadkar@ti.com, h-shenoy@ti.com,
 dmitry.baryshkov@oss.qualcomm.com
References: <20251030151635.3019864-1-devarsht@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 xsFNBE6ms0cBEACyizowecZqXfMZtnBniOieTuFdErHAUyxVgtmr0f5ZfIi9Z4l+uUN4Zdw2
 wCEZjx3o0Z34diXBaMRJ3rAk9yB90UJAnLtb8A97Oq64DskLF81GCYB2P1i0qrG7UjpASgCA
 Ru0lVvxsWyIwSfoYoLrazbT1wkWRs8YBkkXQFfL7Mn3ZMoGPcpfwYH9O7bV1NslbmyJzRCMO
 eYV258gjCcwYlrkyIratlHCek4GrwV8Z9NQcjD5iLzrONjfafrWPwj6yn2RlL0mQEwt1lOvn
 LnI7QRtB3zxA3yB+FLsT1hx0va6xCHpX3QO2gBsyHCyVafFMrg3c/7IIWkDLngJxFgz6DLiA
 G4ld1QK/jsYqfP2GIMH1mFdjY+iagG4DqOsjip479HCWAptpNxSOCL6z3qxCU8MCz8iNOtZk
 DYXQWVscM5qgYSn+fmMM2qN+eoWlnCGVURZZLDjg387S2E1jT/dNTOsM/IqQj+ZROUZuRcF7
 0RTtuU5q1HnbRNwy+23xeoSGuwmLQ2UsUk7Q5CnrjYfiPo3wHze8avK95JBoSd+WIRmV3uoO
 rXCoYOIRlDhg9XJTrbnQ3Ot5zOa0Y9c4IpyAlut6mDtxtKXr4+8OzjSVFww7tIwadTK3wDQv
 Bus4jxHjS6dz1g2ypT65qnHen6mUUH63lhzewqO9peAHJ0SLrQARAQABzTBUb21pIFZhbGtl
 aW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT7CwY4EEwEIADgWIQTEOAw+
 ll79gQef86f6PaqMvJYe9QUCX/HruAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD6
 PaqMvJYe9WmFD/99NGoD5lBJhlFDHMZvO+Op8vCwnIRZdTsyrtGl72rVh9xRfcSgYPZUvBuT
 VDxE53mY9HaZyu1eGMccYRBaTLJSfCXl/g317CrMNdY0k40b9YeIX10feiRYEWoDIPQ3tMmA
 0nHDygzcnuPiPT68JYZ6tUOvAt7r6OX/litM+m2/E9mtp8xCoWOo/kYO4mOAIoMNvLB8vufi
 uBB4e/AvAjtny4ScuNV5c5q8MkfNIiOyag9QCiQ/JfoAqzXRjVb4VZG72AKaElwipiKCWEcU
 R4+Bu5Qbaxj7Cd36M/bI54OrbWWETJkVVSV1i0tghCd6HHyquTdFl7wYcz6cL1hn/6byVnD+
 sR3BLvSBHYp8WSwv0TCuf6tLiNgHAO1hWiQ1pOoXyMEsxZlgPXT+wb4dbNVunckwqFjGxRbl
 Rz7apFT/ZRwbazEzEzNyrBOfB55xdipG/2+SmFn0oMFqFOBEszXLQVslh64lI0CMJm2OYYe3
 PxHqYaztyeXsx13Bfnq9+bUynAQ4uW1P5DJ3OIRZWKmbQd/Me3Fq6TU57LsvwRgE0Le9PFQs
 dcP2071rMTpqTUteEgODJS4VDf4lXJfY91u32BJkiqM7/62Cqatcz5UWWHq5xeF03MIUTqdE
 qHWk3RJEoWHWQRzQfcx6Fn2fDAUKhAddvoopfcjAHfpAWJ+ENc7BTQROprNHARAAx0aat8GU
 hsusCLc4MIxOQwidecCTRc9Dz/7U2goUwhw2O5j9TPqLtp57VITmHILnvZf6q3QAho2QMQyE
 DDvHubrdtEoqaaSKxKkFie1uhWNNvXPhwkKLYieyL9m2JdU+b88HaDnpzdyTTR4uH7wk0bBa
 KbTSgIFDDe5lXInypewPO30TmYNkFSexnnM3n1PBCqiJXsJahE4ZQ+WnV5FbPUj8T2zXS2xk
 0LZ0+DwKmZ0ZDovvdEWRWrz3UzJ8DLHb7blPpGhmqj3ANXQXC7mb9qJ6J/VSl61GbxIO2Dwb
 xPNkHk8fwnxlUBCOyBti/uD2uSTgKHNdabhVm2dgFNVuS1y3bBHbI/qjC3J7rWE0WiaHWEqy
 UVPk8rsph4rqITsj2RiY70vEW0SKePrChvET7D8P1UPqmveBNNtSS7In+DdZ5kUqLV7rJnM9
 /4cwy+uZUt8cuCZlcA5u8IsBCNJudxEqBG10GHg1B6h1RZIz9Q9XfiBdaqa5+CjyFs8ua01c
 9HmyfkuhXG2OLjfQuK+Ygd56mV3lq0aFdwbaX16DG22c6flkkBSjyWXYepFtHz9KsBS0DaZb
 4IkLmZwEXpZcIOQjQ71fqlpiXkXSIaQ6YMEs8WjBbpP81h7QxWIfWtp+VnwNGc6nq5IQDESH
 mvQcsFS7d3eGVI6eyjCFdcAO8eMAEQEAAcLBXwQYAQIACQUCTqazRwIbDAAKCRD6PaqMvJYe
 9fA7EACS6exUedsBKmt4pT7nqXBcRsqm6YzT6DeCM8PWMTeaVGHiR4TnNFiT3otD5UpYQI7S
 suYxoTdHrrrBzdlKe5rUWpzoZkVK6p0s9OIvGzLT0lrb0HC9iNDWT3JgpYDnk4Z2mFi6tTbq
 xKMtpVFRA6FjviGDRsfkfoURZI51nf2RSAk/A8BEDDZ7lgJHskYoklSpwyrXhkp9FHGMaYII
 m9EKuUTX9JPDG2FTthCBrdsgWYPdJQvM+zscq09vFMQ9Fykbx5N8z/oFEUy3ACyPqW2oyfvU
 CH5WDpWBG0s5BALp1gBJPytIAd/pY/5ZdNoi0Cx3+Z7jaBFEyYJdWy1hGddpkgnMjyOfLI7B
 CFrdecTZbR5upjNSDvQ7RG85SnpYJTIin+SAUazAeA2nS6gTZzumgtdw8XmVXZwdBfF+ICof
 92UkbYcYNbzWO/GHgsNT1WnM4sa9lwCSWH8Fw1o/3bX1VVPEsnESOfxkNdu+gAF5S6+I6n3a
 ueeIlwJl5CpT5l8RpoZXEOVtXYn8zzOJ7oGZYINRV9Pf8qKGLf3Dft7zKBP832I3PQjeok7F
 yjt+9S+KgSFSHP3Pa4E7lsSdWhSlHYNdG/czhoUkSCN09C0rEK93wxACx3vtxPLjXu6RptBw
 3dRq7n+mQChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
In-Reply-To: <20251030151635.3019864-1-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 30/10/2025 17:16, Devarsh Thakkar wrote:
> The sii902x driver was caching HDMI detection state in a sink_is_hdmi field
> and checking it in mode_set() to determine whether to set HDMI or DVI
> output mode. This approach had two problems:
> 
> 1. With DRM_BRIDGE_ATTACH_NO_CONNECTOR (used by modern display drivers like
> TIDSS), the bridge's get_modes() is never called. Instead, the
> drm_bridge_connector helper calls the bridge's edid_read() and updates the
> connector itself. This meant sink_is_hdmi was never populated, causing the
> driver to default to DVI mode and breaking HDMI audio.
> 
> 2. The mode_set() callback doesn't receive atomic state or connector
> pointer, making it impossible to check connector->display_info.is_hdmi
> directly at that point.
> 
> Fix this by moving the HDMI vs DVI decision from mode_set() to
> atomic_enable(), where we can access the connector via
> drm_atomic_get_new_connector_for_encoder(). This works for both connector
> models:
> 
> - With DRM_BRIDGE_ATTACH_NO_CONNECTOR: Returns the drm_bridge_connector
>   created by the display driver, which has already been updated by the
> helper's call to drm_edid_connector_update()
> 
> - Without DRM_BRIDGE_ATTACH_NO_CONNECTOR (legacy): Returns the connector
>   embedded in sii902x struct, which gets updated by the bridge's own
> get_modes()
> 
> Fixes: 3de47e1309c2 ("drm/bridge: sii902x: use display info is_hdmi")
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V4: Shift HDMI detection to atomic_enable() and remove sink_is_hdmi caching
> V3: Use drm_edid_connector_update without edid NULL check
> V2: Use drm_edid_connector_update to detect HDMI
> 
> Link to V3:
> https://lore.kernel.org/all/20251007112309.1103811-1-devarsht@ti.com/
> Link to V2:
> https://lore.kernel.org/all/20251006150714.3144368-1-devarsht@ti.com/
> Link to V1:
> https://lore.kernel.org/all/20251003143642.4072918-1-devarsht@ti.com/
> 
>  drivers/gpu/drm/bridge/sii902x.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index d537b1d036fb..1f0aba28ad1e 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -179,7 +179,6 @@ struct sii902x {
>  	struct drm_connector connector;
>  	struct gpio_desc *reset_gpio;
>  	struct i2c_mux_core *i2cmux;
> -	bool sink_is_hdmi;
>  	u32 bus_width;
>  
>  	/*
> @@ -315,8 +314,6 @@ static int sii902x_get_modes(struct drm_connector *connector)
>  		drm_edid_free(drm_edid);
>  	}
>  
> -	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
> -
>  	return num;
>  }
>  
> @@ -342,9 +339,17 @@ static void sii902x_bridge_atomic_enable(struct drm_bridge *bridge,
>  					 struct drm_atomic_state *state)
>  {
>  	struct sii902x *sii902x = bridge_to_sii902x(bridge);
> +	struct drm_connector *connector;
> +	u8 output_mode = SII902X_SYS_CTRL_OUTPUT_DVI;
> +
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	if (connector && connector->display_info.is_hdmi)
> +		output_mode = SII902X_SYS_CTRL_OUTPUT_HDMI;
>  
>  	mutex_lock(&sii902x->mutex);
>  
> +	regmap_update_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA,
> +			   SII902X_SYS_CTRL_OUTPUT_MODE, output_mode);
>  	regmap_update_bits(sii902x->regmap, SII902X_PWR_STATE_CTRL,
>  			   SII902X_AVI_POWER_STATE_MSK,
>  			   SII902X_AVI_POWER_STATE_D(0));
> @@ -359,16 +364,12 @@ static void sii902x_bridge_mode_set(struct drm_bridge *bridge,
>  				    const struct drm_display_mode *adj)
>  {
>  	struct sii902x *sii902x = bridge_to_sii902x(bridge);
> -	u8 output_mode = SII902X_SYS_CTRL_OUTPUT_DVI;
>  	struct regmap *regmap = sii902x->regmap;
>  	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
>  	struct hdmi_avi_infoframe frame;
>  	u16 pixel_clock_10kHz = adj->clock / 10;
>  	int ret;
>  
> -	if (sii902x->sink_is_hdmi)
> -		output_mode = SII902X_SYS_CTRL_OUTPUT_HDMI;
> -
>  	buf[0] = pixel_clock_10kHz & 0xff;
>  	buf[1] = pixel_clock_10kHz >> 8;
>  	buf[2] = drm_mode_vrefresh(adj);
> @@ -384,11 +385,6 @@ static void sii902x_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	mutex_lock(&sii902x->mutex);
>  
> -	ret = regmap_update_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA,
> -				 SII902X_SYS_CTRL_OUTPUT_MODE, output_mode);
> -	if (ret)
> -		goto out;
> -
>  	ret = regmap_bulk_write(regmap, SII902X_TPI_VIDEO_DATA, buf, 10);
>  	if (ret)
>  		goto out;

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

 Tomi


