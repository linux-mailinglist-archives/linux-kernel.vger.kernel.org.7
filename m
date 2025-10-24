Return-Path: <linux-kernel+bounces-868883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E4C06687
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0843BFE74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09873164B5;
	Fri, 24 Oct 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHiS2/le"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77533148DD;
	Fri, 24 Oct 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311136; cv=none; b=MDnT/H9LG8oOEPgKSqClSm99hpfmhBAJ/jGIf5faif7D6MkiSR8AHj00hUKZqs9dYfkPnQr3PEzHlZiu71XgrO1ZVbrNVwOVaRlShQaMz6keowAhHtUIivBoiTC0hFfrbFQWHpAlsWQz4AhOsC8TUuzdjh24G1g5/P4Vcy9XuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311136; c=relaxed/simple;
	bh=eWVfHAy/Y1MgnCBk77yAbcbeYMqjJFLxcrncLASEdUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMnLqV/pnJ0ByDY8NBPWJgrLXbUq9bBh69MYv2AZ1RVjqdEmSSk8csVUEXoPx4DQI1b1odcWykEqso5DkRqAQR0UU1ZmkP5kC90I/Y3rvnA4W1JJSG71xuZKhmuJAWWazKTmbULQoFLjKWlK35Gr6qc3QV7XWAyctegyMC167sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHiS2/le; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761311135; x=1792847135;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eWVfHAy/Y1MgnCBk77yAbcbeYMqjJFLxcrncLASEdUw=;
  b=UHiS2/leOPSldLkNfplVyshLYpnlKyiXqF93NrddFb5bttNHAHo9z/OP
   LG9btBV6bLNDnxU0muegraKnCH44Wlk+vgjIxGjUHImo8Gb7f15sISsSY
   1QY2vshqKtRCejrDItyKVAdKSudZVFQ+38vSsAsPWvAoDIlsDWooczUCo
   RpJ33WzPrmNsC/Yonij/ZH11SxhHB58dMQ4KpCmmNGBZIMBZc3bb+1NRC
   E1LabnELZP//+n5HbgcFtYtJFb7gypMBAW31asFYHgP6f8tIGfFjWV3ls
   r2rOJ9UK7yDb3fIMOMizmdKoWr2piO7DBZwtNXHjnURoa1WGjoiOnAtQt
   g==;
X-CSE-ConnectionGUID: psPdySGeStOm5EKMQcROMg==
X-CSE-MsgGUID: C4Apgp7kQ/+ZDS9dQH56Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81119368"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="81119368"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 06:05:34 -0700
X-CSE-ConnectionGUID: Y3vLbxaBTpu5PVLAp/8bSw==
X-CSE-MsgGUID: ENAXkJ4vTpuel3Wv8VEQ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="183600413"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.230])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 06:05:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 00/10] Collect documentation-related tools under
 /tools/docs
In-Reply-To: <20251023161027.697135-1-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251023161027.697135-1-corbet@lwn.net>
Date: Fri, 24 Oct 2025 16:05:28 +0300
Message-ID: <4b965910f35458a708ae3d810f1d766720f96c4f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 23 Oct 2025, Jonathan Corbet <corbet@lwn.net> wrote:
> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
>
> Recently, the idea of creating a dedicated directory for documentation tools
> came up; I decided to see what it would look like.  This series creates a
> new directory, tools/docs, and moves various utilities there, hopefully
> fixing up all of the relevant references in the process.
>
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.

I think lib is for kernel code, so lib/python seems out of place.

I don't think tools/python emphasizes lib enough, and gut feeling says
it'll end up containing random python tools, which I think is the wrong
way to organize things.

tools/lib/python?

In any case, I think either tools/python or tools/lib/python is better
than, say, tools/docs/lib, because the python libraries should be geared
at being more generally useful than just for docs.


BR,
Jani.


-- 
Jani Nikula, Intel

