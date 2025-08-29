Return-Path: <linux-kernel+bounces-791523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD07CB3B7FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84641BA1CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7B305E0D;
	Fri, 29 Aug 2025 10:00:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B722F14C;
	Fri, 29 Aug 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461635; cv=none; b=fFHx1HfxYmg4TfhZjxvlXn1GJrol7VAbqSmJk5YH/2fjKMhRtMs3C265sRarQGmYsSoNSAtxKWFGnQnwKAdR+4OvlwtMcQpbAMR4eM/DetfzpRYZN4RC0gr6Awt75CxpZ6NzgL4DqEGAPImefyydNvb+7fmJ250FvG9it8ACQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461635; c=relaxed/simple;
	bh=WgIq3sc66mC3NqKzd1tHDwIcbZNwfuVmbnIzoovutt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHB4Q4ZZmx7Let5/d485+BM7d3AAix8eazKGN+14D94kyMW4mRoFDvE+vKsTKrQKiedDUJMDzeaaY7USVEzs9WohQIIztVPAAQEbR28pBldNwBSHU/WSQyZCauAwJVJ/jGgXgHfRXwbS8EpbACsP0brNuaNEvzUwxqonOzfDyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D1A15A1;
	Fri, 29 Aug 2025 03:00:25 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08F23F694;
	Fri, 29 Aug 2025 03:00:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:00:28 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: scmi: migrate round_rate() to determine_rate()
Message-ID: <20250829-strange-jolly-barracuda-c6adac@sudeepholla>
References: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>

On Wed, Aug 27, 2025 at 01:12:07PM -0400, Brian Masney wrote:
> This driver implements both the determine_rate() and round_rate() clk
> ops, and the round_rate() clk ops is deprecated. When both are defined,
> clk_core_determine_round_nolock() from the clk core will only use the
> determine_rate() clk ops.
> 
> The existing scmi_clk_determine_rate() is a noop implementation that
> lets the firmware round the rate as appropriate. Drop the existing
> determine_rate implementation and convert the existing round_rate()
> implementation over to determine_rate().
> 
> scmi_clk_determine_rate() was added recently when the clock parent
> support was added, so it's not expected that this change will regress
> anything.
> 

Changes LGTM,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I assume it can go via clk tree.

-- 
Regards,
Sudeep

