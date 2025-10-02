Return-Path: <linux-kernel+bounces-840197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE792BB3CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8463016459A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C968224A076;
	Thu,  2 Oct 2025 11:45:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D81F5EA;
	Thu,  2 Oct 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405543; cv=none; b=I6W78eRvaJTM20eLtcyOMne1j1rhkugTPOeMIL9khU5JMuw7dVirBHFkNloX46pWIbQhvXt5+vwPnKJzu8CJcofNrSFjDpYRglkeGukv2r1/9ocNReWzefi9jPt+8K704HkCMP7KyjGyg0W02XWFomcbCvsyFKm1NrbewT6FNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405543; c=relaxed/simple;
	bh=0Km/dUXS3Bo8kb/Q+OJyzQ5joN1wN3Rn4kdEqhUzEcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0uhAUxMFxLmpuaJ2y9pZ/KvyHyvGhCX+VDFQeEt/5ClQcG9TBHxkb0FyqCsvHhxXmmTnsCXDVh3VrYI9tqlQRPxxHeEao9sce1MfLKq+0c+BlVMYz3Pelcfnd8LSnbqSFmQdD65jIbPOK/6idk5TS6YeywJIgnqbx1klat/pd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64E91595;
	Thu,  2 Oct 2025 04:45:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 864F43F59E;
	Thu,  2 Oct 2025 04:45:39 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:45:37 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <20251002114537.GU7985@e132581.arm.com>
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>

On Thu, Oct 02, 2025 at 11:09:28AM +0100, James Clark wrote:
> Do some cleanups then add a new format attribute to set the timestamp
> interval for ETMv4 in Perf mode. The current interval is too high for
> most use cases, and particularly on the FVP the number of timestamps
> generated is excessive.

For the series:

Reviewed-by: Leo Yan <leo.yan@arm.com>

