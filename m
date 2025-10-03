Return-Path: <linux-kernel+bounces-841403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C1BB736E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1111891B33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737926E6FA;
	Fri,  3 Oct 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gooSuUvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA701F9F73
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502471; cv=none; b=LV8UEOWF2XfjoO1rQSD0BXejSpgTlu6SqU/9dqKAGGmywm+bTyV3DNPZS8ZwgardYFNAkR/E4dQT07ZK0ZxdNkG7uzDCb+uwkATEU0CAhNPFFS6oLApVDsynBkqVfDLvRyqdPTKOsoryT6pxpKpqqXHy6GcyeP7mPlB4ELWdrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502471; c=relaxed/simple;
	bh=bx0s1P62xMVENFHKLMPJrGfBOUqIwhHXInCdciLOI28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyO4WPCHe80edZ2wHQryQNR7Rl3kiB3r+y1fP03avJas5sGEL+basJNvxPsmBQ0gUF/qWWyXvKZY4Nxo+BZlHmWsnNmnbtlrwAN5BqK+YYvIfKCYn+lWCByhnDmqhPwkX482Ms2nfA4VnGnFOes1fsLcxJY4+2Dc1q9PIkb/Mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gooSuUvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E3DC4CEF5;
	Fri,  3 Oct 2025 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759502469;
	bh=bx0s1P62xMVENFHKLMPJrGfBOUqIwhHXInCdciLOI28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gooSuUvfRNNV8OVGww1ML/xwqk09e1xghY60hhLXfxcrYtLUqU49R4u+klORm29bP
	 nxmxqz5XEYVJpaG/nenm6koFmty84zTI4wPHiYz8DQ77BrnJTJDsn+4B4kLg29WeR4
	 bhwJXW8SEFDxWL1C/KnTiErQtcZOy/XszVFuTPJTY7GdsJyOcM91YM4qpW/2mrw3Js
	 gzLZPBtHO29gCqLotQ1CjuIbbXDKvxBwir4n6v4VLfE1/lqFsjyBusvP8q4PKwTlmU
	 N040cSlVRWfLSEJn5K7DL2E2BmzHv9wQ187YKWtB8CBpAzvte5CzQx219rAHDTjitn
	 3HGhaYTkPB3xQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A9659F4006E;
	Fri,  3 Oct 2025 10:41:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 10:41:08 -0400
X-ME-Sender: <xms:hODfaFzzNst2fJ9nsIh_4nXMRtdtOoU9q2tLBMH-xX9onZNA8WETbg>
    <xme:hODfaFYm4nMntXtyFLKI2ForkYnY6oSWBO1aW9LL0ZVkFmd6F5PVDbRTJKVajQIah
    X7V4J01XNzwyKbVSBrKc-N77IA4dmpaw5ve69U1Y_TvHeQlarsr9AA>
X-ME-Received: <xmr:hODfaNL02WtZI4ffI5vVcDxtjDtb_nOJESyrPu5hAAfWB0RmwuqdmC1ydr4qfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeffefgteeljedtgfekiefguefgffdugeelueffgeehvddutdefgedvfeehudejgfen
    ucffohhmrghinhepshhtrghtrdhtohdpghhithhhuhgsrdgtohhmpdhrshhtrddqqddqmh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhi
    rhhilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeihe
    ehqddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepfedtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegusehilhhvohhkhhhinhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepshhhihhkvghmvghngheshh
    hurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehkrghsohhnghesthgvnhgtvghn
    thdrtghomhdprhgtphhtthhopehnphhhrghmtghssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrohhhuhgrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhrihhslheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprgigvghlrhgrshhmuhhsshgvnhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:hODfaLwoTx8Y67Fv462ACMflW_iHLcmVlLOv36fgFtydz1owY5aKag>
    <xmx:hODfaFPutmKdVMde_Epn7Vd3zK9_XdjhZ2Jada17jn8RhABnYcgSEg>
    <xmx:hODfaPv-C8Dzp9gAPsbMvk3yFrtxiieBrO8glu-5jXgTK13pe1Jxsg>
    <xmx:hODfaC05BylUzwxUNzxABzaWlvVUIXl2UCeONM4m3uTWGE_X8kivtQ>
    <xmx:hODfaMDHgKrDZCbX4AnEAnKDt2PIiZibepNnOOpkj6PnRh5Vgvl1fCLz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 10:41:07 -0400 (EDT)
Date: Fri, 3 Oct 2025 15:41:05 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] mm: skip folio_activate() for mlocked folios
Message-ID: <hnpzad4aehmp6ncgwhlinzx55z3zst5dlkhsjphpazccy5lzpv@hfj2eyewuplz>
References: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>

On Fri, Oct 03, 2025 at 02:19:55PM +0000, Dmitry Ilvokhin wrote:
> __mlock_folio() should update stats, when lruvec_add_folio() is called,

The update of stats is incidental to moving to unevicable LRU. But okay.

> but if folio_test_clear_lru() check failed, then __mlock_folio() gives
> up early. From the other hand, folio_mark_accessed() calls
> folio_activate() which also calls folio_test_clear_lru() down the line.
> When folio_activate() successfully removed folio from LRU,
> __mlock_folio() will not update any stats, which will lead to inaccurate
> values in /proc/meminfo as well as cgroup memory.stat.
> 
> To prevent this case from happening also check for folio_test_mlocked()
> in folio_mark_accessed(). If folio is not yet marked as unevictable, but
> already marked as mlocked, then skip folio_activate() call to allow
> __mlock_folio() to make all necessary updates.
> 
> To observe the problem mmap() and mlock() big file and check Unevictable
> and Mlocked values from /proc/meminfo. On freshly booted system without
> any other mlocked memory we expect them to match or be quite close.
> 
> See below for more detailed reproduction steps. Source code of stat.c
> is available at [1].
> 
>   $ head -c 8G < /dev/urandom > /tmp/random.bin
> 
>   $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
>   $ /tmp/stat
>   Unevictable:     8389668 kB
>   Mlocked:         8389700 kB
> 
>   Need to run binary twice. Problem does not reproduce on the first run,
>   but always reproduces on the second run.
> 
>   $ /tmp/stat
>   Unevictable:     5374676 kB
>   Mlocked:         8389332 kB

I think it is worth starting with the problem statement.

I like to follow this pattern of commit messages:

<Background, if needed>

<Issue statement>

<Proposed solution>

> 
> [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
> 
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Your Co-developed-by is missing. See submitting-patches.rst.

> ---
>  mm/swap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 2260dcd2775e..f682f070160b 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -469,6 +469,16 @@ void folio_mark_accessed(struct folio *folio)
>  		 * this list is never rotated or maintained, so marking an
>  		 * unevictable page accessed has no effect.
>  		 */
> +	} else if (folio_test_mlocked(folio)) {
> +		/*
> +		 * Pages that are mlocked, but not yet on unevictable LRU.
> +		 * They might be still in mlock_fbatch waiting to be processed
> +		 * and activating it here might interfere with
> +		 * mlock_folio_batch(). __mlock_folio() will fail
> +		 * folio_test_clear_lru() check and give up. It happens because
> +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> +		 * folio to activate batch.
> +		 */
>  	} else if (!folio_test_active(folio)) {
>  		/*
>  		 * If the folio is on the LRU, queue it for activation via
> -- 
> 2.47.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

