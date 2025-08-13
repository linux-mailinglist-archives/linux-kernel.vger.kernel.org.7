Return-Path: <linux-kernel+bounces-766544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78058B247E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35E87AF6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE22F658E;
	Wed, 13 Aug 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqgPrqkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F827462
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082923; cv=none; b=iWS9dXs7rDQohfYC14yErHjoEoekjb50O9IVhnDDm5rdbUm5pPX5HancObv0ATbDVPPNQYkDrkyXB9og+9kkADF6ydks1184og95ACgermiNRxz6J5LOZ5Y6dp3RK8i9/9tijcumlNvmj0lW1XfYyi1cr46rh+syLPSXnILqKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082923; c=relaxed/simple;
	bh=7YbELCjb51P2Om8mI3uQ8h1CufdMDKxXXOjRp9ywryU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QCaj7Zhyd+tB80N18S6BQRfUW6JsmiF3t5R+3wY0OkNjlnvj/vBU/J1ImAFkhbBoTMcdz5/IhJko29CE0GIpvEUVlGqbxrAcmwA7H1Udtb2dZoVuDUvCPUL7n/jEhDuwt+GNjHK5EItbh8NQEof0swrl6DSuCqetRZHXYMoUL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqgPrqkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2839C4CEEB;
	Wed, 13 Aug 2025 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755082922;
	bh=7YbELCjb51P2Om8mI3uQ8h1CufdMDKxXXOjRp9ywryU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nqgPrqkAbwBgVMdL5bsNJgaWBzGnZfhBhi729kTMoKgbvncBLz3oA0yOwss9xxIlI
	 X9ZdLwYV/l5RIvLM67nSQolEdrl5uutTw5bJ8nP7ReUuFjNkCLgH719SPORJdPppjV
	 JZafvpxzouV81aM/ykcfJaOFXx/U7K+sO+eAkOF96Pjs7HZlnyjzbQ3iD5LU/K5etN
	 RBb+hsp8j9FdHLPZOz5DwIqwJscUPSWY41U0ozP5is4Y9CSWCLd9p8ktidbPBgqUtX
	 VmWga6BNkOGLdT86giifihUv1jPXRg5YEf+otTkzF5Iuhj5bUBQJgSxDKMGrbMFLyM
	 0shcNnZ2UZCyg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 13:01:58 +0200
Message-Id: <DC18YY6U37ZD.16KGMXOUG43RO@kernel.org>
Subject: Re: [PATCH] drm/nouveau/gsp: fix mismatched alloc/free for
 kvmalloc()
Cc: "Qianfeng Rong" <rongqianfeng@vivo.com>, "Lyude Paul"
 <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Dave Airlie" <airlied@redhat.com>, "Ben Skeggs"
 <bskeggs@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811091910.404659-1-rongqianfeng@vivo.com>
 <20250813134622.000069a0@nvidia.com>
In-Reply-To: <20250813134622.000069a0@nvidia.com>

On Wed Aug 13, 2025 at 12:46 PM CEST, Zhi Wang wrote:
> On Mon, 11 Aug 2025 17:19:00 +0800
> Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>
> Acked-by: Zhi Wang <zhiw@nvidia.com>
>
> Please add a Fixes: tag.

And please also add "Cc: stable@vger.kernel.org", thanks!

