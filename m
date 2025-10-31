Return-Path: <linux-kernel+bounces-880087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FE4C24D69
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 261B1350E43
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7F346FD9;
	Fri, 31 Oct 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qu6amDWd"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8C346FB4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911309; cv=none; b=CTC3X9kuD+KXWLE9aQ01252qURDZ64kIH06vGLMJ3OX4xfhNU/O8zkZ95S1nBqhMPxiXjNmFmvo+Q+RzcEzjIqRdxzgGSVr08Prp1QRS2xx+ALjwRaLVCrmUL8tc3TXkumxRLauZFu0NRoxSY4I3w5sOBp1K0a5pFC+9KzSmI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911309; c=relaxed/simple;
	bh=z+o0QIXZjT8lXxXxsGC/4Fs2wMHpYKBAa2A7KhQGQ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoZ8XqOmsLuYsI6flbbsmfQj3w1fmqoGk1UDCYbM66OlcVImjc05L0yOMxtu0sOKbayuwlzD/V2yFz1l2IR2ULMKBZgt3O/9xTpo26UaCtkyHg3OXGDPHi3B55u7hN6Vo7U18RY1EBB/Ewd0XgTHLtjZUiNwcWV9ru8whzNoCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qu6amDWd; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-44da917e7deso1136393b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761911306; x=1762516106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlwS3zPH7Q41Nzo2HC1V07gN7n2rhCpo5Vfsn6GhCWs=;
        b=Qu6amDWdQkOYAc2m1sA6GmuxxYkBThNtLYqji4A5HzPLrQOlMjJvxEJOps6Kh5mYEo
         kRCz5cAsdxuTI57zNwYkBRrxCLkITOT2nuM9LAtvhjt86huw07Z2HdyNWpJiGOPNVdJq
         c160scaFY4Z8kXTOpqmn2jKFKz0nKGayf7vHQOyByeGgd27lBQZVKMqPXTbB7oDS6gvs
         9gbZNYYHdtj43sUxEg7eiD+vH+xRikFcO0fKXWgS6rOJP8/cjsFeKfJop3myt3eksoj4
         NmSOJfMyW/QcsrbwyrfBT/UBpukr6zJDsxSGXUgBBVft8w7SarUnZBUhuTI/HgqqoNwV
         3oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911306; x=1762516106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlwS3zPH7Q41Nzo2HC1V07gN7n2rhCpo5Vfsn6GhCWs=;
        b=EIGbjiYU99zQDQF8TPrOSVGLt37LkY4GARjfgbP7rnJKhhpEqoYgc/jEEJkwYA0B00
         qF42DOZKlSROH7pvbTaRhGt4hMntGlhHqZUvvjHYTYgzpNY4EZvTvj5Nt2QBrYbEcknK
         9FRdPyx2d3dbM+MMS0fCFR0JBf265R+TLNtDUoUVU/UZPLvgfn19EgxxyIibhqcuxj8E
         GlPqXLwzVTFr5lQ7EBWmrJurBy4V8EVMtdk7mOhyr3FxBmqrH/a5hPbvr17b9f2oNpq5
         JyJiavlytUZzqkR7dMVt8G9/MHc3aSV3voG8jaVYj788nljkfXDgCz79DSTRsxfCnHVt
         JB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtl5GPopxGt5b3vaP67DTNtCRSxZbzxvqm9Wz/3BtI/++apVPjy/RKL1bNVYb/NWKVDKLHQbiFXQnY0xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QUTGNS998zCNAAxsF0dNczC2oh+GSt+YmzYPJ4u/AgGXwKp4
	qbVwNoxNTQ3AtpycJDq7oo6ukxqKIFm5SP8Nj98NB6ygX5btFWVsxOZeWgNB796hchGMRO7yzA6
	qh3URtk+n2MhqPbaTgztCE8ueSUriX3769zNP96kptX2pjklrkSSz3ku9LlI=
X-Gm-Gg: ASbGncthGcCoYyQ3Vd0CrCuVBVL8VzSeUlXkareBEXvC2ZkmdCV6b+qWrUMpVZLmZLG
	2lgCg6oF9BE8soC2M3wxND7FVAnIknbkau94T34LLxTz5XYnkK7XxqvEEsHpsWiC46wMuhEhMnv
	ju2HmwiP4hUG6Ee1et65IjHIiOWyZRRJh2SJP8Rr5TZ24wrnqjuqzHMERLoELlOKW1pk1hs2rxs
	BjU8tfb+NjKvvejduTHa0zdq3K1oNdnSW20cO1ZXn/EsNlP68+zOX+L4O3PoDGadPlB7EG/bqG7
	XSyEP/sCK8S2F1w=
X-Google-Smtp-Source: AGHT+IFn+kdpOaxRHChvDDCOT/IzFOqf6Yuxb5QncITiTYgJQXvWtUAPFk1/Z9bVNPh2z8gErYmDPzmHey0AxrHVefg=
X-Received: by 2002:a05:6808:218d:b0:441:8f74:f0d with SMTP id
 5614622812f47-44f95fac413mr1322392b6e.55.1761911306379; Fri, 31 Oct 2025
 04:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251030183621.39ea843ebba82ae133b2b38b@linux-foundation.org>
In-Reply-To: <20251030183621.39ea843ebba82ae133b2b38b@linux-foundation.org>
From: Big Sleep <big-sleep-vuln-reports@google.com>
Date: Fri, 31 Oct 2025 12:48:15 +0100
X-Gm-Features: AWmQ_bllX8fiVQbcOAZy9XxrHCwkX9Mk1pssFOX_WeDNH-_wvRGsENq8nY9U520
Message-ID: <CAEXGt5TEr353v7waAc8N68te4xLwCRE+RB2BWs5tFwMC1mQs9Q@mail.gmail.com>
Subject: Re: Oops in secretmem_fault()
To: big-sleep-vuln-reports@google.com
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew!

On Fri, Oct 31, 2025 at 2:36=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Thu, 30 Oct 2025 16:34:29 +0100 Big Sleep <big-sleep-vuln-reports@goog=
le.com> wrote:
> You might want to include a token here so we (you!) can track the
> report through to its resolution.  See what the sysbot people are
> doing.  For example,
>
> https://lkml.rescloud.iu.edu/2408.2/07972.html included:
>
> : IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> : Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
>
> and when Dmitry fixed this he included that info in the patch metadata:
>
> https://lore.kernel.org/all/20251028101447.693289-1-dmantipov@yandex.ru/T=
/#u
>
> and that Reported-by: will be carried all the way into the mainline tree.

Thank you for the suggestion!  We are not currently tracking reports
which we categorize as having no security impact, but we will include
a tagging scheme like this for future reports to the kernel which do
have a security impact.

> btw, it would be nice to Cc some human on these reports.  One cannot
> be very confident that emails sent to big-sleep-vuln-reports@google.com
> will actually be read by someone.

We are monitoring and replying to our reports and the surrounding
conversations from our project alias.  We'll try to clarify this on
future reports.

--Google Big Sleep Team

