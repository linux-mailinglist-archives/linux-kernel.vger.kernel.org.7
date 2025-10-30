Return-Path: <linux-kernel+bounces-878765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C792C216FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9879D4620F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5DE3678D9;
	Thu, 30 Oct 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLix9qRb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCE1F4176;
	Thu, 30 Oct 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844478; cv=none; b=DCZZWKU+cp3ybmqMoQdN4VLcxxQm2IW8B4fP9r5F2aIK5u1irf8O7r/1dIO5YjUSLJgx5B2LFclPo05svaIZ+IVR7qEScdXWK7yuYXO6q8vq+IbIKfhAj4HJhxlIAiEn29dNeRxxjRkWGakLE0VnVa9qERW835bkSkIj95VmoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844478; c=relaxed/simple;
	bh=Yixu+s8Ofyo/TKa/DCpqVsKFp673UhdjdxL0UycCRIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r92jmH/UaZ8zWZ03keXosctuEPKYapKvkhhLdWwQwfkwu3PlMFtxjpU9rGRFnIO5KMUa0RllRNWjEPQqIGAv2Tzq6Vb9pjmfGbJY9ihVssstFb6ozKU+v4sOqbzkDX+94Lp+BUy7Dez6sUCJIhuZHU+Kyd2PaKLHMuqEtgMz6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLix9qRb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761844476; x=1793380476;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Yixu+s8Ofyo/TKa/DCpqVsKFp673UhdjdxL0UycCRIY=;
  b=aLix9qRbExjZhG3ZJoAnelKOHHdT12kRTevWENoYVKVAURfLCmy6WrIR
   jKapiuRn+2y1B5+ZlHmJ6s0weyU7nwD3JiP/ZrlVccCG+RTq7ODo5rlNA
   QQKqVPtL6Nuor3JBi2TOL/kMuicBBaZRCIiwPnt4/O/aiAgCBi8IeejWB
   7S2ZXJpzBban1U2w1eG0l51i0F6eEonKl2h5huFD0u7QYI/DkY2aeWPab
   PSi3wLRUgk8+DAOWrYQy6b/IPbUpqm7XeWdKhvHLsKnJAA/FrSjkXqBoF
   djEf7Pt2FErce5tBXsbY5JhLYopKhYp+DXzKt5ZyoO2UdDTtmz5UK/1XK
   w==;
X-CSE-ConnectionGUID: xj3YeJNaSRKPIvN1kFzNTg==
X-CSE-MsgGUID: E9JfJdUlRN6TxA0Owsyecg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63899838"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63899838"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:14:35 -0700
X-CSE-ConnectionGUID: A4Qd4hLxSZCzcdqqH8usmw==
X-CSE-MsgGUID: 0EEY1XgXQrOWHebGSnDhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185699891"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:14:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Konrad Dybcio <quic_kdybcio@quicinc.com>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b25c9842-7ebc-43f0-a411-8098359f81a6@web.de>
References: <b25c9842-7ebc-43f0-a411-8098359f81a6@web.de>
Subject: Re: [PATCH] platform/surface: aggregator: Omit a variable
 reassignment in ssam_serial_hub_probe()
Message-Id: <176184446742.9294.15447762321951594673.b4-ty@linux.intel.com>
Date: Thu, 30 Oct 2025 19:14:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 20 Oct 2025 16:43:16 +0200, Markus Elfring wrote:

> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
> 
> The source code was transformed by using the Coccinelle software.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/surface: aggregator: Omit a variable reassignment in ssam_serial_hub_probe()
      commit: 6581e83ea65dc117f8c5cae1089550fe7e779cd7

--
 i.


