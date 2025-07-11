Return-Path: <linux-kernel+bounces-728205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB1B0249E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D341CA5E82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A41E47A8;
	Fri, 11 Jul 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJiXPFIV"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA554C79
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262250; cv=none; b=b0/cJrlHaPQphQSqJgmVb8RbBnt69bfp6+gtiQJA9bHqfOgGuE4aArJXN5qSBuyO4SOvPLXkwjqA+PUiOdf9UjuPtqeey1Ys/sBM6zE/M96YRN+lgwWqnxA7XfhuAQjElsw2yrQQmfZw4MXJ3TUYj7vHKLdRidkxLwhsdl0OdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262250; c=relaxed/simple;
	bh=fFeiBWFwEu6yivVJrS3VCjAHsiIzHVVSjwe6FIgy23I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4CvNNjt51LoBUKrAb+oV5nQDwr9G6fji0sYED9llVpZ3QGL+ptqzTmUZyNf27dAdVq0iJB9gZLTwpubOIbRw670iKfJG/+C80mM/NXCjJolpfMjEccjrx/qyZj9uD2AXnmpk8i/3RDMeh1UjXsB3jUua3J7V7Q2NhOyBNpCZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJiXPFIV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0dad3a179so403415466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752262246; x=1752867046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W42wqNZ6CmAMcEVUi0DgirOnpBMSt1r3eJzW5nHOkPQ=;
        b=IJiXPFIV4nLUlO0Na3colxhV3qwNgy3S7s1i/NXZe5dDnP7NH6io8lb5hDrWPntILf
         T7s1QvZkzLu/Yly3fmV9BDGyVKmwFmvw71wL+ur2UoSqIE28/m7ngRZr/3T7Y05b+37D
         tKio/rMUQC65mwrcZWK1lVfrqzGus+cuoEzCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262246; x=1752867046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W42wqNZ6CmAMcEVUi0DgirOnpBMSt1r3eJzW5nHOkPQ=;
        b=EF84cQC8vQ7NdQBc2QXWSetvNQQwk44LouawrQY2YdPGyOKHBqYOF3LHcCjkkUZiwD
         aFUnMrLfaPUOgtSUNps1r5oVCj84CAtWjvWxpzJtE+3rs48NILtBuFRpxB2RkCA9XkL4
         F0+cwurzkLoBDqfvXYcOfhvpdI7qyh8PTDf6lI4ucVoH25yaLkt5e8WccSMFCZWBexde
         VvX+hgUV1Bk6gWGYBkNTlAFNPKqnSXBAI9gNLq8YwjmzIHcUI8DQAwYUMNOe4S9QS41r
         Fch4rZTDcs1FxKJBKZusb1TLUTkmph33hn67sEc4F0mIN7kgWik2f44mnpq4OJF+szR6
         wj8w==
X-Forwarded-Encrypted: i=1; AJvYcCW7+qk2A4Lx1fI4Z/4Ys7CNLbM+atBIBqFj1cNxi+naBOYUHYmRu8nrvCHICQ2IVJzgnLXdeU4mI1Q2oYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYQny3B+ONNwYkiNXoah4+Eku6OpNA7poeqDAEy0Nu9Dn6N3A
	Vxs3RTY6PTE3RL1bp0fkOLDe6ve+oQuB7cK43vELGjp3acryIkLAzmU/Mr9Mn5TJb2u9k8PFrnz
	+1iF+/eGCsQ==
X-Gm-Gg: ASbGncu74khmFgjkJiCDm/InkBzIon4HoiDxBlaZM33ZubXlBOHzuOCBmNZ1uGPiBWB
	flWArwTAufXmjK40scRfPpPliS7cXut48Oe4Z8cTa2hHTDTm9GLQRnU0O+yljTyQtG/4xoytsYK
	qTscNsFyIFPagpQUqjAKR+/3nwZG0KBPfQGiiRqKlMC1nC/hjHipmQjh4Wctnc3BBdpTYSecXz3
	qkM9U7u7nrVh5qj3cfbPt+RorEp0dgk+cmEVXDwMtbY112gSwPgrju+ah7YY5YBe/IfFeMOLr3z
	Zl3ABHPN787b8yXSqcSYVrCXmnDTOmnDB3wm4TrN/ajhCutYGzwsNOr4Ovf3fuPZKmU85zYz4F2
	pCVy7MG8FoBn7W5hGSHloaEPNfzens5Mmn16U73ZzBnc8TtmFZTLcqF8PYLNSo6kBzWJYakoOvk
	20Hk7mKO0=
X-Google-Smtp-Source: AGHT+IHk1EZ0u6zQI3bU9KInPmA0LtI5e/jbK4cGq9kTq364JKbZH9tbo2nSbLW2zFRoA9wnebXamg==
X-Received: by 2002:a17:907:3c90:b0:ae0:1fdf:ea65 with SMTP id a640c23a62f3a-ae6fbc8859emr528087466b.17.1752262246400;
        Fri, 11 Jul 2025 12:30:46 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bc2sm346118966b.135.2025.07.11.12.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:30:45 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so4693173a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY6xIH8uJgHSYRQrCB6KPvVvoNVIro4O4c1Fbz5Ojdxa2PudleukzeuWtbCjamx4BRwPEiJmw1qqyY2S0=@vger.kernel.org
X-Received: by 2002:a05:6402:13d5:b0:601:e99c:9b19 with SMTP id
 4fb4d7f45d1cf-611eefbd8ccmr2998361a12.1.1752262244860; Fri, 11 Jul 2025
 12:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 12:30:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
X-Gm-Features: Ac12FXz05ddJJmdKtsU0c732bvFnqaJPd5imXrgLsnwoQ6msxaZ9czwbq-1pfJM
Message-ID: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 12:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I spent several hours yesterday chasing all the wrong things (because
> I thought it was in drm), and often thought "Oh, that fixed it". Only
> to then realize that nope, the problem still happens.
>
> I will test the reverts. Several times.

Well, the first boot with those three commits reverted shows no problem at all.

But as mentioned, I've now had "Oh, that fixed it" about ten times.

So that "Oh, it worked this time" has been tainted by past experience.
Will do several more boots now in the hope that it's gone for good.

            Linus

