Return-Path: <linux-kernel+bounces-798523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137FB41F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A4682E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51A2FF662;
	Wed,  3 Sep 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFI6yPw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A12FF141
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902968; cv=none; b=A1NkIAtjU/2t5RwyPTb0vED0/us4kRFLKJRAJJwLTpWUMLXiDC/vDZE5IP7BEK0lr2IJgCZEH77Jil8+IJWmLxotUJBfwepEN05TGvzlBpobXWfPdlIPotqvUDJwlLKgSJoUr8EWLMwh04vCpHa0chM69EiyH07UTRRvQpXvdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902968; c=relaxed/simple;
	bh=VktvVgVF9kvWQmrQxXLbMOZ2GkcHidn+yNqQgkKPVd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCc5xtV1EgeNpuFcNWaysolyKyU8ya6ltkQSGqX6e8FXxdxuuK2IRjOja+f+8hjppIrR46pC2VkVlSUB8yNQX4wz7vAjf8llX2llqezjb7BCxAUM/IZ3a2fw19ExOzDBUDYsSUG49uxZ0KiGLAbUnkW8YFULTasomToNKqD3Kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFI6yPw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58D1C4CEF0;
	Wed,  3 Sep 2025 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756902967;
	bh=VktvVgVF9kvWQmrQxXLbMOZ2GkcHidn+yNqQgkKPVd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFI6yPw3BmEppdwkdmSvXO422miYOl7VP6Zfu0dLO9C8QWdeRkRAgr27Wgnay5Yox
	 WHJUgZ8+LQiPWCdLk52uyjIPEI91A1lEtP9GDItHrjTgoGdKdVFJfGaFnCNGoZpqQY
	 v/BXAOLsgoBBcQDrbKl+gtpbtKvDoX3bIf5clj6M=
Date: Wed, 3 Sep 2025 14:36:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vulns] add a .vulnerable id for CVE-2025-38608
Message-ID: <2025090355-impromptu-tragedy-9ff2@gregkh>
References: <20250903054107.221958-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903054107.221958-1-hoyeon.lee@suse.com>

On Wed, Sep 03, 2025 at 02:41:07PM +0900, Hoyeon Lee wrote:
> The issue depends on bpf_msg_pop_data() helper, which was introduced
> by commit 7246d8ed4dcc ("bpf: helper to pop data from messages"). Fixes
> tag in commit 178f6a5c8cb3 ("bpf, ktls: Fix data corruption when using
> bpf_msg_pop_data() in ktls") incorrectly points to commit d3b18ad31f93
> ("tls: add bpf support to sk_msg handling"), which does not provide this
> helper. For this reason, the introduction of bpf_msg_pop_data() has been
> chosen as the vulnerable point for CVE-2025-38608.
> 
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  cve/published/2025/CVE-2025-38608.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2025/CVE-2025-38608.vulnerable
> 
> diff --git a/cve/published/2025/CVE-2025-38608.vulnerable b/cve/published/2025/CVE-2025-38608.vulnerable
> new file mode 100644
> index 000000000..f0336d0ed
> --- /dev/null
> +++ b/cve/published/2025/CVE-2025-38608.vulnerable
> @@ -0,0 +1 @@
> +7246d8ed4dcce23f7509949a77be15fa9f0e3d28
> -- 
> 2.51.0
> 

Looks good, thanks!  Now applied and updated.

greg k-h

