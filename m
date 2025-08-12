Return-Path: <linux-kernel+bounces-765508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B6B23953
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBAC6E0E24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA012FFDCC;
	Tue, 12 Aug 2025 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ6bsLIb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137A296BCA;
	Tue, 12 Aug 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028379; cv=none; b=SElxFgNkmQVBTZVX8Y4Wqfim3MQrCbH2L1b0gM/NGUmNwD7iyxwdEywBtMKF4H3cH3WB6kyh6DWlwd2h3zH63ZHY1R9GagGAVwHQoDmZs83i5/6n7KFgCAIjyMW0+EMuWH4rgTrBVtMngMlayzliex4rP0Gmn2plnyUIshTF7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028379; c=relaxed/simple;
	bh=T/aLjDLfTvyKnPGOQdgq0rcqlXVBr/0vWvH6zLMPvLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH7WlbEzWu7HAuXbJ3fcvnrqWjq/UcW35oxi2r0kZVlmogBz4QMY51UV+L4KJ9rUo8uAgDtynEYlp6T9tah7SuIZBZhsCabf79GMMSXg80olnCyIv+DJIhCM2D0RDkkQiT4F4eVmuCC0LAsHov1A38e4L+JQNQdb8D34gIYZroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ6bsLIb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-242fdf8568dso1611815ad.2;
        Tue, 12 Aug 2025 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755028377; x=1755633177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/aLjDLfTvyKnPGOQdgq0rcqlXVBr/0vWvH6zLMPvLs=;
        b=YQ6bsLIb5bQIst8AzQ0GywuZCZa8QeJX0fPMB4gNJ92iBrwKGAhuAW9cj+10YNucKB
         HrVOrDpNT+VCwexMFVJSNXLehOVx3bSlU4/KMKwEzCWrHUfX3TeQFyBuz4U54Bk2WTF/
         qH25nmqe/l9dXtRNf+Udw+VqtWSROo2TWykATPZDEbaMIshPNBiAph4Ex6fZlho9zemm
         uoXERAMWm1Fb7TDzkbfeudOmP56STcTlR5utzbfjmB0ivilsBgBdSwnfcCGgQ9o6Hjdq
         FXj2fl9rAbWhPw0ggmXd1m5i4bYrH+tQ82AOgkcNUBOeW+Fj2Oe7eZsitVPNL+yNmr5E
         yFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028377; x=1755633177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/aLjDLfTvyKnPGOQdgq0rcqlXVBr/0vWvH6zLMPvLs=;
        b=dJOEX3Qj/fcazHHo2lo/MuUKZXJfevCfiHm4qdtETPnoOPzkkGEkNDYcxEMS9Y9E0/
         mb9SsgyoZTxYc9OI1wmS6QPWAkqeWTeD9mhGEMsz7h2ay2PkO+pcbo3iSvLt8AszfR2+
         RZfYL6TO+YMBCY5Lrt96KVtc3ozpol/g9sdFC9BuvFUGwX7Pfu4z7b2BU59oUhjzu8UU
         QOV4ZQ6dyrMHocHTB4sZsMQLheZlH+n22C6RqweZ4JGHDdtqfbwsFE/ywX6/+NHznE/z
         /vT71UrMBPP5tbEFWvTmN7MbxfxG31el1L2uvIRsBygseIVkRdAcupN+6G100/w5XgKi
         FIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNADos1xrG3YIKKyBKAhy6lwffWGHM+NinWmjRHpiHyv171VhAUdbkRb2KbbLwBOjMpaY+QM27tGUl29vgT4U=@vger.kernel.org, AJvYcCXFux/4ofQcZLNGmk7jKjShnYZZcsfo0FadU9TN/eB/3ydFblZIwgCIZLLouOe2e+MuZ0BgKHMaqF0WRrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuDnhO11kULSS1ZPMEXB9tHMJyQpY66zAyV4rIo5aa2mHr9lE
	pCG1DifUpSnpeV0lGyGD2VvHX+VRcRjjr7Ve9/wIuMMOSZkO8fZqdz8BJRRf4sX7AJNSp9ivQ5Q
	XsjnzRLs3LvfyfduOwvtmchGFfymJvSE=
X-Gm-Gg: ASbGnctoRn/tCZQNGeffVlvYzsIm4gwaJwGDLS4ECZP/mD7+cqoh1p53Dmg0OuxpF2t
	Wi/TwU2LtZT8a+fDQw/KSNT5rT5x7fcAmdWcp/WqnB/7SZqqmxdC2Xcy4k/EBfT/tUd2FgGdbNg
	RMLy6F8uaqNHZ/slw8HbCYVVh2squKAGV7DJXKGwetNNoMy6V2xNtZtGWLc8+ja9OGegduCAfE5
	8PSi06g
X-Google-Smtp-Source: AGHT+IGp2dikV2vxjvTnzDsMEmpfe17vDuKqbKTf/CZzTpQPjGrvZF5vqCTO61EiCku5j1w4GqjR19wPBunrAjI29rI=
X-Received: by 2002:a17:902:ea0c:b0:240:729c:a022 with SMTP id
 d9443c01a7336-2430d32b8a7mr2923825ad.11.1755028377016; Tue, 12 Aug 2025
 12:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154919.4132-1-dakr@kernel.org> <20250731154919.4132-2-dakr@kernel.org>
In-Reply-To: <20250731154919.4132-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Aug 2025 21:52:44 +0200
X-Gm-Features: Ac12FXwx1OhTXBSqNTxWMSI4678VquyiqAavjpkw2PB14JZbF78QjVQ8X5t3gEY
Message-ID: <CANiq72mWVmso1yMYGYih-NDwjB9E1iVE=_oSpPiSvqTu5mkE0g@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
To: Danilo Krummrich <dakr@kernel.org>
Cc: lorenzo.stoakes@oracle.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	urezki@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> aligned_size() dates back to when Rust did support kmalloc() only, but
> is now used in ReallocFunc::call() and hence for all allocators.
>
> However, the additional padding applied by aligned_size() is only
> required by the kmalloc() allocator backend.
>
> Hence, replace aligned_size() with Kmalloc::aligned_layout() and use it
> for the affected allocators, i.e. kmalloc() and kvmalloc(), only.
>
> While at it, make Kmalloc::aligned_layout() public, such that Rust
> abstractions, which have to call subsystem specific kmalloc() based
> allocation primitives directly, can make use of it.
>
> Fixes: 8a799831fc63 ("rust: alloc: implement `ReallocFunc`")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Did this need Cc: stable or was it skipped since it is just extra padding?

(i.e. not sure what you usually do for DRM, but I was looking at this
since it is alloc since I would normally pick it.)

Thanks!

Cheers,
Miguel

