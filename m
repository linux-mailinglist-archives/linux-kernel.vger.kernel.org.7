Return-Path: <linux-kernel+bounces-769120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8DB26A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439A53A21F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD52144D2;
	Thu, 14 Aug 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yz5cvluJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3171B043A;
	Thu, 14 Aug 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183576; cv=none; b=tU4irnyw+iMuV8hI36gT3VeqAejfyGTmgVmArviviepxdxPVk2gNqfyL3S0gIZuI1n9QF4w6dqG2rGawhuHeI/Oa7aWC7GJIe9tWFK+Z85qMTudtZMNsdIwcg6kMleKmxO22z8WCxjPg/GlFJ9m2nORq942QJ4ROwl/yO8X2f2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183576; c=relaxed/simple;
	bh=d3KrOdEoT2zJZHZunSCY/weFGSUsN4QrN+Bx3hTSE44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcCWVoJjF6rzbRwtnG3xkpFgsczJZEM11TaRf0iDXKRD5QBbOmUbNEePmvZo0UDOoqCStP7IYoogK01CQ5g216I5hoPHNrO0mlrr8e2a76G5o/9nvXmsKfQBAr10lv+I3zO+u9/OhVrEoDZmEyjk5IVDSrO9FheJijxt4hGTYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yz5cvluJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755183574; x=1786719574;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=d3KrOdEoT2zJZHZunSCY/weFGSUsN4QrN+Bx3hTSE44=;
  b=Yz5cvluJo6tm1NohYxOoJnu3SI4gfVpRWQzEVBaDp5pwJDI3NDX0CjkP
   u/1HWTycPa1xO2e7o9w6+QmDG39zmBSIMhwOjbkRzOEC+PqXnyMOL3Nep
   hq4jm/HlR+F3yKdD+QJm2cPy1X3Lx4i5hr/9bxek0i1herPmk8b/33v8x
   fOfUytdWrltzwB4tYg3iV5pgyqDikPq+nmd0/aXe1AgR6AHbPmX+ybLUK
   6snvbbwku4W8LTGuMYsckLTqtjL+KvMr6xPMQmIn3oPYgMbInrUQg9T3q
   /I74AuSBI7P8cUks534uNaCL8a95r0PiNCOhaWXXKcBsSf/cRmG9PXYfk
   Q==;
X-CSE-ConnectionGUID: 3sFSbYkdStaX0ZcyqhkAnQ==
X-CSE-MsgGUID: 0znHLrl7QOeePsjD009AHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56709637"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56709637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 07:59:32 -0700
X-CSE-ConnectionGUID: CBQUz6+KSRyap+idAss4VQ==
X-CSE-MsgGUID: p2QKORO8S/209ndVJ73Uow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165999986"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.100])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 07:59:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC 00/13] Collect documention-related tools under
 tools/doc
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250813213218.198582-1-corbet@lwn.net>
Date: Thu, 14 Aug 2025 17:59:26 +0300
Message-ID: <e84e288af0536cdc406c787301bc6b9b11c0be0a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 13 Aug 2025, Jonathan Corbet <corbet@lwn.net> wrote:
> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
>
> Recently, the idea of creating a dedicated directory for documentation tools
> came up; I decided to see what it would look like.  This series creates a
> new directory, tools/doc, and moves various utilities there, hopefully
> fixing up all of the relevant references in the process.
>
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.

A wholehearted

Acked-by: Jani Nikula <jani.nikula@intel.com>

on all of it.

> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.

lib/ contains code that's built into the kernel, I think lib/python
would be out of place.

IMO tools/python (or tools/lib/python, no strong opinion) is more
appropriate.


BR,
Jani.


-- 
Jani Nikula, Intel

