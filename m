Return-Path: <linux-kernel+bounces-737683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10AB0AF51
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A3C1686B3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A0236424;
	Sat, 19 Jul 2025 10:23:13 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB44219E93;
	Sat, 19 Jul 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752920593; cv=none; b=fAh55pnzGAH16WQx04qCJNZ/b0KcYxTkM/QWwCy2d/wiMienhOuRvp4DwRwItNNDaALqUOo3UIl4/QnTqh+50+evyfwk8pJsjqQILAVk23QQeUo3dW/XEB3JNlL6iRuil2+zs06ZSxg8GWDtZ3WtaMe7dECVL7cPuimEcYNJYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752920593; c=relaxed/simple;
	bh=r0Q7XC4Y+Q57UUFqNz1ik0OjM8d/D/mHipbuFgx9z70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlOPvoLRej/Ns4PGNmIaQVMNv6PbEMwWcgJz1wJ1ZwXoWM2hALJc/9czifgBzbVO9hA6pkR2ECnynrxONbZK3ovxozqI2zUB8wwFe4d07maxMCheTYN2Np57nioXumBcHCMkasbgs0gx9JqxGsW1F273buzYkOayqNnsVyyoGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1AD37340E1F;
	Sat, 19 Jul 2025 10:23:10 +0000 (UTC)
Date: Sat, 19 Jul 2025 18:23:06 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: spacemit: uart: set dummy clock to silent dt
 warning
Message-ID: <20250719102306-GYA705838@gentoo>
References: <20250718-02-k1-uart-clock-v1-1-698e884aa717@gentoo.org>
 <22fd8b89-b937-48db-a5bf-4e468441b206@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fd8b89-b937-48db-a5bf-4e468441b206@iscas.ac.cn>

hi Vivian,

On 15:48 Sat 19 Jul     , Vivian Wang wrote:
> On 7/18/25 23:13, Yixun Lan wrote:
> > sec_uart1 is reserved in DT, and no clock is implemented in the CCF
> > framework, thus 'make dtbs_check' will eject this warning message:
> >   serial@f0612000: 'clock-names' is a required property
> >
> > So, adding a dummy clock to the device tree to fulfill the clock
> > requirement, then silent this dt check warning.
> 
> NAK. This is definitely worse than the warning.
> 
> Honestly, if you don't like this warning, I think we should just drop
> the node. If not...
> 
right, I realised this wasn't a good approach..

I will try in next version to comment out the sec_uart1 node,
unless people have better suggestion..

-- 
Yixun Lan (dlan)

