Return-Path: <linux-kernel+bounces-832853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74ADBA0937
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D846B1C2128B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72340306B30;
	Thu, 25 Sep 2025 16:22:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEA306486
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817377; cv=none; b=KT0wbdH86uTfFRTBQTjvxV7QUKbqEbi/Uhx0uoLewTPt76tsIu4D5GcEMYnSgcbQIAHW1ogRRwvUwgLupi/IfBu7Id3BgO2MYj/fvJOIA0Pcm0+tgz9OoEqXyZ97Hd47KUW/yYWBjWyupccIRe4+rn7RtJopORXD7pG99+5NlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817377; c=relaxed/simple;
	bh=RFX1AhuGaW9ZxfaUKPwS3mPM+9Ozp/qCZ8JQB4xZ684=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCQKmYmcthxXN5Ke76ZL7vueg+7WhWTu6+o7JzUOkUfhgsaMjC0EcXg3pLQVRbYHmwvEYeQH7dl3hHAbR0wUb4+s6/cVR+TZXXMHnHEeCdhqZDUUx3xDV2P3MN0N3i0wRvf9FQWdhhkzZ6Mq08AaAR4F6BI9bZqGTwIZKAsizis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E2F1692;
	Thu, 25 Sep 2025 09:22:46 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2F43F694;
	Thu, 25 Sep 2025 09:22:54 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:22:52 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v5 3/3] coresight: Fix possible deadlock in
 coresight_panic_cb
Message-ID: <20250925162252.GE7985@e132581.arm.com>
References: <20250925150342.1845615-1-sean.anderson@linux.dev>
 <20250925150342.1845615-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925150342.1845615-4-sean.anderson@linux.dev>

On Thu, Sep 25, 2025 at 11:03:42AM -0400, Sean Anderson wrote:
> Panics can occur at any time, so taking locks may cause a deadlock (such
> as if the panicking CPU held the lock).  coresight_panic_cb uses
> bus_for_each_dev, but that calls bus_to_subsys which takes
> bus_kset->list_lock.
> 
> Instead of registering a single panic notifier and iterating over
> coresight devices, register a panic notifier for each coresight device
> that requires it (letting the atomic notifier list handle iteration).
> atomic_notifier_chain_unregister will just return -ENOENT if a notifier
> block isn't on the list, so it's safe to call when we haven't registered
> a notifier.
> 
> Fixes: 46006ceb5d02 ("coresight: core: Add provision for panic callbacks")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Leo Yan <leo.yan@arm.com>

