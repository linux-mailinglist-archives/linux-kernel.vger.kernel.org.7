Return-Path: <linux-kernel+bounces-874766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D89C170D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFE335656ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349952E173F;
	Tue, 28 Oct 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nmaf///6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF72C1586;
	Tue, 28 Oct 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687125; cv=none; b=n6h/c48nIRLHBxUC3QdQK5XmafATZh5Z4N5dBO5GEnzi8tK0NjkLEg8FvT4MA6wApMLUC3O4YOw0XDsYbdS8llSc7Uo0gIH2wW16Hz9kfjeagvqZnjjEtFtPy+YZ5cp+v9xMoVUYTubhwuL4vR6ejNL8Lk6Nuocx3zGxIvXx0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687125; c=relaxed/simple;
	bh=i9X3JURiH14oZSxNI1RGlS0fvnIEeIQNELsDfZdPbpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eku4nH/5kltbh+Kj2nM5c+wtk5AIYnB5gEug5lvunFqpT+GagfKrlsAdthHzl67daYRpuZstekBKEi5GDEsx2PwEwQXNnSJurgzRmoF4QkjqCsSXXS0Be5kGE8UJa2AuFTA5y9cpunpZ0ngRvNzc/n5rOG2RhJ26K9zLgQmQjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nmaf///6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2694D40B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761687122; bh=zthN1S7O3Ap1702+fuoQfixzm8wCyv1tjmdxOE74RCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nmaf///6URvqptCOr/sEZQgCX5CVK0H5BtjV/buW64BWb9Ac+U4rGL0iSi9QkAGmE
	 i9lD9eK0gMcFRjiP+G6bg9xGZcmi+hDE3K6H/axs++pAcH2EqdIk4vFo08xirUiq+l
	 bF4qp6H3PmNkn36Cv5SnEjIQXalAuxtsnhmM/hqicVY5s9Tmerg9lIhh2ADwovfxEX
	 2ppjaIfaMSwv51sWdrXNiIIIu2eKOrRc7iR/iXC0+havgILKh6jrMpSb2XcPcGhU2Y
	 JdoiXf0zqf7okkyFkd56NDqLZkXUCU3n1m4PyyguwOAwJu3fSBukXFYNY+QR6jAti5
	 /0tqL10M0rKzA==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2694D40B38;
	Tue, 28 Oct 2025 21:32:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/30] docs: reporting-issues: replace TLDR guide
 with more of an into
In-Reply-To: <bffecd192c73909b8ceb58a123842c943e51200f.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <bffecd192c73909b8ceb58a123842c943e51200f.1761481839.git.linux@leemhuis.info>
Date: Tue, 28 Oct 2025 15:32:01 -0600
Message-ID: <87qzumk90u.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Remove the TLDR guide and just describe the essence: a email is all that
> is needed.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> ---
>  .../admin-guide/reporting-issues.rst          | 90 +++++++------------
>  1 file changed, 32 insertions(+), 58 deletions(-)

This one seems OK - always nice to make it shorter! :)

Thanks,

jon

