Return-Path: <linux-kernel+bounces-824585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C704EB899BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76320586034
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724D25B2FE;
	Fri, 19 Sep 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQLULYpi"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EF23C4F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287257; cv=none; b=EDpEBsiwlNkJVMsxMQdO+xBiZIHyNIyFD6oo8yO4RT/UyF4ebw/H9W0kwL01FxwDer912ZHYQvQEYnS1c4PThOAb55/ahY6LQOlRc2XyUMqyfRkh5FUAqdxmyuU29oAsbXyIPxU0mSjE/0XXqdt0fmXmhWNF5GzQk0/IqZsMepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287257; c=relaxed/simple;
	bh=9Evrth9omEu7LnLSDoHOTwjlOVVGVh9MSp/R77shj6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggsfo3IKp+CXvUA2vp7iMa3JHrb+Sikk9oRu7tAd3Is5rbqhsxLvwrKZw9WX/VHSxIr0QJtIZB1Id2/VqGUW/JW4WQqGQaeHc5FRB+/RMLgjF7pfMkmzEcSajErvnIjgVxEOILmOx1IHSDPDrFHYSHBivDFu8WCzrIMBZHoQUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQLULYpi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3515a0bca13so34102331fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758287254; x=1758892054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Evrth9omEu7LnLSDoHOTwjlOVVGVh9MSp/R77shj6M=;
        b=GQLULYpibn5TmqPImqBO1LN1We+m6wrwap3gtH0RSVT/PFnEr4rGdy3ZJM8ZNDFAwz
         SEFXQcQ4Zz9WiZQN55vV8vgkU9lNeTL/rqEYA1l8WCde/WKry33tQOSZSm4hCh1v8D20
         jCXtVKX8Z6eYohanQnILR58S5v4kq3NtU6EuVH+ueH+rVDdUH0CaXPfZiiubeIkt0pk3
         ZJ4xSU3AHB5JUkcn8OgrYbor5YcXGm+uF9+fsuNiDRJRYVivB9Aqi1hxVBXmAtOECVxb
         t3a1l2KdHxsOrmc0OAYWm9GGr/NMplySDqgR1cVYgFeWS0fxUzRJWm0VTvNQ+vujsN2w
         Iebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287254; x=1758892054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Evrth9omEu7LnLSDoHOTwjlOVVGVh9MSp/R77shj6M=;
        b=c0eFJAdcZk/CRi1nb6X+Q5gJQvBFUynyvxWpjN4VISiPe9yNTkrb5m/mA3sMIO2Mcj
         /nuxq7NIZGzzREqbwDnnbZYZXZQ2Nm+2GqyQUO7ORWcmAVUxKaIpLBMgmKQ3cUsGa6Uk
         YP94N59Wo8bcF2w7RsrZixYHrSpVFUuEjUi+r1xeTK0QBCYSj3aFBJWj8D882rgkuMS+
         3rJZKNPJ7nwFwP2BHJ3mPVzR4tsxhn6Uba2UluA8F1k0Pm6/2qyqW1A1kzECZqzLvFLM
         LReUyW2I3KtCW+LRBqbWnlRlsP21yihROpEM6f9xdQW7z8tgWFPd02g43gOr2wRu3VRr
         jQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgKqUjj0Mt0sJ1m3HFPgWcFJOwUbXDWn05MFNy3+/RZwu99guWAF0o37SSz7drdcb/SYnUSOd6ZS7Ps08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2R/eIoBUxyUNFIjJ68+87ri0P+0963W9gIueEwWzJ9/8Qrvs0
	OVqX0ZH95DhypNAXkgk/rvKN/WuwJYkPkbtt6rDmU8HAuyiq6SI95KhPRQfWv4SMbizZHXhs4kT
	oTxDtjwLvBlXQ09lKJ6Y66cjwxv5zlE1UUeP+VVVr
X-Gm-Gg: ASbGncsAhrH566WLgrBNBzsCMwecn3T53Ch5eKJ3O0Wm/bdZNw+DENMfmeRMvNvsynK
	6nMD7SR+z0SbYfzmD0Fov/sh59MThs+GQRj/K54kZRuF2dsXIsR0BsotgI3JCPX8EU+askmKLfq
	gr+Z3FWpNB4+SncC6j1+tRiQEzp4aH0Amegy5fOx0agy/Z98ysNj5W3DzOkOkY9x+aTdFEgvgHC
	dyMgHJiHSGpUhCBNzxa4Vn17zTlhEr75Ekp5vLS
X-Google-Smtp-Source: AGHT+IF7OsjpHIrA0sWyLoThXiNmJ0D3bQg/q76DJk6hcIK1mIG2Lhl3VqoT3ICuDXULsvtFZETK2vIrJvm2VubdaL8=
X-Received: by 2002:a05:651c:3254:20b0:360:eb0d:76b3 with SMTP id
 38308e7fff4ca-363ffac16c2mr9112881fa.0.1758287253676; Fri, 19 Sep 2025
 06:07:33 -0700 (PDT)
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
 <CACT4Y+ZtFPSaNyp9m=cU-QZNeRz1GoUHE08TDq+X-8yAz34Rcg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZtFPSaNyp9m=cU-QZNeRz1GoUHE08TDq+X-8yAz34Rcg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 19 Sep 2025 15:07:21 +0200
X-Gm-Features: AS18NWA-VJOPdryWM2j7D1XJDSwp7ia_B-OVN32_daMcjo-MnKVa9PvD-r7mrO8
Message-ID: <CACT4Y+YQdjRyrQ_=sR4chrh1J5yRykXf-ck2ygNB9rzpAiyF4Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: Ingo Molnar <mingo@kernel.org>, x86@kernel.org, mingo@redhat.com, bp@alien8.de
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, dave.hansen@linux.intel.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, peterz@infradead.org, 
	boqun.feng@gmail.com, tglx@linutronix.de, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 17:12, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 21 Jul 2025 at 10:41, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 7/21/25 06:25, Mathieu Desnoyers wrote:
> > > This series looks OK from my perspective. I think the last piece that
> > > was missing was to get a review from Dave Hansen.
> > >
> > > Dave ?
> >
> > It looks fine to me. I think the best thing is if you folks send it in
> > as an rseq fix. I'm OK with the x86 bits. For the series:
> >
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>
> Ingo,
>
> Now both Mathieu and Dave reviewed this series.
>
> Can you please take it to your tree? Or suggest who can take it?
>
> Thanks

Ingo, Borislav (not sure who else maintaining tip tree),

Please merge this change into the tip tree.

