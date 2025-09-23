Return-Path: <linux-kernel+bounces-829555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D6B9754E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C883E441959
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D9303CB0;
	Tue, 23 Sep 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkd/JW9/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2F303A08
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655470; cv=none; b=pqKas0nNPLIy9wOnnCMmhtMIHsJO4FTyT5IrVoJLXbDaCiGGwCs2oT6IdbzAwgWlVFhRd9y1J0JwSeNygAGxolbyjtUhjZEwghkalHQlUvUFaWsd6M0wEJl0LEaO+rB0WkcfMlKvU0z3AfVPwYBptVl7UFRjrUjtA3rb4igj48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655470; c=relaxed/simple;
	bh=N9a4JnHkbJgQCm+ywJBCt4OEQLE4uXwPZhIJCqUpup4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/xZThVK1FsiU00NttUHTwzQzCV43oTh3Nv5ZiC2PkeSD9noks1XXJb49/Xc6obXUy4HMq+jx5z+kFSKr4MIW3Wb5pEfFZ2ST7ADKgQQJ87AwHw3CsGDQv6i3F9OhtWiDAmPr9vMJ836wJtWk+kmpRnalKKSxf+3MzD+mnYsAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkd/JW9/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26808b24a00so10246645ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655469; x=1759260269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9a4JnHkbJgQCm+ywJBCt4OEQLE4uXwPZhIJCqUpup4=;
        b=lkd/JW9/SL2GIPBW2PBUpKt0iJRoHyDok0dhyuObavUgKeIUoXrQ9ucFvqd6A+3JnV
         E3Q4kifvW5glKqyL7fwEgejGqe69+vrb62fzyEMiWWvV+xWKVyCF0/Qlas07L7E8yB07
         F8X0/ItqB4SqByZVJv1Z3QMWY6othwg8g/kPhWSAp3hkQXvRykJcVfPALMqrZcZiXgxL
         WCPZVTCAdIXm3J7t+0w9azos1QWhq74wKt742XVHA+s6zZokbwuM/jCFQgLjJHXvq5Rd
         BDtEX94wo0lZgU00mSh8PVqZQFaFVNo934H0Axivy76bpkKcV3gXdpohDmFztN996hX8
         lekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655469; x=1759260269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9a4JnHkbJgQCm+ywJBCt4OEQLE4uXwPZhIJCqUpup4=;
        b=dEBiBebrxSd4t+/Wh6CSESnt1qSwRLYWHTl8RLtysjdNM1SHM+cHcXOVcESLeQQw2D
         VVjXmwJAl9lQtVuxW/Bg4RbS5qApRO4rLz/CYvwlu7n7gz19CZxiP7DbzpuJKMFJIovD
         e40XyaKGpr8/1lGthewy/r8viLJ6boYdxqZAOkZppk+1zDgOZ0jvtxT+NLh/K+rS0wBE
         44c/fHnM4tDygwBGCYBzHrNO57HdSA434DpQjoCQykLPAbM2TjpIB5dv+TY88iDSiLlV
         k7HPItgN0eYmkmSF9UTXqVDDXLv1zvs9VoNcYrzk3YXmj9x2aEy2bBv48v6le3Pkrve7
         GOaw==
X-Forwarded-Encrypted: i=1; AJvYcCW7gdAiPLCqyadHJzoBAklDwSfGvoKixcHDNCsiP/TCMmfsD69hIyf4afTA1Ro5lFDJaTBi00sFJYyY4Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1y8hMlm/KwH6UipmvLFKO0OuCsg08/KthpFonX72slHAEJnt
	YpHQ5P7dCKEO9a5wKWiFA74qRdB+eu8oXac2y9uioZS3Wo3jphSNl8DRUpsG/JJOKVecGjWkk7t
	U8xt1UebEGlQ5We7pmBKyNezk0Q1QPmA=
X-Gm-Gg: ASbGncucJy317WyCGJB05D1y7BUTkL8M2KmNyFpMkqjvS45osBte4krE6+El0rBtjKk
	M8KKl6Rfx0/3oaV2wTpyYPj4Y/0rOTi65yVdHIeYUZLXsg2WcDUjhALAk0zp8vGyQPA2oQ5VtgN
	MQGgY2cKhD+bFzeYkWVwQP0iw/i8wEte/wanRA8rwq4SyRcjL1jfjh6IYVfJ5ZKN0QLYZiCz6T9
	uR51XBsz1i3f3Itz0nUXrKxWYOXGH6XumF2zDM3A/gDTfdxhOrc5oSmD3Z7jBVr/Du8vppkeGW3
	sbZiBDOMNwxiZt4DSy0kiEX0SsPaADmzRcKD
X-Google-Smtp-Source: AGHT+IFcQiModumtMVHD8aRIh8pOQHwIGYsNP00K7IKOFBbOEOOvFFtXFDdnCrBTCO4N3BIOJ+CC74WWEzOU0nsptoc=
X-Received: by 2002:a17:903:191:b0:253:a668:b638 with SMTP id
 d9443c01a7336-27cc1e1fc0cmr24562995ad.2.1758655468711; Tue, 23 Sep 2025
 12:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNLOhQyd0YmJnPco@finisterre.sirena.org.uk> <22591ebe-c496-42e5-b2f8-9ca4f8fcaed5@kernel.org>
In-Reply-To: <22591ebe-c496-42e5-b2f8-9ca4f8fcaed5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Sep 2025 21:24:15 +0200
X-Gm-Features: AS18NWCKolACJxLsyWUtpGgTwyc_nQQiPmP9g5k3cGe-YzxrqLoSYqm_9fB8kPc
Message-ID: <CANiq72k6fioBpFam4YhHazS1X=EVGV8RM6Y9g7ecZG_0w2FA0A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the driver-core tree
To: Danilo Krummrich <dakr@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> This hunk doesn't seem to be related to the driver-core tree.

Yeah, that comes from drm-next, a script went awry here?

Cheers,
Miguel

