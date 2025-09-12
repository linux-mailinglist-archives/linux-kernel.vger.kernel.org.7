Return-Path: <linux-kernel+bounces-813589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D4B5480C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6509A014BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E198246348;
	Fri, 12 Sep 2025 09:35:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24AD223336
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669739; cv=none; b=dhLk1SVtYGKK7N+lJqrbXkdHh6bTA0pfAFkDowEe3KpNPeL2ZKhdvywuy5NNzI69/sdroatOQeNvpBxMjzqvTbJ3Hn1C7Jf6tHNvwujrwCpKjcnHBi3nWYrB0KM1GwJWIur5XNrgw/BWHhjJNC71XY0J3kKlLdtks4ZjuB/qNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669739; c=relaxed/simple;
	bh=e8Kv+heaIGHh0UyeIZLnqRvrSzgtEd+kbBWci2LzLmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV3wIdX06bZ9lSFIAbDqSHoonFOeiy1HyxD4Pb5ZhFSUKmb/J2F222NDQVfq8G8rYDsh6EVPdOMKpXCLb2ON4+BQzf2HDzH570O0c+f5pWOD9zFlcrC/CaabKRqHOJxq6lAAnIaMAQ1CanvziSPkD9vkb+oRXCWQa1CuKaVibSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0EAA1A25;
	Fri, 12 Sep 2025 02:35:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25273F63F;
	Fri, 12 Sep 2025 02:35:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:35:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <20250912093534.GF12516@e132581.arm.com>
References: <20250911153315.3607119-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911153315.3607119-1-sean.anderson@linux.dev>

Hi Sean,

On Thu, Sep 11, 2025 at 11:33:15AM -0400, Sean Anderson wrote:
> coresight_panic_cb is called with interrupts disabled during panics.
> However, bus_for_each_dev calls bus_to_subsys which takes
> bus_kset->list_lock without disabling IRQs. This will cause a deadlock
> if a panic occurs while one of the other coresight functions that uses
> bus_for_each_dev is running.

The decription is a bit misleading. Even when IRQ is disabled, if an
exception happens, a CPU still can be trapped for handling kernel panic.

> Maintain a separate list of coresight devices to access during a panic.

Rather than maintaining a separate list and introducing a new spinlock,
I would argue if we can simply register panic notifier in TMC ETR and
ETF drviers (see tmc_panic_sync_etr() and tmc_panic_sync_etf()).

If there is no dependency between CoreSight modules in panic sync flow,
it is not necessary to maintain list (and lock) for these modules.

I have not involved in panic patches before, so I would like to know
the maintainers' opinion.

Thanks,
Leo

