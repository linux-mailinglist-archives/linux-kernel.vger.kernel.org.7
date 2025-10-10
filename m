Return-Path: <linux-kernel+bounces-847614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0184BCB47E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EFB19E6294
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048719597F;
	Fri, 10 Oct 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S2eQDno7"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6E2868B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056309; cv=none; b=CzuSgerhaGku5HjxIn20airrtOigo+6yC6h0LuLPaPOKU+d5F62Tq9bsJGxFdzHbskLBUZlOcXn/mD6ofau0PfwQ1snQAsfiFdddULu+vPAL3aASNTjIIDn81OYTH+bay9MF5v0mME4EkAxCYNzpg/CJ+qULSCY/6wfMlm5NvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056309; c=relaxed/simple;
	bh=XmMwD6hz2XGhsUtNCVc6UkstcFwDnj39gvirmCr8xiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNZP2V+p66lIEG1OrhYqjIYECqjtn48E53SbCjul2NO5XZOSjiK6R4rLQBf3EQDbPv5bSH3/9wlKNhmQyJLHsECLeVbfd0rq26CigKi2j4lhTjWjAbW8VyMSbb+UA84va1DDOh7rL69rHheplBST0he+NkRcXInYd+5k5IIoQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S2eQDno7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 17:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760056303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COasMxXbWmot2wCffZuh9uIQ26pwWVgYk3t1yThZc98=;
	b=S2eQDno76eTArUZfcQ2wbw6L8HWA9gvcez0w3/XygcjzYbmQfmoI79GIBR2MpII72YuGw6
	NntkcfDJ4LnqXWnuqFasZl+1BMpwhm7vQkoBi+2sBOtv/h4DRLMUbFupVGsOGS3iXCT14K
	YwxUK24370qM7mip7NG2Tt2N4B/+pbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Usama Arif <usamaarif642@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, 
	kas@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime
 helper
Message-ID: <zo3ieot5a3n2qw3kv5iuzkrt4g3kbrkzrwtdlcshxk2n2ubbqc@yl7dqssisnfy>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009172433.4158118-1-usamaarif642@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 09, 2025 at 06:24:30PM +0100, Usama Arif wrote:
> This is a common condition used to skip operations that cannot
> be performed on gigantic pages when runtime support is disabled.
> This helper is introduced as the condition will exist even more
> when allowing "overcommit" of gigantic hugepages.
> No functional change intended with this patch.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

