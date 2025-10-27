Return-Path: <linux-kernel+bounces-872221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C6C0F9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D0946020E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752733164C8;
	Mon, 27 Oct 2025 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Sl/2wW08"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC89314B80;
	Mon, 27 Oct 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585522; cv=none; b=T9QCqKP8UUiuMzfUSViNq81GSwYFyIz0+XyZlLKiQ8AeyYSiM5vYSmzt5v3b0LPCEEwFUi/3rb/6LkvV9bUB2stkZkZoBOYrberlme5Rj8tDj/dNM1EmrN3GLn2VzPQ0VFEjgMzTpE1wKcyLfaLXPtsacpGP8s9WYeGBLsvyv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585522; c=relaxed/simple;
	bh=qVIW8hz58C1WUT9TjPFhj13W5JBteyd8aHEXqPuj9Mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IY1EzGgyugfnoqogiSU9FGPP0PzoHyrLWYEuqYKQgBxnskZDbhS9enh4FrPGVYYzYsm4oYSqIBFS5oPFVLBVN/WP/8t/oSMA4ZV/dhBr4qRi7Q1IR6hPcKsRj50YA5UUOmwu6sbpLD6Dr0RsTI+55tZXlU+EqQegT9bD0Q+6Lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Sl/2wW08; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C6872406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761585521; bh=7HJgEVP9W7fZ+uD/7VQ7BeYsu2YsELLdPuhb6HwTik8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sl/2wW08g5Yw3d2SwGiRAqbrs9BmhaHsQ2LJ7gqmeetdnektOfnT/a7NhUJUnB7gD
	 x3jeiGvGUk/Bbiu3y4spBavbxvACG515i1ki/H0nHe77caDMGhp7P0O2xhEduAPO0c
	 D1QP3S49K78Q0eM0Mp77fiuooHma7Ql03c45I/vPP+xYyvOyaYMtnzEuVN54luSr7p
	 Q8uKnt64vG+qc7g1BK0XSFwFjF9rsPfqtiRAJ3wNdUD+rP+XFeNYUl0Ke9cmqWscUE
	 chwsBL41lV7ejU/3+XOAagjH539x3uEVlWlcjVqLXuliOdzpBMMS5/q5N0Ae+U5SI+
	 0xO/woCng6qew==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C6872406FB;
	Mon, 27 Oct 2025 17:18:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/30] docs: reporting-issues: mention text is best
 viewed rendered
In-Reply-To: <4f7e2de2a2336c52e55cc49dcda627a4e86b8793.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <4f7e2de2a2336c52e55cc49dcda627a4e86b8793.1761481839.git.linux@leemhuis.info>
Date: Mon, 27 Oct 2025 11:18:40 -0600
Message-ID: <87v7k0ntzj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Add a comment before the step-by-step guide explaining that the document
> is best viewed in the rendered form, as there the internal links will
> work that later patches will add.
>
> While at it change the double quotes in the license hint at the end of
> the document into single quotes, which is the preferred style.

That is the classic marker of an independent change, of course.  But
more significantly ... "preferred" by who?  Double quotes are the normal
English style that folks like me learned many years ago...

> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-issues.rst | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Otherwise seems OK.

jon

