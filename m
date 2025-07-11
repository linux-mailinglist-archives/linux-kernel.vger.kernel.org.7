Return-Path: <linux-kernel+bounces-727215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54BB01698
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000705642B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AE1E51FA;
	Fri, 11 Jul 2025 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="F+qwGLrz"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34341760;
	Fri, 11 Jul 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223178; cv=none; b=Y2WniVR1VlijfFe7bCYiQi9uHA4/KpoRKBLSwZpmU022mwWD+XwW4SsKhbCFYJlB53tnAA25VjVgA5Um9clXVQf9TcP5GIDpGUZciUPsiAX9kr1tgYXZMGO1QqFRkG6fqmRH2giXqBQmtKvfVZ8YkIepoPclNQWGIFDc9zSwwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223178; c=relaxed/simple;
	bh=1/racivFa0yaGw0X+WiRRpIkHtBesUL79mk3V6GFo74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq4EvwZ4cRVsY271HE/74lukruy9EDw55hDNHnCAOW6ohtVL7nkTYwGDS3Qf6tkdTXW/imclH/PZ2dskzM5KhDkz69JdINigt45vR0bgEZqGULD0QbhwLzAcxB8eEJOjm8TzngA0imjAlr8h2ZsBue3eRcakrT3VZwx4Xx/aA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=F+qwGLrz; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=4hDZoIQxIbXd6WlsC6cZSw5cAAfuW34VyJGhlqXRNQ0=;
	b=F+qwGLrzwZTC82LcvCyG0NANA+ERaJScJnpa+YsMeIBjfY2n41gctWFOs3G8cs
	5L8mevoj/qjd9RTy76xKi01G51cIXI90xFWkb3YYkiYIux57TzsrZZeb45IuofV5
	s+EL6n7Drr0R2UVjA+Ii2L0KEHFAROUoRNGJFyFSTPcP8=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnf52azXBo7nFSAA--.5528S3;
	Fri, 11 Jul 2025 16:38:52 +0800 (CST)
Date: Fri, 11 Jul 2025 16:38:49 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <aHDNmVE23O4V4rqJ@dragon>
References: <20250610160152.1113930-1-laurentiumihalcea111@gmail.com>
 <20250610160152.1113930-5-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610160152.1113930-5-laurentiumihalcea111@gmail.com>
X-CM-TRANSID:M88vCgDnf52azXBo7nFSAA--.5528S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWfur48WF43Gr4fZr1rtFb_yoWkurXE9F
	y8JryDCw15Aws7Kws3ZF1rX348Ka18CF1aqryftrnxX34Sq347J3ZxAr48uF45WF4293sI
	vasxtF4aqw1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQeOJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhzQNmhwzZyCeAAA3r

On Tue, Jun 10, 2025 at 12:01:50PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> AIPS5 is actually AIPSTZ5 as it offers some security-related
> configurations. Since these configurations need to be applied before
> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
> be their parent instead of keeping AIPS5 and adding a child node for
> AIPSTZ5. Also, because of the security configurations, the address space
> of the bus has to be changed to that of the configuration registers.
> 
> Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
> missing 'power-domains' property. The domain needs to be powered on before
> attempting to configure the security-related registers.
> 
> The DT node name is not changed to avoid potential issues with DTs in
> which this node is referenced.
> 
> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Patch 4 ~ 6 dropped from my tree due to the regression.

Shawn


