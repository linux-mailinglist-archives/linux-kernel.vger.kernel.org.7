Return-Path: <linux-kernel+bounces-689079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C5ADBBBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE09173983
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A1218858;
	Mon, 16 Jun 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SymWvp+x"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4521771C;
	Mon, 16 Jun 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108301; cv=none; b=eZw94kYLFRjYaQTlvodqRPiFI2g7QV+BLWvxUef98v4KlkaUOtkL8/OagFzCkZTF5KzDIKKECHsQvfPj4nb5dqBpCnwsUeSGxZiCY8SnHvJ6ig6qZphX9iFCWtRfCewV2/zi/oiCo1Dkp4CksoHJq6kvpZTWBVuTCKwMjVwk3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108301; c=relaxed/simple;
	bh=+6WsT5oth9ZD2+8RwI0NPoBIPmRFMBqAn9cfCcds/Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0VbPN2mDrahhGjy2FhuluCoRtedvTpTWYZ7E65zriN3LFPMB8LAJB1rF5UgtVPvCWaaJla+zdiGkTFT77rlbOv2TjouWOcHLILj9wM7rFQT41lcNgGeNIJTw3Tg5bI6HxK1bKAQcNuDTw5rEpUEQfA5205UrCdsLVOSWtddJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SymWvp+x; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e7f553aec9so116218137.0;
        Mon, 16 Jun 2025 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750108299; x=1750713099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+6WsT5oth9ZD2+8RwI0NPoBIPmRFMBqAn9cfCcds/Go=;
        b=SymWvp+xfXqOQX/Ivzx+8oJCbarW2ifWMDlel9JvlM5FfhtMmKG64mZphFAJ3kt/gP
         FI4L2RpxXNhvUTVLYKXbv67BmuqEezCBAk44K9G5r6KSCfdURNNeCI/KocvYJIROi8Sy
         gVLh4j9ZkigQKLC32uBgAzWODu/UhmbzxjztXOeTqsbMjwQPdU88iRylnZxbFNDz89Ox
         vKgNbd5+I7lN0Pe68lyAISdPh1zDIcpMvERnHdmRIODBgqMFVwY6ppOOY9CSj2OZBFnT
         c9yfnSuGYmbqKo/ma3CqgsT801wkVty2vZ+9lT0gZi3WAefGGQm6YXiHUzldqrDTAEAv
         PxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108299; x=1750713099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6WsT5oth9ZD2+8RwI0NPoBIPmRFMBqAn9cfCcds/Go=;
        b=tXVTHMaXmLd1PP7Fnmk1Kw8wemnUd2Kfyn5DoO7+k4epqW4yDPXwEK3WKHL5HTvpND
         rIPtbN241dQLu79JgwibQJ9QVR2/NA0GiuewluxBdiWsT01CPNKxDGL4bUS76gmB5Eb6
         RuRLBBqbrXvr5ivxQoVnnnR3er7v2s7qulxyI3rv2PEeYb/qzaMtaxIdLK53bq/9YTEi
         EX/eksxwE7ypa9hkdU1p68QLoVWWDYU8LeZLjCcmprD50pOJ53GeEcunLi7hT3DYJrOz
         uOhO3kqabPRqcZ88/H4GLnqaXzSFTZCfVpmDNNpzxc/DdS+85EPGgCS3vlHuOzYnvmzt
         mKMw==
X-Forwarded-Encrypted: i=1; AJvYcCUkbM0UtroZt6JidlVCGvOG9o/kLYBsV5/b7P5SxwnfpoeIr9Vz7TZaeUkY4IFsGJn7fDZrSDD9Fa2pp6w=@vger.kernel.org, AJvYcCXysgF4cAxULwD5kofxZiubzIakJ1biqZoQjqtDPy2WWtzu8UJu3CgXVYnMzkZ9VCGSPPGKXw26Ld/s/SH6yLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzxy+y404ZWfWN6IDUD4yGyxUf7anQP40bRU7HhNlq4tsOXwKr
	S3iwSabagDgc9k4Vh/VdGaWFkSAouPrJHUMyOhTW7//JKxHCg8T8jveqLI6mE5z6+kl/YrPrjDI
	90+1g7xlRLya+Dc70rK5EFZohudq1ad4=
X-Gm-Gg: ASbGncu8XU3Mne/R2b/SydRvCaTte10ku26pkxg5l1UsN0CeDt6IWPE+mLT9e/ZXKTO
	OUABmo6du6snDatf0tBEyQxVwYXhv9x29GX2puKVqbJmvLY2GXsRt8nbRCBCOrx6kjxlRsXTIL4
	n4CtxUyZq6QCRRAPvCo+liD94zDLnDLPKBRPLbgZ+tfy3O
X-Google-Smtp-Source: AGHT+IHxxDVxSUITwagCUTBvK7fwI4v1AzvPrcNuxf2YPzf0+RAa3smgdSZaA8ftkJefkSspm+3ImMbmYV15uxQaqL8=
X-Received: by 2002:a05:6102:390b:b0:4e5:ab43:6a6c with SMTP id
 ada2fe7eead31-4e7f6110aa7mr2498168137.2.1750108298981; Mon, 16 Jun 2025
 14:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615072042.133290-1-christiansantoslima21@gmail.com>
 <CANiq72mnxRquFmjoJemb=3LSq+ZdUfs9J+HXTwM6AavprsVNUg@mail.gmail.com>
 <CABm2a9fVSGm+WWjdkAmJHUH9eH=Qx5efORKxyJtt0HnQrs0QHQ@mail.gmail.com> <CANiq72=s6Ugqrf5Ot6fJOMyCug2XyvKpjFCzya_Mr5iBkpitLA@mail.gmail.com>
In-Reply-To: <CANiq72=s6Ugqrf5Ot6fJOMyCug2XyvKpjFCzya_Mr5iBkpitLA@mail.gmail.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 16 Jun 2025 18:11:27 -0300
X-Gm-Features: AX0GCFv5Oj4kAlsf3GqFl59AZHxvY23KVsJ3tuGAELRmwcs5Dj_HuRlJ44a7izE
Message-ID: <CABm2a9e+XJsess6XY5ukz8vav30ADcmBrufmek+Bd-TNJpR2aQ@mail.gmail.com>
Subject: Re: [PATCH v7] rust: transmute: Add methods for FromBytes trait
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Hmm... I am not sure I understand.

I mean, using something like `use core::mem;` globally since we use a
lot of core stuff and so, it would make the code less verbose just
importing size_of, align_of and etc.

Thanks,
Christian

