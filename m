Return-Path: <linux-kernel+bounces-794927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09455B3EADC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0549D484648
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE742DF127;
	Mon,  1 Sep 2025 15:21:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110735A2AB;
	Mon,  1 Sep 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740099; cv=none; b=YuYh7GCZlMQiZH15TeZtapBWNmVU6u/odEUhP98FbNvq9Bn9bXez/zX4T4yGp6x9jKZPJCJzFDEUa1SYJUyaPOpK3rIfjkPOx5wlwzRKZA1wV8Spp8mjQJGrAquyNq19XODRty8SVvJFAzcjV4rFaeAymw+tWnn9+enouw7cXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740099; c=relaxed/simple;
	bh=1zFDSt4FU/dgpJY/24qF59h/idw2S/LOG6SW1eTsmqI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AJgIRW8ICcra+6GrlA/RDKXvFQB3NXcEtunddtVY3DnebD8O67eIG+1nqzShQByZXdl2FeywF9RVB6FU5WVerbhOqCvMzoALT8gDlZKEz6aZX75BOsj4m2z9h3DanQBz4fdVm5ftm0lPQyIuPkKGfiA04j02tvo9jv9g1UZ84Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75E8C4CEF0;
	Mon,  1 Sep 2025 15:21:38 +0000 (UTC)
Message-ID: <5c616645-cbfe-4c7d-b4bd-72497a90f497@kernel.og>
Date: Mon, 1 Sep 2025 10:21:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/4] firmware: stratix10-svc: Add for SDM
 mailbox doorbell interrupt
From: Dinh Nguyen <dinguyen@kernel.og>
To: mahesh.rao@altera.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
 <20250812-sip_svc_irq-v2-4-53098e11705a@altera.com>
 <f2411365-9443-43cf-8420-3afd2c5bf6e2@kernel.og>
Content-Language: en-US
In-Reply-To: <f2411365-9443-43cf-8420-3afd2c5bf6e2@kernel.og>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/1/25 10:16, Dinh Nguyen wrote:
> 
> 
> On 8/12/25 07:59, Mahesh Rao via B4 Relay wrote:
>> From: Mahesh Rao <mahesh.rao@altera.com>
>>
>> Add support for SDM (Secure Device Manager) mailbox
>> doorbell interrupt for async transactions. On interrupt,
>> a workqueue is triggered which polls the ATF for
>> pending responses and retrieves the bitmap of all
>> retrieved and unprocessed transaction ids of mailbox
>> responses from SDM. It then triggers the corresponding
>> registered callbacks.
> 
> You should configure your editor to use a full 80-char width. Why stop
> at ~50? When you're unsure, look at that other commit logs from other
> developers. If yours doesn't look similar, its probably a problem. For
> example:
> 
> "Add support for SDM (Secure Device Manager) mailbox doorbell interrupt
> for async transactions. On interrupt, a workqueue is triggered which
> polls the ATF for pending responses and retrieves the bitmap of all
> retrieved and unprocessed transaction ids of mailbox responses from SDM.
> It then triggers the corresponding registered callbacks."
> 
>>
>> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> ---

<snip>

>> @@ -1784,13 +1874,14 @@ static int stratix10_svc_async_init(struct 
>> stratix10_svc_controller *controller)
>>    *                            service controller
>>    * @ctrl: Pointer to the stratix10_svc_controller structure
>>    *
>> - * This function performs the necessary cleanup for the asynchronous
>> - * service controller. It checks if the controller is valid and if it
>> - * has been initialized. It then locks the transaction list and safely
>> - * removes and deallocates each handler in the list. The function also
>> - * removes any asynchronous clients associated with the controller's
>> - * channels and destroys the asynchronous ID pool. Finally, it resets
>> - * the asynchronous ID pool and invoke function pointers to NULL.
>> + * This function performs the necessary cleanup for the asynchronous 
>> service
>> + * controller. It checks if the controller is valid and if it has been
>> + * initialized. Also If the controller has an IRQ assigned, it frees 
>> the IRQ
>> + * and flushes any pending asynchronous work. It then locks the 
>> transaction
>> + * list and safely removes and deallocates each handler in the list.
>> + * The function also removes any asynchronous clients associated with 
>> the
>> + * controller's channels and destroys the asynchronous ID pool. 
>> Finally, it
>> + * resets the asynchronous ID pool and invoke function pointers to NULL.
> 
> Did you mean to repeat the same paragraph twice?
> 

Ignore this comment...

