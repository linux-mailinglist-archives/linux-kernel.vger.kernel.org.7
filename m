Return-Path: <linux-kernel+bounces-838937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64741BB0771
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28F03A9694
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478282ED84C;
	Wed,  1 Oct 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EzVH3F3a"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508912C544
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324971; cv=none; b=HpQ7Ev5muxi4GPEDqHa3Fr1p+GkwkC16kox4/7WUdX9rphtc+oJP9OzOG5UZxwZ1MVbCB/1pg0Nnn5xXrPPkzEQTBl6Q9Ag8CWvP9QqqKfrH/CYov/UXyGY/i7p2m1xH//ES2Lj8jnD+WfI5Y1yBQcxsEtoFjfGPG8/qQS4LrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324971; c=relaxed/simple;
	bh=yOS1la7tFfk/E20MZjQcEn6S65k24fLO7P0Llku+CcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l0qLdbehTq2mWIzPnT6yffokt6F5coKtN0EcfHG8Gam6n7Vpu5rv0ApWV91Apog9ZTSqDAhhltubL4z1c2RhkmCmM6OwXMtOJP3tG8zdClgleMC20JpnF96+3zcKB3RfgDNPQ9tPGUFT+TMcqoFpj5+apn7l7IFe88adE0Qn0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EzVH3F3a; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DD7AED;
	Wed,  1 Oct 2025 15:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324877;
	bh=yOS1la7tFfk/E20MZjQcEn6S65k24fLO7P0Llku+CcE=;
	h=From:Subject:Date:To:Cc:From;
	b=EzVH3F3aVrDvGkJ6K3h9zd3D6RRAeKHRJuySkZxlOXnnV+s6pZ4249FmGkdslHinW
	 BoL4TAsYuFFMoBbDIHja8grSZ2ASEWE9aEH7OmMPhf2QVW/jF/QRKyX+F5E8eIWwAO
	 oPxMr/DiRMhOt72p0vM5O7RSPGUvRurn4KD/fIHA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v6 00/11] drm: Add new pixel formats for Xilinx Zynqmp
Date: Wed, 01 Oct 2025 16:22:12 +0300
Message-Id: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUr3WgC/3XPy2rDMBCF4VcJWldlLpJcd9X3KFnIujSCxipSM
 A7B714lpRjqevkfmA/mJmooKVTxeriJEqZUUx5bmKeDcCc7fgSZfGtBQAqRQM7pM42zjLmc7aX
 K2GEPaAhfmEU7+iohpvkBvh9bn1K95HJ9+BPe1x+KQP2lJpQgYYjkNKrOD/iWfLA1j0O2xT+7f
 BZ3caJfRQOi3ijUFDTA1DlrNNkdhVeFkDYKN6UHDzEgmL7XO4paFSazUVRTmMgygDO+ox1Fr4q
 i7Ue6Ka5TZJgYDcM/yrIs3199czXLAQAA
X-Change-ID: 20241120-xilinx-formats-f71901621833
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7168;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=yOS1la7tFfk/E20MZjQcEn6S65k24fLO7P0Llku+CcE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SsbAWlb99mfRuxxQUFJWVZEo/XvGWtVD2RE/
 mKL7RyUqcKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rGwAKCRD6PaqMvJYe
 9UwwEACDTN3FabMsbZXuqsakfdNYxieHDNIbOCvygc2aEQqHoQZLnVUPqq0u/kzRLEugDOKrQVG
 GMEtmjYBowCHyWZpzhY1e92jARUwZR3nnOorBGFP32yzCQNQVkpn5xVrYHl+pPOKPpe3pTZRcuw
 +6x1xpVUG+4P0+mAxdHTP7wuluHTtNGPiLAPE+j706fPz2rdlgDQoA22dczggMXcfTnguvoDpWT
 CUDQU/dk61VzxaB2vAvvV7N3DJEx0P9K85T/2L9b4dVetvYrpaT0Dke9atl+DYavwZ2AObBv0+1
 en8aIBQZ/fhcYFCfhJO8XLjKYJO7UieN9doAhOufnXGdVLYzc1h5rC3JuEGuLZ6+TVaQ6xAqDHT
 1oBce9jGlYByzhg0AZEWxEa7wpZYcEM25frU1cK3Ep6TbsuUjntZ5LIyD+FKlSlToTUGVQfz78o
 Hvfr8SwvQhZr0hNCEvYEHgEZPafjzcB1tPSy6zvCAAQZmbb3pAudKzQ0G9YukabZfTxlGDOWlct
 itKNQa93EzymNLd4+yrTwAlbFiSB8IWrrW1j2RpPdFj+7njic8LQzDY0PnT9E6V+Nm0/LLRBIt4
 3us49gX4aWKgyZYuHHYVFiatmAQftiYpRx/Q2ta1+jEtDPFyE8tnUkGivgQr9wWyafhT05U/Fd8
 7POHdaacnqAgQTQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add new DRM pixel formats and add support for those in the Xilinx zynqmp
display driver.

All other formats except XVUY2101010 are already supported in upstream
gstreamer, but gstreamer's kmssink does not have the support yet, as it
obviously cannot support the formats without kernel having the formats.

Xilinx has support for these formats in their BSP kernel, and Xilinx has
a branch here, adding the support to gstreamer kmssink:

https://github.com/Xilinx/gst-plugins-bad.git xlnx-rebase-v1.18.5

New formats added:

DRM_FORMAT_Y8
- 8-bit Y-only
- fourcc: "GREY"
- gstreamer: GRAY8

DRM_FORMAT_Y10_P32
- 10-bit Y-only, three pixels packed into 32-bits
- fourcc: "YPA4"
- gstreamer: GRAY10_LE32

DRM_FORMAT_XV15
- Like NV12, but with 10-bit components
- fourcc: "XV15"
- gstreamer: NV12_10LE32

DRM_FORMAT_XV20
- Like NV16, but with 10-bit components
- fourcc: "XV20"
- gstreamer: NV16_10LE32

DRM_FORMAT_X403
- 10-bit planar 4:4:4, with three samples packed into 32-bits
- fourcc: "X403"
- gstreamer: Y444_10LE32

XVUY2101010
- 10-bit 4:4:4, one pixel in 32 bits
- fourcc: "XY30"

Some notes:

I know the 8-bit greyscale format has been discussed before, and the
guidance was to use DRM_FORMAT_R8. While I'm not totally against that, I
would argue that adding DRM_FORMAT_Y8 makes sense, as:

1) We can mark it as 'is_yuv' in the drm_format_info, and this can help
   the drivers handle e.g. full/limited range. Probably some hardware
   handles grayscale as a value used for all RGB components, in which case
   R8 makes sense, but when the hardware handles the Y-only pixels as YCbCr,
   where Cb and Cr are "neutral", it makes more sense to consider the
   format as an YUV format rather than RGB.

2) We can have the same fourcc as in v4l2. While not strictly necessary,
   it's a constant source of confusion when the fourccs differ.

3) It (possibly) makes more sense for the user to use Y8/GREY format
   instead of R8, as, in my experience, the documentation usually refers
   to gray(scale) format or Y-only format.

As we add new Y-only formats, it makes sense to have similar terms, so
we need to adjust the Y10_P32 format name accordingly.

I have made some adjustments to the formats compared to the Xilinx's
branch. E.g. The DRM_FORMAT_Y10_P32 format in Xilinx's kmssink uses
fourcc "Y10 ", and DRM_FORMAT_Y10. I didn't like those, as the format is
a packed format, three 10-bit pixels in a 32-bit container, and I think
Y10 means a 10-bit pixel in a 16-bit container.

Generally speaking, if someone has good ideas for the format define
names or fourccs, speak up, as it's not easy to invent good names =).
That said, keeping them the same as in the Xilinx trees will, of course,
be slightly easier for the users of Xilinx platforms.

I made WIP additions to modetest to support most of these formats,
partially based on Xilinx's code:

https://github.com/tomba/libdrm.git xilinx

A few thoughts about that:

modetest uses bo_create_dumb(), and as highlighted in recent discussions
in the kernel list [1], dumb buffers are only for RGB formats. They may
work for non-RGB formats, but that's platform specific. None of the
formats I add here are RGB formats. Do we want to go this way with
modetest?

I also feel that the current structure of modetest is not well suited to
more complicated formats. Both the buffer allocation is a bit more
difficult (see "Add virtual_width and pixels_per_container"), and the
drawing is complicated (see, e.g., "Add support for DRM_FORMAT_XV15 &
DRM_FORMAT_XV20").

I have recently added support for these Xilinx formats to both kms++ [2] and
pykms/pixutils [3][4] (WIP), and it's not been easy... But I have to say I
think I like the template based version in kms++. That won't work in
modetest, of course, but a non-templated version might be implementable,
but probably much slower.

In any case, I slighly feel it's not worth merging the modetest patches
I have for these formats: they complicate the code quite a bit, break
the RGB-only rule, and I'm not sure if there really are (m)any users. If
we want to add support to modetest, I think a bigger rewrite of the test
pattern code might be in order.

[1] https://lore.kernel.org/all/20250109150310.219442-26-tzimmermann%40suse.de/
[2] git@github.com:tomba/kmsxx.git xilinx
[3] git@github.com:tomba/pykms.git xilinx
[4] git@github.com:tomba/pixutils.git xilinx

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v6:
- Added tags for reviews
- Rebased on v6.17
- Link to v5: https://lore.kernel.org/r/20250425-xilinx-formats-v5-0-c74263231630@ideasonboard.com

Changes in v5:
- Add comment about Y-only formats, clarifying how the display pipeline
  handles them (they're handled as YCbCr, with Cb and Cr as "neutral")
- Clarify X403 format in the patch description
- Set unused Y-only CSC offsets to 0 (instead of 0x1800).
- Add R-bs
- Link to v4: https://lore.kernel.org/r/20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com

Changes in v4:
- Reformat the drm_format_info entries a bit
- Calculate block size only once in drm_format_info_bpp()
- Declare local variables in separate lines
- Add review tags
- Fix commit message referring to Y10_LE32 (should be Y10_P32)
- Link to v3: https://lore.kernel.org/r/20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com

Changes in v3:
- Drop "drm: xlnx: zynqmp: Fix max dma segment size". It is already
  pushed.
- Add XVUY2101010 format.
- Rename DRM_FORMAT_Y10_LE32 to DRM_FORMAT_Y10_P32.
- Link to v2: https://lore.kernel.org/r/20250115-xilinx-formats-v2-0-160327ca652a@ideasonboard.com

Changes in v2:
- I noticed V4L2 already has fourcc Y10P, referring to MIPI-style packed
  Y10 format. So I changed Y10_LE32 fourcc to YPA4. If logic has any
  relevance here, P means packed, A means 10, 4 means "in 4 bytes".
- Added tags to "Fix max dma segment size" patch
- Updated description for "Add warning for bad bpp"
- Link to v1: https://lore.kernel.org/r/20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com

---
Tomi Valkeinen (11):
      drm/fourcc: Add warning for bad bpp
      drm/fourcc: Add DRM_FORMAT_XV15/XV20
      drm/fourcc: Add DRM_FORMAT_Y8
      drm/fourcc: Add DRM_FORMAT_Y10_P32
      drm/fourcc: Add DRM_FORMAT_X403
      drm/fourcc: Add DRM_FORMAT_XVUY2101010
      drm: xlnx: zynqmp: Use drm helpers when calculating buffer sizes
      drm: xlnx: zynqmp: Add support for XV15 & XV20
      drm: xlnx: zynqmp: Add support for Y8 and Y10_P32
      drm: xlnx: zynqmp: Add support for X403
      drm: xlnx: zynqmp: Add support for XVUY2101010

 drivers/gpu/drm/drm_fourcc.c       | 28 ++++++++++++++++---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 55 +++++++++++++++++++++++++++++++++++---
 include/uapi/drm/drm_fourcc.h      | 29 ++++++++++++++++++++
 3 files changed, 105 insertions(+), 7 deletions(-)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20241120-xilinx-formats-f71901621833

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


