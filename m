Return-Path: <linux-kernel+bounces-765353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA42AB22F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C083562756
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CE2FDC4F;
	Tue, 12 Aug 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="c/A+57AB"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CD2FDC2B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019913; cv=none; b=UpsfpNHhA6w40hVqGaZS41VDwz11pTx8d8D/oa8c6RXTXx8qydFI9AV/cgNDFl1eq37HgG8XWFXVDwhmMuMl02zUUKuAVvF4PPB3jyxjCDJW2QNgLECvKvN5d6mOxt2dq4YKL/fvmoWHoPznIZRL0WBbinRU0iWMpKQwod+qLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019913; c=relaxed/simple;
	bh=vGPEjbF20fanotlxlvyuLCGGl8an7bi1fogBzOPg9iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKDWZXpfADQ5e8XWL0njb59YL0Axlji+ToIgYfyIK8UaCvh7AqB4ecVzuKpElrdquCuVw/4K4DCk8pxNZ8+5SlDVbaAYh8bugtxyeR7GKxSSu3zy2G60x3PvpuZO5KW8mRihxFfjEGFBq8qdXrGS/js+VpQl8abrwYZGDSeqn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=c/A+57AB; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1755019909;
 bh=lLNl7MI8X4M5cxrMR25hGPEYfSQVqkkWhNzJlEstFA0=;
 b=c/A+57ABEc86qFRkbT3YxSoUTbk1suErG6+UYUEVudmnMctx2i3e+4mauZi7y5BuVtasDxxmK
 dmkb6agWunYlH+g7vP1xsLY5VxFRnRYHMiW2F8UuAv2hrX+3rXOjXZsnKBLWBWxWBJtiiMCS8Ke
 MBZGTCMeD5YgtZqjk4GCGRMTsJWyZHBke4KsWjqAdZN3qwToof8kme/gPXzu5pT3LSmkcTUBO05
 C9RkclPkmcta6oV9mG95nZEkEPUKIIfo5UHWYcj6VwUBdR9n7fGWmp16/WFg1zg7/5ahC3C1+IA
 mavOTTFDqHfNwJdyjAyvfLvHpKENsPslfoL02B6Eq0kw==
X-Forward-Email-ID: 689b7a6df092412ac2631c2f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <efdf8c99-d166-4b78-afc5-d4a6eb5ac046@kwiboo.se>
Date: Tue, 12 Aug 2025 19:31:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] media: rkvdec: Add HEVC backend
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Alex Bee <knaerzche@gmail.com>,
 Sebastian Fricke <sebastian.fricke@collabora.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250810212454.3237486-1-jonas@kwiboo.se>
 <50162371fd54fc976a84fcf57c9b69112a892c46.camel@collabora.com>
 <1dd29158-0660-4254-ac00-1316768d9b82@kwiboo.se>
 <91864a1c047d2bdfce202b070716a694ede47d5e.camel@collabora.com>
 <a66feb89fa02f05b187e5603ffc3b1501ef3cbd5.camel@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a66feb89fa02f05b187e5603ffc3b1501ef3cbd5.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/2025 2:44 PM, Nicolas Dufresne wrote:
> I forgot, 
> 
> Le mardi 12 août 2025 à 08:38 -0400, Nicolas Dufresne a écrit :
>>> JCT-VC-HEVC_V1 on GStreamer-H.265-V4L2SL-Gst1.0:
>>>
>>> - DBLK_D_VIXS_2 (fail)
>>> - DSLICE_A_HHI_5 (fail)
>>> - EXT_A_ericsson_4 (fail)
>>> - PICSIZE_A_Bossen_1 (error)
>>> - PICSIZE_B_Bossen_1 (error)
>>> - PICSIZE_C_Bossen_1 (error)
>>> - PICSIZE_D_Bossen_1 (error)
>>> - SAODBLK_A_MainConcept_4 (fail)
>>> - SAODBLK_B_MainConcept_4 (fail)
>>> - TSUNEQBD_A_MAIN10_Technicolor_2 (error)
> 
> I'me getting the same result if I force a single job in fluster. The test I
> posted was with 2 jobs. Detlev found that the iommu reset is required in more
> cases on RK3588/3576, perhaps the HEVC decoder in older hardware needs the same,
> I will try and report.

Vendor kernel [1] check following bits from RKVDEC_REG_INTERRUPT reg to
decide if a full HW reset should be done.

  err_mask = RKVDEC_BUF_EMPTY_STA
  	   | RKVDEC_BUS_STA
  	   | RKVDEC_COLMV_REF_ERR_STA
  	   | RKVDEC_ERR_STA
  	   | RKVDEC_TIMEOUT_STA;

Adding proper reset support can be rather involved and main reason why
this series does not handle it, better suited for a separate future
series.

Proper HW reset will require e.g. dt-bindings, DT updates, pmu idle
request integration and for rk3328 vendor even moved VPU reset to TF-A.

Doing the iommu detach/attach dance not only on RKVDEC_SOFTRESET_RDY
could possible improve some cases, until full reset can be implemented.

[1] https://github.com/Kwiboo/linux-rockchip/blob/linux-6.1-stan-rkr6.1/drivers/video/rockchip/mpp/mpp_rkvdec.c#L924-L931

Regards,
Jonas

> 
> Nicolas


