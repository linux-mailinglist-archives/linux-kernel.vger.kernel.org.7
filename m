Return-Path: <linux-kernel+bounces-800858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828CB43D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65631C80D08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A373064A2;
	Thu,  4 Sep 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g43JZu92"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886E305E1F;
	Thu,  4 Sep 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992194; cv=none; b=b+f3eIboGHyh0fb2lk0miyM3Br8UDkRN8JwHC2e3/V9xkGUvGYSCg/UkWlwq9HQBVLWfRHNcNZN9NLIgwsY3gh2jMBi49wDVsEOZ411TFwvsS2lgEaXtguH8BQ/KYa+q7K7J9blLTZJM0ArUC5a/FiJ9y/fvpc7S2C2JxlC17ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992194; c=relaxed/simple;
	bh=l9C0thl+GhJVIGwQEXfJLrj7YQDaOs7hR2zOArMDjyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O8kekcibz5bgpruf2bLvFLeyEdMZtEmPGcVOHDwDH+/d7E5GfJK9cTVYd/6m2MIAFboAlFJMMp2StNvaqEjDQ6V91AAUK/mZAOGJZFOrNnc3XlMcV4UhI0TIQh83g1ySx1A/Y6NsiTaIssXNrJdjqRbIqGmOLbD9BoAvfutPNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g43JZu92; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756992193; x=1788528193;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=l9C0thl+GhJVIGwQEXfJLrj7YQDaOs7hR2zOArMDjyg=;
  b=g43JZu92MptTRUcWEfBUIUcRds4xNHAabFuETNGfCZv7if77R8LGK+ay
   JIf3CcnlSgavkbVo8LYEjDuiRONTSY8HIAVfM/urjB8ko5qDiDphU3ie4
   EcaaseIr0uQ29Qpa2Ya96MHs7ytOvoAswQop8Gm/JBAZNQaOGCKFlZR2a
   /LZeFm9+V0yQyr6VliqZHn4csqWzlYaqy5wQhdyp5jTHqSc9TgUbojD7T
   NNh0PMTq2XX7oVLk/TaFVtsWi+hciNMPw/AqriJMTb74HU+MPWvm7VVu7
   /oPjsRG8ZDFl/nYJ6jv6SkPezaqVUcLwYCAVEJw82XwwaHb277//x+grZ
   g==;
X-CSE-ConnectionGUID: 5vvdsYK9QxqjHoTYA4CCoA==
X-CSE-MsgGUID: /Epa0eyJT7qWI8M7UU8Png==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59396737"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59396737"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:23:12 -0700
X-CSE-ConnectionGUID: xu7hI5RSRKaZrTFfy1inVA==
X-CSE-MsgGUID: sFcr6qc+SCuSDh3wBgSnog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202819401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:23:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: hansg@kernel.org, kean0048@gmail.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v4 0/3] platform/x86: think-lmi: ThinkCenter
 certificate
Message-Id: <175699218574.16699.13124325115196828575.b4-ty@linux.intel.com>
Date: Thu, 04 Sep 2025 16:23:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 03 Sep 2025 13:38:11 -0400, Mark Pearson wrote:

> Patch series to implement certificate based authentication on
> ThinkCenter platforms
> 
> Patch 1 introduce a certificate GUID structure to make it easier to
> support different GUIDs for certificate authentication
> Patch 2 implements the changes needed to support ThinkCenter platforms
> Patch 3 adds some extra error message handling as used on ThinkCenter
> platforms.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: think-lmi: Add certificate GUID structure
      commit: c778f7ac13d5e94db821cf8e1078aa318cc15460
[2/3] platform/x86: think-lmi: Certificate support for ThinkCenter
      commit: 07b93b747cb713478991388b3d55c3ce9267e037
[3/3] platform/x86: think-lmi: Add extra TC BIOS error messages
      commit: a0d6959c345d89d811288a718e3f6b145dcadc8c

--
 i.


