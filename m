Return-Path: <linux-kernel+bounces-729961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AEFB03E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F214A4B54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1D253F1D;
	Mon, 14 Jul 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uv0b/mnJ"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E62229B16
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494776; cv=none; b=siv28w/3P24Gx61nZZmBUUsS8P6CATUDvEEM3AU2gYYdO/qysgig/xHv08uTy3knXc/q3u1PlWaP8u7/wRf/vWvmiul7I+5IuJoyDY61SW1k2EzH6Li6jyiRXVxjX3G+N5GNhbJQiWh+87a1OO8FduestZqxn0iJt4w6/8TirEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494776; c=relaxed/simple;
	bh=KhvodG7UPM4KmPvjXDLJRXih060ZGfuKaf5+gHJ+sEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTB9CDSDBDnjcqTMwSt5j02/U6FAUeZEZkcfrMqThQT3IFc6qmN+uZANMaV0F4RNm6NXMZJKu8Gtlundlq0VBNnulwiXi3FtNpAc0Q1s4Oag6ScPxf2bzY0ks/aA9UeYRiiRh3ccknqpd7fXavIcMNlbMwd1R/rEkZCjmFzaajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uv0b/mnJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2a231c2-43c3-4027-bcc7-674955e5ba3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752494761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3l4SjgR+dr12WvJvDbrOO5yU63BAL466Fxwff8lUU9E=;
	b=uv0b/mnJHcQAOFBxD9qhY6ic/RpYOck+TS/2jkWxc0Io2leTccD+sA+jF88y4vtlUaZQDA
	U+tvzSkhXuLSdAWKM2upBS7s+4A3KFtLTlWut8sppStDUA6gAkIObeznwKxKr1rQSMoUWK
	4YIW0QoYhQnW+Of5duicolaBuHrcU+Y=
Date: Mon, 14 Jul 2025 20:05:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] netfilter: load nf_log_syslog on enabling
 nf_conntrack_log_invalid
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, coreteam@netfilter.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kadlec@netfilter.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, zi.li@linux.dev,
 Lance Yang <ioworker0@gmail.com>
References: <20250526085902.36467-1-lance.yang@linux.dev>
 <aDbt9Iw8G6A-tV9R@strlen.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aDbt9Iw8G6A-tV9R@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/5/28 19:05, Florian Westphal wrote:
> Lance Yang <ioworker0@gmail.com> wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When no logger is registered, nf_conntrack_log_invalid fails to log invalid
>> packets, leaving users unaware of actual invalid traffic. Improve this by
>> loading nf_log_syslog, similar to how 'iptables -I FORWARD 1 -m conntrack
>> --ctstate INVALID -j LOG' triggers it.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

A gentle reminder for this patch, as the merge window is approaching ;)
Please let me know if any changes are needed.

Thanks,
Lance


