Return-Path: <linux-kernel+bounces-864803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1DBFB92F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19305507830
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3E32D43A;
	Wed, 22 Oct 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jX4XEa30"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1A32D0FC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131642; cv=none; b=EZVZ8yvhTdKP8YBD2PNKIxPo2Olc4aaxpsBllS7kqdFKSUHCeN+tyWI/4rVUAn5zXAjv5PIHvjUzcvoiXks/c+j+uESWszTUPY4zEvU3xFVidz9JEjEv/kyGm2eP8yuV8Cfc5+ZKZfzETi/s0CEdAetcJF8Sz5FBmpetkHZYOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131642; c=relaxed/simple;
	bh=ghJcC+8CgxXj7I+keXnFyerO2sKjTfm+HsU0J3nIO8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkelg0d2LQXJIecVXCLH904qZARFXDTsDSEPqotd+3d/CMkloReBnKl8nhp47wwA+olA4bF7R4i3vkDkYl6BKthwIQSkECsmYV7DqeLPJyne6DODPTw5aNGrSnT6LsoCvly0HYVZLrnQkz+w86BHtee8+JWgIQBi7QRTX9/yOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jX4XEa30; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9225140E00DA;
	Wed, 22 Oct 2025 11:13:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xC6UdyrtqWPe; Wed, 22 Oct 2025 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761131633; bh=OKj/JzQkNl7jyLKUkWHoJNmXsgj7wrSIde2aZ9Mkl+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jX4XEa30RQ3UJcGbvZquiO4XGFG80soGCTYYIV1F8achLxTyKSexA3dRrAHS97d15
	 qDrgwAIaw8rRxlKwk3f3WYBglAkynoH78IU1dvSrQ2oMZAlrdjkgn91zHW1BbMkPVi
	 A97ENU8HaUwDza3p6pYx58KjgsHxyjDl6kkpFyqu6qrPjTQ6YONXhOhuwkMbrH6TrG
	 m7vh30cJxGuWPa46+ZSZuS3XpXBYqdChamDZ5Y1h5IfEyA0e2r7nZZkuECAzM02Qen
	 0IVUY+e//8jTASW1id0ka77TJOrWkyp8VTk2+lthGlJOrd1Gd+J0rRheB7g4vUvIX8
	 FLeQkxxORFKgSSby+F8fF0JMllSRk4CEHZauWrSYkiJTMfJdL3Xs2Js3likuNlFEvI
	 Ph0VEkZUK8OgM4Uwj4DqK9YclE0gzHfDgUOQIlxoRglz5wFJ1zFomBecKiRthZH3NH
	 w6fed+PAg7H8sheqZqkvKnU0CpDBmf3AfNLWsW4UZXKmC/LaPlt3k9E1nwNZLRaNch
	 TBNhf4NkF1thkewD0M7OSh7v2Ke8mstxgov06bYT6xROncapkqVJc8lcJodfPcEYav
	 aG6GQ7XaG57TVSh/abn5ZoqFoJn0IgAoIl8RIZvNe82yN1mrga5gns//wGaBaY8vM0
	 XH6GVCIFCu599jsNPEXaWppc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1D87B40E01CD;
	Wed, 22 Oct 2025 11:13:48 +0000 (UTC)
Date: Wed, 22 Oct 2025 13:13:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251022111342.GNaPi8ZqATfwpja2GR@fat_crate.local>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>

On Tue, Sep 30, 2025 at 04:45:45PM +0000, Yazen Ghannam wrote:
> This behavior is benign on AMD reference design boards, since the bus
> numbers are aligned. This results in a bitwise-OR value matching one of
> the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.
> 
> This behavior breaks on boards where the bus numbers are not exactly
> aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.

<---

Please add here something along the lines of:

"And even if one could say, they both have bus 0x0 containing the root
devices, this is not true on the other AMD nodes besides 0."

>  static int amd_cache_roots(void)
>  {
> -	u16 node, num_nodes = amd_num_nodes();
> +	u16 count = 0, num_roots = 0, roots_per_node, node = 0, num_nodes = amd_num_nodes();
> +	struct pci_dev *root = NULL;
>  
>  	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
>  	if (!amd_roots)
>  		return -ENOMEM;
>  
> -	for (node = 0; node < num_nodes; node++)
> -		amd_roots[node] = amd_node_get_root(node);
> +	while ((root = get_next_root(root))) {
> +		pci_dbg(root, "is an AMD root device\n");
> +		num_roots++;
> +	}
> +
> +	pr_debug("Found %d AMD root devices\n", num_roots);
> +
> +	roots_per_node = num_roots / num_nodes;

What happens if num_roots = 0? IOW, you need to handle that here.

> +
> +	while ((root = get_next_root(root)) && node < num_nodes) {
> +		/* Use one root for each node and skip the rest. */
> +		if (count++ % roots_per_node)
> +			continue;
> +
> +		pci_dbg(root, "is root for AMD node %u\n", node);
> +		amd_roots[node++] = root;
> +	}

If I squint my eyes hard enough, I can see you getting rid of the *three*
while loops here. So please try again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

