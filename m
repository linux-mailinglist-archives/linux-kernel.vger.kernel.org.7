Return-Path: <linux-kernel+bounces-618205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F7A9AB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988615A1105
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC4221FDD;
	Thu, 24 Apr 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3/p8omF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A367DA6D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492628; cv=none; b=BOX9S66AWCYfrOyW/qnDCm8z2YQy3h6XJ3avTUyxg+yC1IKtsFXyyyND7wJgPwRgh1fpWIe/kJO16CcTiZFLjLfHItgrmskAcNqCegJQUrpRBgLx0LvINfzyhdQP+cZhEzRDO/76XQmQupcMcV3glwVZsFXx3UVESMCA6dO487o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492628; c=relaxed/simple;
	bh=A7aRIxDQxrduf6NSsAo53MIHR9GutTW1OcwawD0x1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB9L5JG+W9/1+i+3jlZEwkwIrDh784lRTlttxjtbHXRsi30QVX9IO892ZyaoHQM9x8F7q2DrOHUHIlUDbfE+k0y3Vm6E5yy63BzvVKASa87ZOtrPuc0j01mckQMOMdhrSKYfltsiGccBLU1MverBfCg+oHF5obtmb9B/VyFE0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3/p8omF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAQe7N011396
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 11:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtcq15bcZveDtJrN9AJkNlJ7tHg9tPDmaStBfTOGpKM=; b=U3/p8omFF+aR6zWA
	/BUyEfsCVhX859gnb3pKNn2EGlq8zg7K9WCYKvoLhB6oH1fc51i5Qu+WROX3UUoF
	IR+5EU023alctiDUeLLc+wQsXvduakokM7vC4sYJzqvwFpxOzd9NdFub5+2p8HZZ
	vQtEgxa6wHw6bim4DAuTBzfUjPnE7gFGwepbvznsuTZlNdMlNCsBX4isLBKhUqbc
	TPRWS4OePSxqgUeFmW5CziHaUAkXgv67Onv7wf9bCmhX17r8KzqPc5kjiTpHPp2T
	fr3UTILdQZL6Fc/khvegPVBcHfVBoaVD9AOrvuXPtUyfLQQiNn7sEuC4nVYcCnxj
	7tusLw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh25b8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 11:03:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c760637fe5so159401085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 04:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492623; x=1746097423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtcq15bcZveDtJrN9AJkNlJ7tHg9tPDmaStBfTOGpKM=;
        b=Z22CyYpI70OdTSU6cKDupiqi+ReRsfrsHvrQHPUnDGcwr+cKSaRcbo6pdVD/HAJW9d
         THrEkBL/fUMrOr0lJH2jFLp+ndF6XlLm111VYotJiIHvUq4fN3ZLodd1d0E8yfEsQJLz
         99qcGo34yLEDbsE+fFavWLxdxjydo2fr/AhX84Gfo3ytRvyY07DviJy06oqGadP0QoFg
         OHWx7KYTSPrcSHiZReIbiFrDdcaVvQxaD/3iHRrRq0hiYlWdysg+M6Z0HRoCo7++DlFV
         M8+0QHmLFo5Vt0qqHGwYjKWuAifltRm0x1LTQl1f6RbyT5hYjrvhwPz3WAEKf3Cf2ksv
         z7QA==
X-Forwarded-Encrypted: i=1; AJvYcCXcTzxmB0i8EH/bDWrCAE1OY2AVq1dMbH/4RQ9+Th8PWBBXdQ6k4zP1yA9FXqNxSzfS58JdneRaf/xYELc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JOkbFmd/SmKc4haPMlCXtw301pof2sgH2hvxKwfQRUuo96o8
	ayLvs9Qlay1+tQHJ7ZiPMT3O30ryx2J14YPBntXhVr5bfiEv6ZXRk2qPpdcJTWCfcD4x2gUaGxh
	oywlAuCYLhk4EKfxJtkEKHAL2yncyOvh/mKvS6Vc8cm4ui9XeWUqfQMWjyiD0xj4=
X-Gm-Gg: ASbGncu/LSWva7jSz0wGA1gfi6XmKKE3JwPOi13mUZ+5DcN/n0gkiGkHkmTHwYNXweo
	LZGrfqm3jDPfMzZdlYWobUynqfXIy+TRQDaNaOY6piNZqpK8Y/v/SXRWrMR/NHJy6fiZxCa2ieb
	0b0RzkrotEhzBg3C+iy4Bd/kZz8xIprzsVOZB6Ej6+lEuHviCof2TMiTm4RyRb+W//CsFQHFj+P
	rE6arsAZeDPO/sr03ypfHK/T3lcOkFwLNRk7WOiDACgfLEB39qe2Lm3BG4pzmMs47rZ+aKMwtVb
	FLWNYfq4pVSv1DkjubQw48tzxOa6eDEMPfJl4R1fh42oF77Bq0H1XDpwrjD4NshOjHkL/uFG2IM
	=
X-Received: by 2002:a05:620a:c4c:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c956f89c96mr328238285a.55.1745492623175;
        Thu, 24 Apr 2025 04:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHteZMGvMFSUTqYYbTjZaDrVtXlfhjZqwxSyZzrDMv5DByJy8uB+GwR+TYFTzyjT/YfuETNvw==
X-Received: by 2002:a05:620a:c4c:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c956f89c96mr328231685a.55.1745492622399;
        Thu, 24 Apr 2025 04:03:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cca8de0sm193160e87.189.2025.04.24.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:03:41 -0700 (PDT)
Date: Thu, 24 Apr 2025 14:03:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev, Pin-yen Lin <treapking@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
        Jameson Thies <jthies@google.com>,
        Andrei Kuchynski <akuchynski@chromium.org>
Subject: Re: [PATCH 7/7] platform/chrome: cros_ec_typec: Support DP muxing
Message-ID: <mu6f7ru7wrxtbjra4hu4btlztg5zfrug2wxrbylfguvrv25sjl@ywxtxioeydqh>
References: <20250416000208.3568635-1-swboyd@chromium.org>
 <20250416000208.3568635-8-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416000208.3568635-8-swboyd@chromium.org>
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=680a1a90 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=InMYaEMRAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VHk893xo0hp5UeZsn5AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=uQu4y5UHrBEQhWXbw-vk:22
X-Proofpoint-GUID: n5ky2FBC8Hjt0YoJOnU4pA9haJbSIwh8
X-Proofpoint-ORIG-GUID: n5ky2FBC8Hjt0YoJOnU4pA9haJbSIwh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NCBTYWx0ZWRfXzbN7uJLHdGaZ yjUxzhJv4KIJlfvMJx63zE5pgIdLnAL73FkGhYDu6Nls/UE48WI2OWnh+xS08d/KwTR1BFU+i5H n25z2kkOyKqdwtZWDYMHplRbT+MLYVNZ5snmPkXb6E1lKazZO6WGy/cpCUFVmPzjuF3Z3H1soV8
 BSst6MfhOTmZd6sVug7otpLqsjCDYKGVrT8VcJ2l/l4E/6dSvzfD+JvMnzvKX1RRcHywiPZE39U k/hvYfYY8Hiu8UUUtC/Hx1Tpk5anBxoWR7q0Eq493OYtyU7rnu2LydkQcX7yFdwQssfwpCLDFv0 ulvGvipLrct+eNoiuhicRz4KXXuO84oSXfP3QTnz1ALU3DE90jiOYwQOg5K41dAW2sLudUq3TAJ
 TlaiwWHQ88h7CFY2EIcQEz1oybihXLilSCFWyQWbV+HFEOe9ebr+qftlRvOjCLD2WOXbAx/b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240074

On Tue, Apr 15, 2025 at 05:02:07PM -0700, Stephen Boyd wrote:
> Most ARM based chromebooks with two usb-c-connector nodes and one DP
> controller are muxing the DP lanes between the two USB ports. This is
> done so that the type-c ports are at least equal in capability if not
> functionality. Either an analog mux is used to steer the DP signal to
> one or the other port, or a DP bridge chip has two lanes (e.g. DP
> ML0/ML1) wired to one type-c port while the other two (e.g. DP ML2/ML3)
> are wired to another type-c port.
> 
> If a user connects a DP capable cable to both usb-c-connectors the EC
> likes to inform the AP that both ports have entered DP altmode, even
> though one of those ports can't actually display anything because the DP
> lanes aren't steered there. The answer to this problem is to look at the
> HPD bit in the EC messages. The port that isn't steered for DP won't
> ever see HPD be asserted, because the EC hides HPD state for the other
> port. This isn't a great solution though, because some EC firmwares
> don't even signal HPD state in the message at all. Oops! And it really
> does throw the whole type-c subsystem for a loop when the port has DP
> altmode present but it can't be entered properly.
> 
> Let's fix these problems by doing two things.
> 
> First, we'll only allow the port that's steered for DP to enter DP mode.
> Do that by checking the mux-gpios whenever we see that the EC tells us
> DP mode has been entered. If the mux isn't selecting this port, remove
> the flag from the message so that DP mode doesn't look to be entered.
> 
> Second, inject HPD into the EC message when the EC has busted firmware.
> In this case, DT authors add 'no-hpd' to the typec node (essentially
> only on Trogdor). Listen for HPD events from the drm_bridge and read the
> mux when HPD is asserted to figure out which port actually had HPD
> asserted on it. When the port state is processed, check the bit against
> the port and if DP mode is entered, i.e. the mux is still steering
> toward that port, check if HPD is asserted on that port and inject HPD.
> This is necessary so that the typec framework can update the HPD state
> in sysfs, and eventually call drm_connector_oob_hotplug_event() from the
> DP altmode driver.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Cc: Łukasz Bartosik <ukaszb@chromium.org>
> Cc: Jameson Thies <jthies@google.com>
> Cc: Andrei Kuchynski <akuchynski@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c      | 115 +++++++++++++++++++
>  drivers/platform/chrome/cros_ec_typec.h      |  14 +++
>  drivers/platform/chrome/cros_typec_altmode.c |   2 +
>  3 files changed, 131 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 27324cf0c0c6..10079129645d 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
> @@ -427,6 +428,41 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  	return ret;
>  }
>  
> +static void cros_typec_dp_bridge_hpd_notify(struct drm_bridge *bridge, enum drm_connector_status status)

Okay, I can see why you've implemented the bride on your own, but I
can't say that I'm happy with it. For example, for such bridges it's
relatively easy to miss the interlace_allowed and ycbcr_420_allowed
flags (which you did). Likewise it makes it harder for Luca and other
developers to review / rework bridge lifetime.

> +{
> +	struct cros_typec_dp_bridge *dp_bridge = bridge_to_cros_typec_dp_bridge(bridge);
> +	struct cros_typec_data *typec = dp_bridge->typec_data;
> +	struct gpio_desc *mux_gpio = dp_bridge->mux_gpio;
> +	int val;
> +	DECLARE_BITMAP(orig, EC_USB_PD_MAX_PORTS);
> +	DECLARE_BITMAP(changed, EC_USB_PD_MAX_PORTS);
> +
> +	if (!mux_gpio)
> +		return;
> +
> +	/* This bridge signals HPD so it must be able to detect HPD properly */
> +	if (dp_bridge->bridge.ops & DRM_BRIDGE_OP_HPD)
> +		return;
> +
> +	bitmap_copy(orig, dp_bridge->hpd_asserted, EC_USB_PD_MAX_PORTS);
> +	bitmap_zero(changed, EC_USB_PD_MAX_PORTS);
> +
> +	if (status == connector_status_connected) {
> +		val = gpiod_get_value_cansleep(mux_gpio);
> +		if (val < 0) {
> +			dev_err(typec->dev, "Failed to read mux gpio\n");
> +			return;
> +		}
> +		__set_bit(val, changed);
> +	}
> +
> +	bitmap_copy(dp_bridge->hpd_asserted, changed, EC_USB_PD_MAX_PORTS);

This looks like a home-made reimplementation of test_and_set_bit() /
test_and_clear_bit(). Can those functions be used instead?
Or simply store GPIO value under the lock?

> +
> +	/* Refresh port state. */
> +	if (!bitmap_equal(orig, changed, EC_USB_PD_MAX_PORTS))
> +		schedule_work(&typec->port_work);
> +}
> +
>  static int cros_typec_dp_bridge_attach(struct drm_bridge *bridge,
>  				       enum drm_bridge_attach_flags flags)
>  {
> @@ -435,6 +471,7 @@ static int cros_typec_dp_bridge_attach(struct drm_bridge *bridge,
>  
>  static const struct drm_bridge_funcs cros_typec_dp_bridge_funcs = {
>  	.attach	= cros_typec_dp_bridge_attach,
> +	.hpd_notify = cros_typec_dp_bridge_hpd_notify,
>  };
>  
>  static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
> @@ -452,6 +489,11 @@ static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
>  	if (!dp_bridge)
>  		return -ENOMEM;
>  	typec->dp_bridge = dp_bridge;
> +	dp_bridge->typec_data = typec;
> +
> +	dp_bridge->mux_gpio = devm_gpiod_get_optional(dev, "mux", GPIOD_ASIS);
> +	if (IS_ERR(dp_bridge->mux_gpio))
> +		return dev_err_probe(dev, PTR_ERR(dp_bridge->mux_gpio), "failed to get mux gpio\n");
>  
>  	bridge = &dp_bridge->bridge;
>  	bridge->funcs = &cros_typec_dp_bridge_funcs;
> @@ -662,6 +704,77 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
>  	return typec_mux_set(port->mux, &port->state);
>  }
>  
> +/*
> + * Some ECs like to tell AP that both ports have DP enabled when that's
> + * impossible because the EC is muxing DP to one or the other port. Check the
> + * mux on the EC in this case and ignore what the EC tells us about DP on the
> + * port that isn't actually muxed for DP.
> + */
> +void cros_typec_check_dp(struct cros_typec_data *typec,
> +			 struct ec_response_usb_pd_mux_info *resp,
> +			 struct cros_typec_port *port)
> +{
> +	struct cros_typec_dp_bridge *dp_bridge = typec->dp_bridge;
> +	struct gpio_desc *mux_gpio;
> +	int val;
> +
> +	/* Never registered a drm_bridge. Skip. */
> +	if (!dp_bridge)
> +		return;
> +
> +	/* Don't need to override DP enabled when DP isn't enabled. */
> +	if (!(resp->flags & USB_PD_MUX_DP_ENABLED))
> +		return;
> +
> +	mux_gpio = dp_bridge->mux_gpio;
> +	/* EC mux is required to determine which port actually has DP on it. */
> +	if (!mux_gpio)
> +		return;
> +
> +	val = gpiod_get_value_cansleep(mux_gpio);
> +	if (val < 0) {
> +		dev_err(typec->dev, "Failed to read mux gpio\n");
> +		return;
> +	}
> +
> +	/* Only the muxed port can have DP enabled. Ignore. */
> +	if (val != port->port_num)
> +		resp->flags &= ~USB_PD_MUX_DP_ENABLED;
> +}
> +
> +/*
> + * Some ECs don't notify AP when HPD goes high or low because their firmware is
> + * broken. Capture the state of HPD in cros_typec_dp_bridge_hpd_notify() and
> + * inject the asserted state into the EC's response (deasserted is the
> + * default).
> + */
> +static void cros_typec_inject_hpd(struct cros_typec_data *typec,
> +				  struct ec_response_usb_pd_mux_info *resp,
> +				  struct cros_typec_port *port)
> +{
> +	struct cros_typec_dp_bridge *dp_bridge = typec->dp_bridge;
> +
> +	/* Never registered a drm_bridge. Skip. */
> +	if (!dp_bridge)
> +		return;
> +
> +	/* Don't need to inject HPD level when DP isn't enabled. */
> +	if (!(resp->flags & USB_PD_MUX_DP_ENABLED))
> +		return;
> +
> +	/* This bridge signals HPD so it doesn't need to be reinjected */
> +	if (dp_bridge->bridge.ops & DRM_BRIDGE_OP_HPD)
> +		return;
> +
> +	/*
> +	 * The default setting is HPD deasserted. Ignore if nothing to inject.
> +	 */
> +	if (!test_bit(port->port_num, dp_bridge->hpd_asserted))
> +		return;
> +
> +	resp->flags |= USB_PD_MUX_HPD_LVL;
> +}
> +
>  static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  				struct ec_response_usb_pd_control_v2 *pd_ctrl)
>  {
> @@ -682,6 +795,8 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  			 port_num, ret);
>  		return ret;
>  	}
> +	cros_typec_check_dp(typec, &resp, port);
> +	cros_typec_inject_hpd(typec, &resp, port);
>  
>  	/* No change needs to be made, let's exit early. */
>  	if (port->mux_flags == resp.flags && port->role == pd_ctrl->role)
> diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
> index 090f8f5c0492..b4b331aa5dc7 100644
> --- a/drivers/platform/chrome/cros_ec_typec.h
> +++ b/drivers/platform/chrome/cros_ec_typec.h
> @@ -6,6 +6,7 @@
>  #include <linux/list.h>
>  #include <linux/notifier.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/types.h>
>  #include <linux/usb/pd.h>
>  #include <linux/usb/role.h>
>  #include <linux/usb/typec.h>
> @@ -88,6 +89,19 @@ struct cros_typec_port {
>  
>  struct cros_typec_dp_bridge {
>  	struct drm_bridge bridge;
> +	struct cros_typec_data *typec_data;
> +	struct gpio_desc *mux_gpio;
> +	DECLARE_BITMAP(hpd_asserted, EC_USB_PD_MAX_PORTS);
>  };
>  
> +static inline struct cros_typec_dp_bridge *
> +bridge_to_cros_typec_dp_bridge(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct cros_typec_dp_bridge, bridge);
> +}
> +
> +void cros_typec_check_dp(struct cros_typec_data *typec,
> +			 struct ec_response_usb_pd_mux_info *resp,
> +			 struct cros_typec_port *port);
> +
>  #endif /*  __CROS_EC_TYPEC__ */
> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
> index 97ca4cfabbc0..10d21da592f1 100644
> --- a/drivers/platform/chrome/cros_typec_altmode.c
> +++ b/drivers/platform/chrome/cros_typec_altmode.c
> @@ -82,6 +82,7 @@ static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
>  		if (ret < 0)
>  			return ret;
>  
> +		cros_typec_check_dp(adata->port->typec_data, &resp, adata->port);
>  		if (!(resp.flags & flags))
>  			return -EINVAL;
>  	} else {
> @@ -147,6 +148,7 @@ static int cros_typec_altmode_exit(struct typec_altmode *alt)
>  		if (ret < 0)
>  			return ret;
>  
> +		cros_typec_check_dp(adata->port->typec_data, &resp, adata->port);
>  		if (resp.flags & flags)
>  			return -EINVAL;
>  	} else {
> -- 
> https://chromeos.dev
> 

-- 
With best wishes
Dmitry

