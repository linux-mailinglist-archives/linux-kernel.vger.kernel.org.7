Return-Path: <linux-kernel+bounces-651317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E075BAB9D12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFAB503B15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9614B1E4A;
	Fri, 16 May 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTONgGAq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383812E7F;
	Fri, 16 May 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401461; cv=none; b=Exeh6ihxYwQ1Wy1qsEZZ0XxAkWvMl51B6lT1+qLspDcVy1MJkT8J9D3hG2HkqkNLGNADkAmMAx48SCKnbXJLlVkP7TxUED++CuiE3GMJE6TH3B80nxyLSchcNXueV6AQLFuuyGCF2yKdvzTpjh3xZPW722nOYYCeh/fcXhWadTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401461; c=relaxed/simple;
	bh=rVeEmKln0gNTxsxDZ0s6DRl00sLdCRCSPPJjd26+MDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRrz2GXgxrPyxXWFTgl7oUCO3P+XIQGuFs32APnu3wi/xeeyyfgM+LfTcauGw8dJrOvJYGGxGZUZgjDc7V2I1Q9fKbbyol/JQBFUNAbcKHXYjAZu8hizSCdmbLvq3clPctIqiL1vKHRvoMi8msFBWfbFcMbOiE1pxTKplwSbFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTONgGAq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747401460; x=1778937460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rVeEmKln0gNTxsxDZ0s6DRl00sLdCRCSPPJjd26+MDE=;
  b=bTONgGAqVQ7ewUyjwdvs+lwBbflSAfsIWlk7cRra1byyQMw9Q8ZmHZip
   peuam05vfLk18pyN3BzBGXZ4Yzv8L/jifU3EpkjkfmJ1vpMvXoXnjPhaS
   QhOcDbnf1TrmjFl86j87Cwjzczg6B2yl6OqJSZ0d56Tfoc69uObZh+ilz
   Kiuw81U39o6Ldp9AA9bcABA9oUavgdr7mvMIK7PNETf6gxp64lXd1P1ua
   uCpvrDTAXt7bDNXLbqXGYLbxzRDX+X++l8Q09tH88z8bQ2C7l8ozi8eIf
   NI73bM2uf4r5O7L9H+PKI766yh3jrPZwreWFdiNIzb/0ihvkg74obX7pZ
   Q==;
X-CSE-ConnectionGUID: 7otnPEuwRAONIrJ16ZV3Cw==
X-CSE-MsgGUID: gewe6C/ERRC1ejwdJ2dhdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53045003"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53045003"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 06:17:39 -0700
X-CSE-ConnectionGUID: 7e9q5ZeFSxW+0LvW/hgXUw==
X-CSE-MsgGUID: 4VIMYbnlSKqD9Ot6qaED7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143934000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 16 May 2025 06:17:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BAD1A1BC; Fri, 16 May 2025 16:17:32 +0300 (EEST)
Date: Fri, 16 May 2025 16:17:32 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Juergen Gross <jgross@suse.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv3 0/4] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <rdbzqwmbjel6oiy6db5l6tgu5bzbwdni5gi2q7p7nmr24dwo6m@3vciui3f2ws4>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
 <aCc5cm_ZC-y9OnyA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCc5cm_ZC-y9OnyA@gmail.com>

On Fri, May 16, 2025 at 03:11:14PM +0200, Ingo Molnar wrote:
> Does this approach sound good to everyone?

Sounds good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

