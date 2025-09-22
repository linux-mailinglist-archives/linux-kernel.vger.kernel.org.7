Return-Path: <linux-kernel+bounces-827708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327D7B92763
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D6E1904A58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F758316189;
	Mon, 22 Sep 2025 17:42:42 +0000 (UTC)
Received: from aero2k.de (aero2k.de [49.12.35.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF577285CA2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562962; cv=none; b=D5z9tkS00V30WY/2ZTT2YLCkYuuiNK21WrqYPXzQGwE82Md6Uo6c8rKmy4mQfNjEWHGj+6iQotIFEppSNFhR5TeLSENMK6+Pcc5UwhsSKmSIeufQyEJ8ITHeEouCCLuV+YqqcquTQeciIyIQNZAGJkdLsPZhHIriarr6aR1jpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562962; c=relaxed/simple;
	bh=+z8laoByDF+J7usdfNvnaPQnu7QjnH2bfkPSXSXSC2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQO5pvvYXWcMtVqk4eD2Biuif93POm1ZLGp0hPydPS3Lsx/dEZ9HKiJ1wg3YivfwNOoVV86FBYKPeM4zl++4s2txBN5x04DtsgPQ9/LA1IVn6cUMQhhuQ0snIBgXC2g+mdQLyVNwTBzREHbPAt/bAHLPExTrUAw6djNSgdZogQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aero2k.de; spf=pass smtp.mailfrom=aero2k.de; arc=none smtp.client-ip=49.12.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aero2k.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aero2k.de
Received: from [IPV6:2a02:8071:73d0:11f0:9c03:26ff:fe9c:2a6a] (unknown [IPv6:2a02:8071:73d0:11f0:9c03:26ff:fe9c:2a6a])
	by aero2k.de (Postfix) with ESMTPSA id 8265B22325;
	Mon, 22 Sep 2025 19:33:05 +0200 (CEST)
Message-ID: <60c824f2-667f-4957-bfe1-145a79e01ac5@aero2k.de>
Date: Mon, 22 Sep 2025 19:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: 1111027@bugs.debian.org, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>
 <2pdp3kq4qebdxizprbnaq6omh4dvxdlktokvr37b7nlkf4po3b@fxzmgmi47wxx>
Content-Language: en-US
From: Thorsten Sperber <lists+debian@aero2k.de>
In-Reply-To: <2pdp3kq4qebdxizprbnaq6omh4dvxdlktokvr37b7nlkf4po3b@fxzmgmi47wxx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

thanks for your help. It's been four days now, I'd say above average (last was five days) - and no crash yet. I'm going to wait at least until the weekend before naming a winner, but that's already looking pretty good.

Just to get things right: the machine stopped crashing fatally - I believe with the addition of intel_iommu=off. It starts flashing red, logs those errors in kernel buffer, but stays running. I'd like to backtrack that later on, maybe after the weekend, removing all params and seeing where things go. Unless you'd like me to test something else before that.

Best regards
Thorsten

On 9/18/25 10:57, Uwe Kleine-König wrote:
> Hello Thorsten,
>
> after writing the mail to Rafael Thomas provided the idea on irc to test
> using
>
> 	intel_idle.max_cstate=2
>
> (or =1 or =0) on the kernel command line given that the splat hints at
> this happening for C3.
>
> Can you please add this (with =2) to your bootloader and if the problem
> happens again, tell us here and reduce the number further?
>
> Best regards
> Uwe

