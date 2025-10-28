Return-Path: <linux-kernel+bounces-874692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD44C16DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AF91B243B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED52BE04B;
	Tue, 28 Oct 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="jcn4Qm+0"
Received: from out.bound.email (out.bound.email [141.193.244.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D62DA757;
	Tue, 28 Oct 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.244.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685583; cv=none; b=qx94YawB318eFd/6+GsFCGWUYLsGf8fP46E8J/cNdAKGWG8l+246t2/gOjRZ1/jrMijf7kgvZE20KlWd+D9uIX2pDuhYFNLiYnUFU53dP6YbxNIeOd5ZZ9iPZdy3Om0BS1URzCt1baXGSpBYly1GUU3cRRmk9nlwDy1J/W698mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685583; c=relaxed/simple;
	bh=Hv8DHOlyQnNQFBqPcnrsK3QnDX2yTB0jidqOY1dVoY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccvU97uXFjSvbv7JPMPXKbXgxSEbTLJyPCZqLEyfUBos/mz+FWBs57vj1k/ruuCNWJQU0YosL//bMO+RKaK/PPaBqaYuA58grzNApQ1eHYGQYH21Rk6zJqIQXt+ridAEffLej99UM5yHQJHCg3fYj37g2AUW6nF8PgeVBj0p1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com; spf=pass smtp.mailfrom=erdfelt.com; dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b=jcn4Qm+0; arc=none smtp.client-ip=141.193.244.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erdfelt.com
Received: from mail.sventech.com (localhost [127.0.0.1])
	by out.bound.email (Postfix) with ESMTP id 341EF8A0A03;
	Tue, 28 Oct 2025 14:06:19 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
	id 1C913160036F; Tue, 28 Oct 2025 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
	s=default; t=1761685579;
	bh=MG2CHoxJgPs5SpTo/dvhA7IRWSaF2xM68nlYgIMcDJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcn4Qm+0JCJsdorJ1JBiojYDHyMW7YVNCTmSHHHY/FrNV4YTHwhpO+kiX5dWW2tXs
	 KFzHhV5TWX0wT97cjNNlL937Bgtwe3Yp1QXofXDtpA81ulz7ppYxfxYOE9H4Pegqib
	 Z7fXwUy0Fyyf5PSq0/KK2pYIjzY0JiEvYCMCgxN0=
Date: Tue, 28 Oct 2025 14:06:19 -0700
From: Johannes Erdfelt <johannes@erdfelt.com>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
Message-ID: <20251028210619.GO15521@sventech.com>
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
 <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Wed, Oct 22, 2025, michael.opdenacker@rootcommit.com <michael.opdenacker@rootcommit.com> wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> The OrangePi RV2 board ships two RGMII ethernet ports.
> Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
> for reset pin control.
> 
> Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
> CC: Yixun Lan <dlan@gentoo.org>
> CC: Vivian Wang <wangruikang@iscas.ac.cn>

I tested this patch on my RV2 board. I see similar iperf3 results.

Tested-by: Johannes Erdfelt <johannes@erdfelt.com>

JE


