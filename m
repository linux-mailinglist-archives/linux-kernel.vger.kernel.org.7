Return-Path: <linux-kernel+bounces-886546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC02C35E83
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 234BD34C3CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1D324B20;
	Wed,  5 Nov 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="TTxyY3lE"
Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1F311971
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350382; cv=none; b=nLWfgO4DdmthSCLw7jihpkOiGsaWRMyJIvtuMuEVfgIVAVosPpxAeRyjhlHx8iqOVNGsOIm5qwo4reTachzQy4dUbC+tRJWxvLnGZ/iGZRSW7jlCg83CKX9uKzlxrjm9Gqn0M4j9jJaT3oSSXuLJ44OgUs+HVUsmYjxfEtCEqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350382; c=relaxed/simple;
	bh=8+E+wvcxBVM0MPG0WH1f2Ay5kSxXX3yb3qO1FxQOTls=;
	h=Mime-Version:In-Reply-To:To:Cc:From:Subject:Date:Message-Id:
	 Content-Type:References; b=nh4IqJ5mFdu1ZNzMvPbZz8EW8t6A7SRrF4/iR3pPYToiURPEIIeIU1z7hanGQu00ZF+PHoVzixAMPDlpbFDchYZBpeBm4A5Y5TOZ67Be8HwuS7lMT1Nzjb5l+qkTinfe21eOmyFDYOhnlMF9p2b2rTp9d7B2NUmPhFTEUXbbb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=TTxyY3lE; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762350367;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=8+E+wvcxBVM0MPG0WH1f2Ay5kSxXX3yb3qO1FxQOTls=;
 b=TTxyY3lEsgB/ruiv12o5h9soSJW+ZDCU82keg4+yJJctTVzAv06sP3lQ4f3pUi9pGZf+kJ
 70W8OchN4+pHhQ0bOCiosqc9Wz4cSMZyURaI/ED8ZnKpMYF3F/7nSWLUozgxFCYG3cjj8p
 iCLlDB6n39Fziu1w4/s3i6WPdtuWSOoyyUfTjxiyNZKJMjhScIj0vPTxui6txfHJs7HDUN
 z2WGKlga3x4pgkX6lrdoZrguKykgxDy9ur5GQ+vp1itYOYMc6dhaSkPW/+gQZ1hZmJpBuI
 JE+rkDmp5XKCk1NO7xv539CkHx8mh5oiJ2Tuw+WGn0xZrjNuNrvbzsP0uPaMrw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2690b551d+de204c+vger.kernel.org+chenmiao@openatom.club>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANiq72=OE3JNpemanR-r1efbgKqQrZCiQ7hY2-=_bvxLyJZ-HQ@mail.gmail.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
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
From: "Chen Miao" <chenmiao@openatom.club>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
Date: Wed, 5 Nov 2025 21:46:02 +0800
X-Original-From: Chen Miao <chenmiao@openatom.club>
Received: from [198.18.0.1] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Wed, 05 Nov 2025 21:46:04 +0800
Message-Id: <282bd8d5-afde-4a96-b294-bbd7b69ce684@openatom.club>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club> <CANiq72=WZJ5=UACpFLWCVJ7mcXbc93X9MyYAZP8-0F==2b0adw@mail.gmail.com> <8d865a46-82c8-428d-a371-407889eefb62@openatom.club> <CANiq72=OE3JNpemanR-r1efbgKqQrZCiQ7hY2-=_bvxLyJZ-HQ@mail.gmail.com>

On 11/5/2025 9:40 PM, Miguel Ojeda wrote:
> On Wed, Nov 5, 2025 at 2:35=E2=80=AFPM Chen Miao <chenmiao@openatom.club>=
 wrote:
>> I can understand, but I'd like to make a brief explanation here. "Chen M=
iao"
>> is my name, so the prefix of all my email addresses is "chenmiao." There=
fore,
>> "Chen Miao" and "chenmiao" are equivalent.
> That is fine, but what I was trying to say is that, in that case the
> Signed-off-by should be "Chen Miao".
>
> Please see https://docs.kernel.org/process/submitting-patches.html#sign-y=
our-work-the-developer-s-certificate-of-origin
> -- thanks!
>
> Cheers,
> Miguel

Well, I will follow this rule and change the Signed-off-by to "Chen Miao"=
=20
before the next push.

Regards,

Chen Miao

