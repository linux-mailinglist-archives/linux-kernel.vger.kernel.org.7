Return-Path: <linux-kernel+bounces-739117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B43B0C20D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD93A72B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1028FAAD;
	Mon, 21 Jul 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIj8EYNa"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AC28DF33
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095667; cv=none; b=LnzkJW6IZ/9jE8L05e5WqgmdplbXCZPidd9TGkmxvhtRv7I5XiwDwd1MDRpcPVxeRNV7rBN6hOOtPlk8Owr6TAdgnHXkkNgMX4FOmTK+ABqivoqfRZyAVO/TZB2/2hIEARz9mZQQnPzKXMBKqCXXeP3mzWANIlAfWw//LUVBdrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095667; c=relaxed/simple;
	bh=vvqRmzn5bsiLfDQPVMIJEqn98dYEOaVj5gPI9frgUKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgxVHTimc82FHmHZI0imWYJCVbLGoTWKdtbQeOg3zdSBukQmGKPetn2P4yIUn9I06ePYpiFOutUlcXbGSBU7Bp0sJHjEsV+mRx8YLyXPtRKz0y/BZBakcoa4C52UF/hTGihBdvQBVC6KztZ9fVOM6jgZdJ6/FvoN7Dr9086pt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIj8EYNa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2432790f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753095664; x=1753700464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmY+IpkmibE+BnldzW/yUpXObRNwKpLs/0Xryp2VLPA=;
        b=kIj8EYNam8LXepRBDgJSj3+801Gr5i+Ne5Mn9YzQ6zos+RrvPGz834tJWd/1bvVqeA
         cZ+uL3p04LdhBkeojVaCB1nvbAuK5LXZGtCIjt/bSucXW8fFTem9iKrq3Klgq7l031JS
         m8pMecsz+POvIJxXmInzERk/Mz/AKT1iVgmEdrRNk0f5xk3kEop97mSkWDxRviFStMNE
         7ZRD8SoYlb4drKToRnrHZiHR+YU6MnUm+709n1wnPrLqIiEXof/PjYAGHcevXUiOK4/p
         DTLgfegP+7YeI/mfCX4VehrgqTFcGCmhBnCEelU5BSFku42uXXNKO7ZOmHzhEgLDDAEz
         LZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095664; x=1753700464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmY+IpkmibE+BnldzW/yUpXObRNwKpLs/0Xryp2VLPA=;
        b=kpfwXmjP9F/xuFkSk8MfogsgNJXCPQ8kYhDrkYj7VUpSPu3p/z5T44X77I19L41ZJm
         lBho2bYKA199elB1yN3WrGPspueb8BY5V1S/hkn2nq6CXfSYTOwRrFRQ0Saviw/EXoHo
         onQ5cOkGEMpzd0oH1Bs0IXNwKanOXDLFhN7/lZuym+pwdu/k144JVo5hxqQlSGtV371p
         9/YDn50V0Sv73R7srQVjPG7+y7Klv+Uzj7ufyXKv3QsOk9eY+zCEfoancnCSWLA0Cx/z
         vWpmeJpCZD97XRriP6jtr6AH/XVgznj66zSlMMRf7WZ4PiqCiEgwh9cM0TuPceqjWcon
         yBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOUyREYQybFcA4qIKVNL4qYpK73MUwTyA6gypkh9YUPjgGFQbzk9kSbSJxmKuoKkBTw6CXNQqEkmN1lBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqKvHys3D3a4J2lviKyBWgHJ7KD5lSJKt2mpn4RlhB4jHiNcwV
	+MmfDS1f3HY1FCX36HKgzBAbB5FnIQJW2ODjPiChpcEyvj5pp/EEi0Gct5Vo+fYWDGr7F2ZW+FW
	sDp83ijYnqgxm6rXOhsE5tkNmDHhV2qI+8kydUvSj
X-Gm-Gg: ASbGncuEb05SVDvyVuh6uFYgDXFGr4tbEuh28pXLE8yitxlc8oVGr7uOXg4b66jeX+P
	5RJNq+LVsVvd8yQ6RbbOhZnvqLLX7Kxl2t7m8HddkGzd8yR0Hf85rVj/B0xowZv1Xo7ZRrrchsH
	7+veJT1CmrQGj0al6wtz5WAfJSDsXr1P9t16lEVC3+SZJv1ndC96g9OYoMioqrgaV5EPwBhhD5r
	YeCepsM8VKf6284RAUSMOwddm6GcYqy/DSY
X-Google-Smtp-Source: AGHT+IEDEegBWf7D/JwjxXCNJSDo4l+APz+X0qs4pQdmNxde/72o3MOGn11+E/f6IP+htttyF0gaDT6zRxAPVq+4caU=
X-Received: by 2002:a05:6000:2903:b0:3a5:2cb5:6429 with SMTP id
 ffacd0b85a97d-3b61b222600mr10029667f8f.43.1753095662535; Mon, 21 Jul 2025
 04:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625051518.15255-1-boqun.feng@gmail.com> <aGKWIFVl4nwSl8SG@Mac.home>
In-Reply-To: <aGKWIFVl4nwSl8SG@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 21 Jul 2025 13:00:49 +0200
X-Gm-Features: Ac12FXwftzBCY7VjqfRESxSmTve-JCl6P7gakKhAmACJbgq-_ANGdiID8v6daPU
Message-ID: <CAH5fLgj1C-BVAfK8Qoaxb4hV=s74-SNPUeHq9LtmQ5q8aqcd-g@mail.gmail.com>
Subject: Re: [GIT PULL] [PATCH v2 0/5] rust: Task & schedule related changes
 for v6.17
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Tamir Duberstein <tamird@gmail.com>, 
	Kunwu Chan <kunwu.chan@hotmail.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Borys Tyran <borys.tyran@protonmail.com>, 
	Christian Brauner <brauner@kernel.org>, Panagiotis Foliadis <pfoliadis@posteo.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 3:50=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Jun 24, 2025 at 10:15:13PM -0700, Boqun Feng wrote:
> > Hi Ingo & Peter,
> >
> > This is the updated version from my pull request last cycle:
> >
> > v1: https://lore.kernel.org/rust-for-linux/20250506045843.51258-1-boqun=
.feng@gmail.com/
> >
> > Please take a look, thanks!
> >
>
> Ping ;-) I forgot to add that this is a dependency for Rust version's
> read_poll_timeout(), which is a dependency to a few things:
>
> * In the `Tyr` driver:
>
>   https://lore.kernel.org/rust-for-linux/20250628.224928.6908316292615465=
21.fujita.tomonori@gmail.com/
>
> * In Nova, the gpu driver:
>
>   https://lore.kernel.org/rust-for-linux/20250619-nova-frts-v6-24-ecf41ef=
99252@nvidia.com/
>
> * In the qt2025 phy driver:
>
>   https://lore.kernel.org/lkml/20250220070611.214262-9-fujita.tomonori@gm=
ail.com/
>
> Thanks!

I would love to see this land to unblock the above users. I wanted to
add that I fixed the Rust language so that it NUL-terminates these
filename strings, so Ingo's concern from the last cycle should not
apply to this version of the PR.

Thanks!
Alice

