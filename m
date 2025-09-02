Return-Path: <linux-kernel+bounces-795694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716AB3F68C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005853A3D15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8532E3373;
	Tue,  2 Sep 2025 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVVEDF1C"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4903282E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797800; cv=none; b=tAp+hfcvsipsuA+rKtqdugeUOx1MIIAs15uRsfFHGnLArT/KW67QKlvJR7uOKfAqeVYp4VC8/607aplma7bflB3fo+3ixozkr3a2SRKfC847hYYZ0lWjTmHHlvnOQ/aDTNvdY7kanXFEtolFIy+5JOk43iQUKsK/QvNVfeW+Hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797800; c=relaxed/simple;
	bh=HkGU2qUS8H/fYKa+RDS3E3lJ8pHvi1C/k35xx7z8HmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JDHS8BOdDtpeOhtBhWlwoyh63eIP1y1CZkQuPjiQJcrq/iJrYqXNiqjYXxJiCuDBIJsVcE4L48bWhp94gAy6QOeGywK6QL/YnNeLLsLujg1ZWccYgbqPaRq8tn9v2UFIJsRYZKg5wiTXG/VeQsl8uEPDmU5VnX466Tm/nugiQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVVEDF1C; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-327f8726b95so3248405a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797798; x=1757402598; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFBpUVkk/SLpQU+JapXnL+35XvgcEAr8AC5EOl66PDw=;
        b=nVVEDF1CFGyK00LVEVo+fG/hen9lJ90akfD36LUl0YgnRFu3bRL5QqIQbNAnqILXLx
         UsA7L1ulWhiOYH7DH/T6Vkh2jZBoo22E1RUsWQvEm3CLPIah15Y4If2fSTOyNMFZlvJI
         mR3sDryoJCc8ByhgfKFBETZJfyU08fm0m3AWc1dVrRxYzCDjTHwfl7UGLBsyQ3HdoZFz
         KUKhSdfUE+zAg4uSMny+g0I/Sci3FSvEaw9JChysdu11vZFws9pmpsTNd5Bnqf+omcXK
         1e7Zn2Y8cM0dXrVm6+Wjfj/MXQO59QVYOorG30GPU/jqntXTli9un5XI4ojUMMxy8tW5
         5T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797798; x=1757402598;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFBpUVkk/SLpQU+JapXnL+35XvgcEAr8AC5EOl66PDw=;
        b=TdxSNGw6jZ87EzrduQeKCZxIteR3LeQ8zFvFh+1pD3q3PGdevOBkBhAQSYdjrUW/VE
         NnSIgxe/5tuMWcKSz575QWnTYgShSS9kPgPvAlJprawmul6Mpey/tbIdfGfQDmqpLBAs
         qk7YnyylrmB7FqH3uxVwPKwk/lGRDDif17TKXSvwDhCrfGsQfMObnuIYFGRjdTCq2jNr
         ZWqNMRYw41qWRDax1fmyY4p34ljt7UJPq/+ZJlgAowXpCBg0oXlCg6wXL7fd39Fducku
         RHNdJ/UfuvVoyG+G7dY4aKkZX83BvZa8uyrRRMts2ftUnVz/J65uXUPUlFq9FfHxD8W2
         eNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcLe0fzuFBbYAI8M0m6SVZXB97Cx0H313/dWxU1qYW03lZ0cnS/4JbHT/lvrC3PVzsLUduiYAm9d24yOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKyZJvUMCLPAbvitlg/BuVqvwgQS0PlNP1MHg/9j7Bv0SH+u8
	Vtxo8zLbxEVPO+pb92ZPUtWmRKeYz1iZ/cAzyrQGrBehlApf4hzCMdi2EsVfGz2OdTftm2mGuSm
	R4lonspopPlC4AYT8Kc0bxjWVwuXgwWo=
X-Gm-Gg: ASbGncvARJP+xQSmBTlLKx8/2duAUx2qzDMKx+xx6qlFiPPgDXhLG7sGhe30fGLcNuY
	23naKXE5HyNvWi7OJ/gCqlTO24kSVqSp054m3wKXipz/1kz0RC2EeuDGGNOSau5XgMS0xHueaAc
	Ftoz+flW/DjF+725yXmBzP5heKYqzluRX/cpU+OvFe33nqA3LOUBsK7yTq3kjbmn2EJUWq1gQLG
	oMitQ==
X-Google-Smtp-Source: AGHT+IHo5m2bG21/X4LSh/GmxoqpCz0iu0U3uRlRFHQGyt7VjT/kMFqVf5HCJVa1gcXyHRVCLJKjB10WB14yq3f00nk=
X-Received: by 2002:a17:90b:3fd0:b0:325:65e7:5cc with SMTP id
 98e67ed59e1d1-3280d2b7e5amr14184164a91.3.1756797797620; Tue, 02 Sep 2025
 00:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-yarn-from-020874b4da63@thorsis.com>
In-Reply-To: <20250902-yarn-from-020874b4da63@thorsis.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 2 Sep 2025 09:23:04 +0200
X-Gm-Features: Ac12FXy9sWf0mbkNJea7ykYvSQGMAgT7txawRQXCSHJT53XJnLBzaPb8xMBBf_o
Message-ID: <CAFLxGvzO2yszspJtd_A3BSTCRNSF+ts_5+2aMkNksxM48DYEwA@mail.gmail.com>
Subject: Re: State of the UBI fastmap feature
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:00=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wro=
te:
> Hello everyone,
>
> after using UBI for almost 15 years now without fastmap, I'm currently
> experimenting with that feature.  The help text in Kconfig menu
> (drivers/mtd/ubi/Kconfig) still says "Experimental feature" and
> further down:
>
> > Important: this feature is experimental so far and the on-flash
> > format for fastmap may change in the next kernel versions
>
> Is this still the current state?  I can not remember seing any patches
> touching fastmap in the last time.  Are there plans to stabilize this?
> Will there be changes in the on-flash format?  Do folks even use this
> feature?  In production?

I don=E2=80=99t expect changes to the on-disk format, but the number of new=
 raw NAND
devices being introduced is now close to zero. As a result, the user
base is very small,
and subtle bugs are likely to remain undiscovered.

Fastmap does have users, including in production,
but I don=E2=80=99t have concrete numbers. And I don't know their workload.
That said, Fastmap should work but I still anticipate performance and
runtime issues.

I guess your motivation is reducing the attach time?

--=20
Thanks,
//richard

