Return-Path: <linux-kernel+bounces-794147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15ECB3DD80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9157A1C9E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD530276A;
	Mon,  1 Sep 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt2Q8Tru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBB304BC1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717329; cv=none; b=ia/CIpGnjjKoIMqxjA9dlDr4iLKz+Hx5JxH4ckbnJpjOC53LcC/3e9fexTa+WsEZMqxGkVkDg7KAwjdaRUWxjSw7m+xZvww+ltyIlGGvER5GeQXCsPOU4ktbvda3XmGdcjgqQySA8v4flfjhcMKBoQkASIMebU01RZ2jPx4J/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717329; c=relaxed/simple;
	bh=dmWftgOYXnwqfimPo5iGk24UkXj0UgScTAHQx516kNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+azZ9rU7mrT3i4qeGEY0MwfqBiY8d6A+K3EJHjj0tqcBGwHyvp5wzHGmC1o74rh/IzicrCZ5XzdALsBCtOCbPYQT3XzfiIw/nSU7GCtP/gLfYEL5f4TDXg0QPP0IzEPeLQXh2TGF7LwhI/Ik8DjKxNpwq3ws+1GbZPCW2mMAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt2Q8Tru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D07AC4CEF4;
	Mon,  1 Sep 2025 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756717328;
	bh=dmWftgOYXnwqfimPo5iGk24UkXj0UgScTAHQx516kNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt2Q8TruNmgq3X52QEd8IDcJOs6iK8kI1BMjyxHwgRPVldf0rLQs+CrnF0ZCB6SSW
	 qibjwepNeMtBuTQ4KjAE/0yaNVPFZlk0w7Kr66pmIhbPfYu+JRSWlk3iCVHynRNw01
	 gZoEzqH/HlOS8b3hrtLNBktSWPdXEmZUTyGeMDj8FMt7MAqa4W5lqCh2fzV+EaQlgh
	 FlInVOCdEk3w06f66JUA5G5X/iWs6JQ1MRslNQ/0yRAvyrtb++ivZ8M+XH84IBreu0
	 ZI2qycGpcxOt14J5/SAwvGJ8jivBZk4Fs3TWopWRnOhcT8e714jpla2JH8Q0CGAZJj
	 +GHyEg4L6PLKQ==
Date: Mon, 1 Sep 2025 12:01:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
	david@redhat.com, axelrasmussen@google.com, yuanchu@google.com,
	willy@infradead.org, hughd@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	surenb@google.com, vishal.moola@gmail.com
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
Message-ID: <aLVhB4qQMurjS1Ap@kernel.org>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>

On Mon, Sep 01, 2025 at 10:05:53AM +0200, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 9:33 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > On Sun, Aug 31, 2025 at 11:39:07AM +0200, Max Kellermann wrote:
> > > For improved const-correctness.
> >
> > It is not a proper commit message.
> 
> I believe it is proper for something as trivial as this. I think
> adding more text would just be noise, only wasting the time of people
> reading it. But that is a matter of perspective: I expect every
> competent C developer to know the concept of const-correctness.

True, but having a brief explanation why it's ok to constify these
parameters helps. Especially in longer patches.
 
> Do you believe the commit message of 29cfe7556bfd ("mm: constify more
> page/folio tests") is "proper"?

-- 
Sincerely yours,
Mike.

