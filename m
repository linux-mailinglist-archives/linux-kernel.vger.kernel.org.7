Return-Path: <linux-kernel+bounces-848209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7FEBCCE55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D343B8413
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAED28CF6B;
	Fri, 10 Oct 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZH92PC/e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E411FA178
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099372; cv=none; b=BrBcTrONoc7UatpIAGPVXGZfAS9WIuurFjwu56Qy+oDLcjJQVjg4ge5uzT6RaN6cAXY90RJd/vmh8IDtsLr26pCbnEbs2rVIRtLVn0D+lSk+VVoUHwUdWG33RxevT7Ue5buV4AvxwIuhpICXJrjeO48NAhiQn1+opSth1fkPgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099372; c=relaxed/simple;
	bh=cT6ZvqBVD/D8IQOgCHSwTn6NYbayJueOAv5t24HimWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmiFHKhG8mVX5YfZzhLSBVqvI72ARP9DRgAKUeaGmbDGIofvkNd26bPNeOb8MgcY8IbQXifyCGlrSBOyKYiXA22OpWP/jOEdzmPL+ETWAI+hfy4mn7/00PG2kHAHVCn1garfC/l0kD2UtO4oZIYUNE68JkeIM8zF7d1lntzjAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZH92PC/e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6Wnw6008193
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QF1LCWZ7o2I4/kgoswe5lA0f
	Npob/JHWxWB1T8GiLZs=; b=ZH92PC/efiibFtSAKcdeB0aGO0KlblkrH20NiB9o
	wAwrCieUXIVnoacwPH0TnnGV/7NbGBAYCDiINGWkRtvfYeFNBRvKRQpUUQdcKdg4
	rkzMagfAVZWEtMr5LkBKV8hsl+G9PH+hdhNXZAwzkGcX0H90b3pHbD7CAv0EyEFQ
	mQ7jipYzVrhiSTJwgKIVzVRNyzicXoYyqEj3BAqx5bLodqvUePGIA06ikD8dtarm
	OoZS4PXYxzmvkMlzHxLr81Sog5yF02IwMEjHOIZGPoHvy3AiYJci+98Si7S7b6G5
	6CtFOrfcHk3KyLrp54tErDuW3zSSiM5TAGLjDH7EDQZkCA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kpce2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:29:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d6a41b5b66so93178311cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099369; x=1760704169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF1LCWZ7o2I4/kgoswe5lA0fNpob/JHWxWB1T8GiLZs=;
        b=KcBHtDUuBj8CKmXlkosAemBLHJoe0XDiMve1dFASsHd7YhSIzm69IU5IXmAAlMVfij
         V4jC7YJbDbSbrym54bFet+zw3zsTnhbENyIJFi6xDG3PmcGdm3VZJytRk3na8u91oHph
         kSJGuFkjwjWjKaEtpJOnGLGqVUX6hBzRmbTRDpcvJX7/lXS/EzDx0w2f8uU3O+8JiUA6
         qCy7XnSf8EuCKXMgmQlqvPWOHkon+1phpSjSgfnxV3ISHCkoASvRC5uORjsjGC92wNJM
         7qqyh0nbD2gZ2sohGUQXBJGnyt7y1Nexf4o6jsQNfaoXxYzBMYrCOz6AW3exoYsW3uM2
         1LRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR9zU958fgKxE2Ex6hVnAmQY159jJpD4Kw3BJtuxO60WK2m84iaLHcnDLarz/nTz7SBBGC2EBXGG1jX6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8o2bP2eYPh+QDEJ1kzEfo4NcGp/03XEVFC4blOwZLpeJpesF
	THUIoOpKlWJynzKNyH8qe6lh2CstqcXij4V7btEtZopGv1Xuaxk6IpPnDt8saApDbqUD/Rh4yZO
	QHEPcUVBDtaOOv1luUFRfB374Xv33FtbaUU4EzS4ucBK07PxHsLGQslSmoj7Y9F+m4JI=
X-Gm-Gg: ASbGnctXDwEWcY/lygtTIfy2Y01B+zGZfpa7f9O5ld+ZyNLyrJdOmzQvTH5LSgIaco2
	SSh2MjiRXpIG4H44Buvhpa20uvrcf8eLHtzcglA3fkec2FpvZ1k1e04klFt5AWAhmmFQNTVqCig
	qzbnjaNGGCIdK5Z9zYy9sby4H9+Iio1EnxEv691nGeYN0X7vfEkUweQQ0KvRiCJGwhEWO1XqHwP
	w0kE5kPaZXvU7EFtHAjn6WaAnFmnsZU4+9wEJkqBUet+BmLu9eVqGo7h4hAKVvaT9DMdh5JW6S4
	CAdoq0GveYW1HzHq7nFvH8UkWKG3czzHhT2ix3xG0bVe1bSGWmtacwPiJ1MP29O/OzFz5Y2kyRk
	G5CdGNE3oECIvwgl/p7epMEM3GhmvF6ZQYuFAf/XNqqfuKCl46Vi6
X-Received: by 2002:a05:622a:5889:b0:4d7:df9a:ee60 with SMTP id d75a77b69052e-4e6eaceba97mr157153931cf.29.1760099368538;
        Fri, 10 Oct 2025 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV3B8k5DizM201gFV+CcWBFvlDAiV9V446D58E7Th6jRZxc+76CNwjo7AV1LWg7IhxRUybgg==
X-Received: by 2002:a05:622a:5889:b0:4d7:df9a:ee60 with SMTP id d75a77b69052e-4e6eaceba97mr157153401cf.29.1760099368013;
        Fri, 10 Oct 2025 05:29:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4f26sm847059e87.9.2025.10.10.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:29:27 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:29:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
        airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Ilitek IL79900A-based
 panels
Message-ID: <g7vgqpqjhen74fzgs3k3git33bmb6fa553ndsslu3chuqh267w@uwtuutrnuue5>
References: <20251010093751.2793492-1-yelangyan@huaqin.corp-partner.google.com>
 <20251010093751.2793492-3-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010093751.2793492-3-yelangyan@huaqin.corp-partner.google.com>
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e8fc2a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=1XWaLZrsAAAA:8 a=wy7oPuJDPKlYPVI7QQcA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9XtzYAsJpMRsQaEzLfsY1flcBiFo3e6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5SowKhgscEnI
 Fs62hj7CM0JJ1nuu0+Cbyft7R4HGKZxbA0l1rsQjJPcaYhr6IZQ8X7FC9n8cbKiyCgLioOINsTK
 b0DLPkpYglBIPxm3Ktgfenhb5YsBB4KheHU/1y+x61Oim9PZ9s217YXo2bAm998NblQZv6rQ5f1
 M0tzYpBf9BOaGRZXNwEWkJblepawOoG15MWamLKVuE8Omlpixro5eM0ejW7WX8Tlt1oRhFIS49h
 f0umuvt7xndOcMLQpFdWphPTdPKCCLEeLar90nKRWU543fqIAL/3tFEgg8iAWUt/+JjY4h8U6km
 fHFFFinnoFPV3J47rwcRSYKs6RfGN9Wua+B9eoVJM3r5kGKcK6Fdv/Rot/wbcp1yJV71tH/iqkT
 SUti4tLDYuowTtm729JK0jgG4qTLVQ==
X-Proofpoint-ORIG-GUID: 9XtzYAsJpMRsQaEzLfsY1flcBiFo3e6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Fri, Oct 10, 2025 at 05:37:51PM +0800, Langyan Ye wrote:
> Add a DRM panel driver for the Ilitek IL79900A MIPI-DSI LCD controller.
> 
> The controller is used in panels such as the Tianma TL121BVMS07-00.
> It requires multiple power supplies (AVDD, AVEE, 1.8V logic), an enable
> GPIO, and a backlight device.
> 
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-il79900a.c | 394 ++++++++++++++++++
>  1 file changed, 394 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-il79900a.c
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-il79900a.c b/drivers/gpu/drm/panel/panel-ilitek-il79900a.c
> new file mode 100644
> index 000000000000..2134f8af673e
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-il79900a.c
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Panels based on the Ilitek IL79900A display controller.
> + */
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct il79900a;
> +
> +/*
> + * Use this descriptor struct to describe different panels using the
> + * Ilitek IL79900A display controller.
> + */
> +struct panel_desc {
> +	const struct drm_display_mode *modes;
> +	unsigned int bpc;
> +
> +	/**
> +	 * @width_mm: width of the panel's active display area
> +	 * @height_mm: height of the panel's active display area
> +	 */
> +	struct {
> +		unsigned int width_mm;
> +		unsigned int height_mm;
> +	} size;


Move these to the mode

> +
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +	int (*init)(struct il79900a *boe);
> +	unsigned int lanes;
> +};
> +
> +struct il79900a {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *dsi;
> +
> +	const struct panel_desc *desc;
> +
> +	enum drm_panel_orientation orientation;
> +	struct regulator *pp1800;
> +	struct regulator *avee;
> +	struct regulator *avdd;
> +	struct gpio_desc *enable_gpio;
> +};
> +
> +/* IL79900A-specific commands, add new commands as you decode them */
> +#define IL79900A_DCS_SWITCH_PAGE	0xFF
> +
> +#define il79900a_switch_page(ctx, page) \
> +	mipi_dsi_dcs_write_seq_multi(ctx, IL79900A_DCS_SWITCH_PAGE, \
> +				     0x5a, 0xa5, (page))
> +
> +static int tianma_il79900a_init(struct il79900a *ili)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
> +
> +	usleep_range(5000, 5100);

mipi_dsi_usleep_range

> +
> +	il79900a_switch_page(&ctx, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3e, 0x62);
> +
> +	il79900a_switch_page(&ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x40);
> +
> +	il79900a_switch_page(&ctx, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29, 0x00);
> +
> +	il79900a_switch_page(&ctx, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x22);
> +
> +	il79900a_switch_page(&ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
> +	if (ctx.accum_err)
> +		return ctx.accum_err;

Drop

> +
> +	msleep(120);

mipi_dsi_msleep

> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
> +	if (ctx.accum_err)
> +		return ctx.accum_err;

drop

> +
> +	msleep(80);

mipi_dsi_msleep
> +
> +	return 0;
> +};
> +
> +static inline struct il79900a *to_il79900a(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct il79900a, base);
> +}
> +
> +static int il79900a_enter_sleep_mode(struct il79900a *ili)
> +{
> +	struct mipi_dsi_device *dsi = ili->dsi;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_off(dsi);

_multi

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);

_multi

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int il79900a_disable(struct drm_panel *panel)
> +{
> +	struct il79900a *ili = to_il79900a(panel);
> +	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
> +	int ret;
> +
> +	il79900a_switch_page(&ctx, 0x00);
> +	if (ctx.accum_err)
> +		return ctx.accum_err;
> +
> +	ret = il79900a_enter_sleep_mode(ili);

Pass context to that function

> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(150);

mipi_dsi_msleep

> +
> +	return 0;
> +}
> +
> +static int il79900a_unprepare(struct drm_panel *panel)
> +{
> +	struct il79900a *ili = to_il79900a(panel);
> +
> +	gpiod_set_value(ili->enable_gpio, 0);
> +	usleep_range(1000, 2000);
> +	regulator_disable(ili->avee);
> +	regulator_disable(ili->avdd);
> +	usleep_range(5000, 7000);
> +	regulator_disable(ili->pp1800);
> +
> +	return 0;
> +}
> +
> +static int il79900a_prepare(struct drm_panel *panel)
> +{
> +	struct il79900a *ili = to_il79900a(panel);
> +	int ret;
> +
> +	gpiod_set_value(ili->enable_gpio, 0);
> +	usleep_range(1000, 1500);
> +
> +	ret = regulator_enable(ili->pp1800);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(3000, 5000);
> +
> +	ret = regulator_enable(ili->avdd);
> +	if (ret < 0)
> +		goto poweroff1v8;
> +	ret = regulator_enable(ili->avee);
> +	if (ret < 0)
> +		goto poweroffavdd;
> +
> +	usleep_range(10000, 11000);
> +
> +	// MIPI needs to keep the LP11 state before the lcm_reset pin is pulled high
> +	ret = mipi_dsi_dcs_nop(ili->dsi);
> +	if (ret < 0) {
> +		dev_err(&ili->dsi->dev, "Failed to send NOP: %d\n", ret);
> +		goto poweroff;
> +	}
> +	usleep_range(1000, 2000);
> +
> +	gpiod_set_value(ili->enable_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value(ili->enable_gpio, 0);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value(ili->enable_gpio, 1);
> +	usleep_range(20000, 21000);
> +
> +	ret = ili->desc->init(ili);
> +	if (ret < 0)
> +		goto poweroff;
> +
> +	return 0;
> +
> +poweroff:
> +	gpiod_set_value(ili->enable_gpio, 0);
> +	regulator_disable(ili->avee);
> +poweroffavdd:
> +	regulator_disable(ili->avdd);
> +poweroff1v8:
> +	usleep_range(5000, 7000);
> +	regulator_disable(ili->pp1800);
> +
> +	return ret;
> +}
> +
> +static int il79900a_enable(struct drm_panel *panel)
> +{
> +	msleep(130);

Why?

> +	return 0;
> +}
> +
> +static const struct drm_display_mode tianma_il79900a_default_mode = {
> +	.clock = 264355,
> +	.hdisplay = 1600,
> +	.hsync_start = 1600 + 20,
> +	.hsync_end = 1600 + 20 + 4,
> +	.htotal = 1600 + 20 + 4 + 20,
> +	.vdisplay = 2560,
> +	.vsync_start = 2560 + 82,
> +	.vsync_end = 2560 + 82 + 2,
> +	.vtotal = 2560 + 82 + 2 + 36,
> +};
> +
> +static const struct panel_desc tianma_il79900a_desc = {
> +	.modes = &tianma_il79900a_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 163,
> +		.height_mm = 260,
> +	},
> +	.lanes = 3,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init = tianma_il79900a_init,
> +};
> +
> +static int il79900a_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct il79900a *ili = to_il79900a(panel);
> +	const struct drm_display_mode *m = ili->desc->modes;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, m);
> +	if (!mode) {
> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +			m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> +		return -ENOMEM;
> +	}
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm = ili->desc->size.width_mm;
> +	connector->display_info.height_mm = ili->desc->size.height_mm;

drm_connector_helper_get_modes_fixed()

> +	connector->display_info.bpc = ili->desc->bpc;
> +
> +	return 1;
> +}
> +
> +static enum drm_panel_orientation il79900a_get_orientation(struct drm_panel *panel)
> +{
> +	struct il79900a *ili = to_il79900a(panel);
> +
> +	return ili->orientation;
> +}
> +
> +static const struct drm_panel_funcs il79900a_funcs = {
> +	.disable = il79900a_disable,
> +	.unprepare = il79900a_unprepare,
> +	.prepare = il79900a_prepare,
> +	.enable = il79900a_enable,
> +	.get_modes = il79900a_get_modes,
> +	.get_orientation = il79900a_get_orientation,
> +};
> +
> +static int il79900a_add(struct il79900a *ili)
> +{
> +	struct device *dev = &ili->dsi->dev;
> +	int err;
> +
> +	ili->avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(ili->avdd))
> +		return PTR_ERR(ili->avdd);
> +
> +	ili->avee = devm_regulator_get(dev, "avee");
> +	if (IS_ERR(ili->avee))
> +		return PTR_ERR(ili->avee);
> +
> +	ili->pp1800 = devm_regulator_get(dev, "pp1800");
> +	if (IS_ERR(ili->pp1800))
> +		return PTR_ERR(ili->pp1800);
> +
> +	ili->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(ili->enable_gpio)) {
> +		dev_err(dev, "cannot get reset-gpios %ld\n",
> +			PTR_ERR(ili->enable_gpio));
> +		return PTR_ERR(ili->enable_gpio);
> +	}
> +
> +	gpiod_set_value(ili->enable_gpio, 0);
> +
> +	drm_panel_init(&ili->base, dev, &il79900a_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);
> +	err = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
> +	if (err < 0) {
> +		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
> +		return err;
> +	}
> +
> +	err = drm_panel_of_backlight(&ili->base);
> +	if (err)
> +		return err;
> +
> +	ili->base.funcs = &il79900a_funcs;
> +	ili->base.dev = &ili->dsi->dev;
> +
> +	drm_panel_add(&ili->base);
> +
> +	return 0;
> +}
> +
> +static int il79900a_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct il79900a *ili;
> +	int ret;
> +	const struct panel_desc *desc;
> +
> +	ili = devm_kzalloc(&dsi->dev, sizeof(*ili), GFP_KERNEL);
> +	if (!ili)
> +		return -ENOMEM;
> +
> +	desc = of_device_get_match_data(&dsi->dev);
> +	dsi->lanes = desc->lanes;
> +	dsi->format = desc->format;
> +	dsi->mode_flags = desc->mode_flags;
> +	ili->desc = desc;
> +	ili->dsi = dsi;
> +	ret = il79900a_add(ili);
> +	if (ret < 0)
> +		return ret;
> +
> +	mipi_dsi_set_drvdata(dsi, ili);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret)
> +		drm_panel_remove(&ili->base);
> +
> +	return ret;
> +}
> +
> +static void il79900a_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct il79900a *ili = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	if (ili->base.dev)
> +		drm_panel_remove(&ili->base);
> +}
> +
> +static const struct of_device_id il79900a_of_match[] = {
> +	{ .compatible = "tianma,il79900a",
> +	  .data = &tianma_il79900a_desc
> +	},

Single line

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, il79900a_of_match);
> +
> +static struct mipi_dsi_driver il79900a_driver = {
> +	.driver = {
> +		.name = "panel-il79900a",
> +		.of_match_table = il79900a_of_match,
> +	},
> +	.probe = il79900a_probe,
> +	.remove = il79900a_remove,
> +};
> +module_mipi_dsi_driver(il79900a_driver);
> +
> +MODULE_AUTHOR("Langyan Ye <yelangyan@huaqin.corp-partner.google.com>");
> +MODULE_DESCRIPTION("Ilitek IL79900A-based panels driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

