Return-Path: <linux-kernel+bounces-834386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223ABA4978
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E20F3AD80B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4682472B6;
	Fri, 26 Sep 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay+BidnN"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52139242D65
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903549; cv=none; b=dwuK6crNR+flDHoBap3oNGV7XerWVSnIIfuVOpLqj7tb1qgemfCmCmmLsEDyBKdhrAxRfjKvhtFtTK3l0V6j85S+cbdVCZQH9Iv+S4iCc6/EFgomABQ5q1epe+6zelchhO9CZRBjqqmFoVwGMrUvrf03t7hJVoXa8bDb41eVf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903549; c=relaxed/simple;
	bh=kyP0o37MX2lUHBzC997IW8hkhObR2L3+qn3wFYoszlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjINBMgip2sYWS1lEp+LD5sbCZFqlWARELmXT353m/DsF3wZsZHToIZvOwRSTWiVQHtOurxX/6iVVIforE9nsd5A+vVm6zCv63+MIacZ+QptWRK/JkOzTHzcOP1sIUgAzFhGKaPgk6aQegGs3wudyRrxrwdf6QR7sRZWWLl22yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay+BidnN; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b5241e51764so2079330a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903548; x=1759508348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1W4qixDMwh1UINVBHbI1zU46f9ziZLnkZGt4es5DdI=;
        b=Ay+BidnNS7OWw1Axn1gS7ZyW25wkfPc4CPyqiPuJqqGs5UZjSpRfXUcI82W0fNd78R
         OZiqkLUSe1dDO4/Nl3elKZhiPzvVwk3lywXMEPaTZz0qk5Q2/ylB8fq7CkmdheL/YBE+
         Rq1mwY8u5Af7wcrwM5AS4ilZyIqI8wP2W/0hHSGCGgOi9iXkF7ueIBtT/eMRDncSLEkJ
         RpUAgPRJl3J8r4cbbVC9k8wlHGmpxkQVgWYD28XgXGeUwbR8SPbDerSdb/6YFXzQok/k
         F8ZA0VWxMR8MgBURsMnzrb2a+lb485f0TLbyNRJZtG1mBDZ3Q0KDJDUt0A8Zs6T87Q0H
         bbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903548; x=1759508348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1W4qixDMwh1UINVBHbI1zU46f9ziZLnkZGt4es5DdI=;
        b=VGHsvWmEqDjl0JKCTnViByC9nN6qrgOEJ3GFL7ykaXKfW0GewdsI10Py7QYPuHCIwQ
         3cTNWYzkDfCDZny/UCibpOCaQLNlFMiPisaMtsRk/0m/Gzy3XWJP7Rvpps3FR0U83OKR
         kV5/i/HGcblxYWMO9GdpOW05xUBTSs/2KSnYMdYO35iGz4bq9LLVfrOR7G88ji+RlshR
         LP1MlJ39UviG2+1thT5IQg5qYfx+Jza3nR9aE0h85y9Qov+VUG9sfuT9SpuXJtg5xiRy
         cU5agu3RUXiKRkK4WwsMhX5W+DpDKoRCB8QbWRL8X22sjN08vmguT+TrVPZhWM7PS59K
         HgMg==
X-Gm-Message-State: AOJu0YzuVFQ0R2D9nP6EArsSNQtR3cFAsRitNfHpu6+jI0v3qRuyMral
	uAzRMbqstB4JRgIW8/7KwP/z2tqA0WXlSH7cqqkeih+sx4vmYj7d3C3q5fS7gNV0aJv0Bgp90xu
	P/APRx9QmfmubXlhthiZ50gwua0T9098=
X-Gm-Gg: ASbGncuy3lFggo2CyncFeMv/uK6XScWlyqAAPpHTOzmdV6QsFTLYP7C963tWvhoi3FC
	/LY2hhaRQK0XW8ttcSEmxtDemxmK6m5cAZ+jVyx4f5qasbCf2DAdeJq6ZF+1MoHBjQXQzS0Sj7J
	pQvhzRy3RRUOsdVBLOyHsk5f4sNnKcA6bCR27116qBmcgELv1clVuUm1rQLG4fxPJPHWK8BzKjq
	hE0IIY=
X-Google-Smtp-Source: AGHT+IE3VCpZaamNq/ddeBCSpBzW+N+Aa9xRpmDejic3U82kHi9pSkULBEsKk6fGVE1RWfoTM1NkRg/9xsbSXxbmD9w=
X-Received: by 2002:a17:903:ac5:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-27ed4a4959bmr82499145ad.46.1758903547539; Fri, 26 Sep 2025
 09:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926092832.1457477-1-jianyungao89@gmail.com> <20250926110047.GB3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250926110047.GB3245006@noisy.programming.kicks-ass.net>
From: =?UTF-8?B?6auY5bu65LqR?= <jianyungao89@gmail.com>
Date: Sat, 27 Sep 2025 00:18:55 +0800
X-Gm-Features: AS18NWDnDlmT00QTwGQ02_21yOFw9kNRMNpkdrYWYLQRXzqTYgMlFfc8EP9ik74
Message-ID: <CAHP3+4Cr4pODFG_p9FywvgTQPT6v4jhbsdxzuV=q_YTWF9m4fw@mail.gmail.com>
Subject: Re: [PATCH] sched: Fix some spelling mistakes in the scheduler module
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 7:00=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Sep 26, 2025 at 05:28:32PM +0800, jianyun.gao wrote:
> > The following are some spelling mistakes existing in the scheduler
> > module. Just fix it!
> >
>
> >   borken -> broken
>
> That is not a typo.

OK. I will drop it in the PATCH v2.

>  Also, in general I;m not really a fan of spelling
> patches.
>

Me too. But this was my first Linux kernel patch. It was also the
beginning of my contributions to the kernel. :)

Best regards !

