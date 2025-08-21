Return-Path: <linux-kernel+bounces-779516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D6B2F517
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061D35E0C52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DA2F28EF;
	Thu, 21 Aug 2025 10:17:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F518C933;
	Thu, 21 Aug 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771462; cv=none; b=bMxm85CAyewMd+6G3L7TyJYYqCfF46EfC4HYdW8EeLLZc8XE/lpgum6TL7xLw1CK3l663VgB1sa+J2cCP7XEsKAAjWT75Eo93mlAf7tD0ex99yzNNMomfSfEGL71bmMCSGi3bot6MPsZIEO9E8wLj4cXc8vjzkEK10FgX8oNntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771462; c=relaxed/simple;
	bh=PWiWc3LtueeY6gvUwOzbvGNxtp5WuxxIFYIX6ArplCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djm9MabAePVXAji8D6aCA2juH2S0jTdIRyZX/6ywvH5QjL9EV5kveeCKlKSxmx2VCgePIVUdlXGidjDDmwR0C2cFCVLqiuo7tte0h2XJ61xhje7x48DTGiGopHfH3/3H2X0TTReAXko3rsJ7FEE8vKtu28czjPcAceHE4LKbxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE41152B;
	Thu, 21 Aug 2025 03:17:32 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABDC63F63F;
	Thu, 21 Aug 2025 03:17:37 -0700 (PDT)
Date: Thu, 21 Aug 2025 11:17:34 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Juno-r2 WARNING kernel time clockevents.c cev_delta2ns
 clockevents_config.part
Message-ID: <20250821-thundering-skylark-of-proficiency-a17ddd@sudeepholla>
References: <CA+G9fYsYVuEpL5KnYdq4ciRmpnUMQqkNQHmy7y5XvUm48kjxyA@mail.gmail.com>
 <aKXajiHqhhkFeV4a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXajiHqhhkFeV4a@stanley.mountain>

On Wed, Aug 20, 2025 at 05:24:14PM +0300, Dan Carpenter wrote:
> Hi Sudeep,
> 
> Could we revert commit 1fa3ed04ac55 ("arm64: dts: arm: Drop the
> clock-frequency property from timer nodes")?  We're still getting this
> warning on our Juno systems (with admittedly ancient firmware).
> 

It was dropped to avoid further copy-paste into newer platforms that
need to get these right in the firmware. I am afraid keep it would just
not help and any strong reasons for not moving to newer firmware. It should
be really ancient one with no security fixes I guess. I strong prefer to
move to slightly newer firmware version if not the latest.

-- 
Regards,
Sudeep

