Return-Path: <linux-kernel+bounces-871626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65745C0DDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806F9502163
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9A6248898;
	Mon, 27 Oct 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/U+n7jX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787227F72C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569885; cv=none; b=HuVz3Cjp4qj01tRhd/3E5zOEiCpJWnc0rEQ1v9xD13NrAyaL1TZZL8f/VYqltu6qOUlMn9vKD7jWDxG36z8hEHY7DaN6/nXOI2Ls3xqYSuLhhm3n/I2SIUwfsqU44dN8xSjTAYmXiKq+vW0JsjFlX6R/K2KW0jtpUPuEoaKoNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569885; c=relaxed/simple;
	bh=n21cZTqPgABc0lqN1y6qRGe3m4vhXISPsOg4pFEecus=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sIZCQ6gzZe/dwGGGydufX88tHZQuZUpPuQvOqpMMv5Ie+2Yw32RaLu15DX2XbAZBxDt6tUkLTLnS3SWk8SXNNy7j69tBzmQPtl4PnB7PeZwnwJT0Psb/8y404aKAaImK4EeXktZxL8ySOkRu/iotn5X3/yArEDUi5pp3sGt1ElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/U+n7jX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591eb980286so4774593e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761569882; x=1762174682; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDnkAXitF9GtjD22LMyNok6W71oRGQ0I52PlIr3ehxY=;
        b=d/U+n7jXJGUnISDWeQ3fW+0ckXCMxsaui3HcRIpY1ore/IqTbaieQniUJBJgZtXkSz
         uzPFaKv1bbmrlBPTk+nCr26ZfSHE5imjcOCvoWkS8m4ledZZXRKuWILGu38x2LTQsYCd
         t8AIlGS+nSBUgVF/+H4hmIQbfLd6EnreYooxM33SSf3rUBDax7dgLy/mOnj7U+Lobh/T
         91w9m/d9PLnk4gzdw5Fdvb3dAOokl3pXESrpJHThGgpgJY92juK/4WshPfwhN3qu1k6V
         uTlrvClb02o0OiwhGnvLpZm75zQ0wYf8zIcXrdp+RjeDGwWpZ/ftKk6tFJWqW0IM/VjI
         fbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569882; x=1762174682;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDnkAXitF9GtjD22LMyNok6W71oRGQ0I52PlIr3ehxY=;
        b=cERQMEFkmT0fDTl7EYirXtak4E/CZrZop8MbfJcxvEFnoU94QVGx/bGwDpUhq5+3L3
         4eV1iadGPj5CIMnLQfxf+JjQMVEC9eQPzUs7K3m8AV/9vBMajp8GNYljn02zqQq/QJRH
         gDrgH84Cycv6a18XIjMKqjub+r/89ebe1n6R+fQZD37pRW4yAaRVMhjf6WTSTP0z5m85
         kFUMYuioSjsNEzX7w6LboCxZeIqYAuuOZyZ79dkVZZ2QBYR+0EoEVXTu2lwe5dd++eIp
         2L9d2KjkeDVWg5oYLBLEAxVM4bEtZQwScML3pB0+KmEIoGzgjMD05TrM8Ub1Tui3UsIk
         LRAw==
X-Forwarded-Encrypted: i=1; AJvYcCUgVhoLE/WesumQ4gZ/9cwAC8ZDlgIQaNkfVFJPnE/KwrB5b0BILzl2LTks/bg4syVVqc1u7GT0OPLlCgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aEtkxjDpItGRZb2wEyxS448niD+FPy5Mqst7FaB70qTEJEUC
	0XP/2OJ0WqaNYY5HJgFcY9mWtyNJZD8+Z7HxAVKK3ZAYbMyJPXk/AB0N
X-Gm-Gg: ASbGncvw6i3SCIuJpx8dIWgtT+8lUoe4bcf+mi4P6lU8jGchYi/jpwApeN+8GneTmXc
	cpp9BETnRzMxjDQDJjHynDXtJMTmgBF3/H/L5ZBvMNnswiDMIyO8aTH3bmPuIDaaDRBEsnhZrP3
	5NCqWJMaNXNp5TU46iC23wM/eUtwYw1l6LKnAAlaQa3m5GC5yuLVYqtIMdBvczvaFUZu9+/EOM4
	HZJ4WAfOK7yJSQRdgw5/2qYdGuSBfLcZVuZfJcQ9VKoEGr+bhYpQ9M/wecY7o1nrkdK8DGokxmh
	wGHgtLG5LtTZB0jysy5GTnVn+PETZA1/WGrkjzs0hJ+qCvIwEzI1a/DJrXJUE9kloa2ckxIN0e1
	SUOay+VgGmtMX5a9na/p0gLiedk96AoEWkqAiWaApMgxbXzQOpcMXS8GFS0L6UJ/ybf6Xhh3BKe
	2CuphZ9aErp8q15K2viDVXcWgl
X-Google-Smtp-Source: AGHT+IFja74kXhxrCKdeDBkd8002sKu3KlGMVzwjrWEOPZsKrpFPZoCVtufCuW+OdjAREKz9DJufog==
X-Received: by 2002:a05:6512:a89:b0:592:fd1e:6f7a with SMTP id 2adb3069b0e04-592fd1e70ffmr3461763e87.5.1761569881576;
        Mon, 27 Oct 2025 05:58:01 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f71da0sm2342141e87.82.2025.10.27.05.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:58:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
Date: Mon, 27 Oct 2025 16:57:45 +0400
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-media@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9A578FB-BF95-47E1-B202-B59897C2C898@gmail.com>
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
To: zhentao.guo@amlogic.com
X-Mailer: Apple Mail (2.3826.700.81)

> On 27 Oct 2025, at 9:42=E2=80=AFam, Zhentao Guo via B4 Relay =
<devnull+zhentao.guo.amlogic.com@kernel.org> wrote:
>=20
> Introduce initial driver support for Amlogic's new video acceleration
> hardware architecture, designed for video stream decoding.
>=20
> Compared to the current Amlogic video decoder hardware architecture,
> this new implementation eliminates the Esparser hardware component,
> enabling direct vb2 buffer input. The driver is designed to support
> the V4L2 M2M stateless decoder API. The initial phase includes support
> for H.264 decoding on Amlogic S805X2 platform.

It would be nice if you can outline the additional hardware the driver
plans to support so reviewers have perspective on where we are now, and
what more be coming? - the community would also like to understand if
this driver will supersede the stalled driver attempt in staging.

NB: I can only find two S805X2 devices to purchase for testing. The
first is a Mecool KD5 HDMI stick, but this has Widevine L1 certs so
will be unusable due to verified boot. The second is a no-name TV box
on Aliexpress where the advert claims S805X2 inside but also shows a
prominent Rockchip RK3228 logo :) .. please advise on some accessible
hardware that can be used for validating the driver.

> The driver is capable of:
> - Supporting stateless H.264 decoding up to a resolution 1920x1088(on =
the S805X2 platform).

It would be good to provide guidance to reviewers about other codecs
the driver plans to support and how (architecturally) the driver will
be expanded. I=E2=80=99m aware due to off-list discussions, but others =
are
not and will want to know.

> - Supporting I/P/B frame handling.
> - Supporting vb2 mmap and dma-buf modes.
> - Supporting frame-based decode mode. (Note that some H.264 bitstreams =
require
>  DPB reordering to generate reference lists, the stateless decoder =
driver
>  cannot access reordered reference lists in this mode, requiring the =
driver
>  to perform reference list reordering itself)
> - Supporting NV12/NV21 output.
> - Supporting Annex B start codes.
>=20
> This driver is tested with Gstreamer.
> Example:
> gst-launch-1.0 filesrc =
location=3D/tmp/video_640x360_mp4_hevc_450kbps_no_b.mp4 !
> parsebin ! v4l2slh264dec ! filesink location=3D/tmp/output.yuv

Is this upstream gstreamer? if yes which version? If no, where can
we obtain sources for testing. Has ffmpeg been tested? - the same
questions apply.

> The driver passes v4l2 compliance test, test reports :
> v4l2-compliance 1.30.1, 64 bits, 64-bit time_t
>=20
> Compliance test for aml-vdec-drv device /dev/video0:
>=20
> Driver Info:
>        Driver name      : aml-vdec-drv
>        Card type        : platform:aml-vdec-drv
>        Bus info         : platform:fe320000.video-codec
>        Driver version   : 6.16.0

It would be preferable to test the next iteration of patches on
the latest kernel release, e.g. 6.18-rc, or recent media tree or
perhaps drm-tip source.

>        Capabilities     : 0x84204000
>                Video Memory-to-Memory Multiplanar
>                Streaming
>                Extended Pix Format
>                Device Capabilities
>        Device Caps      : 0x04204000
>                Video Memory-to-Memory Multiplanar
>                Streaming
>                Extended Pix Format
>        Detected Stateless Decoder
> Media Driver Info:
>        Driver name      : aml-vdec-drv
>        Model            : aml-vdec-drv
>        Serial           :
>        Bus info         : platform:fe320000.video-codec
>        Media version    : 6.16.0
>        Hardware revision: 0x00000000 (0)
>        Driver version   : 6.16.0
> Interface Info:
>        ID               : 0x0300000c
>        Type             : V4L Video
> Entity Info:
>        ID               : 0x00000001 (1)
>        Name             : aml_dev_drv-source
>        Function         : V4L2 I/O
>        Pad 0x01000002   : 0: Source
>          Link 0x02000008: to remote pad 0x1000004 of entity =
'aml_dev_drv-proc' (Video Decoder): Data, Enabled, Immutable
>=20
> Required ioctls:
>        test MC information (see 'Media Driver Info' above): OK
>        test VIDIOC_QUERYCAP: OK
>        test invalid ioctls: OK
>=20
> Allow for multiple opens:
>        test second /dev/video0 open: OK
>        test VIDIOC_QUERYCAP: OK
>        test VIDIOC_G/S_PRIORITY: OK
>        test for unlimited opens: OK
>=20
> Debug ioctls:
>        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>        test VIDIOC_LOG_STATUS: OK (Not Supported)
>=20
> Input ioctls:
>        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>        test VIDIOC_ENUMAUDIO: OK (Not Supported)
>        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>        test VIDIOC_G/S_AUDIO: OK (Not Supported)
>        Inputs: 0 Audio Inputs: 0 Tuners: 0
>=20
> Output ioctls:
>        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>        Outputs: 0 Audio Outputs: 0 Modulators: 0
>=20
> Input/Output configuration ioctls:
>        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>        test VIDIOC_G/S_EDID: OK (Not Supported)
>=20
> Control ioctls:
>        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>        test VIDIOC_QUERYCTRL: OK
>        test VIDIOC_G/S_CTRL: OK
>        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>        Standard Controls: 6 Private Controls: 0
>        Standard Compound Controls: 4 Private Compound Controls: 0
>=20
> Format ioctls:
>        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>        test VIDIOC_G/S_PARM: OK (Not Supported)
>        test VIDIOC_G_FBUF: OK (Not Supported)
>        test VIDIOC_G_FMT: OK
>        test VIDIOC_TRY_FMT: OK
>        test VIDIOC_S_FMT: OK
>        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>        test Cropping: OK (Not Supported)
>        test Composing: OK (Not Supported)
>        test Scaling: OK (Not Supported)
>=20
> Codec ioctls:
>        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>        test VIDIOC_(TRY_)DECODER_CMD: OK
>=20
> Buffer ioctls:
>        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>        test CREATE_BUFS maximum buffers: OK
>        test VIDIOC_REMOVE_BUFS: OK
>        test VIDIOC_EXPBUF: OK
>        test Requests: OK
>        test blocking wait: OK
>=20
> Total for aml-vdec-drv device /dev/video0: 49, Succeeded: 49, Failed: =
0, Warnings: 0
>=20
> Some Fluster test cases are still failing. We will publish the final =
results
> once all these Fluster test failures have been resolved.

IMHO good drivers that merge quickly have more merit than perfect
drivers that take forever. No driver passes all fluster tests. If
you share the results, people can advise whether the failures are
normal, something that must be improved, or something that can be
improved with time.

> Signed-off-by: Zhentao Guo <zhentao.guo@amlogic.com>
> ---
> Zhentao Guo (3):
>      dt-bindings: vdec: Add binding document of Amlogic decoder =
accelerator
>      dts: decoder: Support V4L2 stateless decoder dt node for S4
>      decoder: Add V4L2 stateless H.264 decoder driver

None of the patch subject lines are following the naming formats
used for the subsystems. Patch order is also important. Bindings
go first, device-tree changes to expose support normally go last.
Expect maintainer complaints about not reading kernel etiquette
rules before submitting.=20

> .../bindings/media/amlogic,vcodec-dec.yaml         |   96 ++
> MAINTAINERS                                        |    7 +
> arch/arm64/boot/dts/amlogic/meson-s4.dtsi          |   24 +
> drivers/media/platform/amlogic/Kconfig             |    2 +
> drivers/media/platform/amlogic/Makefile            |    1 +
> drivers/media/platform/amlogic/vdec/Kconfig        |   15 +
> drivers/media/platform/amlogic/vdec/Makefile       |    4 +
> drivers/media/platform/amlogic/vdec/aml_vdec.c     |  759 +++++++++
> drivers/media/platform/amlogic/vdec/aml_vdec.h     |   31 +
> .../platform/amlogic/vdec/aml_vdec_canvas_utils.c  |  154 ++
> .../platform/amlogic/vdec/aml_vdec_canvas_utils.h  |   22 +
> drivers/media/platform/amlogic/vdec/aml_vdec_drv.c |  263 +++
> drivers/media/platform/amlogic/vdec/aml_vdec_drv.h |  194 +++
> drivers/media/platform/amlogic/vdec/aml_vdec_hw.c  |  652 +++++++
> drivers/media/platform/amlogic/vdec/aml_vdec_hw.h  |  182 ++
> .../platform/amlogic/vdec/aml_vdec_platform.c      |   37 +
> .../platform/amlogic/vdec/aml_vdec_platform.h      |   62 +
> drivers/media/platform/amlogic/vdec/h264.c         | 1790 =
++++++++++++++++++++
> drivers/media/platform/amlogic/vdec/h264.h         |  300 ++++
> drivers/media/platform/amlogic/vdec/reg_defines.h  |  175 ++
> 20 files changed, 4770 insertions(+)

The driver requires closed-source firmware blobs (sadly) for each
codec and hardware target. Will that change in future iterations?
If not, the firmware blobs are not provided here so it would be
useful if you could provide a public source for them. There are
known FOSS tools for extracting files from the Android ucode blob
but testing presumably needs a specific blob version?

Most maintainers also prefer a complex driver to be submitted in a
series of patches that break the driver up into logical and easier
to-review pieces. Large uber-patches are harder to digest and are
likely to take much longer to review, and more effort for everyone
to track feedback on over time.

***=20

NB: The fact this driver is being submitted, is still a positive
and welcomed step towards better upstream Amlogic support and it=E2=80=99s=

great to see! I would encourage you and colleagues to establish a
public working space to share code and tools so the community can
directly engage and support driver testing and development.

Christian


