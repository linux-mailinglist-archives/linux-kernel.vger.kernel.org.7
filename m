Return-Path: <linux-kernel+bounces-815633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD06B56935
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CEF17526B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998B230BDF;
	Sun, 14 Sep 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyH+xuXt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113819DFA2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855900; cv=none; b=JMdgOPbgPSbiC5lzqSw5NDdXl2BcIwzfsslKQwJUVbuuYTg62AWteU+ejw4lJJjTn4CfNLeKBgvv+8pjCzAdXWlgvdIkqvFMLI4Jt8N59NM11z+cb1RQofaF4FECqQzoAHZm1wkOFvI40VTeoZ9oLd5iepJwXQp4ijEWtaOCJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855900; c=relaxed/simple;
	bh=B/MHHbQKWKXKGrb3TcbxJQuhg0Fns/e+Mfok4N2hvrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVMeg60RZaqhQCgRKzzADl9KuhXoivU19mpYdAI7HTzNrVbwyU+VUxlmqPz0TgOVb4xoy3qnrgJNiW+1mcvs5nMSxDPPBoVKvKwrZkoqpbdTzFhtMJdPcjuoRMa5TcG3CGBZkmM5CPh7Bu9tFpSqjZ6QMxADnD6S9B2Tbzf8DLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyH+xuXt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b046f6fb230so652997566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855895; x=1758460695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/MHHbQKWKXKGrb3TcbxJQuhg0Fns/e+Mfok4N2hvrA=;
        b=JyH+xuXtTzIw7P+pS/Wj9Z2HZzQ/wAauQs3hAFXYFxztmonsk0xxPMsbgnbDR61btb
         C9lhSgCe5snE/1Mdspi4PS/byFu1+9Ck0w2iT/GXHWUBiEjZhQgJvJhGuRHIDCGs0HYr
         fZ3PRKHVYti5DuKueBhv/7JgOXOss9cfZeRGEj8p/GeUCHdED+9/eyW3K3IdfKZVxGcN
         VU7/jAOkW+tej+g3jsqCBnaX9NVj9f79xee/BBwdt/S1TmtXUNG91k7h0BkAq+uOOOjG
         fGwnfIyaei06IU9Te18bJ7s3cpififLo6e29SDAmmH2SLIZSlOezouf80aRr1R8DuvoA
         5ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855895; x=1758460695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/MHHbQKWKXKGrb3TcbxJQuhg0Fns/e+Mfok4N2hvrA=;
        b=TPTD4/OR1qrDfuOuiNyTR2jxQoZC0iwJNEKZjFBh4PVQtQCzHhmArYPBu3TvhWIWqY
         1vRMl5VYsM+aTP27MKxLSeGuEOBsKIsAae07oELdTvmu7mIpLQvbgfEpFGzD/DlvwSAK
         HphPZ45zNXR99hBa5ffKtXqpm9g32ZaWlIMux2Y6ztPtrJ5jlQAifB/OYbOjvq6BnS7+
         F76XiWvdKrdUNGrgXAvt5X3RHVd6F0kEesgcWbkqI+tW+LFsfWEbofhsdpx2Z84JxKXX
         vYKSWO9qC6FydOFgg2qZoKiAm4hr3Vwx0os4GS2iJyd2ZwCYoeOhP5YJQ49VSQefw8MV
         wIbQ==
X-Gm-Message-State: AOJu0YyXKBEw9kFdow1iNYusm8MKMteTBPHjIaHZSxZ8vB9Vh6Dwj9Tp
	wuv7klQjo88WHf9AD4DgKH/lGptizVJD4GPkuu3LKMVX9QIIRC/vs4fEXIpxZqAeM3dhxV4vrL7
	tf/ec0CfppBm+GIwgwc7QbQmMV0tzZDI=
X-Gm-Gg: ASbGncvB0lPcTQLOBtubIbn+CZFyMg3Nu1ppZwQYpqqv92XS1/yIE+dHG2WI0JbvRfm
	o/i3EPPqzGUDBugM8yM3V4GmBRKv4Im/cLfMT3I5mYwrsw3YNrO6lInrn72cgi8jIS60vm94wch
	dPeJ5G/bKuFzOhD8r7OK89KyZFGTF0iCWPsqiDyKw/y0b99Dc4l0k1QQJMuzhSLLQgo5STWrd4e
	09TSac=
X-Google-Smtp-Source: AGHT+IFZJzjR3DE/qZmIuieb9Ec2cOdXAcGWHjEKWhar85GsXLWRAMdg0zButMdqYr0pWrjx0yF+GOztpSlmKRG4U7E=
X-Received: by 2002:a17:907:3fa7:b0:b07:880b:79d3 with SMTP id
 a640c23a62f3a-b07c2081bbbmr1208647866b.0.1757855895286; Sun, 14 Sep 2025
 06:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913210600.36986-1-shaythomaspower@gmail.com>
In-Reply-To: <20250913210600.36986-1-shaythomaspower@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 16:17:39 +0300
X-Gm-Features: Ac12FXxewCGgT69GHbv8Fx-4TnstLxtxDMBfEueTNpM_75YpkFCPUKNUam-IbP8
Message-ID: <CAHp75VcnUXcOWTBxZpTa6ihS0fef6rD8ySK_DHEjNribLjGU0Q@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft/fbtft-bus: remove empty macro argument
To: Shay Power <shaythomaspower@gmail.com>
Cc: linux-kernel@vger.kernel.org, andy@kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 12:06=E2=80=AFAM Shay Power <shaythomaspower@gmail.=
com> wrote:
>
> Removed the trailing empty argument in define_fbtft_write_reg calls to
> fix SPACING ERROR reported by checkpatch.pl.

Please, always compile your code. These are macros, you should
understand what you are doing...

--=20
With Best Regards,
Andy Shevchenko

