Return-Path: <linux-kernel+bounces-727163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C462B015DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56220765620
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026E204C0F;
	Fri, 11 Jul 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="kcMqUPmh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D191FECB4;
	Fri, 11 Jul 2025 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222282; cv=none; b=AN8U7bNzIpvV6vNmUdfLvmPpSkz1iji+6FdQOo3w/LaUlPi5Q8VqFkfh0RcNStmpQcP7HA0rG1SPnaoen5O4oK0ohSQS96o0fgdJXCWFcmTwdZvwxO0XVxT6vtry0ADzR1toze4hwhlIBdROymD0mXnoL25Xz1ZYnZ1D4/bdDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222282; c=relaxed/simple;
	bh=oe4lhkLGr8IVFpNtn+zfgMZ6IZRAf5sC+irhj7PnqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLevWJH+btKUEYlRSNko2C/vO4ZRxq30jlap3c+HFDn+GcuocNDgBBnhtO2+7KOYely/Z3Uys/P0PGQ2UOFhNpp3uqSZpn8W6ALCT3mVomPjooMnQee1748H5NEQ2A5qLQC1Y1+U7TLDY8sJB8WQhgSBeI+8uMSXNV+v4iz68ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=kcMqUPmh; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=M8HMI4dBSHOZzYxtls69B2jOiIgFLybmVcuOyVJM9LE=;
	b=kcMqUPmh/qagFxTfJHasI3aSRZlobqClH28SagoqLkvIgkq4ih8ujofBHK1JMe
	MRsQwq7V2CuHrl7nntwpxJwZUP+u7tfgQsIOsXyAu1s51sCbYOm66k0+yP3+/tkr
	Pf+A7uK0HwDdqYKceOGcGzj8oJRuFNM638KyKV2lnpotA=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3d6YJynBoKCtSAA--.9983S3;
	Fri, 11 Jul 2025 16:23:39 +0800 (CST)
Date: Fri, 11 Jul 2025 16:23:37 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] ARM: dts: imx6-gw: Replace license text comment with
 SPDX identifier
Message-ID: <aHDKCWFd9oOZu6NC@dragon>
References: <20250709-gw-dts-lic-v2-1-ac3b697f65d5@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-gw-dts-lic-v2-1-ac3b697f65d5@prolan.hu>
X-CM-TRANSID:M88vCgD3d6YJynBoKCtSAA--.9983S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryDAF1rtF47GF45GF1rWFg_yoWxKFXE9F
	W8Ww15JrWSgFW0k3ySkF1avasrKFWDZr12qwnYqFZxJF98KrZ8WFn8Wryqvrn8Xw4xtrnr
	CF15Way7C3sxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb9NVDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRqHZWhwiwXXmQAAsp

On Wed, Jul 09, 2025 at 09:26:41AM +0200, Bence Csókás wrote:
> Replace verbatim license text with a `SPDX-License-Identifier`.
> 
> The comment header mis-attributes this license to be "X11", but the
> license text does not include the last line "Except as contained in this
> notice, the name of the X Consortium shall not be used in advertising or
> otherwise to promote the sale, use or other dealings in this Software
> without prior written authorization from the X Consortium.". Therefore,
> this license is actually equivalent to the SPDX "MIT" license (confirmed
> by text diffing).
> 
> Cc: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Applied, thanks!


