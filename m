Return-Path: <linux-kernel+bounces-744634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B86B10F68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2BE1CE572F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78922E8E0C;
	Thu, 24 Jul 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Rm6elYei"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66F1DF244
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373261; cv=none; b=KhmCRdev/+uo9W3779TrrZ+MOfsTqiqGj3PoznnZWmy9cfJHGC4cYKWXhf7LIXxGZsDAorKpYFYaFr2ATKrCom/13c+0ofoc31JobIH0GzoCH6dvAq/w6JbliBRSVpbY7Pn32INdOnRt27CLvjx7MrsXPID2T9uwU6VXBKSSLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373261; c=relaxed/simple;
	bh=+OtN7kun+/v8bL+X/qBJAQbJt6E5IsBweEEjq/w2Oe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX06rj9MuxZ3PMa4mabfLAX73jVb6T4huv8Pltg6r2fryW3TV4Wc976XvWUTi5rOeInZKS+UCLJYttyQCdXSJTY/jx9/kD5mPYB2UfgcdUyU/64VTNJUotMZgD69f2ja5NqW++LfTNGpD1yaOESVbV9ZwH7L0MOuqhWysMhT+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Rm6elYei; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bnwrV2qCBzlfdh7;
	Thu, 24 Jul 2025 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753373256; x=1755965257; bh=+OtN7kun+/v8bL+X/qBJAQbJ
	t6E5IsBweEEjq/w2Oe8=; b=Rm6elYeiBKN1FpRIaH0OA5AOMQIOPaobQ2z+D00T
	WmInGS3THNeEIeASaggWC81hVJgIs2Zo4+HTU4OjIjKo6B2ifbVSqAdkHdjAgOLs
	vKOxtwsjxaGMdPTjgWCgwMLKQyESEvmBaMJhqM4JqNCCDZ9qk+72Ny22LHhFlTWx
	VQY1ZQ5bFQ1+UJn2UyYsLaf+goHCwQ1WRtiBqJPSSfKdJ2/aWhVE3bwofdGIJd2W
	VeBsUaO3ytms8gcnP9juQWI1BDtuPJgA0FP7gHSYyuPCeuthG6upQPTjYx83NeJy
	IFBpgcDKyZWCRPAUYRdOuF7WGJgR2J+tNU/oOcD3s55fvQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BQDbTJaqtjWL; Thu, 24 Jul 2025 16:07:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bnwrM51CwzlgqVY;
	Thu, 24 Jul 2025 16:07:30 +0000 (UTC)
Message-ID: <58c289ef-770b-4524-b38d-ebdb51ccc8f4@acm.org>
Date: Thu, 24 Jul 2025 09:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme/host/pci: Fix the asynchronous detection
 issue of nvme devices
To: likunyu10 <likunyu10@163.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 likunyu15 <likunyu15@jd.com>
References: <20250720185154.138391-1-likunyu10@163.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250720185154.138391-1-likunyu10@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/25 11:51 AM, likunyu10 wrote:
> PROBE_PREFER_ASYNCHRONOUS asynchronous detection has a significant impact
> on important devices. For example, if a server has two or more nvme disk
> devices, it can cause disk loading disorder, which can also have a
> certain impact on actual production environments.

That's intentional. Please fix your user space code that uses hard-coded
NVMe block device names or introduce a mechanism in user space for block
devices that is similar to the predictable network interface names
mechanism. See also https://systemd.io/PREDICTABLE_INTERFACE_NAMES/.

Bart.

