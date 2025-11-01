Return-Path: <linux-kernel+bounces-881234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE6C27C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F663BF549
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1652F3C1D;
	Sat,  1 Nov 2025 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpjTaGHY"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BD1D5CF2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995956; cv=none; b=j4p00iQRjjGjzTp7MiSR58D/++YquxbUui2sgLPUOZ5umQrgLXwaZAnI1KgCBSwlR3fO0S/5yITMFjJ3UNuBRZyRWlKMClFMHERfqT7kVOh4tryNXtsQrugOD1PTTlYoBUsoflkFF65XkyaV8gGgeO4EjswySidg8dsw8Phzdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995956; c=relaxed/simple;
	bh=Le3ojftnvwAMSHGtZ12ti6v3tbFc6aZVtoSsbrZK5Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huUx/rYSWY1Anntm2h1tHSnrJKsGhchdPloqUzdKLUT1crYyxX+LwxMF2t/aLP2/8UKnAzCUptoDZxjmwlqW8k2zpE9IP39sEPqom7sZjHci3+utfZvZ+p/6BsoOfp3DmbEgPT6MIfC6XCjhIjQ8BZ8n5HDBDVDyhoGQRk9wAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpjTaGHY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9193e49a-b7e8-4a45-ab30-c7308f8e9d75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761995941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybok/k/EaCYbs1jQUTE3ffytqk49cuVoxPSAGtQzHbQ=;
	b=cpjTaGHY7o2jQE5u/jerXx9XdI2PXlkTRisB8iKajAYMm0GwGn0yOoY8R5DNR6zACa0Zka
	UqGye6yTsmhpENccIdneKZZVPgPR+iHVY6oWOZvQhasHgex4lqYLLCQEiFhXFooN6a3m3K
	HbD49XO+sOgUa11l1DQG4XXc3taP5Wo=
Date: Sat, 1 Nov 2025 11:18:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Add newline to sysfs attribute output
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
 <20251031165903.4b94aa66@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251031165903.4b94aa66@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/10/2025 23:59, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 20:45:19 +0800 Zhongqiu Han wrote:
>> Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
>> This aligns with common kernel conventions and improves readability for
>> userspace tools that expect newline-terminated values.
> 
> Vadim? Is the backward compat here a concern?

I'm checking our software now, hopefully it will not break, but I need a
bit of time to be sure

