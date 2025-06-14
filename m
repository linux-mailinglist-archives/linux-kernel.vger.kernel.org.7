Return-Path: <linux-kernel+bounces-687033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B029AD9F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0D17628D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120D1E8320;
	Sat, 14 Jun 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SFuAS0JT"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF91EBFE0;
	Sat, 14 Jun 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749927248; cv=none; b=TIHRXR3C5a7bLesoI2Hj6ZPI/C/vSqZ4RED3Q3oD2MRHjlR+IVGS460JzlMjBN5CXQwPJaz//vn/ToZmelBg0B1tMrEHHV0dVs43hXKwqeJ8bd6F7G3GOpyq+N33GirDnSMsilBIz1sjYDLGEPn37zoNF2H5BPYi7PKUc89H+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749927248; c=relaxed/simple;
	bh=7ZXzApUk5l2qS86Q3m8IfXmZ+4gYsRPxq+nMQeFcvNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=gXzjdiazsZ3pyZEoaM/cD0+l4aOrGk6q2RZPa9g/QHMbEgSiZwn7FJy6eefmG4VpttDUI41CL7ojP4El6v1LG62hgGofeMgRH+EF++RGmoNOWYDuPFyDLsvpXlGXnXttdyFQJmQ/Rqk7G+jJaLuDGZocLDFJriRewGRSn2mzCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SFuAS0JT; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250614185402euoutp01e5e6f59d2241bc2cbe37305571877d54~I-Y5G6nHA1202912029euoutp01d;
	Sat, 14 Jun 2025 18:54:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250614185402euoutp01e5e6f59d2241bc2cbe37305571877d54~I-Y5G6nHA1202912029euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749927242;
	bh=7KEfhRp6tc3/RqpqL6VW1k9rbi+XK5sl46BXBJoQ56U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SFuAS0JTlb+Uc+syWfLpDwqf4YdSFq/Av//E/FZ3W6jbeV6pwQhHBmgirah5wjjCE
	 RBthWoGosiknr24lAvtDaSp5MDSzpy0g64g1D/P6WEEhNRLidydlQpKY1AJdtL9Hf+
	 /LsVGpD94bFNpqLMeScHlZ+RHg0338sVELJxAs/0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250614185401eucas1p2ee3104b2054057c27a757b99f6b1a748~I-Y3uT4wk1692616926eucas1p2K;
	Sat, 14 Jun 2025 18:54:01 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250614185359eusmtip1bfe9e9bceb8b79c3627bd748ad193068~I-Y2gwiqt2547525475eusmtip1R;
	Sat, 14 Jun 2025 18:53:59 +0000 (GMT)
Message-ID: <c7df0d84-93a6-4a9c-b911-515d0816d899@samsung.com>
Date: Sat, 14 Jun 2025 20:53:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] drm/verisilicon : support DC8200 and inno hdmi
To: Maud Spierings <maud_spierings@hotmail.com>, keith zhao
	<keith.zhao@starfivetech.com>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, william.qiu@starfivetech.com,
	xingyu.wu@starfivetech.com, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	changhuang.liang@starfivetech.com, jack.zhu@starfivetech.com
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
	william.qiu@starfivetech.com, xingyu.wu@starfivetech.com, kernel@esmil.dk,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	p.zabel@pengutronix.de, changhuang.liang@starfivetech.com,
	jack.zhu@starfivetech.com, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <AM7P189MB10092D0348FC9E0A70C911E2E3D12@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250614185401eucas1p2ee3104b2054057c27a757b99f6b1a748
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250614185401eucas1p2ee3104b2054057c27a757b99f6b1a748
X-EPHeader: CA
X-CMS-RootMailID: 20250614185401eucas1p2ee3104b2054057c27a757b99f6b1a748
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
	<AM7P189MB10092D0348FC9E0A70C911E2E3D12@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
	<CGME20250614185401eucas1p2ee3104b2054057c27a757b99f6b1a748@eucas1p2.samsung.com>



On 3/11/25 08:42, Maud Spierings wrote:
> On 11/20/24 07:18, keith zhao wrote:
>> Verisilicon/DC8200 display controller IP has 2 display pipes and each
>> pipe support a primary plane and a cursor plane .
>> In addition, there are 4 overlay planes as 2 display pipes common resources.
>>
>> The first display pipe is bound to the inno HDMI encoder.
>> The second display pipe is bound to Internal custom encoder,
>> which is used to find dsi bridge by dts node.
>>
>> This patchset should be applied on next branch.
>>
>> V1:
>> Changes since v1:
>> - Further standardize the yaml file.
>> - Dts naming convention improved.
>> - Fix the problem of compiling and loading ko files.
>> - Use drm new api to automatically manage resources.
>> - Drop vs_crtc_funcs&vs_plane_funcs, subdivide the plane's help interface.
>> - Reduce the modifiers unused.
>> - Optimize the hdmi driver code
>>
>> V2:
>> Changes since v2:
>> - fix the error about checking the yaml file.
>> - match drm driver GEM DMA API.
>> - Delete the custom crtc property .
>> - hdmi use drmm_ new api to automatically manage resources.
>> - update the modifiers comments.
>> - enabling KASAN, fix the error during removing module
>>
>> V3:
>> Changes since v3:
>> - Delete the custom plane property.
>> - Delete the custom fourcc modifiers.
>> - Adjust the calculation mode of hdmi pixclock.
>> - Add match data for dc8200 driver.
>> - Adjust some magic values.
>> - Add a simple encoder for dsi output.
>>
>> V4:
>> Changes since v4:
>> - Delete the display subsystem module as all crtcs and planes are a driver.
>> - Delete the custom struct, directly use the drm struct data.
>> - Tidy up the inno hdmi public interface.
>> - Add a simple encoder for dsi output.
>>
>> V5:
>> Changes since v5:
>> - Refine the Innosilicon HDMI by quoting bridge abstracting.
>> - Delete the encoder driver, which is created directly by internal functions.
>> - Adapt to the changes in kernel upgrade APIs, such as drm_client_setup.
>>
>> keith zhao (9):
>>    dt-bindings: display: bindings for starfive,JH7110 display pipeline
>>    riscv: dts: Add display property
>>    drm: bridge: inno-hdmi: add inno bridge driver.
>>    drm/vs: Add Hardware Functions for VS DC8200
>>    drm/vs: Add Base API for VS Mode Configuration
>>    drm/vs: Add CRTC Functions
>>    drm/vs: Add VS Plane API
>>    drm/vs: Add Innosilicon HDMI Support
>>    drm/vs: Add VS DRM Master Driver for JH7110 SoC
>>
>>   .../display/bridge/innosilicon,inno-hdmi.yaml |   45 +
>>   .../display/rockchip/rockchip,inno-hdmi.yaml  |   27 +-
>>   .../starfive/starfive,jh7110-dc8200.yaml      |  176 +++
>>   .../starfive/starfive,jh7110-inno-hdmi.yaml   |   91 ++
>>   .../soc/starfive/starfive,jh7110-syscon.yaml  |    1 +
>>   MAINTAINERS                                   |   11 +
>>   .../boot/dts/starfive/jh7110-common.dtsi      |  125 ++
>>   arch/riscv/boot/dts/starfive/jh7110.dtsi      |   41 +
>>   drivers/gpu/drm/Kconfig                       |    2 +
>>   drivers/gpu/drm/Makefile                      |    1 +
>>   drivers/gpu/drm/bridge/Kconfig                |    2 +
>>   drivers/gpu/drm/bridge/Makefile               |    1 +
>>   drivers/gpu/drm/bridge/innosilicon/Kconfig    |    6 +
>>   drivers/gpu/drm/bridge/innosilicon/Makefile   |    2 +
>>   .../gpu/drm/bridge/innosilicon/inno-hdmi.c    |  376 ++++++
>>   .../gpu/drm/bridge/innosilicon/inno-hdmi.h    |   34 +
>>   drivers/gpu/drm/rockchip/Kconfig              |    1 +
>>   drivers/gpu/drm/rockchip/Makefile             |    2 +-
>>   drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  690 +++++++++++
>>   .../{inno_hdmi.h => inno_hdmi-rockchip.h}     |    0
>>   drivers/gpu/drm/rockchip/inno_hdmi.c          | 1025 ---------------
>>   drivers/gpu/drm/verisilicon/Kconfig           |   32 +
>>   drivers/gpu/drm/verisilicon/Makefile          |   10 +
>>   .../gpu/drm/verisilicon/inno_hdmi-starfive.c  |  553 +++++++++
>>   .../gpu/drm/verisilicon/inno_hdmi-starfive.h  |  194 +++
>>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  241 ++++
>>   drivers/gpu/drm/verisilicon/vs_crtc.h         |   42 +
>>   drivers/gpu/drm/verisilicon/vs_dc_hw.c        | 1104 +++++++++++++++++
>>   drivers/gpu/drm/verisilicon/vs_dc_hw.h        |  492 ++++++++
>>   drivers/gpu/drm/verisilicon/vs_drv.c          |  777 ++++++++++++
>>   drivers/gpu/drm/verisilicon/vs_drv.h          |   41 +
>>   drivers/gpu/drm/verisilicon/vs_modeset.c      |   31 +
>>   drivers/gpu/drm/verisilicon/vs_modeset.h      |   10 +
>>   drivers/gpu/drm/verisilicon/vs_plane.c        |  358 ++++++
>>   drivers/gpu/drm/verisilicon/vs_plane.h        |   27 +
>>   drivers/gpu/drm/verisilicon/vs_type.h         |   54 +
>>   include/drm/bridge/inno_hdmi.h                |   56 +
>>   37 files changed, 5630 insertions(+), 1051 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
>>   create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
>>   create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Kconfig
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Makefile
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.h
>>   create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
>>   rename drivers/gpu/drm/rockchip/{inno_hdmi.h => inno_hdmi-rockchip.h} (100%)
>>   delete mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>>   create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>>   create mode 100644 drivers/gpu/drm/verisilicon/inno_hdmi-starfive.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/inno_hdmi-starfive.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
>>   create mode 100644 include/drm/bridge/inno_hdmi.h
>>
> 
> Is this patch series still being worked on? If not I would like to give it a try to fix it up and get it merged.
> 
> Would like to get it working on my deepcomputing fml13v01 board, there is also a gpu driver for the thead th1520 being worked on by Michal Wilczynski that depends on this. Would be nice if that could get merged when it is ready.

Hi Maud,

Thanks for your interest in this patch series. I'm also keen to see it
merged, as the GPU support on the TH1520 Soc depends on it. I just sent
v4 of my series [1] with the last missing pieces to enable the GPU
driver to probe correctly.

I'm not aware of any recent progress on this particular set from Keith.
I would be happy to collaborate with you or take over the work of
getting it ready for merging.

I also have a StarFive Vision Five 2 board, and my plan was to get the
driver working for the JH7110 first. The only thing different for the
TH1520 SoC is the HDMI driver, which could be added later.

However, the main blocker is the lack of public documentation for the
Verisilicon DC8200 controller. The official StarFive documentation
portal [2] mentions two essential documents: "DC8200 Dual Display
Controller DPU IP Exposed Accessible Registers" and "DC8200 Dual Display
Controller IP Hardware Features."

Pinging the StarFive developers on this thread: would it be possible to
make these documents available? Access to them is critical for us to
successfully move this driver forward.

[1] - https://lore.kernel.org/all/20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com/
[2] - https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/detail_info_display.html

> 
> Kind regards,
> Maud
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

