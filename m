Return-Path: <linux-kernel+bounces-793316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF88B3D1CF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA106188AC17
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7DF23D7E4;
	Sun, 31 Aug 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gljRPolR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8222154B;
	Sun, 31 Aug 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634679; cv=none; b=ULEs117CW2wd/QkiOPpNQppnbGnzT+8mK3KLRcSP+4pvUQv+NS3ncBuqk2/4JH8AGk/Dnh45FcofrnEFw0gY+g82YeGR1o5u77evB4i1kCrdwPvIrhurWSpgp+RnEKkuVJgLs6TaRx+XnHAZ4Lag5CPyZwx710MNmQxlruOCHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634679; c=relaxed/simple;
	bh=8MSiAJFhyW6DO7wWxoxRzC8Zw4+nLElUnPgM3hXUqDE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SFNrnGBIU27roeaWvkVjtVY0T29yYjqUvXZztOOXBsXZNXC9tu7YTTIWuWcnuZqroMFTPjNUv3UuEI2cTzM7sAuiuK6T74JGlyCXc6wGuKTnST8Erg/O0tZyQnR8Y4cpHcBQrQ9iI05xcDIk5MCm3x/9dy2g96Gbl5152D+pXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gljRPolR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248a61a27acso24754415ad.1;
        Sun, 31 Aug 2025 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756634678; x=1757239478; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MSiAJFhyW6DO7wWxoxRzC8Zw4+nLElUnPgM3hXUqDE=;
        b=gljRPolRT91AYDzhRYJggh2HCpW1ILGU1JyrvzOlcZJ9zzCTvtv1fCmTq/S4u+qi2b
         XS2tQh1we8vb4Ux2OA6wA1VyXhs/a4roWPcBbn3ovlx+I4bRdEbF73oTNjMQZok877mm
         EWnKoJUxQNvVgN6MphHWHDKwJ6tvlhX2smtfABzrqTLHRpG7OvhyVkcYebSs/0xH11Fs
         h5tf87nbGgnL1PhL9RTUlSRoG0C2YJodMUazcaMKgYKiGjsr7GStHmY9YysaoKcL33ZC
         aRBucWW4DC3NvcuBpVus/Fu/+POacjWCM+DJAITGuAEJ5KcZQWbENdsKhSsoQCKtE8rt
         OsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756634678; x=1757239478;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8MSiAJFhyW6DO7wWxoxRzC8Zw4+nLElUnPgM3hXUqDE=;
        b=lwUEd3Fyjat2UCjRUZwmZWr+Nr2tCAIP4jKdpls7RLWE+8qbqqN3DJsiuDx9fDy5PZ
         xOk4ghLsMYiyGFs4J3MqXi/mDgRfBScJ0ovR5VJlGTfn6HGiIAonggETCh5buMyo5q8W
         h71K6UB5IgUiMdOLZivF6ocXfWQ1FKTwUcHITgaWstX3siwfot6amqyDPm8ku93b56XD
         nYGYbEEKEjK7TCqedM9sTy816dmVrfm9t+PW/ocg+VFdaIYboMcoynl3oBxklQeg6Ew6
         EF+K7Dp4M3TXBK8foDw9FZIKHmExqNQsySnDTC2FgvDQZlDe5MN45jGfRP7DFvggV4sz
         kHYw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZ8zABU9a1wUExXEC43xhFVawiLKnEH9nJazFqbeFcnP47ZcNJk3huTE3mRQ2J7Iy4HJMHIti/ywPYXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRn7nCIr3et006M0VB02pyetsPtEjK/2oWOIHyq2BSIHX36haE
	Ad09BxxFcvET3I3OEOhdLcuejOKKjwp53EgdoHtrmCfNDj14Ku0EchYa9umXezMBaBTaXQ==
X-Gm-Gg: ASbGncsdFFeiik/wGPhCiJLolxmGayxJM/++KZdlezGS3XF7ZrVzN45kwd/PaHOSOVp
	Dhgeq0ghp2o5KwNpg7fN+i2BJ8XIR76gsFzTe1CkwLSJuoPnMz++Febpei/++NCsD5IjnH6LCRU
	kZu6/OYB4LKUK9wBwbFwawNF7OgGMGuNoWkHEQt5KpYSCsgdG1P1/9N9hKQS2l0SNwQxd80gIxI
	vDT+X+/PaadCa+lgOjz5X9y9LTqW5IkR2t9DY3vS7aSVOoVJjBVD0YByhknHouxj1qqsjoqnO/q
	fn8ErmIty8U7POh4Z9klL3GTx1Msz+AuVLS2gNjl5r+0ctXxgsmMtPXPEi9t93+QIE53zUXfj/t
	MdqnVQpeeyGiDT7vMmH8K1+eZXf+VVh6GkB/BnY+U0UY=
X-Google-Smtp-Source: AGHT+IFOoTNyERuZMFffcSv/0n30wrDtZL5qG7wYKN/yq6xQgQOTOKzyMmchWLg6teNeEuvMwjnuCA==
X-Received: by 2002:a17:902:ea0e:b0:249:274f:84a8 with SMTP id d9443c01a7336-2493efe0734mr61057395ad.25.1756634677399;
        Sun, 31 Aug 2025 03:04:37 -0700 (PDT)
Received: from localhost ([221.216.116.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77236d7eb7fsm5439602b3a.54.2025.08.31.03.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 03:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Aug 2025 18:04:32 +0800
Message-Id: <DCGJ0S0C9ZZH.1IFDOEWH6YF2K@gmail.com>
Subject: Re: [PATCH v2] docs: scheduler: completion: Document
 complete_on_current_cpu()
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andrei
 Vagin" <avagin@google.com>
To: "Peter Zijlstra" <peterz@infradead.org>, "Jonathan Corbet"
 <corbet@lwn.net>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com> <87a53h3fzn.fsf@trenco.lwn.net> <20250830190718.GS3289052@noisy.programming.kicks-ass.net>
In-Reply-To: <20250830190718.GS3289052@noisy.programming.kicks-ass.net>

On Sun Aug 31, 2025 at 3:07 AM CST, Peter Zijlstra wrote:
> On Fri, Aug 29, 2025 at 04:44:28PM -0600, Jonathan Corbet wrote:
>> Javier Carrasco <javier.carrasco.cruz@gmail.com> writes:
>>=20
>> > Commit 6f63904c8f3e ("sched: add a few helpers to wake up tasks on the
>> > current cpu") introduced this new function to the completion API that
>> > has not been documented yet.
>>=20
>> For a change like this, it is a really good idea to copy the author of
>> the original patch and others who were involved in it; I have added them
>> now.
>
> This really is a rather specialized thing -- not sure it makes sense to
> have in the document.
>

Hello Peter, thank you for your reply.

I agree that it is a rather specialized function, but in my opinion that
should not be a reason to exclude it from the documentation. Where do
you draw the line then? It is an exposed function from the API that can
be called like any other function from the API if the user requires that.


This one is by the way the only undocumented function from the completion
API.

Best regards,
Javier Carrasco

