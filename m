Return-Path: <linux-kernel+bounces-765324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710FB22EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A61792EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FAA2FD1B0;
	Tue, 12 Aug 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="R93pjl1Z"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628629994A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018738; cv=none; b=BnpF5cO/YFapsr0vpv6tUqeVtYl/RZjvFMzXiazkiCM30ta4N+MSUkHn5ltSxVxRbxugqjKGoB5O5EjdP/nqd2YoB6tgPMfFIsUNUltZioemGlLjSJbUwMycx3iSvz3g5jrd+JyxUdbGYMx9F7YWztQk6Y6Jxt5BY/iKVHSFIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018738; c=relaxed/simple;
	bh=lS/40P8nQMXKSvQR6zaZadkefSkKwNcHGpfg+Wj5eCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHFGAYH6z+uKlWMGHsRKKXUa3jNqPiz0mkiO0ue4TRT5m+c9TDsqf4Z/zmjDCjdmU4m5GkIcCSCtI3VoW0PbhfeTRYWDpDkpgCSC/2XqiGGEOct7TayBx/8gkuN6V2+HOTEgePhEVQOPg3pktfxMjFOOhyi51cwA/rs9/NjXrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=R93pjl1Z; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1755018733;
 bh=cdeSFqQnzEBtE1cji6fpW5bK8huqaFlZYcJ7e7uALrE=;
 b=R93pjl1ZZ75pMZc2by7v1hRq+D3BHYcg6Bpqis2cMw0DpZKCniTjhHf0I7U0zAFogZ9PFmGgp
 3knqf1bXc4HAv1K6kmDIW1aEZOkFEauIDexJ9ZEcZsqTNkUlTzr2Yj5wDdYrjmeYSpVBmO5qnMI
 1BvKG1MirGuMLNdWmRqh+pmuBmiza1MslPSyF8l/G08B0bGIoWk1+Heg+bFCf/sr7qgZhbWsz/z
 vczMVX/S9T1IBHPIW6T8FpPZ0cDsyOQA6NGcUpTSjD3T/fRFwvDgdaQfksWmYGfRZu7QdaNqUp3
 UEe2zonY8paIojmRU4REBTB53mJc+gQIMzYKO+Iz1/XQ==
X-Forward-Email-ID: 689b75bff092412ac26312e8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <64d551d7-924a-48af-96ca-224fa94543d8@kwiboo.se>
Date: Tue, 12 Aug 2025 19:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] media: rkvdec: Add HEVC backend
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Alex Bee <knaerzche@gmail.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Sebastian Fricke <sebastian.fricke@collabora.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250810212454.3237486-1-jonas@kwiboo.se>
 <DC0FTXJNW0KB.3I8DLNHJVL21O@cknow.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <DC0FTXJNW0KB.3I8DLNHJVL21O@cknow.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Diederik,

On 8/12/2025 2:11 PM, Diederik de Haas wrote:
> Hi Jonas,
> 
> On Sun Aug 10, 2025 at 11:24 PM CEST, Jonas Karlman wrote:
>> This series add a HEVC backend to the Rockchip Video Decoder driver.
>>
>> With the dependent H.264 High 10 and 4:2:2 profile support series
>> finally merged there is finally time to send a v2 with minor changes and
>> a suggested code style fix of this series. v1 of this series has been
>> fully functional up until recent unstaging of the rkvdec driver.
>>
>> A version of this HEVC backend has been in use by the LibreELEC distro
>> for the past 5+ years [1]. It was initially created based on a copy of
>> the H264 backend, unstable HEVC uAPI controls and a cabac table + scaling
>> matrix functions shamelessly copied 1:1 from the Rockchip mpp library.
>>
>> It has since then been extended to use the stable HEVC uAPI controls and
>> improved opon e.g. to include support for rk3288 and fix decoding issues
>> by Alex Bee and Nicolas Dufresne.
>>
>> The version submitted in this series is based on the code currently used
>> by the LibreELEC distro, excluding hard/soft reset, and with cabac table
>> and scaling matrix functions picked from Sebastian Fricke prior series
>> to add a HEVC backend [2].
>>
>> Big thanks to Alex Bee, Nicolas Dufresne and Sebastian Fricke for making
>> this series possible!
>>
>> Patch 1 add the new HEVC backend.
>> Patch 2-3 add variants support to the driver.
>> Patch 4 add support for a rk3288 variant.
>> Patch 5 add a rk3328 variant to work around hw quirks.
>> Patch 6-7 add device tree node for rk3288.
> 
> It looks like I had a previous version of linuxtv-rkvdec-hevc-v2 branch
> locally and that also had this commit:
> - media: rkvdec: Keep decoder clocks gated
> 
> Is that one no longer needed/useful/etc ?

I do not think it is, could possible be to keep power consumption at
minimum while decoding. Some parts enable auto gating and then we
disable it when decoding is complete. With auto-suspend the entire block
is disabled anyway so this probably did not make any noticeable
difference and could instead introduce new possible issues.

> 
> And 'chewitt' also had a commit to fix 8/10-bit selection:
> https://github.com/chewitt/linux/commit/4b93b05d2ca608bc23f1d52bcc32df926d435c7c
> "WIP: media: rkvdec: fix 8-bit/10-bit format selection"
> 
> I haven't tried that one (yet), but did  try an other variant with
> changing the ordering in rkvdec_hevc_decoded_fmts but that didn't work
> in my tests. (Can ofc be PEBKAC)

The format selection in kernel for this series should be correct,
however to ensure 10-bit works you need following for ffmpeg-v4l2request
to select and use 10-bit pixel formats:

libdrm 2.4.104+ (NV15) / 2.4.118+ (NV20)
- 10-bit drm formats, ffmpeg v4l2request test with a #ifdef

linux headers v6.16-rc1+ (NV15/NV20)
- 10-bit v4l2 pix fmt, ffmpeg v4l2request test with a #ifdef

FFmpeg v4l2request will not negotiate use of 10-bit formats without
DRM_FORMAT_NV15/NV20 and V4L2_PIX_FMT_NV15/NV20 defined when ffmpeg was
compiled.

That would be the most likely issue if only 8-bit formats is working.

> 
> Would that be useful? I do/did have consistent problems with playing
> 10-bit encoded video files.

Looking quickly at the 'fix 8/10-bit selection' commit the issue is that
rkvdec_hevc_get_image_fmt() was incomplete to begin with. The
rkvdec_hevc_get_image_fmt() in this series has been correct since v1.

> 
>> This was tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
>> <snip>
>>
>> Please note that there is a known issue with concurrent decoding,
>> decoding errors in one decode session may affect a separate session.
>> The only known mitigation to this is to pause decoding for some time
>> and/or do a full HW reset, something to handle in future series.
> 
> Or would that be (potential) material for a future series as well?

Yes, adding proper HW reset support is something for a future series.

Regards,
Jonas

> 
> Cheers,
>   Diederik
>>
>> <snip>
>>
>> Alex Bee (4):
>>   media: rkvdec: Add variants support
>>   media: rkvdec: Add RK3288 variant
>>   media: rkvdec: Disable QoS for HEVC and VP9 on RK3328
>>   ARM: dts: rockchip: Add vdec node for RK3288
>>
>> Jonas Karlman (3):
>>   media: rkvdec: Add HEVC backend
>>   media: rkvdec: Implement capability filtering
>>   media: dt-bindings: rockchip,vdec: Add RK3288 compatible
>>
>>  .../bindings/media/rockchip,vdec.yaml         |    1 +
>>  arch/arm/boot/dts/rockchip/rk3288.dtsi        |   17 +-
>>  .../media/platform/rockchip/rkvdec/Makefile   |    2 +-
>>  .../rockchip/rkvdec/rkvdec-hevc-data.c        | 1848 +++++++++++++++++
>>  .../platform/rockchip/rkvdec/rkvdec-hevc.c    |  826 ++++++++
>>  .../platform/rockchip/rkvdec/rkvdec-regs.h    |    4 +
>>  .../platform/rockchip/rkvdec/rkvdec-vp9.c     |   10 +
>>  .../media/platform/rockchip/rkvdec/rkvdec.c   |  184 +-
>>  .../media/platform/rockchip/rkvdec/rkvdec.h   |   15 +
>>  9 files changed, 2886 insertions(+), 21 deletions(-)
>>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-data.c
>>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c
> 


