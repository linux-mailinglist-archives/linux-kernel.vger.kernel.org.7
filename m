Return-Path: <linux-kernel+bounces-817332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43705B580E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DF41B20562
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85934575A;
	Mon, 15 Sep 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj7EI87k"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC921A421
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950108; cv=none; b=tpQP16gu01ffTfc0PzjP9OyTQH+XFLZ5DWs5BhXdwxpfFSNzvxU05Xt27OrjujmuGJG8bYwemq086Buy9p4zGhwVNfcKbTQOhXX6DLTb5DiJdQL+QugI8GGxOEYU1CU1Tmfgpu2rFIARQTJyEZRARZU/rrcS+63lcVkuVau+Xt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950108; c=relaxed/simple;
	bh=CO5Kbl3OXWgTC8LZPs393tbcpXI0rUDxrixuD8t8JhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1iYteArDB/IOQ6slET2k9fUadt4nTgymi3zHuw8eBzaz+0tiuo68vLlGAvSJtHRLQLSQq3Dt46qY+y0cG1KpTi3xncP06c2h7pMmPzsO85XXjNTHCuF7i5PdVVhbRboHcbWoc4/iI/NsZsusGXh3TYTVyNZK6LtmxYBsEvK0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj7EI87k; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea3f9e9f782so1767621276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950106; x=1758554906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiClITBt+CyIUIsQX+fBoErmvovdqrPoDXurgutbUMA=;
        b=Sj7EI87kLFVNCajnfzgyFIED1NuXECW75e9o9rBgwEXMnKHgteSucvbT3WlkKLc71Y
         BxDpvFxnOvCNlcI2dzjEW180atC4cc8DE0NEtf9A3K10V3H6xNqDN6NP7F130ONjOKv0
         jdJ1LO9DkJZJGxawpuwlbY2YguQ6sX2PNdKQw1Op/etm162y/LyY6VtSH0gSZq09aZxo
         4V2K76NM/qLwaBPiQ8oZ+YkJi94uaJIxXqpo4zzu8sLBqD1Q220vD1OFUNrx92oHlODb
         m/vfboqTDuHWqJoVwRuWgCUrdLuJUYe2/TvU1jdfK7ku6Z5wqxrWuFDPa6sukIUO1GI1
         AsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950106; x=1758554906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiClITBt+CyIUIsQX+fBoErmvovdqrPoDXurgutbUMA=;
        b=JOZSvWxMG9yH4KtUuo5drBiF5u/3DsDviCqHDUUVomihQYYt5s/RQpXy+0n8x/Pohk
         6CMyZUjwPXfNLxg0Rf23tIynqorNTCB0ENfrc2/SYAqvBMUx6QRmW4mCiopE0ErVoUFe
         /cYeys5J5u2awG4sXnDuM2bNzg3q1OKeKKkOPrIRXAhnsAUMA7I86MjNNaa/bhAlpaav
         lKEgTR1sVO6PBTUTJi9TrjfegAe5ucvE1OgSMGy3HjmB1B5w9gOIhgoWXIAWQWk/bB/+
         x9GA6TXgJ75tGAWoTvTx+zfDFDrU+fjL2HsbIXgsi4Qy+i2qjIg/IFRlcH3h/bADNwOk
         j+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUI7pTCvtG0qMjTYYcM6Zr2EHTbGtSVan+pxaeXrJ59xc30Et4psl9XO/v4NL0tElLRyRnGcq0WHhHZuSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PoYnd+dZStKPle2xDLaysjZdWp/Fu4p0OGmlIUzcb0ziWoxs
	6/Auc+NgGpwRbDqolgstUvVuMUHfC+/nka/T2XQFVpKAd5h1Jk53AAM6
X-Gm-Gg: ASbGncvWxzUdNjPGetAc3st1V2+SliJgXnXoQSqBzlKV8xbvlOixkvqlsnyODpBm3JN
	ImsY8lYqKjWjGLuLQX4arhDikar7l7x2nMmKCK5sZCWbAq/ZOjd2c19VsHC9Il9o/3YL/UdoIke
	HAbfxgP4B4Bv521BficDlG8hSJdvEZ4Mbijelz7tmpOp5HcnjerCQTKZALZ3T7/oNKmwJzw4QnU
	95uNxSxEf/zrUlT82aq7QMLWdHUO344RhVhJMXV3EBzcEGLWKGB4ewIAxd05n/N+QgoENzcCFop
	zpZUPkz93TidsLA4S1+U+W+ZJPxJFtjD1f/yHJ6C30lMBKN1IPyvt2GG4+cKV7wDlRcYe1Fd2ki
	PnUchHs5Q5yrUkPnS47qastxMfuVyD+//ADhgsuPeFutrx9n+Po5i9A==
X-Google-Smtp-Source: AGHT+IHLKoGjQLIXfH7bFgayvLYdDgcTU1x7NMyUkMTH4LT0uz24DJ/2fWVkpnpcFtkckwGwJRVnpg==
X-Received: by 2002:a53:cb41:0:b0:612:891a:9ecc with SMTP id 956f58d0204a3-627202230a3mr8701789d50.9.1757950105297;
        Mon, 15 Sep 2025 08:28:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3edad05c0sm2586944276.10.2025.09.15.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:28:24 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
Date: Mon, 15 Sep 2025 08:28:18 -0700
Message-ID: <20250915152823.1605591-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJnrk1ZHdt-sj4n2VigW6u6bnd-gX47WpUfaHDxqN1BH4JGUXw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 08:25:40 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> On Mon, Sep 15, 2025 at 8:08 AM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:
> >
> > > Misc fixes and improvements for DAMON that are not critical and
> > > therefore aims to be merged into Linux 6.18-rc1.
> > >
> > > The first patch improves DAMON's age counting for nr_accesses zero
> > > to/from non-zero changes.
> > >
> > > The second patch fixes an initial DAMOS apply interval delay issue that
> > > is not realistic but still could happen on an odd setup.
> > >
> > > The third patch fixes wrongly written code that doesn't cause any real
> > > problem but could make code review confusing.
> > >
> > > The fourth and the fifth patches update DAMON community meetup
> > > description and DAMON user-space tool example command for DAMOS usage,
> > > respectively.
> > >
> > > Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> > > just DAMON.
> >
> > Hi SJ,
> >
> > I was unable to find this sixth patch on the mailing list. Maybe it got dropped
> > somewhere? : -)
> 
> I'm seeing it show up for me, this is the link I'm looking at
> https://lore.kernel.org/all/20250915015807.101505-7-sj@kernel.org/

Hi Joanne,

Thanks, it seems like linux-mm wasn't CCed on the 6th patch. I should have
checked in /all! Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

