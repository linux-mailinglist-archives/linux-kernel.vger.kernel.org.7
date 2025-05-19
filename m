Return-Path: <linux-kernel+bounces-654653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E37ABCAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 00:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0498C3ACDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A921019C;
	Mon, 19 May 2025 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IImoJb/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182471A2396;
	Mon, 19 May 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693917; cv=none; b=VZpliPRCLYDoVHASX17H+QlyFVulfjZbvOWD6far5wRmGRJMiD4xOkNCx9cTAolyJQkZprQpsn7qHKQP8xNRsFTFQ3uCeAyb5NRq6b1Xad51MkxRr2jEtlVRIWFmyg08RB9xjECWg7McPUv9vqVX1eQJDRrhIVyj7xR6XKczeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693917; c=relaxed/simple;
	bh=EHns4IUgtFSetCSEhkxVR4ARJ8BTb1nVbBAUd4Felkc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=baa8oozvXYA+5Bepo14YeM2q+9jOW3PLmGc08nSDZN/C8o/LCmiFMZ24zNxETxeIfaUcqACpNNMfm2dyBZAfa/T6frpmBnlL0Hh000ghEo4nxRCqP2wU/1U9qxA5eoCQWIF7o805d84NkBXSobUtN/r0rnPpNrtqJ9FMBPVm+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IImoJb/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF248C4CEE9;
	Mon, 19 May 2025 22:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747693915;
	bh=EHns4IUgtFSetCSEhkxVR4ARJ8BTb1nVbBAUd4Felkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IImoJb/K2b4ePmgHgLChQ3z4PTI3Al3Ab06S/6oCFlLfMqRvzI/HvyRqXbVs50DCg
	 fnVcoDw0ZgX1sm2tPnUSVcvqG/7HPC6f6KfbdTbj9Ychy7SF6JM0Q3m/6gtaKPgfoK
	 9KzjEmBZb+4fft/tNk+qiG236QzBZxTVgdU4qnqM=
Date: Mon, 19 May 2025 15:31:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, ying.huang@linux.alibaba.com, honggyu.kim@sk.com,
 yunjeong.mun@sk.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 lenb@kernel.org, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 osalvador@suse.de, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250519153154.6eb14de35a632cd23bdcc11d@linux-foundation.org>
In-Reply-To: <20250519015606.378475-1-joshua.hahnjy@gmail.com>
References: <20250505182328.4148265-1-joshua.hahnjy@gmail.com>
	<20250519015606.378475-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 May 2025 18:56:06 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Perhaps at this point it is best to just send a v9? : -)

Sure.

