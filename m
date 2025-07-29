Return-Path: <linux-kernel+bounces-749526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A30B14F77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E4218A298C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4BA1A238A;
	Tue, 29 Jul 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRTdT4uw"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2EF1428E7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800283; cv=none; b=EelT25AP9tHsI7D59JRQIGHEwOZ1XqF6rEb939zhXX3g4lVRLdJqZEurCIrvH2HNDLV+1y2a/O/xuVcuMPsgbKXhgoRGeC63siA0lXajKOGjExR0wQKT+JRK9vrosSiCT2DJf4WZrObqBwUi6Wd1Q22Qk+MWXjzU3F9pc02mkrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800283; c=relaxed/simple;
	bh=fMjKw8fJE6/DYyPVFlL4viEYITAF/89CcAe+AzMPyE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skNK6iHk+TBmngl0tfs/9ERH9lvDJeKZ530B7Ib1O8V9vp4ZeLUMKvzBsntXZ7FbVEySPveX8FMrGgGVy1bTVjktxixW1z2YT/kv/+RwAXP5PG+SxxHf3rh3Qzw24VguuDEtdSpk95yX0hoJRFCP5mZsl5QiPuw/Z7WBWJedW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRTdT4uw; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61922872dbdso1464352eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753800281; x=1754405081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e58Oz7oUEhQLUk8T4Mqsd2AZ8HqT3w/u9Zdk0j5kkxw=;
        b=PRTdT4uwBtV3Q8SrEpxa+8BGlfzk3RWGeUfJvNGKCzBBpstvoYc4MjK8xEyLAkEu4K
         YU2Dg4YmnR/JKda3yN9GRlhHpe+OqxDZrQA6619uLRLyy/Tldno+kaZ1KGIjTFAJ0T3h
         kU/rTFLYYzy8IsoxYXfwz7z7+cEG12DjyH4aqLo22ROTjDu2fh6hKxnXgoSo+lgAI+Tl
         hOtARheMzNhndn8uBvIQTlv1DiKLz5rVQ5Sni6ui9r4VFgY2KoKpS2VA2Ypc+qnmLcmD
         bUzox75sjp6TIpvX5y69tCKz6RB70lohLEGC4LDbpD0untrLRvJxilTVQT9+abNxpOUw
         3omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753800281; x=1754405081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e58Oz7oUEhQLUk8T4Mqsd2AZ8HqT3w/u9Zdk0j5kkxw=;
        b=JAd/Bwx4dBX2E8TqHSuaLrdKC2TO/lmg++lcyRByn0S3OFVEFqtYzD4xeuLOMgguLE
         MCCUrOrhWLx5ONBDzAI+FJ6sAv7gHNmiMk7Asv+MXBGdlnJ/zMWTmBO/dA3iGfAKGGso
         HOcWcJ6CTL4qKJ/eSK3sj7j6egiAqd7QAfVBX9MZVSaxqGAp1lAel7yWhsD0Wq23QZt6
         giCZAM9d7BdWa5zIGdd7nvXXHMbuxMvCgA+bAGojieQ1+VW7w8oJETQOITWINpC4WztZ
         Q7ep6fjcXqbitSTB2h0ttHoLzXKS6H+IkJH+Sn3DQoK5Bf8Uj/4MylhOXoIGqvBux/DV
         gonQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqLCkcU8RxM8PbOA/25PYYnVQen4x+A+1ekPWI+04l496AURjvUtWtcYY18MI+PJMR6FxqA521erKm08A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAefyhQT9AIdAiNv56LjbXQ6bES/bE+GTqpPICPsp6JL7sfwf
	TU5tL5QV9Nw0d/X1ghbufgiLDPQhgxsQZNS1BF4woR/mo9kieMHre/GEXzRY/RSRcDlHZlWqx/5
	12nYxvBS3LW5c2ioFJPp6W1ciAfY3KUaTaKtgN5A=
X-Gm-Gg: ASbGncthzNzs9Mv2zp1tr2F31zCyfaCel4gbGQas5mdxU6oU3XL1BSVHiEdxNjut//C
	tWw9rUPsxD1mz4pFERNaqzEmbHTwlONamGAqESSS+r79t+hwmYqx8g0LfHz8owKZmV5ZGwUCO8a
	OGTWKy2kDx+MjkZVYV2ed+uODk1YajkktoGB1T4M2u+Yq9jJhLFMqoHfLplNjn3m6U12p9qO83J
	eGWmDBM
X-Google-Smtp-Source: AGHT+IGpZ1p6KnGy9noX018eYoSIQZ7nbMhop24dOULZsTAevFcYoUJSfW6pitPb5UB0Nbo/Dw2gvFvXCh80lYOFdfg=
X-Received: by 2002:a05:6871:cca0:b0:2fc:2b74:7b79 with SMTP id
 586e51a60fabf-30701ef8394mr9974973fac.20.1753800281088; Tue, 29 Jul 2025
 07:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
 <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
 <CAO9wTFhCb7gDEo+q2SAZcn2KdUyVe-fG1E4bR_+US9k2J9DOnw@mail.gmail.com> <2a2bb7879e22208205fbb8f9bc56fb3c882bc307.camel@perches.com>
In-Reply-To: <2a2bb7879e22208205fbb8f9bc56fb3c882bc307.camel@perches.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 20:14:30 +0530
X-Gm-Features: Ac12FXy3fK67xSnSanQZzpriiQ5R6tCVBHHq-_iW5iFbtcF2Hd5yuVnENBkTDco
Message-ID: <CAO9wTFjd3MfL1yPTbcPp8_oKtQwNiMHCiZs8Y9oha7m8g8BiUQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace tools
To: Joe Perches <joe@perches.com>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 19:14, Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2025-07-29 at 17:15 +0530, Suchit Karunakaran wrote:
> > On Tue, 29 Jul 2025 at 15:54, Joe Perches <joe@perches.com> wrote:
> > >
> > > On Sun, 2025-07-27 at 18:20 +0530, Suchit Karunakaran wrote:
> > > > The checkpatch.pl script currently warns against the use of strcpy,
> > > > strlcpy, and strncpy, recommending strscpy as a safer alternative.
> > > > However, these warnings are also triggered for code under tools/ and
> > > > scripts/, which are userspace utilities where strscpy is not available.
> > > > This patch suppresses these warnings for files in tools/ and scripts/.
> > > >
> > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > >
> > > > Changes since v1:
> > > > - Create is_userspace function to check if the file is in userspace
> > > >   directories
> > >
> > > the changelog bit should go below the --- line
> > >
> > > > ---
> > >
> > > This
> >
> > Sorry I will change it in the next version.
> >
> > > >  scripts/checkpatch.pl | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -7019,20 +7019,24 @@ sub process {
> > > >  #                    }
> > > >  #            }
> > > >
> > > > +        sub is_userspace {
> > > > +            my ($file) = @_;
> > > > +            return ($file =~ m@\btools/@ || $file =~ m@\bscripts/@);
> > >
> > > All other sub uses start in without indentation.
> > > Please move this next to other sub blocks.
> > >
> >
> > Yup will do it.
> >
> > > Please do a git ls-files -- '*tools/' and see if too many other
> > > files are matched, especially the Documentation/ ones.
> > >
> >
> > I didn't quite understand this. Could you please elaborate?
>
> The search pattern m@\btools/@ matches files other than the
> first level tools/ directory.
>
> It also matches Documentation/tools/
>
> Perhaps using m@^tools/@ to match only the first level tools
> and change $file to $realfile to make it clear it's not
> a/tools or b/tools like the diff filenames.
>

Apologies, I missed that part. Will fix it in the next version. Thanks!

