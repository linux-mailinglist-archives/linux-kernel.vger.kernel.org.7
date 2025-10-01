Return-Path: <linux-kernel+bounces-839246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F2FBB1290
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4BC16A1FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646A27D780;
	Wed,  1 Oct 2025 15:45:30 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9F1459FA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333530; cv=none; b=S2THxEuEouzZI0pyQzWqfxruQrwxKLc787SUXl5eijy28WV7SGkzb4bm1sD9UhNzSGLwOL8437JSDl7fXPVcil5Vuwy7l5NELb5mRbwjAcikTfze0OY1f6xcHwWPdLLJ+2VfRIu6ghwIAfHOx6T3agDJR+od8p8z6A5Yc3wsjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333530; c=relaxed/simple;
	bh=l3+j1qBtWVeJbLqlOoYwmRcgTQWLmfgBE3R7wFAstRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBeBeApa/boXSkvRyYyX/QbrLogJvbb4w+Q/xngSSlgTVaa897fZLuPnvKrkacl+Au33DlePsPGl81dVC7/h4bddEDUzNhPWqQ0ZwM8ubYEtKjAXHYXSr6C95nE1M0FLr4JCi5ZEN8tqmcIMr5J9iEHNCKnTb1CMUcHIaFuMWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 6563BC0166;
	Wed,  1 Oct 2025 15:45:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id B6A1F31;
	Wed,  1 Oct 2025 15:45:24 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:47:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] unwind: Make unwind_task_info::unwind_mask
 consistent
Message-ID: <20251001114702.06e2b1d8@gandalf.local.home>
In-Reply-To: <20250924080119.384384486@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.384384486@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g158948skhodmx6tbwzf39gubiss9f7d
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B6A1F31
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OMW4XSFp4Dig02OXKk246amWPi9EXI+k=
X-HE-Tag: 1759333524-461601
X-HE-Meta: U2FsdGVkX1/zVpPXzhVGhC4Y+71/FCLiJlnm/QiGd4rgK0kGR4FcS8p5zKH7IEMeqt3Dz4eZT85hCeB6PvfDKatZ9mkFGo8v9JBrEiI7oWnQLd0Bv8qvgE0wwgsjVl9mZNDSTkjGMHEHZJooLP1mL6JnrL1/aEipRUWB9WaWJF0bGfiOgVuz9K4/++CITy51cPeHkHQPHkb6KFUzAYViQ1KKLdLwHJqWPVVLn6vw6zYPLPPfRv4g2A2puKTgdNUiHLxjiMl+umRAiPv8KXF+p9nfcUXA6jnzbNKh1g4X/auUg2lbU71+MwXPQYVeAf6TFzympqBbpiuEdXALRevRDTy7HZHKkMguNaMzZb9SO8LbGZjp8TfT+HB34EhyY+44

On Wed, 24 Sep 2025 09:59:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> @@ -324,7 +324,8 @@ void unwind_deferred_cancel(struct unwin
>  	guard(rcu)();
>  	/* Clear this bit from all threads */
>  	for_each_process_thread(g, t) {
> -		clear_bit(bit, &t->unwind_info.unwind_mask);
> +		atomic_long_andnot(UNWIND_USED,
> +				   &t->unwind_info.unwind_mask);

Shouldn't this be:

		atomic_long_andnot(BIT(bit), &t->unwind_info.unwind_mask);

 ?

As BIT(bit) != UNWIND_USED.

-- Steve

>  		if (t->unwind_info.cache)
>  			clear_bit(bit, &t->unwind_info.cache->unwind_completed);
>  	}

