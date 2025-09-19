Return-Path: <linux-kernel+bounces-824007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C9BB87EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8961C256FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB5248F57;
	Fri, 19 Sep 2025 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="E0LnbaDT"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FA221544;
	Fri, 19 Sep 2025 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758259577; cv=none; b=saDN/nl/l3VjEJO3gUTedvYo9Ozpw7/Dm6vxRE21XZJOkVJVSexAEl6gUChexgs1Us8HobcvExvtlr5hQXpE95BCMSqpzAd+/mxjxkA+tGXm65pL4iwJfVH//HGG8E87hX609+Xmr5Az1a6DsT6FZE5creKlg8XGXnAb9N1yLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758259577; c=relaxed/simple;
	bh=6r4jkJdeIG14qcprpmzE8FnhltEYwQM6z8RdBo+8MmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LykZixHT971YN2BvBV/hO0DOorjOMFva7IMihLud1VZXQnxIGuT2XlVjblVZILu/4gc94wzwMP0MqWwnBzyxXWkz4fGIcrkRlIs5ZxuDyos64hPaKk0J/l+lKRZnPxhB5TEHZBVfY1MGMQL6qYe32Omjs8NApu/jYxyNamtzBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=E0LnbaDT; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=APGCrIWwUZU9xTDPwf41AxSbF6mMd4oZliNSkrRCWfU=; t=1758259576;
	x=1758691576; b=E0LnbaDTEDAHZ2z19Jlgwg6R95IRWMenyiYw5FsKwJqOIZ966LAL9Iuzpsdt/
	aU4YEzXip1wfFh9z+GWPoStv02bZHjrsPQmmyYe+8Q+MXZ3rSHtn+8OsOPXka9TFD340+b2V8aXEX
	1EaNAUHrltMyOwGgRPEOYh82hiISsO3DTnuOMUr75PAElqjcSD+y1NpYbu3aQpjl4vUaAX/RmjWA+
	9O6yq4pBVha37WdFT6ntlMg1yh9heY/0qgIFXdQSVYo8g9a9Efmgpm0hBDeh6ZfdQkrSvD/9rQPEu
	Mn2WCm/lpeHfKjT3URG9rBQ29lTIhqzTIbE3Q2ihBeEk4322yQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uzTdH-00E6Rr-12;
	Fri, 19 Sep 2025 07:26:07 +0200
Message-ID: <b8c4ed52-260d-4963-8d8f-4976229dd4e5@leemhuis.info>
Date: Fri, 19 Sep 2025 07:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build break due to merge commit in linux-next 20250916
To: Christian Heusel <christian@heusel.eu>, Mark Brown <broonie@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Bert Karwatzki <spasswolf@web.de>
References: <0fee48bb-7411-4414-b4e7-395a8c3d0f6c@heusel.eu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <0fee48bb-7411-4414-b4e7-395a8c3d0f6c@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1758259576;a749e26e;
X-HE-SMSGID: 1uzTdH-00E6Rr-12

CCing Bert, who ran into a similar problem and send a similar patch.

On 16.09.25 16:45, Christian Heusel wrote:
> 
> I have noticed that the recent linux-next release fails to build due to
> a syntax error in the rust code:
> 
>       EXPORTS rust/exports_bindings_generated.h
>       RUSTC L rust/kernel.o
>     error: expected one of `,` or `}`, found `;`
>       --> rust/kernel/block/mq/gen_disk.rs:12:23
>        |
>     12 |     fmt::{self, Write};
>        |                       ^
>        |                       |
>        |                       expected one of `,` or `}`
>        |                       help: missing `,`
> 
>     error: aborting due to 1 previous error
> 
>     make[2]: *** [rust/Makefile:553: rust/kernel.o] Error 1
> 
> It seems like this error was introduced in 6e86e08cdc19 ("Merge branch
> 'rust-next' of https://github.com/Rust-for-Linux/linux.git") and
> introduced with the merge, the attached patch fixes it.

Mark, that error from next-20250916 was gone in next-20250917, but came
back with next-20250918 yesterday. Maybe due to something git rerere had
recorded? But whatever, just wanted to let you know.

Ciao, Thorsten

