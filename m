Return-Path: <linux-kernel+bounces-803233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0977B45C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBC175FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416931B811;
	Fri,  5 Sep 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w75D6bIc"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDC1EFF80
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085815; cv=none; b=PrhyvDWO6JnaMY0Kb/Mw9bvUCbMbAvk0CHidJWOxbjtYnBJaB9WAqOQWKrR3iCStN08GQF85S48BonMCZtgk7HbE9LBJ5KJ1g7IJT7i5gmqZcYHNwEBK4yphPfInqhBszU/zspiRCU3I5Ja+jtc71Jj1M+yfPiJhE42sLfvflOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085815; c=relaxed/simple;
	bh=L1erzjAPTsvN6HrQUgZX1AksS89vYp7mpiVFM99jDHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5XmJ864ZYOzz99LZzC7sgTyWkfF/WiEoURxcS7wlynIvWDd232VOeyRThDBV3daeMt+ViuFQOo7PjEs+nicJbOEBArRlf7hAyOVnIqTWPHXIaX+XxJbdMMFgUQIyMiq6HrZ38PBhPPKzjrjUUplQCc5h/Kdwda23qhY5G2on98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w75D6bIc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b2337d1bfso196935ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757085813; x=1757690613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcbfPqu6x/zD1qFEIta6ywBnIMx01Wx5kGVGKOgI10Q=;
        b=w75D6bIc1c1N3id6E/MrxMCi44TcmoQ4KzC9Q+5DjUjdC+3ejvZBvxgxeXzf9yub58
         LpWDByLVWpKucH+tHgg1Aejq+CKc4QzgD61u/Azju2aBmk/+P52M2UcL7mRdEz0w/qwC
         ZFFW3v8Ps31X2Ca2lNLXyZtoqppJzggWWgO1L24UTkg0w55MOzUyZ3ThUZARuVkhWvrw
         4hHTMa1nc8qumSbrCzQuxB+PKchECfBg+wwZ1yu0E9FVRRr8ElFmMKQu3MsPUnpzwvu9
         p2viGewlJAAjOJVXl0sH0vJ02S1o/5+stC1LLHXN/+62zR1udO1ZVhFw57Pv59g7qD9C
         HdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085813; x=1757690613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcbfPqu6x/zD1qFEIta6ywBnIMx01Wx5kGVGKOgI10Q=;
        b=YwYG9GfrLxUM+4liH6FJw0WfLU4DlBKScsATXobTUluhelWymYrZ+U2hKQXnKWN6+A
         MFCUs0l/ZGrKrNITSxL4xWMrIS0Y7rqvg2s7Qlk0hcTENmHYaX7PIaaj8fEzOhaQDfb8
         e67C9R5A6cMgTAQmsfslUkYH7q+9ujf4BP+gmlokZ+Mxx90qjoBL41QsUqLzz1DP5/ha
         fS4drVmlcalG5h6z4tLaqWLb30zsPradDMWJeNQOv2/xyaIwmP+paI6noq38poNVkYKk
         tKxYXSoVyCo2Xf5OYM4NNQdr6hUNPAPVYOZUsV1eC4kaKzkwHrwqAaVfV+R4razGH7a4
         Q0qA==
X-Forwarded-Encrypted: i=1; AJvYcCVGo4EdDw7t2oyKrQCKrOE5wtNmdHALSMThjjs2h2yhG1taHuXDGK4YDL6pYi8fGJsbkUlh2s1Gad1AxWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYjB4Exswg6Jv4JTaIXkpUdLAT9357RZ2aufoxbk4zWKrahbg
	/ByvIZPE/bga34YnaWynRQCZtUcYXfFm4nO+Gpiq/0olU1VqRORLMl2uCzESobe7N6NLgBndo4S
	NJ0fyHm7wmdn1nUe95z+n8aq8vcYVQAKMdk32wWrR
X-Gm-Gg: ASbGncv4PszXd4jTKuOrb0FfgCox0nXTGVg/gP1UVO8wHEqWkjkT68kYFBHNnOJvKsi
	Tq+9VDVX49MKHRiXFYLcOgvlMBLgX0u/3vemjJkTcwYeWD59EdOTsFWTeEiR4Q9GEfzfG+VhxIn
	UBE3ffHgwPW8oft4eJ66ClgWz/2A4B05jCxzw6+RrcEHe2QQlCtfeeSUwDHTc8pAB1rivsuNeES
	bTLRqn72FwqG/GkufpRvA==
X-Google-Smtp-Source: AGHT+IF+gru6sdcU5F/mZuVq6IDva+6mmYWp6nBgVWHn+CRMCzQ/MCa/gCpzt0iDhfTf3m3/Un6Um48mI6lY8WAjZT0=
X-Received: by 2002:a17:902:f542:b0:249:2f1e:5d14 with SMTP id
 d9443c01a7336-24d3838da76mr2885585ad.3.1757085813071; Fri, 05 Sep 2025
 08:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5b5zgXZ8UGEo_oOKGUqyWPOSfA9nBJw0_wzxRvEQZTjt6DLw@mail.gmail.com>
In-Reply-To: <CAE5b5zgXZ8UGEo_oOKGUqyWPOSfA9nBJw0_wzxRvEQZTjt6DLw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 5 Sep 2025 08:22:56 -0700
X-Gm-Features: Ac12FXxckOMEebGfc8qDQJVkw74dP6APBx_zFnjXFuf9ojwwcEcU74MrYLbV8qI
Message-ID: <CABCJKuePtd00h3Z57Nj6TbG=GyeKeFgkzUBZJUT1v2_BQ9dczA@mail.gmail.com>
Subject: Re: [PATCH] module: harden module signature checking
To: Coder <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, mcgrof@kernel.org, 
	"petr.pavlu@suse.com" <petr.pavlu@suse.com>, da.gomez@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 5, 2025 at 6:38=E2=80=AFAM Coder <rootuserhere@gmail.com> wrote=
:
>
> From: Fidal Palamparambil <rootuserhere@gmail.com>
> Date: Fri, 5 Sep 2025 17:16:01 +0400
> Subject: [PATCH] module: harden module signature checking
> Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, samitolv=
anen@google.com, linux-kernel@vger.kernel.org
>
> module: harden module signature checking
>
> This patch makes small defensive and style improvements to the
> module signature checker:
>
>  - avoid void * arithmetic by casting module header to const u8 *
>  - add an explicit bounds check for ms.sig_len before using it
>  - restore info->len to its original value when verification fails so
>    the loader does not observe a truncated length unexpectedly
>  - use READ_ONCE/WRITE_ONCE for sig_enforce to avoid rare SMP visibility
>    races
>
> These changes are intended to improve clarity and robustness; they do not
> change the signature verification policy or behavior.
>
> Signed-off-by: Fidal Palamparambil <rootuserhere@gmail.com>
>
> ---
>
> diff --git a/kernel/module-signing.c b/kernel/module-signing.c
> index abcdef1..1234567 100644
> --- a/kernel/module-signing.c
> +++ b/kernel/module-signing.c

We used to have kernel/module_signing.c before v5.19, but I'm not sure
if kernel/module-signing.c has ever existed. How exactly did you
generate this patch?

Sami

