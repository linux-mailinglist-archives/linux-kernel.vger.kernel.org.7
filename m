Return-Path: <linux-kernel+bounces-597967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9FA840A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 12:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5784C5E43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E16280CFD;
	Thu, 10 Apr 2025 10:27:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C8280CFC;
	Thu, 10 Apr 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280863; cv=none; b=ccOK/WrkwalkTiNxBLnueCwj4jtdBZuZqRfY8GjG40v1lljRZvBY56MB+I/+Qq5BV/B9Su7m1djMTtK2nQRfE3gKXG3tbtSEiEqyh4vu5LCVjUZ0TuDu1ziRUbWic//NE9MPk88QTXuWBHve80SdBAT0OYTLbdaXFEghyUr/1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280863; c=relaxed/simple;
	bh=WrfhtfZVb6eNoyzZh1KqRt/D9PZkQ4YbXdLaZgOVmgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XypLFzzf1ANEl4WhJJ4B6PA/bJ3eCMt3nGR8pEzTcv8TX8FfqYiOoN7s2CH+xkJQqXt8ORoybNCoky3MUe6C/e3tBhvcTPApdU6EC4Q18ekd5n99t389lVpgKlng7PRLNuiPzaZeAdVtIiH0L4dHr8mc5dF55AX16x2EIJNC8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34181106F;
	Thu, 10 Apr 2025 03:27:34 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11473F59E;
	Thu, 10 Apr 2025 03:27:32 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:27:29 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] cpufreq: Drop unused cpufreq_get_policy()
Message-ID: <20250410-colorful-jaybird-of-development-8caaf4@sudeepholla>
References: <2802770.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2802770.mvXUDI8C0e@rjwysocki.net>

On Thu, Apr 10, 2025 at 12:20:43PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A recent change has introduced a bug into cpufreq_get_policy(), but this
> function is not used, so it's better to drop it altogether.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

