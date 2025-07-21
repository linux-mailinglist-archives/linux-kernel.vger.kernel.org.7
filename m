Return-Path: <linux-kernel+bounces-739418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A3B0C610
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EDE7AF50B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F180273FD;
	Mon, 21 Jul 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D++7aQYF"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C41A2630
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107466; cv=none; b=JaEE5Va7G6w6KW7hQcDJ6cJPgvUXpmlv+Ymb15JTV9bvXZMqBUrMMfwjcCvjZg7SFybZkxCwkCkC6YR+qSphpl8L/spV+TRuktB2h+7thy2fyPFuHD8raXfC0GXXyERHI/YQ88b6UsrliHtCB2qYGspP8IYcGiZo+4iyKn0Y5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107466; c=relaxed/simple;
	bh=jx62/zzI69MGOw6Q1ltR2MwUC388v3A5IGqMmpKVPmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c530s/djAb3Lm8RtZfZtH2clHgtQgXzsR27gaP7kVx2nAKCJa7Jo3p+b//CNYNcG2h1zFWP48FbqlfmX0pmVJrH7aDc2ObcndM1nJJtyqjWfpKIPmDOzFgZsnLr7FHRTWyXUnDpxCw9UDcQkXcdVmC9juRzM0fo0CdKJW71IFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D++7aQYF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso33318575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753107462; x=1753712262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHTz2f/tCB5gJfHRUHusAnrHo0WkysiHKc8/HuxZcyk=;
        b=D++7aQYFr5L68qNWwL/6zhUENYiKjmqUo1TJh2Z+2mF60qdLzy6CIZ+pGTEMtQM+HK
         7YKl+TD5gKVwZ3EMqoX75nloA/j9A4+Ics/VJADr3c7MCue2dUtz2eDhJiPOeIDmj4Kj
         woZ0BiltwOVZoVbDkT4AoIoq5NZlBAUoQu0I4sWUvmi6YoSdApdLKoHzn9h2mz+DKMKw
         0DZYegFgRd+N6AxhW69vAmAJhKuWrX6zrBIEr4IL5AUpPzx8ZHobPTEvPFucknhKpSJ/
         LMdwYMp2C5v812DMHr7QH0aWt7+fR96mCMpCJGDu18HnPppnpjQ7ayqkJvnUcBAr2RGI
         EXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107462; x=1753712262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHTz2f/tCB5gJfHRUHusAnrHo0WkysiHKc8/HuxZcyk=;
        b=VSOO9gLcZE6ERCqZ0HbQcX8Ciy6F/rVu//2Q5O1ewEhsAMsn+df13csJpTDR0hP7BY
         ctu9yjytxqYBJKoUxsrY8Tb6zuPemQUoQadWAnSoFujPUc3I62BM64PmvN1i1qjwfoWs
         ka51QLEl4UV9bI6T15izkaWzHmKLoXuSn/Iw8QSPz6KtbbaCOuhtp+LkhOA6ZkSIa28L
         G7RPQGkptZdoqbwmpu0VR4aoNvgQ7d7SILswSyliGrnnQJCy0Z2z7IwihunSI6GaNfnr
         niB3Q2clDMUoEV6M6UGuaiJtdmBkaW9/3SYSSrVos3rIs1IU12RMtzcWfjxWu27kJZoV
         kfDw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1fZ6cBKw/YvYq1M2KzehMn5NwbgrNiIttOr5+1hP5SAS9KQig7BSlOC4pKk0BbnufQiXDLg/D0AJJ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NBWkogmYmWsZ3qxL3A7YdNwHnvvnXHEnBgfjSpLbMVUkq0hZ
	xBBqJlKgl5jl3c9V7ly03q8Y9OZzh21XQNi6D/zM49115h9yxmmz9KzLqWTIiWY1vY+NqrYd0wn
	HAvbEZZV+rMiINutylGcqo8RhtNWbx3R7qKXJeps1
X-Gm-Gg: ASbGncvfCrP1/TKX1mIsUgrQN8P/8M/FpQ9G+90F9nSdBx0R4pYSRcdl6VffXXO8s75
	zq5vgl90SM96KDr3i4P+1Oqcu2QE1NIjWupkoO9UYX7Lbx69HLkeC11NstkS/WeInk4d4RjUNUo
	OCrtgYzeVhxuZiLG9xZTWsesSp8/zZWMI+K9Emrq8c4d87a7AFB7jcp1xM7dC+aj1GKSrOCRKfu
	gpt33RqspzCcgHK8o7uD83EIjgC8NTFMf9jiA==
X-Google-Smtp-Source: AGHT+IGjLzZ7/Km2FCbSNRsrArfXJV2GEMgIhjJN78UwwjSKkWJY+F2cHXQv40vfc3kSfYwQzfjjab4StDfPm4kGNEg=
X-Received: by 2002:a05:600c:5253:b0:456:1efa:8fe9 with SMTP id
 5b1f17b1804b1-4562e03a678mr216153965e9.2.1753107462190; Mon, 21 Jul 2025
 07:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <202507170718.AVqYqRan-lkp@intel.com> <9834736F-F70F-4290-9DE8-755A6D0D5EB8@collabora.com>
In-Reply-To: <9834736F-F70F-4290-9DE8-755A6D0D5EB8@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 21 Jul 2025 16:17:29 +0200
X-Gm-Features: Ac12FXzqc3WLYmS_rx0F_dtIhtQQ4LQMKVOtCM3xLb6rdTs9AmutrC95-1kYQiY
Message-ID: <CAH5fLggfp36q0UmF_XNLCZKn+fc1xd2hMBsYX1UrtJqBFYrf+g@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: kernel test robot <lkp@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 6:21=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 16 Jul 2025, at 20:45, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Daniel,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on 3964d07dd821efe9680e90c51c86661a98e60a0f]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Almeida/r=
ust-irq-add-irq-module/20250715-232121
> > base:   3964d07dd821efe9680e90c51c86661a98e60a0f
> > patch link:    https://lore.kernel.org/r/20250715-topics-tyr-request_ir=
q2-v7-3-d469c0f37c07%40collabora.com
> > patch subject: [PATCH v7 3/6] rust: irq: add support for non-threaded I=
RQs and handlers
> > config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/2=
0250717/202507170718.AVqYqRan-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87=
f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250717/202507170718.AVqYqRan-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507170718.AVqYqRan-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> error[E0425]: cannot find value `SHARED` in module `flags`
> >   --> rust/doctests_kernel_generated.rs:4790:58
> >   |
> >   4790 |     let registration =3D Registration::new(request, flags::SHA=
RED, c_str!("my_device"), handler);
> >   |                                                          ^^^^^^ not=
 found in `flags`
> >   |
> >   help: consider importing this constant
> >   |
> >   3    + use kernel::mm::virt::flags::SHARED;
> >   |
> >   help: if you import `SHARED`, refer to it directly
> >   |
> >   4790 -     let registration =3D Registration::new(request, flags::SHA=
RED, c_str!("my_device"), handler);
> >   4790 +     let registration =3D Registration::new(request, SHARED, c_=
str!("my_device"), handler);
> >   |
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
> This is a single character fix, so I am waiting for the discussion on the=
 cover
> letter [0] to advance before sending a new version.
>
> [0] https://lore.kernel.org/all/DBCQKJIBVGGM.1R0QNKO3TE4N0@kernel.org/#t

My suggestion is to make the flags module private and re-export the
Flags type from the irq module. That way you don't have to write
use kernel::irq::flags::Flags;

Alice

