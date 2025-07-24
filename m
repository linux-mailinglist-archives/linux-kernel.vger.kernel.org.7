Return-Path: <linux-kernel+bounces-745000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C5B1139D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB755A2D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53F22A808;
	Thu, 24 Jul 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LxqejKLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39223BCF5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395037; cv=none; b=NRPao5WerTRzBJrL5Vw4PnN1SKuh7CimtyJfXZ0FhUl65YirO3jmOOSeZaOUAndWsvbK6Wc5eExKt/mTSkUp8uIHE+ACXMT0x+MElMglkad94Nbvg6hq9+kzzzg4UJhcDXinP6DN50VgtAHle1dKpgQU1mr+0xhOVYoxIaCfmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395037; c=relaxed/simple;
	bh=TNnLDIq21qsztRWhB2H8GUnroBWBk5YryXZ3YPgkilU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rj+IG49PzoEHaH+pUA32hbBleDRAwUdrPCSmx/1dXMHqDpYpe3M9a7uGIfngqlZ1MRPlb831t3ePAn2FtoiQLhxjm9+jcP3Ll3UzVyzecwQcxxZYpjgCxWYJYWQDkK/X66g57ALBIPfh4LrYainQjVs6zYGWBD/6oUhpZaYsLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LxqejKLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D287FC4CEF5;
	Thu, 24 Jul 2025 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753395036;
	bh=TNnLDIq21qsztRWhB2H8GUnroBWBk5YryXZ3YPgkilU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxqejKLTOrjfJlTdd8QtRgq8O3+ZV5i/Xx6TN+4619+k3cK4CbQ+zmWrehnKzGwXu
	 Lqr060kOgt0mT+KylJQ6A9ONo79h0DQ9kny2ZHtd14LWGv+121HU0b4QHzOK17SDCF
	 7XlCCxvlNo/iMkPXddeaY7PgWY7tmjQYRvWlO/oU=
Date: Thu, 24 Jul 2025 15:10:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Ye Liu <ye.liu@linux.dev>, Ye Liu <liuye@kylinos.cn>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hung_task: Add detection count to hung task warning
 message
Message-Id: <20250724151035.cc2d421d1b1ed20b89be1917@linux-foundation.org>
In-Reply-To: <bdd8f5de-acd5-4c09-b3a4-ec6af54b396c@linux.dev>
References: <20250724072326.2031432-1-ye.liu@linux.dev>
	<bdd8f5de-acd5-4c09-b3a4-ec6af54b396c@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 20:06:52 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> 
> 
> On 2025/7/24 15:23, Ye Liu wrote:
> > From: Ye Liu <liuye@kylinos.cn>
> > 
> > Add [#N] to hung task warnings to show occurrence count.
> > This helps quickly identify warning order when multiple
> > messages appear in logs.
> 
> Hmm... once we have this number, what do we do with it?

Yes, adding to the changelog a more comprehensive description of the
use-cases would help get this patch into Linux.

> While I totally get the desire for a quick reference number, my thinking
> is that the hung_task_detect_count counter is the intended and more
> reliable way for users to check.

But that's what this patch does?  Confused.

> But like I said before, let's see what Andrew thinks ;)

Andrew thinks it's a pain when the title of a patch is changed! 
Fortunately the changelog had a "Link to v1".


