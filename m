Return-Path: <linux-kernel+bounces-599973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA6A85A56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA6D189DD20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563D221271;
	Fri, 11 Apr 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="5xdjPp33"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C5143748
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368207; cv=none; b=Jxda3+vSQ6bOr91jdT7pWlJyAuySn5lGjLr6VH1uwYgG/oSj867yIK5fBZnjgq/vLzbpJdDSCpFAFG1SDNFx9md8m71Abi2KvCYWlVMJSglWFqKGeTY5OkWaZM62r3P5ehuYxRkm4tMU/ooFMqNI5a5L7udEqfamw5ACyO/gfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368207; c=relaxed/simple;
	bh=YqwfqaCJBoFKbX+KBgP8jOEVSEqmcgGQRnYVE1vGI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm1XQysxqJfdKKIy0rl8Uht/OCWWPOKO3A12xcVpgcmnDhBYlPASOMY1z645E9owBQnLE/A/uuFboZhqdH+8WCyAfjePPWM3xrH0IM0iXecdDLzoKkt4TY9QCCwfAB7oPrnjyhvRekEHM6PtODMI+zsWMO2WAe93IyqNf2/TvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=5xdjPp33; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A2C6B47EA4;
	Fri, 11 Apr 2025 12:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744368204;
	bh=YqwfqaCJBoFKbX+KBgP8jOEVSEqmcgGQRnYVE1vGI+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5xdjPp332/yyJLskJcmAnMloJwa8q21xHc/l0D/UAC0J7t1TSsDXKlJ64vF3SlENw
	 B+TFghWxGkS54FF3Y3+Rk6pWrV0SCn4NrKhVz0rUTEcT7ktQLeU62T6kmz4a1T3eNn
	 GUH1n/M++4sFOkkxVu23SUwpKL+gi6TmoTlNgWpXFJp6tfPA54IVgHF64ObeVlwjC3
	 PuR5/RGBb4/+iH2chbRnjFBH0zt1IpChJ9XJEuqJ4doADqvdiCucRJ02/8V/tsNDsK
	 YBQKCD4SaolgMJwV3Lw+juMxyGyfE1YZbHr2vNh5ZkT7f3QWfhBApLViTGrbI/71h4
	 LlU9ajvKq0QzQ==
Date: Fri, 11 Apr 2025 12:43:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: xiaopeitux@foxmail.com
Cc: robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] iommu: remove unneeded semicolon
Message-ID: <Z_jyS5YZsvAKnZ7I@8bytes.org>
References: <tencent_73EEE47E6ECCF538229C9B9E6A0272DA2B05@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_73EEE47E6ECCF538229C9B9E6A0272DA2B05@qq.com>

On Mon, Apr 07, 2025 at 09:53:28AM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> cocci warnings:
> 	drivers/iommu/dma-iommu.c:1788:2-3: Unneeded semicolon
> 
> so remove unneeded semicolon to fix cocci warnings.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/iommu/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.


