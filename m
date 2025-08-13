Return-Path: <linux-kernel+bounces-767651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F44B25738
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121146221C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C52F656D;
	Wed, 13 Aug 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="c9cXknZD"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E12F0C73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126437; cv=none; b=IPcm1Js11cXDG2cxeUbw0x8ph7tgriVHJzuvgXcObi7Gsi1OHSPnrZ5ptokYzU4wUr2FBvZbfVTGYN2o7Ea6k1BYdxz01l5Lrnjue2S5Hzact7MhkN7lqTiT2cODuPDJR2WSB/Tc7tuDDVNowqW4tR6CnKG4mbapqxWotp0H0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126437; c=relaxed/simple;
	bh=yVULnksl4OKg12CxxFYhPKFfdwxXkGZSNGl9YwQ9v2c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DGCddrt+myIqwSa9FG+IWLCXOWWom1+hfHGD+BXqRqqHdLooR6fJjlfoKos2aqhW9eJt+cl/n12Zg1mjKoaKplgsXW7Q3BdA2zaGUog+00zzOQeuAjj/IRmvDaBTi33OGVfVsi4pA+qJr6yoU2c0BCEclgYGvAS3l9aTMxhJpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=c9cXknZD; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755125807;
	bh=yVULnksl4OKg12CxxFYhPKFfdwxXkGZSNGl9YwQ9v2c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=c9cXknZDA7jyMse2KwiTCmhQnLux9UKA/5fhjfEmP5A5B2TlCljggrqBrGgxMyVbs
	 uvPkj/FSbvMznPSZdPr95SfEj6EpM9re3w44gRah73+XyU05DKRl+AmPV2FjXmKZoB
	 FCBoKE4TInJVdKQyFAb3GKWl0c9/xEjxlIc5Sh+8=
Received: by gentwo.org (Postfix, from userid 1003)
	id C26E3401FB; Wed, 13 Aug 2025 15:56:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C15174010E;
	Wed, 13 Aug 2025 15:56:47 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:56:47 -0700 (PDT)
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
In-Reply-To: <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
Message-ID: <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com> <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com> <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org> <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com> <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Aug 2025, Christoph Lameter (Ampere) wrote:

> Can we figure out which platforms benchmarks were affected and why?
>
> It seems the notion of a "cluster" on ARM64 is derived (I guess a better
> word than "invented" hehe)  from sibling information instead of PPTT. But
> using that information should work fine right?

Sorry no that is not correct. The cluster information is correctly read
from the ACPI tables and the cluster ids are avaialble in

	/sys/devices/system/cpu/cpuXX/topology/cluster_id

if CONFIG_SCHED_CLUSTER is enabled.

If there is an issue then it is a problem with the vendor firmware
providing cluster id configurations via ACPI that cause regressions.

We could add a blacklist for those platforms to avoid regressions but we
should not allow that to hinder us to enable full support for clustering
on ARM64.




