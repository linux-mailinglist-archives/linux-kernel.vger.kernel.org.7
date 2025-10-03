Return-Path: <linux-kernel+bounces-841630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DDBB7D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D6B3A6B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CD2DC34F;
	Fri,  3 Oct 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LjXTSBgu"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DD2D77E7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515010; cv=none; b=Qwin8qkeKT78A0shJExFIhU+Ixe5c5b9hW9xEwfe4t9ZdXPx2b9it4Ea0I5smXYQKaYS1L/WMRxpsOlkOtj76xi0jwrx4ya6lYxoSU8zQEY6lqmquttzL7q1nRPT1ASZUVvXs7LBUhZyb4tqHVi8ENLbkphSkItvFMw0UTwXU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515010; c=relaxed/simple;
	bh=vUXrRl9708vjIJ3H98Dzt9wiBfYX8pxbc6MnkBBD5Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTxeMcv30b04m5rkDr8FC1niFHi6nws9hYzUcePwaL+Z/+dUKBO5cXJOO52K5xnjsGzDmObaIaDK13M9Rar+TptFehthXYuKAhd5zrr/bcsRxQV1dPMg0Da6ffP/vmp3iASC55jBCFvDAsClNfjSOYh8T09ZJDRpsGnxMr7dWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LjXTSBgu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b00a9989633so94702466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759515003; x=1760119803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6HcZa5x/ZueKvCVojJriM429YMOmrXwyu7CDTC62Sag=;
        b=LjXTSBguzts+/pmrbIpCHWI5MEkC/9KVCHCFKE8WB8gjR9QjUIir8an/E7Wq0IknxK
         oMvlesveyt3z3BcepPeNkUjKnCTsiUaf3Vb+DEPNykHlbi8qyi6vZDfH60+FwMIbtiLJ
         Dq/tR7e0ki4+z4NAucwExHmnLHphTLF0fbmes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515003; x=1760119803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HcZa5x/ZueKvCVojJriM429YMOmrXwyu7CDTC62Sag=;
        b=WjgmvnUAgx23tnaj0qn3dsnBXJwE0Q0Ibdl1Qe1QeoF9fJZ9gejSQNEOn1U7303zQx
         RTgxdnjVaYDE1C81xrlmMtKhgbcOgIemiv1BIOeiJsXIDD+ZlZmcHAJQr2+tR01VLY79
         u7/Yicuhoc/S5MqebWujDze5lNE51Q7wnVx0u8+ga3efXVkQp/bKC8BQS+ZbMFgZFjcQ
         l63yR7U+z8+c499oM9VcYRehY+P7fGeGNT+IG2NcWZznnEiG2FX/yvNeOlfRFrCCg1aJ
         w/jhmkElr5S7vC1VhgMcvmEwAeHf653Xkh9unoHnol0I9LCENJDwlC4Cb6imOIVUj2Yo
         Vw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+cOawtYwW0ZRqjtvD4qn53q86TN+SU1lS19f8LGJSqkFAja68WbzEzQYHOSaTbvRa6j9gro0k0gC+fVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QYdo8zoeMbbzgIPxIQM4PyncnNoQF3IDAjvkO+KA07BhqB+O
	UKvOr4Tg2MscwpBV+suppYajuVD6kHxK3vAHLkhpXhaTBZUGcxekd/ljug7psZ8i3JFkhjTughE
	8vVFWVws=
X-Gm-Gg: ASbGncuJE5MueDYlqmRlBP0a8XfZRrHalC7cCBtVwte6K2gQ2KsiP12ekV8acrizIEc
	4X94xwRdf+Gmjq2iiNXqoEsxyq4FLb63HWbPXBMI/GOWnwoytrCUt/QayNnIc2ewaMTQ1N2qgPb
	aMpt22Nf28PeEud6mq/GNSZbpfiXc4UJzJ14Hg23rBxhhMztTKKzFW3GMuAj15kuxOUvuzGf1CR
	R7B2jV9L9gOOJGiVRKwqZ4nbbAD/oeEetUpyxVTRFP4yoBQd737H6dzk6Mk90mqUBSf66nSNxua
	teepv8CfQPM6P+Y+i6rm645/DbtvbDkmh8tUG3FV9CtuJeu1bIsnMZsk950jrLLNzGQRJEsKcxQ
	UTYnD34sRr7zwB2Xsy7msi14YMIzsmXwam1YB2uf63N4R48B5CIPiePA4ItYxVzFdVySmQKTNbx
	xoBPgg/VZDNSgPskwvQyZw
X-Google-Smtp-Source: AGHT+IEm070SbqP5ENz/DEAAoqd9rcQihFTyS7MAaosFuc++TjuqyByTYPuU08ra7HlvcBcL2e7aZg==
X-Received: by 2002:a17:907:6eac:b0:b41:1d96:29d7 with SMTP id a640c23a62f3a-b48595942c5mr961031666b.5.1759515002891;
        Fri, 03 Oct 2025 11:10:02 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63781c46688sm4486452a12.22.2025.10.03.11.10.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 11:10:01 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-636535e4b1aso732649a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:10:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtJDPuQZKOwjANsgZWd4ESwadiGAN+p77KfKGe5BFarUM272QLIGiTyXOe3Gx1CM9hQBqE+i7l4X5Pltw=@vger.kernel.org
X-Received: by 2002:a17:907:94ce:b0:b3f:493c:aa with SMTP id
 a640c23a62f3a-b4859595d81mr997367066b.7.1759515001411; Fri, 03 Oct 2025
 11:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com> <CAPM=9txjNo==nMA7XcjzLWLO155+1bk2THwPs_BmTLu_5kU_bQ@mail.gmail.com>
In-Reply-To: <CAPM=9txjNo==nMA7XcjzLWLO155+1bk2THwPs_BmTLu_5kU_bQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 11:09:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgR61VxiHyOKXBJv_HinoFVA2av1EuSHg5NcRGC1fNq3w@mail.gmail.com>
X-Gm-Features: AS18NWB0AZ2Hkgtacs8r8m7VKTE8yKqMQtBylPIC27T3Do3iNp2cujh48qXpsYw
Message-ID: <CAHk-=wgR61VxiHyOKXBJv_HinoFVA2av1EuSHg5NcRGC1fNq3w@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 03:53, Dave Airlie <airlied@gmail.com> wrote:
>
> I get about 15-20 pull requests in various formats from very different
> groups of people, if I just cut-n-paste them all into the changelog it
> would be horribly inconsistent.

Yes.  Exactly.

> I try to harmonize them for myself, so they are somewhat visually
> consistent

Me too. You just don't do a very good job at it, I feel

> i.e. single level of indenting is my limit.

Why?

Yes. You do multiple merges:

  $ git rev-list --count --merges --author=Airlie v6.16..v6.17
  48

and yes, trying to make the merge messages be legible is a fair amount of work.

But lookie here:

  git rev-list --count --merges --author=Torvalds v6.16..v6.17
  441

IOW, I do closer to AN ORDER OF MAGNITUDE more merges than you do.
And I spend the time and try to do it right. I don't have some "one
level of indentation only" rule, I try to make the merge messages
consistent and legible.

And in order to try to lessen the burden of that consistency, I then
ask the people I pull from to try to have better messages to make it
easier for me to do that.

If you get pull requests from the people you pull from that make it
harder for you to do a better job, please push back on them too.

But maybe you now understand why I am asking *you* to try to do a
better job at formatting. Exactly like apparently you should ask the
people you pull from.

Please.

               Linus

