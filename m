Return-Path: <linux-kernel+bounces-787206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7BB372FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67215E69D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB63728AB;
	Tue, 26 Aug 2025 19:21:54 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBA2D46B4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236114; cv=none; b=ueyIWmHMraUvOn/s6oDcA2N3YFLmoSPqtxGGFgqbmoaBMQCPO7/eJG2bGTwzodweWd+nbaT2K4MA7EXX1FkerJ0wvjk7Tlpw3fwqxOk5zxYBEdK9TuT8SAp1Wl8Fy5Yvak/M5UtqkV74LB22AQpcLcplxoUPZ29vvPW41O87bK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236114; c=relaxed/simple;
	bh=6M8YSacVnldoBP7xbTOhFNfCn0JjOCt/FNTX9d4FiAI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5cMKBOWMQJ0Q0Z9CkxlJMqkFuvIkvuLlUX+KR/xqx1cjpnCesVJ3Sr3lfQPJP9+4fZEB2Ped/U7IfS19oMPa9VcAVqUFrm2HKQrIO/gXOWOWj8cTFg4YdZKEtvVsBg8GvZ2NXmQa3L+2kC+ucVhASKeEVTnCDOGTJp7cWr+8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id c0ceb352-82b1-11f0-ab53-005056bdfda7;
	Tue, 26 Aug 2025 22:20:40 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 22:20:40 +0300
To: David Arcari <darcari@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel: power-domains validate domain in
 tpmi_cpu_online()
Message-ID: <aK4JCK8q-Kf3dS-w@pixelbook>
References: <20250826164331.1372856-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826164331.1372856-1-darcari@redhat.com>

Tue, Aug 26, 2025 at 12:43:28PM -0400, David Arcari kirjoitti:
> Although tpmi_get_power_domain_mask() calls tpmi_domain_is_valid()
> prior to indexing tpmi_power_domain_mask[], tpmi_cpu_online() does
> not. In the case where a VM creates non-contiguous package ids the
> result can be memory corruption. This can be prevented by adding
> the same validation in tpmi_cpu_online().
> 
> Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU mapping")

> 

Shouldn't be blank lines in the tag block.

> Cc: Hans de Goede <hansg@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Tero Kristo <tero.kristo@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org

Can you keep Cc list below '---' line? It will have the same effect on emails,
but reduce unneeded noise in the commit message. If one wants to retrieve this
it is available on lore archive.

> Signed-off-by: David Arcari <darcari@redhat.com>
> ---

-- 
With Best Regards,
Andy Shevchenko



