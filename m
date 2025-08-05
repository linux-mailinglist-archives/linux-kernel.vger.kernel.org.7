Return-Path: <linux-kernel+bounces-756482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262FB1B4E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C195F7A1498
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C7274B40;
	Tue,  5 Aug 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qbq7YXCG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEC2749F8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400560; cv=none; b=E5i3IbJLo+SuQLCzSDtU2hThNP4hEHOIG9LP3n2WbSa+vpPLZzj4008T83J1sQbP/S30nvKx8Ub2rte83nqhl56BUQoMvCSkKh4eVloPfIxUfOCKzF7RyTTfV+2Q2ygYoxQbcj0qXdjQf/A4AK90DZINZdvY8sljX+LToKoj+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400560; c=relaxed/simple;
	bh=gJ9cXvAsqM/enVc1aXO5W+6MUHAIrb338LYuERqrbWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itSg+mxVEiB1SxvUrMNsQtFOjXqem/TKpHhBmhGgVgSMiH06bG02BBAVJLxq9EeZVlGJW0zOCdEuqbN/OcHxwt07PwpoGN8aINliUkFNjBTr3qSnTaJ63zUVUDXhwl7x0D14qt5tv0r8+74ABwJykFohj+wPx2B0ElUsOfM+olU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qbq7YXCG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so11983205a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754400557; x=1755005357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ipjdbz9dkXcEYaCNiHZ/32p0xoqI5N0UZ1qphfpkvU=;
        b=Qbq7YXCGVchgnMmupWWUr0BuXdDPtdRvEOyfcXKLbowi5vq/i6nw0B/DXt3uxxJW4g
         Zp3PICqDyF3mMsEE0F1ShifuLtEgadzv0dZlnatick70eLbipC1wR9GdE+gcVpssZ9kY
         m6bbtqdvQnXcfbA49p9U6WwLCU/d8ga7sXkH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754400557; x=1755005357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ipjdbz9dkXcEYaCNiHZ/32p0xoqI5N0UZ1qphfpkvU=;
        b=YUScgF99aCZtOyZOIQxMUvOWwh4v7gzEvBx04E3q2QJG5GsB+zUNb8Hzq0SlaDTm8N
         /tkzRC9MhNBfN4m5TL5EDRqFS4JBFtwt1ddpjBcDkwklrfHfDQ0Zf/UdRtcP1oZd5InQ
         CPkDl6IWEdd9GsAI6/vIHk7OkUFQqT6UrtdIYdY8+KMsOUPLiGbmo6LnOoPnZbrKhdxy
         GCep6A6qNahjjmflVMIpmn9wRyeAJmGpty3xG/37wuqjk+naD/OHZAZbqW214O4y6+T7
         8MoMKTh/t10N0pNOxpdznaWiFqW+NAqFbCWn+BWN7cf+PLuusjVpVdszoUwkD4i3WkXQ
         1yyA==
X-Forwarded-Encrypted: i=1; AJvYcCWq20cbM7th+A8XSy7/3bNkvFzJr4fGO+zTizwdiFt13ahNQemKOHpj/RE1rmPiKpHR/dNMlkvZ0Fh4lGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKPzM0OdPNSDk7f1+Rz2uFKGcmflZepUVAyotaRi3o2W3OB2y
	uzxEN3Ty7uBTgW86LaZ52iXYjTrYVyDo+uZSfUJHB11z8GgQfipJI7337OxNSWrSx93LkRMwmWB
	uRuirAcld7Q==
X-Gm-Gg: ASbGncunRDpawRAOqPLVlPiTKCmpoUgphCPixjbq1fJWHBIb+PwYMSGrMI7Gqp994cR
	gvtGSB51vNhvIGwYIXetSeb4zOva3A4fOthMMphnZBmPDmUJjNway5+f3GjHw6s52bypyqQGT6E
	mZrkbiL2qC7zZAtQXQ6Sk6Nrkp47IAimPh5xa5B9ZR+uB8j1CtAOg0Lbp5NSIG2mC4+n7zAtpcA
	Vrm3XfWEOCzJHeYOpUG/zi6HgB23qp67Ky+nDdtkz7XETIFpxH6oKicYtXZkKxX20SQl3esnPKu
	5IGyo13jHheEigwnNzUMuKU+qMsFtmlXy7hku8NzQKUr4oR07mSpNZj2WEAfXcUDvYrpoOgKrOB
	hI29LQqYSQnW2f9Rnev6CD7IFyTfBNqoVIbXubHPHLaMzSOIESjG/79721smm7OCX9A5U2iP8
X-Google-Smtp-Source: AGHT+IHU+fAMdmS1y9ywZG3O1eWfK/nNfl0KRq0CabZESxtgp1Ym5Qfoqy0rgDkeptXTltGe4jDPYA==
X-Received: by 2002:a17:907:7f2a:b0:ae3:bd96:78cd with SMTP id a640c23a62f3a-af93ffa03c2mr1487726166b.7.1754400556725;
        Tue, 05 Aug 2025 06:29:16 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e833dsm896304866b.64.2025.08.05.06.29.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:29:15 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so8028978a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3p4+3l48HStgOFvbq51jEhh7Z8ZU7ji9a5BQXd815ksamzMocv+xxR7avE393nuZId+sY/BRnlaJLIP4=@vger.kernel.org
X-Received: by 2002:a05:6402:40d4:b0:615:aa8e:a19c with SMTP id
 4fb4d7f45d1cf-615e7172bffmr11870059a12.32.1754400555257; Tue, 05 Aug 2025
 06:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com> <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com> <7f891077-39a2-4c0a-87ec-8ef1a244f7ad@redhat.com>
In-Reply-To: <7f891077-39a2-4c0a-87ec-8ef1a244f7ad@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 16:28:58 +0300
X-Gmail-Original-Message-ID: <CAHk-=wgX3VMxQM7ohrPX5sHnxM2S9R1_C5PWNBAHYCb0H0CW8w@mail.gmail.com>
X-Gm-Features: Ac12FXy4pouEpOs-tuosaE-SL0UAQrdOn097LdBH-sum6lMT-SjAL3WAjOmxvbk
Message-ID: <CAHk-=wgX3VMxQM7ohrPX5sHnxM2S9R1_C5PWNBAHYCb0H0CW8w@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: David Hildenbrand <david@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 16:20, David Hildenbrand <david@redhat.com> wrote:
>
> I think that would work, and we could limit the section check to the
> problematic case only (sparsemem without VMEMMAP).

We really don't need to, because unlike the nth_page() thing, the
compiler can see the logic and see "it's always zero".

And in the complex case (ie actual sparsemem without VMEMMAP), the
page_section() test is at least trivial, unlike the whole "turn it
into a pfn and back".

Because that "turn it into a pfn and back" is actually a really quite
complicated operation (and the compiler won't be able to optimize that
one much, so I'm pretty sure it generates horrific code).

I wish we didn't have nth_page() at all. I really don't think it's a
valid operation. It's been around forever, but I think it was broken
as introduced, exactly because I don't think you can validly even have
allocations that cross section boundaries.

So the only possible reason for nth_page() is that you tried to
combine two such allocations into one, and you simply shouldn't do
that in the first place. The VM layer can't free them as one
allocation anyway, so the only possible use-case is for some broken
"let's optimize this IO into one bigger chunk".

So people should actively get rid of that, not add to the brokenness.

           Linus

