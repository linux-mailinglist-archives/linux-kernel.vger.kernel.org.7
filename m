Return-Path: <linux-kernel+bounces-805369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10AB487B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1E4E0237
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FF2EF675;
	Mon,  8 Sep 2025 09:01:58 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2B29AB1A;
	Mon,  8 Sep 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322118; cv=none; b=og1WhnikEmo9rbYIGv26T43b20as6ecg+nFkVhj77DX8xeJ/TE5Yhs2PTPuPymHLZtKNmFwl3DWbsSed/eo+Qkvg2hRroOVt1vIF3AFLA3swn+EtQS4FRiHO6u6aitfZA6VnedfWvjGXpFhWABp6OgNRh3iC8zdoc3jF7M/moL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322118; c=relaxed/simple;
	bh=q0BXJbWUGkpqpO4MDox2UFnW0f0cR4V3hBxgPDn8tuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0NwWZrVvf1d0Yrn2ZPj1BisSDmB3rT+Q6Hvt215g5ufzwaFihRuOIRNrMkMelmo0QUvXvkXy+O2OJameQp4GwqnH8ISjlyMgOLOq02C9QZStrf1Pqt2Fygiy5VNokMcF8/0gVB/LmNYPQ7MPAFgcWkLNgayo/cg696WWHmietk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89a079e01f2so1153416241.3;
        Mon, 08 Sep 2025 02:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322115; x=1757926915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFwI6TqYVmu1hmFIIK6VMUwLQfySXRrPHHAhZT/pLGA=;
        b=UKlIho1Sk3QgGAWeFn0h7h9PtgLg0bwxfugIVDVX+4UrfG9tYXlLe7tRS62n7/Q9oq
         uoVVlbP27BtzBvjTo1LxNyKD7DtdAGFjGhuZbeewzUvWcKEpk6dXze8uMJ0hiRUw0YRy
         5H+nQY6cE0PK4Y7ipjPEo07d5TCJTvTslYUAlqUWlNhjXmrE/giS3QLhFyIngza9Dfq5
         pSjDjcU9VQBHwsyGtVQ9IoBHvpYE8Sta8w3RbgoPslHHQtEtBC2zSC4JGyMXJ6bg7zZy
         n6wx4K9vLSXnrYXmvffLjgyiy/Ywdrb1ol79oKpb9gZE2EP4xwZ+Pcch/3wLbnskmsem
         Havw==
X-Forwarded-Encrypted: i=1; AJvYcCUUfcM41CjECYscxCycw9qbRPfYm4w84HJXGlE9n4EQ4nJHaD4pOaNNhrT0HzyMT2QSGWX3hVm307NMregU@vger.kernel.org, AJvYcCWi6DIIKo5+Qm9Y/GsPGBhyXmN0kWq3eHuD/SBCMf1zWro1a28baC78hvfXHuFiF2zqmR+AfoytCIXgBg8zPqkDGJsi@vger.kernel.org, AJvYcCXpWD2etypeI+w+NNZdl9KE/1HvvSb+PDCW4JoLt76Rshpqj0APM58cYhLkUeFp6UKCWS6hlhep4J00bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6gy3oZYCyLxFFzAESxdeaBrMI5j+RJWu1gGz7xHKMEE1Pr1g
	qjmyicIef5xBhYEz8uXFU4C2Fmu+5+lC9f5Cd/6VTRjp56l9kN1RFiPKiIJAOqpA
X-Gm-Gg: ASbGncurQlxbHLFW0BSApBf52feDHqhRfnjt4sutmniAUBvzZhDEYogzg4k5gLJYNtk
	oikUMMO8S7mO899a3PgnjwYQHKyp9I9lmHFLJgf3Qf4UFPJIUHSlG31ucGxpOg8CAY6WPa+LrOM
	ADGUpCy+x0N7He69No6lgYLyeNui/0Ldtwx430LSb7vAMAZ/WDlgq0P99qsHEpoQWbInD3/Zeio
	3hqZe3MCKMVnGGsNhszkQOLP7XzMcdxL4u3Q80M+8+Vtb6wHtE+jU3di8VhiJaEuj1jtX9LApF/
	nkJtQsvmLsZlWwG//y3kLEo7a/4tiEvorMKkmuN1ZGCyTW/P5gKWsw37kV3elZSk4lYTxWt/1gT
	Dr9I3XQyHmqMMe6ZJr/QU2lVupgqFTGrMZlLPnOmit4dnnaAr5XOrxXAFX2lB
X-Google-Smtp-Source: AGHT+IGpOLWKGfJeF7VhO4fNRiEU4yhsitsJCz3Mee8VqOhBDs92nyLp0mkVRJX0zDmN3uAhIQgoog==
X-Received: by 2002:a05:6102:6882:b0:4e7:5f31:7443 with SMTP id ada2fe7eead31-53d1be13184mr1564684137.9.1757322115033;
        Mon, 08 Sep 2025 02:01:55 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89608759c3bsm7971724241.9.2025.09.08.02.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:01:54 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89607b19f71so1304768241.1;
        Mon, 08 Sep 2025 02:01:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgvKlpP5DI+xzjcwlrLCPXK8OlFi087ixUQXV5KwPBEmavjuDnaWG8gFjl5i0x3c8Eu2r+kb6JYmplpNKZ@vger.kernel.org, AJvYcCVvod6HdNOQco4nktKzs/yu6AyO4xa3ZXqVwHGzyPjyIUGM5yyTRbMR+xi4SIH2KGTIMNc1Yh9YJ4i1EA==@vger.kernel.org, AJvYcCWKfCtpZa6o0jrAG3SVtcVGOqP1uUn3Q5UeofVajzWrnZa+aM/3iKRYE4CMEbx7f4AmIUnEnjV4OP0taiLFK3FQhHlQ@vger.kernel.org
X-Received: by 2002:a05:6102:5f04:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-53d1aad7c23mr1460406137.3.1757322114633; Mon, 08 Sep 2025
 02:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org> <aL5dNtzwiinq_geg@zatzit>
In-Reply-To: <aL5dNtzwiinq_geg@zatzit>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 11:01:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmJcwy8YUqfeBT+B79a19YeW77Ms6KjNhKGY8935tTog@mail.gmail.com>
X-Gm-Features: AS18NWDxOsfHISF-XemhyJHETyvAN38Dk8IqY_hqDYxyyU56PPJHY-UbH9peq8Y
Message-ID: <CAMuHMdWmJcwy8YUqfeBT+B79a19YeW77Ms6KjNhKGY8935tTog@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ayush Singh <ayush@beagleboard.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Jason Kridner <jkridner@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Mon, 8 Sept 2025 at 06:36, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Thu, Sep 04, 2025 at 11:15:44AM +0530, Ayush Singh wrote:
> > I would need to wrap my head around this a bit, specially in context of
> > chaining connectors. It does seem like it will still require the points you
> > mentioned above to be present in one form or another, i.e. some way to
> > extend busses to different nodes/trees and connector (even a chained one)
> > local symbols/aliases.
>
> Yes, it would still require those mappings.  I don't think chained
> connectors introduce a lot of extra complication.  An intermediate
> connector would need to be able to "re-export" things it got from its
> parent connector to its child connector(s) - renaming them if
> necessary.

I don't expect chained connectors to be complicated.
Boards using multiple-connectors may be more difficult, e.g.
https://1bitsquared.de/products/pmod-hyperram


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

