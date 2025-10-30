Return-Path: <linux-kernel+bounces-877453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EECBC1E25B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E81C1893EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5A32B9A7;
	Thu, 30 Oct 2025 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="EbLknmts"
Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90E31A056
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792003; cv=none; b=g+vZr4Kdi6cjL9yWJobMeay4ZVhsXYC0eX96JDbNatE+G46/JOkjbjbN30CrRlYFWLOSkIckBCeS4ZjG60U0fUDq+r6Q8get7kXQovV7W9T7GVEwLSui0uawVsa4DTk7rxU83D3UulAZOGJLPvh9AA1fL18Vc7rO5snfOs4M+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792003; c=relaxed/simple;
	bh=ThNrNURslt67ENdzzidR8I57heYr+EHWMgLGfBYpWJk=;
	h=Mime-Version:References:Cc:Subject:Content-Type:To:From:
	 Message-Id:Date:In-Reply-To; b=k5iW9xqR14CocOglURVXP3htBoauTCSwc6cX2/ft/ju1/5PPmdDtE9p7lrX2GjwxQhEuw8jl23HZ2P+2Qjz9VGKuoZhJJtWVdFiLGEin13ufqw66fAcegtKmwm3npPKAE8WIE4vAeHH9YP5jfieTT+BDRqOY5FgdPSk4EdHB7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=EbLknmts; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761791994;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PpETjQCrXpmPKARG99vTEdxE6+OSeGvIljYABF1mUa0=;
 b=EbLknmtsU/GHUFe9NFvx2P8ovm2+TjEIpJ/aUlCWrR6wv3m/FaJ8RxTozL+xgTdlEjtiuX
 dn5e1blCzmydBeOqXN+UO28AouLM6Fsw+AST5TPlqxhcve2TvgDRtjjPG8wgtPl9ttQ/qZ
 KJBV6lIW/fC8F9kgCNf4SgJjMdg6R4eDNbwsIFIGAe6a/1+kIVLH/JqnXThLsbG9+fo9i5
 zA2l5/EJUnnr4gjRly/vzzPs9X+uLjNnaRps6DmZZ85IGnO0f+huiHIsSvDXNAkx0biFxZ
 9XXuTpz2xbHUw2fvbJK4LmF9VQW0mYzwEimmLhht/xX8uGTkjsm2AfR/yC+XDA==
Reply-To: yukuai@fnnas.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251027150433.18193-1-k@mgml.me> <20251027150433.18193-9-k@mgml.me>
Content-Transfer-Encoding: quoted-printable
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
Subject: Re: [PATCH v5 08/16] md/raid10: refactor handle_read_error()
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+26902cff8+b3b649+vger.kernel.org+yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Thu, 30 Oct 2025 10:39:51 +0800
Content-Type: text/plain; charset=UTF-8
To: "Kenta Akagi" <k@mgml.me>, "Song Liu" <song@kernel.org>, 
	"Shaohua Li" <shli@fb.com>, "Mariusz Tkaczyk" <mtkaczyk@kernel.org>, 
	"Guoqing Jiang" <jgq516@gmail.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <a203ac26-20be-4cd6-9969-860cf9878b94@fnnas.com>
Date: Thu, 30 Oct 2025 10:39:49 +0800
In-Reply-To: <20251027150433.18193-9-k@mgml.me>

=E5=9C=A8 2025/10/27 23:04, Kenta Akagi =E5=86=99=E9=81=93:

> For the failfast bio feature, the behavior of handle_read_error() will
> be changed in a subsequent commit, but refactor it first.
>
> This commit only refactors the code without functional changes. A
> subsequent commit will replace md_error() with md_cond_error()
> to implement proper failfast error handling.
>
> Signed-off-by: Kenta Akagi<k@mgml.me>
> ---
>   drivers/md/raid10.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

