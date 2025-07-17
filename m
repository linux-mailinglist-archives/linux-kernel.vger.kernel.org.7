Return-Path: <linux-kernel+bounces-735931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091EB09577
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BDB17DEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74CD2253BC;
	Thu, 17 Jul 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OMYv7235"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7181223DCE;
	Thu, 17 Jul 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782910; cv=none; b=Ph5nJYlEd+0a5swrjCjoZKravDeAwtqV+zVFErvzfcSPlLrh2N1LMNlcaf6Qpvuogc3Mdq/miY5aQRHO9qfc0FRjKg47RVZ7TgJimTU5ZQmR42nNY8hWbqJz0EMELdxptG8xZmn7En1nzPfp1df3+QSLkk9goM3kfBnhlSOdV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782910; c=relaxed/simple;
	bh=nTpjYF7OS2BfN5+r0VIu6Sj2KcuDF69GVm+Mkzpj8hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVR/lGezP2lHnFNuZV0/qxfELWh+ry084/ngfUDIbq1qC5viNn+l95iD3fOcZD+nmn8CWUiHBLp7ZXvA1W6N+X8KLLfc/dnUjyLs2wvWKtbBr5HyVjXg/wopXTUUmJlYjlFrNj7iJ2Pb8ODuoXzgoEU/UFRTOq3Gdg+nHHpd5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OMYv7235; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 245CD403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752782908; bh=I9SR1/DU9UKPIoxKbVay4GFVE4kiXvXdOhs5xJVcEMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OMYv7235y0rkOW2We8V/5ZO1W5xIb3gg0gYEnDM/FjmSWQkhiufhy7ReQ03BB3FFd
	 AtZctJs2OkmXrl0uV/DtfcQwRXxha6tWge/Bq+VWysYZNfLoZBOtLvMPTq6U0EE5Ep
	 3n8dGqcOPxDwj2H8Gne+C8pi/n/W8RaslIT+hbOjdVbNeUSnbhYP21bPX5cspi9OUT
	 1Voa07sL2zBo3yzqjHrlrH0SnuEQydfRaiP+JDuLfVTloEgoeahYCeGwQKOc4QuXnr
	 NLOOM1Tgxng6ifSmUbtzDU5HDFGAK1rEul+qORi3BZhLnZiORwRzPEp4xdcqgkP20T
	 9Y/a74iT6AKsg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 245CD403E1;
	Thu, 17 Jul 2025 20:08:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>, dzm91@hust.edu.cn,
 si.yanteng@linux.dev, zhiyuzhang999@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts: add origin commit identification based on
 specific patterns
In-Reply-To: <20250713163418.1459-1-zhiyuzhang999@gmail.com>
References: <20250713163418.1459-1-zhiyuzhang999@gmail.com>
Date: Thu, 17 Jul 2025 14:08:27 -0600
Message-ID: <87o6tia8ck.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:

> This patch adds the functionability to smartly identify origin commit
> of the translation by matching the following patterns in commit log:
> 1) update to commit HASH
> 2) Update the translation through commit HASH
> If no such pattern is found, script will obey the original workflow.
>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> ---
>  scripts/checktransupdate.py | 38 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)

So I don't have any objection to this, but wouldn't mind hearing from
folks who actually use this script - has anybody else tested it out?

Thanks,

jon

