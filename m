Return-Path: <linux-kernel+bounces-762464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E09B206E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A63D2A14B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C12BE7AB;
	Mon, 11 Aug 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cXkzUFps"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A02475CB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910465; cv=none; b=mqMatPDF4HH7c7dOo0OSrAtFBKudp8kkK1GT6MJxtBMIGTgnX22SSiP1seaRm1akFkjjqwkimcYbmdcWBA+REd3rS7NhrE8jG/WUiZVNpcJi9a791RmXp4vaWfdk2ZoTSUtGgXeJTtTtnfWztPH5SaVHjQr/hb+masKuNssFM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910465; c=relaxed/simple;
	bh=jrPX3asXOVnx4d8V7WmssJwou+YiP/03bbhmghaPMxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fHTBCh4bd6zwoXBurXTbZ/w8WwUVqZQCzzdy0fvrrBX9MpYMd0acLkE2jLBnjLTGOj4I9BMJGwcPoSwD1NfpeEeZTqoOaL8Juqu79+z/kyqMjHgr9NKJ6bPW5gQtSV7qCTKRPO1XNeSjz4zZcVWVnp48hs3w1XAjhb8PKTp2MB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cXkzUFps; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250811110741euoutp01cb35f7a564e9feafb7fc2b68c8a11c8c~ascRisjjM2626626266euoutp011
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250811110741euoutp01cb35f7a564e9feafb7fc2b68c8a11c8c~ascRisjjM2626626266euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754910461;
	bh=u8h5sOd5ZZUtNfpfhWggmgKeLg0/x2lr+B4GFvhV6yY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cXkzUFpskzwmCYAS5S0GKje5vrNr80hJseWOOuVwTV/0EE8IlwlenonPQ7l6xjDeq
	 Af6LNlt2d1wsr5qwJyoXfYqo57pUUjibYloSLxMeowLeF+9rT7L6RympoDWnaXKaST
	 +CNSZZEGRjmf/BqlqKRIv/73xoY8dbw5C0wW93xc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250811110741eucas1p1fdd92fcf7b997d5d67d34129c14ea7f5~ascRHgJUF1793917939eucas1p1Y;
	Mon, 11 Aug 2025 11:07:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811110740eusmtip1c4907f7c2fd3a01b855aa829c7bff5e0~ascQJfIL53218032180eusmtip17;
	Mon, 11 Aug 2025 11:07:40 +0000 (GMT)
Message-ID: <416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
Date: Mon, 11 Aug 2025 13:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	robh@kernel.org, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, william.zhang@broadcom.com, kernel@oss.qualcomm.com,
	will@kernel.org, djakov@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250811110741eucas1p1fdd92fcf7b997d5d67d34129c14ea7f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf
X-EPHeader: CA
X-CMS-RootMailID: 20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf
References: <CGME20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf@eucas1p2.samsung.com>
	<20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>

On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
> Restructure the call site for dma_contiguous_early_fixup() to
> where the reserved_mem nodes are being parsed from the DT so that
> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>
> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
> Tested-by: William Zhang <william.zhang@broadcom.com>

Thanks, applied to dma-mapping-fixes branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


