Return-Path: <linux-kernel+bounces-797398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DEB40FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A060B5E3C22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8BD2773EA;
	Tue,  2 Sep 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YZXeCm/7"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C12550BA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851680; cv=none; b=gclzZmsFkYThvvR3g+LndFGwG1HBwWNKPfTQAgV/F3hWMHJQocOXm91XryOgZb25YH4RMXlMfoOC7ompDu5pzvk39OnrSuFq4V4J9SvfeiDL2xi5yZY7jbbnliBaSLY4kLF1MVxSNAYMYxFFO4iFurQI8nO09qvkpRsATSpJXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851680; c=relaxed/simple;
	bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scbQzWKQPdp7FfXsMNw3B6xhfagQPxcI/vM+8Ijdd2Mz3NlUk8vpIyd8bWSN8wfYoEMa6VSZ79muSyiDqBhmMSf16URZH06ggf2WF8ZzQCWYObukscLlCqFFdCMjmOkBPUqo9RK9cD5Nh435e0pMa6UcjTDrF4AYQ2V7L4zY31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YZXeCm/7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6f434c96so3714786e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756851677; x=1757456477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
        b=YZXeCm/7GBFRBljfCnajK0LOK+eFyDX8BLB+D9ZwyBVU55xyJcMli4pnmsUrRsloty
         +ZZGtCu3Y6cU/UpJOWsMDRssPDdMbAEQrnGixIZG6ApzEZfIhJVMJMv47pyAM6luug30
         QmpihjkjU80vv3XeIYuGlLUITmjutbOw34LBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851677; x=1757456477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhrGdUwtX0TRrHmzp18ffizdjSUfmH13xn/mmFzf3K0=;
        b=nSUK317Vfpzg/1rPM0VEuU8IrcpJC4iuWKw6ajGqTnDbLzk9hnLs7omLLp94JUfJnk
         Dyd8Fioq1VAuvMm+dbkksyCKce0aEjLrykkYuvsrDghbwpx9GkydV3//g5hpSteMsSkD
         9z1RVy90yCYuf4Se3RxZ6kbMaSciLOJiKPTNPE40xR4O6dXJQDhDfOZoov9pF7KHAj/y
         idp/qM1Pe5ol6qLIWkuRdve05OAfNsFVhdDCliFgqW1G93OjakfRFFKHjbX9mxHrefDF
         yDx11noTMyv7OyZ7iNXO3cOZm9MUEtSCaenvmeMG1m3pUcF8MIGwbGFgacYky0zDRq1Y
         ncVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTlRsOTvge1QcVJG3xasQmKLcS0Na8oI+JAMtTJ3RTYMgUbfW1DIH157oueyE86IN8EpcdTB2dNqNmZuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPrcxt3H6uVSe4ISZ1Xx7ITEelruE/Ko4RwcSSjsenHQViEmy
	7gzXYOrkxrJDMb/D+cW6dK0mOcnXqen+eIYc12Q4J3/YJTXVey0+iy9dYz3hc2Wqd3n9nTyryZX
	YmZVlB7nu9rnTbQqn2SuYjsuPg6HMdP6qzEC6+yv4+A==
X-Gm-Gg: ASbGnctRWPG6GwsEYQmbk4qeVgrBifhyL7NCQDvM48UoqiqaNaFY7jimsLgHycimKN6
	zjkaR0AC4tu7tdLWPjAKahewVmXtsqHbp7XdyI8nwLAYdF4pfNAwXCDMD5fpAqmoNX5A7Gc4DBH
	P0yqqWMGffcHwClAcRA4XdyQKbf/KvTNfOlAznD/F2g68ikqDNBEVdjt9VrRUsSrgPq9ZVYDW1/
	HJQHN+lSitNMwVc9M95mHu8CoKUjJK/+cGetIR4aZqCTyNm5FC2peA=
X-Google-Smtp-Source: AGHT+IFBza3hqagc0puDleD+Unkl9olkJ3klet94+JtsC9LdhtggFejId/AtdG7cn9nz3QYINpZRSm2wOlqELxCKl/Q=
X-Received: by 2002:a05:6512:1389:b0:55f:6fcc:6f4e with SMTP id
 2adb3069b0e04-55f7089c3a6mr4162223e87.7.1756851677166; Tue, 02 Sep 2025
 15:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
 <20250902072600.2a9be439@kernel.org> <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
 <20250902082759.1e7813b8@kernel.org> <aLc2hyFAH9kxlNEg@arm.com>
 <d4205818-e283-4862-946d-4e51bf180158@kernel.org> <aLdfOrQ4O4rnD5M9@arm.com> <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
In-Reply-To: <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 15:21:06 -0700
X-Gm-Features: Ac12FXxOi9AsViKZtjtWxiVRlAl5eHnNmsfESqGUjGTMg6KF47joBlOhH8IUoMY
Message-ID: <CADg4-L-5f3a=3XCv5UaZG+47DHaO3NTk5+4mp-nWJ2rFXx-5WQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:38=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> 2 Sept 2025 23:18:56 Catalin Marinas <catalin.marinas@arm.com>:
>
> > On Tue, Sep 02, 2025 at 08:50:19PM +0200, Matthieu Baerts wrote:
> >> Hi Catalin,
> >>
> >> 2 Sept 2025 20:25:19 Catalin Marinas <catalin.marinas@arm.com>:
> >>
> >>> On Tue, Sep 02, 2025 at 08:27:59AM -0700, Jakub Kicinski wrote:
> >>>> On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
> >>>>> It is unclear why a second scan is needed and only the second one c=
aught
> >>>>> something. Was it the same with the strange issues you mentioned in
> >>>>> driver tests? Do you think I should re-add the second scan + cat?
> >>>>
> >>>> Not sure, cc: Catalin, from experience it seems like second scan oft=
en
> >>>> surfaces issues the first scan missed.
> >>>
> >>> It's some of the kmemleak heuristics to reduce false positives. It do=
es
> >>> a checksum of the object during scanning and only reports a leak if t=
he
> >>> checksum is the same in two consecutive scans.
> >>
> >> Thank you for the explanation!
> >>
> >> Does that mean a scan should be triggered at the end of the tests,
> >> then wait 5 second for the grace period, then trigger another scan
> >> and check the results?
> >>
> >> Or wait 5 seconds, then trigger two consecutive scans?
> >
> > The 5 seconds is the minimum age of an object before it gets reported a=
s
> > a leak. It's not related to the scanning process. So you could do two
> > scans in succession and wait 5 seconds before checking for leaks.
> >
> > However, I'd go with the first option - do a scan, wait 5 seconds and d=
o
> > another. That's mostly because at the end of the scan kmemleak prints i=
f
> > it found new unreferenced objects. It might not print the message if a
> > leaked object is younger than 5 seconds. In practice, though, the scan
> > may take longer, depending on how loaded your system is.
> >
> > The second option works as well but waiting between them has a better
> > chance of removing false positives if, say, some objects are moved
> > between lists and two consecutive scans do not detect the list_head
> > change (and update the object's checksum).
>
> Thank you for this very nice reply, that's very clear!
>
> I will then adapt our CI having CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
> to do a manual scan at the very end, wait 5 seconds and do another.

FWIW - I am able to pretty reliably reproduce the kmemleak. However, I
also tried adding an inline kmemleak scan to the test harness (did it
once with, once without a sleep). When I do that the kmemleak
disappears :-)

(not saying that adding the scan isn't useful, just pointing out that
this particular leak seems to be related to how quickly we iterate
over the testcases)


Christoph

