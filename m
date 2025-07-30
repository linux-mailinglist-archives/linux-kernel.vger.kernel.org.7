Return-Path: <linux-kernel+bounces-750212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6BB158AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42C65475D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FF1E633C;
	Wed, 30 Jul 2025 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIGjWqI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6A249F9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855091; cv=none; b=guHMgyfhbLeYx0m17jrTzKe/sYlQrcPnNNLOS9boo5sgZSpUlS8tlxTQc8i/+/Dgn/N5htqqbS6rLkwLb25TWJjzQNAvEjK0aREIqRs2e5rh6VM0Wg4aNyxSBcTf+xYRIvk9RP6UMpPcktNSB9Njk1sUFUDfBphhUJp0G8Wxd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855091; c=relaxed/simple;
	bh=h0+pGIvI7aH6Cfk38whPmM3Fu2WRu9U7BpvLijwALJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9XY33tixcwWCmmvC4ncVpqIDQ5TpfLUZtogy9iXWXawydpyK7xewpCv3Bud0R+ZAbFUdJc3nAl3fVLwIs77m5UTwKT6U6jqkNLHv4jgJnN4cdh3AFUxuOP7ycBlTUyjoiaCKV2xMyjwKd4ggQ8UYyiF83tTFvkgH68KuG9tfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIGjWqI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5B5C4CEE7;
	Wed, 30 Jul 2025 05:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753855091;
	bh=h0+pGIvI7aH6Cfk38whPmM3Fu2WRu9U7BpvLijwALJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zIGjWqI+NXfbZsEQwDwQSIYS19w68t32oyHWBls8wElns1pnSxVY7T7GeA05GKnhG
	 7slhyqs1EXHSLdJHREHZxAeLKDMm0kpReEnuYiJtRQsLVIdSO5kC0Qjp67qvLO5v0L
	 NQX9+/03e0pKRqxcuMJS2ANbCKegDmTXIE3oyclU=
Date: Wed, 30 Jul 2025 07:58:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?iso-8859-1?Q?Jo=E3o_P=F3voas?= <joao.povoas@suse.com>
Subject: Re: [PATCH vulns 1/3] add a .vulnerable id for CVE-2024-53099
Message-ID: <2025073001-hypertext-robotics-046f@gregkh>
References: <20250729081824.85105-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729081824.85105-1-shung-hsi.yu@suse.com>

On Tue, Jul 29, 2025 at 04:18:22PM +0800, Shung-Hsi Yu wrote:
> The issue is present since the inroduction of BPF link abstraction with
> commit 70ed506c3bbc "bpf: Introduce pinnable bpf_link abstraction".
> 
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  cve/published/2024/CVE-2024-53099.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2024/CVE-2024-53099.vulnerable
> 
> diff --git a/cve/published/2024/CVE-2024-53099.vulnerable b/cve/published/2024/CVE-2024-53099.vulnerable
> new file mode 100644
> index 000000000..3a7ce7976
> --- /dev/null
> +++ b/cve/published/2024/CVE-2024-53099.vulnerable
> @@ -0,0 +1 @@
> +70ed506c3bbcfa846d4636b23051ca79fa4781f7
> -- 
> 2.50.1
> 
> 

All now applied, thanks!

greg k-h

