Return-Path: <linux-kernel+bounces-859877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79749BEEDBE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 126214E3346
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BFC23B605;
	Sun, 19 Oct 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yki1CazC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166D7483;
	Sun, 19 Oct 2025 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760910367; cv=none; b=k6MPXT8IogftafgSZgImZPUlH3hnvRyaReP7O7FmUSmC9dNFiLb51wEBcqfTsoDP2StlershoCaOf45ybY8boZELOQtdFmY+ThvTDfqShrIqwFqjBtorjN8jIh1/vxxX99e9IEIqYdi+m0mMrDeo04tAQSsQf5+SdaANGERgp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760910367; c=relaxed/simple;
	bh=Wo8sK6NoIVdkryEquQ9ETC3MVmO0q/Qudfc9HcMiv4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1tdijIprU67Njn0d/ZnSA7qNUViDbMS6dJ0QCydV5OkDvHYw41poYxQtcJc6OF1SEGTA/6ZCWzfTDiwMxnmiFEZT53s4XPerzajCCrM9SYAc1ymbBLn9FFJG21zzyZtoVk8hot0VgMEyk8qfkhc2NFlhEWJWTbTyn+yLbV10/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yki1CazC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yVGGrO4DDZjSgDZJPBGsRs7YtimUc3xMzrynnI6r79E=; b=Yki1CazC8THrQ6iZER6ZAXs0dJ
	gYh+Qznv0TCAqWJPZuwYf6iUrWcdCqA4k9zLawZ+TYxuVa5ATSPzALTI7eSIVPzAj4bOQWdUDPi85
	+hNfb8qzVja5cg+Udex4WnVMQEFHHEHKmjQZ4BETNoit44tR0Yv+Wc8vJYwxgFeS10O+nA43jhAx8
	4PrGMgDxbmw27IUaciqeyZXSDCKehA81PftvU2HcLjVbOkblqWNvKm9WeTjWq9rCihz/2YlJVUg6Z
	1Y3C5i6YhM8JpujZEG4akrConDYO5REB8Livkkdi4QhvIrVgEdS3GgQKbXrV7CWH9kK2nbu+Gqcbt
	R+PGZ8cA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAbE1-0000000BTV9-1IFM;
	Sun, 19 Oct 2025 21:46:01 +0000
Message-ID: <aac01aad-b8e5-4d88-91b7-52d98e32809c@infradead.org>
Date: Sun, 19 Oct 2025 14:46:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: doc-guide: parse-headers.rst update its
 documentation
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <alexs@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org
References: <4da6a180fcbc107a0c15fafed4e1d57a70976876.1760869676.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4da6a180fcbc107a0c15fafed4e1d57a70976876.1760869676.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 10/19/25 3:28 AM, Mauro Carvalho Chehab wrote:
> Besides converting from Perl to Python, parse-headers has gained
> some new functionality and was moved to tools/docs.
> 
> Update its documentation accordingly.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/9391a0f0-7c92-42aa-8190-28255b22e131@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/doc-guide/parse-headers.rst     | 195 +++++++++---------
>  .../it_IT/doc-guide/parse-headers.rst         |   8 +-
>  .../zh_CN/doc-guide/parse-headers.rst         |   8 +-
>  3 files changed, 103 insertions(+), 108 deletions(-)


Thanks for updating this documentation.

Do you want grammar etc. corrections to it now or should I do that
after this is merged?

-- 
~Randy


