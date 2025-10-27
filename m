Return-Path: <linux-kernel+bounces-871198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCCC0C9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6772E3A4C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F82E7645;
	Mon, 27 Oct 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU1DAkV1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD20226863
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556558; cv=none; b=YcdNue0V4Gp8giS7r7zLkwjxnhArX4kAKkXLspneuy9SrpwQNllOiwEqwmBi+OZ7AAA0yuEZ5yHzuo/rlebhfyWF9/UOjU3Sbn2tFq3viV9luQdXZSj8T8nrMvsMA6R62qx7pcNqCReBRJfUmDTO+FXqeE8J4V7G6TtW42JLraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556558; c=relaxed/simple;
	bh=pn0uJFmb6Z1OlXOEqhkBbIJxTFdZ/OiY1aCisooL1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOvJU1nMTBaXYRlGGlfMEfmWo1XwZR+Wqm24+ak4FCmZ8h2WdFX3Ouv8d5awNSx/78YtT+JPtTB/j0Lke0eOUzdSVTKDw9p0CDYiNQw7yEzHLU/nSGoI7H68PMi5E8glk26/5lVCxvJx3gaZfIlxeqxMWrXG8pVz7nEBxYOFrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU1DAkV1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761556557; x=1793092557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pn0uJFmb6Z1OlXOEqhkBbIJxTFdZ/OiY1aCisooL1Gw=;
  b=PU1DAkV1LbLxl2VaK/nTjT+78soFArthwV5Jm1h3mS5d7qxgOaaa00hd
   SDQWLH5ZyzlnnygFqVqo16onkUStH+zp1rj4/AX3p61umX5HnzY8q7LvQ
   s6stg5aPn4DX1vaCfpECAv18vzTYEexZtCltUOF5An7Ja3Z8FhKkSHF3B
   PEAdXbzSYzH6QvSqE45/24bev20NQ6m57DTgDSLLFhVvPOKj1Deki79nU
   KBrTzbAgpGyqW0NkzI5je7mBCcE4DYQIyttvE8JnFBl04JurDJnddYE5h
   dXBSYWH7V6Y6uLggZP5VvwY7ZVmGGkPsU/4quPFvtLfyjjYOuF9rxbRkf
   g==;
X-CSE-ConnectionGUID: ThkDvW54ToCtU1vwtQ1CwQ==
X-CSE-MsgGUID: oOS1ePCqQQabxT/mkZ/gow==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63537326"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63537326"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:15:56 -0700
X-CSE-ConnectionGUID: Ld+3N+12REKsz8VZjL4CTg==
X-CSE-MsgGUID: Zs+y7xyMTX2vPJlwoeJdvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="222204901"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:15:55 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDJKR-00000002xfT-2sOi;
	Mon, 27 Oct 2025 11:15:51 +0200
Date: Mon, 27 Oct 2025 11:15:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: Re: [PATCH v1 1/1] checkpatch: Don't warn on "orhapned" DT schema
 file
Message-ID: <aP84R10AL2UE9OGG@smile.fi.intel.com>
References: <20251027090635.1740111-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027090635.1740111-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 10:06:35AM +0100, Andy Shevchenko wrote:
> Currently checkpatch warns is the DT schema file is absent in MAINTAINERS.
> However the DT schema files are self-contained in this sense and
> have embedded information about maintainers of it. This is a requirement.
> Hence, avoid checkpatch warning about it.

...

> +		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> +			if ($realfile =~ m@^include/asm/@) {

Crap. I forgot leftovers once again, v2 is coming soon...

-- 
With Best Regards,
Andy Shevchenko



