Return-Path: <linux-kernel+bounces-781561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC1B313CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97CF4E619D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C92F618E;
	Fri, 22 Aug 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UhkiRzGN"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12A2EFDB8;
	Fri, 22 Aug 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855575; cv=none; b=kprVBXFRTakoovmvSnvmY7EgG7TuHcbfk+xEkA9GKfVSc29N1nEmgW4r4EcMlTW296bbjmBhUglHyfNqARlETi/u4Eu+3uXaK6Bj5ndK6ktVmAQDxO0p5AV7qCKc/v7uRIERRKZr1pJX/FSrA9z2pGKiFYlZLexslMbBu5UZSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855575; c=relaxed/simple;
	bh=escQ0eYemKQ36vqXovrhDFWhLwxwMiVnwgqPn+khWlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBEXbZgpRzjh7OclLQHKjloBSsb//mlykOQVbKhznDJlXE3NJTyT28Pj7n+GeMNWWMXvkqnoICqZETbJMLnXc2v0BsA+vheONvurNN1g0hiPl+GSyr0yjD63JUjRhBbGcEl6yPI6IrXXskjNHDFxdzKdaWEv5TdzaUIodI2FMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UhkiRzGN; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=l0H7eWI6XbSubtchLLYle5o/qTdCGwy3vl8S3tVMSUQ=;
	b=UhkiRzGNmJIrB+P3HlxAvrgqc0kGw8nszom35do73cxuOA1dcPOL/afy2fJC10
	sis+r5O1wIRuwhAp0Kd0jKPmU8Q7xdObn8FlI9+RgDO/OB1aQXXpfRiPAg1d6w+f
	a374bxAQpt78c4ccAH6kkdf/4s6gSkSwtdFEgXQFk2a9k=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3tG6lOqhoRwwWAw--.12680S3;
	Fri, 22 Aug 2025 17:38:47 +0800 (CST)
Date: Fri, 22 Aug 2025 17:38:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/4] ARM: dts: vfxxx: rename nodename iomux to pinctrl
Message-ID: <aKg6pYNjxZvjkJq6@dragon>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
 <20250819-vfxxx_warning-v1-1-080930d8e1ea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-vfxxx_warning-v1-1-080930d8e1ea@nxp.com>
X-CM-TRANSID:M88vCgD3tG6lOqhoRwwWAw--.12680S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzOzVUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNAn8YmioOqkPXAAA3j

On Tue, Aug 19, 2025 at 03:44:06PM -0400, Frank Li wrote:
> Rename nodename iomux to pinctrl to fix below warnings:
>   arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dtb: iomuxc@40048000 (fsl,vf610-iomuxc): $nodename:0: 'iomuxc@40048000' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> 	from schema $id: http://devicetree.org/schemas/pinctrl/fsl,vf610-iomuxc.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Fabio beat you to this one ;)

Shawn


