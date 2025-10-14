Return-Path: <linux-kernel+bounces-853142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2001BDABA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466BB19A1BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36AE304975;
	Tue, 14 Oct 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCKb16It"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4823019DF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461328; cv=none; b=qAcn8BtwPPNITpripufaZO4zJ6ZqtLMeYjFGxoAW+8rtRXkrWUYstMWgtHOavV8cZ5fdhH2zNpT1CqimOMY/9Ni0kAc7AfWX+jWIkdRwUCMXshGbu78rZ/jx4WZvT/rE3qe6RKXhu98Y2umfQm1JxzsNY43XAWTtcnilicfv4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461328; c=relaxed/simple;
	bh=L4ugcq6cShFH07clIC29+wavr51l+pFw40whAk/VOpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUU11DiJuTTuT0sMlFKxoiLwondzlehWmOHdTQrteNbJnppNh0hSR/J081CSrDn5MPdiiR54ezMbZk8v73JQ7VbfwDBmWSmdTIKjwDcjfpLrUesU5y7szg28hWfGIBv+lWWpunPF5HJJG3Dmo5+GLRASJYNtvaUAZ0Z5zLpl/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCKb16It; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7501c24a731so66774957b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760461325; x=1761066125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiCVY5I1JOpPd1mbXTfrhMnqAsmeTTtG3NfQtMnTa2A=;
        b=HCKb16ItdVmdIrq/mO6LLg4FjyPsWcaGIkrKQkoa+t7jxzOz6H+4FpzplczDiPuMgL
         oZhc03ml831jOu3nMUkihblC3UukIxThZ8nV9e3w45kQg8zb4l4TA7+w3asku7nKtY+6
         OKsupcsFi2CpJCT3Txg9qlzoz2QkgJggw0G/fntS41LV7VCgR95lboJGhFIEoj2aQKPb
         ldhX7BTsMW2s3wCRanq3V5sB3Nyr7Bs1ZUNQCSFCyzBVanDq6JkiRW/NLCMCRbSRHzsI
         8iRG39vQLsvWWX74Fdkqu6lyDmcPBIZhuIDfPFACCZO7I32o4HjIo1B9j1tCcdK/4zc/
         VAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760461325; x=1761066125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiCVY5I1JOpPd1mbXTfrhMnqAsmeTTtG3NfQtMnTa2A=;
        b=Bj82RxsYvmPODTX2uq47EuZXamsOY5duWrkref6yfU4pUm/gOEgLQyJ5WYOJ/FbDOq
         YXnYBxldwBT6moDPn3+Z0IcBc02gnKn7F+rAX4qvfghFxlT66CNnOWtfkGhxU15YM0kJ
         Ka+SUx+p37lHPa4LetHdOC4qiUXxBciBccquwBwcJjuFPoQi+T+koQJcWrqTlZ5qg5Cb
         pbBlLO9ychiBodxuQmEBjUjgd3ErqHu6sUKc/R1CxbVtSpz+W00o8WBP9dXZVurDYcyA
         +02fXjcjuYpuh9JV7FXPkZeWnoh2qr+I9MzX8I8myWElPmR/XY7ViFQ8RHjaSU04Coxn
         q5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5A1T+ysRo4mmDSDDICbnu4YEax68SLSvo2l0lO1oH01CL+XGBMS22RaU+UN2alEXel801bmc6/J/rtK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3MHd5i5MHhdKEsNH2zED7vaWCwQptjHL2vnTN+Yqy2A7cXtZ
	raH1eXitXCjTEZovd/dmO1dnUb5yWrEkDpZwQHqf8FHktmoHf5riTjAGT+Vo+PzRC8tG1m0QTV7
	FqZOmNanajkJZe5z7SflPKwhfCjCLgzQ=
X-Gm-Gg: ASbGncverIPMgtdgfzOzr/KLijuMVMwuB2dLQdr7t0x4uaX6pAfhVL4ajhKVtnNwP1r
	JcXhS/6Zbx1xTmzCrr56ibWUO5T0pkQE5LMfegA3r4+DdIVb0RSlk+nb2du8RZUwOMIecTL+53b
	t9ZojbpjEkiKZ8ACSlgiYM+ZSr1zMDvEjrKRy7HEPLCcHM8n5gydgxPz2LrhmV0uxFNsV6WWqaA
	IS7o1za3SkVF17SCWbNPrpOdKmpQ5taGaBy0FLW+UIOBIQi/+2WgxBLPA==
X-Google-Smtp-Source: AGHT+IEujHm7zyW9C9csmplcIl28YSFbDC+RXAgRXtI1BLXHl0TPBl4b/XV5+0w/3Sz4hb4eZjnDYii/ibYLEg5tNaU=
X-Received: by 2002:a05:690c:fc2:b0:780:fcbb:c35f with SMTP id
 00721157ae682-780fcbc0e13mr190348647b3.30.1760461324794; Tue, 14 Oct 2025
 10:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
In-Reply-To: <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Oct 2025 10:01:53 -0700
X-Gm-Features: AS18NWDA-EBGXeaV443-s_8eQCzvx4G2-GBvxjQgb9Qan8gEi2zGKFJFUTwlXxQ
Message-ID: <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Brian Foster <bfoster@redhat.com>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:43=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 14 Oct 2025 at 09:48, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Maybe the solution is to change the write-through to regular cached
> > write + fsync range?  That could even be a complexity reduction.
>
> While this would be nice, it's impossible to guarantee requests being
> initiated in the context of the original write(2), which means that
> the information about which open file it originated from might be
> lost.   This could result in regressions, so I don't think we should
> risk it.
>
> Will try the idea of marking folios writeback for the duration of the wri=
te.
>

Is it safe to mark a folio as being under writeback if it doesn't
actually go through mm writeback? for example, my understanding is
that the inode wb mechanisms get initiated when an inode is marked
dirty (__mark_inode_dirty()) but writethrough skips any dirtying.
Afaict, folio_start_writeback()/folio_end_write() needs i_wb.
Additionally, if the server page faults on the folio that is now
marked as under writeback, does that lead to a deadlock since
page_mkwrite() waits on folio writeback?


Thanks,
Joanne

> Thanks,
> Miklos

