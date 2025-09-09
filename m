Return-Path: <linux-kernel+bounces-808177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81572B4FB82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E385E2FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4533473D;
	Tue,  9 Sep 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ile70M0m"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAFB2C21EF;
	Tue,  9 Sep 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421724; cv=none; b=PWZnS1uqtTdNr6Npb4j8SVl8RppUYQug6oDGgSDGHSs6JOr6COmxPYNEqbjy7K5CQhJVbOyO7PCH1CUVRNOdNFnO0sbNgN3xWwHDsN9/c8ZjOq86o7HpP71oggLkd7n+5hh+sNb/K5sHrWX/UTPgcVuNuF7MHIWhrhkSrViT1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421724; c=relaxed/simple;
	bh=3MiBzhsdL4dafE7452zyti+ngiEllOLG1c1BBv3fe5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6jJHRXXw+WTSsim7GtfRHb3Namlaxb5SQqHlSFPB8KhIAQ9OCbgmp1tSPL3ffFSaZdNSyBAxFRmi7eQrfddT1yMmY/UC2rHYU8M9z5V1dB0CW5mJLG8FmQE3xCkRF93tM4pSSDIUFut9lo1PwFqAlpaXhGDwyu3n7FoodrCRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ile70M0m; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <769fc59b-c248-40ff-87ba-41a18a8c5ec1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757421709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNVwcYcMRQa2515eB4UJUkPtT4gHNKDrzy0mKQWPvAs=;
	b=Ile70M0mf52PIUGjzBw+nrcoW2N4tqvyUqLur6rY21Y4NOTH/Iz2Vz52p7VCrBUD4g0bYe
	VC2a6N7CpBMlE1xoKD83Swdt7UAZrB1CtMvS47j1fWCUPGsX0jBawiGgqW7VohisdvDAlf
	Z6YKv7/K1OeT1hbbjSRaCvAm+GjueZg=
Date: Tue, 9 Sep 2025 13:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v11 2/5] net: rnpgbe: Add n500/n210 chip support
 with BAR2 mapping
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-3-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250909120906.1781444-3-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 13:09, Dong Yibo wrote:
> Add hardware initialization foundation for MUCSE 1Gbe controller,
> including:
> 1. Map PCI BAR2 as hardware register base;
> 2. Bind PCI device to driver private data (struct mucse) and
>     initialize hardware context (struct mucse_hw);
> 3. Reserve board-specific init framework via rnpgbe_init_hw.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

