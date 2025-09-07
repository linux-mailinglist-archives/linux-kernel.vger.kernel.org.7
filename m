Return-Path: <linux-kernel+bounces-804524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770DB478C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 05:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174453C6FCD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A571D5CD7;
	Sun,  7 Sep 2025 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jrWfrwVv"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58F35950;
	Sun,  7 Sep 2025 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757215062; cv=none; b=NmrfWGf+Fa202kIjXeqbSMRv2mzbdc1XnyXDy3Sh5EPBHGqCVXGps4iaFfLFp52VrzXO0l98NSp71D01ecPZte5UkNYhe5M7bzos/dxPOC1ngjAahIL0WpNW92uBnJMGWOxJ5+JbRYh/GFbPSRPQF7IzcHZ2T19mySe/txWTdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757215062; c=relaxed/simple;
	bh=LhDHTlcfR1jGlZto3p6JzzhQfbrunIuTuGNvuvqpJWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTpFUji+qbHe+WxbTpreuHRFdmi0V6BeNVsGm+oNb8Thxtdw7NFCp2QPDk6yeom+OxpJzgGHfniGJvOwVekknmI+ge/8TgKiCjF1JJXKyKgWu8UIGD8gRFbILjwDyEZrfb6QCBLhIvmLjO5oigQx6DortiBH0r/dWlgz2bYEToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jrWfrwVv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7772D20E83;
	Sun,  7 Sep 2025 05:17:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8t3ZYEGffzYV; Sun,  7 Sep 2025 05:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757215057; bh=LhDHTlcfR1jGlZto3p6JzzhQfbrunIuTuGNvuvqpJWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jrWfrwVvsp5VR5ASaKQCO0jC+3CL6AoWx6zFsTPONS1ul+pILsdE6xQfe5oHrOgbg
	 yNKw6gCy8+kBwGl9bVE+U6elHWFtNqJzjhtOrYeePFNhEK+oP2k8PgiY6ypUxAWnqL
	 Eqbr7JmA89v3x1q0pS3inbCvfvHYKpA/jXN3nRRn7Ckmc9upfw+O5STwWo2sbLB1Ym
	 FZ6IdAQZcCQHM/yYjLWtI12ugh2CJoLdVDsnHfXOhgVK+Vg5pVwdt9GYe3v/SiWyRw
	 pZWZh2C+CuNlqz8Xbs4ZntgGi5S0EtHpuQsPrnrrIlA6flrLkblWWq+hfl3rlZxhT8
	 WSKXzQqrsmMDQ==
Date: Sun, 7 Sep 2025 03:17:26 +0000
From: Yao Zi <ziyao@disroot.org>
To: Xukai Wang <kingxukai@zohomail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Troy Mitchell <TroyMitchell988@gmail.com>
Subject: Re: [PATCH v8 2/3] clk: canaan: Add clock driver for Canaan K230
Message-ID: <aLz5RsjBoi0KVGSJ@pie>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
 <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com>
 <aLz4Q7LZFEfQQGUj@pie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLz4Q7LZFEfQQGUj@pie>

On Sun, Sep 07, 2025 at 03:13:07AM +0000, Yao Zi wrote:
> > +struct k230_clk_rate_self {
> > +	struct clk_hw	hw;
> > +	void __iomem	*reg;
> > +	bool		read_only;
> 
> Isn't a read-only multiplier, divider or something capable of both a
> simple fixed-factor hardware? If so please switch to the existing clock
> hardware, instead of introducing a field in description of rate clocks.
> 
> It's worth noting that you've already had at least one fixed-rate clock
> (shrm_sram_div2).

It should be "fixed-factor" clock instead of "fixed-rate" clock, sorry
for the typo.

Regards,
Yao Zi

