Return-Path: <linux-kernel+bounces-860670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB0BF0AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA93E3310
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0724DD17;
	Mon, 20 Oct 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gBvRol7R"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424324DCE9;
	Mon, 20 Oct 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957381; cv=none; b=nCxdHGvRCh6iFNA9jxkWP0lw4UnQKL4MraQni89rSBtN2WtNQCXLVLTQ35X5vWcAPKbGHsetpeiBgiCB28S/9AlAOh96SX5VMyjN8oob6yaksvScWpb5NgWO3/zpJJNpeos5PSGVmRluPavQO+rGWsNde2Ef2AlkZfE4eCQTizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957381; c=relaxed/simple;
	bh=4q7bStPX7BqVDGCLC1PViWLocjPoO+px7Wi9b1Kj/T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7zpQE6tXPlQIn88XF6cKD+7sXY6sVpu3een+4xdL8zncX6ZsRMtmEkDy7jairAqcMXP5tEptLwzoaw3D0eBAzhp6cP1f44DQNhJvZh0i3EFEncemmvmDTdzZeumf15g+RLXMDqoFai/pY4g1FfrD8n2SXP8niAUEt79QuooWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gBvRol7R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760957378;
	bh=4q7bStPX7BqVDGCLC1PViWLocjPoO+px7Wi9b1Kj/T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gBvRol7Rqry/KkHOfomZ5bphkYi7XMyIjNbgPMPmBLhcTqpvJFSW8Z/+mhrT5yTI4
	 wFvFzPwK27f+wiEbk8VSn37Trs1zu0j2BkmztH35tqO+Fsb3z2kWAAEXbt5FaxEEOo
	 W4xqME1YAwkX9+G5Wep5fPsyUnlnMNGxa9Xr7Ejt7ekFH0ugluIucTcTll5IUWrwC3
	 JBIJJ+hrJDsdzV5muyDrASImeJgUOFd9ENPaTnHNz1ChitJBbQNow4RshEx8Tv18MV
	 lavAccJsT1E90RwWATPgFR1NHRve2hzrb8H6FYv4Yqmo6pJHcHmx3nIC/6bTy2ZRXm
	 lhZ3vZKoxEdmA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 93B1317E0FAD;
	Mon, 20 Oct 2025 12:49:37 +0200 (CEST)
Message-ID: <0cb6a85a-1fdd-4ac7-aba7-bb25945b21f9@collabora.com>
Date: Mon, 20 Oct 2025 12:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] dt-bindings: arm: mediatek: mmsys: add
 compatible for MT8189
To: Xiandong Wang <xiandong.wang@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
 <20251020074211.8942-7-xiandong.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020074211.8942-7-xiandong.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 09:40, Xiandong Wang ha scritto:
> In MT8189, a single HW pipeline was an independent mmsys,
> which included the OVL module, PQ module, and display interface
> module.
> 
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



