Return-Path: <linux-kernel+bounces-883612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CFAC2DE15
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCD04201AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A99296BB7;
	Mon,  3 Nov 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI4IEceT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488126ED31
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197456; cv=none; b=mcbbTFT2FZBhZ7Mq1koa3l6MXeCC6HepVVvFQv7dgbftUPGOkiJoWD3rv05bQp5wMGsdghQ9plvALlIVjh5cKmvRxlW105L5pPugXbWyXDH/rDqonV8K+Xp+bP589ZZxz1A0sMW5lkCOXUYVyzbe6nB3uoWOYr9OFit1vvWI5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197456; c=relaxed/simple;
	bh=ZdQu9jWeg5RJ3g3Vn7fsPI9e2L5ti/jaJi2n3TjztDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhXTWFjGWCsT4Nq0HO8AC6+Dy51coZeBBs3yPTc5dGiCy6PkCF0AeazsiXRPTi/nxgSFFiE6XbW+b9KqDM5SDr5krm3+JNSQi0jxi1GaJvJxpRvqGQpYJcUwmyzMGPFSiFDwljLUTqVGhyqs0BvKiFuBsq3gghKiVgAXr5WryxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI4IEceT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762197455; x=1793733455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdQu9jWeg5RJ3g3Vn7fsPI9e2L5ti/jaJi2n3TjztDg=;
  b=GI4IEceT3JfWCraZG+Wa7u9+eNsB2hfOb2hojvBPaVokeq/oaPXHdNhr
   vXk7h2AjjUlD4gJovRHJ6OBYsHRuxWoEY4mYzzMt3iHQYYmBwE/KGcxRc
   wBs8nhP+zGx6QwVvPe81AapovnKfGqUtNAsuhL01YPyxsi810eJjuYy45
   cwMNSk8Ag8yX0W48OJ46jmrOwV2UXI8S8dhE/k+iBilHyGV400X6FWIF5
   tqqAyMcmZP1lXdKGGGTGZW7vgQ6lqVDN0s2Tijyui3PlbvXqo6szpNybx
   W01o2oMlChLmamEHuLBEmZpMjodXWt0B7HAN1DTttbYwERQPV3i88cI/j
   A==;
X-CSE-ConnectionGUID: blajTX8CTByJ2t+Y0NbakA==
X-CSE-MsgGUID: ku+AjgrOQs+KEJ1CjVf5GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64169642"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64169642"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:17:33 -0800
X-CSE-ConnectionGUID: T1h0BkvHTouCBCid8I+S+A==
X-CSE-MsgGUID: z+Eg9sO0R8mYDwDt2vM18A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186635625"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:17:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vG03T-00000005FP1-0ds0;
	Mon, 03 Nov 2025 21:17:27 +0200
Date: Mon, 3 Nov 2025 21:17:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v1 1/1] base64: Unroll the tables initialisers
Message-ID: <aQj_xgm5_dnyJ2cc@smile.fi.intel.com>
References: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 08:05:10PM +0100, Andy Shevchenko wrote:
> Currently the initialisers of the tables have duplicate indices.
> This prevents from building with `make W=1`.
> 
> To address the issue, unroll the table initialisers with generated
> arrays by the following Python excerpt:
> 
> CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
> 
> def gen_table(ch62, ch63):
>     table = [ 0xff ] * 256
>     for idx, char in enumerate(CHARS):
>         table[ord(char)] = idx
>     table[ord(ch62)] = 62
>     table[ord(ch63)] = 63
> 
>     for i in range(0, len(table), 8):
>         print (f"\t{', '.join(f"0x{c:02x}" for c in table[i:i+8])},\t/* {i:-3d} - {i+7:-3d} */")

I haven't added a Fixes tag as the idea to fold this to the initial
contribution.

-- 
With Best Regards,
Andy Shevchenko



