Return-Path: <linux-kernel+bounces-811442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE6B52920
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6684A1C813E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A8262FE7;
	Thu, 11 Sep 2025 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr0JzyW3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CB221F0C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572789; cv=none; b=QrFZ68v/orjbJYZUtIbmTkS0xDXxyo4+JnFyo3cf5Mc6bxMzkfLDHGrVxw3b1TvGxP/5gP6yJOiO/QtHqfpha5c00qxAn9ycRmSBbnOyIa6RW2oXHO5rp8TbvQMnwz4vWI6GcIydzZ9UNBx9GEyJxUHtrVV8dk2KoSGfVLoIPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572789; c=relaxed/simple;
	bh=L8o32onMABOVp8/pkTZQw6vQLL93zFnmSTrzqXO3azc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLZGfBvJx5BPw1fmJWaK3tjAPtzgVWkZhJpZpkoP7u6Uu+2hwJRopL6GlEr9emzgwFrxsgXyzfTxPMXakNa61QNwd87y3GnpYVqmmzLrqPgrPjiy++QYlb4cMdWcqdWpj+7VBDu81FYiJa1quPlY05n+/QcyLwcHzQ45Ujwx840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr0JzyW3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757572788; x=1789108788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8o32onMABOVp8/pkTZQw6vQLL93zFnmSTrzqXO3azc=;
  b=lr0JzyW3AXxX1rOVoEeeR6ojPQkqwEWxzOn0JgF5dpjpzhR9u587zs0r
   +Tj9rFLrI1jQfllg2HdQlpphyvrE17ZjKkW7y4YEUIqqH0Pg3LZRVwru8
   31K9N6ASC+bttwKCzItkRT8l38C0YeoXANwv8HMvH2yUN4PmA1iS5ra0D
   5Mr7xUGqa3X3nByQtxRxqxAjgfgL9qaaRPv3Nmx+uuovkzb0kzVIDQ8Op
   X++R1kgSrMrCk8WPEWkzFggu3CXlyx8WeaY0Z1lnfIqdEzufqhSgMZGB2
   f0XM6vQRX2TVg/zWle6P6gjGBO6D17hzlrwptKT8/FkwdrhGNflBFIdRZ
   g==;
X-CSE-ConnectionGUID: CMiGJplBSOymxXQBYcerOQ==
X-CSE-MsgGUID: 4qeITTBLQBKPUlS6b4c+LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59842024"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59842024"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:39:48 -0700
X-CSE-ConnectionGUID: vcqDcBWNTtmy4rKFSLeppA==
X-CSE-MsgGUID: coSGbHPFTsKZMe9zH+yFNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173182969"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.180])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:39:45 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8423C11F83D;
	Thu, 11 Sep 2025 09:39:42 +0300 (EEST)
Date: Thu, 11 Sep 2025 09:39:42 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Martin Hecht <mhecht73@gmail.com>
Cc: michael.roeder@avnet.eu, martin.hecht@avnet.eu,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v2] media: i2c: alvium: Accelerated alvium_set_power
Message-ID: <aMJurorR5MfCcVQV@kekkonen.localdomain>
References: <20250909112252.2577949-1-mhecht73@gmail.com>
 <aMGUoQMGZ12oBnpa@kekkonen.localdomain>
 <7f095cde-cefc-4259-9f7d-9de17c12758b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f095cde-cefc-4259-9f7d-9de17c12758b@gmail.com>

Hi Martin,

On Wed, Sep 10, 2025 at 07:17:01PM +0200, Martin Hecht wrote:
> Hi Sakari,
> 
> thank you for your feedback. Please ignore v3 because overlap. I will adopt
> your proposal and send v4. Nevertheless I'm in conversation with Ricardo
> because some eventually misleading feedback from CI to learn how to deal
> with that.

Ack.

> > 	return ret ?: brcm_major ? 0 : -ENODEV;

Actually -ETIMEDOUT is probably a better choice than -ENODEV in this case.

-- 
Regards,

Sakari Ailus

