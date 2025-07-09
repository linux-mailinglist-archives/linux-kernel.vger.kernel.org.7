Return-Path: <linux-kernel+bounces-724269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9868AFF0A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F1516C518
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD4238166;
	Wed,  9 Jul 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dC3lR63V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4221D3E9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084763; cv=none; b=L/O41YS338V8uoZFy1+oGs0TGIAI5R+0TvnBDmHn4OZxA2ZL3kOD3zxGKgWWFHe2mmJ9oGA0vtebgVv2j0+Cp//IvN8NGjsJKTPO6vE63rN2jvK84XTZN11yvV7thZfP5y4SHx3Jf73DtMKD2cEUdofy78J2laMDXQa1rj0eLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084763; c=relaxed/simple;
	bh=ZGKG7E1vpbJmu+R+ZP5tg4O6G4wQmSXGehTcEDAAtXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci6RUrE7J2LFul/TZCmzlUQN3zgQz2L+La5WoOwBkCw9+7gdgQpqQaKW4/RSNn+jZeJzDdATUoBoUtfgINBlcjYQCgSiD44KsEzrzUw37x6pm3DV92VG5nT9478FtAAB/L4nGUxa6TUlRO6CkNvH4g5JdsbjNdtJZ/8nvozkV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dC3lR63V; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752084763; x=1783620763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZGKG7E1vpbJmu+R+ZP5tg4O6G4wQmSXGehTcEDAAtXQ=;
  b=dC3lR63Vz7c6qMNWS/Lx5KTGpLSrOrF7gUWtJaCOi3w7PF1q4ObSALbt
   JwbInU6xtIH3TqNKetRR7EHSZq3hwn/JKrHCMnggbyXLYmbUvq2zDhEdW
   GdcFXY6RzBYZ7DkpC6rwWZ917HgiZtwGGwxqFLQOTEM1V0yPNANW0VHOb
   25sH5Gf7Akd/o41RZ69jTHY3u1lmc/xw2WDqPyKFami/D529Mh1o6ypz4
   SygV7NyT8j5wYiX/iYRbSfilRbDbVvks0nsL9tzbbOEDvRRKN84sCXJ70
   bMQeTm8JyvqllL2l2JE4aG/srbZkYtyAPCuJyR2vuR7VH0hll3OoawXWS
   g==;
X-CSE-ConnectionGUID: pC3GJ9POSzqV8/Qvq+c6KQ==
X-CSE-MsgGUID: I1ji9Q0cQBmsrIUu9VoJFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64935871"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64935871"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 11:12:42 -0700
X-CSE-ConnectionGUID: RQko7YZZR/auVI5oMgTCCg==
X-CSE-MsgGUID: B8lXHw/QSR6tq5xCXq+HIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159869615"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 11:12:41 -0700
Date: Wed, 9 Jul 2025 11:12:40 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v6 18/30] x86/resctrl: Count valid telemetry aggregators
 per package
Message-ID: <aG6xGGiOy3xKL-t4@agluck-desk3>
References: <20250626164941.106341-1-tony.luck@intel.com>
 <20250626164941.106341-19-tony.luck@intel.com>
 <69f18b65-4e20-4383-a559-46fe1eda7db0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f18b65-4e20-4383-a559-46fe1eda7db0@intel.com>

On Tue, Jul 08, 2025 at 07:20:35PM -0700, Reinette Chatre wrote:
> As I understand there is 1:1 relationship between struct event_group and struct pmt_feature_group.
> It thus seems unnecessary to loop through all the telemetry regions of a struct pmt_feature_group
> if it is known to not be associated with the "event group"?
> Could it be helpful to add a new (hardcoded) event_group::id that is of type enum pmt_feature_id
> that can be used to ensure that only relevant struct pmt_feature_group is used to discover events
> for a particular struct event_group?
> 
> Another consideration is that this implementation seems to require that guids are unique across
> all telemetry regions of all RMID telemetry features, is this guaranteed?

The guids are unique. The XML file tags them like this:

	<TELEM:uniqueid>26557651</TELEM:uniqueid>

the "guid" naming of the value comes from the Intel PMT_DISCOVERY driver.

An alternative to adding the new event_group::id field would be to
separate the arrays of known event groups. I.e. change from:

static struct event_group *known_event_groups[] = {
        &energy_0x26696143,
        &perf_0x26557651,
};

to

static struct event_group *known_energy_event_groups[] = {
        &energy_0x26696143,
};

static struct event_group *known_perf_event_groups[] = {
        &perf_0x26557651,
};

then only scan the appropriate array that matches the
enum pmt_feature_id passed to get_pmt_feature().


With only one option in each array today this looks
like extra infrasctruture. But I already have a patch
for the next generation system that adds another guid.

-Tony


