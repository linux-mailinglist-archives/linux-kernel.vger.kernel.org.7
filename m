Return-Path: <linux-kernel+bounces-754347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD26B19314
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453BE7A6DCF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 08:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9105B284669;
	Sun,  3 Aug 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvYmjfgf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049A6ADD;
	Sun,  3 Aug 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754209092; cv=none; b=X5JDPflhy7CgRxL7f95BVU8PD9lr9saOAFUeF7YYSnoK5ZUBxIVozIZKtNqZGnbLE2hkOIxUw+EXi99t8q0xzz9SGEdPbTs8VBEtb9mXNePPWLpWetdb+jWX7X1h7+cQbR4cA2m2Ev8hSsOjkYAvE0NmC1G6nt79sqMZ/k3pDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754209092; c=relaxed/simple;
	bh=ByXRHJAbOYgU0cIygd2V2UEXXynkeCaZrRIAnBlXViI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1ZXd/PkLT+ZaGrBT8q9Cas2ePRth5IryQeCI0jA+4Yh7OHzGrcPXFOrCWv6yyvb9nPcS23JmluhCuJ0jk9g2n4HCw3jjfn5hqVS7rpfWLy1qJfXKa9WhEhy2p522o/8GHg/J+XiChUS87rfa4D6Fo13Cbypj9hGRisJggu9bBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvYmjfgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E203C4CEF4;
	Sun,  3 Aug 2025 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754209091;
	bh=ByXRHJAbOYgU0cIygd2V2UEXXynkeCaZrRIAnBlXViI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvYmjfgf+a/Xn7Wx44t7M6g5DeO0hEZGLNLuPzB/vqm9VUq4UmkW/zfcg3fdLK/9B
	 EcSQHhBOAyOmsXHKN1OZlcIEm5XOkJ+4PkLHE0tyxm4YmpwNrQRMZPi/uVw1AWYUFu
	 UkoVV35jNQhXae8WVrhcKuLT7PAdDJN7PoAOouXL+/GUODMUHvvNSxngvG46ffiSxP
	 hYoslzkIpX/kYctsYz+JSnsfml4fro5a8sTI8hB5OhXj4HEhf07Fj6KOG56zp0RoIT
	 eOx+1etKR2lrj3d2rdG2KX/4ZTL95VQ7mu0uLe5CdRNtW8BBXPXQvCosg7+wk/hOdY
	 tGyP9uDEt1VRg==
Date: Sun, 3 Aug 2025 11:18:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kim Tae Hyun <kimth0312@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, corbet@lwn.net,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] docs: update physical memory documentation by
 adding N_GENERIC_INITIATOR to enum node_states
Message-ID: <aI8bO2n8RuhF0Zb5@kernel.org>
References: <20250802125801.10068-1-kimth0312@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802125801.10068-1-kimth0312@gmail.com>

On Sat, Aug 02, 2025 at 09:58:01PM +0900, Kim Tae Hyun wrote:
> While reading physical_memory.rst, I noticed that N_GENERIC_INITIATOR has not been update
> from the node_states list, even though it's already added in commit 894c26a1c274b8eafbb4b1dad67e70e51a106061.
> 
> Signed-off-by: Kim Tae Hyun <kimth0312@gmail.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/mm/physical_memory.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 9af11b5bd145..b76183545e5b 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -171,6 +171,8 @@ nodes with particular properties as defined by ``enum node_states``:
>    The node has memory(regular, high, movable)
>  ``N_CPU``
>    The node has one or more CPUs
> +``N_GENERIC_INITIATOR``
> +  The node has one or more Generic Initiators
>  
>  For each node that has a property described above, the bit corresponding to the
>  node ID in the ``node_states[<property>]`` bitmask is set.
> -- 
> 2.49.0
> 

-- 
Sincerely yours,
Mike.

