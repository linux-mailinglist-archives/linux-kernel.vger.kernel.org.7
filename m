Return-Path: <linux-kernel+bounces-820534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E5B7D828
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F7E2A4740
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4F2EC54D;
	Wed, 17 Sep 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGJt740u"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA52EA740
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107357; cv=none; b=fi5uazf4cq4cI6v86OTCVk4FQ8uB/asE+laTV7+vNnTibnE0aqr2y1xUBAQATEQsfPbF+/hy40SxNfLTvaDbwJxRUfo3A+IYH/nIkOrtPOGWylAbiKOb4YCfIZWHwFppU2zxNJpNoshYqhNF06B0mITnJHlbwCyu2OhaW5vPwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107357; c=relaxed/simple;
	bh=vCQ82qV94yiNku9nli/U7SHV6Xn5r9YiEW4JVuIgcls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwRXqEr98S7e/DNgWvLWzBVflyouhDSkqaTISwGF+shm2n4GWr/JztXdgoNuC53D7YUXywTPvhEf0VCXdMlmGxqv2dFoHNYrvRPVBr8U0ivIys898qmfMuIRd6QT+ld53WRymuMkgGbM32gMvVw1MpYP94FHq5A1H4ubrJIRyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGJt740u; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0892d313-c483-44e8-98d4-6a4cab788e29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758107341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+RKa+uqGSHSACfTcMdSr144l4JX7Dk0z0dr1U28JGU=;
	b=iGJt740u+j96DRk93gu+geDuO4RJOuxcqEU5ghVWcK+T4YN52cIf867k0kLZ3gzllNTjFC
	zCt+d3KWOnmrwUnkEZpqylijU6fxqmrJNQQZnFEUzPArtWwB1luIMaCrZ7UHml3jOOfFqu
	pptOWqU4/BLtzA3JW43UhNHVv15A3pI=
Date: Wed, 17 Sep 2025 12:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ti: am65-cpsw: Update hw timestamping filter for
 PTPv1 RX packets
To: vishnu singh <v-singh1@ti.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, rogerq@kernel.org,
 horms@kernel.org, mwalle@kernel.org, alexander.sverdlin@gmail.com,
 npitre@baylibre.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: c-vankar@ti.com
References: <20250917041455.1815579-1-v-singh1@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250917041455.1815579-1-v-singh1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/09/2025 05:14, vishnu singh wrote:
> From: Vishnu Singh <v-singh1@ti.com>
> 
> CPTS module of CPSW supports hardware timestamping of PTPv1 packets.Update
> the "hwtstamp_rx_filters" of CPSW driver to enable timestamping of received
> PTPv1 packets. Also update the advertised capability to include PTPv1.
> 
> Signed-off-by: Vishnu Singh <v-singh1@ti.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

