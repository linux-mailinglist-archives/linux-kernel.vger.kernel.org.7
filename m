Return-Path: <linux-kernel+bounces-811819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE603B52E48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181451BC748B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD953101A2;
	Thu, 11 Sep 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juZ+ZaqW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFD2206A9;
	Thu, 11 Sep 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586515; cv=none; b=CX/IxqqIRD1upnDfomrYCfAHzxRxjB97NG4AUtFqwkcRZkdhaEYFNdLyf0c4kVjmFP69qMvEKUb6aqW2rrB3P51YG+DjRT96OhPCp/wFZ58qgUL9BBnezEUjJMu0UHemyu/5tcaxrqBpY+rzBXXFbgkAIH+3ksiORKbj5msgpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586515; c=relaxed/simple;
	bh=4mdqsA9BzJF/pZg/fnVA3G+Thh4lO9JU6WzDhpS/kco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJijk3uKiEhTDHbS+TfnqjHbCm/EbvyGP+xI3Yee2SwemeEu/bmlyyRZUlx/7fXqrk8Yo5+2xOyUAhwzZr91kT+vmL85YDc7E1iWd//NvmBIbMX/OwA4Hm5eqiRMRUGQz/psi7MPMXPt5cVGGRCTKY3Fcbn7JwYjw+dp3verf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juZ+ZaqW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757586514; x=1789122514;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4mdqsA9BzJF/pZg/fnVA3G+Thh4lO9JU6WzDhpS/kco=;
  b=juZ+ZaqWTMy/DKR/jY0hqfZsQAXpmp51tFgzKH1thg95V0jJxkG1mida
   +KfX2d+d+EzCGf1sfNdRYUZGpe3vmJMEYvf/RsmtqfpsFv6cXAq7/oRl6
   clOo1LBH6nPhwesaoWrZI0SFbRxr2XwH+ymA9J3ure9mAUp4RXRXY+nlC
   UdggkmxLoVTuCZwGLCxbK1wGipn1VmkFOUqJGysqy6vXc6pFKDCEiE7g6
   MrrV2A3WbtyzYe4VRxLJLIzh7jiMCCFZbmhqlmO4SbTXaqeKSEBZNglCc
   lXfE1wfCdcqC9P9naWlo+VYt22gibyIZGLBhA7+dZe+0XBTqIG9+E0vKx
   w==;
X-CSE-ConnectionGUID: lw9RAueSTRWm1B8YTPeQog==
X-CSE-MsgGUID: iKM+93bURmmVn3Ui+ED3OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="85356537"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="85356537"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 03:28:33 -0700
X-CSE-ConnectionGUID: NgzwDza4ThaqBgE10jcOIg==
X-CSE-MsgGUID: ZYcUKkyIRE+1lCbHSGefbA==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.136])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 03:28:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] tools/docs: python_version: move version check
 from sphinx-pre-install
In-Reply-To: <20250910142427.61347215@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <784ca5070326558220cc275deaa046a274badebe.1756969623.git.mchehab+huawei@kernel.org>
 <12f948d2bb995d9321ce07d8765e00bcbd822402@intel.com>
 <20250910142427.61347215@foz.lan>
Date: Thu, 11 Sep 2025 13:28:28 +0300
Message-ID: <62eddeec2ac82b6631957a8ce1dea330fd6862f7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 10 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Em Wed, 10 Sep 2025 13:14:33 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>
>> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>> > +        # Restart script using the newer version  
>> 
>> I thought the whole idea of restarting was completely rejected by
>> approximately everyone?!
>
> This patch is just moving the code. There is a patch after this one
> changing the behavior.

Shouldn't we fix that kind of problems first, instead of refactoring?


-- 
Jani Nikula, Intel

