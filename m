Return-Path: <linux-kernel+bounces-754853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B9B19D88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E4A3A8DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994E241114;
	Mon,  4 Aug 2025 08:22:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFC23FC49
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295757; cv=none; b=sE2JNvuBo/KI5qmiDpabr8WoHO4Z15NZT4bKzTxF/AewwQRKuJeC9Jg++fhlqtpj6RRCr24MapYex+3smiJKxs+HWzLwDuRxyzkB+gOjdH05sWLKdEXazvVXaoFSOZJNTCu2wrGNEskVVWCKaI26ZP5a58FmbwZubROVAo02B+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295757; c=relaxed/simple;
	bh=EcgsEKmnGpbSO5YixYL1wsyByc7pai2IaJdgtz6xhE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0A+Wqy3d5YRadjwG7utnnUNSg/siXHCyWwJl4z0bVc4QLSIa1wqqQiEcJaGt3o+LjofnI3yZS5xXb5UJv/7NdDfcWW0x2+qnwZRxbzk26HAKp6eUnnuU3Y9miP+jmMTW4qDdd4fz7ecRMSqtrj1b8lsZ7dGkBUQLYBz1KbxDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE8E1C25;
	Mon,  4 Aug 2025 01:22:20 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46FE73F738;
	Mon,  4 Aug 2025 01:22:28 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:22:26 +0100
From: Leo Yan <leo.yan@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Levi Yun <yeoreum.yun@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yabin Cui <yabinc@google.com>, Keita Morisaki <keyz@google.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/28] coresight: Change device mode to atomic type
Message-ID: <20250804082226.GH143191@e132581.arm.com>
References: <20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com>
 <20250701-arm_cs_pm_fix_v3-v2-1-23ebb864fcc1@arm.com>
 <cd8cba00-b495-4aab-b63c-699bb2c12d48@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8cba00-b495-4aab-b63c-699bb2c12d48@arm.com>

On Tue, Jul 15, 2025 at 12:23:22PM +0530, Anshuman Khandual wrote:
> On 01/07/25 8:23 PM, Leo Yan wrote:
> > The device mode is defined as local type. This type cannot promise
> > SMP-safe access.
> > 
> > Change to atomic type and impose relax ordering, which ensures the
> > SMP-safe synchronisation and the ordering between the mode setting and
> > relevant operations.
> 
> 
> But have we really faced such problems on real systems due to local_t
> or this is just an improvement ?

This is an improvement based on reading code. The reason is the
variable is accessed by mutliple CPUs but not per-CPU access.

Thanks,
Leo

