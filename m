Return-Path: <linux-kernel+bounces-860508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4DBF0478
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298CA18A001A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718942F9DBC;
	Mon, 20 Oct 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+hbWWe2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DC2F83DE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953361; cv=none; b=WXhhZ5Xvr0kqbBlYCEpMwzn7A2ZJG5Y2E4zUkGXl7JKLHwOaOQGbLeVjDnGc6J+/o95kp42GXWm5Fgf3oNtMQZpMl8jt6K+wl3+Y+hYkUgYEplif+J9gdssfwn/ZNX1iMkpHohUCftehOgb2eERjEHyBIBbadFeqG6kuGohGtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953361; c=relaxed/simple;
	bh=awb5VBYU9MlBMSh4//gl2J1eqN52cI5c/rwFGAFoxqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JywkS4ZaY+H/akVmRtvGeKOS/F1BvvRUSF5qgZPYAS6UbeZt2I9LXoflcIHOMIJ6ArbsyNowhMK5Zu8zV2T5amiHfrRlDCDz0IMV81/62TrtPPiS3aBa5EDyhqzjXrWw4vDR7IfAY4f93pUcckwecSlJ0qj+P/9TIcD/CGxYis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+hbWWe2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bca51so3367004f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760953358; x=1761558158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioa1FAiTtXpL3cjOc/pRz0HeIDc17GZukfloq40NFdY=;
        b=0+hbWWe2Z+z9gkwXl84gal4tuAbySry/vSjmd1TPx7yXHg4b5d45vR4N5qa1HC5RMo
         lHh1UCcbwnTnOb99nRI2yjWQ5JiyytA9AGxNFu0Tp+UJI672Kk1tqy3I6I+nJcss5Vun
         PMo7yFS5mOOTqWj2c+khkZXoBkUBYdFfrb661Zj/TReS0pufUAwlOc9ZDvarriBsh0UB
         /GpHNMUyk5+ZATnKkqWUGVNUjUmCVz92+OJmRcaN3qNKYnfJ6PBmgHY0Ap397gYburRj
         QvzTWozlkSQT/gYqoMj/UMRSOvHrUtNbhco1lla8iD7hzFpIS/TxzXxM6b0sxlaG9AZu
         bMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953358; x=1761558158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioa1FAiTtXpL3cjOc/pRz0HeIDc17GZukfloq40NFdY=;
        b=vsuR3lUGzHeasEeIiOZ0TqLZmOxXQ/4NaGdCSkm+YViTSdePNsLVU1nlDoVOr4BDMZ
         xx+AwVgYkwAOM6wy97Qdf2ey6wCltvGPFZquYCVm4zyXouoe0l2dJrSB14uYYfHj5ile
         2d12PLlxzw5wQkezAotgRaTlKdmBeDct5006CTfqLKgYfCwnOZzqHq0kdKxcW7TyJT62
         FJx0IIyzlsED/yPec4Ted4ZN1todOpKcJI2YLau2643H+y8iE7hIle5en0S7kWCqyw8K
         MSaI/t+RmXZLwIF/pYJTsOTVR+Fpn8WKCaqnU1vqXCiUBJ5ii6jpkr7h4T1ebwYUSNih
         BulQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEdeQ5xs2UKhRVMJGN0nSY0ldWEZfn50sXz3R/8cnidjlVFJDFUPiAOaKdsoAVzRRQwxli2ZtrQOmAYgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy192Cxbd1HJmdwrAcU887xOPcKmJ99OB81cUYCCm1Iq559swvw
	KBBWVs17uQWw4ywyWNzUPWLQkD/8RSv+zcscDcgkw34vG3wH+AmcOEdxAVj4Vs6D5CcRk0QL7au
	hM0i5KQjyAkbUx+6weBPlUctlU5CvLuzXXQSJBbc0
X-Gm-Gg: ASbGnct37I8VHU/ICbLxedq+EP03EOgQk0mg0xbcdUxnLBW7Qv9FBRXBvmpoq0rw46D
	F0LGj4Ty5nRaM3FwZABv24B5tYiFypyZN0fA3SRByDQParqyWrJyMJHiFDuu0Uom1hsfzMKiOTX
	IDZZdORefql4P/eEkeFjSMSPtivBzMYfXT6fgmQkE1sCt2qazzG2GqrvNr2r+7gF3f+9f9mOQE4
	N+3+kAs4mL+JIZZWVszs23pYhrAKfrwunsU3PG3wgJFUHdXeNLoJeka4NKhgfjS6RpLnMJU9cTN
	pQgGCEee1uo4iA==
X-Google-Smtp-Source: AGHT+IGkYPUSKNRc80kzAB+AdD6JXVWhff93Ifaos+he9fb1OEMssuQk3PK0+0z4BYdwPIXDcCdUqPJgDGN5YoA02o8=
X-Received: by 2002:a05:6000:2f84:b0:425:7179:16eb with SMTP id
 ffacd0b85a97d-42704d87ee4mr7605293f8f.17.1760953358396; Mon, 20 Oct 2025
 02:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-4-dakr@kernel.org>
 <aPI9tNoh0I3KGDjl@google.com> <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <DDKOLD1897SY.84W93E6L8ITR@kernel.org> <aPSzE7DpA7DxTHmm@google.com>
 <DDMA6OR8V1L3.22YQDEKL20MB5@kernel.org> <aPXu0FWUrbxyemPq@google.com> <DDN1TL0WE895.1R5Z8AR975ZJH@kernel.org>
In-Reply-To: <DDN1TL0WE895.1R5Z8AR975ZJH@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 20 Oct 2025 11:42:26 +0200
X-Gm-Features: AS18NWC-DsJ2iWgnI_p90tlgZ8p23Bf1mygztSiPg7pVtriRmkKsKOHh9aSkU9M
Message-ID: <CAH5fLgjw4cZ3Y3Z60v8Wtp1EsR3AjyopJBE-UzZH5H3qkFrWmQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:40=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Mon Oct 20, 2025 at 10:12 AM CEST, Alice Ryhl wrote:
> > On Sun, Oct 19, 2025 at 02:01:03PM +0200, Danilo Krummrich wrote:
> >> On Sun Oct 19, 2025 at 11:44 AM CEST, Alice Ryhl wrote:
> >> > On Fri, Oct 17, 2025 at 04:53:09PM +0200, Danilo Krummrich wrote:
> >> >> On Fri Oct 17, 2025 at 4:37 PM CEST, Danilo Krummrich wrote:
> >> >> > The reason I went with a trait is because that's consistent withi=
n the file.
> >> >> >
> >> >> > Otherwise, I don't mind one or the other. If we always want to us=
e a struct, I'm
> >> >> > fine with that. :)
> >> >>
> >> >> Actually, there's another reason I forgot about since I sent the se=
ries. :)
> >> >>
> >> >> We need it because we derive it from blanket implementations:
> >> >>
> >> >>   impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T
> >> >>   impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T
> >> >>   impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T=
> for T
> >> >
> >> > You can still use a struct:
> >> >
> >> > struct BinaryWriterVtable<T: BinaryWriter + Sync>;
> >> >
> >> > impl<T: BinaryWriter + Sync> BinaryWriterVtable<T> {
> >> >     const VTABLE: bindings::foo =3D ...;
> >> > }
> >>
> >> Yeah, but do we get something for adding yet another type in this case=
?
> >>
> >> Another point to consider is if we want a more generic fops abstractio=
n type.
> >>
> >> In any case, I'd like to add this as good first issue for the whole fi=
le to be
> >> changed accordingly.
> >
> > Yes, keep it as-is for consistency with the rest of the file, even if
> > the file is inconsistent with the rest of `kernel`. Please go ahead and
> > file a good-first-issue for this.
>
> Before doing so, can you please answer the question above? While I'm all =
for
> consistency, in this specific case it seems we'd need another indirection=
 for
> that. And I'm not convinced that's an improvement.

The choice is between adding a new type or a new trait. There's no
intrinsic advantage to choosing either one, but the rest of `kernel`
chose "new type" over "new trait", so it makes sense to be consistent.

Alice

