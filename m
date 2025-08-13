Return-Path: <linux-kernel+bounces-767104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB2B24FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535571740FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E528AB03;
	Wed, 13 Aug 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="iLZpmoWp"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF62727F9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101238; cv=none; b=VnsJvt/smyoinnS3zK7NFAEDPnL4qg52Sxh/LUU34do/n2DJPoGhRET7TNyArOsqB04YVwkcjP/Qg11jZenJf+fQ2va85PxNtWFyHwcOMjv2jR+AKN2qYM+PuxoF2JkdHnncN+nqcE/cnfElWK706ntxNo+6UpMXHdIFcqAMWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101238; c=relaxed/simple;
	bh=N4JCyCl3TMqGdxL8z8nyy4b0wwx4vjcVA+ne1uluhZo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PTtYi1ghQmauDZ4/Rt2SfhVuhfQ/B/N1Fl6AKzu1Wk+Ss6EYV4aJTQmMPSF8Ck7XtzVo2io4ez7ct9T5EfgZyQpwvBzyVLcxGVHFZtdmS4cnwL6qzUx2TQ7yquUxRER7BQ5uSrEcgfovMRDqlGfuPNQKijJ0fdXFi5rJt5LaLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=iLZpmoWp; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755100536;
	bh=N4JCyCl3TMqGdxL8z8nyy4b0wwx4vjcVA+ne1uluhZo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iLZpmoWpVApJyh/MbWULYTT+MrxPWB884CI1fKVacIcDXp6PMJbZNxlv5xjj6s4EE
	 +V19nVSCemZ5TY9cj27OLG63WxO6hTKf96CxuDRjT8B7Gq+26M39qNVya6GxBnA0ny
	 87ap3K00EQEpcVZU4nqiP3VgHFPGZl1TSIwGWXEc=
Received: by gentwo.org (Postfix, from userid 1003)
	id 47644401FB; Wed, 13 Aug 2025 08:55:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 453694010E;
	Wed, 13 Aug 2025 08:55:36 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:55:36 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Sudeep Holla <sudeep.holla@arm.com>
cc: Jeremy Linton <jeremy.linton@arm.com>, 
    Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com, 
    will@kernel.org, patches@amperecomputing.com, 
    Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org, 
    bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de, 
    nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com, 
    prabhakar.mahadev-lad.rj@bp.renesas.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
In-Reply-To: <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
Message-ID: <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com> <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com> <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org> <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Aug 2025, Sudeep Holla wrote:

> > The problem is that this information is being sourced from the ACPI PPTT.
> > The ACPI specification (AFAIK) doesn't define a cluster, so the linux
> > cluster information is being 'invented' based on however the firmware vendor
> > choose to group CPU nodes in the PPTT. Which means its possible for them to
> > unknowingly create clusters, or also fail to create them when they make
> > sense.
>
> +1, completely agree. As Jeremy mentioned, it is hit or miss and cluster
> is loosely defined and IIRC Huawei pushed this based on their platform at
> the time and it did break some benchmarks on few other platforms. So it
> is not a good idea to make it default config IMO.

Can we figure out which platforms benchmarks were affected and why?

It seems the notion of a "cluster" on ARM64 is derived (I guess a better
word than "invented" hehe)  from sibling information instead of PPTT. But
using that information should work fine right?


