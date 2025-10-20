Return-Path: <linux-kernel+bounces-859982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E1BEF146
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3FBD3488B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FA27FD7D;
	Mon, 20 Oct 2025 02:18:53 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47427F163;
	Mon, 20 Oct 2025 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926733; cv=none; b=pr4mI8Q2LnGIEMJNAkzyeMjwQrDt2ZumdNNZp1OuwNzqy2IA3COkDbawUB8OA7s1hZJZFJ5jbqcnWGka3YbC2uHmUrc6KW8ng9ZTsY0zfCdwVms3IfePRy0nE0NSw/9+Qdg+N84XlXh9170TtN9jGNt458n49ch4ZpnoAEja9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926733; c=relaxed/simple;
	bh=tCim8/OQXv6esAr1a2ZnG/Qa4epnenVw/wrXBjAB+zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvqU2Eulqro2VPrWMRLI9XsfvBTrp74S49Yf9+GPMJzVrwddA0GBDDnHGHxqIf0bLjdVJ/Z7uG/ukJURBSRToNfh5VNvHJ3VLEnggn7zM72JguckIs5t5Eov5d6bs0iND+wV74xsxstYRIvVbGz5z4y8m+K4jXQ4rO2fd/RwOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DFB15341ED2;
	Mon, 20 Oct 2025 02:18:50 +0000 (UTC)
Date: Mon, 20 Oct 2025 10:18:46 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Message-ID: <20251020021846-GYG1506524@gentoo.org>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
 <20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com>
 <20251020015204-GYF1506524@gentoo.org>
 <52A7E982E5B11F53+aPWYHMbImTxJy7pJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52A7E982E5B11F53+aPWYHMbImTxJy7pJ@kernel.org>

Hi Troy,
On 10:02 Mon 20 Oct     , Troy Mitchell wrote:
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > > @@ -0,0 +1,78 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > ..
> > > + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > this isn't a big problem, but I think it would be better to use SpacemiT
> > Corp's Copyright, to reflect you're not doing as individual contributor..
> I understand. Since I originally wrote and now maintain this DTS,
..
> would it still be acceptable to include my own copyright line along with SpacemiT’s?
I think this is good

-- 
Yixun Lan (dlan)

