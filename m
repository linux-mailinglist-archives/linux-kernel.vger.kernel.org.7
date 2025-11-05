Return-Path: <linux-kernel+bounces-886536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA31C35DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE3294F1BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA14322C73;
	Wed,  5 Nov 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="vMHHFEWV"
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF1322A00
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349758; cv=none; b=Ct8+Ekiz4/9lYervyB2G4i/f3qvOdq963IQEyOTBYj/DJDWOjzAVd8IKj6cvzrRR/NLwBV6bS5UbCP5G128qbzfUHvb6NAGdbvQ3NaEOkXt7J1oHi1/SuYQV4QFu7/9Fh4pLHnQFX8pV3U+iGRidBOGuWDOoWGwJo8GP0Zbgj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349758; c=relaxed/simple;
	bh=HvtCFB+YVlcHXviOlDNyWHCt60UpWIwHrdNsZvjwr6M=;
	h=From:In-Reply-To:Content-Type:Subject:References:To:Date:Cc:
	 Message-Id:Mime-Version; b=Ef6ZCUYNiuPfLy4awnwBF06OtkbNMSK+Ciqj2XXIZf2kQU9wrEvUWsTuu2Hh0ZmBPLdl77pQTk8lNpxrQnIwVmVcPiihXRh787tUOBt0+zO3y8sIKoOlXRI5xgCba8T3xmylYuuorAvHmD/dmPuxARQVM3zgLwwZg0oqd77qbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=vMHHFEWV; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762349744;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HvtCFB+YVlcHXviOlDNyWHCt60UpWIwHrdNsZvjwr6M=;
 b=vMHHFEWVDlSZLz4CtRwt9m1zBgG8qB3NUSvXN53QMOJq+9ULBo9TkR+qeGb2OERJL3IMhO
 y0aqnLMG21dl9Qj5DvOSw1o6oQIIml/6a7pyR8h2ZmrOlZ35TCP3Zu8z69tirseBJBSi9t
 uGMaQhMZnKckrtA7dvZMD5ZCEpifpgAOKuehEFxn/9aKZrAUKiz6KRkYRT/qzT3H4yJ3Py
 UjFiwEsxE2JNjuVZOjmwKi1n879lIcUEKZ47+F3EAX0/5xuxkIzGFZaWxf+tx2CZ4StIvn
 Er7fPBnuH2eFLwsG1mulDQ6wTKtKhk+mIPMKDgmivDY7q0BR2UrOXdu2KS15nA==
From: "Chen Miao" <chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
In-Reply-To: <CANiq72=WZJ5=UACpFLWCVJ7mcXbc93X9MyYAZP8-0F==2b0adw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
X-Lms-Return-Path: <lba+2690b52ae+2e2957+vger.kernel.org+chenmiao@openatom.club>
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club> <CANiq72=WZJ5=UACpFLWCVJ7mcXbc93X9MyYAZP8-0F==2b0adw@mail.gmail.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Nov 2025 21:35:40 +0800
User-Agent: Mozilla Thunderbird
Cc: <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, 
	"Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	"Benno Lossin" <lossin@kernel.org>, 
	"Andreas Hindborg" <a.hindborg@kernel.org>, 
	"Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, 
	"Danilo Krummrich" <dakr@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, 
	"open list" <linux-kernel@vger.kernel.org>
Message-Id: <8d865a46-82c8-428d-a371-407889eefb62@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [198.18.0.1] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Wed, 05 Nov 2025 21:35:41 +0800
Content-Transfer-Encoding: quoted-printable

On 11/4/2025 10:14 PM, Miguel Ojeda wrote:
> Hi chenmiao,
>
> A few procedural bits below for future versions/patches...
>
> On Tue, Nov 4, 2025 at 3:04=E2=80=AFAM chenmiao <chenmiao@openatom.club> =
wrote:
>> If finding the offset from the primitive type is necessary for this
>> implementation, I will abandon this change.
> In general, this should not be part of the commit message, but go
> below the `---` line.
>
> And if the commit is not ready, typically it should be marked as RFC.
Understood. I will pay attention to this in my future possible emails.
>> Additionally, support for the `static_branch_enable/disable` APIs has be=
en
>> introduced.
> Please split different changes in different patches if possible.
As the same I said above.
>> Signed-off-by: chenmiao <chenmiao@openatom.club>
> In another email you used Chen Miao in the From -- in general, please
> note that the SoB is supposed to have the "full name" ("known
> identity") as you would normally write it. I mention this since
> sometimes people use the local part of the email address, i.e. `...@`,
> but that is usually not the normal spelling of a full name. Of course,
> please ignore this if it is correct already.
>
> Thanks!
>
> Cheers,
> Miguel

I can understand, but I'd like to make a brief explanation here. "Chen Miao=
"=20
is my name, so the prefix of all my email addresses is "chenmiao." Therefor=
e,=20
"Chen Miao" and "chenmiao" are equivalent.

Regards,

Chen Miao

