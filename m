Return-Path: <linux-kernel+bounces-889361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D6C3D62B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34DB1894323
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25E345CC9;
	Thu,  6 Nov 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIcqIsta"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08A32B991
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461879; cv=none; b=eUT16NLFErSWTPtEebV64a0sYJjHd47sYmUHBudVxUam/qi57dCnw55149eq6hV4v33tBNiPAcetUPbcN0y0zQsQMvS+ow1RyTURxCmF1+1h/dARh6DD97D1BhXdC1TLC6gfSYXZ0NEH9m0ESCrM2SVWy+O9+ST8zNjgyAJJn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461879; c=relaxed/simple;
	bh=SKx2m1YCAFTmy3Li1bzVsBhlBB06YKzCs12SQ6XOmxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrGkhEK3acNTHja9jbjBtqY74iALfQVJu7rCGwnKtkX1r8/rYRLt3zlD1kHXMgKgJR9pppQ/7FcCL/MwhEX0szncN/boFHg/tdD4yrERZHBVp+VUyXHkFI+ajpudO+KbvqH4XOdJU4MdW5Uvmlywc4vNEN2OmpCXhvDQqS8/I7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIcqIsta; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b220ddc189so7934785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762461876; x=1763066676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5Wim2l7yHGi/WuR+a4P3f7TIA6US21JyW18qkpxH38=;
        b=TIcqIstaR8ayW7ITn0YfHIjHKHmoAeQ4Opu+KNgU1bnGxUN2U+mM5tAgm5hqj+JUt4
         WrkccpjVRmxp4Morl+fKrLzAyfOstG9j4XeTvwubrbBFih/h+tOsBkFpHPwOOMJ/WIqX
         3cwnxr7O1YxyhtFootBUALURSyx1mR108fi94eK27O0lqkLWyen0fUu+mrPEe7RSikTE
         FuP3gb2QLi/+jhtzs9jf1b2biyvy7FWzqIEvWtdL0aLzRrH6KRnzH0BnrOoRpPa5ED3R
         0DYC23tioXD9W7orgIJC+v5vN9wZvSwTOBIRbR6GN/yrJ5OChau6xicdF/VsPKFcW26K
         Bdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762461876; x=1763066676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5Wim2l7yHGi/WuR+a4P3f7TIA6US21JyW18qkpxH38=;
        b=U1ghh3NFLSkUYJ3BGLYiBU4WdE+xrIVgAMOP9XnmPxgxiAYu3pFd52U4TaHfTpnnoC
         G/RneyRSJvQ6h/mzRTKRs1HWejp67droFBU6tj1IAzKrSYTLXuLWV3xc5VZ+/JtzN29J
         tjuyEvmibREGw6S63+yLr+ChGVpDS+hxQu+63v4ivbEt+UC91YmlP7SKIEBxAqrtsvZe
         ANglxFYHOCvGCvUSK25NWUFLTDe1UbxVI9x5ZJB8TTtxK3UW4wr1c3vhN3BK3xsAIGJk
         5GxySLhxq6quZtKiWlqyp9NEL8Tf7g4U4aIwBcuWPikoYX+nR8K+xjXsn2emmwguEsGB
         TezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeP2jRadgiI+g58q4MqRxRsm4mefk9PmGxHH/kFNOmyAvZx5WhinC1/8DBJQg1wPXVqgBG8pVcbB34/v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFO0DINsx/+n9T14FtCKGmvSvq5Pudnr8pLs9F432AIrtWox1
	buyHC2xvO2GDLy/cficPMBXE+1vXBOZEgtlYE5uuvhQ+Xuxqz7Kt4AUiNRbNckDTH+UHcHgyTqo
	fRRuuNfWsP55wqxrDDqlO/QfEEkk59Qs=
X-Gm-Gg: ASbGncsOCTTSi/tHgSQ/OuYZcZmhKNCdpSPBy+aDxtQB/Pbb7/4gn/DE674G7CfM8f3
	jAtp7FwF03tkYhTJkgp4jrukiaey4gZtvJ0+TDcjbSzzH/QrIiJXr3INdcat1mYkwrLHGNwlCco
	xuXBE+kCb/f6zWoFT+ItMcGbDxyYKJkEXTE2Jp+c4cFr7oNhACL0QRI0BCYCq2r8cPNFj02sFLl
	yRtnmBvLEDdpZK1009hzATKZvoWRf23RP3Xthca7qhd/0GPfWxLYBzpz4G02I2OfTWrw334ST/s
	EODVtpOtS7gy5GajuJvMvifB1nfHo0lTKMUKBQ==
X-Google-Smtp-Source: AGHT+IGz8Y08GiIKkx5vY35Pamqy5/QXc0dcKCzhllhnUKHhV1vYYvBZag4ViRF1b6CAEtb+2wXa1fOPMaLoDa+5/MI=
X-Received: by 2002:a05:620a:4081:b0:7e8:3fbd:4190 with SMTP id
 af79cd13be357-8b245274f77mr136213385a.2.1762461876060; Thu, 06 Nov 2025
 12:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029023115.22809-1-21cnbao@gmail.com>
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Nov 2025 04:44:24 +0800
X-Gm-Features: AWmQ_bn8KiJSqK3-zGdnXEadv5DAIhjUO-bmMe5yIKhizW75xMm4dJ2q8wKSyoI
Message-ID: <CAGsJ_4wy6ZPhCvMqODy6W6Why34Lfn5WXf1bUwJh+Qmd2X2rCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] dma-mapping: arm64: support batched cache sync
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:31=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Many embedded ARM64 SoCs still lack hardware cache coherency support, whi=
ch
> causes DMA mapping operations to appear as hotspots in on-CPU flame graph=
s.
>
> For an SG list with *nents* entries, the current dma_map/unmap_sg() and D=
MA
> sync APIs perform cache maintenance one entry at a time. After each entry=
,
> the implementation synchronously waits for the corresponding region=E2=80=
=99s
> D-cache operations to complete. On architectures like arm64, efficiency c=
an
> be improved by issuing all entries=E2=80=99 operations first and then per=
forming a
> single batched wait for completion.
>
> Tangquan's initial results show that batched synchronization can reduce
> dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
> phone platform (MediaTek Dimensity 9500). The tests were performed by
> pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
> running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
> sg entries per buffer) for 200 iterations and then averaging the
> results.
>
> Barry Song (5):
>   arm64: Provide dcache_by_myline_op_nosync helper
>   arm64: Provide dcache_clean_poc_nosync helper
>   arm64: Provide dcache_inval_poc_nosync helper
>   arm64: Provide arch_sync_dma_ batched helpers
>   dma-mapping: Allow batched DMA sync operations if supported by the
>     arch
>

Hi Catalin, Will, Marek, Robin, and all,
Do you have any feedback on this before I send the formal
patchset (dropping the RFC tag)?

Thanks
Barry

