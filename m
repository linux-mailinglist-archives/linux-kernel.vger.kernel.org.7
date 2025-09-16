Return-Path: <linux-kernel+bounces-818409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C41B59163
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0404E2A44C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E8128AAF9;
	Tue, 16 Sep 2025 08:57:32 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABC283FD8;
	Tue, 16 Sep 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013052; cv=none; b=Iv0Y/EkvbWqCFsoVzbeo/5PBFIH729wp5R2GDOKJTXpROGwo1feqQY168GMACtvVVm4Kmt7s/rXyz5414rEPrCXKe1+ihM/wUmOco/oEYs1OJMFmqiX3DSHnHLvEzDXRDWVSqZYsP06gdu8t9hvU19qOaYnzfm4fayJsYVpA9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013052; c=relaxed/simple;
	bh=af7rjeVyq1V01VmfV+h18NMd8JU8MkjjJFZfdDYHg2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdSi+ylJ957aPkBbyoFoOGyJ1XTRf3mknLIUqzLC06T6mcHbHNMFOCIl/V8cBv1jTu11BXjLFGDlsL9c5EXIbqarQzAWmw67gPUT6HuImMnanNvf9Fo6HBg8Bq/yPr6Sh4+tW3pV/LvObhe0NYNf26Dll3cqgheyo2e/c/Lj9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D2D98340EAF;
	Tue, 16 Sep 2025 08:57:29 +0000 (UTC)
Date: Tue, 16 Sep 2025 16:57:25 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <20250916085725-GYA1255161@gentoo.org>
References: <20250916064739.196695-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916064739.196695-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik,

On 08:47 Tue 16 Sep     , Hendrik Hamerlinck wrote:
> Add UART pinctrl configurations based on the SoC datasheet and the
> downstream Bianbu Linux tree. The drive strength values were taken from
> the downstream implementation, which uses medium drive strength.
> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> hardware flow control conditionally.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
> Changes in v3:
> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
> 
> Changes in v2:
> - Split cts/rts into separate pinctrl configs as suggested
> - Removed options from board DTS files to keep them cleaner
> ---

-- 
Yixun Lan (dlan)

