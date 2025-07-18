Return-Path: <linux-kernel+bounces-737383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1CB0ABC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4907B5B96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCCA221275;
	Fri, 18 Jul 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q5B6q4uu"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8321B9E0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875584; cv=none; b=iz9DVl/Ol8BE6snEkiW2SwOn2FpKx2yZGDmZchIcDcD6B7khPavhp+dtLLCR/sx+JyGjLbr/1DC/1G1b9WyXC/FI26nYCwXDsEXrvcatcD5HWzjiHmS/uIy1REsvWuq8bGsJQEMY7DzBFg0dpSEPdMrvoQW6eZ+pGMs8I8kwWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875584; c=relaxed/simple;
	bh=m/GVkH7kFga5E6DvDF13ZQV8++8dXVqa9LQzwKfgKw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/86g78D7ndJFIZX3tQGlu4aYV3zZrm9k9LnLy6hVXaHGd27WlqlyQsrncfUTH0PV1knVwbg4lf+Yk79Un3QcBEQBNdQxXWf6GEn8mMcOr1R7UqxlWR7mNaCd2iFuLMI17gVdavtTxxnnXj05FXcurhCPI2Qs6P8G7JcUf0V8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q5B6q4uu; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8bb69cdb90so2521570276.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752875582; x=1753480382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/cQbSOC5kbaML7lIX5aEU6S9YhJ0RymQUswAa6phlM=;
        b=Q5B6q4uudbJ1JW9aniixTUzBJSecTybb7pbWTUnzgrt9vcKXpzTtXu7aAOvYvcaVC2
         5m8jY65KSVjtF7tBQckcFl1qQ9SmPMw73eY4rUN0yOqUQj1DQbX3+LipS3VpN/pwmRxH
         yfVT43TP79sWpavdCtosj9F4Ij6Q5nlZbhpk+H19mKPnyRShjkd1fXn521eKh5iuoyD0
         skxSibpuLhWGEIUccMiwS8XJAf8YCsWOz1hpVcqml6xZjNo5jHjDiUgLDtdbkJYxMCz9
         ZftlZOwFqGA8qfadd6QYXrPgcVF6mslscgHlG5sJNPsoV0f20A0ewpogj9ATkF3bZG/s
         F3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875582; x=1753480382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/cQbSOC5kbaML7lIX5aEU6S9YhJ0RymQUswAa6phlM=;
        b=bRyQHDonlHaUKwB0n14e1lziZhMCuVUn8F1NShOtjEkxXRcHHx9lm2boDVkGTdDM7Y
         snY2Eb6MYxQH/uhp1QD/gh+nA8ixM2JG9O/1iKocT71VNbNpvvB3VyLAsxe1iKb9eSv2
         LemgM6Xv+KlacUg+bkVibcF5TT31XpC8pS+elsGvaH9lWoniIDoeug0GZxJpiNoPQVf/
         jDdWGGD7cE4RF4INyckj/33rAkOowohpMOAi7DmAsaQRRXim5i9DD3fGaICEliTBI05s
         TdVHNwc527Y77yZWOPpa/ItNajOZ0qPoCLOlc4GfuYAShkRQVGS69l+gEIxZCFpjiseo
         nwtw==
X-Forwarded-Encrypted: i=1; AJvYcCXdNez3c7uxfuTrdeiSjB0xnmLrriACd6xydS6rBOWYhUN7ApZ/bg/9JwTxtuVANnapAx1a9TAZ/YvE/Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lYVtzVxr21WhGu9cvnpiEITffh87vtrlwHO5DIcTRHdbTTbv
	wtecw89MGw+k67yxrMS8ot9vC1qvdh9hpOnpx7/cFIR6yOfBeCX4/wrG1/XubNmK+GF8Ae9w8Qb
	XPg3zl9f1PhyC3sl7H6Y9pb9lwc+kkv71LyCX9p1J
X-Gm-Gg: ASbGncuc13VHChcHn+556CaRHK6sFM+O+9UDIQo+SeFaG3zUMtees/AkXoRT4smrNno
	mj+KQ64fTFY1hSUS6uJU9ExH4aosPwpZULbaKelCawIaXJmGZU56I5Y9tCEcJx+hc5NZBRHniOQ
	DMRLW6F4KCcHaFLPLxaJOieETBkX+Wc9TcsGrAisBLhQOfEMcZRg3kDiXYIHxAAGKV1Ob3yU5qo
	l+bLk0=
X-Google-Smtp-Source: AGHT+IFf5bnxZbREvMvlsbfizsYWDzhgcbPnRrN1Pv/fcSWvOqeCSaHZjLEK4HTUY1AY4fj8c+1pm2RjoePlp3shqXo=
X-Received: by 2002:a05:6902:e08:b0:e8c:93d4:b0ae with SMTP id
 3f1490d57ef6-e8c93d4b42amr10116844276.21.1752875581835; Fri, 18 Jul 2025
 14:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718203734.347091-2-thorsten.blum@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 18 Jul 2025 17:52:50 -0400
X-Gm-Features: Ac12FXzCPEr9FkZrYDFFpVvOY_IL3QCEVZrKQZHLJkmmAUMqwWFbcM7dIijU3Ck
Message-ID: <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/audit_tree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This looks fine to me, but as we are at -rc6 I'm going to hold off on
merging this until after the upcoming merge window.

--=20
paul-moore.com

