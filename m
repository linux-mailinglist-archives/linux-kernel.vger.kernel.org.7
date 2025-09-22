Return-Path: <linux-kernel+bounces-827150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A6B90718
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB757A1B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04D30506F;
	Mon, 22 Sep 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eN1bBPag"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FC29E0E5;
	Mon, 22 Sep 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541158; cv=none; b=pwwDZsKDQ2RWJ8r8gNL4Fbwf4ryNnWS+I2sizG+nt6S5zUDhmy2+4O6qsMW4mxW4w8c1Sjq/kKLUWs07Z5B9kY9hvR6cVwW+JwSXAPwsjwXEMMYrFmhaGeY1HwcWur+Q1iPoH9QFZwAhyAL1LpQZkyeoaD276tDBwLK0JWw+rJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541158; c=relaxed/simple;
	bh=nMADfA3UKEbyqlZhjNt1e9kpbSLVmyXTD2ba8CiFz+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n/vBFcZ6AXYXGFARH3BGfqrR/Sksekv29xBHNSnBc6Ks4QmBmuDFuvPf+VmNXdffagDUBTWA2H3nRM2kTXi2GeLpmNdM0OYmQGD8om0+rKRAKDWS6SGvri7RFXjt9qzgoMMWfP9/BRNqzUfwtrUeuRe3o9fw91kDeMxoEwxP/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eN1bBPag; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758541155;
	bh=nMADfA3UKEbyqlZhjNt1e9kpbSLVmyXTD2ba8CiFz+0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eN1bBPagXpQJ6g9esQ4O/9Nr7/+Qeen6NJgveEIE0Nuuzj8xOa3mEPJKWOfaKBFch
	 2rB79slebeyZ+hbew8oKUfRJarLWRJ5MGg7WIDr3V9+X7YAhLWyBUHZPJndBqgRedj
	 aJ7jn7JpFUW0TMkyFTl+rT5AwrbhPaf4HNANjRym0J50NOsnFFEwEGy5s5gn6KmzrR
	 2uk6Bi8k+WbTDRL0jIl8zRjs92NAMsWH1d+8+mQzlGqjwwC2BJ9PLc6W03nOspyxKK
	 NLFB7xYaeDEOEPpnfee15g1jLRMl2Rbu3t3pkk1ZZrndGVEnClxIfNsW+6KuOaumJL
	 dHN33TNpEtw2w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E3FA17E0B85;
	Mon, 22 Sep 2025 13:39:14 +0200 (CEST)
Message-ID: <19132a59-993e-4148-b883-1bc892183f33@collabora.com>
Date: Mon, 22 Sep 2025 13:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: airoha: Add AN7583
 compatible
To: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250920091230.17702-1-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250920091230.17702-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/25 11:12, Christian Marangi ha scritto:
> Add Airoha AN7583 compatible to the list of enum for Airoha Supported
> SoCs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
> index 7c38c08dbf3f..6506c64af4f3 100644
> --- a/Documentation/devicetree/bindings/arm/airoha.yaml
> +++ b/Documentation/devicetree/bindings/arm/airoha.yaml
> @@ -26,6 +26,10 @@ properties:

"an" comes before "en". Please keep alphabetical order.

Cheers,
Angelo



