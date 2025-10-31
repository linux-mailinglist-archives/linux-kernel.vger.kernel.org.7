Return-Path: <linux-kernel+bounces-879943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82005C24759
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78291A661C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973333F8D7;
	Fri, 31 Oct 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgZr/ZlB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9233F8CA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906282; cv=none; b=iu3fGLG1B5kZ/ZlrqiurfVOv2+7KnEr/hPJP26zeE8AXZyYtnYcCe5mSJ55syTIZ/xx9RZgzwnYktFm45WSjebgMK11FJ4pGYH/l4+J91NDmdmeT7mjSgXn+OF+dnchWCrFiabwSZGbByqddbNP1UyZ7TZgmVd2SCbqEzYOd0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906282; c=relaxed/simple;
	bh=KieV0O7byC8e0nnu0XsmTnOJPcll1gsJYOjgt6OjyY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cjkedrEg6W6ouaVATZG/P8EtjHvGSJe6PsMc/zhSkv9WqmToUHtqlXYCMAgHo/m2vKTqxOVEOcEdd34jXpIEFnxlgo8N0dZDEhYsh7wtgf3loLRuDFcc/5jikkHiol6OIQ5TC2fyAPEmWk31TiuYATrujxK+MjNkA63TFKevBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgZr/ZlB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4773a7dc957so889185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761906279; x=1762511079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CRyUBEdYzTfHD7NFKEMLRCGWmiMvGoOUHzXVYzcwM8=;
        b=rgZr/ZlBaT03thp9K4M9q3mxJ8HMcIDcCv+GH+b+9y4TUnC93vuN3Hdf+qBoNGtqwI
         ZGmJCAAhVp7vcuP1In/Khz3rKdo/PeOWsFT0bDAmAQroZmyu/ObBmr9YZsB8RdH4UXEI
         YJSyFbo8DIdfgR8zHKQatTHSHiHne8v6KtQKQCqfhHd/uEw1bYJu6qRfPiKYyEap2H6l
         R19rN+NkMatdwD5tUv9rRlvmz4RfeBaCk0qizSroVMwUZafF35GhqEkwNCMnamz7w5CX
         eNg1Gg1M8blIQGGmVUtNmBGuM3g61N347gDA/qArTIAuQWxGGzp8Yn7kARbEZJVcYCZ2
         83Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906279; x=1762511079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CRyUBEdYzTfHD7NFKEMLRCGWmiMvGoOUHzXVYzcwM8=;
        b=NEFidskGadxnQ+C8zN7Bu+3hvparHvdJjnW0YvzrCXoEzXCSB4VIlXXVpQjqra4L1W
         pQiHQU2oQEkmgQM2aUfGKwrS5gun0y3/fntLdEEUWbkd0wlJcOEPhMS0hg0swl9mjNN2
         6DWvqrj+Fpvu/VpcPsYn1pWQ2zJmBscjZ0r2AaGUDgY/xgLdrdbk0gWRsKj8yJuiPc9P
         m9Y4TrVnDB/YgtRSYfkn2+zJu6bwk4J7g6NAiB+lWtU8gee2VIcqznL6g/liHFFu7zQW
         dDrhJcZnj8tPr/Lz1MJdZDKHFBMnxoiwvOUKOazHF5Jz+eQ3U20P4RUPyOEn49FvIivk
         ccoA==
X-Forwarded-Encrypted: i=1; AJvYcCVmsP134eOar+qO8zUhj/F9KSbqIH1JDhhGRwajSlos/Dz8ylV+ySGCRgUhqdmMC/xR0WzHxTmJ4p6ir9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNuvcED/ovB8EEwZhXiAfxQ0P9uC+vFOTml3/5fTB1l+9JErhB
	UNhuJTcN9zO64ljlGndrNmA4jPmFDkYYclxOlmoS7QrMWzyYwQcXO9N+wvq5xEnF4Gh+osrxmJz
	kBbl1q3Bq3WStZFLvWQ==
X-Google-Smtp-Source: AGHT+IFJiNqrAFjhTH0j1IQrWmuNfO9ezr7CBAv4dYvxjJD8RXOTsTwsexS+6DU3D3HPKTldT7mYPQwVt4lzjww=
X-Received: from wmaz8.prod.google.com ([2002:a05:600c:6d88:b0:46f:aa50:d711])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3146:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47730802df6mr26133065e9.4.1761906279576;
 Fri, 31 Oct 2025 03:24:39 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:24:38 +0000
In-Reply-To: <288ba4d2-b7db-46cf-b979-341a58613fc0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029183538.226257-1-lyude@redhat.com> <c1ff48ea-53ca-40ea-9541-85abd1a528d0@redhat.com>
 <e0112480a6786c64fa65888b5ce8befbba72a230.camel@redhat.com>
 <CAH5fLgiWceOs-VtDnFkx5EBxCbAnJ3cLkRwp9adQC7x9oJCDFQ@mail.gmail.com> <288ba4d2-b7db-46cf-b979-341a58613fc0@redhat.com>
Message-ID: <aQSOZu7nN56Uqj6V@google.com>
Subject: Re: [PATCH v4] rust: lock: Export Guard::do_unlocked()
From: Alice Ryhl <aliceryhl@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, Oct 31, 2025 at 10:38:32AM +0100, Paolo Bonzini wrote:
> On 10/31/25 10:31, Alice Ryhl wrote:
> > I do agree that this behavior has a lot of potential to surprise
> > users, but I don't think it's incorrect per se. It was done
> > intentionally for Condvar, and it's not unsound. Just surprising.
> 
> Yes, I agree that it is not unsound.`
> 
> For conditional variables, wait() is clearly going to release the mutex to
> wait for someone else so the surprise factor is much less.  Having it return
> a new guard would be closer to std::sync::Condvar::wait, but it'd add churn
> and I'm not sure how much you all care about consistency with std.  std has
> the extra constraint of poisoned locks so it doesn't really have a choice.

I mean, it's not that much different.

	my_method(&mut guard);

might still call Condvar::wait internally, so it can release the lock
today.

Alice

