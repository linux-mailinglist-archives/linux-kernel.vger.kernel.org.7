Return-Path: <linux-kernel+bounces-843294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E32BBEDAF
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472361899941
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59851DE887;
	Mon,  6 Oct 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwRbNZJh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0E199237
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773280; cv=none; b=BZVLmdtd6+7uqag9+1DCv1QFftfE7XxZI/LE+k2g/GsG/KauXfl3LUTMYtQDh4sSI2N6nC7OfMYmQmDNtyJddMdUgYUQvkkpcWf+4f4f0SUTU6BuBE5xNnsiCQiNbkmF2H+ZsCXYg2lv3ug6p7ZtgLayjS9CffhuVpoAWGUS/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773280; c=relaxed/simple;
	bh=SaOJ+bWZKtnYSvf8DZSFyMYB3L1UYISDcDX/6cb7FRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkcYY7Fh+NSLVP27hR0U/o3LzSIng6jDu7gcdsPUNbo6X82l8QR+Y6W16vdSiuZVPvt3FZNQHi0sOIc0YyyRSxkBzoDaNy0XTQyeoKg9Ju0m/ScW7La0WPgSOMEKdQzlIuNSGzgJsVnRCcNmRElTaUzJQaKg9bIx+J6a2QS0LwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwRbNZJh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso12665752a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759773277; x=1760378077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaOJ+bWZKtnYSvf8DZSFyMYB3L1UYISDcDX/6cb7FRI=;
        b=UwRbNZJh/pf0ial9f2mem0+riQWMM2FytktZwwn7aF8HwSlaSc4xM929GRGxqgHnAm
         6qmgWJKxoZPjiedBTNkh6i4ZCVvfGdfHxkRVgzZvl3Q53kCnNGOBe9bXGzpcgW+knQ9T
         EFchVaHUCjGIdorwSG6fZ2lovSCJQmtrbNcKOcb2jtUrBmMAD/JPtsIB5mXn6esOX2Uw
         gaCIAVOX4ftSslC3g9csgaBiUS3rR2UBvcO64AqIrd8P/Fn9zi88hxikFKlm3wt10m8q
         awGPgS6Lhcp0fiHdjIsA9k5UqTDZ5R0TQ4HjG7JWQ6acBST30gBr3eiKr3n9ypRd1now
         p+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773277; x=1760378077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaOJ+bWZKtnYSvf8DZSFyMYB3L1UYISDcDX/6cb7FRI=;
        b=ZGPmpJBOJJ1Qc//HQNzEYYtUJM/mx5jXgkwQeXK+100AjuPW7FlQv8TnLXXQxfBLza
         ylf6tfr9mR2pGpbAxjmkaNmWHfplYla71VoXSe6LFoxMKmfhf6xVdAsMrjT90xphWhKV
         XLQoM0fNvvjyRZdrNltu3CFrp3Re7HEBctTFi64UlN26gXnsxZys1JUjV91ldU41FiDQ
         Y1OCFuUlIzXGFKdmBm6ORlYs92MzVOI/dEFkgWlzTQ/1oy34UY0/GMCYmGJ/xljXILh8
         BqPcwWoyoCsC4Qcl/4qeyLhU/W7yWWw20D6a35OUry/Ov415zKM2+gdCRltld+KjNPmy
         /sug==
X-Forwarded-Encrypted: i=1; AJvYcCUfTSNT0jiZxu72bgNURkHS4EYPuZygkq0e62oQlG69NhbeX7lh3wJYL6GzhEuj/TMv1rv67e3x0G0HStg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEGgbvFvtI0y3vfDnaa66OhsC5IhTqwXoWvOyRAPIW4HceOFo
	o3eegfxtspLGeHBt9Y7wD/06KEcwLdpqSxIzKGkKT3lpgxWydqbyfM/qexBTvnzzzXLxiJ5edGn
	t/q0UWY1pMhe/OwGEW5oRRJ1Ej/akjEo=
X-Gm-Gg: ASbGncvV6iBvAQrMgaJnuCaB3Tql+kP9IlT6iwMyxUTB+SywhUhT9OyP5zXz3rvwxGq
	nuogy6b4c39IKO+LwwvtzRdwCA6HPhvgViY9BgO0S45qVWj1vPDrKXVx//Hb20yezCfN23NM0+p
	t6dNqq72y7g/8NRsMMIoOJ50dQ8QZ29+ydVsZXk9+J3cHbL/+Cu8yb1G4rlH0pPx7azaDKk3cdX
	a7FCT0UbUwizBUCsVSWGbY9urM4PoQhLLnSj/IB/GAeH0mScbtO94LWVTyk8iPnnmAnaUpsmOo=
X-Google-Smtp-Source: AGHT+IHJ/Vo1fUDIbL1nQls8Cr4SC1cob3Zyk1meplN6YxuRUzmZSznvUBX82xUYSZ0V+jqCXqlYjvtl8U3EdawMybk=
X-Received: by 2002:aa7:d785:0:b0:633:14bb:dcb1 with SMTP id
 4fb4d7f45d1cf-639bb13500dmr436309a12.11.1759773276820; Mon, 06 Oct 2025
 10:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004065618.70151-1-vivekyadav1207731111@gmail.com> <aOOyNpNL3YCrLIgq@hovoldconsulting.com>
In-Reply-To: <aOOyNpNL3YCrLIgq@hovoldconsulting.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Mon, 6 Oct 2025 23:24:24 +0530
X-Gm-Features: AS18NWCJ1A4gEHjkk_EONI5344ds4mNs5A4ME7lLehyqnImXo5EA8_39H-V9_iI
Message-ID: <CABPSWR4W5Eyz8=NPvysT7XhFY=bjCO_WqqOOMWeZGen9e2fhqQ@mail.gmail.com>
Subject: Re: [PATCH] usb: serial: fix: space prohibited before comma separator
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,
Thanks for giving time for the review of my patch.
I understand your point and will avoid such kind of practice.


~~Vivek

On Mon, Oct 6, 2025 at 5:42=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Sat, Oct 04, 2025 at 12:26:18PM +0530, vivekyadav1207731111@gmail.com =
wrote:
> > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> >
> > Run `checkpatch.pl` script on path `drivers/usb/serial/*`.
>
> Yeah, don't do that, that is, don't run checkpatch on code that's
> already in the tree. Use it on your on patches before submitting them to
> catch potential issues, but always use your own judgement when
> considering its output.
>
> If you just want to practise sending patches, changes like these are
> accepted for drivers/staging for that purpose.
>
> Johan

