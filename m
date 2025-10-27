Return-Path: <linux-kernel+bounces-870752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75690C0B980
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F7604EC2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA526FA5B;
	Mon, 27 Oct 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Zn2iSZVO"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63122129B;
	Mon, 27 Oct 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761528185; cv=none; b=NhZ7I2FnOPnmeOoTaTvsBLGKXcKs/6NUKExN2Vvrd0vHAITRLu4ZHSYLMtlMTrBOTw78FmOLoX8p7yjZmXEAYGylSB+mO+oz7xyYzZmli7oq0mZjXgpe5Akb/fso9lud89ZMwMu2p8gVHOA61/NpowcCUp6T7WSqjQY3ABy3CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761528185; c=relaxed/simple;
	bh=2NVjVK98UhB3Y21CFxnmh/3oR38w9ufdRbfalTn5BRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQItbB250PRXqsiaX0MNNddpgnF/ykeRv6NVyXeX2kcg9Genku25rnfOeUokXU+DxtS0IvuSSk+k0u3c/PFUG+EyEz33ulQW+I8FYsRfrUHriq2Up8Z04zfYagZXlga5q4m8rJFaU0q/37O5GmBs3vQ96i4zsoZiaZPbvQtED7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Zn2iSZVO; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761528144;
	bh=YFqnaQXbGn6xdpcNOP814zAlTHleVU+KgUL5SVGaMpQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Zn2iSZVOMGKCMCIrlqbX47mDEBSdSWKQDLrpXpijLy8IV/gXgDFHrTgCadW6m42gU
	 /Joi1frrfTu5Bi2dEMGPf/gULXGb8PTRgJFsoYuXRgIo1iG3mk6Z07ql+EMzhzse0I
	 PueuHILhxM13QOUR68VCJNqeFxXvjhudFK4AqlKQ=
X-QQ-mid: zesmtpsz5t1761528136ta7becb60
X-QQ-Originating-IP: Qzn6Gh3dF5mQyqK/6O3ihXXcFnqBQdYjHjd+FkTWnwk=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 09:22:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13636534776712087437
EX-QQ-RecipientCnt: 17
Date: Mon, 27 Oct 2025 09:22:14 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/6] clk/reset: anlogic: add support for DR1V90 SoC
Message-ID: <0E60AA15166FED21+aP7JRmPzDIq2WhWw@kernel.org>
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N+/GyfuFbcLi0yesWPY/w8SSsQTT4ZUmo8kWT9abRFNYSwRm+J+l2MRV
	q+AxTMB0a/xvOWKW49aFyy2U7RcHsbJEjeDkYCAyKwneTlcOOF4muRpVuIiijuiGLnPw5KR
	uX5Fp0CaX/l2cowEzpze9nPRco8R6i3j5+/Zd8xhkz3/ZPNHhIUVj6WKbyJRW5DJR4gVJrD
	zqoR88dc1kLKULG6mp9R/qcQ8spmmipOoJLZCuB0+cow/NsfHXUxeMyJPB3AxDvi2jNs0px
	npY+ORtW39JJsMkJrnbpPu9vpNAAQnw3twPHCTH9Kn4f6OTC6t6m7jnAXyqoLezMUbgwIeZ
	O48sbZKK04wsBJdLLJk3FXh+bPhyN4jfdKgptrhHWODTu0kdSPPjlCyFQo1mkDdvhqoU2fv
	/yslAgxrZtsLA5VXLzqmXyyW9MlCW+w4M+bb4+fpgKNVd7roN4PRkyrT9tX2a5ehYmAkZkW
	WlsMW6rLUeDr17+lqf2ZFE1y3e/EFmc/d11YujXkX1WAnpV8uBFG3KhxOWHcHfkEyVmifGi
	wJa+2hpiCbQXPzqWDdAluilnmR+pQFJ3BmBJA3F1X9TTXkKfhdRxbFQmKh4Z71GHv3fdSGh
	GCzfZDCVHkWb7nbOxq03QIKkQoEw0aCpKKo/MJWZ/AQ7WzpIBCrcvfJvl1E60/cWmbqcXkh
	TDcLoLjOmnKZMWP5O29aoNhszk/2CdzWB9l1cObGr/WsCJPGVdqHWC4bmmN+amocB1VMwNW
	8gDzE+6UQI2bTRcVQTLbgEZTsLUnzIFNsx+ffA/jghL/5E/P4q36MASazckLFCh+JMsE2MO
	YGOaMTE/ncKRadQJArj2FvqK46nG6P9G7559kQD6ZcUfZwpN8b2kr3GE6X0Xv/dsj0eftYh
	UDrSGkIgKV+hOPf/jabZVs2eNU++US9clQ725Hgr5BCy1W2bzEBFhGkOsV/XUbKElC35D0F
	CqLEdSa3WXWMkXWedbY0US0LjpCB5M/z6XWKYBC+G6z/ebIHGXzr+0x+NQ4foIzyb+tvx1E
	dEUikEzlomI9hG3oKUD6FAAR/54BGkd16lDew9nB1VEDFKGoXvEgROHarYn+w=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Sun, Oct 26, 2025 at 10:00:40PM +0800, Junhui Liu wrote:
> This adds Clock and Reset Unit (CRU) support for the Anlogic DR1V90 SoC,
> as well as corresponding dts bindings and dts integration.
> 
> The CRU driver framework is built around the clock controller as the
> primary device, with the reset controller implemented as an auxiliary
> device. The clock part refers to the vendor's code [1] to determine the
> structure of the clock tree.
> 
> The Anlogic DR1 series includes not only the DR1V90 (based on the Nuclei
> UX900 RISC-V core), but also the DR1M90 (based on the Cortex-A35 ARM64
> core). Most of the clock tree and CRU design can be shared between them.
> This series only adds CRU support for DR1V90. Nevertheless, the driver
> is structured to make future extension to other DR1 variants like
> DR1M90.
> 
> This depends on the basic dt series for DR1V90 SoC [2].
> 
> Link: https://gitee.com/anlogic/linux/blob/anlogic-6.1.54/drivers/clk/anlogic/anl_dr1x90_crp.c [1]
> Link: https://lore.kernel.org/all/20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech/ [2]
> ---
Do we really need a cover-letter? Since you only have one patch, Is it
better to put the above information below the --- line in the actual patch?

                                      - Troy

