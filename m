Return-Path: <linux-kernel+bounces-734342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E4B08066
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F116F1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66226CE2F;
	Wed, 16 Jul 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RJ5feXq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52544B660
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704380; cv=none; b=GD07SB8PgRAt0o+FGBz5di5DhrfX7jSTC8I+nUigFlJjMwdnLjIiT6PwoWnwqdpGwrSlzFocrtWozuAjCBrsOknbOBCzKRQQsbbXA5KDfe+Ab3XG1Xnt4yIJ70SPfhz3OsjaJpTkQ3hCTOWu9yFBy+9fwQnaNLNVxCJsxhkZL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704380; c=relaxed/simple;
	bh=369vctLzkQfJIcj6VvksIN2X4tih54GQszHRWKgNRiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=prGJbkx4RcFq5XfnlWtMl319lO2m0NnYA4N46bjiYDdgSBU2nOLfJTaPsQqVwk7/naGnS6ijfGg06N+g7dDniYdQKZEiRQDaEe3iZpO6zqGysHGknJNa6roCWtTwiydtbD5MOADePDoB3+S5vdIZL69UEH9lUFlb0qJ1CgMKioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RJ5feXq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E90C4CEE7;
	Wed, 16 Jul 2025 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752704378;
	bh=369vctLzkQfJIcj6VvksIN2X4tih54GQszHRWKgNRiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJ5feXq5pLgc88dpiwJc+b2qpUSbClRMdgXExifvb4nMprCUJpaItDkMskhDpS29F
	 pusHWff6Ddjz0Uo1n5FIA4E0R12HtRf0WTfx/vIVta0xEA3aqVhjlukevmzADKs1a4
	 /YhcgXj1UUKRRzbJaaQrWR0qdxjKIDeVBtfBp7UI=
Date: Wed, 16 Jul 2025 15:19:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
Subject: Re: [PATCH v3 2/4] mm/util: introduce snapshot_page()
Message-Id: <20250716151937.6dd71398bf764d073526dc8c@linux-foundation.org>
In-Reply-To: <492025a7-4132-4944-b55b-90c6d6e40bba@redhat.com>
References: <cover.1752499009.git.luizcap@redhat.com>
	<637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
	<ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
	<900252c7-b16c-49b9-8c01-60e6a7a48683@redhat.com>
	<492025a7-4132-4944-b55b-90c6d6e40bba@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 20:18:00 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 16.07.25 19:36, Luiz Capitulino wrote:
> > Yes, good catch. This was from an earlier version.
> > 
> > Is it fine if I fix only this with a follow up patch for Andrew in this
> > thread or would you prefer that I post v4 with all the other changes as
> > well?
> 
> I think the series was part of mm-new, but now I only spot it in 
> mm-everything, weird. Maybe because of a conflict with the other 
> stable_page_flags() change?

I think I removed v2 from mm-unstable and added v3 to mm-new.  Maybe.

> So whatever Andrew prefers, really :)

Either is OK at this stage.  I do prefer little fixes so that I and
others can see what changed - it depends how tricky and large they are.

