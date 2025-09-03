Return-Path: <linux-kernel+bounces-797512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1320CB4116A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03F61A81FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946091BD9D0;
	Wed,  3 Sep 2025 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eT+h1A1D"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397115C0;
	Wed,  3 Sep 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860152; cv=none; b=tf4/YC0C+iK7sxGgwfx50ErwlxX+EztRendbrWSYxeoc8sFQT+EvqT9Ptw6e79IcvtwjD+P1Pw6VfKpmgfKbTd7FhPFeP3Jtd6wfIP1cqRyKmWFUCxj4neb/1D1q6VZypkHWB1bFHc0r9Rx+n9ODRAhnRGKvxF7S5QcFywSoLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860152; c=relaxed/simple;
	bh=FD3rVftaBGV2mQ+n+/bkbUpgs1u88xX5yE3RgbMNAtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjdEMQkgZQ8n/+LA+VJocUuHy4k9+ibSTZ1r/kNGviHTRDzp4WPN48xfMqd+j5ftnDaUA0WYuZPFw3UhH8ZOUIBeftZUroPk0WmpFcXBLtlAEtaDBp+HPWaKZzAs4tRGrRCtftSgm4EZivW7Z8gdWMDJHcrnuWAr2VXoHLnH7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eT+h1A1D; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B093725DB0;
	Wed,  3 Sep 2025 02:42:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHYT6eTry66f; Wed,  3 Sep 2025 02:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756860139; bh=FD3rVftaBGV2mQ+n+/bkbUpgs1u88xX5yE3RgbMNAtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eT+h1A1DHmwt2J7b+cv2FaP5H+FE9UbE0BAKODxKF+YU8YtK+BNqz3bLbfFZcAJ3t
	 XH92wBTThN35ERFKFS7NcCGzVbvBr+HX9DyQuOyu9fw7ZqZabkXwmDnevU5W/znfig
	 vohxwjPgdmaPkeK3kRO++iNCBHMsI8lYAtNzi6/q7Pa34MD1p50MQnSnw5phz56XYq
	 io2EJXu2vJMIQmO163jRG6l/bts3K5rPwblQEErpULIK75dEhEd1fWo1JkZSn2r59S
	 1BH3x/Ng9hbDY1wkevrIhSV27kV1rjzK160Bdkk+dZ1/wenjXbcPdTKnncYgK+1N4g
	 Bwk2sW3ABM3Qg==
Date: Wed, 3 Sep 2025 00:41:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 1/4] dt-bindings: reset: thead,th1520-reset: Add
 controllers for more subsys
Message-ID: <aLeO1T1YM8_UorEr@pie>
References: <20250901042320.22865-1-ziyao@disroot.org>
 <20250901042320.22865-2-ziyao@disroot.org>
 <8de5763d7104a552f32196f04363d071548b7bba.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de5763d7104a552f32196f04363d071548b7bba.camel@pengutronix.de>

On Tue, Sep 02, 2025 at 03:57:07PM +0200, Philipp Zabel wrote:
> On Mo, 2025-09-01 at 04:23 +0000, Yao Zi wrote:
> > TH1520 SoC is divided into several subsystems, most of them have
> > distinct reset controllers. Let's document reset controllers other than
> > the one for VO subsystem and IDs for their reset signals.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
> >  .../dt-bindings/reset/thead,th1520-reset.h    | 219 +++++++++++++++++-
> >  2 files changed, 223 insertions(+), 4 deletions(-)
> > 
> [...]
> > diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
> > index ee799286c175..927e251edfab 100644
> > --- a/include/dt-bindings/reset/thead,th1520-reset.h
> > +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> > @@ -7,11 +7,186 @@
> [...]
> > +/* AP Subsystem */
> [...]
> > +#define TH1520_RESET_ID_C910_C0			5
> > +#define TH1520_RESET_ID_C910_C1			5
> > +#define TH1520_RESET_ID_C910_C2			5
> > +#define TH1520_RESET_ID_C910_C3			5
> 
> As the kernel test robot already noticed, this doesn't seem right.

Yes, this is a copy-paste error. I'll fix it and run static check before
sending v2. Thanks.

> regards
> Philipp

Best regards,
Yao Zi

