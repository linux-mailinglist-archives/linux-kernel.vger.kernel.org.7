Return-Path: <linux-kernel+bounces-837855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D35BBADBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F793204BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53F3043CC;
	Tue, 30 Sep 2025 15:20:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B08173;
	Tue, 30 Sep 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245625; cv=none; b=LfO6qclTzixVT/VdI1NjBY66xeKeRHAoYD6ye7LMCo9NyV+YIwkwFyEiicSw8Rzc6qeW1PXrNtmKItifV+TVd98jJbMIEgiBC0aTWPStll/1SHj6Oz/Qo/7M1ea2v98qs5xFrKAwONuWU1pl/MyJpDBYWJlBfDmeoJ2NBO2rXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245625; c=relaxed/simple;
	bh=4e30QlnkrFHP1IK4ssY3GXRdwGRiC58ydkd81fVN7Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnX8oseEwfsqj+SiF7qltMyW/rBnpDxpkj8cao2jP9zYOnHVJmKTtU+SG9GNz2YAIO3cMbyvGD7l9w9C5aneR99HfTdpJJ+5BOr+V8shZ2VeiI+RdQeKHVq04pgWuFmTZEW57mXWrThOLaT6xiqx66mXOoJliQJ6nfroL6G92qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97D81424;
	Tue, 30 Sep 2025 08:20:14 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59BD13F59E;
	Tue, 30 Sep 2025 08:20:22 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:20:20 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/6] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <20250930152020.GL7985@e132581.arm.com>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>

On Thu, Aug 14, 2025 at 11:49:51AM +0100, James Clark wrote:

[...]

> This is added as an event format attribute, rather than a Coresight
> config because it's something that the driver is already configuring
> automatically in Perf mode with any unused counter, so it's not possible
> to modify this with a config.

Tested on Juno-r2 for this series:

  # /mnt/build/perf record -e cs_etm/timestamp=1,ts_level=15/ -- ls
  # /mnt/build/perf script -D | grep I_TIMESTAMP | wc

   1305   11745   83337

  # /mnt/build/perf record -e cs_etm/timestamp=1,ts_level=0/ -- ls
  # /mnt/build/perf script -D | grep I_TIMESTAMP | wc

   120668 1086012 7705024

We can see a small counter (2 ^ 0 = 1) that records significant
timestamp packets.

Tested-by: Leo Yan <leo.yan@arm.com>

