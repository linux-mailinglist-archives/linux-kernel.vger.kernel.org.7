Return-Path: <linux-kernel+bounces-766534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC5B247D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259F9688BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1B2F746B;
	Wed, 13 Aug 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efHLnc+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D929E0E9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082825; cv=none; b=qShhiC/H1krCkk/iVU/A+7ndG6vaskqmaOPTqoNDfAroIdkEY6pN5xXYvUWgO2E/e5+wFVlLo5ZPQRDIehmTkzD78p4u3E1AAXrBePOWHzdd46rSXTQ2utP7jiew7sFQpUfQgUZPi5q8IO3YTHgjbKcGJ3Vobehkkp064H/nrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082825; c=relaxed/simple;
	bh=pVBUctv6a7hHpBHFt5YC4+ibU3IDgNVLqiCYEtBc9a0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KCI1VoxdDyzE2izCMD+aqKq6BCvgMkK61X1CtEbHBcfu7byVKPTAafdQC3WQETJ129b+xyqdgZMgiIft5oqpEATgQ6+rby2qdhhRn6/5JKuCz7KZOA0TPfDFJpd9CojjivOmLNxVGWJKj/VBsnHMPfLHLGBSUUgYD/YgaKxcyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efHLnc+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7177AC4CEEB;
	Wed, 13 Aug 2025 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755082825;
	bh=pVBUctv6a7hHpBHFt5YC4+ibU3IDgNVLqiCYEtBc9a0=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=efHLnc+9hVS3/Z6pbE8olMidSsQLiLectidty7sW+Pr1QupIibRqmF93lAdRANhUF
	 7UvkyA0+8ISiujGZPjuwYJ8zI/gkBDYgDtJXJVadNrW3bp1iyzHuw6l2G45gJkk2ik
	 5KxSlZEisvcF7fN+QcUT9ym+AXqX/d+NSsoLc64Y3X3s/idourIB03+FAiIACQk5eJ
	 esS4yuskbGfrjnJfXlne7ofzzwL/aiC/hZL0XQ5NtyrJseIQcreP3psmkluGllG5+O
	 pGO2tc4e/r99E4oupGmaqk3xJ0SOCpaeQyhMFiEndVtc6e/Db8Abip1Zq97UHTKVvA
	 uaR5iKuGxmgaA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 13:00:21 +0200
Message-Id: <DC18XPLOI092.3BTLNFSDWJU8G@kernel.org>
Cc: "rongqianfeng@vivo.com" <rongqianfeng@vivo.com>, "airlied@redhat.com"
 <airlied@redhat.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "lyude@redhat.com" <lyude@redhat.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Zhi Wang" <zhiw@nvidia.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/nouveau/gsp: fix mismatched alloc/free for
 kvmalloc()
References: <20250811091910.404659-1-rongqianfeng@vivo.com>
 <4ca70a236502a2359b8ba332919b1fe4f9f09010.camel@nvidia.com>
In-Reply-To: <4ca70a236502a2359b8ba332919b1fe4f9f09010.camel@nvidia.com>

On Wed Aug 13, 2025 at 12:52 AM CEST, Timur Tabi wrote:
> On Mon, 2025-08-11 at 17:19 +0800, Qianfeng Rong wrote:
>> Replace kfree() with kvfree() for memory allocated by kvmalloc().
>>=20
>> Compile-tested only.
>>=20
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>
> Reviewed-by: Timur Tabi <ttabi@nvidia.com>
>
> This does fix a real bug.
>
> However, I think the real problem is that it's really confusing that
> r535_gsp_msgq_recv_one_elem(gsp, &info) returns info.gsp_rpc_buf instead =
of just success/failure.=20
> r535_gsp_msgq_recv() does this:
>
> 	buf =3D kvmalloc(max_t(u32, rpc->length, expected), GFP_KERNEL);
> ...
> 	info.gsp_rpc_buf =3D buf;
> ...=20
> 	buf =3D r535_gsp_msgq_recv_one_elem(gsp, &info);
>
> You wouldn't know it, but this does not change the value of 'buf' unless
> r535_gsp_msgq_recv_one_elem() fails.  If it does fail, the code does this=
:

Ick! That makes no sense, r535_gsp_msgq_recv_one_elem() should just return =
an
int and we shouldn't overwrite buf -- that's a footgun.

> 	if (IS_ERR(buf)) {
> 		kvfree(info.gsp_rpc_buf);

Should just be

	if (ret) {
		kvfree(buf);
		return ERR_PTR(ret);
	}

It also doesn't need the info.gsp_rpc_buf =3D NULL; assignment, info is loc=
al
anyways.

> It would be a lot clearer if we could kvfree(buf) here, but we can't beca=
use 'buf' no longer points
> to the buffer, even though the buffer still exists.

Agreed.

Zhi, Timur do you want to send a follow-up patch for this?

