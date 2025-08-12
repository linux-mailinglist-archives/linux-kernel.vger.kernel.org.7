Return-Path: <linux-kernel+bounces-765427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935AB2348A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A09584A22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87CC2FE57E;
	Tue, 12 Aug 2025 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ur1wgBXu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABD2FDC55;
	Tue, 12 Aug 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023945; cv=none; b=nL7MGgRRec2B1bqk/sVpKsDyV7twCopq08YbB2y4O2o+KQWuPejueqsEqeysV/fIyhVrcbcx1EoW5SqtqlAGtn0KkgzXVPHLAwL4L2W6Z0Go+lINnhjTje1p8i+eJPYqT3GiYGDG/Yj7Ry28cTut75P2mXEE0jsMBpU2KmYJbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023945; c=relaxed/simple;
	bh=K4zcpvodHKRtUTgq0qJbR0c9lCKU6kpCp0Kmpo5DY30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hq8JI0K1XyugcQY/L1//HyK+WrTvJIopeYO4nS7WJMU/KJLXaYFsPD4UCYpUoIpQJ2BsBoOMUoDhZw5ujZkvJ3pgeVp/Td38F9FXMtTTKWtQkY1RO2pPyWS6IFbKZ6gUOx6kM5EmINQDJO3la/QrbVOPBrCKDxikVl4quwTpl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ur1wgBXu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E1E3B40AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755023943; bh=rHDn941Sg/eSk0bmpOyy2XNxu/PzRvDqOKXRQlNFv1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ur1wgBXuom2nwAqVqx7OUtkP9XmJ4h+IMVcCbdXeQ3n/bpwqB7c5kWvgJmeFtx2VB
	 f5f5Yj4G1x42XGImUnF1UCqD9fllUl9o9DJciCp3h6tSSWduQUj4bzqhOps9xruetz
	 32YWH0SNa9ZvsfV5Eb9T2Fgu03F2lW3+dbeuN1WVI2bgssZMVFMD36oTnuiBUlTvsT
	 +l5Hr8Z1wc8NgMY+sHsKlt4DNiu2PtoF4yn+piYiUOk7phnreDmnolSPXxkB6YB+rN
	 Je6MDOkgKNOAJth7VlhiDgL3gBrfO8Y0yNF8LQlGARUkWW98xMtd+c2OKxMN6b3nU1
	 RkcCsQMDvSe9w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E1E3B40AD9;
	Tue, 12 Aug 2025 18:39:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org, alexs@kernel.org, si.yanteng@linux.dev,
 dzm91@hust.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add File entry for
 scripts/checktransupdate.py to DOCUMENTATION
In-Reply-To: <20250812050711.2515173-1-dzm91@hust.edu.cn>
References: <20250812050711.2515173-1-dzm91@hust.edu.cn>
Date: Tue, 12 Aug 2025 12:39:02 -0600
Message-ID: <878qjofkqh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> As suggested by Nathan, add a File entry for scripts/checktransupdate.py
> to the DOCUMENTATION section to maintain this script.
>
> Link: https://lore.kernel.org/all/20250811212446.GA924610@ax162/
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..b7e3a8c8832e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,6 +7302,7 @@ P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
>  F:	scripts/check-variable-fonts.sh
> +F:	scripts/checktransupdate.py
>  F:	scripts/documentation-file-ref-check

Applied, thanks.

jon

