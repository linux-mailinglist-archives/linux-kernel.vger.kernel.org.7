Return-Path: <linux-kernel+bounces-772569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B3B29446
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B827A9539
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641E29E0FD;
	Sun, 17 Aug 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AL/7LO/j"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7027E0E4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449447; cv=none; b=fqckttOBBXXw6PD8kgJ9ztFhoaIyiG9GSTbqxVM1GqFyI/PvF4JD/twFyOEa9AuCcMX2ZcOG+N3U86zhUu1q9ZDh8QznlinorEfkQUyWjsivYMeQ+TZvxnlGRAU4geWdf9DBS5Y0GdVddONtRKkWuGmR0/yhFoGWzUI7JQSvSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449447; c=relaxed/simple;
	bh=X6spNPqrh4bgXvrO1J4kDpbBugOahcsnBb60o9fYuck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVH+Jim+Oa4lL7k9KWRF56IuR1rAb/tXUJFFljoVSiVTTvLh36sTtfrbeYJ08K0negbBBVLqI9+WST4cP17vW6jRS1PAHnxsSO7vW5/oG3s/PcBaRb0sK6x6Bw7masyIEHmjlGnCOsM+fW0Gv5wMLJkDZZmOUOX6YSwCepvUQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AL/7LO/j; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb61f6044so581260266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755449443; x=1756054243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bifBG0HdmWlpPr/1SzHtWkElsh3tLh55jQ42e+XiVuU=;
        b=AL/7LO/jKY5k8p5Qrl5JKqc2P7M9IV0z4th3CaRFEsjDYpgVSWuy636X0uip+RcDxe
         zdFZzfRTkZvjo23IML0VXnbSCXQyGegLbJiK4LcR1/NR02GQfl9dklZTi7WP4Vi7Vy0B
         l6tDZX1LVGH3Whyrujg2j0gqaTMxaIiFa3mO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755449443; x=1756054243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bifBG0HdmWlpPr/1SzHtWkElsh3tLh55jQ42e+XiVuU=;
        b=veW6/nMz6UVppnC3IAJdKS1enbnB2INZ5V5oxh39KDIhxLeVmHfIo2SJYJNJhKNlmI
         W8yFk+h2uCUiYx0CJUL+OcpWq19ZJ19ngOHInx2S3CoO5V5hBNB4tYutBo+OmhWeFu1k
         GswWNCOTqfFCuUxZnhPDPzumuTXAIgtC9sgsPR0G3qGlrcZHS4rELG2TILWcGH1TccMA
         sxDpgJA2JOvQilhuv0ZOQ6nyDkdIOqS+RtU6rimJ9ug2zm8bvSJ7wA1nfGfsOY3wJSjn
         yUGGe06iDF4V6bJlnJ+qatlRcaGGPao4Ktn27TkB9+cRJ9vk2WKJ331UWy1M6TdCVQA1
         GwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaWa58P98bvQYSiu7DUicDpljbu+Gz+j5VTUTETUdS469CBwWxwkbocvZ8CCcFJRtcbOpqMFpaMt+FJQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNEwXAB2PdP6PdL1U8hShPzHdldfvFl8T3tcfroovpLtiDk1B
	lJAayg3OwTekXbdZPxk+V0+PCmt16aFM5IsoCRCC5Je4rjD1C5PXGzz5BPBZUyaNtp8d7tBzYwt
	J+nlJenc=
X-Gm-Gg: ASbGnctHyYgHvLuJdP6JbaTAwqL3YmT8T0hUEIczDRVIL/0kqAhoYqFduupPTL0/Zlj
	qrMZcrOqE4V8cRsGAi75zcqnhGld3pvvD36CKS/iO/3T5xVKM3hQ88vYxreGVBiH89B9DMO+tC+
	RePqKmEYROvUU3OkPCrYje8hZr8gkQSkguqw0mII2FYdlaiMhi7j3KIBztIgHXwuW/NA6QgVWAA
	/Mp3guukWVbCayVCZGpQ7f+PhfBbkZyPPKbuBNKFon+Xn4qghAJt3sftEYCymrlHRKUDtbnUlAW
	IHUfMBeJrH6/FUKQZVfIGstPw/P8rv0tFPiGW86ETV81rIOh017ZePiwV3ilXSFER4a32v32kkr
	IhBjWcNdlH6bKC9uteGJiLrTTRBOVV50TuLwuwlNUKTsPuqYzMRcn0pjhOIYEpT4oQ8OiOVTgTJ
	KfO1YoSvY=
X-Google-Smtp-Source: AGHT+IHwcHOWtsKYVhuomap6mocJxNWBghdo4OpxdA7MkswL1QUI7RGiywtzBaBBi+0ekRbdavUKZw==
X-Received: by 2002:a17:907:97cd:b0:afc:d246:8425 with SMTP id a640c23a62f3a-afcdb273073mr912972166b.19.1755449443208;
        Sun, 17 Aug 2025 09:50:43 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccbebsm620286166b.59.2025.08.17.09.50.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:50:41 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so6837551a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 09:50:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEF3rbCXCcAyQ6buGsziGjLTitozCaAg1lAF53XXMuiyIvyAp8ejtPtqHz4BRyNSVRd974090mRi7F9yQ=@vger.kernel.org
X-Received: by 2002:a05:6402:5041:b0:61a:13d5:6caf with SMTP id
 4fb4d7f45d1cf-61a13d571b6mr5201931a12.2.1755449441317; Sun, 17 Aug 2025
 09:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817163609.GV222315@ZenIV>
In-Reply-To: <20250817163609.GV222315@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 09:50:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
X-Gm-Features: Ac12FXywdGIbBfQPe7J0Tp5bA1tValys2xnri0ed59elJ02zPNHmqJn6IQW9tyk
Message-ID: <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
Subject: Re: [PATCH] spin_lock_irqsave() in autofs_write() is bogus
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 09:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         That function should never be (and never is) called with irqs
> disabled - we have an explicit mutex_lock() in there, if nothing else.
> Which makes spin_lock_irqsave() use in there pointless - we do need to
> disable irqs for ->siglock, but that should be spin_lock_irq().

I think we basically did the irqsave/restore version as the default
when not wanting to think about the context.

Your patch looks fine, but I doubt it's measurable outside of "it
makes the code a few bytes smaller".

So ACK on it, but I'm not convinced it's worth spending time actively
_looking_ for these kinds of things.

            Linus

