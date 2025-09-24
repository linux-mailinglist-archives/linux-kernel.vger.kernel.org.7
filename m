Return-Path: <linux-kernel+bounces-830942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F6B9AF65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD32B16ADFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60817314B9F;
	Wed, 24 Sep 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U+sAnOZn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684128153D;
	Wed, 24 Sep 2025 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733320; cv=none; b=lovDqnVUmpj7oF8o70QwOCdeQYkkcl6IvgwORWMA2zeZ+E94Fk1/+tEq1yZu2NzKS7A8D9i13PVLyCQfqiZgSiac2e5eWzyjdJ1dDyRT+zZUGeHIEg+ZBfJEhyPr0d8dt/Bz+f4p5zk7qQDo0PR/8jlK34tfZiqFEpz19GUWBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733320; c=relaxed/simple;
	bh=8IvBnzK5ylc3xa78RjdmvwnioZ45Ia7e7oq7Ndcyik0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fzM6Q4cr1b3pmXhyG9PoltxDQDC9Urnehxap1NAn956q3i5HJGFMF8Vw6FW9WEb9/eJPJCiZltwgH8yMvnyWNSVAtdW41LNJ0MsTOrHdg6RsfkeFCc/IOlhXLCIuidr+DaP4J+g1ypqS7vq7AxtZpx1lb6AMuDmP2Efc3RDUh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U+sAnOZn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758733316;
	bh=8IvBnzK5ylc3xa78RjdmvwnioZ45Ia7e7oq7Ndcyik0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=U+sAnOZnqFVS6Zp1cLMJajGSmaiXDbR1w1oC43liIPxMz1twrM1DkRlTzICJPvRdV
	 3NRpU4P899W3PpyrD1rT7fz3KwdUBO8EyAqmhT8P2jq9RLdF9Vr1s6WgxQVCcbS6X1
	 RfXB0ZDNwEjOjZ0jhPPW/IcpZIVZO4+no5m8vj7v3gHGVvT6WsZurTzZcGvpqCVPqw
	 Km5cps81E9Pj6b6p993h3rmqi0eugbzz670U1ZiQwHrHjq/IQvo/wTtW9mmIR9U4qu
	 Nef/5Dk54GCoMxUlt6TN0XTe3/FxvYrCCGqhU41YKjKjbO9y+ncTDmbL3RPHsKZ7lu
	 hodQyx00HTzyg==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BB1617E12DA;
	Wed, 24 Sep 2025 19:01:56 +0200 (CEST)
Message-ID: <71b47ce7-a799-42f1-acc7-e59e6ce13884@collabora.com>
Date: Wed, 24 Sep 2025 20:01:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: vhci-hcd: Prevent suspending virtually attached
 devices
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902-vhci-hcd-suspend-fix-v3-1-864e4e833559@collabora.com>
Content-Language: en-US
In-Reply-To: <20250902-vhci-hcd-suspend-fix-v3-1-864e4e833559@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/2/25 3:15 PM, Cristian Ciocaltea wrote:
> The VHCI platform driver aims to forbid entering system suspend when at
> least one of the virtual USB ports are bound to an active USB/IP
> connection.
> 
> However, in some cases, the detection logic doesn't work reliably, i.e.
> when all devices attached to the virtual root hub have been already
> suspended, leading to a broken suspend state, with unrecoverable resume.
> 
> Ensure the virtually attached devices do not enter suspend by setting
> the syscore PM flag.  Note this is currently limited to the client side
> only, since the server side doesn't implement system suspend prevention.
> 
> Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
> prevent entering system suspend when at least one remote device is
> attached to the virtual USB root hub.
> 
> However, in some cases, the detection logic for active USB/IP
> connections doesn't seem to work reliably, e.g. when all devices
> attached to the virtual hub have been already suspended.  This will
> normally lead to a broken suspend state, with unrecoverable resume.
> 
> The first patch of the series provides a workaround to ensure the
> virtually attached devices do not enter suspend.  Note this is currently
> limited to the client side (vhci_hcd) only, since the server side
> (usbip_host) doesn't implement system suspend prevention.
> 
> IMPORTANT:
> 
> Please note commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
> suspending children") from v6.16-rc1 introduced a regression which
> breaks the suspend cancellation and hangs the system.
> 
> A fix [1] has been already provided, which also landed soon after in
> v6.16-rc7 under commit ebd6884167ea ("PM: sleep: Update power.completion
> for all devices on errors").
> 
> [1] https://lore.kernel.org/all/6191258.lOV4Wx5bFT@rjwysocki.net/
> ---
> Changes in v3:
> - Moved all driver cleanup patches to a separate series:
>   https://lore.kernel.org/all/20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com/
> - Replaced FIXME with NOTE in the new comment block, as it refers to a
>   potential cleanup of redundant code rather than addressing a
>   functional issue
> - Rebased remaining patch onto next-20250902
> - Link to v2: https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com

Just a kind reminder in case there's still a chance to get this and/or the
cleanup patches queued for v6.18.

Thanks,
Cristian

