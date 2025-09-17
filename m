Return-Path: <linux-kernel+bounces-820656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91FB7D59D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8541B23FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584F337EA2;
	Wed, 17 Sep 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FzTfMB18"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A37337E92;
	Wed, 17 Sep 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111779; cv=none; b=Wypaa2wFnvcdJXh/qSDBaBXQJhYo4cmqtLDAIv3wo0E+rmvtjLlSGUpK6FaoqS0DljLZMejhjbqJ+Ud3eJjQpWjs6rsIe9nAQA4R3qEE6MFwqGHqbxD7IWGkAj+P8NTfcNGQKydDiG7Xl/ebpcjfolMrPGdb2XamUf6UU6h8UkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111779; c=relaxed/simple;
	bh=tIyNIr2U33ejQLdh2WCxkNDDVGCp7RUvUVzw27lmM0U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CIjgOB/HFBpP8lh0LDp0BBQaD49Y/0d/E/JjacVAa+fC/ST5pJU/xIHCqzEcV7vBWfWxB95o0vjZSSvFbgf4T68YJtbU3vomWBxfHERs3hRwZF7jtVcZYDQfrpH4y2nEswd2yPFaNoDWyImw/MPB6t0FNfF0R47MOrILm+D96IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FzTfMB18; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1758111775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/YUiKdTCNoLY1GEz8aALnf4XAGh1lYAmaGmZs7m/9A=;
	b=FzTfMB18+cpLicwCu+AVJNnZiJZfNKz2M2wHjk0wSNA8lAcT/2dnutF/5zvQ4J+OZFYGRb
	liWN2/69B5++gcN5E9nuSeW2MgHullwTxyCBNwv21OnLtPPriPbYI046Sww50yAMXyU+Wh
	dya8dQ0wjzznMvsEmsEA7Q1Qhu/IlBfaxsd0u4T7dK4hkZC2/gw08RZHC3CXITXyEscwta
	Wjwx+fFUs02paN+jsv+hCZ6hg81gifSw+p5S0da3Vakg4vY3yrpmS7jhbqZTDHwPWuWfGg
	iGIybL4VqvCD1O2Uwt+wNtVcRXoJTubiQY49/rW33IbacCna5IiY4CQQScHn2g==
Date: Wed, 17 Sep 2025 14:22:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rockchip: dts: Enable UART DMA by adding default
 dma-names property
In-Reply-To: <20250917114932.25994-3-lists@wildgooses.com>
References: <20250917114932.25994-1-lists@wildgooses.com>
 <20250917114932.25994-3-lists@wildgooses.com>
Message-ID: <7c8576e3d9fc73ba45830833f5281706@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ed,

On 2025-09-17 13:49, Ed Wildgoose wrote:
> Kernel appears to need a dma-names set for DMA to actually enable. Set 
> a
> default dma-names property for all UARTs defined in the base 
> rk356x-base
> dtsi
> 
> This is tested on a Radxa Zero 3W (which has 5x UARTs) and removes the
> warnings and enables DMA on this platform

Thanks for the patches.

We should (still) stay away from defining the "dma-names" property
at the SoC level, because doing that causes serious issues in certain
cases.  Thus, I'd suggest that this patch is dropped, and that the
"dma-names" property is defined instead at the board level, where
it's needed and tested to work as expected.

Please see commit bf6f26deb0e8 (arm64: dts: rockchip: Add dma-names
to uart1 on quartz64-b, 2024-06-28) for further explanation.

If/when the underlying issues are debugged and resolved, we can get
back to defining the "dma-names" property at the SoC level.

