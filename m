Return-Path: <linux-kernel+bounces-881296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE7C27F03
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E521A229FE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6EA2C0307;
	Sat,  1 Nov 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tz9Aq75g"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C3254B09;
	Sat,  1 Nov 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762002887; cv=none; b=JacZ8+EMxJgu8u8qOUXJ0ZGK/FFMQdN0fX1erpuruZVqzX2V6I2gCWwyjLj2GNVGiXFSRZ+MpTFB2tNFLAOiAG+nD2teyTpv7XQ6zC32FBuE+MoKv1jzMrXO2oCDlx9qM1BuC0nCnfviA5tqLH/k+ZmfOjfuC+IxEqjNgV/KjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762002887; c=relaxed/simple;
	bh=4/HCqTH6QVAgyoFA0vyk+8EG5alrDDUv0Jior9NUFXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgK4sjxOLzC+eopXvigQ+gtE5llaXxXRCNpQ+QM9upQW61Mv9WDlHaHL9TP8U5piq85Ai4tAzfvOnSiKLeJBxeB5h821lh55nGbcBzilY1qvE0W7qV82xWAjLkQQGPH1n8FgVILZi/Ble+qa/wvjTimKEMfpMKnJkZsDgY/IlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tz9Aq75g; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id FBQAvpxTMfpAtFBQBvVQQR; Sat, 01 Nov 2025 14:13:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762002812;
	bh=JjGbBPHBN73tG3pr/4Sq0ecZepCR3rtBC5d+11wEzGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tz9Aq75gTBrbF6mwnvyeCMkoCbvrx1hwjGbuMX1TCjjqvl0NJ59rYjKPxTfRMrXXN
	 IJutUnaEU+B9nVyDSAAkKGt4dRzta/Gutwl64fWvDulDvd+Bf0lVARTa9iy73Ide/d
	 mYDR39vqCCaMuuDQIOZRd2UKgepGrJneO0p1kXFaLXQBI/NpNN5ICvP+L3Ht7O4vGT
	 H6ziwEn8rLIhACNaQd4xq1wY34fJrAryVwTzo224jK/vfZwb1qQYCSHzp+3H20Fal2
	 /BoIY1vlUf9/u61BHr6/AIt7pWE270y2KlEHucXMWPRr10umctJOFYa7keRLoFWzkb
	 HwShxUbiRA9WA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 01 Nov 2025 14:13:32 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <76bfdeaf-3c95-4cf2-a210-9d3f069b5707@wanadoo.fr>
Date: Sat, 1 Nov 2025 14:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] configfs: Constify some fileds in struct
 config_item_type
To: Andreas Hindborg <a.hindborg@kernel.org>, leitao@debian.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <UMPsw5UqjtBaIrv5LPKiow0sOdVevbuvSx39jhXV_gtjHReEeeqGpgijGJj5OoJjMJA3mDIeSyzR9lffgIOr6g==@protonmail.internalid>
 <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
 <87sef2fa5x.fsf@t14s.mail-host-address-is-not-set>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <87sef2fa5x.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/10/2025 à 08:18, Andreas Hindborg a écrit :
> "Christophe JAILLET" <christophe.jaillet@wanadoo.fr> writes:
> 
>> These 2 patches constify ct_item_ops and ct_group_ops in struct
>> config_item_type.
>>
>> When/if they are applied, I'll send some patchess in each subsystem to
>> constify the corresponding structures.
>>
>> This 2 steps approach is IMHO easier way to make these changes.
>> This avoids long series and cover-letter/first patches sent to many
>> maintainers and lists.
>>
>> However, if you prefer things to be done in the same serie, I can do
>> that as well.
> 
> Looks good to me. Please also include a patch to fix up the rust
> bindings in the 2nd step:
> 
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> index 318a2f073d1c7..468c8c4170d5e 100644
> --- a/rust/kernel/configfs.rs
> +++ b/rust/kernel/configfs.rs
> @@ -755,8 +755,8 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
>                   Self {
>                       item_type: Opaque::new(bindings::config_item_type {
>                           ct_owner: owner.as_ptr(),
> -                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
> -                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
> +                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr(),
> +                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
>                           ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
>                           ct_bin_attrs: core::ptr::null_mut(),
>                       }),
> @@ -773,7 +773,7 @@ pub const fn new<const N: usize>(
>                       item_type: Opaque::new(bindings::config_item_type {
>                           ct_owner: owner.as_ptr(),
>                           ct_group_ops: core::ptr::null_mut(),
> -                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
> +                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
>                           ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
>                           ct_bin_attrs: core::ptr::null_mut(),
>                       }),
> 

I'm not a big fan of mixing c and rs files updates in the same commit.
And, as I don't know rust, I'm reluctant to changes things that I don't 
understand and I'm not able to at least compile test.

Can s.o. send this change as a follow-up patch?

CJ

> 
> 
> Best regards,
> Andreas Hindborg
> 
> 
> 
> 


