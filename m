Return-Path: <linux-kernel+bounces-806479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B125B49791
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3946B20239C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008B313520;
	Mon,  8 Sep 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="079uX+64"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E83128AB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353906; cv=none; b=YkVPJudSCFiv7fkTgDWON5E6cX2w7MRGlKw6nqN29wrT0+SsZlhC/7sHivUwQuskEp0rVhiFwKRTeJYaFpOJVYlUUn8MyahRFkm+aD0gCZyTDHmttL1vWqr36gmPa4PapQYhzpJTn1xP8s3pbDNKYzK3rwLQSjL26Yq55FrHyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353906; c=relaxed/simple;
	bh=4G8OjR9ssKy/HeocTqhx3l5d0C6Xda9h262DRWrvvKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4SxYDTp5RlwVMI4VEcuEe3npo4oka+F9NiaK/akC+KpAGkmw84DYF5Zp5isz+2q6F6hb01WICU5Q6YfYV8vhDpnaQ2PXm6HCM3GGb7RvvFP9ipXWADK9HMJDhylB54TV4ptrrW6ZEBmnqZgc8C3jce99eI6wr7ijQc7IE2Hhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=079uX+64; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b350971a2eso412711cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757353903; x=1757958703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G8OjR9ssKy/HeocTqhx3l5d0C6Xda9h262DRWrvvKQ=;
        b=079uX+64QLvdSDdn6L1FTABEUwHE14L07L2O1V8RZGepFO0Y8FvsUcywIiMP0CVHek
         zUqG1ohbzNBNnIPbr9DZQydKLx55d2oH06+VZoHIbVeA0v4grk2zXXnNVVZrQeVH80gf
         oukt0ou1jIgX7HMstE/5fJlNkWwvB93I5mqX2Tc5MbGGlSQNh53JkRSUJ2ZjmTs0Bpgu
         7EoJmDREdxgCPySnOPQDbvuMwpqP1IQfAPKtZ/mL+vSLRmoLCXTPNp7Uc73bk4gKuyxp
         2pGS3MTyXT/gJklr6xbnCKC1AoZlck4rsvaYrds5ASUWYLoed2lBL4GmNThEsW9S2sKq
         ljBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353903; x=1757958703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G8OjR9ssKy/HeocTqhx3l5d0C6Xda9h262DRWrvvKQ=;
        b=LXin7/SXs8kj+T2dye0Prv8HTkkVh+xGp3TnU1sHpZsdQixzyTsEmLoyZ+oXqlHFLm
         0eDsn5Q68BuYUVPHsKYtjmI7UuQ31/YQa+FaK0L7ygqOTWO8o/TszBlu+I8Es66WuTW8
         96meLb3ioNQi2VODZbBC7odT0Kr2OB+AuO1OllxFRTKypvjOi8COUIyczK/6E/kR92J4
         FTJDUjRfIpNLdnD6j7QX6DN/aNavbTNpoPzPR/oeqWpZpHI9XpAGWyP4eSTf+pZf/EvP
         zpUKxBJTdGE2PnhRT5u5zJQQmGsh8FjjbcyWbcjiVjXQHrCLo//aOdM0Kn9hamOU7S5z
         1hJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPJ+UDHwhB3piCv2SjTPG1YQm1jv5QSEY3/cyiGS73cybfF3kOYb9ABFoH3b5Pcqq0xy19ldfVQVPNtlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+0rC2AyNIV3rjFh5AR6y84fv4v+55EIW9Mz5NTIjwbsVUXfo
	aAN6/ePnH/9fTlUCpYjN0HYS1Ol/e5E8Ixnqa1lus53twZ1wrsZ9UaB+SLrtpdWEfXB3fs1vAwn
	E+8i8VqdcKoxov6nc17U64jXXLQUJUYHVUtZ8SUuv
X-Gm-Gg: ASbGncs3W5Rfk7kuKwJ2TEJ185uKRlWxiRPbzWBjuVZ8PXRbLGTcDlb5PamKLzruy2Y
	tCjiXZtCGT+hzIISdbrOONAZ6zRh+5IGqcn3T78kMZguLtbDLTvXZmC8iECHYx9w+oQIZ8kasvQ
	swdAsOM1or0W1yKczk5nf4UW3rTqEgzNu1IzrAWgY5UcxWWGu4PUXizwj5S1f+t/W1MFt38Sd3f
	9wzSblWskYpdJGXJo/URwE=
X-Google-Smtp-Source: AGHT+IFX5M5+t7hmlxY9Bks+Ly9Dc9jsstbdD0XJ6NCNG5zc5agHlOjwp6nPJ4I+6VcViwGGr1N8NMZ0XWuJy7AaxH4=
X-Received: by 2002:a05:622a:d0:b0:4b3:50ee:579e with SMTP id
 d75a77b69052e-4b5f839899fmr9996781cf.11.1757353902829; Mon, 08 Sep 2025
 10:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755190013.git.pyyjason@gmail.com> <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com> <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka> <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
 <CAJuCfpFynEuwBSu28UiRDjWrayN-raX4Nqqh283MwRoJLi8bMQ@mail.gmail.com> <uoyjzkybkqd3wkvauofmorv72gnjisoq3owvijsezpt3wbrazz@at562ngtvszd>
In-Reply-To: <uoyjzkybkqd3wkvauofmorv72gnjisoq3owvijsezpt3wbrazz@at562ngtvszd>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Sep 2025 10:51:30 -0700
X-Gm-Features: AS18NWDsU1J1RP4dbV6eRyI9elf2CPlWHKgnI901gTzxBYcnOYe7IoD0JikeTzY
Message-ID: <CAJuCfpG17E_yoZeqEDrN0PFn8UBKqiGT28KDwEDmBm6byFje-Q@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Yueyang Pan <pyyjason@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sourav Panda <souravpanda@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:49=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Sep 08, 2025 at 10:47:06AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > I think that got the memcg people looking at ways to make the account=
ing
> > > cheaper, but I'm not sure if anything landed from that.
> >
> > Yes, Roman landed a series of changes reducing the memcg accounting ove=
rhead.
>
> Do you know offhand how big that was?

I'll need to dig it up but it was still much higher than memory profiling.

