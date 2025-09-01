Return-Path: <linux-kernel+bounces-794317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A9B3DFEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F873B829E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F23081A9;
	Mon,  1 Sep 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lEubheKh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CE1AB6F1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721930; cv=none; b=QnmxzTE18Fm9PTQW7s6rFlEcj3iRcynVXeWvw4po2bg2E3NFD+jGNaHlQejtWFJbA7lnf1Uj7JZ+IVI2Gm69Kpc3abvPBdM2QKSp+WEn3VN+Yq0dRerMA7OMCQnZJHRdLRsnez+MWSjbhNmXYrhSCVl/K/rsI9AeEogdPbc47+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721930; c=relaxed/simple;
	bh=iOkaljgYLSdO8hKFV+fAbOx0CUR35mexW82LJfDAoR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLrTOF62GjzTNl24V/LWua8hMLickw5Wel5hnfan8SlgJoGoJSBFeONzrdFn/MeEh1H9TCftKU1ZGu9jx73tJLEl2TpBOj1H25EX6vQ0a61up4JP4/Uz6sJurAOcsBk2kBimXL72CMWbGHSccDbW9FU0vFTr9SDDT0bey2G8ZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lEubheKh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 67E51E92;
	Mon,  1 Sep 2025 12:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756721859;
	bh=iOkaljgYLSdO8hKFV+fAbOx0CUR35mexW82LJfDAoR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lEubheKh9ZKfSHprC4cLb66haXZSQgnd+cQtRkfv9FYi6OiwLURM6fHJVya0WFB9C
	 8VTz2hmDJoOjFQZspb+s35JjYp2WojP8Cote8kQ9pmVfsfMKvov+NtFyCbNbbN5+V2
	 1UCfne1boUUM+fq/fNU+T4vdLVOzHSyc2MPYhFvU=
Message-ID: <4e7fb22e-8b15-46e5-906b-9b2aa65f2911@ideasonboard.com>
Date: Mon, 1 Sep 2025 13:18:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] drm/bridge: cadence: cdns-mhdp8546-core: Handle
 HDCP state in bridge atomic check
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, lyude@redhat.com, luca.ceresoli@bootlin.com,
 viro@zeniv.linux.org.uk, andy.yan@rock-chips.com, linux@treblig.org,
 javierm@redhat.com, linux-kernel@vger.kernel.org, devarsht@ti.com,
 j-choudhary@ti.com, u-kumar1@ti.com, s-jain1@ti.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, mripard@kernel.org, lumag@kernel.org,
 dianders@chromium.org, dri-devel@lists.freedesktop.org
References: <20250811075904.1613519-1-h-shenoy@ti.com>
 <20250811075904.1613519-7-h-shenoy@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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
In-Reply-To: <20250811075904.1613519-7-h-shenoy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/08/2025 10:59, Harikrishna Shenoy wrote:
> Now that we have DBANC framework and legacy connector functions removed,
> handle the HDCP disabling in bridge atomic check rather than in connector
> atomic check previously.

Both this and the patch 4 make me feel a bit confused: In patch 1 a
bunch of code is removed. Then in patches 4 and 6 we add it back. Yes,
we don't add it back the same way, but this raises the question if the
first patch then breaks these two features, until patches 4 and 6 add it
back.

Or is the case that with DRM_BRIDGE_ATTACH_NO_CONNECTOR, which is the
way tidss uses this, none of the code removed in patch 1 was even being
called? And thus, in theory, patches 4 and 6 could even be added before
patch 1?

The patches nor the cover letter really explain well what's going on
here. The "fixes" tags also confuse me. So is the current upstream
driver working fine or not? Are there bugs? It would be good to fix
those bugs first, then do the cleanup of removing the old code. Maybe
that's difficult to do and this patch order makes sense, but it's all
left very unclear to the reviewer.

 Tomi

> 
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 4fb1db3e030c..af41b2908a74 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1960,6 +1960,10 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>  {
>  	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>  	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> +	struct drm_connector_state *old_state, *new_state;
> +	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_connector *conn = mhdp->connector;
> +	u64 old_cp, new_cp;
>  
>  	mutex_lock(&mhdp->link_mutex);
>  
> @@ -1979,6 +1983,25 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>  	if (mhdp->info)
>  		bridge_state->input_bus_cfg.flags = *mhdp->info->input_bus_flags;
>  
> +	if (conn && mhdp->hdcp_supported) {
> +		old_state = drm_atomic_get_old_connector_state(state, conn);
> +		new_state = drm_atomic_get_new_connector_state(state, conn);
> +		old_cp = old_state->content_protection;
> +		new_cp = new_state->content_protection;
> +
> +		if (old_state->hdcp_content_type != new_state->hdcp_content_type &&
> +		    new_cp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> +			new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +			crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +			crtc_state->mode_changed = true;
> +		}
> +
> +		if (!new_state->crtc) {
> +			if (old_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
> +				new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +		}
> +	}
> +
>  	mutex_unlock(&mhdp->link_mutex);
>  	return 0;
>  }


