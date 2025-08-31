Return-Path: <linux-kernel+bounces-793217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A3B3D09B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 03:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D7E17D228
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D611DEFDD;
	Sun, 31 Aug 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SN5qq5iZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9138FA3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756604982; cv=none; b=EkcO75mHSAKFaI/oZ+TaPqNJhQzkhCI7Yt1lLblD6YLLdPmI0ms6+biZhcT+sl35+pqr8WSMMfYPPoHHKhJi2IW7A/Djk//lYfHUXDh5Fxz48gp8epGH2ApEDoJTYXVklKW2Rivkp2bkNuckXTN5uzmTWTNwuI0RbDNq7H1KsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756604982; c=relaxed/simple;
	bh=VoenFyvbohpUvKigw6ID2nFxRK7fJ77AkbwwQZiefYc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VpkwCSg3m0mx7WsiZB2pmRPWJs7ZtvP/ARu1Znn2PUpBOnLVEuiGBZvL8q8zII8x2g3pmzQVIxGVGFHmRhAJMM12hd0CE6wXK4FegiEsRX5nKQWPt96KL5RuGtpYFcs8t0uip8D6Wu/HI0DM0S9peklXn0Sg1BOjBJZuVP6ty/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SN5qq5iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16588C4CEEB;
	Sun, 31 Aug 2025 01:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756604981;
	bh=VoenFyvbohpUvKigw6ID2nFxRK7fJ77AkbwwQZiefYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SN5qq5iZGhL8d6JW+tDzB7sLsQgImyZlSEgfpbTAufAVhtcS9bkeRaOHsF3+N6WIb
	 9r8hyd0HFAY0wagAa1iTzGvx06N4NMZgkf7gEMMgGxpQp8K8o4UkY1BlNEoDuathSN
	 ufql9NV+PtwWjX5VDtdfAB2e1sWySzeB0p9emUKQ=
Date: Sat, 30 Aug 2025 18:49:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, david@redhat.com,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 05/12] mm/oom_kill: add `const` to pointer parameter
Message-Id: <20250830184940.5d83cdda762c849cf74d9dcc@linux-foundation.org>
In-Reply-To: <CAKPOu+9MBokh6z2o8=GKwTeU61Ce8Pbs7zjTSxo9=d+vKCYZWw@mail.gmail.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
	<20250829183159.2223948-6-max.kellermann@ionos.com>
	<aLIxs1cFhneGU5D9@fedora>
	<CAKPOu+9MBokh6z2o8=GKwTeU61Ce8Pbs7zjTSxo9=d+vKCYZWw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 30 Aug 2025 08:26:07 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:

> On Sat, Aug 30, 2025 at 1:03 AM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
> > > -extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
> > > +extern bool process_shares_mm(struct task_struct *p, const struct mm_struct *mm);
> >
> > Nowadays we're dropping the extern keyword.
> 
> I can do that - is it acceptable to do that in the same patch?

The culture is "ooh ooh ooh, you can't do two things in the same
patch".  My culture is well, gee, it's simple and obvious and makes the
kernel better, so I think we can handle it.


