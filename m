Return-Path: <linux-kernel+bounces-736675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9BBB0A057
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A26F5A1FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071229CB42;
	Fri, 18 Jul 2025 10:07:41 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CED29B76B;
	Fri, 18 Jul 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833260; cv=none; b=DHN7BnmH6OUUEH7m0WaIcsCIhW9OigAdpfrXZqZELjAGI1n7Edm008nnkowE0POGIX9sMGHJt81nR14B910qRSCmOBa2dU76YGeG0Qc8e11VXkBIeC0wgOA6kADVTUlyj3JYJorSUw6+z2YG1Rv78Pg/BuyXvY+eN8OnPbgReEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833260; c=relaxed/simple;
	bh=keXTVKHuCD0L5Qb/JscNYjXIELHz1c4oi3RqVYlTU6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrZgqYuwJdErMkg4NbiDyGkpTayOF1N+6pv3TcEshdo5fiAG21BQVi2/YiRc2CIsbhbqzhBkvBTL4jAJs0opFCoTOrKZtndN5P/57uwZZc6KPPoj38T/nfTP/aYmGw9l+COy1bSZMbofjMINZfOWLkxz1WpkpJm+LQZ0adAZRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3380A340F28;
	Fri, 18 Jul 2025 10:07:37 +0000 (UTC)
Date: Fri, 18 Jul 2025 18:07:32 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, palmer@dabbelt.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add OrangePi RV2 board
 device tree
Message-ID: <20250718100732-GYA700698@gentoo>
References: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
 <20250718084339.471449-3-hendrik.hamerlinck@hammernet.be>
 <8ade99a6-84a0-4e69-8ebf-d9dfdc9141b5@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ade99a6-84a0-4e69-8ebf-d9dfdc9141b5@iscas.ac.cn>

Hi Vivian,

On 17:10 Fri 18 Jul     , Vivian Wang wrote:
> Hi Hendrik,
> 
> On 7/18/25 16:43, Hendrik Hamerlinck wrote:
> > Add initial device tree support for the OrangePi RV2 board [1], which is
> > marketed as using the Ky X1 SoC but has been confirmed to be 
> > identical to the SpacemiT K1 [2].
> >
> > The device tree is adapted from the OrangePi vendor tree [3], and similar
> > integration can be found in the Banana Pi kernel tree [4], confirming SoC
> > compatibility.
> 
> This isn't particularly crucial, but I wonder if we can do something
> similar to a jh7110-common.dtsi arrangement, where most of the boards
> sharing similar designs can also share devicetree source files.
> 
> Easier said than done, probably, but I think it should be possible by
> just comparing the vendor dts files.
> 
> Again this doesn't need to block this patch.
> 
Sure

> Yixun: I'm assuming you'll be handling this. What do you think about a
> k1-common.dtsi?
> 

Sharing dtsi file for similar boards is generally fine, I saw a few
other SoC maintainers have done the same..

In the practical cases, we have to evaluate and plan carefully, it
should be manageable to support fixed number of boards for one file,
but would be nasty if expect one common dts file to cover all boards..

Anyhow, I think we can revisit this idea and having incremental patch
later, it's not the problem for now

Thanks for the suggestion

-- 
Yixun Lan (dlan)

