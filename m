Return-Path: <linux-kernel+bounces-763284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A34B212B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF341907DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAA2D372A;
	Mon, 11 Aug 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AFUZTEUt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4571262FF1;
	Mon, 11 Aug 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931647; cv=none; b=P10QioN45O7QZdkDWD8q1oAszsZe9x/Mmp5PEM5q9cAe2UJJxaurXkzkuPmAPuEXhrky1LGALdiiQEPwxuKDlDo0duSUvVUB7TtxFhZal55t6YiRgdP2iWjGmx5YRmnkJl9nfdEcYDgkSbtMAUPFSRKg1gpB6TOPB1G+Dg4apcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931647; c=relaxed/simple;
	bh=/wMxM4RKAGxKIP1Ser8xxq+lbQZEdcFqtOMStm1K60w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEi19blXEcTvu1y+7ItPI7Pvsao3GCQPMl5YHPCO6roIVJgrAx8LSybxv4n+WMy2XyBYu2u18qLLQFvT1En0YBtdwRcuBM+qgRRD0y+icRP9xwthc4RjZiEXRcj0rSW5HZPmI8hY5FNe2BTP1lB9LroHneJJLwYLBeNviyizQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AFUZTEUt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DA1CB40AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754931645; bh=WTFzAFPn1a9qI2BOH7lZX+Br9yJcFtU5QZnHQb2WBng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AFUZTEUt3DQ19EsDrlU6OA5AjZeuCutryOv/w4On9iZlmE4uUUKJvQcO0osxvCOs7
	 NCYz+qfkAN/jROf/pgEdacfVGMWG/P/xApMb+A+OaEFhC+wzPJcAgUeeWUqtM/H3HF
	 CNLtQ3IMpl4ueNXVasiQ70L1QO+99JJZSUBKo6F67WP1CSp7yTNoQjPpEz7XlDXep1
	 Sphb+z3JRjmvH9KrsqNlOgj7Pru6ivUSpMqqKYKsRhbE2jYPQ3Uw13xp7gv48AtqsQ
	 ML2N9lu4f8LKNuSEFy9XG/OejWJYjwLv4I1kJv/SA/N/SOU7FpV+K2eJtSkgNGv5se
	 bvAnMVsMNh+8w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DA1CB40AD2;
	Mon, 11 Aug 2025 17:00:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] Documentation/printf: Use literal fwnode_handle
In-Reply-To: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
References: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
Date: Mon, 11 Aug 2025 11:00:44 -0600
Message-ID: <87ldnpeqtf.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> When looking for fwnode_handle in the printk format documentation, it is
> only found in the Chinese translation:
>
>     $ git grep fwnode_handle -- Documentation/*printk-formats.rst
>     Documentation/translations/zh_CN/core-api/printk-formats.rst:=E7=94=
=A8=E4=BA=8E=E6=89=93=E5=8D=B0fwnode_handles=E7=9A=84=E6=B6=88=E6=81=AF=E3=
=80=82=E9=BB=98=E8=AE=A4=E6=83=85=E5=86=B5=E4=B8=8B=E6=98=AF=E6=89=93=E5=8D=
=B0=E5=AE=8C=E6=95=B4=E7=9A=84=E8=8A=82=E7=82=B9=E5=90=8D=E7=A7=B0=EF=BC=8C=
=E5=8C=85=E6=8B=AC=E8=B7=AF=E5=BE=84=E3=80=82
>
> This happens because the original documentation talks about "fwnode
> handles", without mentioning the actual type name.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/core-api/printk-formats.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/co=
re-api/printk-formats.rst
> index 4b7f3646ec6ce028..7f2f11b482865175 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -521,7 +521,7 @@ Fwnode handles
>=20=20
>  	%pfw[fP]
>=20=20
> -For printing information on fwnode handles. The default is to print the =
full
> +For printing information on an fwnode_handle. The default is to print th=
e full
>  node name, including the path. The modifiers are functionally equivalent=
 to

Applied, thanks.

jon

