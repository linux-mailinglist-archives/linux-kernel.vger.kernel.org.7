Return-Path: <linux-kernel+bounces-840122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBABB3978
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56A1174C64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CB2FE56F;
	Thu,  2 Oct 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vr2Bqqu+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34742EDD76;
	Thu,  2 Oct 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400222; cv=none; b=jqbnGcQT3TJ2oFSuuUz08+F+M/PDrEzA3s/E1feEQvsEQmw3HLDQJMKJZZLZW73mK+r0Zb3M2aybI4xINMXrDirasy5yLDrckWO6/6zi6KKk2RgAgeTVCuQJMrOkw5HQs6cw5kpqYKFuZRW/9fAOo+QBe91wrSp3vp22uaxmtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400222; c=relaxed/simple;
	bh=rBdIXori8WP0TwgaYABKn1raWbJCyFiPMjbMD4E+mCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVvceV+tQ4Kblp9+HbFdJLoDb6SquykESbUgNLmooo/YvKV/iwR2zV+2rAVM8AWYo0cJ6kXXQBIrCt2c8bmpnSRujwwXDfSpawQocoBTHrOZ1MhySwFUXc5Dx2s/BCBT7iPheq59GzuASSff8+vylw2PjxFZY8I4p/Aq6O/9qAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vr2Bqqu+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759400218;
	bh=rBdIXori8WP0TwgaYABKn1raWbJCyFiPMjbMD4E+mCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vr2Bqqu+gLxMJ82V8rA5gq4SJrB52nulJwTLREEAqZFl0iEVvNLjPBs8Ba9ORsUbr
	 asg+l6oBDPmjV/KXe7v5I6eLqKJsyNMaXlMlY1BBc9kq5GK6g9yvFn/nGJmtan7ztC
	 5WjyVywbe4D6KDNBKVyy05SFKo/kwMYg5QpQ9Xar7XxqsAClCLbTvACQQsPjKvvo/l
	 wbh35IhN8N2KiHL5HQqM7deKO11w4xNtRDHgBlixAVMlbbdf52vloG+4PCqJBhHpsQ
	 KYQWJ+QC/vDfKrl/teaGxJWkHr1gDjTQAVIpKnhITq4NZWRELRVfkZzalvw04la5fn
	 GhlxY88U7S55g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D68317E12BB;
	Thu,  2 Oct 2025 12:16:58 +0200 (CEST)
Message-ID: <e2253310-8a07-45db-a3e9-ead9a9bf69ad@collabora.com>
Date: Thu, 2 Oct 2025 12:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: ASoC: Convert MediaTek RT5650 codecs
 bindings to DT schema
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>, broonie@kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, lgirdwood@gmail.com,
 matthias.bgg@gmail.com, robh@kernel.org
Cc: devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
References: <20251001183517.83278-1-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251001183517.83278-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/10/25 20:35, Ariel D'Alessandro ha scritto:
> Convert the existing text-based DT bindings for Mediatek MT8173 RT5650
> codecs to a DT schema.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



