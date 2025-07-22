Return-Path: <linux-kernel+bounces-741504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FAEB0E515
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983EA1C28302
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA22853E5;
	Tue, 22 Jul 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mf+02rr/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588F2641E3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217240; cv=none; b=tWvL2RlbYONxSGg1rajO18YFjbvB2YZgGf4HNuq6U6Z4swh2GBvGEW1HcTKJVDR6Q7y43IvRxj1JGhZoKrNhDxxxMIx+3ZHXgvAlVGVktJDchEYKTYyT4wbXy3gOusgCPFUe1JyffpCIB1UMtjBMV9ssTKlVq6YicjPRIw+v4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217240; c=relaxed/simple;
	bh=U4DORizE/f7hNR9eFeDGUav+ZFR1aFMf+KdprGRWYNI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XSKFyx0AGtAKWc6f99YTOExqLDHhOioKA2R5Ckl/TCqc+tEJhGQNMb3Wreeo85lwgNVoayBVrHkrmLRl+KqgjUMCVY76SGG3K1j2TJIqYzKh4hcrMF0lgSSLo50jpm8vKOGhdhR0+8SzlLX/TfPh8n8wOjwG4U26cJtyCraIvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mf+02rr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2AFC4CEEB;
	Tue, 22 Jul 2025 20:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753217238;
	bh=U4DORizE/f7hNR9eFeDGUav+ZFR1aFMf+KdprGRWYNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mf+02rr/c0d3kW1n35vEDCRg28UcNcK336t1EvLB9wFb9F4LIK4EjPkTCxTknAb1h
	 rwxYJDBgaX+NjVqK+anuV3pRqvn5RtzuwY502sv1cd+A+YNCH0yOskV2D503NB877g
	 7rRqIsaJ8KyKh/vLrBeURSUbNJXoMkfwgpycjzB4=
Date: Tue, 22 Jul 2025 13:47:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm: add get_and_clear_ptes() and clear_ptes()
Message-Id: <20250722134717.b8c9b09b8915b552447cb419@linux-foundation.org>
In-Reply-To: <20250722150559.96465-2-dev.jain@arm.com>
References: <20250722150559.96465-1-dev.jain@arm.com>
	<20250722150559.96465-2-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 20:35:57 +0530 Dev Jain <dev.jain@arm.com> wrote:

> Let's add variants to be used where "full" does not apply -- which will
> be the majority of cases in the future. "full" really only applies if
> we are about to tear down a full MM.
> 
> Use get_and_clear_ptes() in existing code, clear_ptes() users will
> be added next.
> 
> Should we make these inline functions instead and add separate docs?

inlined functions would be preferable.

> Probably not worth it for now.

Well, as David has called for a v4 I suggest you make that change.

Thanks, I'll queue the series in mm-new for a bit of testing.

