Return-Path: <linux-kernel+bounces-730885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078DB04B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F43B765F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83627933E;
	Mon, 14 Jul 2025 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="RG7E6FCe"
Received: from mail33.out.titan.email (mail33.out.titan.email [3.121.9.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43BB672
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.121.9.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534045; cv=none; b=ZAD4kfXPwgEe4+nMVeDJRLu6RTuau+gxX0OHRZs2+CTBoMNm5EWHapJdjs8griUgXSwO0D1QL1Z9QafAVLaKAqtQeex6rhSi8/47ut6ooC3U8Aj643i2YsyZjFgzvOO8tDYs7m6v5S4Tavh53FSLYW/QSimpCTxBJfcyIL2lpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534045; c=relaxed/simple;
	bh=mBxjDrUbQD1x6VqP4FWLYwy535s+5JSHphJrpTncBSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhufE7xJ3/sz0cDj/OC4rA1n134Bo4vx+15xrG5EdlmAa86prfzPBJe7bWgs1QLxd8nMJsmQTSNdndK2+Z9HCs+cWZSqsn2zUoi5w8iTYlio7DQlrDbKC6ZRFSZ5TmQZzSAwBxkDyHTO1jAeeFeV9GZS3hF0KIxQ8Z920IU95IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=RG7E6FCe; arc=none smtp.client-ip=3.121.9.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 5F51E100007;
	Mon, 14 Jul 2025 23:00:41 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=NEswE8lcNVviMTE0ceVx7H70DTE0OxlkfoIzbX0ITvg=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=cc:date:from:to:in-reply-to:references:mime-version:subject:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752534041; v=1;
	b=RG7E6FCezwjOvsBtdHdTRAXbFiUxXzT4nkSvCPybGDP03aBY4NWxoWoLmJBnzGlCp3j0Z7Qt
	ZqUVkvubjtixB3StRQiA9aaDdF/eXlSPfR+b1OzEEOa4Z5VWpRVAOD+irf6cxWaVQy1Npbnbr4I
	NCkLVRnFx7gzpOAzPz89rZ48=
Received: from mail.blacknight.com (ip-84-203-196-90.broadband.digiweb.ie [84.203.196.90])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 7AA23100002;
	Mon, 14 Jul 2025 23:00:40 +0000 (UTC)
Date: Tue, 15 Jul 2025 00:00:39 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] sched: Use lock guard in ttwu_runnable()
Message-ID: <bd5pjkxlqhsbhipb2kjbug2ih3uomjbfcq3ojic6x22eadket7@phsejmiscj6o>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.703344062@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20250702121158.703344062@infradead.org>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752534041197128311.2332.6983245332994849159@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=FN3hx/os c=1 sm=1 tr=0 ts=68758c19
	a=+XWPlUOTt03IZrtNKHUAqA==:117 a=+XWPlUOTt03IZrtNKHUAqA==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
	a=R_Myd5XaAAAA:8 a=F9zcA1u9qsZnIuwwswcA:9 a=PUjeQqilurYA:10
	a=1CNFftbPRP8L7MoqJWF3:22 a=L2g4Dz8VuBQ37YGmWQah:22

On Wed, Jul 02, 2025 at 01:49:28PM +0200, Peter Zijlstra wrote:
> Reflow and get rid of 'ret' variable.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.732703833@infradead.org

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

