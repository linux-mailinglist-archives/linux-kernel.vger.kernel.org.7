Return-Path: <linux-kernel+bounces-805549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88201B48A19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414293425F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC62F7AA8;
	Mon,  8 Sep 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/5QVI7n"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C32192E3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327072; cv=none; b=b91giicVK8HhTJkWNpmLfnL+vYt9xKJyczM0nAQ3fpLhSZDoWOIquMkVWIqD6jfbVadxmLPvGcKXGTRmLYys5Rij5TaTVSHP64vuceyAk1oOAm5u3WZXvvzx0X2UhmNu1y+gD4XNAl1Kc0usgX35xRRSYW8+CKD3hfzvrVbdbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327072; c=relaxed/simple;
	bh=XnWf6lKHXJUHU3vhe1YUuEdjO9a2CX2ypi/RZq+5EDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd4P52jZrKOT4XxZ1+glCfXDDpIp5WzadlH4GwgMoksY/MT4xZqBUKcKT8Wjh4ZM9RNardvZreA5Y9PM6Y6HcmnN7s6Sp1J4/u1zAiQTOJDVn68/JNPvs04SKJU1aaoSVwr50NSKhT17bh8Sh33+1u71cP1BqWgUZ/zpowH2FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y/5QVI7n; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so4334861e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757327068; x=1757931868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwjChtfYMEeGuB/wdk7FN7umIHbSaximMcCkeQ4PR3g=;
        b=Y/5QVI7nhI6iFA+QCwmSQAWL5DYgynJTHqID7hupV7NjgLydvj/1xiLYreY5L8xnm1
         I7gHAJ0WlUOouVccC3XKhqIsp4DZXu3nAt8urrYRIKZsrsZZIEezh6kIECBlHl8fgCde
         H34IKB3QW5WbS/m92a9qqg3l1xFTZy1En+syOSZxI9NujszwVgzoiow8yoNCwSikhkLn
         zHKbI1qRPnoWplh2iXa86AFtVEDGNpBBQWk9qbrSfEb7rzhi98b+M1wVftsv/6Spep+9
         hE/hjQcRSAri15PHdhtXtx1Sb8uWb2/gQLaEE5HYy9f6sA1roYvxtNZPzvoQbcqeowx9
         do5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757327068; x=1757931868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwjChtfYMEeGuB/wdk7FN7umIHbSaximMcCkeQ4PR3g=;
        b=bhjbpEi3yXeJruok1VFeff4Zn8AlftOzGQErQquZ484EWJoVQfvqI20jbQ82sWcMtU
         +RDQ3LiDbWBAt1MU/MIeTAiiDMW/81U/WSNEaaFxsnV4Bh5aJM90/mEbsIjehYzLjSLS
         FXdtGXcxEAE20orM76uweupzYTeFWFPtg9zK+dubIt4tcQ6bsfWvY1KZD5XQOhM8ZbDd
         A1DLv6C9ZU2nSoitcsuerUIhshCmmvnIq6H27Xx9uk0QFPHsoPuwPe/sQHlaIcH3lG0J
         LDg6wRJqVPnc+oqgdanKIS3i2FfLR4C6kYlBOcIRRJSUzXgCBIVzUNMwkDUKAnEWEfxE
         +VPQ==
X-Gm-Message-State: AOJu0YwcD/hcadiDZ5deN6i9d0XWVyM+NqKYZ+QacrqHVaopQBjaUyF1
	rhL4sskztlcUShehVw0H1tvGEyU3WWix4bS+pVkYN+fXGI7xGssGgk4+Tc9s+Q+flTbF2YsOG+R
	ZpKothDueqQFPhL8wewWLNjHyBxz6SbS0mEqbEwpGIA==
X-Gm-Gg: ASbGnctagIiuQavhG3BOrDa2BsQnJ5nwhhhN9jQB3rEK4i/+LOwHRgm1Y4k7wBSpvYh
	U5kM+QelZ/E24Tpu1g1VO7XdGiwZE8NBI48I42b1h3ZspiFe0xDJKxcwnY4ucIseyfMQhwFPvqF
	1tte/jCa4Mm+oN2Kss1nXhZquiq4OE9mwMa/QyKVFzo3+5IH2Q/OR2SWYn3DyMKBCh4WUztAH/v
	FSFbzQasffAECwk3Jt7DMniLecuvs3v+x2gADseX/JnpQ+fdxY=
X-Google-Smtp-Source: AGHT+IEU92SWFcqL2QLe01sPUZQ53vA4dSF+LeC1eGi9vzhaBBHpAD5T0LpNw8VkFQ7aMMrmY4T/VkWVtAdVP7ScVQ0=
X-Received: by 2002:a05:6512:3984:b0:55f:4e8a:19b9 with SMTP id
 2adb3069b0e04-56260873705mr1755433e87.25.1757327068230; Mon, 08 Sep 2025
 03:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090819.107694-1-marco.crivellari@suse.com>
 <CAH5fLgiZnCbNLpuphv4Kgsu48kRkhf6wJiSLrrgsqyEDvU3X3Q@mail.gmail.com>
 <CAAofZF4a6ARXOS0rmK5zY1Kd3xdODqdkj_keZmEYx8Z-JRvhng@mail.gmail.com> <aL1lkN5WcWkwiq3S@google.com>
In-Reply-To: <aL1lkN5WcWkwiq3S@google.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 8 Sep 2025 12:24:17 +0200
X-Gm-Features: Ac12FXwzRONvDWlYnRSSfpeI4s-lFdpCX_TWM6Wio52dNFtybcl11454WB4Q3Oo
Message-ID: <CAAofZF77saPdGYXt-oYkfV=2pRCRtso5eJuw+FqmS8b8WERgOA@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:59=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> I mean that instead of:
>
> +/// Returns the system unbound work queue (`system_dfl_wq`).
>  ///
>  /// Workers are not bound to any specific CPU, not concurrency managed, =
and all queued work items
>  /// are executed immediately as long as `max_active` limit is not reache=
d and resources are
>  /// available.
>  pub fn system_unbound() -> &'static Queue {
> -    // SAFETY: `system_unbound_wq` is a C global, always available.
> -    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
> +    // SAFETY: `system_dfl_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
>  }
>
> you add a new function:
>
>         pub fn system_dfl() -> &'static Queue {
>             // SAFETY: `system_dfl_wq` is a C global, always available.
>             unsafe { Queue::from_raw(bindings::system_dfl_wq) }
>         }
>
> and do *not* modify system_unbound().
>
> Alice

Hello Alice,

Ah, perfect. Yes it makes sense this change, you're right.
I will send the v2 introducing the new functions for both the patches
in this series.

It would also make sense to also change the above comment, mentioning that
system_unbound() uses a wq that will be removed in the future, and so
it is better to
use system_dfl() instead?

I'm thinking to something like:

+///
+/// Note: system_unbound_wq will be removed in a future release
cycle. Use system_dfl_wq instead.
pub fn system_unbound() -> &'static Queue {
    // SAFETY: `system_unbound_wq` is a C global, always available.
    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
}

+pub fn system_dfl() -> &'static Queue {
+    // SAFETY: `system_dfl_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
+}

Sounds good?

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

