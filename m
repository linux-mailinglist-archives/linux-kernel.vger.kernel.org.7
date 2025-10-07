Return-Path: <linux-kernel+bounces-844687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA8BC280B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C970C19A2EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C740231842;
	Tue,  7 Oct 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcBXaI58"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6E2236F2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865102; cv=none; b=uSZOyQ8cSDNaPToNIzs/24z4IxMeQ0rNO03kDtMrET8l1gnpzuWDGZbN5tZ+cMfI+yrjg/HNJl4JtjraFrtJFOw6LJ6Eda2zdQGQ/J47cdxtVKcv5CJIIv/e4NK5u5KW62hYjXua64lIA5J52j5c01eDsJFLO3aBeT74tOnEUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865102; c=relaxed/simple;
	bh=liSEly5qVQa8OlgORhHC4vbdfnKfkA3258Y55R80fYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyavpvwFfiBERZLBQTwk05k4PEhk66F3mM1Bhs/nWziQo9g75J7Z10Ylemn5TrIQkaE4f16SVzHvXurPcIYdq056ZFwYGWZwPhojOiX97ak/um3SE2AMRW3YvLMCZNrijrCku5J9givPt2+Qr82b1zqc6Bj9/s9IZ42K7J50sNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcBXaI58; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5538e4343fso105976a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759865099; x=1760469899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+iej964gqYmw3EStGTseOsB/VJ0n3f1dmiT9VwkheM=;
        b=mcBXaI58uL2/XTfvqOWeWULDQaOY0b044WDX/04EG4F/alVW2uzMpaVoF/loUzLGAZ
         HGC2bqlns9G2SQRaxLHKHtxOfGrLV/tv2Dwaq765TLAUmqrWO9VWaDjwbaFN9k65kqgt
         Msx6C8GHhwFmQ+sLbh/rstwdSfnDAUZXQSFe5IiRFeRhKUpD+NnqTMespVe37yiSgul2
         iSN2kolKmfDuMu3MnYkMCe8B0Y9ixTqtNUFV0DFYe5gdH2z45tyhJgJ0UhpDBEDyvtsc
         AESOGiYaB8rmPa0XiGGiNDoxsTdsRdPxT4Kz7ui/X24/g7IP5+xHC9kFhI+3dOB0GwW8
         ZEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865099; x=1760469899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+iej964gqYmw3EStGTseOsB/VJ0n3f1dmiT9VwkheM=;
        b=rmS+hYdo+cTTEw2Phc5l1bEyxmL8iJeJObz6YV/ISzD7ud9RYBvS/seHb2+BWQImoH
         x7spiF3ZYlSRlYUwjgGDj1CHBsw+ZYSprRVXqksSRPfP9zfTSYCcJnNPEJiMOlizMp5a
         ZYNGQdi9VBgRRHJD+EfG8NRax3oF07r5lvvDHO66SRaAWR7qCVOqGg2l0UNQ+BwxLBL1
         2j1EqUS5vFOEMe13sHDo4M64avnO6qhaPxjq6eIZxGnHWcBsK43rTu2s8zWgIPnk+wIF
         HgQl4cNuGXRMaHPsEz86ItpoM3IYngkfSQzi3o29b7jxpMbA98Mh4WOeT97MAao4PXG4
         YhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1VTB6BrPeuvT8L/G3IymPtuNbIyw15qNtL34MQCOuJY3FGVz+qkqUW/9WI3NJYXLKnMVhtV+x6YBTBKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxueDP6myD5bUMmF9HGzB1XToC8kS8YPo4ZIvyee9cVnvFhD60N
	qE+CMRQLjiSl62oPHRjgwySzp92VwPwPFL3I02ovmTSgm1e8Wp9CENounBbqGKQMFFxIWP0kQP7
	O9a0pGabXBvXBRqh+INVGxaTy/u8PPTQ=
X-Gm-Gg: ASbGnct4qgmtLa4AtpG6tdJj3lvDA521FStzFZeNFafY3HzUW3pUoYxnTD+ZZkGVed8
	FuWIKzLROtChYJfvPIKcMxHZxT12wSKzDU1Uvhs4TGBIFLJgRavDbUKSXrDgRP4XsBSQEUeQVUJ
	GpCZ6lkRnBuc2J7n9kd+LzT8Q8AvKJFUvakGanjy8GX2+I7Ce4lCBvmV9x1KddcIi1cJn+btg09
	v5t/1GgXRBoMcwlMEJvOF0b/JY+h8GUQN7nothqrnsozRkVKXaQPx2nN6iLHevyY6JLJ7oX6JRD
	vYquO/QzggIfxTBaRIJfao3XMLDwKOiWiM7VAoeQ3UfMamPMsw==
X-Google-Smtp-Source: AGHT+IHRFimerlEMqF3boAdKkBiNG8MkW5f1eh9EAmm670Jbl+52qtss8zZiJX+57J7MzfxLc/d3NZ0jQ1LQJ9RjfUM=
X-Received: by 2002:a17:902:ea07:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-2902743e550mr5868445ad.6.1759865099543; Tue, 07 Oct 2025
 12:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
 <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com> <3771775.lGaqSPkdTl@hyperion>
 <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com>
 <CANiq72kDB1cX1XXX7sc3yQvnaUUYB8q1wVKNxykv8=OV-=rWuQ@mail.gmail.com> <CAHk-=whe8NLsT-TnBxzzW8sCL_X3BN7zv5ELVufy6=sZ_k=uGw@mail.gmail.com>
In-Reply-To: <CAHk-=whe8NLsT-TnBxzzW8sCL_X3BN7zv5ELVufy6=sZ_k=uGw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 21:24:47 +0200
X-Gm-Features: AS18NWCFJirSOJNc7E5--qS2zoXHw3wCzCsVJLxEt1b3tIkqnjp9hJnURlrXm5E
Message-ID: <CANiq72nwosJkFp8PyqY=XLt6ZMS2rnsTHaN-arzQUemR5cuqRg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>, John Hubbard <jhubbard@nvidia.com>, 
	Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:35=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Although that example actually made me go "WTF?" regardless of the
> changes involved.
>
> I clearly do not understand the sorting rules either. Why are the
> "device::" entries not sorted?

Essentially, `self` (a special case) is placed first, then it puts
things like modules (i.e. `lower_case`), then things like types (i.e.
`CamelCase`), and then things like constants (i.e. `UPPERCASE`):

    use crate::{
        self, myitem1,
        myitem1::{myitem2, MyItem2, MYITEM2},
        myitem3, MyItem1,
        MyItem1::{myitem2, MyItem2, MYITEM2},
        MyItem3, MYITEM1,
        MYITEM1::{myitem2, MyItem2, MYITEM2},
        MYITEM3,
    };

This got substantially changed for the next edition (2024), though --
they decided to just do version sorting (I added a 256 to show that
too):

    use crate::{
        self, MYITEM1,
        MYITEM1::{MYITEM2, MyItem2, myitem2},
        MYITEM3, MyItem1,
        MyItem1::{MYITEM2, MyItem2, myitem2},
        MyItem3, myitem1,
        myitem1::{MYITEM2, MyItem2, myitem2},
        myitem3, myitem256,
    };

https://github.com/rust-lang/rust/issues/123800

You can play with the new one in Compiler Explorer (right-click ->
Format Document).

Cheers,
Miguel

