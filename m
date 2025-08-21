Return-Path: <linux-kernel+bounces-780133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB193B2FE11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C961C26F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C338F9C;
	Thu, 21 Aug 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3dODcZ7h"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25D16D9C2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789165; cv=none; b=a7B5z451x1+3+iUfTSudwkKqFeCHGQ7TbGH3qeYlaY/W8V6trKYJCJ5kLV0Ipvu9Swy2hh0v6MpowxATQcpdheCN8wbrNYDItXQlhRJnev38AxxMGT4S/OR0MNe7b+gXxEmMXS9ggVjegpezAMZ/zPaou0N8f8B8l6nffA26c0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789165; c=relaxed/simple;
	bh=2ztGlIi9jhNoVS9BS3L9BthWA8NithL9Qy05+r7uzEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2yn5ixgRP1Xsx3Z5v1SlToZwoATJDGONfL9y5QpEXxtRKJkeVlIL9R98h3DX/CDk1BNdDSrdGp9hyMw9AOllJHIUo1QuPgl2rjp41w03hFJFcq9Ei82cIYNTDhDDZ3skaoAPoR91lLluT7qN/xOQwPBi6rK/8KQyLPwlZonfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3dODcZ7h; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f92a69d4so8722731fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755789161; x=1756393961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ztGlIi9jhNoVS9BS3L9BthWA8NithL9Qy05+r7uzEo=;
        b=3dODcZ7hmPv9PNKiFZbNfYlM1uaUvRadV47s/7LEEVifubbJRElbQeFDD0kKUiHrm3
         02ciFTMxcMI99EjMvvGKXwMsENmVdR2YLloDOKKXeH78H2gW4iQev/0oP+qYKQ3xDbgk
         JlVRLFZY3phuAhWfjX08fylMjIJo6phdkiiyZ3RPPFfBWcfazsNcQUPyKNk/Rys6752r
         4ADiGObUnWlzY6k5fNkloUhC3HnaRxjKolpIAGOUOLmsLoPNSTzq0H/B3V4HCInRpe4T
         L7blLIHXlUf9C4asMoJHqOiU3fgXDpVD/JJYyPDdaA+GnJ90ltQvQL5/1cxiSEXLnzPv
         uC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789161; x=1756393961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ztGlIi9jhNoVS9BS3L9BthWA8NithL9Qy05+r7uzEo=;
        b=trExJZHCHGfr4rRU2ART8giTOBvkgZfljCJvplVyCulcjV2fDT25F+tYumU3Yz/Z8j
         u24lukwuncqyS+r+t3DorjIkG77X5rqt8gA9wXJZWXHcE9Y0KY1Y1QyUSf7x1A2svpjr
         8b+o6tCJT2pHdn4OfZvnRT5v+UE/2cUekz0sGsrpcZgmCm5bP3B46z0uJVUuDLG9PLGe
         Xz7XN3y/F4iO0vpVnGKOcSdby3Bdv3njj6kOMjv05fixG9lG8IXu5O9pGr02UmRG3j7D
         RTiRRsPmn4I+amHMT0eAexM/bLPt6nW2Xq00ffCPCWee9y/MW0bRf2wT3eektktktjhD
         oXlw==
X-Forwarded-Encrypted: i=1; AJvYcCXg2DohpRYaa/EijMkycZK+SrMGkqQ/bpMmD48dU6yrrmGUfYxhIB7OQkUTG55sUJfvQBfQortLwP6riuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmyUAvNUz/oe1aHvoGOidM0lLj7dTYNtjVJ/z2uPjkaFYwOUK
	Tx2AfQjFGu5q1/QmJxRGSTNs8w7h/JYHqioetUSZKjjDAs9IfDv6iNaPs1ZM55RvAg/ON2K2V0v
	vqrPi/Q8L9D+cflvX8YsAI2OuJw21/J5dLPw2j6UMBIm7hJqF4Zh2pu6YxWU=
X-Gm-Gg: ASbGncsy5cfQAS2jpXsYhgdwuCuIgqmqD1ogPzvDyhk9s+q6mhbdkRhRyRIMu1h78O9
	RUAMtpxmQqrkqZxPIlkIFELiVPZpvvvCfh6kYrpI+GUPeJiozAnEc0gZk4Yz+GFUnvcxW6s4311
	WH60cYt1ipS0SZbo+U3E3RLImk5bTcpLA4clyhzECEp9DGJc6D7t+vblG8mHn5Awy1im1WY9CzS
	Rda+eVHOSBYbLjJTBcYRBk=
X-Google-Smtp-Source: AGHT+IGgs3o6N1t7H2DOARQPBYqR2fDZBHhF1hDPpM/VN9qB9DqymvvNNruI66I2wrgVpAwwEboMyUeNt/ldkvHZX2A=
X-Received: by 2002:a2e:a556:0:b0:330:dc53:22d4 with SMTP id
 38308e7fff4ca-33549e40356mr8950451fa.9.1755789161039; Thu, 21 Aug 2025
 08:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747817128.git.dvyukov@google.com> <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
 <CACT4Y+ZcQV3JWEaeh7BXNwXUsoH6RcVRyG2iNUA+_mrOBOHfNA@mail.gmail.com>
 <CACT4Y+anDdNU9rh1xsDRs7vZRfXbbvjFS3RRBu1zVejrp11Scw@mail.gmail.com>
 <CACT4Y+b0cdGZwqmZSikxam+ASp9LXMuT9f8iifnmNed+PjamVg@mail.gmail.com>
 <6e737bd5-1167-4cc8-96c3-abc3d3598d2d@efficios.com> <885a517e-fe3b-436a-accf-9d8c6b991aee@intel.com>
In-Reply-To: <885a517e-fe3b-436a-accf-9d8c6b991aee@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 21 Aug 2025 08:12:28 -0700
X-Gm-Features: Ac12FXxyRT5emCZFTeuYmrsgCHoL9i8AEcQNDZ3iVBEavAMVHB8G2k51aEdN0rQ
Message-ID: <CACT4Y+ZtFPSaNyp9m=cU-QZNeRz1GoUHE08TDq+X-8yAz34Rcg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: Ingo Molnar <mingo@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, dave.hansen@linux.intel.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, peterz@infradead.org, 
	boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, aruna.ramakrishna@oracle.com, elver@google.com, 
	Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 10:41, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/21/25 06:25, Mathieu Desnoyers wrote:
> > This series looks OK from my perspective. I think the last piece that
> > was missing was to get a review from Dave Hansen.
> >
> > Dave ?
>
> It looks fine to me. I think the best thing is if you folks send it in
> as an rseq fix. I'm OK with the x86 bits. For the series:
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Ingo,

Now both Mathieu and Dave reviewed this series.

Can you please take it to your tree? Or suggest who can take it?

Thanks

