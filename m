Return-Path: <linux-kernel+bounces-832071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE29B9E459
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA65516B159
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B042E8B8F;
	Thu, 25 Sep 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0RZZ1Rb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9D1552FD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791981; cv=none; b=IZ4up6Ay4/tnFR29eLzz4RdbEVhLp87/1JoghqoXJCCwhiOW4NKu449lQf83FyGTm8jOwzgONqHKEQDD32gLh8cO5nQQqkMoBKtfJ2bI+cXSHd+h/eA5ga6OqXwth4A3GLio5ror1YDPObbzF8iVby7j2nZlpD231TzOPg5CNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791981; c=relaxed/simple;
	bh=AQqMJQUBDrq9kxPLr/qGEjxf9utS86NJR0MoZy6d1v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfBj1ZYRjYGnhJfpMppMAJXGKziIJCroXT0xXCuXGGakI0kpToZ6lPaA3PD3tvY+LfY24Oqr3ukMQ+f6sggKWYF14f7sifcprxyCXZ3DEWxdqF48t9QdJudmYtcLgMnvbHW09PzCV26i6izc6T/OxOxgToSK2FYUqBkWth4ihgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0RZZ1Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96BDC4CEF0;
	Thu, 25 Sep 2025 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758791980;
	bh=AQqMJQUBDrq9kxPLr/qGEjxf9utS86NJR0MoZy6d1v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0RZZ1RbKWAAkwlLtYKHcY7S4z/MVWCM50D//MM7NbnU4x0VQ104OQW68HBeAYRYE
	 Gk60I4tro2JMqe3Qjc8LwqFxAq2mJlq+lKwYDTQWUkX3AkNoBii2ZDZfEvqZN3rEM3
	 A3jYcewOMAlaG7c+WSx11wDrWKMqV5Bcp+7l8t8kM9isRSp+OuRBU+FwhwS9ueFh46
	 0/QAkKl2M040I2KBKOwHwNMlJg2blEiveia9uQcZQJmWSKPe2WfUhlSKJLGTLszk2K
	 Fb5QnhvksFC9LTB8hhqUzWg6e7ye1m3pyxoM4nRn+bZFFpXmDoPpHtCOVBTNV3MagN
	 yOB/K5Ig541Lg==
Date: Thu, 25 Sep 2025 12:19:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
Message-ID: <aNUJIsElr5L5uxNv@kernel.org>
References: <20250917025019.1585041-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>

Hi Jason,

On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> This series transitions KHO from an xarray-based metadata tracking
> system with serialization to using page table like data structures
> that can be passed directly to the next kernel.
> 
> The key motivations for this change are to:
> - Eliminate the need for data serialization before kexec.
> - Remove the former KHO state machine by deprecating the finalize
>   and abort states.
> - Pass preservation metadata more directly to the next kernel via the FDT.

If we pass the preservation metadata directly between the kernels, it means
that any change to that data structure will break compatibility between the
new and old kernels. With serialization this is less severe because a more
recent kernel can relatively easy have backward compatible deserialization.

I'm all for removing KHO state machine, but that does not necessarily mean
we must remove the serialization of memory persistence metadata?

For example, we can do the serialization at kernel_kexec() time and if we
want to avoid memory allocations there we might preallocate pages for
khoser_mem_chunk's as amount of bitmaps grow.

It also would be interesting to see how much time is saved if we remove the
serialization.

-- 
Sincerely yours,
Mike.

