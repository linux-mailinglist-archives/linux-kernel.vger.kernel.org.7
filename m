Return-Path: <linux-kernel+bounces-807265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9DB4A245
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DA618847FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE671F3BA4;
	Tue,  9 Sep 2025 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNLn8D6l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E18302CB5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399446; cv=none; b=ra825PE6Fel3ElixN+DckAFBBUcHSB/QqEiWZQA5mPbN3fWFJTeJMdbyYf41banbXzxIFCcLcrk3Wxj+p88rMidsU7Rb92y0vbeZfgjnc7ZaZ0lFs/AulytH+5igycKQsTjzJA7hBjC5cStChKlWsemqYyrXM/HL3TYCpvgNbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399446; c=relaxed/simple;
	bh=Sc0AlrHEuuqIDsAMjno5tS1ebxOGfZrnDqw+DIZdtmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dxl2CMA/VBDW/dhhqCdYV8aPPNvKPUaBRDLtZUjlaW4OVk7d2WE3ayy01D/L8Ci64OdO7d28CcyNBeozE4sXbaRxGJXZxn64NhSSvdiLe1xY7SCGBtoRInMxW0MY+I8+eX1TpP3TeK1sKTFfXLUCSK6bMpRzCrUPWGvYhWZPWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNLn8D6l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757399445; x=1788935445;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Sc0AlrHEuuqIDsAMjno5tS1ebxOGfZrnDqw+DIZdtmg=;
  b=LNLn8D6lOw5FWUXuLag7lIo/of3PdNG2RIOoB+ZZcahdaeO/h8lAIJV9
   jF+7SkW1eIhUr2AsfzZd0vE0GxL1yR3TJzMXmueNNYZyrCGCcARXmsBq1
   rfEhZtxYeWxn7cyP+bdditI6Yv8XUTilYA0Jso1BJTDkgzlOckzr5Go9w
   2K2f3YazYxb+jNOyKtDEQG+dshTW8q5w/+OFi366ubcF2y2t+wbc9ny+L
   9b8UY7Rv8v9rY0zMHX/i1KHWBgGxk5hWLV4zhe58neOMHdMyGdt4FlqwB
   JLPBfkkYN7k+fWBRmtdVMxdB98c37iKNj0A/E2Tkdk8/TFsXzI0rBddM8
   A==;
X-CSE-ConnectionGUID: 0IJ0eIrWQmeGix/VzS3PqA==
X-CSE-MsgGUID: OROnWuWoQ6mNWC7hqt3qNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59819189"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="59819189"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 23:30:40 -0700
X-CSE-ConnectionGUID: 8b7+0R3bTxiChmjdVHjtog==
X-CSE-MsgGUID: 8IU7RMyxTCiPoIYkgKZcgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="172875206"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.247])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 23:30:37 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas Moreno <lucasgabmoreno@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Lenovo D330-10IGL: Blank screen issues with DSI display
 on Gemini Lake
In-Reply-To: <CAND3jMbggtne5+SL7h8Ojkv2yV1oqrBCTB2X55WB+_dkUJu5gg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAND3jMbggtne5+SL7h8Ojkv2yV1oqrBCTB2X55WB+_dkUJu5gg@mail.gmail.com>
Date: Tue, 09 Sep 2025 09:30:33 +0300
Message-ID: <44b90c861a01e509a52a31598d6b842cc6e67821@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 04 Sep 2025, Lucas Moreno <lucasgabmoreno@gmail.com> wrote:
> I'm writing to report a recurring issue with the DSI display on my
> Lenovo D330-10IGL. The screen randomly goes blank. I've observed this
> problem across multiple Linux operating systems and kernel versions,
> which suggests it's a driver-level issue.

Please file a bug over at [1].

Thanks,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


-- 
Jani Nikula, Intel

