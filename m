Return-Path: <linux-kernel+bounces-733435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F0B074A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1397B7E29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD562F365E;
	Wed, 16 Jul 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nkz+J3Of"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC112F1FF2;
	Wed, 16 Jul 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665067; cv=none; b=PlTbWCTAfFjBDeY3yFWNABQYk16HqKrXYUbHgqoGarN8aRL+qUoMyr8MfL2Fgbu8BYjnm4hHiWSdf0jQyh/mg+yC3xHb53JJWKStFsfY2QN+n438Lo9VE8afcwRIWt781okRoTpa+HzLezbdJ8f2k01luGsISsCaR2XKoFfTZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665067; c=relaxed/simple;
	bh=f4AIqi/Fw9DY2N7mZbmHndvTW9t43xWntHr65s/N59w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8F3r6CjrZAx4/NthmjCsQzeUEdroiH55/deevEDEFRzDworuT0qZA4AiZHKXB4lnTNk4HBwizaO1RsUtsaxt2Fdt/iHyRe8Eke3ktx4JX44T91In5q7F/GLsMhLBzXTrZUH9G27f8DIhCTSNSMbkSEodvW8zf2jQJEGH580FR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Nkz+J3Of; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167b30so58372585ad.1;
        Wed, 16 Jul 2025 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752665065; x=1753269865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dotDuLYLN/iXt+U/0felTJMwvc4r74ynMy/X01T15SI=;
        b=Nkz+J3OfcOCeWr2hwNdfHF4nAP2c5lZOdyW5KoUfgVdFTv4N8ALtqriJDB8x/iWJ27
         0pt2nn6DtO8sysW5aXcJywgCYK6VgIU/vxGw/onsb8wggYbK/iWD3K97E8dD+cqk4sTR
         OW+M6XB6NoT6MdZWvRvohru3aNxgkzcAy+IyeQgOIhYGySRBQYJHuVJkORg2iV7zLwNC
         gMto69tPCHcZVRFEzo9qUQpDnPhJMEyqb49Q8w5wOc0wnjQ+U+ZVc8Wz1Yr6AxkMFzns
         mxyvMe2kCiiKkV4unmOdyvSdB4Cg5egzgTHm8jY0No9IOteNJTXd0RoKa5k7iHliLy/x
         qgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752665065; x=1753269865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dotDuLYLN/iXt+U/0felTJMwvc4r74ynMy/X01T15SI=;
        b=cOP2e/OHGlZgRwPkLles9QY02/TLvAfV7JDBXcO0vyhD7K1TsFXod5qyBMApyf6drJ
         f+aBdMu2rvIb7PufumY5MmbpHkhRbMe/rBGUd2jQcRc7YAr6h2Oa81kZIzAOLd+ex85D
         zAXnDvkdYdLRDJ+6IO9HMesNaMEUXvnY1Gu5f2ozHFDvfesNKyAlcJdjbNtRLyxmpsyF
         2zguxqm6xzXskQJHWA7I3Fxzbfmn2ldUEAiavxr+D8WFjdAWjp2yDLmEn2Yiogx8QmJX
         zaiw8+FChqeTCuMlbKSlG599LtT5HuGAfjXORITNOcRyCaiLyCA5OqCKlejfq64HOJTO
         D2UA==
X-Forwarded-Encrypted: i=1; AJvYcCVCcF4UIxkucUxnCDSuyP5a7Ncj/6vg2bzOnXdzGcuygjAI5gCfh4cwzk1X+CGA8lr/vUoBnLlg+EeF@vger.kernel.org, AJvYcCWexTBjF4XnfERssrM+u6ymY2qZCNRVa/Z/HOVCsYzKvThuQ0sGk/Wyo5UqQDgDSQ5CVbCjWrtnxhXHNDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhjiRYpNk1oHWQAFWKBy6SRMZDWK4Vfs9EudfQgy7j3dlCgWe
	dxjxnbsyWMpEFyfYOIQ7v8M1fUU90g3jI24gkCsDky+plFdzdiuoRYRjLVtHPsV64eT14+HJlkY
	I23EbwWrNrMuKL99zzDFiq5272KCwH94=
X-Gm-Gg: ASbGncvaMM48AsBR0Wsrb2CWTGKmlsz2xh0dR6xicIaadaFFcNVZtNXoNSHjxSngSUf
	53ax0EQ+F7qwd48D5bT8o3/txEELSgOtMs9hQpLOaJxvKhkTwVq52zYjjuq2zpI8VfBsKmnW8i6
	z4tGbFPDuPcPeJhJqiHNTQ6a7x38256alFdHEO0jR2ojwkRcmPwneOVAON/lmHfLuqzuCd81X33
	1Sy6TWg+3zdX3b7vzDy8q+RJ+1ZwI6RMLsAgSez
X-Google-Smtp-Source: AGHT+IFnVNzGcIE0bNOY91eQmo8Ch4/qdMkQf/sYVo0NGryBs/0yxEncXjaWCxRIEZpcy+IAEitVlIpwJyjafSJ1RSA=
X-Received: by 2002:a17:903:1b25:b0:234:a139:120d with SMTP id
 d9443c01a7336-23e25685241mr29266375ad.7.1752665065587; Wed, 16 Jul 2025
 04:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com> <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <2025071631-thesaurus-blissful-58f3@gregkh> <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>
 <2025071613-ethics-component-e56d@gregkh> <CAFBinCA8cMP3o483c40RjHkMAEt4RCmL6uCTTk5DPmrNVN6_NQ@mail.gmail.com>
 <2025071639-annotate-huddle-0e11@gregkh>
In-Reply-To: <2025071639-annotate-huddle-0e11@gregkh>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 16 Jul 2025 13:24:14 +0200
X-Gm-Features: Ac12FXwmH9CLx-aQN6hja2jmj2fX6eE0YjQjoBg8-DbyCeVF_pa0Ya9zUbGjW4g
Message-ID: <CAFBinCCxdZfEngHuPJPM162bQRc-SZu91kFHEik50Yrk3DYcVQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"

[...]
> > >From what I've seen during my tests:
> > - we fire the URB with TX data
> > - the device receives it and puts the data into a per-port TX buffer
> > - it indicates that it's done processing the URB
> > - the TX buffer is then written out (the host can move on do something else)
> > - the device signals to the host (via the STATUS endpoint) that it has
> > written out all data from the TX buffer
> >
> > With that timeout logic my understanding is that they're trying to
> > catch cases where the last step (STATUS signal) did not work (for
> > whatever reason) so that the host can continue sending more data.
>
> Why can't the host just keep sending data?  Only "stall" if you don't
> have an active urb to send?  Or just keep creating new urbs for every
> send transaction and then destroying them when finished?  That way the
> data gets queued up in the kernel (have a max able to be allocated so
> you don't create a DoS accidentally), and you should be ok.  I think
> some of the other drivers do this, or used to in the past.
The usb-serial framework queues up data in a kfifo (with max size = PAGE_SIZE).
After step 3 (CH348 indicates to the host that it has ingested the
URB) we can continue sending data for another port - that's what I'm
working on for v9.

> > > > If you have any suggestions: please tell me - I'm happy to try them out!
> > >
> > > Try keeping it simple first, the vendor driver looks like it was written
> > > by someone who was paid per line of code :)
> > The original approach when upstreaming the ch348 driver was just to
> > submit TX URBs (without any custom code, just letting usb-serial core
> > handle it).
>
> Ah, and what happened with that version?  Did it not work?
TX data was truncated/corrupted. There's a recent-ish commit in the
vendor driver [0] which suggests that parallel (they're calling it
"independent upload on multiple serial ports") is possible starting
with chip revision 0x8a but I cannot test this (since my test board
has a CH348Q revision 0x86).


Best regards,
Martin


[0] https://github.com/WCHSoftGroup/ch9344ser_linux/commit/875d57b8c6a7dd3f4359eb9adfe3779e2bbb0ac1

