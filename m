Return-Path: <linux-kernel+bounces-787141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F6B371E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602D936594E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11863362098;
	Tue, 26 Aug 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzRHQAFE"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A3338F54;
	Tue, 26 Aug 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231420; cv=none; b=Frg1XnmAJy/gnn9CNgN6iu4iFPxEvdBDpIPu+0tBQEN70mdeCJqBnvHwfV8I8stMVCLoGmes8jjy6rXspSnLwBm2TJvX5dO1Cn0bBYJ+RWTwN+V4nmfZSeipBiPPQaZZ2wb5flwSDd39PXpQ4hR+7DW806pXP74hlh42YbT0H4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231420; c=relaxed/simple;
	bh=fves3TlKOiL6El/r71tNPg5Ed7FLQBLTsDv8cZZc6jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCIaHjj08ilPpwzzDEsQx1/Du9q9Trd9APGgymAOCRnXPFCQjs81oT0wUzrsHVEBBcH/kLhYqE1He58vjGFMmJOi+qHI9I0ZyV/h3lY28mZ2rDaJxN8l8bOWcJ6TPxw1ijc2u04KOJjNtCLQEulwdUyru7qGs+xKWGXzaWwe+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzRHQAFE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-246163711caso8489585ad.3;
        Tue, 26 Aug 2025 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756231418; x=1756836218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fves3TlKOiL6El/r71tNPg5Ed7FLQBLTsDv8cZZc6jU=;
        b=OzRHQAFER6NWloHnmsH72D5PKj+1znPwfkqMPn0InJAVsqWRZy6qy5JNpid61HASym
         jkVS28IIY8+mmmLRxXt2qefIG4R6jrRbmtxry5d8pyXprqEEeyxQwleYJdcl1azGgwFi
         OpSaaXkAk1Z/GZCyUS74NzI9SwWqqFgVNQwqORFxr/7sABuWz2UOBzU083LAigg06p/b
         +qGxmKWLgYXFsK7fiHCXGIBR1z4XjEAFumg/ASwEiH7Yl/kSgHO5n17EwkxQA4tmwySW
         BduJ1SmZMu0SKzzX14xjvpyzpm4Ah04Y4fqEm1nQBXKRhKt34IO/faTaL7j6qDlAww7p
         P+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231418; x=1756836218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fves3TlKOiL6El/r71tNPg5Ed7FLQBLTsDv8cZZc6jU=;
        b=oOssz1VdFivpTxvCeh4/cGqDzzaNSE8zeawMiWUruPpEVzCb+Xz7ZHoH4WNqhCFc/+
         6cHhfROQ4vOIngNW++bWUfQRoA9J02lPV8u9dkbi552HwGKdMYd55SFzbAPI4tm4tzZ2
         5AjvnmKzFWEBEO+OoaB0HKgZfXwbXiOTXt8bov7wigk7MDVOagZf9XtGrZasOu7rSrv2
         3yCjmtjsNib6AaMDO46/qczAFPwV5xl9fP+dJZqmnBPkh42Cyvv6RcqnY13XNQ0uHFMP
         S2O4/vE43IGeMVRMjkuwNR1vtqFzasH0s9++rcQ63dG339Too8Shf56wEI0ryGzswozt
         A7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU55Utf1gkOfaCpPhqiSl2Kxj0E3p8jPJfGxlVA480TwBLsTz8OAxR8JRSggxzWuSV7vxo5acwV+uVLz7KEfPU=@vger.kernel.org, AJvYcCUoEqJyKBCOjFKnKsJ+7CPMMe26K6RG5Z02YPwoD6x1SQZ8GsXx3KPdE9TjxmIs68W9yO8JW5Ru+tRBMOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2coqGycXxhQvhbocCr+JfsIJ/dqmKYeB6QI62MzL8piV/h2Hp
	wyq/ECMao9J0yETjQr67WWTdXC70Dv7RplufcDuXGRI6PeTycU8BA4XGjONZhaeMPdnj0Jc0SIc
	wFUgWB/T9gCIMGj5qFe6v8g50lzZlvX0=
X-Gm-Gg: ASbGncs79+s26fNHm23HrWV9a/tbQpqCO7kuaONeFLR4pTJe97iXbWUrfstnUKpLl/T
	TPVzNz5uMtSiIadgKCYK58HtO2xq/CXafm10d912i7rYbLrm4C1ZbrBAa+BOkvgAnRj7ba+ID8b
	7PhK4rxXey28phr7FnS+xoT9/8Oa3OWEzy3w6Erqceu4uuqD2gxPJ+oBn9Nz0LCu23vv4Dk2ezU
	cU1BIC2cgqQWq20yQ7SCsoEiGAemokS6dQwflZaVis/O81/VI9FimG6LCj5TITxwjvtRNDEqowE
	wdxHmNpDvb7691SkElit6qYmqA==
X-Google-Smtp-Source: AGHT+IEkDu0dZOVR4ym4Y9k1+JLt3r3CZqSLtfwEbuDz5hkPzEZathJgAPIL0R3F+nfJ5F2R16Lwn4qWJNBSCV1Zhog=
X-Received: by 2002:a17:902:db0c:b0:240:9dcd:94c0 with SMTP id
 d9443c01a7336-2462edfb000mr108271585ad.2.1756231418142; Tue, 26 Aug 2025
 11:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ub8ohgErgUJB1KWyrSWn18gSQiyiIJ4Py133yi5fMR68ZG2zeWokoP7kULU7voBjry46A7GZUSrHuCQn0C_DZg==@protonmail.internalid>
 <20250821035710.3692455-2-fujita.tomonori@gmail.com> <87bjo2witj.fsf@t14s.mail-host-address-is-not-set>
 <20250826.205941.963904478024459782.fujita.tomonori@gmail.com>
In-Reply-To: <20250826.205941.963904478024459782.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Aug 2025 20:03:25 +0200
X-Gm-Features: Ac12FXyFyZdjTmFaRLIHEhugsupQrMJ1GFstOS_rGWVLewFxnM6d2xXXwjoCDvc
Message-ID: <CANiq72n4GKUo3LjNkvBvh0C=20tfz7D_jirZpu+2BogqNuK3KQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] rust: add udelay() function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:59=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> This can lead to an unexpected delay duration, but it's safe in Rust=E2=
=80=99s
> sense of safety?

If it is just unexpected behavior, then yeah.

Perhaps Andreas is referring to C overflow UB? If that is the case,
then in the kernel it is actually defined due to
`-fno-strict-overflow`.

Cheers,
Miguel

