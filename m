Return-Path: <linux-kernel+bounces-749262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620CB14C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6745452CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8127289350;
	Tue, 29 Jul 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d19DDHnJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C926D4EF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784799; cv=none; b=dW6XTqh7AYNvMMLt6jUSqwDUtNe1AUxkYgz584VNKozA9r9+CejqPAyn6oGZeaY+iGbQJo4VXPndU8CIhOLCnm6wLieejdAxVcThmB4LFCgw8Z29M/QRzvsaf5VOO80AeXi8DDmIjCCfqP8qLCw9NxYH2ifWsWN6AYnhCNTWx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784799; c=relaxed/simple;
	bh=eOtAjkutcfTgfbsTp9YZ6t3LmyaglOAeVM+Ud2WX8gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rH8Reoci3bm2FSd8+Zzny//h4cmXJZFK4j0OV1MREyWFxgQwd61gFtKfmvpGQJhv7bprhG9PazluX4YyA2+a3r1/FfUnkzs0vomGiSWf/ygIxlJYjskWaxn7Obk91otyrtp4M8Tl7aiHnBLRcqZ9Q78SjTbXpOSfZvQmZ3i4Bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d19DDHnJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753784794;
	bh=eOtAjkutcfTgfbsTp9YZ6t3LmyaglOAeVM+Ud2WX8gE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d19DDHnJYY4lXlvk7kWjbkvAlwGGfW/DR+TRQrOgBAKEbu8d59K9iyog18odLNH/d
	 MWYHoP3lE8vm8KzH/oJj7ZwoY2/33e5+mwrdrMVMbQ4OuxAIkcPyhZo+YXGuQJdfAG
	 JQJ7+t5beFEpbT7Q9zkzJ6x9SGjONFgoBASVhsCPAEf8jPo43OAv4/G94B1vgwLgvg
	 qOlHU8taa5oXeZcC0J5TdyQHq7Tz7e2swZYi0sGHZUM1ux0NUvSVRpxcYg18rvFW7f
	 qmEH9vrLwewjMmSaOq8eVQS6g5ZeD7BYSSwGmgVRJzY0AsV4T6GBOHe0ZsaivSAGT9
	 gFxMdntqqBn5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C92717E1315;
	Tue, 29 Jul 2025 12:26:33 +0200 (CEST)
Message-ID: <bba7ff19-8ce0-406d-b2a1-4489858fdb33@collabora.com>
Date: Tue, 29 Jul 2025 12:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] drm/mediatek: Add error handling for old state
 CRTC in atomic_disable
To: Jason-JH Lin <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, David Airlie <airlied@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>, Nancy Lin
 <nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>,
 Paul-PL Chen <paul-pl.chen@mediatek.com>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>,
 Zhenxing Qin <zhenxing.qin@mediatek.com>,
 Xiandong Wang <xiandong.wang@mediatek.com>,
 Sirius Wang <sirius.wang@mediatek.com>,
 Xavier Chang <xavier.chang@mediatek.com>,
 Jarried Lin <jarried.lin@mediatek.com>, Fei Shao <fshao@chromium.org>,
 Chen-yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250728025036.24953-1-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250728025036.24953-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/07/25 04:48, Jason-JH Lin ha scritto:
> Introduce error handling to address an issue where, after a hotplug
> event, the cursor continues to update. This situation can lead to a
> kernel panic due to accessing the NULL `old_state->crtc`.
> 
> E,g.
> Unable to handle kernel NULL pointer dereference at virtual address
> Call trace:
>   mtk_crtc_plane_disable+0x24/0x140
>   mtk_plane_atomic_update+0x8c/0xa8
>   drm_atomic_helper_commit_planes+0x114/0x2c8
>   drm_atomic_helper_commit_tail_rpm+0x4c/0x158
>   commit_tail+0xa0/0x168
>   drm_atomic_helper_commit+0x110/0x120
>   drm_atomic_commit+0x8c/0xe0
>   drm_atomic_helper_update_plane+0xd4/0x128
>   __setplane_atomic+0xcc/0x110
>   drm_mode_cursor_common+0x250/0x440
>   drm_mode_cursor_ioctl+0x44/0x70
>   drm_ioctl+0x264/0x5d8
>   __arm64_sys_ioctl+0xd8/0x510
>   invoke_syscall+0x6c/0xe0
>   do_el0_svc+0x68/0xe8
>   el0_svc+0x34/0x60
>   el0t_64_sync_handler+0x1c/0xf8
>   el0t_64_sync+0x180/0x188
> 
> Adding NULL pointer checks to ensure stability by preventing operations
> on an invalid CRTC state.
> 
> Fixes: d208261e9f7c ("drm/mediatek: Add wait_event_timeout when disabling plane")
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



