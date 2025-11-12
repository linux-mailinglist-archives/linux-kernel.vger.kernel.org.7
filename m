Return-Path: <linux-kernel+bounces-897565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E175AC5383D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17BA563E04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61D340280;
	Wed, 12 Nov 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jhYIWBml"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC933E37B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961251; cv=none; b=eT5jkOxf7eWUibyLf8OBsPbowi7XZy6CufW15HI1TwYRVW3h8raZrTun2EGdSFXLCRwMjeaqb+41CE3IucxIqULgWacNoZ9bKTqLog9N3LvhaLmn4Vff1kO/UNAJDO9ywo4/c4QsmZv73Wn8X+N1X1Fw3LwAk/MOOSEN+F7pLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961251; c=relaxed/simple;
	bh=k8Xbh93K326Q294BpfNudl6MAbWI+uk6DZXLupxhhRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUXWz1nlGu5lbZcXtg8ZsEbUhFMJ5TWDLbvDg3iRCpc+hiJIT4bHtcFaeTgvIxaBKFyy9jtvpLLk6F6T9v/sj65A621KeicP7nNZFuO4w8llX1dctrQkvWULWiI/tLAT3+3w0aG4FNcQBgs4/aMLvJkt3wspo5AVNepNQZnH99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jhYIWBml; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6bc8f48-9cfd-4d46-b105-6ef274c8f842@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762961237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs57aKC+dzCFz9S0pk+SxlPQNFMFAlzZlXYGwekxgog=;
	b=jhYIWBml0eWeuCpIzNoi5z9eDYktk558M4Lgh51ySKl3Tef7vGaQ/Nd+MU/Ge6dFGp3LDh
	hql/Ar9QyhUKzroMs8wjlNcpnKIyL8B8AnISMdHGYtOd8c0QdZq5H/dV9r/+UqXZ7v2yrq
	QV7umttP6dw/a2d26c8rpOS6gCYoQDs=
Date: Wed, 12 Nov 2025 15:27:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/7] ptp: ocp: A fix and refactoring
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 16:52, Andy Shevchenko wrote:

>    ptp: ocp: Sort headers alphabetically
>    ptp: ocp: don't use "proxy" headers
I don't see benefits of these 2 patches, what's the reason?

