Return-Path: <linux-kernel+bounces-803698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A079B463DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA45C40AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003528725B;
	Fri,  5 Sep 2025 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLirrO8k"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE228689A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101456; cv=none; b=j4LRLBMQgBkERFltGV/cJKHme3ui0ToJw2WVdj0MzvaH+0537RCHZgaHLWfTbhNaTLy3BlyrhXDVeiVfg/KnwFi8WcWgactLDzOwI5qN5HXz6nAQfKtV3vlfiioZ3+I+SSjk1oYZyO0hazAg4/wWYu+TenBcRUMBS2o9bm4CGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101456; c=relaxed/simple;
	bh=5kSIyEkKJPNtcS4C9SW12B6CjFCMmyXxFbHsBSrhHlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV+t+9PsD+b5jnFSHK1FpS6GmbpY2DFNkuwGgsrxUBpgM9J+VV5ZSKllmDs7Tx+Js3cQL2OJgZyRHRJkSiOXFx+3k0tkToobc0gS7cXWXnJ/Av9dGKVkPJAkvrSUat06F6Tq904PjTSC2ms+iwNP55A3mnB4Wp+MIEDC1hwp/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLirrO8k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd16c484dso14399525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757101453; x=1757706253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kSIyEkKJPNtcS4C9SW12B6CjFCMmyXxFbHsBSrhHlc=;
        b=RLirrO8kUXEHAMr6lLkv9LZQkPjYycgTfXVU34+M+YF290imjjVAfBkfhcwEGkjqd3
         1oIFpXmjWBEu+OhJtAat5JuSPpfNn3APqNtorWRukQbW+9bSv2VGrN1X6QIvi1dklNdl
         EdnBHIweAibSXn3ZrU/oQe+435JJ62xbFX8rf8pQAW1pww0h5i3BhBy30jfUztWubhr6
         nyFoCvDL3Tvcc0je5Uh11XI9FCcYuuY6zzRBhiVioBnRPI/tOECyXW6qc2iCFK/TSIqh
         uZGQIoUGBYVl3yQzCPRFh1dQrUT3i84ZbLpw8flcatrVm5E0gwnLnlVkBsIKc6aZDTGr
         nozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101453; x=1757706253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kSIyEkKJPNtcS4C9SW12B6CjFCMmyXxFbHsBSrhHlc=;
        b=VJlxA9BUBNqYq8w3cr6BdeIbDPZtZZEEp7uXgLSrt7j+tcW6yRV6L7EMlQ0DbM0d2O
         Hz4288a6tKleOD2a3kqXytjQXO4aeZnV43ho6emVU5sh41NBbtJGv8Lfj6M1btSS+0b+
         wLjqFdb70oWZPkgtjHnOZsC3iO6m1495m9tjR93wcf+s85QlSYTe6HXPSaPlnycqYwBm
         JQwbuVSRmRzDO/6SHNpngfFTad0UysRkmxKIIfliGMD3z/x8UTQI5VZAXTHBrW20zXA4
         KUkgLdfIku4JK9Y+SuPpOR45PU/qOFN3Cyqb5sB62NEa5OMiKZ0Q0uOnZSC1yg819nTz
         imEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTf+NUtlL9N2ubMeiFGt4WJMceAhnva5GvJKaoD9j4t1+QjQWi8v//rUhWZFgtyS6pQwF2XWt0Od17INU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PorXqbi8k+2pzNunKgDQ/uVfKN0FeZqtQhOSyvzBYNx62vnW
	Ojyd0KRDqcR6xskAZqMiLQkvMUz1XQNcUGokGn2E/UuxMIk3nUJ+jSECo8LPWezCowOQYt7HIRw
	5rihBIL7lPUIwnc6503q8S1x07Y8o5u4=
X-Gm-Gg: ASbGnctDhgocLp3mQOvD039/PjiyPdcFgaGGEuxJ6eJalx9d3vhY0q+KVBhULMBStY6
	Pss8Of57UGWYVYouzEFEJy+8uP9soxLPAcB2cWdxW7A+cNad8HCvJxpwaQ/aoGo7xnJAyK5vwQf
	QAM9oPYCRuxKhiHciFmSToNKeld1SIPsOCrphKEOGICrehgtwq5yHoCKjLNbYFkHDXeJPbyt7Vw
	RpTpdSeSwWOvspS4A==
X-Google-Smtp-Source: AGHT+IEIWTbj6iXai5EB56BajMtkwmQ0wX6zSMX9cOQAlzshrXJq4aBijoRGaRfyrquo9vOREnmChUojy9i9giTVk9g=
X-Received: by 2002:adf:b188:0:b0:3cd:44a8:ffcf with SMTP id
 ffacd0b85a97d-3d1dd81e4b7mr13383104f8f.12.1757101453197; Fri, 05 Sep 2025
 12:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
 <c0bd173c-c84f-41d5-8532-2afb8eca9313@csgroup.eu>
In-Reply-To: <c0bd173c-c84f-41d5-8532-2afb8eca9313@csgroup.eu>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 21:44:00 +0200
X-Gm-Features: Ac12FXw8jIlx5I_GnULq-nTw7_htdTiBmfe6-tGy9IZcoS0RzVO8mAQjd7gKDAU
Message-ID: <CA+fCnZd9unSjY-UnEwc4rGkSRgZX3nrs=WgBb2eDQNEpZX10cA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Baoquan He <bhe@redhat.com>, snovitoll@gmail.com, 
	glider@google.com, dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:13=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> > Hm, I thought it worked like that, but then what threw me off just now
> > was seeing that zero_pte_populate()->pte_wrprotect() (on arm64) resets
> > the PTE_WRITE bit and sets the PTE_RDONLY bit. So I thought the
> > kasan_early_shadow_page is marked as read-only and then the
> > instrumentation is disabled for all early code that might write into
> > the page before the proper shadow is set up. Or am I reading this
> > bit-setting code wrong?
>
> But that zero_pte_populate() is called by kasan_init() when everything
> is ready.
>
> kasan_init()->kasan_init_shadow()->kasan_populate_early_shadow()->zero_p4=
d_populate()->zero_pud_populate()->zero_pmd_populate()->zero_pte_populate()
>
> Here we are talking about the shadow set at startup kasan_early_init(),
> aren't we ?

Ah, you're right, thanks!

I was confused by the name of kasan_populate_early_shadow(). I think
we should rename it to kasan_populate_shadow_read_only() or something
like that and also update the comment. As this function is not
intended for populating early shadow (that is done via
kasan_early_init() in the arch code instead), we're populating normal
shadow for pages that can be accessed but whose shadow won't be
written to. Perhaps it makes sense to come up with a better name for
the kasan_early_shadow_page variable too to point out its dual
purpose.

