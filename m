Return-Path: <linux-kernel+bounces-801690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC327B448D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58898189F9E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716812C08D4;
	Thu,  4 Sep 2025 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsMPoRGR"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAF295516;
	Thu,  4 Sep 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022628; cv=none; b=BPeyLe/UzByukDV+vU4aj+JrsqOvW7RkoekJpiwDytmelNcfrAs79HItKRKYBKbsDSbZFKOdXwMajYwM/58+SfuTmXz7i1WzRpvlB2fUFDlYVhGoJ41xAwViT6x/eNTZTjkdVpVbVv8UAT9XqqsD2ggP135mjvi8oDHvkiYLf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022628; c=relaxed/simple;
	bh=IRDiZTv3OYvUsc0Jx4n9Wjgh2UfzP/uYMQmFzvZ7viU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hizulb9gxiTF4a+3sP+3mQrVlyxdVcq4qh4KrpICrl5OuxIe+Bw255gWzxd61x5MbDcPAPulm9InK/OieN9LkX+hf3pXORZBoezfyLOjz6vGpadWPZHVF7qc+UgRLKZcv8Brlcz2Ba5mZ6ywdTz3yPWfO6zYxeWJ5i2zd5uKOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsMPoRGR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7723f0924a3so2102137b3a.2;
        Thu, 04 Sep 2025 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757022626; x=1757627426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EzWsxCCVon/G+ryLza8yWbR2S2Ik/r0FDZw8OJQuNvs=;
        b=RsMPoRGRvAtzA1nA46Zibo4yL3HWylgbgzJ32x5oLdSvsRgjoHBXA1ituWBFuXCnrC
         caMxw1ZYP3FHF2ydUjgbN9Slp3E3U3OsTwxgaYe8RvEwVKOlUo89psl6fb3DP5hy/bzF
         G2TRikbm0NeYmD3FUvgd0W+an+YN7r7MZIBOYNxMbsdLpXt0csUdlB2e5Oh8YAA8d2Dd
         LyDOMk27+LbJc/3ugB0riLL+MkQAYRXHvR0AzoKAbhfPyK3iY5/D8klZm96zfZ8vnvak
         6E84I8UgDX4FNAPJ1TNNOdh7rEM7yWnES6HIkLmCLmwUDjCKjV6lR7sxAVkm7xinNOb9
         dSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757022626; x=1757627426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzWsxCCVon/G+ryLza8yWbR2S2Ik/r0FDZw8OJQuNvs=;
        b=iM4/JAAF0gIsNkRjjtV/wsrZkM6EtH7jQhIhl0k0m2RBUmOfpIBFyUMOMKWs2mYYRA
         4eH+gCBTCuI7CBLNSefybguTL6hw86Rqxo0pIE9TkwPaXnTchIuqUcXDzWfroboHdYnD
         zBkcdUEwoYVRG73xyAVlNqz68gebOpuhtEMMGtfdlXhoScTXpwgW3bFEzE/RPWw2Rndn
         zbY5uq3ItIphx0Vyq5cSCLnCwh36sOpEeae3ShHoEWGc4LJCs8X4iZlrklqyKGgZIHzJ
         mvXZILtlYBT1O0G6K+zwRPExUEvDWlj+DpACAI0RD6HnCdQEdFgncynF6L+pyN+zBGLn
         XhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwFk4FUnPIizC+U14+PKhHxvvfosRli0QNejChsJzWKrQucXhl4VqHOB2sW6DtIkmye0BfATc6VLFMp06AjYI=@vger.kernel.org, AJvYcCXMvsRthxEQKIEce8zeI2H+P6epjC9Enw47xyc/TLKbGIac+J2jj6aEmQd2q1PcPYDxAHYeSglb6DSwKe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOr5OdHUPKWXnn9t3QqtDKC8z7SmS6R9/6pf/vgQW4KPc3m12g
	ZDlLy0YwdMS2hzlT2qsgU5zijSQXUYWxjldrnnAyg9vjFWOeYNQTx6kG
X-Gm-Gg: ASbGncuTGV+cvxAJzgk9EDmNmWDQzctSeISl5UyK1+0orT84ZMDvIBfThh4JuYPLlWH
	yApoVUouSRt7zfhC7P3pEXSWgTlRr9Qlu2xDgoNyKzMssLdB1g1Ioj9ganB6Eo8Tun5z86MkdPt
	AOkpsdhgFlWj1gSTIsQ8XA6pdyvKStdzcl/3Ng7x6L3k1GR5jaIRKGW5UfKonLHJ+qgoyZERuKp
	bY8214SeuqylnV7UTVC5jwUt4Y93PhtajYLm8Y/o7WpOFftUnLrFVyxk4Aoqqe385p32XkFjqUX
	oMffV9Q/merfBYuU2oYDu5ZVuojH+SS0fc1AKoCqxws63pudyJ9mtMq1w6K4EVWBTOcupZsslPw
	rz/oFe9jxcJcYgqZBAQHrTXkNAS8=
X-Google-Smtp-Source: AGHT+IE45ytdzBxMga75esb/Y7Im/l4pSAA616Pe798pih9rJgiPf5vYwPMS1Fhq7qCOSOl6pr2tkg==
X-Received: by 2002:a05:6a00:ae01:b0:772:45ee:9b9e with SMTP id d2e1a72fcca58-77245eea098mr20166665b3a.9.1757022626403;
        Thu, 04 Sep 2025 14:50:26 -0700 (PDT)
Received: from Cyndaquil. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm16575595b3a.4.2025.09.04.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:50:26 -0700 (PDT)
Message-ID: <68ba09a2.050a0220.84a5d.2f3a@mx.google.com>
X-Google-Original-Message-ID: <aLoJn0T1uXHCe1T9@Cyndaquil.>
Date: Thu, 4 Sep 2025 14:50:23 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
 <CANiq72nnWmzOfZ1PhSid4t_e-yWEgi_hVx5Uj4hrB9wzpuP6nA@mail.gmail.com>
 <68b9f3d6.050a0220.174510.28d9@mx.google.com>
 <CANiq72nkZ0F1_YUfBg_y=JcEMnQW+uVr9v4BXONUJdor3ZJzgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nkZ0F1_YUfBg_y=JcEMnQW+uVr9v4BXONUJdor3ZJzgA@mail.gmail.com>

On Thu, Sep 04, 2025 at 10:37:48PM +0200, Miguel Ojeda wrote:
> On Thu, Sep 4, 2025 at 10:17 PM Mitchell Levy <levymitchell0@gmail.com> wrote:
> >
> > Will do.
> 
> By the way, sorry -- just to clarify, I didn't mean to remove
> anything, but rather split it (likely at the first full stop).

Oh no worries, I gotcha

> > Yes, this is true; strictly speaking, calling this function without
> > dereferencing the returned pointer is always safe. I suppose I find i
> t> clearer that, when a function has preconditions that are necessary for
> > it to return a valid pointer, the "safe-ness" has more to do with the
> > functions preconditions than the act of dereferencing the pointer.
> 
> In that case, I would make it safe -- we don't use safety
> preconditions to mark "dangerous" operations, so to speak.

Understood.

> > In this case, the pointer shouldn't be going very far, but I think this
> > logic applies especially well in cases where pointers might be getting
> > stored away for later (and so the validity of the dereference later on
> > might rely on non-local conditions).
> 
> But that applies to any returned raw pointer, no?

This is a fair point :)

> > This flows from the first requirement (that `self` is a live allocation,
> > which is necessary for `per_cpu_ptr` to return a valid pointer). Though,
> > as above, simply possessing this pointer isn't UB, so it's arguable that
> > any call to `per_cpu_ptr` (on x86 at least, I'm not sure how it's
> > implemented on other arches) is always safe. Regardless, I agree this
> > comment should be more clear (even if the function is safe, it's
> > probably worth noting why the pointer returned is valid when the
> > function preconditions are met); will fix.
> 
> Sounds good, thanks!
> 
> If you have cases you think other architectures may have different
> requirements, and you think it is likely one could enable the support
> for other arches and break it, then I would suggest adding a comment
> about it.
>
> Or, ideally, try to see if other architectures are fine already, even
> if you still don't enable the code in other arches.

Yeah agreed, I'd like to get ARM64 support going soon-ish at the very
least. My hope is that I should only need to mess with `percpu::numeric`
and `PerCpuPtr::get_ptr`... usage of `per_cpu_ptr` *shouldn't* have any
prerequisites, but there's just this note:
https://elixir.bootlin.com/linux/v6.17-rc4/source/include/asm-generic/percpu.h#L29
so I don't want to make strong claims :)

(note, I think the comment about x86_64 might be out-of-date, see
https://elixir.bootlin.com/linux/v6.17-rc4/source/arch/x86/kernel/setup_percpu.c#L32
and
https://elixir.bootlin.com/linux/v6.17-rc4/source/arch/x86/kernel/setup_percpu.c#L165
)

Thanks,
Mitchell

> Cheers,
> Miguel

