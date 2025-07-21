Return-Path: <linux-kernel+bounces-738647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA77B0BB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A113A83AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D231F1522;
	Mon, 21 Jul 2025 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DSouQuv2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9C38DE1;
	Mon, 21 Jul 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068648; cv=none; b=gbMuhHMIdLuFAsKluDPgnOIN5on1rBnMJzpKBwjWRNvbB0OodVcmlmvELc9lngfutf1BR1FP9FcKgNM7pm26dDSQhnxs8NrDQE7wHRNKI01SPR94f0vj9xMaWy71af4m23zpqmMcRY0y4Nip/OIyG4eqhtjCotW5+nZIDKKB47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068648; c=relaxed/simple;
	bh=LFsKT2Q94pPFDivxU/VRLDLQdtBJNufP1cqScw8I0v4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BXuf8dPC8dw4S6BEAzJ4dVghsGHSXf4WrcDVv5BCAqJgsrq962hX5IHO9HF2K2BQrnnuULRYBgRfMUyTavGMWkfWm7hZKVeZUxM+V/7ixBzri7iK0erk31iAd9DknzxF7TG2HJb0z/iCOrSt5QNzjDDsH+zLkkG8UySR6dL3wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DSouQuv2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753068643;
	bh=VuSv0/XI/eD9FBwiYcZx/CO4wUCjzxcc9XNCARjCC6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DSouQuv27SyZh06F/ZYCO5G2WVwWjFsbsiPNoh8HGk2orE/qR23g8EAU3fUkCjLdI
	 Hvov4ZxhWauWqgDW3oCIhchw8bcj9v25Wa4DamYtaujlrup7qb3QyPtxBT4Iprj9i7
	 nYn79yWqv3jyNZmafxAKheJxGe1dWshVlktl8A1ggstKyM+5u/+xVTxsAwps4IdDvl
	 raOGV/8/KgVBZZ1lRN1R9Y/cCnztogEvWJoc9FHXrdY9GazNPygU+7x27jCH9XaNqz
	 DXhpNFACCQ9/qyy7x5S00fMncpFT8oT3UmakjPM1ajuALpk0qZs9e7b5C/1UrYl7Yg
	 od/N8MsWOdjoA==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9F6F4640A2;
	Mon, 21 Jul 2025 11:30:41 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 openbmc@lists.ozlabs.org, Willie Thai <wthai@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Deepak Kodihalli <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, 
 Leo Huang <leohu@nvidia.com>
In-Reply-To: <20250717-update-gb200nvl-dts-for-new-hardware-v3-0-f28145c55c98@nvidia.com>
References: <20250717-update-gb200nvl-dts-for-new-hardware-v3-0-f28145c55c98@nvidia.com>
Subject: Re: [PATCH v3 0/4] ARM: dts: aspeed: nvidia: Update DTS to support
 GB200NVL hardware
Message-Id: <175306864149.1300934.10142311415731184566.b4-ty@codeconstruct.com.au>
Date: Mon, 21 Jul 2025 13:00:41 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 17 Jul 2025 09:52:09 +0000, Willie Thai wrote:
> Update the DTS file for the GB200NVL hardware change.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


