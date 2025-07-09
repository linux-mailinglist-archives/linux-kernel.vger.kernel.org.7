Return-Path: <linux-kernel+bounces-724155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A9AFEF33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA6B562C87
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C823221F1C;
	Wed,  9 Jul 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yd6mo/N2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DED2080C8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079955; cv=none; b=LhRJS3M+MGb8gu9drxtW8Phzx4oDVHW84/+CKZb5h6JdT3Ufk2wB0t1RnTdgw1auLHmPaJZixWAviGKjZilEYNBQnTbdwHSvUfwwl5LWc9L4rV1LyM+/x2o7+4thBo0d49s9PXl16c+KO5zXkNKp9xyEd3ZvpSpCEvX9tZZZhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079955; c=relaxed/simple;
	bh=xXG453hgJ5Dpw7fiwbsmN4MX3KEhUsMOxDlDDu19ahs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrjSw/S5nAm4z9lr/NSNPnSqLbM50yAAZzqxY7SZAcKRl+U8WGvQAKNxwxwEm3Ebc8v5gqXakPOMBreA1xbtyfqd6GbNJqha6FQHTk4KCj+LAGM+jCqRYhVb5VIMwo6/99XqxKRXwodOqLGBObPmvTbMFgFnUkv9Mbr4P0DoWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yd6mo/N2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752079954; x=1783615954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXG453hgJ5Dpw7fiwbsmN4MX3KEhUsMOxDlDDu19ahs=;
  b=Yd6mo/N2efrwN9l+HQ+ZzUEqdlTz17D16Wvtfe2198x0iQZKShFY1q9V
   ZlKppYHYK6iBWUgQmz12SlZxxYFhpeR0ofxcf5mXExjjbtMBZ5i51GDW3
   flpz9IXkjhuqWBj4+E5yTlygHb4qDjL9WfhGN4TyfYCrJHIsCNStF/K3Z
   ajwQ0FgqUj1/zPU6uA9a3C/CyL5i+n0yZtbi9ie58HaylmGV64Oz/DDxO
   UEWfjxHB79VEulh7LsZjLveqX5QiS9SYZNE6etHr0vnz2VqGgPdS0XCSd
   8Lu5kjwN/58BQrfFrTVyN56GSTt7BRAmKCG/0iYoTbIfx9JOk6s4M/CXE
   g==;
X-CSE-ConnectionGUID: B+Vf9kpCS6OPEnc7t27EEw==
X-CSE-MsgGUID: HgGc6lFGQs6h3PBcCbyC4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54276566"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54276566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 09:52:33 -0700
X-CSE-ConnectionGUID: eSHJfKepToWsvAVRwUTcSg==
X-CSE-MsgGUID: fe5iGt+qTWWG2I7rP8RQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161384973"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 09:52:33 -0700
Date: Wed, 9 Jul 2025 09:52:32 -0700
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
Subject: Re: [PATCH v6 14/30] x86,fs/resctrl: Support binary fixed point
 event counters
Message-ID: <aG6eUJDdbx7zgm89@agluck-desk3>
References: <20250626164941.106341-1-tony.luck@intel.com>
 <20250626164941.106341-15-tony.luck@intel.com>
 <8214ae1f-d64c-496c-b41d-13b31250acea@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8214ae1f-d64c-496c-b41d-13b31250acea@intel.com>

On Tue, Jul 08, 2025 at 02:46:00PM -0700, Reinette Chatre wrote:
> > -void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu)
> > +void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu, u32 binary_bits)
> >  {
> > -	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >= QOS_NUM_EVENTS))
> > +	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >= QOS_NUM_EVENTS) ||
> > +			 binary_bits > MAX_BINARY_BITS)
> 
> This alignment is off.

I think the problem is location of the parentheses. An invalid
"binary_bits" value should trigger the WARN, just as an invalid
eventid.

So I'll change to:

	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >= QOS_NUM_EVENTS ||
			 binary_bits > MAX_BINARY_BITS))

-Tony

