Return-Path: <linux-kernel+bounces-845754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BCBC6064
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9283D3B266F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE2291C1E;
	Wed,  8 Oct 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2WFr94n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBB4204E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940945; cv=none; b=nIvUts/azdVVF6WQ6DV4YQdu2nVGB01P2huxGbz+VzsV7C20+xF85eiH/QMgn2weotXj6lhJNMgj8EScu/8S3Xj3J47CHbzE5MHk00B0NqOou7wjRHzDNMeRSGl1N0i+cwW5PV/p9uhGrPfybTZnAhw5fS0Xfv9mT414ubQss4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940945; c=relaxed/simple;
	bh=JVQxE9TnJdgpGTrkD0m9zQf/OeSnxvr0yOVTLH/dUZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBCMvO6yciKUUEOKr2OfdBlKqf6Cf9gcfC4LyTUf7XKUYpmfYxwJSSOtIMDB8dmQp5h0QtLcLwj1HRLa6fWOu1gGoGfyz0uYnVW9RfCPkhFH23L38/ud3VPixKTdsdjhiYpaK7Gn8Dxu20+euioW6ba+wKdgK9b0IoHgcLONQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2WFr94n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF8C4CEE7;
	Wed,  8 Oct 2025 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759940944;
	bh=JVQxE9TnJdgpGTrkD0m9zQf/OeSnxvr0yOVTLH/dUZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2WFr94nH31O0NGpLab7G3P1+1WO+wC/oYzHcqO4iw18yOqKIpSpCr5qKVijWddMl
	 mUze/11E8cDL1vw1ibXJtuKSwSyjFvfxsum9AbJNGF+omAtGgef2NqT5SNQt39jDFs
	 QvIS0gqFcJHwkgTzXTfxInEygAgdUZXE8Q7zpBmw/VDRzPhrsCCB79iESd6UFkiTT2
	 DVQ/a/ftenFCvPV48lZWMTLNpWcCIpwCaQjg2Fm5J0RMpV8sKOzRqru3CYC0oP9aAj
	 bl+u5V8Rsw0/5EhZ/EGRkLKmyjaLP+YT35q+92T2xDz6f76No9WsFdt4iPSo3NuwvD
	 KEiKT4Pjqy9lA==
From: SeongJae Park <sj@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Usama Arif <usamaarif642@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Date: Wed,  8 Oct 2025 09:29:01 -0700
Message-Id: <20251008162901.6652-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <x6u2afqqwqpoabtpq24n64owlwagolt63csvaibg33p6t2ywuf@beayabw66enb>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 8 Oct 2025 11:33:01 +0100 Kiryl Shutsemau <kas@kernel.org> wrote:

> On Tue, Oct 07, 2025 at 12:53:13PM -0700, SeongJae Park wrote:
> > On Mon, 6 Oct 2025 13:25:26 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> > 
> > > __mlock_folio() does not move folio to unevicable LRU, when
> > > folio_activate() removes folio from LRU.
> > 
> > A trivial opinion.  So the user-visible issue is the incorrect meminfo, right?
> 
> The user-visible effect is that we unnecessary postpone moving pages to
> unevictable LRU that lead to unexpected stats: Mlocked > Unevictable.

Thank you for clarifying!

> 
> > > ---
> > > Changes in v2:
> > >   - Rephrase commit message: frame it in terms of unevicable LRU, not stat
> > >     accounting.
> > 
> > Yet another trivial and personal opinion.  Adding a link to the previous
> > version could be helpful for reviewers like me.
> 
> You probably missed recent Linus rant on Link: tags :P

I didn't miss it [1] :)  And I pretty sure Linus wouldn't be angry for this,
since what he dislikes is meaningless Link: tags on commit messages.  We are
discussing something about changelog after the '---' line, which will anyway
not added to the commit message.  Also I'm saying a link in a general form, not
specifically Link: tag.

[1] https://lwn.net/Articles/1037069/


Thanks,
SJ

[...]

