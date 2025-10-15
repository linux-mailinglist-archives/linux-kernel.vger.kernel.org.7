Return-Path: <linux-kernel+bounces-854960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C01BDFD90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64C01A21A51
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73F33CE94;
	Wed, 15 Oct 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLYcUCKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39C33CE8C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549286; cv=none; b=UpOV21OSXJiaVFA+AgbSo7GL1XgLvf4qvvX589EvsSDPi+y9qo8jNNcbqhPAbFGb+I47FLeFQjeyA11ehHOgSJ0UAR7YkCa3v+WQNVaIesdgGW5cD9PL6XiHleUJuLBg6onicocCE12oYGFTMuipKyiIN5Va50zKJCv/hAGUt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549286; c=relaxed/simple;
	bh=2/0p/0k/TXO7o16P7A/u4tyNONwtv678Sc1Mfzau9Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHYHRe4gAlq097eCWqpDSoEnhOa6U6xMK2f8AO3BRtPuWdn8vzRENyB7pOoHEYWt6CeiEKiOs/ZtCWM7QOBhBCldRfjbfOgDwF/iULyTmsjKLPyPVdmoTW7bNpSrw69LYqVjZYtPlJMO2ViG3OoGXqh373Sm6KNiDsdVU8IxEC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLYcUCKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B3CC4CEF8;
	Wed, 15 Oct 2025 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549286;
	bh=2/0p/0k/TXO7o16P7A/u4tyNONwtv678Sc1Mfzau9Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLYcUCKM6bI5Mz3l/tIYX/Z8p679bj7v28Kvi74TY7ncPOkHDjSf4kSDNS4Rrv0gO
	 MfF8ObXedzSLW80dEXdPChqCCXcLRHpxhQ6sYCQyL5YhXIij7R6m25TNaY4w/I/oWn
	 GEor+iRGSfQ0uN5vatbPqIWjKlSmdPypIE8CTRamSxuDgJToelhnE5AKSaFiJ1BgD6
	 B0R24iWwCp75s3cU4Or6ZyBpF+8G8eic0/GknwhH8KbJ1bMQO5SWxjKfxapQgHQa+P
	 ZwtVJppb7CxWPrFLIcll1iselKsf67JYLLUZprpMBYL4YisI9hPlE7y0PO6EKSIBU5
	 AsY7Rn1AbrdlQ==
From: SeongJae Park <sj@kernel.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/2] drivers/base/node: Fold unregister_node() into unregister_one_node()
Date: Wed, 15 Oct 2025 10:27:58 -0700
Message-ID: <20251015172759.69864-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <32b7d5d8f0f30d313c3e1d8798f591459c8746f9.1760097208.git.donettom@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 21:09:17 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> The function unregister_node() is only called from unregister_one_node().
> This patch folds unregister_node() into its only caller and renames
> unregister_one_node() to unregister_node().
> 
> This reduces unnecessary indirection and simplifies the code structure.
> No functional changes are introduced.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Acked-by: SeongJae Park <sj@kernel.org>

> ---
>  drivers/base/node.c  | 38 +++++++++++++++++---------------------
>  include/linux/node.h |  6 ++----
>  mm/memory_hotplug.c  |  4 ++--
>  3 files changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 4bcaa8006cd6..758b777dec1f 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -676,23 +676,6 @@ static void node_device_release(struct device *dev)
>  	kfree(to_node(dev));
>  }
>  
> -/**
> - * unregister_node - unregister a node device
> - * @node: node going away
> - *
> - * Unregisters a node device @node.  All the devices on the node must be
> - * unregistered before calling this function.
> - */
> -void unregister_node(struct node *node)
> -{
> -	hugetlb_unregister_node(node);
> -	compaction_unregister_node(node);
> -	reclaim_unregister_node(node);
> -	node_remove_accesses(node);
> -	node_remove_caches(node);
> -	device_unregister(&node->dev);
> -}
> -
>  struct node *node_devices[MAX_NUMNODES];
>  
>  /*
> @@ -924,13 +907,26 @@ int register_node(int nid)
>  
>  	return error;
>  }
> -
> -void unregister_one_node(int nid)
> +/**
> + * unregister_node - unregister a node device
> + * @nid: nid of the node going away
> + *
> + * Unregisters the node device at node id  @nid.  All the devices on the

Nit.  Why two spaces before "@nid"?

[...]


Thanks,
SJ

