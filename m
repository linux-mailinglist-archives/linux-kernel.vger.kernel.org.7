Return-Path: <linux-kernel+bounces-844731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D164BC29C6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474103C3C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E80200BBC;
	Tue,  7 Oct 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UscjKB4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036613FC2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868260; cv=none; b=sL09oRJ1Az1Ro4qHsBXw3s2k8N7WUt7sUliB6+TbTOYACbtig8NECjQQ+QhX0E718CZ/+/+TJedNpdbUPL3vmhf+QjZT2lb0NjcMcHZKSyULY+KuTyf8l/Wn+ax+m5T0j8/e7LgOn79rokh5aYKuqkUjl1occqXgXdUYHwuZKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868260; c=relaxed/simple;
	bh=eAj9fTABA6mwf3gt4JhMjxYOGvFdQBfl/haKLAH7FDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD3YiaJOC1jiQ9kyz7bnIQjvwwjbx5q21wE2uA9e4jqmKM+1ONJrJkRzlj8Lu5nQV3hu8+0/1OaeQP3h0UVeTLBcLwaI++KvEnTWGZzM/jd278WX+vjXbJIHl68ADKiuukWlApoDVfWjcRV++fZh7xBTx6/xfORugdUza/gkidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UscjKB4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F7FC4CEF1;
	Tue,  7 Oct 2025 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759868259;
	bh=eAj9fTABA6mwf3gt4JhMjxYOGvFdQBfl/haKLAH7FDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UscjKB4KmibsVQTi3mswoi/J1Hb30clNJUvZ+FmjyHearI6UTVMVIv+rhV86hYYeH
	 QB5OYukWKuh/fb0jrFQXu8uauw9BjYZPC6oy16x86qz23vJSG1amT5CfSwDHb4M8f6
	 wBry8M8zr+rptB58GTK90FQNsRiNMbTvtZG/691UvX85wBgIlSQ7QPv3K0J1vp7Nqb
	 lNUUfc5+iJ0luO32Pk9tTVIBFAwFXv+g9nNuMYIJtLTyR8/UWrqMNcRWLzK5TQ7otv
	 NynWW2vt8L5c4wIDbjmEwoZYxYB55sI164Rbj6bu8hQvyPUczLqcGdn7rhK+dbH9Xp
	 zAutX2mRePoOw==
Message-ID: <56e7c42f-468c-4855-9039-bf81e51c158f@kernel.org>
Date: Tue, 7 Oct 2025 22:17:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: fix bad ret code in nouveau_bo_move_prep
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <aOU9BXjYDNoPRQmf@homelab>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aOU9BXjYDNoPRQmf@homelab>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 6:17 PM, Shuhao Fu wrote:
> In `nouveau_bo_move_prep`, if `nouveau_mem_map` fails, an error code
> should be returned. Currently, it returns zero even if vmm addr is not
> correctly mapped.
> 
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> Fixes: 9ce523cc3bf2 ("drm/nouveau: separate buffer object backing memory from nvkm structures")
Applied to drm-misc-fixes, thanks!

