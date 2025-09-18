Return-Path: <linux-kernel+bounces-822488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9905B8403B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4807B078A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F57305065;
	Thu, 18 Sep 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+jbxauw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE72C327E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190369; cv=none; b=FAasH9BxvX9ovHRXfJ2Hp7TW8QGWyYTOQZQEJitlHHEOZUdGpLOZCrHMBBBwxELI29MLVa5Z9RwvK4WYHgkLIuYSpRqx34kBmjLEiZDD+BSoPcVoKd62XHT1orNXxFRmW+hYWV4sPQgTVnjuWpJFFNWQZq1p5tx5uCHoVNTuics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190369; c=relaxed/simple;
	bh=o1Cwy5VJ6G9kyEavxaxVgKPCYtlXDCW5Fv2OCftslK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHP2y9T6td5JfPpO1PghAsojtw5ITmvoX7474nD0WZGxGGKvsQqOZAXlqNyE+1KACjn61sEfXqGKF8+0TDVwCAUJ0ylYjOfZQ3nfL+r2C+MKWIBWO0A49IB20PMF/IDqe1KAglGhnFhVa93WpPcOqqZUAwOMsC1gzAqQzGCO/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+jbxauw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BCBC4CEE7;
	Thu, 18 Sep 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190369;
	bh=o1Cwy5VJ6G9kyEavxaxVgKPCYtlXDCW5Fv2OCftslK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q+jbxauwtdR3DlNbHbBHKcz5hgE1MjHos4i+oNE1mJHqF5Qjt7KV/JZS934WuliS7
	 xuey86HpA+fq59AA7iPhj8V3tTwUVGBSBsGfH/6D11xsRXVnkN563o1RbkRkmj7Sb6
	 d22+zYFiTxbHSr9uYnoClv4geEe7jsUQwdPAce8XCrUFTHdVbzCvmRnc0T8rMvU+FE
	 9jqz6DonfGwvKKRwFGWPsEMHgySm1ktjfNWDzt5dn+XR2tUWXqTRhobZBotKDgvoyk
	 taR4TbkICqh+e6ofP4HSEotbrqSEGGvBdDbmcvrd9COPTJzDZMoGcVXjGm+MYsvddl
	 motQ1jDffkubA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] kho: check if kho is finalized in
 __kho_preserve_order()
In-Reply-To: <20250917174033.3810435-2-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-2-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:12:46 +0200
Message-ID: <mafs0a52sgjc1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Instead of checking if kho is finalized in each caller of
> __kho_preserve_order(), do it in the core function itself.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

