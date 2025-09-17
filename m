Return-Path: <linux-kernel+bounces-821702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3ECB8204B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FA51BC585C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CA2E0B68;
	Wed, 17 Sep 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S3VrwZvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA52BE03C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145726; cv=none; b=czN9SUVA2tgRlkAZ01H2R8/n+brQ+ZQm5iOiKtqQ7WVrYfTWdSAPw+vavn1ndwtrwybVdXOlxgDG2QsN4Rj8Esoo7uoD09jJ/rPtkT8bk+ru4i4VjQ9lfsBrMrQF122486mzRx35Xag3qLr7MB9lbPYPoHIy/ioCMGjT8TcNyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145726; c=relaxed/simple;
	bh=4JnhbEe5JE89mQvE/RjARCCmQh4RoVQ/5hH2rSV0bYw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KyffXVU7laGj1bXb3GNeka6y5FQjXIytnJ26FPgx+0dT0tTPUZOXul50HLhKfvdpPqjr0Eu+YIgKdLdOlg4BfHxaIKkduUgvKAHLpSUZTWgs+d28KHl6JQbePOu+COe0wXuFFU3TYo1TlPby5X5pxkxCa3gJTbUYIm0LO2GJ3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S3VrwZvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F57C4CEE7;
	Wed, 17 Sep 2025 21:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758145726;
	bh=4JnhbEe5JE89mQvE/RjARCCmQh4RoVQ/5hH2rSV0bYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S3VrwZvuIUoHe0nbHYZad41XZdFdWZ7NJEddMUeLeK92tsiIAyP6/3CQyOXHBPvCR
	 aDr3TuwL7uUf1R4BxaslOy0FDHegR+bJ4h6PUghpg1M0T8tPa8OSvC/SaMd64FPrLY
	 DJIRVjSYqSaJq4mSkAyAt7A+LaledwS2ZtD1AXlk=
Date: Wed, 17 Sep 2025 14:48:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Chris Mason <clm@meta.com>, David Hildenbrand <david@redhat.com>, Oscar
 Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alison Schofield
 <alison.schofield@intel.com>, Yury Norov <yury.norov@gmail.com>, Dave Jiang
 <dave.jiang@intel.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH v2] drivers/base/node: Handle error properly in
 register_one_node()
Message-Id: <20250917144844.e8d9b9593aac9f3a4b52a0cb@linux-foundation.org>
In-Reply-To: <676712d1-7b4f-4614-bd82-5b0c43881865@linux.ibm.com>
References: <20250917134604.2149316-1-clm@meta.com>
	<676712d1-7b4f-4614-bd82-5b0c43881865@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 20:25:48 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> > Can this cause a double-free? Looking at register_node(), when
> > device_register() fails, it calls put_device(&node->dev). The put_device()
> > call triggers node_device_release() which does kfree(to_node(dev)), freeing
> > the entire node structure. So when register_node() returns an error, the
> > node memory is already freed, but this code calls kfree(node) again on the
> > same memory.
> >
> > The call chain is: register_node()->device_register() fails->
> > put_device()->node_device_release()->kfree(to_node(dev)).
> 
> 
> Thank you for pointing this out. I will address it and send a v3.

This patch is now in mm.git's non-rebasing mm-stable branch, so no
replacements, please.

A standalone patch with 

	Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in register_one_node()")

is the way to go.


