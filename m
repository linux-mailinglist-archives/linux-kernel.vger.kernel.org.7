Return-Path: <linux-kernel+bounces-614511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DEDA96D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1115516907F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDA4C85;
	Tue, 22 Apr 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G/wBOQYu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E561EE7BC;
	Tue, 22 Apr 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330029; cv=none; b=I3gVC+Z1tcn2hCweqvP+Pby8tVP1BgYWh8+lRl1wHITIdabRB163QK4/29rcUd5ryrZrSgFW/AhqjwBK+IEfnT0PKF0jKIrcmL3aMGpK7nkRgIGHYVAT+E9BLaqlGdT8tWzQTKB+jDpDkqG4Xf2rJQ5rF8raEOAEIt1FN9CWqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330029; c=relaxed/simple;
	bh=eiFHy0TD6ojLHrM6IgI2opGeeWPGapwMgujChqNE3Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q714OIIP3ljfJz1rYPH00QNWAsQHOrb/vKbCxNkoKZ3evMYzXKrrrgaljgIc056xB7bbqE2y/9JZoC6UqIJyuF2KJXkGlj3AjqQHgl0ORaFl29GAgVOrAQLBv7KaDvd9SQNIPTqF/Nj87yiv7iouSybNfSv5R9nhYaxc3o469JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G/wBOQYu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745330025;
	bh=eiFHy0TD6ojLHrM6IgI2opGeeWPGapwMgujChqNE3Xw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G/wBOQYudLddk7OOF5sCI5SQJzSZbnlpkgWSDAJms7sqo/autmUNrS7xlyI0IzDDm
	 ceVH3EEjml+WY6L/+awdJJYerRLvRm8UUwMdV9relT7QJqfwgLjuS2j19GR7S1bQ4K
	 82tuVBf1lTVWmbyVHBvbkuXeMpVUbZUcgpZ1VzMy9tXoUaqjduZJVhOK8fyR4UNRix
	 eJ7jLyDwqJXN0Vj9rs41R3fPAKjvj57x9irAVbV2B3714m4WF9kjY8ZuyaIf6wzJSd
	 um98ujwUZ/1rFPDIsiOQQFr2ru/4EQTepMhVEtXlPLhQlPm3JsdMsZv/wgO6snv9E8
	 0H3EgD5e7FFKA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C61217E0DD1;
	Tue, 22 Apr 2025 15:53:44 +0200 (CEST)
Message-ID: <7b3713d1-df18-4da1-a1e2-16dcff08fe66@collabora.com>
Date: Tue, 22 Apr 2025 15:53:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 22/23] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, ck.hu@mediatek.com,
 jitao.shi@mediatek.com, jie.qiu@mediatek.com, junzhi.zhao@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com,
 ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com,
 jason-jh.lin@mediatek.com
References: <20250415104321.51149-1-angelogioacchino.delregno@collabora.com>
 <20250415104321.51149-23-angelogioacchino.delregno@collabora.com>
 <aestmu2rblcrcz77tuqgkimaj4stg24skyp2avdstahwr3aa3i@cfv5ov2qjcf6>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aestmu2rblcrcz77tuqgkimaj4stg24skyp2avdstahwr3aa3i@cfv5ov2qjcf6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/04/25 21:16, Dmitry Baryshkov ha scritto:
> On Tue, Apr 15, 2025 at 12:43:20PM +0200, AngeloGioacchino Del Regno wrote:
>> Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
>> found in MediaTek's MT8195, MT8188 SoC and their variants, and
>> including support for display modes up to 4k60 and for HDMI
>> Audio, as per the HDMI 2.0 spec.
>>
>> HDCP and CEC functionalities are also supported by this hardware,
>> but are not included in this commit and that also poses a slight
>> difference between the V2 and V1 controllers in how they handle
>> Hotplug Detection (HPD).
>>
>> While the v1 controller was using the CEC controller to check
>> HDMI cable connection and disconnection, in this driver the v2
>> one does not.
>>
>> This is due to the fact that on parts with v2 designs, like the
>> MT8195 SoC, there is one CEC controller shared between the HDMI
>> Transmitter (HDMI-TX) and Receiver (HDMI-RX): before eventually
>> adding support to use the CEC HW to wake up the HDMI controllers
>> it is necessary to have support for one TX, one RX *and* for both
>> at the same time.
>>
>> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/Kconfig            |    7 +
>>   drivers/gpu/drm/mediatek/Makefile           |    2 +
>>   drivers/gpu/drm/mediatek/mtk_hdmi_common.c  |    4 +
>>   drivers/gpu/drm/mediatek/mtk_hdmi_common.h  |    9 +
>>   drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c  |  385 +++++
>>   drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h |  263 ++++
>>   drivers/gpu/drm/mediatek/mtk_hdmi_v2.c      | 1396 +++++++++++++++++++
>>   7 files changed, 2066 insertions(+)
>>   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
>>   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
>>   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
>>
>> +
>> +static int mtk_hdmi_v2_setup_audio_infoframe(struct mtk_hdmi *hdmi)
>> +{
>> +	struct hdmi_codec_params *params = &hdmi->aud_param.codec_params;
>> +	struct hdmi_audio_infoframe frame;
>> +	u8 buffer[14];
>> +	ssize_t ret;
>> +
>> +	memcpy(&frame, &params->cea, sizeof(frame));
>> +
>> +	ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
>> +	if (ret < 0)
>> +		return ret;
> 
> This should really be done via
> drm_atomic_helper_connector_hdmi_update_audio_infoframe() or
> drm_atomic_helper_connector_hdmi_clear_audio_infoframe().
> 
> Ideally this should come from the .hw_params() / .prepare() calls so
> that you don't need to store the params in the driver data.
> 

When switching to the new hdmi audio helpers yes, but I was planning to do that
later.....

>> +
>> +	mtk_hdmi_v2_hw_write_audio_infoframe(hdmi, buffer);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void mtk_hdmi_v2_hw_gcp_avmute(struct mtk_hdmi *hdmi, bool mute)
>> +{
>> +	u32 val;
>> +
>> +	regmap_read(hdmi->regs, TOP_CFG01, &val);
>> +	val &= ~(CP_CLR_MUTE_EN | CP_SET_MUTE_EN);
>> +
>> +	if (mute) {
>> +		val |= CP_SET_MUTE_EN;
>> +		val &= ~CP_CLR_MUTE_EN;
>> +	} else {
>> +		val |= CP_CLR_MUTE_EN;
>> +		val &= ~CP_SET_MUTE_EN;
>> +	}
>> +	regmap_write(hdmi->regs, TOP_CFG01, val);
>> +
>> +	regmap_set_bits(hdmi->regs, TOP_INFO_RPT, CP_RPT_EN);
>> +	regmap_set_bits(hdmi->regs, TOP_INFO_EN, CP_EN | CP_EN_WR);
>> +}
>> +
>> +static void mtk_hdmi_v2_hw_ncts_enable(struct mtk_hdmi *hdmi, bool enable)
>> +{
>> +	if (enable)
>> +		regmap_set_bits(hdmi->regs, AIP_CTRL, CTS_SW_SEL);
>> +	else
>> +		regmap_clear_bits(hdmi->regs, AIP_CTRL, CTS_SW_SEL);
>> +}
>> +
>> +static void mtk_hdmi_v2_hw_aud_set_channel_status(struct mtk_hdmi *hdmi)
>> +{
>> +	u8 *ch_status = hdmi->aud_param.codec_params.iec.status;
>> +
>> +	/* Only the first 5 to 7 bytes of Channel Status contain useful information */
>> +	regmap_write(hdmi->regs, AIP_I2S_CHST0, mtk_hdmi_v2_format_hw_packet(&ch_status[0], 4));
>> +	regmap_write(hdmi->regs, AIP_I2S_CHST1, mtk_hdmi_v2_format_hw_packet(&ch_status[4], 3));
>> +}
>> +
>> +static void mtk_hdmi_v2_hw_aud_set_ncts(struct mtk_hdmi *hdmi,
>> +				     unsigned int sample_rate,
>> +				     unsigned int clock)
>> +{
>> +	unsigned int n, cts;
>> +
>> +	mtk_hdmi_get_ncts(sample_rate, clock, &n, &cts);
> 
> drm_hdmi_acr_get_n_cts() ?
> 

I'd have to update both HDMI drivers to use that instead, and I was planning to do
that at a later time when switching to the HDMI audio helpers.

>> +
>> +	regmap_write(hdmi->regs, AIP_N_VAL, n);
>> +	regmap_write(hdmi->regs, AIP_CTS_SVAL, cts);
>> +}
>> +
> 
> [...]
> 
>> +
>> +static int mtk_hdmi_v2_audio_hw_params(struct device *dev, void *data,
>> +				       struct hdmi_codec_daifmt *daifmt,
>> +				       struct hdmi_codec_params *params)
>> +{
>> +	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
>> +
>> +	if (hdmi->audio_enable) {
>> +		mtk_hdmi_audio_params(hdmi, daifmt, params);
>> +		mtk_hdmi_v2_aud_output_config(hdmi, &hdmi->mode);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int mtk_hdmi_v2_audio_startup(struct device *dev, void *data)
>> +{
>> +	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
>> +
>> +	mtk_hdmi_v2_hw_aud_enable(hdmi, true);
>> +	hdmi->audio_enable = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static void mtk_hdmi_v2_audio_shutdown(struct device *dev, void *data)
>> +{
>> +	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
>> +
>> +	hdmi->audio_enable = false;
>> +	mtk_hdmi_v2_hw_aud_enable(hdmi, false);
> 
> Most likely you need to stop sending the AUDIO packet too. Or is it dome
> by the hardware?
> 

The call to `mtk_hdmi_v2_hw_aud_enable(hdmi, false)` will set HW registers to both
mute and stop sending the audio packet.

>> +}
>> +
>> +static int mtk_hdmi_v2_audio_mute(struct device *dev, void *data, bool enable, int dir)
>> +{
>> +	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
>> +
>> +	mtk_hdmi_v2_hw_aud_mute(hdmi, enable);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct hdmi_codec_ops mtk_hdmi_v2_audio_codec_ops = {
>> +	.hw_params = mtk_hdmi_v2_audio_hw_params,
>> +	.audio_startup = mtk_hdmi_v2_audio_startup,
>> +	.audio_shutdown = mtk_hdmi_v2_audio_shutdown,
>> +	.mute_stream = mtk_hdmi_v2_audio_mute,
>> +	.get_eld = mtk_hdmi_audio_get_eld,
>> +	.hook_plugged_cb = mtk_hdmi_v2_audio_hook_plugged_cb,
>> +};
> 
> Do you plan to switch to the OP_HDMI_AUDIO? I'd really like to see
> bridges use the framework instead of implementing everthing on their
> own.
> 

I do, but since I've already reached v9, I really don't want to do that right now
and delay this driver for another two months.

I plan to do the switch after we at least get this in: as the V1 driver would also
need the same cleanup, I may even find a way to throw more stuff in the hdmi_common
when cleaning up both at the same time.

Cheers,
Angelo



