Return-Path: <linux-kernel+bounces-774140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A136BB2AF02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1FF4E67FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE032C311;
	Mon, 18 Aug 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TFGovbOF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A632C304;
	Mon, 18 Aug 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536881; cv=none; b=rQmXwQFwPl+1nkaeJVv3rLNdNnICCv3ug18Rsk9uHrOvpi/QKU99K3N7pELTZHtoM4Np4sUF6Sxb4C7iGDx54mVzKpPzWUh8Gloqrp4YsZyTRDZyqWoqmhFw3Yk3jfLwnsNvJykGxuDJgsnIHqav9QY0NtqWDV0W+BJ/GlT1hHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536881; c=relaxed/simple;
	bh=3HIX8xBft0wT7KpvML4CREs5ghLtKYmEz8RLBPEHaF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZ78AVoBPXQy0R8eHG0Y8JV65+ZrJSOYFmpaGrBqqCLSJZShLz/Mqh0+m1x2f7gE0jjshetNzr9+HTsqZyAuXkveT1/Hx/42eocCZlAiDFypUUo3Mda2SpGsp8wWJeVwD534WqJkfhL6YNrkVGuoGnMHAPyVcppfGJEg3us5Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=TFGovbOF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 16AD540AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755536879; bh=pJLU23dJ8UZqkLglKDXDhtJiJ2cETKYaZ8oMIDK736g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TFGovbOFisyx6lhFQLySC25yp83WJWP6QCl+HdrBA0KOp5eEjox96MiB+gxzDwJ6H
	 gOJC65JZ4tnvuyO5KKhjZJtoldgl3mpoXnOgqAsMmsWRrJyFwTjezsZhMcHT/W5oli
	 MQGdCqe1mPQ83m+xswyW1OzkBgJBNYNbXi2YakzXiOEYsFUFINpnBGMciWyfQwruLp
	 2ArDfb5wDKucPooT7cxl+D2bgf10ANAepWroQqrI50CuyC83kkURtOSZCEZA8tjZpG
	 +qSUaZl7FnSOX4iwDP7emM3O708OVZvIdyZOB4y7b/azVQM/swJXT0xMa72rqaQLiE
	 bbYeA2+lM0+2A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 16AD540AB4;
	Mon, 18 Aug 2025 17:07:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
In-Reply-To: <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
Date: Mon, 18 Aug 2025 11:07:58 -0600
Message-ID: <87y0rg7e35.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Ah, I have finally understood what 5/11 is trying to do.
>
> Its changelog mainly talks about an issue you saw after adding options
> to xindy in that same commit, and you added
>
>    \newfontfamily\headingfont{DejaVu Serif}
>
> to resolve it.
>
> Current changelog didn't make sense at all for me.
>
> Can you please reword it and make it easier to follow?
>
> With that, feel free to add my
>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

So, if I have managed to understand this conversation, this reword is
all we need to get this series merged..?

Thanks,

jon

