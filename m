Return-Path: <linux-kernel+bounces-869354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F391C07A62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC22A4E7A37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2C53396E5;
	Fri, 24 Oct 2025 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np5Kd4wh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B527280E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329348; cv=none; b=f4fI3oOON9LCNx3mwgj8yplKnm69g/cVeR1kZEUs6KKpbqM8ruKFyLylSIgWcPvC5y9xj6QV0706ZcqdJDtmbsXgP1h0eWgPZec6TCr3TWQWb5npBHFMzRqu71Pd1Ga/UXbLdC3bzS9zfijdwxx6vnYDgEAV7iWJ8uKVPnWwVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329348; c=relaxed/simple;
	bh=0r3GG6uH17KZoPbGFRVq5aXoneRvur4IlIF76waTAhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t59aGKN4sztrjMq0kQ3RCNpxBn92wJj2XU3T/n22CFJKTx3h3pdWevOSouGKPkLrbhsVcQFhWrbLAbeNECp7SYjIkBJ+CfJgtAl9jCXQFcMOvurrGMfC0VFE4PwJEbMrptBYsHHuRe12mkVG/mzxeBRbuioGqC7opE6TSUqiEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np5Kd4wh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47106fc51faso28600475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329343; x=1761934143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r3GG6uH17KZoPbGFRVq5aXoneRvur4IlIF76waTAhc=;
        b=Np5Kd4wh2pU+sgez+Iby2qWGkALP5bH7mW91Aft4TpuW6NRJUfUIp6xkmVL4uBorbJ
         MHMnpwSJdaZoLVr+iG2PuHlIm+6SGOC04erTs87Td+8njiqh3XDLwj8lBcJSl9GRSJ0q
         w8CdtrUOcLfAQqjExBd+KxR/AO94wvM/h1KRJ+U6FMxjhjGn0gUewO8LmhHyac29qhbd
         vsFevaQa9aToISr7d8t1bu9GYd2z9Xhy+0BtW7/EIfqBw1Z5eqYwWix31X1VvqHyelwI
         8ZRYa62QSP7C0A1fMwm52MvDdss39kI//QkBqzGuP5yGS1ZEv9v10cWhpUgVdt311PCX
         KXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329343; x=1761934143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r3GG6uH17KZoPbGFRVq5aXoneRvur4IlIF76waTAhc=;
        b=D+tlTJKK+WhWSMmdAQwEOCb/dfZMIAhgA06a4QyP1Ppr4884/cB/fLgna6DOw+qQFa
         I6UoYzxdQ/aY0qbdx8mSnN8AvW4L5ANVcoEqVNMIA/URpsVOy95UUeVBhC2AQEdzVG/T
         SKx4w9MAjyvwkPyPvQp3SeUxu+T+e3bDqHpZTIt1Wq8I2gZ5O/tIK9sZst415U6v+COJ
         x0psuHoq6BF+Pac3y84hCVTYqWUBZMK1vHjhJSvIL9BJigfPR0gjlJbu7iWgklLvf3xn
         F7fW2XWr5L2FiJbcuIsZoB5pVgfTy9KlQnQjKQey5wfv6MeIGiCDpIiLkJEf8ebT7KEw
         0Cbw==
X-Forwarded-Encrypted: i=1; AJvYcCWfkOfGeT6ix+LWgK54veShj9+bW2HYgYLP7WI+qstAuq4vGa6EuS3j8w343+6JRfcJsXTBpmpHe0ww6W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8ZDQVZWhEtLNeqozT58Pd+6le5TiCUL2H7xYZMT8YMuwCSKU
	dPDM8lGm7TPIz8zvA4sfo0ys7xhspWjQQLo93ywVvxRg45gAsrtgwiMJ8PY7r4i5H1KLhs5wMUQ
	uK4SSG3T0g1MMYmn2IMqTuWZagMU0tKE=
X-Gm-Gg: ASbGncsK5cgV2HjfCi31UKc89R4BFZvTLDrZkbM3Ng3j46x2sOx+yE9sDzvuqRq/J20
	dsh6wjSioFeMkf1tQzQZ62iO92n+/Q/W9JuoY6sPGyzZFE4IurpiuLJMvHSDd1HlgXGQGVhwbMj
	VdRWLmIcXqiCE67jki/Wpvjelk9t09O3iOIFrNtadpb6QYE7phkTTf8xZXmsm1ItyCVu83/brk8
	F8dUozCk4BURsbVtubE8tajyeUb7WvxsjisXTy65fIyqxjpvS5Sh3qyS2pZ6W2/+QPwW0wCFXNH
	xA8txmBFZS7ge/mzPw==
X-Google-Smtp-Source: AGHT+IEd2S0CoOnsCEqdQWr53aL//daPs2zGPzlplFARXHXFtEQSkqVuew1/vErGx9hY2N+n/Yhj4MUm3fZG4jwvHts=
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id
 5b1f17b1804b1-47117917572mr276080945e9.32.1761329342449; Fri, 24 Oct 2025
 11:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
 <CAADnVQJS_RUTnpCX5etS_qGD=jgHjtY_Mtc5GQqPwvyyTfghdg@mail.gmail.com>
 <aPrBp_vG_D-8qG_E@hyeyoo> <CAADnVQK+3GLbq4GjOYO0Q6vhURPyNyy70bZKUUwRpLuK-R8NAA@mail.gmail.com>
 <aPrecUasNUbEkLlS@hyeyoo> <cee707e7-b7f7-4c21-8887-2cb69d73df93@suse.cz> <aPtIqm3LaRfCVQ8L@hyeyoo>
In-Reply-To: <aPtIqm3LaRfCVQ8L@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 11:08:51 -0700
X-Gm-Features: AWmQ_blsModMP22bdNbVqa2N139hiiPx7zCrnoVxTggAjMOSrvwRYYINiPlR6I0
Message-ID: <CAADnVQ+H+VLFROjJJYkbaT6ED_ecFzu4eLci1oP9C0kDp7Aa9Q@mail.gmail.com>
Subject: Re: [PATCH v2] slab: fix slab accounting imbalance due to defer_deactivate_slab()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:36=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> >
> > Note that deactivate_slab() contains VM_BUG_ON(!old.frozen);
> > we would have seen this triggered if we were passing unfrozen slabs to
> > (defer_)deactivate_slab(). I assume it's also why the "unlucky, discard=
"
> > code marks it frozen before calling defer_deactivate_slab() (and this p=
atch
> > removes that).

Yes, exactly, since that's what deactivate_slab() wants to see.

> > So I think we're fine?
>
> Yes.

All my concerns were answered. I guess I understand it enough now to:
Acked-by: Alexei Starovoitov <ast@kernel.org>

