Return-Path: <linux-kernel+bounces-847818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED312BCBCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756243A584C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E32262FF3;
	Fri, 10 Oct 2025 06:43:27 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E723E320;
	Fri, 10 Oct 2025 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078606; cv=none; b=H4n08nEQ4j1+aViv8MCkKtzM40FmLhSZcxmgZEpEckZzrbAI1r1XWYwBtI4PjFBL25roX5QbGpVT9894/TNGkgJykqYTjOilNReOSGC6BQrwSfXPd+zAorsKI3nfykk65UCE5qOYDFjROzpdAgZZjz2Z3velISoSXayxQ9Z9LLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078606; c=relaxed/simple;
	bh=vdhUDgaQh+xEYdkKNbOXJPeU6RVE4xKptUp/KdiymTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtsUVk+wc4kfG8VytKyp5r465qJicn46/KIuWH3NKbicC2b1v+e4C0k+/nS9hYBDzuuz8lNenYycAqs9Xf4Qyqy7/gM+V6eJmtl3HvwaMU2X4+G0tNMBYMomOnU3tPATYBQgtiIOQ8eVB/nvgDqnaHCt0KVSbyAbWoOQrDTsKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5C40C340D31;
	Fri, 10 Oct 2025 06:43:24 +0000 (UTC)
Date: Fri, 10 Oct 2025 14:43:10 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
Message-ID: <20251010064310-GYA1439398@gentoo.org>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
 <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
 <59657BBB86F7B678+aOilnA5Z-QL7xF9O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59657BBB86F7B678+aOilnA5Z-QL7xF9O@kernel.org>

Hi Troy, Vivian:

On 14:20 Fri 10 Oct     , Troy Mitchell wrote:
> On Fri, Oct 10, 2025 at 02:13:31PM +0800, Vivian Wang wrote:
> > 
[snip]..
> > 
> > Maybe Yixun can chime in about this as well.
> We have talked here [1]
> 
> Personally, I think splitting them makes the commit history clearer.
> I'm happy to merge them if others also think it's more appropriate.
> 
I do not have strong preference, either way is fine for me
If you plan to split the DT into fine patches, then go ahead

-- 
Yixun Lan (dlan)

