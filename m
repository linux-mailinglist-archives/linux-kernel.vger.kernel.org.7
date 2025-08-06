Return-Path: <linux-kernel+bounces-757237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE25B1BF99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FBA180A39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924691DE4E1;
	Wed,  6 Aug 2025 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZKTvGpwl"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01B1DA3D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754454926; cv=none; b=soJRJdvRlFyk+LFr0kBQh1U7R4osNJb/pqFxxdkJhfErgI/tHqePrgWCABdZHZMInzt930JsJvdXm9xnZ9NEZvb7YxhGn9gZRBN2j78UYw54XhQ8WjhZRG2Se7rGMJqvhjdXxSL+VnGnfOqDrSHewnxt8fbEePmO/JFTKgMr/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754454926; c=relaxed/simple;
	bh=ixqP5isrz46vellfu1bMac3bIcLlc426urXjlfHqYPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXKzVjsdxdxoWODLHKuMcZGNtD0DGz40R+tN70sbSEZcQR2oeD19HjiYdHa7rOICUqmWAfu5aGtTyYfayq1iJ0IGOHpJRr/1b2L9M9PEXwfuZFnc1JiwqA/NAn6cfmBiDa0Zj6f1zBUmNXB7G96DR75WcUsnZgNpxRyPT5lbmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZKTvGpwl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so9155605a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754454922; x=1755059722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMFp9nPrvETLnaWO/a/yk4nWBSLPEvGgBPivTJ6uYRs=;
        b=ZKTvGpwl9889Vb3PsKwwhHyLlvmUFSRuSWLTuB9Bd8wTRDYfMTzTc41GTRTbdZn27f
         wxtiDBlvPQTovXk1+ASWQbJ0YNpdDlv1RM6vE1GriP80nHXgBc3BwOtSD3z+DXKI7cN2
         kn+1VXjQl44cjNh6+2FGtvRRUDhbYpyPoLSCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754454922; x=1755059722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMFp9nPrvETLnaWO/a/yk4nWBSLPEvGgBPivTJ6uYRs=;
        b=UnT4/yMZrchfqGojg760mSzhvPb1UKTLJ5HfdUOYukDCBpD0Fs4DubavcnC2pyAuan
         D3icmp3Af7hKn8UToB8yuOBC2M02NZPofs4B6V4zZDUSoDKP984fom4KkU/d1bBE1Ec2
         bJ4+dsTwFokpiKlJR+SIrnd7+AuhMd4jB3e05i1a8ucoi69kX/RQfW+vLw1okBAMSGsR
         /k7HSM3n755L7EyK1xEygqFrw5VnaBSSQA7fO21XldifXiFM3zXgjpk4CCrLSQGWblQ8
         Y87heWM7fUfqnNhGeIc4rvbHKZCphWF6vut5xurO9FzfAkSod5qwGXVElypEUAiWNutp
         b/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbOgokHit5bfG/ETI+TQEQoOX+cZWtKQCoTrQUv8falxw7xSgDc+8tFNdLMfYdNrLB+jIIHLFs0aYoSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXIHKSbn36LjXAoMIkfg9DCM0XYrXTCyCo3UojioI/M/ygETI
	YtUEtfVk03T9quTR+g9RMWa35Uy4hV7iWQvwsQYmc6SV++kAPwZ6+Yh5MNUo4gNh/TsqsygNYeu
	Zlu3yPRGY2w==
X-Gm-Gg: ASbGnctgwBr5S7Spb3qGbACthqjuVn+DIGB2zE9CHFfOBJej9BeeiPpXyTdbqRlBXIL
	snR+HM2B9ZhmSuz7uAOGoVnvucgqZjURk74n1dBKvcEDNK8ZcIID9TYe8xZwAlmv1zonpJwBIHJ
	P+KBW+sqrZ3DXx9SGVlPkGhNa/73eVqPv+FYKOKLU7ZIFcmVh7aaY85PwZCMCeAcdP6q/+3iWdo
	KGQHiI5rR1MDMm2vPi02TRsHESYSS9r0V6gdj+43sRLLsdVD3RnP5pxMskVqYY3PGP0rZMLPv29
	EqUZdfOfw5r+9de+60d537+QlqBXrInBeNfn88LFvAbmy+j0pjcuTQMnV9YZvwQKIqASNbhDNQx
	J0EYZQZYMKoOeTpOG9kRIOCE1UYjkl+yqESvTEqMcSJ/7dch18C4huLLJw/IbuVrwDq2R8GVs
X-Google-Smtp-Source: AGHT+IFerckNllUh4rJFgKS/NxEbKMaMJ4C2zeVHO9HF34CxH3AfGVpKeRcjtcBuW7c5HDQLt8iwFg==
X-Received: by 2002:a05:6402:50cc:b0:615:756b:1b1d with SMTP id 4fb4d7f45d1cf-61796199378mr1241717a12.30.1754454921672;
        Tue, 05 Aug 2025 21:35:21 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm9297698a12.60.2025.08.05.21.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 21:35:21 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so9155572a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 21:35:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1NdATecyyBtMVVeEcurv/rHFpqUtZnN/WRNLoN9ACeXekTdqLpGidxgvboXhSKV2eVy79ykK8PCLALcE=@vger.kernel.org
X-Received: by 2002:a05:6402:278a:b0:5f6:fab2:9128 with SMTP id
 4fb4d7f45d1cf-617961597femr1157467a12.19.1754454920609; Tue, 05 Aug 2025
 21:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAQdcpEARErjAdJLGf3whwWy-1z8kGtmEDKq3M6qqJQx6w@mail.gmail.com>
In-Reply-To: <CAK7LNAQdcpEARErjAdJLGf3whwWy-1z8kGtmEDKq3M6qqJQx6w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 07:35:04 +0300
X-Gmail-Original-Message-ID: <CAHk-=wj1QTaR=U3_9Ypmqqu70zEiXJfE5tM--GeuqRvrYYCekQ@mail.gmail.com>
X-Gm-Features: Ac12FXwAOo4J2HJ06qEZuSrOy62yxW5XLcYCmM6rix-YQrS9oUFc8DROthH9OV8
Message-ID: <CAHk-=wj1QTaR=U3_9Ypmqqu70zEiXJfE5tM--GeuqRvrYYCekQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.17-rc1 (take 2)
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 06:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Please pull Kbuild updates for v6.17-rc1.
> In this take 2, I dropped one patch series
> that has caused a regression in linux-next.

Thanks, pulled.

> And, this is the last pull request from me.
> I'm grateful to have been able to continue as a maintainer for eight years.
> From the next cycle, Nathan and Nicolas will maintain Kbuild.

.. and thanks for the eight years,

               Linus

