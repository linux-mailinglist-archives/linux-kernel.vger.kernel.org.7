Return-Path: <linux-kernel+bounces-801693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6AB448DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F407B487EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F62D2395;
	Thu,  4 Sep 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZrqVRsu"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F02D1913
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023037; cv=none; b=alUpUtzx/+mywbFISi+zl04qqxCOjqQNotoSW1bDiHvj+m0kE9BjOd+G+Gu5pMAi5CWlTBOVlBcrW5Ps40BWLY5t+6AqNcRe6xcY8ztddrQ9NK5a0J3na8Zf5/3UKsIRpndCN4EkkHAcOiG8ya7xubVvH2+2YXQHiGn6lIvh11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023037; c=relaxed/simple;
	bh=mYPBA9fFtQcaQ5vcpRI0N2FCMIP+h5NUbhtm6CBMWOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrIR8aWPtCkO2miosLzwMRbYTAIcfp3YPPNRsd3FzlbDGVu8fol0ML/Q6nY92aFkSxOnSVakD/ZCM0DBAN15QAZRoCmPqE84Uz5C96eTQR+Gmjc/ybdzIjCjNDLzoCcYYq4S2AmX+TQh30BMVFt1F8MPJknoCdWw1V1ZiCJOw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZrqVRsu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4f8050e031so84860a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757023036; x=1757627836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcZeZoGWZd6oDyE1JgIMLenB9ELxcn6jjg+gL7yAmkY=;
        b=iZrqVRsuxCypbwrClmvoimaYUwi/mGx+++LDy26SziTAUPyWWOYiq1f+N4vEBcDr8A
         ghcahYCeKaKsTmsEM5EZzevEmx4w4hGvYdvVjUpDh496DVR8lVuRGifFAw3UrRIKfyUU
         l2W/+EZdExt8OmhpwKT80UpP8XW6TubTBD5cFE80ygiXzA2xgsD5pWSkrPM47C3S3FKj
         K/pcguII3h24LmW5hoZg3qK36K+4+2bFsyrtENLYPoUvOWNehx733eHI8eQDDfF7Jwtj
         loCnOjtQMMDK7vkSvZLWV4e8x9crJAvJCrwExtusF9dKaJeNDBgXvAUiVPJzOLZLe8XD
         LuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757023036; x=1757627836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcZeZoGWZd6oDyE1JgIMLenB9ELxcn6jjg+gL7yAmkY=;
        b=GmDACBI2lJZKH73VNgjdXUIFQCIN1mdZb9SmbdGddOIOUdAz+zXsd1H2gtB4AveMe0
         YqmQfckyau3s/4C83CTaAufjJgZZV9k2L2aPq6/qskJtbVxY4X6oVevWcCobko0BCXa2
         iSYW9OJqzx62mFY2sDOizpRAV6euJlyKsmOeBkbs4sgyrME9Y/GlESDnYJxMnM1IbYhz
         ERgaNsU/Sfpb2q0mtKrpJoQ7YC/0Gf1gRWnn4SfmxPyy/7hq2nDAIEZjtxGnOiOtghbv
         PMz6euxNJbs3Rea59MdGcx/4jSYDuYrp+iLeMaQlNIiLDupFbenerwgGd/O1Q4Ygqu3T
         vIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSNxsOetMH8R6mbWmv64qiWqVomZ8XPRFz1+JeMAh8h3c0U3ls7oB93d+OaSvsjoiCJGasnoxzf/rPLBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUu6QKwvrj+v6/V5/0wfRTx89xcWscblavhYll6flk8egX6dXM
	jvWCF+MMyzyE4WiROrrO67EGylSzsxvix5CxbJSQkPc/bKUhAAtZA0hjBYGpUq6BUmhmLA/khrJ
	3a0Wd8/44vnlBn2NF+Vgj36VVL966D1c=
X-Gm-Gg: ASbGncsQcc3dGQm6SYu0w9jkNEzk0Jt2krr6cHIHQCg8RFeNyTPKppNWNMIiPmiKtaW
	D2xUi5i6Q6gnPoN1pnt3V47Hin5efQuofQ8dV2binTO25bP8kVQL0Mcis0tx4izmhlFlhU1G5yO
	tgWLH6WJwEprYWSRFrEa5hT5g3Dzp/EmL6MAazMhffUVLI6luf1J12F6k1Ozr5X8FLrCGnxJor1
	NCHECLbYVQx0F5QbBD9qg+uCMp08waA6ki+NPDplJy+qxF0xmbtWfJs096lmn85nR8NdAXb21jg
	SNHnuYC1Yfv/MPEnEJV93Qer233CNzkkRsbz
X-Google-Smtp-Source: AGHT+IHZzzEVWO5PSFfDM0hepN4yQvN1y0+nmWEUBQlDiGcXUbGHi5nbA08+gO7LBQf4rthVM0fgKbPH71PBos20E9w=
X-Received: by 2002:a17:90b:1c86:b0:32b:8f2a:ae35 with SMTP id
 98e67ed59e1d1-32b8f2aaf59mr3254587a91.1.1757023035654; Thu, 04 Sep 2025
 14:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com> <aLi-7W21N45fBGJk@yury>
 <68b9f5e2.170a0220.1224d9.5d3d@mx.google.com> <aLn4bopPt8uS4d1O@yury> <68b9ff1c.050a0220.35de1d.11b7@mx.google.com>
In-Reply-To: <68b9ff1c.050a0220.35de1d.11b7@mx.google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Sep 2025 23:57:02 +0200
X-Gm-Features: Ac12FXzzgEdE64V3Xyhcttg0HrRdfADWmugK1SarEVytCTaLM5JzuX5Un97wiHw
Message-ID: <CANiq72k1oRcxKbBpp4B-uCmqm+Hd7_xPqwM1kt-BYikbcsUSVw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for DynamicPerCpu
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:05=E2=80=AFPM Mitchell Levy <levymitchell0@gmail.=
com> wrote:
>
> it *might* also be possible to use a macro and dispense with the need for
> a closure, though I'm not familiar enough with proc macros to say for
> sure. That would probably look like
>
>         for_each_possible_cpu!(cpu) {
>                 let remote_ptr =3D unsafe { ptr.get_remote_ptr(cpu) };
>                 // ...
>         }
>
> though personally I think the first one is better (simpler
> implementation without too much syntactic overhead, especially since
> closures are already used some within R4L).

Yeah, please avoid macros as much as possible. Sometimes macros do
have advantages, but if it is just to avoid a closure, then no, please
avoid it.

Similarly, unless there is a concrete advantage needed with the
function, please avoid it too -- the original `for` with the iterator
is the normal way of doing it and already used plenty in the kernel.

Thanks!

Cheers,
Miguel

