Return-Path: <linux-kernel+bounces-818116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF6B58CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443A02A66F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58175238C19;
	Tue, 16 Sep 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ffhRuEUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A82A1CF;
	Tue, 16 Sep 2025 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757997196; cv=none; b=h5jhlm4d2v4hDszVJtNOKFL8csewvuu3zZh58Tu3/qT+mJCRZ0K356U1tajb41tZZsLyQoyqvyEaOLlAXrXr3U+GzbUxz9FVC2glVKZsWs3TWMkzQEW1wzqMl7CaUHObP+y9fg5jXnWycjEe5bniT5Eh5P216/JUYgmVJp4GcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757997196; c=relaxed/simple;
	bh=RFJkSWDFhqm9IbEFagXwquv4UPK9KKARrTLze/LmtU8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bk6jwgt/qtatlvuo5tOl4nf3JdOm+z6syT0F/WCFc3U+MoiwY0fXAFxQ18N7RzscQGvUGwoX3OmazZ2QS7dP/QQ1z/42ajKVtBzu6bty0OabFpHyDQb7t0IiUSYGE20b/VUXtq8DODXn40BwKUe4TrQ673IGrOJd1Ohj3K6EIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ffhRuEUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB161C4CEF7;
	Tue, 16 Sep 2025 04:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757997193;
	bh=RFJkSWDFhqm9IbEFagXwquv4UPK9KKARrTLze/LmtU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ffhRuEUSl+esw54iNYqPLjXZkB7pm9/qU6PwF7PfqZ0m7i4oOU94h54q9jAHt/nS4
	 s+f9QUzJNC2ahUAeHoEjZ3N44lirm2epKio2vvbtZatpjoIm0CqJ1pGpaX0G3knn/D
	 6VCEkQjCFe6KZvDs/IDzmvGpZi1wTL3t2fx/haT8=
Date: Mon, 15 Sep 2025 21:33:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: define and use DAMON initialization check
 function
Message-Id: <20250915213312.12892156442f3a795a0a01f5@linux-foundation.org>
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 20:35:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> If DAMON is tried to be used by its API callers when it is not yet
> successfully initialized, the callers could be crashed.  Such issues
> actually happened and were fixed [1].  DAMON API callers are therefore
> having their own hacks for seeing if it is safe to use DAMON or not.
> Those built on an untreliable assumption that DAMON should be ready to
> be used on module init time.  DAMON initialization could fail if
> KMEM_CACHE() fails, though.

Wait.  Is there any realistic expectation that KMEM_CACHE() will fail
when DAMON uses it?  We do have the convention of assuming that
__init-time allocations do not fail.  If they do, an oops or panic is
an acceptable response.

Are these problems actually real-world demonstrable things, or has
someone been playing with fault injection or, ...?

> Also those are basically duplications that
> make their maintenance difficult.

Unclear.  This means that the client hacks are no longer necessary after
these changes?


