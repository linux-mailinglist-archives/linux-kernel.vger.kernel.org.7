Return-Path: <linux-kernel+bounces-861621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50939BF3337
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6C54E5926
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB02D94B6;
	Mon, 20 Oct 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCcKn5Rx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAC149C7B;
	Mon, 20 Oct 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988376; cv=none; b=iE28o8m3NYRIpX9g69eKUXeeZyaR8Nj1drRbKXl7Rm6xJjEmEc57lroLVdFkqq2ONFyJm9BcANbi13+IUG3WM41lo6foU+kSPckbNp2lvLMlwFOpwzC+AtOfHhROUuNi3pCMcUZpGU9lMEu9g1kyAn8h9WXJJWrp/qbVPkc0ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988376; c=relaxed/simple;
	bh=ecV0+c2JurWmrBin/R/fLaomdyER5XlPsExaT7XSYs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1D8dDXbaty2uM+aOocC4z9OHkttEoH5lGxCGI4nNytRO1/n6B75aXADsfDhw9Ogd9k6aN6P3yUgFl+06rA4k7KcG7wawnXeazaEKwR2QGrJmRcEFNdJhD6J5MktQdF0D2ZMT6jjBWGV6leYrNZ+m0K1MOdHZDzv3AfiZ6IZCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCcKn5Rx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760988375; x=1792524375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ecV0+c2JurWmrBin/R/fLaomdyER5XlPsExaT7XSYs0=;
  b=YCcKn5RxtCryWg4drb37GO0kf2y0pEb6vzgZJYTGPAU8FVzc1uvMJazP
   iRXsfc/EFKAY82XbWlwOrWiKGcHGmsxS6SqyluU3OifWrdicGQvU2swgX
   kNkh86julhDfo9tGFY583QzzL5+NeZ5Zj3lo7GIuVVObaruueADbBZfsL
   ubkghCZV9dA6xwk1UNAbXRWvMkSXc8VeJHROgOPKECOHooe8K7/xPqsyv
   mmqWfyOU9paMcyfVhHdXxsw7DaSS9yR0Vh9gFF4bYh/wK1hRMg8Inc3uH
   8uDk7F9/I4kJy3Cm+imQy6iWidl46MF5niXbZSShojxPx2L2QQYA31nFX
   g==;
X-CSE-ConnectionGUID: YdEwt+W3TeiPDjKBbTqoQQ==
X-CSE-MsgGUID: SlCN5o69QLe6CMq3e0WHlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63029453"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63029453"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:26:14 -0700
X-CSE-ConnectionGUID: kAbcuyubQgiUplodBCgBcw==
X-CSE-MsgGUID: OwORjb7iRzuc2DifzI/I2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="183108523"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.220.167])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:26:13 -0700
Date: Mon, 20 Oct 2025 12:26:05 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jon Kohler <jon@nutanix.com>, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>,
	Brendan Jackman <jackmanb@google.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Message-ID: <20251020192605.yqg5mmvah2fzyjvu@desk>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <aPZZwoqWV8cJG2HH@google.com>
 <413D20D7-AB18-4D46-8128-6179F2565765@nutanix.com>
 <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>

On Mon, Oct 20, 2025 at 09:21:41AM -0700, Dave Hansen wrote:
> On 10/20/25 09:05, Jon Kohler wrote:
> > Was running into some testing issues with my qemu change internally,
> > but I’ll get that out this week once I clear them.
> 
> BTW, if there are folks out there that are working on things like QEMU
> and want more formal or regular notification from vendors that a FOO_NO
> bit has been added, that can probably be arranged.
> 
> The real issue here is that nobody cared enough to get QEMU to
> comprehend ITS_NO right after the embargo was lifted, right?

ITS_NO support was added to QEMU right after the embargo was lifted:

https://lore.kernel.org/all/8c1797e488b42650f62d816f25c58726eb522fad.1745946029.git.pawan.kumar.gupta@linux.intel.com/

