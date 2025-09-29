Return-Path: <linux-kernel+bounces-835942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C66DBA8685
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE793B533A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB35257824;
	Mon, 29 Sep 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="r2V41+vf"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DB1BD9C9;
	Mon, 29 Sep 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134784; cv=none; b=AKjwKM0hu29AfFsB1y2n0dyxvPYrjuRB6vxsDrYEXfFbLnGNqT7XSmZg7DC+zb4rMDieavf4ijKG/84BNkGHUpPDhm5a7m1IZB789PbWG6mvk4b4PCCqDDJmqKZ2Fv6+5Ni9C20qN87BcOBBq0XeHFDW8/ejsWz8U4ahF8cSaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134784; c=relaxed/simple;
	bh=nMmASFdlBzIZVDIW2qCAKOeYGx4Il0flG/JZVLk/Bwo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Hnbt8QVpE7S0pk5H08oAzhFPqkaRwo30Ma/cN8Rfa1veytIoM1ekJuDUf1H6HNHXsueS/job4jf9jxPC9HjX+2C2cAGL4R4h94AyUW7YHJG4gXPGC43BYcO/GzmqqEmpYllUuMmH9uTC7MkpJey0IRJi9N1azGmx79KHHdPjTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=r2V41+vf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1759134780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6IgvnJf+TwuohwKNDrr1f+Fnh1ZrNwh++ABQ4h5jac=;
	b=r2V41+vfGVhb91wQwN19qdC63ckj2jVdjphymcYJTu5Jx2T4hXThp+0oY3ErPz+RH7rTEt
	+93F1HDZZ9LX6LeLJMssOs2NZ5ZtHCCgMh/+vNumqvhI7E0jd6PT9/5NHEvmJ3sYOKOZid
	LXu+fHBDfCRweYj/Ne/22L20BtGfy1Jzl+gWO9zZ0wuV92UF/F53dZ0sVJoZFRfHBFhRs3
	xWos+OQPdycV/ExXd2xwUPY68QE3ImwziUwhzEDpLqz0HY3QAGJBdhGkcYj/VI8kFXrslU
	TN5iTmXXB1ipMxjVRP8czyQjyl7gaPlZ3JxxQgEDNyVFOI4v1d5hBc20sRG9FA==
Date: Mon, 29 Sep 2025 10:32:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Ondrej
 Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>, =?UTF-8?Q?Kam?=
 =?UTF-8?Q?il_Trzci=C5=84ski?= <ayufan@ayufan.eu>, "Leonardo G. Trombetta"
 <lgtrombetta@gmx.com>
Subject: Re: [PATCH v4 0/4] Upstreaming Pinephone Pro Patches
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
Message-ID: <49dafe9afc5962d8fec10e6135c9b84d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Rudraksha,

On 2025-09-29 09:35, Rudraksha Gupta via B4 Relay wrote:
>       arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor 
> support
>       arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor 
> support
>       arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
>       arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for 
> volume keys

Please note that the patch summaries/subjects are still a bit
wrong in the v4 of this series, because there should be no
"rk3399-pinephone-pro:" prefixes in them.

You can always check the commit history for the file you're
editing, to see what's the expected format of the patch summary.
It differs a bit between the subsystems and architectures, so
it should always be checked.

