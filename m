Return-Path: <linux-kernel+bounces-739932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93267B0CD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741081AA4B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A624110F;
	Mon, 21 Jul 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m8NxLEJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6A1A5BA4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137221; cv=none; b=BPhL3em9NBC2N+SDzwaWbmNIWncVoG2Z+HF5Q9qt9h+dLJ+6e0Dr3w4xtPdw//93s2o9ZeFDkVr5zOzPdOvA3MljMdrrRfpcsi8oZe+IFQnCTGcM9IHOiJSo81zTb6y5ePz6QhsLpJk+8WOt2IrPru2IyDUiISuHru783fClkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137221; c=relaxed/simple;
	bh=wqvtCvvxBtqckbBNrjXSNAcg18LE4Wi7SGUDbnm1u2Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qC2S5zI3KktDCrLT+Y7ItshSm7LewrZCONMNM5gzARUUWAVEr6F46KWrGv9NXs3Unj4NlhKZhrTKMO6h92cYtz44sYcV5rblBNzg3LjFvtRrt0laBcauMa813kDLuNAGdCIlL4cPP4GuL3hax7cBzSSyiQP1MvENKXvEmRyJOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m8NxLEJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3DEC4CEF4;
	Mon, 21 Jul 2025 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753137221;
	bh=wqvtCvvxBtqckbBNrjXSNAcg18LE4Wi7SGUDbnm1u2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8NxLEJ5UunsQnsYjSaP7q5QaFoSzldtDWqtoYAjAv26z9uh+UHMq8gh8pikpzYbd
	 N/+6GlSRsE7fEAuz03t0n8TVTN5cCfw0NaBIEfOUrxCT9UcLo2Nwi3SVNdCDSfSGBZ
	 ib9LFBAJYEJnuSEVuqiHw+2hdVUt2SaS12/27buc=
Date: Mon, 21 Jul 2025 15:33:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Graf <graf@amazon.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Baoquan He
 <bhe@redhat.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH v5] kexec: Enable CMA based contiguous allocation
Message-Id: <20250721153340.5e033b1df1ac74c1a471c892@linux-foundation.org>
In-Reply-To: <07b21458-832f-4b15-9bc8-43f21f902e34@amazon.com>
References: <20250610085327.51817-1-graf@amazon.com>
	<CA+CK2bBhUdEjD=-gM3=D6mKBYctbXh74_hq-bMf1fa8mfS2Edg@mail.gmail.com>
	<07b21458-832f-4b15-9bc8-43f21f902e34@amazon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 00:01:25 +0200 Alexander Graf <graf@amazon.com> wrote:

> Andrew, I don't see this patch in linus/master. Is it still in your 
> queue? :)

Seems I dropped v3(?) to make way for v5 but then didn't add v5, sorry.

Added now.

