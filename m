Return-Path: <linux-kernel+bounces-827350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B321B9184E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DCE3BCA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941C30E0F2;
	Mon, 22 Sep 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHXRzKkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5630CDB7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549050; cv=none; b=mFQcSUWJwI0NLt9qPN9N9hlaqDQErpcvUd2DwFRxjiBso4USBxOFCgg0ErWYUw9/HmsQ+XKnGnUQwY9m4e6JcJE6T5Cx02Hegoqs4fjLesW/7yxYyHXgZrSX6dM90388eBqfSfVSbzAGLrbS7cVjSPhrAzDrr6RRdwvQUvC+q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549050; c=relaxed/simple;
	bh=d8t+hPlDB0nO1VCV/5JqDtENUCr2tcakVRrmCSOG4Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QkZvXtNkG3gwmOSdZcOmOELe9HpJR2AkvJHytBXxDiEmozXYWBc8HKPj82t/WqfQx2+velDWYguyqyR7ySF6BdXObn54m6vFEebBpAQT9ii3ikENinDUbHMj74Krt2twSCMb8d2GCJzeyYOy0PDetsK2XWnTGCs1BnSB1jkzddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHXRzKkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75E3C4CEF0;
	Mon, 22 Sep 2025 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758549049;
	bh=d8t+hPlDB0nO1VCV/5JqDtENUCr2tcakVRrmCSOG4Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kHXRzKknA3A9aDX+Xz4lbLB90q+PBv33eJfoQmsaLhGOv1tahF6UtQxvL4LPgamsz
	 t5rltBbjHiXOXBaIQ8GXVHEFuNa4IUu6hHP55+CClRyl9Jw9qBab7s+lj2ZLSzSwE0
	 2nVOz1InhfwHxtwZShWt9xa36LxkWLfKVBmhuogVea0VBtzaEoSCScVdh9pM8AOqlz
	 YDAPPY3zBoEUwLTXr7Vzl0RDcIzG0jf3tcO8mz+pWJ8x4ZFRN5eEfZk2Meog34jjTm
	 0hgRJoKPS0hhuNJDPgtvie5eQX1nGMYKMFqk0ZG0V091QLWQPTYjmQDB9nrEPj3vx8
	 U8HP7CeoJb1NA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250921054458.4043761-4-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
Date: Mon, 22 Sep 2025 15:50:46 +0200
Message-ID: <mafs0tt0ufvex.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Sep 21 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
>
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

For the new kho_restore_pages() as well:

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thanks for working on this series!

[...]

-- 
Regards,
Pratyush Yadav

