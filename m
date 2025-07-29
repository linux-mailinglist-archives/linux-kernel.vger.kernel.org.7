Return-Path: <linux-kernel+bounces-749557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A8B14FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E917A11B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612B2690E7;
	Tue, 29 Jul 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYO6xcbl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E1746E;
	Tue, 29 Jul 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801493; cv=none; b=ApMf/HNMwwik4CnPYDHb4ocIwjHIrAnEJpBClbBMN+wClNvgoA5125r7reG8NAZa+CKE5Pt2NmWlD9ZEm2cbpewOoY0HXzMtQmGTdn2PIgSirhdjgwfTr15mdjvWiDqIBbJQwDJJTFHNkv3soq/OJ3PPPnIVOurkJi5l9s8gpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801493; c=relaxed/simple;
	bh=aQ+43kvtdWDOizoWPKmefgnCVdEt6FTWqKjZuLuJgJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pvFUh+WsctIbk5IeQZXgXDXvpSC68hr+I8yRxI8N1j8Hu1OMy9IKmUUYBITyXli+Ukk64P2/0g7iOxYqVezgxC9+VIOXKDmPxET4uhIktTNbCYJOxMDlWxFm+AAEhOM49GBmjdLwVeD2kLVaTEECF+nh4g1rT148pjKqiZlOAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYO6xcbl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753801492; x=1785337492;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=aQ+43kvtdWDOizoWPKmefgnCVdEt6FTWqKjZuLuJgJE=;
  b=JYO6xcblofdX7BBxR8qZmn314BRp+n6E7bRNSP7z2f50lMkiF2d6Ns8V
   Ec0hn+sI7PrSsb3FLy9zB1uMg37HOnvuzrI7U1AWS4l8DJbHyTsIpu34m
   /seqY2ZiqBsgQkHf2RoguB9O1BzaJSa0hkRCN8rT4Gb9+j/4xeCN7w/l4
   xv0PRXvesMZ5L4ihHYz73Vy6tcS1USdIY2HpFp46t9gb3B9BfMATjEQ6+
   uI22+vl01iMzjeL4PX/YN1r9BIsqQgF45K+KlSI6UUpmf0/ef71nQI09V
   EHcIORLOPDGsUU0KtNzS9dDk/Rgq/X+3OyONGaCSkXvrxoBMPihMEvPTB
   w==;
X-CSE-ConnectionGUID: FNXFaidbSb6hLAcJJ9S8+w==
X-CSE-MsgGUID: VQDKQ9w1TNWaIuZaDT1xlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="67512504"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="67512504"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:04:52 -0700
X-CSE-ConnectionGUID: n0T4/5DqR+SRBpjQDi3s5A==
X-CSE-MsgGUID: zq7TZndwTJeEH5eSED3chA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="167215188"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.22])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:04:48 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
In-Reply-To: <20250729154437.6cbd2788@sal.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
 <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
 <20250712163155.GA22640@pendragon.ideasonboard.com>
 <20250713002517.7f52b0e9@foz.lan> <875xfhabv0.fsf@trenco.lwn.net>
 <20250724194306.27b98194@foz.lan>
 <83d12d5293e23c622ae390204fed8fd4453014b1@intel.com>
 <20250728173306.2ab1409a@sal.lan>
 <fd1372a9fb57a1372db5b3c0992a929f90183f83@intel.com>
 <20250729154437.6cbd2788@sal.lan>
Date: Tue, 29 Jul 2025 18:04:45 +0300
Message-ID: <9dc14f4a5adda5a8a40220404648457d56212cca@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 29 Jul 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> I don't think we should do much effort to support Python 2, but it comes
> almost for free: only shebang needs to be different, and, if the comments
> inside the doc contains non-utf8 chars, an encoding line.

As said in the other thread, changing the shebang is not a trivial
thing. I don't have 'python' installed, haven't had for years, just
'python3'.

BR,
Jani.


-- 
Jani Nikula, Intel

