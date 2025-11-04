Return-Path: <linux-kernel+bounces-885478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB0C3316C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E399D188DF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A221FF45;
	Tue,  4 Nov 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QT2Brp8Q"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849532AC17
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762292062; cv=none; b=PmYl7a09ClGgjxVFzCkjSMLYRWnFhmuSL8xkpoiyPAoy/72o7ta+4Ruq4sGTzD3/VGq7o+EmbF3SNFMIHUNZk+QDBA4Dv6xmExGnXXlEEME0Ak1PfpX7eM/bN/ZNKnjgc1JhJfmkzREJ21sjFIrfplkIUz6HqEJVJLt1brKeeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762292062; c=relaxed/simple;
	bh=ycILqtBrjB4qGUP9x609zQaceV8q5qkag9tfFN86/fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+oF0Bh7DT/YVsMvw1pknKYr3lgUwZQpqD5i1n1rUXHPQ2JL1e/WBKqW0oKRMRDinEZLjQYnXt97Apl12ruWD0b2IB+aA1PI9iTKqXJNYJh49cddPT3OBID+Mpasut5DolsNOEb3ab4f3992R+fsrv5DAKVvJl3jXkHaRKGRTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QT2Brp8Q; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d1MCk0hwdz9v6t;
	Tue,  4 Nov 2025 22:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762292050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+dDwJ+0qI41d3Nk94wkdQOdtSTxFTbLoEYJNyRM9I0=;
	b=QT2Brp8Q4z/2gGipDpcjXBAthS1OVn4Df9xhyWHNQm4oZP0QohMcTVAuZBaTrh0t0R+pAe
	rBUWOSJP6ZJ+g2PkpIWoSuh4AeYMZ6YVcEkuSdlUQ48y4e5xXF8yS5OWGASlLSt+/bx9FV
	7i6C7On0YWeSViNFa5iMJzKilnWLLMNDp62kuKSuUJk8HwlRtGZdfh7lXjRzHNYCBUMPrk
	XqLXOGK1J4cwMYbazUxDiQ4aw/NkuRVtWzU67PrkmWu+ZzDyL0OTMI4Z8DoSCKRy3IP7of
	g1271tbxUxrTwgTo4E3mW4kWqB8SZE4NAydV9YNdSDUMZ5AkjJpLp4nuyCu7Kw==
Message-ID: <4ac9dd98-adc8-4be9-9f5c-4e653f656453@mailbox.org>
Date: Tue, 4 Nov 2025 22:34:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/etnaviv: add HWDB entry for GC8000 Nano Ultra VIP
 r6205
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250919183042.273687-1-marek.vasut@mailbox.org>
 <CAH9NwWcK_z_4CcDBRYS2nf3AxYV9-XwirvTd+O9uJtHMhyA3Og@mail.gmail.com>
 <CAH9NwWdkjpV5YHmOpuCE=f7RVm1kXzqAOgN6=Sx1s-wxO_SGGA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH9NwWdkjpV5YHmOpuCE=f7RVm1kXzqAOgN6=Sx1s-wxO_SGGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hgewqfoan3j377woijwwhgfm6xd9jmht
X-MBO-RS-ID: 6c9625f36239ef4b00f

On 11/4/25 4:50 PM, Christian Gmeiner wrote:
>>> This is the GPU/NPU combined device found on the ST STM32MP25 SoC.
>>> Feature bits taken from the downstream kernel driver 6.4.21.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>>
>> Acked-by: Christian Gmeiner <cgmeiner@igalia.com>
>>
>>> ---
>>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: etnaviv@lists.freedesktop.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
>>> index 8665f2658d51b..32d710baf17fe 100644
>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
>>> @@ -196,6 +196,38 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>>>                  .minor_features10 = 0x90044250,
>>>                  .minor_features11 = 0x00000024,
>>>          },
>>> +       {
>>> +               .model = 0x8000,
>>> +               .revision = 0x6205,
>>> +               .product_id = 0x80003,
>>> +               .customer_id = 0x15,
>>> +               .eco_id = 0,
>>> +               .stream_count = 16,
>>> +               .register_max = 64,
>>> +               .thread_count = 512,
>>> +               .shader_core_count = 2,
>>> +               .nn_core_count = 2,
>>> +               .vertex_cache_size = 16,
>>> +               .vertex_output_buffer_size = 1024,
>>> +               .pixel_pipes = 1,
>>> +               .instruction_count = 512,
>>> +               .num_constants = 320,
>>> +               .buffer_size = 0,
>>> +               .varyings_count = 16,
>>> +               .features = 0xe0287c8d,
>>> +               .minor_features0 = 0xc1799eff,
>>> +               .minor_features1 = 0xfefbfad9,
>>> +               .minor_features2 = 0xeb9d4fbf,
>>> +               .minor_features3 = 0xedfffced,
>>> +               .minor_features4 = 0xdb0dafc7,
>>> +               .minor_features5 = 0x7b5ac333,
>>> +               .minor_features6 = 0xfcce6000,
>>> +               .minor_features7 = 0x03fbfa6f,
>>> +               .minor_features8 = 0x00ef0ef0,
>>> +               .minor_features9 = 0x0eca703c,
>>> +               .minor_features10 = 0x898048f0,
>>> +               .minor_features11 = 0x00000034,
>>> +       },
>>>          {
>>>                  .model = 0x8000,
>>>                  .revision = 0x7120,
>>> --
>>> 2.51.0
>>>
>>
> 
> Applied to drm-misc-next.
Thank you.

I _think_ I will try to respin the flop reset patchset next.

