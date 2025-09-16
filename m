Return-Path: <linux-kernel+bounces-817927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E1B588D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA73A75D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F0E571;
	Tue, 16 Sep 2025 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuPIgXvV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59AA926
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981109; cv=none; b=m3KvlSwke5b0nKdrJpqDcJ4/J5j5zn/ZAWrTX8P8Nn9FCw9UhwyjYhn1UVKJzBysaRc9h06AVjiyF7jOWXpTw6UhLugv+ZL2LLJ9ef8h1jblqrzMafiPYk2Uj/F7F7J5Ppidj8pyV30G1FC25z7OIeUv6TFd0tMV1gOHmoeusX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981109; c=relaxed/simple;
	bh=8+KD7NMyyKZmUdc9ijSlgPtApsqokZkOOSakm/49bf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH/eUM05wYvPC9AXA3aNATuLXugsJ6u5bo+zm+f9HJO6c+fPXczYiNNwcj1px6cZzZrIib97d0qjZ2VtY2GS/qHVlW0+ujRpX273XXxgcV25VkEfAdQAbMrE+H2WVUA+Nnis7iuCuClNtL+8aZjRgKmiFp0b6j36jQw+brYqNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuPIgXvV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-264e0729c4aso3658245ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757981107; x=1758585907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+KD7NMyyKZmUdc9ijSlgPtApsqokZkOOSakm/49bf4=;
        b=BuPIgXvVLe9wvPLXBrWOgg7TEnc0nUpYKxmqibVyUR/BACgPyqWi69rz2qsoquPbAj
         rTEjNto5+fpq/DSoicp3HfiroudSidbMI/Fnl8lB4WNUuGtj0KIFFdAvERwPkGh/k1+t
         Qry+cZepHp47FUnWhN1mlMPLoN66glH32iTG/t4CU+9xBfE4jBi10932anqrW2T9G2NL
         PhmUD7UUu1okuIzKQQTzfkUsqtMQfpTdPT209eOAAkrqJWhx3WbHiJF4jBpzWir746bS
         IvAq5k3OYZtNpmDAvnOyXqW4mlCawGlDesCYsFRPYcqPEOZlgn17t7GXlqoezk4kOn2C
         RQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757981107; x=1758585907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+KD7NMyyKZmUdc9ijSlgPtApsqokZkOOSakm/49bf4=;
        b=g3Ys8RO0W6kF98zFeFa9yGVJVRXPnaeyhmc539FkyUbraWgRik2unEK3rRtwGT/SRl
         j5FZPCPO1CO4FEwNAC1hc0c+2x1hBwVPfsvHzX8CTcvY9o9PsBZ7XE1dwNxLg78mkru8
         HTSMh3YhccAM6wOOgZi4KmGcaF+BfNIKZODxApDdEkL5QIX+HaTQNXCMxr4GfLqApCDe
         YhluqrwAjEAYAKsVCj+HCX511Lof9wO3G8pLwSRpYoBjlcF72yNE9VULoqoNrzJPBLdA
         ITu0oCokizABcSk0sMKXU3imNiTrrpsKrFTouj6l4BHsTuzIZR8UbDoSQjp8+nOVvy0H
         MbZg==
X-Forwarded-Encrypted: i=1; AJvYcCWQW4x8WzlKcA9VdP1bml/rOqH+Qds6FH4ylhnU7hYyuwdB3v3ZsTjdUkgNeVVnci71HpDn2XsIP5z2tIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFMpXEfXMrtB4WRgqC50GMfu9VcfLQA97TUHSGVpo9C/g52OI
	lf179kp+xuQ4eXvtafeWtmCvtiN4mtvqGv25ur1MDNVFvA3+cOaz9ioehGeIihlaHnS/YaKGVzJ
	OSx+dyHGZI8htVzTO+lDxeWi7a/nprkY=
X-Gm-Gg: ASbGncvz8RCCUFdY12qKtfQAJyaRXT3vKO0rKUlHQCm94k5xP1iiF6UkQm4eoQ+EAzY
	9EDFCFD+y/5dNt0Wn3e55yKar0jEtmCOAn+9ZGZY9p4mrRCygJ/wyc+aq46mwxwftoMTjDy4/w1
	aGiWD4Sz3roL3fhCHorP9qE2ggeuAlUzfQejF59Cb2b/PGZpdtIoXf3c9heyTr9EzioPCL9Hj+L
	S6mk4Uab8m19jM7nujc+og1fWl1b0GdT0WC3YqjmjINDQ3VdWgnza5Wv3FahHhGkMf5ziyDHGki
	k1ybmGYTZCYRh6dA2Rm53nIMShgfCd8OzyXR
X-Google-Smtp-Source: AGHT+IEINeiItjkyrQ8EZg2byQGb8zEsKoTssAR7nMkdgp16h7prJ4CT4z3/pRYUORq1x2zCi/9P0hjJwiePlKwNzWU=
X-Received: by 2002:a17:902:c406:b0:24c:b36d:637 with SMTP id
 d9443c01a7336-25d246da083mr105124925ad.1.1757981107273; Mon, 15 Sep 2025
 17:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMiZpcBu2LDzwCje@sirena.org.uk> <aMikrcaVbSYdkdmW@tardis-2.local>
In-Reply-To: <aMikrcaVbSYdkdmW@tardis-2.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 02:04:53 +0200
X-Gm-Features: AS18NWAbBrjqoU-TnPCKTrXC4mUz_DxmPRzAa5eZ5sT6APLDzi4TIOCXScmMnIE
Message-ID: <CANiq72k2N+7NG0NnDMjxLy6_zdOhQf0xBZq543fj9vONKoweDg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bitmap tree with the tip tree
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Burak Emir <bqe@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, mingo@kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:43=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> [Cc Ingo, Thomas and Miguel for their awareness]
>
> Thank you for reporting and your resolution looks good to me.

Thanks Boqun, looks good to me too.

Cheers,
Miguel

