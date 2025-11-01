Return-Path: <linux-kernel+bounces-881362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F3C2813C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE24E1010
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198F2264BA;
	Sat,  1 Nov 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXi9MXYv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822815D1;
	Sat,  1 Nov 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009343; cv=none; b=GZdCGZgQhbEXzoX08tcl+uLT3u7fK5jvQCXk2F+GB287m9xGQQu6ytgnJavyU/37wGpFG+k/PB32sIy+gbvSxBAQX1YMsBVbn5Wfs3a2Zy4sErsQ46Ok+HoffRYKZR54OW+k55USAtjGUt8t9ZIKHK5bDYO7WuOvFGvZgsaUMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009343; c=relaxed/simple;
	bh=XjqkzxujCssc2zk4tDrvih0oWnYgkiq9ucEXAO2KA3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OE7srUNTmXDu42iT6hasQLkeBP1gPCdF2/PX695mSv78IhUBB3okCQUlgqcVP5+WwgLkOdjVXAljMHZmWEgb8djwFQ3uqZLkme5HPcPoOe/jBqQm3E649jt5tCAn+GkXdArBOVqzxKWZSOcWvTK2Z2rpS2FNSkFmUA1qXMwUQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXi9MXYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA099C4CEF1;
	Sat,  1 Nov 2025 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762009342;
	bh=XjqkzxujCssc2zk4tDrvih0oWnYgkiq9ucEXAO2KA3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JXi9MXYvV+9UQPohIrfx+2q5bqfUaBY+fjcqd0597u+aQfZgIt7ewlwe23GVoaFKz
	 IRbRec6awKlAUU1agKgFUnIhQGcP5VY9Y1vhfAXLlpBZFLmopVTp088U/plN7nT9QM
	 mbt1AS9GiF6XJFGgTU3u7QTqXo/BsOlewiTTQpKVhEZ+eWXrgS6UbWqls01WG8Gkia
	 rN0/vPYtGRzEFCd/rtvreLmq7RhqMcIZFdjitrV8maMEAsOLK4dm5bYyskZNfSHRXR
	 8g3Ch/eEC+SLeyrLC5OLCegha6x0mbTIt848BGiPrfc2WUbQz5iKB6kb5rt83loCxL
	 bdpBjjB/xBwyg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, leitao@debian.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] configfs: Constify some fileds in struct
 config_item_type
In-Reply-To: <76bfdeaf-3c95-4cf2-a210-9d3f069b5707@wanadoo.fr>
References: <UMPsw5UqjtBaIrv5LPKiow0sOdVevbuvSx39jhXV_gtjHReEeeqGpgijGJj5OoJjMJA3mDIeSyzR9lffgIOr6g==@protonmail.internalid>
 <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
 <87sef2fa5x.fsf@t14s.mail-host-address-is-not-set>
 <AenlUrApTlCB19zk49DWpC_tbPKSEaDPmg7GhZfuqlDfQvbMuYTWFkgVfp85fisHGgilvaGZEy_is6qnad9KMA==@protonmail.internalid>
 <76bfdeaf-3c95-4cf2-a210-9d3f069b5707@wanadoo.fr>
Date: Sat, 01 Nov 2025 16:02:15 +0100
Message-ID: <87ms5594p4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Christophe JAILLET" <christophe.jaillet@wanadoo.fr> writes:

> Le 29/10/2025 =C3=A0 08:18, Andreas Hindborg a =C3=A9crit=C2=A0:
>> "Christophe JAILLET" <christophe.jaillet@wanadoo.fr> writes:
>>
>>> These 2 patches constify ct_item_ops and ct_group_ops in struct
>>> config_item_type.
>>>
>>> When/if they are applied, I'll send some patchess in each subsystem to
>>> constify the corresponding structures.
>>>
>>> This 2 steps approach is IMHO easier way to make these changes.
>>> This avoids long series and cover-letter/first patches sent to many
>>> maintainers and lists.
>>>
>>> However, if you prefer things to be done in the same serie, I can do
>>> that as well.
>>
>> Looks good to me. Please also include a patch to fix up the rust
>> bindings in the 2nd step:
>>
>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>> index 318a2f073d1c7..468c8c4170d5e 100644
>> --- a/rust/kernel/configfs.rs
>> +++ b/rust/kernel/configfs.rs
>> @@ -755,8 +755,8 @@ pub const fn new_with_child_ctor<const N: usize, Chi=
ld>(
>>                   Self {
>>                       item_type: Opaque::new(bindings::config_item_type {
>>                           ct_owner: owner.as_ptr(),
>> -                        ct_group_ops: GroupOperationsVTable::<Data, Chi=
ld>::vtable_ptr().cast_mut(),
>> -                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>=
::vtable_ptr().cast_mut(),
>> +                        ct_group_ops: GroupOperationsVTable::<Data, Chi=
ld>::vtable_ptr(),
>> +                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>=
::vtable_ptr(),
>>                           ct_attrs: core::ptr::from_ref(attributes).cast=
_mut().cast(),
>>                           ct_bin_attrs: core::ptr::null_mut(),
>>                       }),
>> @@ -773,7 +773,7 @@ pub const fn new<const N: usize>(
>>                       item_type: Opaque::new(bindings::config_item_type {
>>                           ct_owner: owner.as_ptr(),
>>                           ct_group_ops: core::ptr::null_mut(),
>> -                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>=
::vtable_ptr().cast_mut(),
>> +                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>=
::vtable_ptr(),
>>                           ct_attrs: core::ptr::from_ref(attributes).cast=
_mut().cast(),
>>                           ct_bin_attrs: core::ptr::null_mut(),
>>                       }),
>>
>
> I'm not a big fan of mixing c and rs files updates in the same commit.
> And, as I don't know rust, I'm reluctant to changes things that I don't
> understand and I'm not able to at least compile test.

This is why I gave you the diff.

>
> Can s.o. send this change as a follow-up patch?

Sure, I can do that.


Best regards,
Andreas Hindborg




