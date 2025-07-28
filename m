Return-Path: <linux-kernel+bounces-747743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98710B1378A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BEF7A206F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1722222A1;
	Mon, 28 Jul 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDLh3FgZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC31DF73C;
	Mon, 28 Jul 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694934; cv=none; b=edTcOiT5P5xUmzty9tWiNE3WmBz3B2EuvCbnjP2WY99oYX3kovyv3zzZp2SV3z8DM1ehLKJ9oACbsBLFnql3x+lauDQO1LnAOCkw7jowBPFIR5CIl4VTrhMU9OcXaIlwbvkfAUklwbfeSSvg6HrC7Rv8/WztikxvwOBIXVHVmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694934; c=relaxed/simple;
	bh=pD/CntcXIRk9jjzKrGwbeKx5t7fkyTPoChELwMFLoK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTGxMyBUB3HvS/0bDIio9ZQVMJ9boHuBOWt5nA0SoJth4fDckguTdQd9liTNZ5mhDQL1e5XHDXdlnC/JldXXL2sWqivs0GfXHGQZQQT14QJF8KmPikaRiYdttCidG+rhyN7pM+GB8eOrFaWPWin//6N9q/lWfYfNZ6detpW0cEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDLh3FgZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753694933; x=1785230933;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pD/CntcXIRk9jjzKrGwbeKx5t7fkyTPoChELwMFLoK0=;
  b=oDLh3FgZPb2le7TgtZF9wP5B5Lgmc/GqFFKnp5FuPjDiuDZFK79Voop8
   K+Iqa1+ZefqoLV7rGiQ7n2V5DdWNYVnoj1i0QVaquq9US2o2a4obbrpjt
   T8G9RrVRfq5n2hc2DByxGnZR+INN0QWCEMyHxdLWyvPteXcj01gMRglHU
   NJv7iLnU0UGlxg4DYisrCp+hMCLvFcrVkU5trRWqDiGSmhudfZUCAhRSR
   Z3yA1bO6qVX4+9ZxVjezgXJfBLWzOtMhLHsMg3hcxNMtxcrWFqteXoXdP
   f0HXCWXecgY/1ZyJR+EI65pAeO5pNlXOXl3oO6Muu6jvSDnWefmhb5vkm
   A==;
X-CSE-ConnectionGUID: W9WKtHSBSuqTtE91dee3Fw==
X-CSE-MsgGUID: 9zylrluRTB+M4RTXuOtxUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="66640936"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66640936"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:28:52 -0700
X-CSE-ConnectionGUID: rOf7qErTT26cfmmC4yR9mA==
X-CSE-MsgGUID: OjycoPtBShWDCsst43NHGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161955044"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:28:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
In-Reply-To: <20250724194306.27b98194@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
 <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
 <20250712163155.GA22640@pendragon.ideasonboard.com>
 <20250713002517.7f52b0e9@foz.lan> <875xfhabv0.fsf@trenco.lwn.net>
 <20250724194306.27b98194@foz.lan>
Date: Mon, 28 Jul 2025 12:28:45 +0300
Message-ID: <83d12d5293e23c622ae390204fed8fd4453014b1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 24 Jul 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Em Thu, 24 Jul 2025 08:42:59 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> 
>> > Maybe I can place instead CONFIG_DRM_I915_WERROR.
>> 
>> I've held off on this series on the expectation that a new version would
>> come.  I guess, at this point, it will be a post-merge-window thing?
>
> Feel free to postpone. I have already a new version of it here somewhere on
> my branches, but I had to take some days off. So, I ended not sending you
> the (probably) final version.
>
> I intend to send what I have here during the merge window for you to
> review and apply post-merge-window.

I think the main questions here are 1) how to handle optional build tool
dependencies, and 2) whether Python is an optional or required
dependency.

It might be nice to be able to have an actual Kconfig and dependency for
optional tools. "depends on TOOL_PYTHON" or something. Enable the
option, and you should have Python.

This in turn raises the question for allyesconfig. It's cumbersome
(though not impossible) to add config options that you actually have to
enable manually.

The header test stuff really isn't required to actually build the kernel
or drm, however DRM_MSM does depend on Python for building the driver.


BR,
Jani.

-- 
Jani Nikula, Intel

