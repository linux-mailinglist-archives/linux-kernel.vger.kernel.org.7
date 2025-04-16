Return-Path: <linux-kernel+bounces-605105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27727A89CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E0616FB38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3710292911;
	Tue, 15 Apr 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YAGw2JXX"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16E274647
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717942; cv=none; b=ndmY6NZLDy5yq1/mD+aEhTrmr91Xkk8prriLEO6Kb8VKndW+rZEE5Hz/45XRNQeH97ObLgLAtxxEye4Q6p+6sHNLuP8vPxXSfv31aT660TWY4stQAOJjZ83JcG19EA7Fcx6vFx6PgiUg+mpIie+Ibzn6CEBCtfzqUJ200KDOJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717942; c=relaxed/simple;
	bh=8b0bfQREaZimBBdltlkhUYeOFXEHlvpmNAAMN4qxJxE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tkrjYK4BbGp7ZyJ4nVS8LDvTyMGZmMmZ2Xcz1QNaW5xHEMB5btbaZA/Lau02Mvednfi36QWhfvULdfV+XIFDUznsSn90BhNPd7X+NPnI4ZMqrSz0CgK8N94e9VtSPFdiSYHobPivnVPz+lGiFmA3459oEivxScxkkcvE8VLMdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YAGw2JXX; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744717928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnJzPNFb5QOe3b9DnUSOoCVI4US185ClhULrkJL+DoU=;
	b=YAGw2JXXNdQhkuGmu15M44i7Uv0VfSOSfplHOnBkON4UM5z5DXnDedBF43ejAkbov4p5N6
	nemigiDJ92BReOcEC7ls8Z63tP7JDaPz45SMKVnY31Xs97TW6f+GmOnYsjgNruafMPy8Vb
	Gfk11BXa6E3pOEZtK9fiom0BuFoIimg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data
 with __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <9a0595a3-00c0-4006-bd54-99b938ee95bd@sirena.org.uk>
Date: Tue, 15 Apr 2025 13:51:54 +0200
Cc: David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C0A89B4A-14BC-48F3-9D0F-31C8C0AF7ECE@linux.dev>
References: <20250415090354.92211-2-thorsten.blum@linux.dev>
 <9a0595a3-00c0-4006-bd54-99b938ee95bd@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 15. Apr 2025, at 12:56, Mark Brown wrote:
> On Tue, Apr 15, 2025 at 11:03:55AM +0200, Thorsten Blum wrote:
>> Add the __counted_by() compiler attribute to the flexible array member
>> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
> 
> As documented in submitting-patches.rst please send patches to the 
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.

I just use whatever scripts/get_maintainer.pl outputs. Maybe the
MAINTAINERS file should be updated?

Best,
Thorsten


