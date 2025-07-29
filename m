Return-Path: <linux-kernel+bounces-749368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E675B14D75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376B316A743
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B128FA8A;
	Tue, 29 Jul 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNBbNnlP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A841E3DF2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791055; cv=none; b=mJy6n+/zsuAd626lEvBTmSmKlDRxrrAosttpTeYxtVs1u2QemIU1ntR2o/xEp4eKvcL6Mu4hiuRub+mKk7Em9jUjX7Vyh59rNxnfkOuTbzuNt6PO4DjfUW9CVzKH6OCLzvsSrBvB5wpqV+Kf80F73V/R3Ns49L/vDEcdD0b3SVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791055; c=relaxed/simple;
	bh=rKtzWVWUY7dD8BuStxPm+F6cs4Vj27MWSvAaSW3jZwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRxbQ3V/oxhaIFxywiBAYJ66M0kFHpTG3L4J8ULingkY5XwvgJWxSZZcy1iuyeCsutv2841h7quh6QnC1DX3dUcMbeXM52F+0OL9MgtJ2K7SJ6+7jWlZMTIVrWdz5iwmHns4BGc+nG6n8XPnSXtf3wa4V6QojqawjkqfOpg+toA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNBbNnlP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2402bbb4bf3so24597845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753791053; x=1754395853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWKHnk9oQgxyxeUhSbQJnOtQ7QzoSPEp1bSLbS6/MPA=;
        b=WNBbNnlPE/5OKiSSgdOBRsJQkpZyobQSyS+VS+XuHfrZCiQSkj3BxqsNEB6pDjrTf/
         pH6M6aXU1e2pHP+tqANHKKLuBUAtz5CaNHPa19IzVydhsS27BI3yIQSQ6eEK4EnUv1Vu
         ebNedRUcoqUlM9TS0PNiLwkQohcNOdFPCVjCAqMWMzIUOlVIq1UYrO5jplC/0wBfZOD+
         4JkD7LK3txMIT5O+qLHuw7DXk/3kpbHhDnd8TZsrK/FJb4x8NO2TnzRa11uRarwEPPPn
         c+mi/g0By4qHMFMPUKvXvtiFt0asfKgw930+Rw1ZAcA3yx4NCID2PqKddk2CXKGeB7xV
         ja7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753791053; x=1754395853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWKHnk9oQgxyxeUhSbQJnOtQ7QzoSPEp1bSLbS6/MPA=;
        b=B3QVWH9X7DjhE/UHt7LfKpJu3nwnyhxSbFWYwqNZKpUu9OJVa8JeIIGAl4b7RlBxq3
         eaKtcPPAjr8X1z4qcAV9cdnLOqmG0g7R4KeFFPs3+F7zSjnaAAZqhxjjlrZQtD7SXP6B
         2OTpxJAXCZL6T37Lw+PipD7pJuc4SkM2jsbQr19GTK5EDH9eDg8qfkpFb8Xy0+NnYsmc
         QAonPhPAJ1FV3kXRJDxrJ80FAIiC+Q/8/Ee1E/4RNBBMmsU2v+Dmm8VSMY3/ga5xa4Zk
         M+Mv9LlSo6W+p6xkapWNz9ToENjRnfN916QaUD/W11Zw1Rp6A6LjrGHmR71VJWnLJ8sI
         LyiA==
X-Forwarded-Encrypted: i=1; AJvYcCWK3SajxVovaZOlg1qAH9xsBr+txhgCVZ4TUy2zywZ3wLiHFRN/eniYn0eAIvDZLyRF08Mn1ceFatBTwdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynb6ZWpoolYV7mi7rzdhHfX6oNBBtsYWIIzbqS2PUXZdFpbuiY
	Yfqetj0ve/xkbcX739vHtmxOnyx0HFC65BxQUmTVliWBC4/7e91f2Toc8d5Tf1hKB8OjD3b9OwL
	IAxxVDXbqFdzg8h5++GSydGQZvJdmZQMG/fW6TuaYeQ==
X-Gm-Gg: ASbGncuSOVNBNAHkzY5KWrn6SVU/izqgHz2Xq7Q9hUAA7rgB8/mN5X24dYUWUGT80UR
	iR0JQ44BsMVjwKyINo04vj3q/T6NicqYePWffLydOdtJXXQWx8MZucG0aNsxEannvvpffr3NSSd
	OYOQGu1cIgZ5VTMTKLXfFKclkPMnZZxE8QH51kgB5y3LU38K47B8lNp38Xks1b58VQn10uGjkBF
	n7U/avQxgEcCYgEn99T0Xnm2MiS6hUFALVB8Vv1ZpCoAUOwlg==
X-Google-Smtp-Source: AGHT+IFaP60gv1WUSZkMysTKs9jLnxKeTR2W/y+JRoZNqD/JP+7TPLQUx8CAkQV9vGmvxYf/KQ5ZXmqN2rQlrRfTMAM=
X-Received: by 2002:a17:902:e84d:b0:240:5549:7094 with SMTP id
 d9443c01a7336-240554973c7mr59545695ad.18.1753791053170; Tue, 29 Jul 2025
 05:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728093412.48065-1-jogidishank503@gmail.com> <CAMuHMdUkJrsug-hKkM_f+0xxrPHBQfw_3WB2FhMM=yAYzRn1Eg@mail.gmail.com>
In-Reply-To: <CAMuHMdUkJrsug-hKkM_f+0xxrPHBQfw_3WB2FhMM=yAYzRn1Eg@mail.gmail.com>
From: Jogi Dishank <jogidishank503@gmail.com>
Date: Tue, 29 Jul 2025 17:40:42 +0530
X-Gm-Features: Ac12FXzLDB0RTpdarzYfGQJBL9ZYIFpDrCdATt7059pgrTe3rFIgWZd2ZC7dBH4
Message-ID: <CADorM-9OnP2zbtn6FHp-3NcO8nfnwC_RbzdcHdiUJCPXyMy8ig@mail.gmail.com>
Subject: Re: [PATCH] zorro: fix checkpatch error by avoiding assignment in if-statement.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	darshanrathod475@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you for the suggestion.

Additionally, the conditional logic is inverted to reduce indentation
and improve readability, aligning with kernel coding style.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
---
 drivers/zorro/gen-devlist.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/zorro/gen-devlist.c b/drivers/zorro/gen-devlist.c
index e325c5ce995b..853619ab27df 100644
--- a/drivers/zorro/gen-devlist.c
+++ b/drivers/zorro/gen-devlist.c
@@ -44,31 +44,32 @@ main(void)

        while (fgets(line, sizeof(line)-1, stdin)) {
                lino++;
-               if ((c = strchr(line, '\n')))
+               c = strchr(line, '\n');
+               if (c)
                        *c = 0;
                if (!line[0] || line[0] == '#')
                        continue;
                if (line[0] == '\t') {
                        switch (mode) {
                        case 1:
-                               if (strlen(line) > 5 && line[5] == ' ') {
-                                       c = line + 5;
-                                       while (*c == ' ')
-                                               *c++ = 0;
+                               if (strlen(line) <= 5 || line[5] != ' ')
+                                       goto err;
+                               c = line + 5;
+                               while (*c == ' ')
+                                       *c++ = 0;
+                               if (manuf_len + strlen(c) + 1 > MAX_NAME_SIZE) {
+                                       /* Too long, try cutting off
long description */
+                                       bra = strchr(c, '[');
+                                       if (bra && bra > c && bra[-1] == ' ')
+                                               bra[-1] = 0;
                                        if (manuf_len + strlen(c) + 1
> MAX_NAME_SIZE) {
-                                               /* Too long, try
cutting off long description */
-                                               bra = strchr(c, '[');
-                                               if (bra && bra > c &&
bra[-1] == ' ')
-                                                       bra[-1] = 0;
-                                               if (manuf_len +
strlen(c) + 1 > MAX_NAME_SIZE) {
-
fprintf(stderr, "Line %d: Product name too long\n", lino);
-                                                       return 1;
-                                               }
+                                               fprintf(stderr, "Line
%d: Product name too long\n", lino);
+                                               return 1;
                                        }
-                                       fprintf(devf,
"\tPRODUCT(%s,%s,\"", manuf, line+1);
-                                       pq(devf, c);
-                                       fputs("\")\n", devf);
-                               } else goto err;
+                               }
+                               fprintf(devf, "\tPRODUCT(%s,%s,\"",
manuf, line+1);
+                               pq(devf, c);
+                               fputs("\")\n", devf);
                                break;
                        default:
                                goto err;

On Tue, 29 Jul 2025 at 12:38, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Dishank,
>
> On Mon, 28 Jul 2025 at 11:34, Dishank Jogi <jogidishank503@gmail.com> wrote:
> > These changes improve code readability and bring the file
> > in line with the Linux kernel coding style.
> >
> > No functional changes.
> >
> > Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
>
> Thanks for your patch!
>
> > --- a/drivers/zorro/gen-devlist.c
> > +++ b/drivers/zorro/gen-devlist.c
> > @@ -44,7 +44,8 @@ main(void)
> >
> >         while (fgets(line, sizeof(line)-1, stdin)) {
> >                 lino++;
> > -               if ((c = strchr(line, '\n')))
> > +               c = strchr(line, '\n')
>
> As Christophe pointed out, this line lacks a semicolon.
> Please do not submit untested patches.
>
> > +               if (c)
> >                         *c = 0;
> >                 if (!line[0] || line[0] == '#')
> >                         continue;
> > @@ -68,7 +69,8 @@ main(void)
> >                                         fprintf(devf, "\tPRODUCT(%s,%s,\"", manuf, line+1);
> >                                         pq(devf, c);
> >                                         fputs("\")\n", devf);
> > -                               } else goto err;
> > +                               } else
> > +                                       goto err;
>
> This does not comply with Linux kernel coding style: please use braces
> in both branches.
>
> However, in this case I'd rather invert the logic, remove the braces,
> and reduce indentation for the big block:
>
>     if (strlen(line) <= 5 || line[5] != ' ')
>             goto err;
>
>     [...]
>
> >                                 break;
> >                         default:
> >                                 goto err;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

