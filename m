Return-Path: <linux-kernel+bounces-631762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F90AA8D12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DE1892B96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC81DDA20;
	Mon,  5 May 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="VcDnuSoI"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E17136E37;
	Mon,  5 May 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430293; cv=none; b=YSaL1qhAGiaNXWZN+9IjIAkKDm87L7A7uRlscw6cKoFGNYvQrr5EbT694Retke74eMb/eTdNpjYGKtqNqe063goydHtmkQAA2BGVvfDiLfm59aBYEiR7eixVyh16WZh57UxPeCIvuhNfQPwxpQwTKRHFpSeNe7TZ8sNm0hREtOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430293; c=relaxed/simple;
	bh=Mia/6VlHw5H79UAsyq5sOlhQsmih26rtUgQ342pP3aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1jnPB+fcUNIYK9Un3gUdK9ZnWf7nUqD3BmECeKyTQvRrgVM6ZC/R41RIk+/L7QwJU3U2fXsOhlxiYX12Rl7r+8E1e4piF7nb6cbuX8coWT439Q/QguzS6h68OweYqJPC0DOQpyjUwAaKoHJdscfq2RrKdYP85OcCU04FHVlq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=VcDnuSoI; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 913782FC0052;
	Mon,  5 May 2025 09:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1746429830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07oOkTCvQFL5GUAR5rE5mpJ+wpoj6c+pTk7+hEK1LDg=;
	b=VcDnuSoIuWKV/CeeXL2natKA2xc8NaDrR5D9AD/uk068SL9cB+1x0uHznpmi9VRav1iyGB
	qRUB5ZaqrUfY65WGya0+X9QaQCzpXRqbJwGKAnI6GhtQSAgKQCSbe+rwvCzXYUBvb83GqV
	J+wcSMaFLEhtrPU1kmjslMk/CnxIK+w=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <a1000849-6744-4362-a998-1eaa80adbf86@tuxedocomputers.com>
Date: Mon, 5 May 2025 09:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/1] platform/x86/tuxedo: Add virtual LampArray for
 TUXEDO NB04 devices
To: Pavel Machek <pavel@ucw.cz>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250423153804.64395-1-wse@tuxedocomputers.com>
 <aAyWs6XJXc4g1lDb@duo.ucw.cz>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <aAyWs6XJXc4g1lDb@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 26.04.25 um 10:17 schrieb Pavel Machek:
> On Wed 2025-04-23 17:33:09, Werner Sembach wrote:
>> @Ilpos you can ignore my small question from my last e-mail. The spec file
>> of the firmware wants the struct to be zeroed (albeit it does also work if
>> not) so I implemented it like that.
> You forgot to cc me.
>
> Anyway, lets not do this. Kernel should have real interfaces, not
> crazy tables to emulate Microsoft interface noone else uses.

The HID standard is not a "Microsoft interface noone else uses."

Best regards,

Werner

>
> NAK.
>
> 									Pavel

