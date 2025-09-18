Return-Path: <linux-kernel+bounces-812827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C354AB53D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8191738BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBA2D0602;
	Thu, 11 Sep 2025 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KU8izAxH"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A627381E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622869; cv=none; b=knueLSqe9l8hTeLAfPmDyLQHNyGcPBC7G+HYsfLirWB3HnmhYI63WfqgwgX7IRaQs3z2gQ4ra8KZiioeYY49tLRsSZJbp8lGcDb2okqwAjGFodxQYdnc1/FFUNaSmj0cnguFlv1tOYLZjiFg3UdgJf28OY5bWLYDhOdE4kkhWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622869; c=relaxed/simple;
	bh=23JJq+roFifUeF8C6bU5RojD6718sgxi/PjX0hdr5ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJi/Cws4gzKgpD3kSG1bbvnOJvDR7SlqEidHS9LJa0qrqxeE5PmdRHQZOp3lL7oYz6UZ+K9OEZECuCWx6BwpKxrjdLGp5qJ4t7rZQsuqh00NP1vateSez/tY0AenoSREZVuS/kcUZFCNEj+FcCg6oD0nn3JpqcbpeE/5c15f1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KU8izAxH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1072505b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757622867; x=1758227667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Pc/MNKgT1tpkpWwiHPHXGDjYhl41JOtHh7+jToyEzk=;
        b=KU8izAxHzcPkaZYujWS2E3mxi5NBZgZxNagCCQ/CjlMzanbo970ZOnfDHe6OMxgcIp
         4BPzPxdkByqJ7N+AXRUDj2omnu/kHLJ75iYeI3p+SCh/QpTfJiuwp04Uw1C+h/BPUb21
         Aj+zLJlYOFlNw5s1CnHgUwFlOfI9igbcsAW/U3L2g+f7eBYsrwuqUyUH7JjfG4byHtMu
         hk9q512pIEtch8fVsG5w6JHD4Iamwiyq7MinkP6ihhsnQkh+3ygeH3AA6SlEErzclDS1
         9oW5EMXlvBCMtiSnXrL4oEJt1LZhdZSSN1NPqZhvtTPtG/5fEVjngqzxsC3RdTFmGDtX
         HGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622867; x=1758227667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Pc/MNKgT1tpkpWwiHPHXGDjYhl41JOtHh7+jToyEzk=;
        b=kDeqWsYfSib+ftb6Fu34zfuezb7vl6Nn1f/q6N6YRBM1wiQHBw9wqCcZ5YnxDNYldI
         6cHHZSnHN1bI9BFe93xaxRmuQew3T01gfqsgc7p6WXs2x/PkB4JL45Y0qpNqWE67FMmN
         quythhWYgZsL/0tYxTszbB9Ne7KMZYnGlw88ewD1jrbN+SocKqGVotqVyeJisfVAA+hP
         75vmYPrC2yctxsAKsZpHb791N1m0b+g9UsVBfRjviPFn3C4OY6C5BlayUC5PGU09Bnuq
         l1B8yze/+sbb60mq4F8SYBvxIizyk2TgpiD2VzA5v/LTHyV8bPEIBsyNBwnEhY1o0Z3j
         VIig==
X-Forwarded-Encrypted: i=1; AJvYcCXPrG50rJXsSY3VMrSeeJn0uuC5e8pbTziJf6X4EW5RL0sdlkN6u9kIR9Gu/XY2l5yPZCNk7jXLf+wLOuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxibd1PnL51JT92NUxGlSgFfY/KvE1GJ90WmuiFlfyZjeAxVfFo
	I5Ugtg0mew2DCtOx2Rinh2jc6hkGkATwit2q01WMZd2YE7Xmf51nPejSsZPJN0Q8ok0BxP4odja
	FI4/o9pTrqkAhJMVCXARZPYmYr/MKWMU95B4/BTVI
X-Gm-Gg: ASbGnctq4OJ5BXZMAi0OpnE13FnM2t3YId/glA62MV6pQq1cavCJ0Zx2P0v9lgUdiHv
	dYUFEJD2oWDrjmCjAEEjwOMYo7ejLCjrQvKVIzLog4ijlGeAaGD1VJKSVSX3wiUPU6lX4H+JbqV
	DWMSGq0vjTQmrH7JwU0pcAzU1bMhfVTs0NkrBIlPQYdRA5XQkIpeK/pLZLvfBNYUkHcpeJUn8wX
	XKKVL0=
X-Google-Smtp-Source: AGHT+IFYyJWjNuAI2LwN0HbeQn4fud3Pe3JigFs4PckWumJaQYpd+6Yx/XHQjaMSpQzmhS14qX49gT1B4tGgjj6Tpe8=
X-Received: by 2002:a05:6a20:a109:b0:24d:7926:bb22 with SMTP id
 adf61e73a8af0-2602a49b15cmr487751637.9.1757622867423; Thu, 11 Sep 2025
 13:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824222813.92300-1-rdunlap@infradead.org> <aKzot67f7F3wtHs7@kernel.org>
In-Reply-To: <aKzot67f7F3wtHs7@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Sep 2025 16:34:15 -0400
X-Gm-Features: Ac12FXw48kSzm76Yb9aQ6HZ2usu4bEgbnBioWlHWDs4daytc5ayhNulgG_v7YI8
Message-ID: <CAHC9VhQsVMKN6YyHFF81rPvxirtM7UwwAJSpOZdeybGCuO1c2g@mail.gmail.com>
Subject: Re: [PATCH] security: keys: use menuconfig for KEYS symbol
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 6:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Sun, Aug 24, 2025 at 03:28:13PM -0700, Randy Dunlap wrote:
> > Give the KEYS kconfig symbol and its associated symbols a separate
> > menu space under Security options by using "menuconfig" instead of
> > "config".
> >
> > This also makes it easier to find the security and LSM options.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >
> >  security/keys/Kconfig |   14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)

...

> I wote for this at least. Definitely an improvement:
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'm guessing you're planning to take this patch Jarkko?

--=20
paul-moore.com

