Return-Path: <linux-kernel+bounces-886676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C8C363AE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644B81A21CC9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC4328B7F;
	Wed,  5 Nov 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lR/AzOXQ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA1221578
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355316; cv=none; b=QxdEq3/tg0sUJN21Tvg8tjyB6FSP+AlJhZNgg4JgEpKZM7U2wAsYDF2kC8nZghLogmYmu3dlGG6kQTSD71GJGqplJoQ56ti6jr9LlCpuV2A7r98tMUHHZ/K569AT7NR/VO2++2qEsobqu+lcIXGsHKkFRj/TgM2TBaahyo8r0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355316; c=relaxed/simple;
	bh=cXTOdx9roH+W8E+xvHKfgqr/Oltnlgk65cUOYpPwHz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTWlwGXtwQS/ljzWEy58itgBbvzstUrTaDd08MKYIuMRmR3f3olLjPP6lKDsumd7OTDAnZeEj9w05jy+VlCh06QWymmdwpRdF5NI0t7iIhbohP0kDJkfWCYcY6+Rk7Qxs8F0hUJ9oW0OQlQ/6VMt+1etxbr0Qyk4l5DU4ZTykBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lR/AzOXQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-96.bstnma.fios.verizon.net [173.48.121.96])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A5F8CvK017071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Nov 2025 10:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762355294; bh=M/5ncdywQVYzy/abn//duOGWqkqeR0Wf5qSNsl+K0vw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lR/AzOXQwUc3QKEg7d8Hlzct5GnVlxLMqhZ0vzLbrcv53DIRB30hQTClR6ywYg8Gm
	 69jaMFfNpigsrMJiGbpZgkj7Jc4M2XGinZhRVKm9XrmnanDZSGpDTP39Qe2+q7smR8
	 ojYGilwaFsu2RjlfQXeGZGZqKnQzaSoviIpkawyBrt0GbSA2KvSDStALNVOH7xUR5w
	 dkCzc0rK2x+JkVal/FFqwNiS0w/LGk6WunUA4efOiPDaIs7PGE7rux3y4EzD0ZhgBn
	 HYK0tfWyi+5xZ2oRnWLMIxFqrhxAbGNvD6oJgZHTovRNe5DZp0jNZrRfs9GqlUXFIu
	 j1xAOjYQ0/ULA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 98FBA2E00D9; Wed, 05 Nov 2025 10:08:12 -0500 (EST)
Date: Wed, 5 Nov 2025 10:08:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <20251105150812.GB2968640@mit.edu>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
 <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
 <20251104221551.GA2968640@mit.edu>
 <aQrfolXgeWs8A_gK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQrfolXgeWs8A_gK@smile.fi.intel.com>

On Wed, Nov 05, 2025 at 07:24:50AM +0200, Andy Shevchenko wrote:
> Yep, less confusing. The problem of the confusion here is the merge commit
> text, that only describes the merge of the small series but also implies bump
> from v6.18-rc3 to v6.18-rc4. Other subsystems I follow usually do an explicit
> back-merges to the rcX whenever is needed. But as I told Mark, I'm fine if
> that was a deliberate (known) move. Now it's all clear.

So what I do is I have an "origin" branch which shows the base on
which my dev series is based.  I use a rewinding workflow where I do
regularly do rebases to add Fixes: and Reviewed-by: tags, et. al.
There will be times when an upstream bugfix in some other file system
(say, vfs and mm) is affecting my testing, so I'll do a fast-forward
of my origin branch to the next rcX, and then do a rebase of my dev
branch on the new dev branch.

If there's a bug that I find before I send a pull request to Linus,
I'll fold the fix into the buggy commit, which can also avoid
potential problems when people are bisecting Linus's tree.

Since one of the goals of my using a rewinding/rebasing workflow is to
keep the dev branch clear, I consider back merges to be noise that
future kernel developers would not appreciate being permanently
preserved in Linus's tree.

I know there are some people who believe that git history should be
immutable, and should never, ever be rewound.  It's a tradeoff, and
different maintainers will use different workflows.

Cheers,

						- Ted

