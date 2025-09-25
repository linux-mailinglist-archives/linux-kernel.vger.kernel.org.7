Return-Path: <linux-kernel+bounces-833210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1135BA16BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7B166129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED67320CC1;
	Thu, 25 Sep 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DDp190Im"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E642F83A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833298; cv=none; b=UCQXYV9cPMzVKMQaxvHApgnvW1hYb256pjubarGDLOdf+vzcQMWw7CZmx+15TeKWkyIYmLdJSnSYF7GiFCH3nlgXKQ27XLJHBNhCrXMtek9WjS9+DVkFgsG2Qri0Vm4rnlk+AEC4QzdQW9rlS0qNIh0dKSrk6NdyllQyNIhejCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833298; c=relaxed/simple;
	bh=H+anUvL00vqftzOh+0MKGhlUAO+NOJ6HDTxVMiKheQA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P0LfRHRLKVM30lJGv0qmwZ4nafIjb/qqi4LoQp80u4Uexuw4DA92xTVrvhGbY+N/WdUBzkLz29HAKx+/Wc2EPh5fZU7AoCAYSIbwXd0X8dbqJ2bZQBStvtYP+y8s2bJFUbEjCaczcumf4PB5+/4DaF39XX2TzQC217ULXHo1BBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DDp190Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CD1C4CEF0;
	Thu, 25 Sep 2025 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758833295;
	bh=H+anUvL00vqftzOh+0MKGhlUAO+NOJ6HDTxVMiKheQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDp190Im5/d1EOHZZEgvMRtSaBHrezIOaLf+RZfX/bPEGe7xksgfxxGZwe2OJ5GJb
	 97OB85nWWjOO673rWqAD0kpNh8Xncn2VzN/zGTdBQiylZU4nOQcDQstZB2BBYArkgY
	 EqA2YUM1Tr3np+7TpsGHG6Lqewq+lXCIQR0ip/fg=
Date: Thu, 25 Sep 2025 13:48:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, Christopher
 Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko
 <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-Id: <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
In-Reply-To: <cover.1758806023.git.alx@kernel.org>
References: <cover.1758806023.git.alx@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 15:20:28 +0200 Alejandro Colomar <alx@kernel.org> wrote:

> I've split some of the patches from the string patch set, as these are
> obvious bug fixes that are trivial to accept.
> 
> I've reset the version number of the patch set to 1, to not conflict
> with the version numbering of the string series.

fyi, there's nothing here which is usable in an introductory [0/N]
cover letter.

Documentation/process/submitting-patches.rst should explain the
conventions here, but it is presently silent.

The [0/N] is an overview of the whole patchset - why it was created,
what value it provides to our users and perhaps to kernel developers
themselves.  It discusses alternative approaches, possible drawbacks,
prior work, all that stuff.  And it provides a high-level description
of the proposed implementation,

Potentially lots of words, and it's quite important.  In the case of
your patchset, it's one short sentence (sorry).

The words you did include are short-term development things, unsuitable
for inclusion in the permanent kernel record.  Such material *is*
important and useful, but should be added after the "^---$" separator,
to tell everyone that this material isn't for permanent inclusion.

Patchset seems reasonable, I guess.  But I'm not loving "ENDOF".  End
of what - is that like __etext?  "ARRAY_END" matches "ARRAY_SIZE" quite
nicely, no?  And it much better describes what the thing does.


