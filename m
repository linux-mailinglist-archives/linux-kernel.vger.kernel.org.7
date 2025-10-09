Return-Path: <linux-kernel+bounces-846421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2ABC7F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470953C3EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7125F2BE658;
	Thu,  9 Oct 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qMMCtFVP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8C272E6A;
	Thu,  9 Oct 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997524; cv=none; b=VlbItZbub6iYNqpklIL1GT9dmntPpj3+ivdiVWQ37aM/wKtUxFzZZyCIAFo91iOJyJBM/mRBgJ08ZkbspxeQcu+iqOBS2BvY9S1dCMD/Xva4j++tiSlu1en0J74otf/L2RMvwinFY5RsJIfW9WihQtOCLYfEYoeUpdHMQZAzfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997524; c=relaxed/simple;
	bh=HDPv9WiPLw0BP2sEHt65AvFtVCCKpnVMmx2R3TRokFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke6q3KGUPYrzUr9LM5AtUgOJ5/SxQwN+RlO/W4V6KazmEFwXxUuDN+BfF4ojB7NjCXnz1X3jAH60vCNX/aGb5xWLCUnYC4u1m5ik8gFPmm77TfYXFtWd2qcZ9/Me2ayNv1Wi4CFhPV/vFnmvYEFBVjmTkiQ3D1noR7XnJzn9ghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qMMCtFVP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759997521;
	bh=HDPv9WiPLw0BP2sEHt65AvFtVCCKpnVMmx2R3TRokFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qMMCtFVP1sWWOUk+5CeBOOzafGdA4qTnk/fQMWxbXynXkpNO0nL5BubfKIMdNpxVc
	 KAArGrfvHAsJEl61czGEM3tTZl6UHqhGjUJjJ6WZ8ODhk68RXoOT7B7ozTVjLS/r77
	 mg0+MEPk+Rz+5mzJnVQYAJISKgcxs6R+ASXRAw33F5qBvl67a392L0vwxS3hKLkhxc
	 tSp0zcrouIM7qOdeoLAU7/zs6oNAAQtq/axnmzLzKZwH21CsQSWwxHhguX7+TQLlEA
	 FLAv03tjp7s3hzD8dhfbe+HC7kgpk3mUtLYxGav6K6x/r2tIrCS7m0MBx/dx8srLtL
	 ugefbML1wkDPQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AF68117E04DA;
	Thu,  9 Oct 2025 10:12:00 +0200 (CEST)
Message-ID: <482eda01-e170-4f31-8d56-4f5b0b896dd9@collabora.com>
Date: Thu, 9 Oct 2025 10:12:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] clk: mediatek: Refactor pllfh registration to pass
 device
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
 <20251008-mtk-pll-rpm-v2-4-170ed0698560@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251008-mtk-pll-rpm-v2-4-170ed0698560@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/25 18:05, Nicolas Frattaroli ha scritto:
> After refactoring all of PLL to pass the device, it's now fairly easy to
> refactor pllfh and its users, as pllfh registration wraps PLL
> registration.
> 
> Do this refactor and move all of the pllfh users to pass the device as
> well.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



