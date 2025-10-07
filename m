Return-Path: <linux-kernel+bounces-844513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C727BC21CE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E230188BFCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631082E7BDD;
	Tue,  7 Oct 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AElYYsOh"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067111712
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854434; cv=none; b=N5fjOiN0BN23SpzOTsrUHBORjXSZf6/msFMzv3FEaxcAz60iBmaTrXseC+3+cC3fQBEJrAMIh1lqzjyOatIi7MoAsCKkeryXS+Z5PpY14Nzt6xhQWLS4RQ3Kh/+wAGY4xuRd0QR+ML56skbZx3otViaGrQhO+qT+XCW2SLhTTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854434; c=relaxed/simple;
	bh=ffdQ3x2Q74v3VCd2+CYlW5xb0s3Z1kjp9on1ibT+iSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Suyfr4g9KL5YxTwtU3V/c3pxXBivCo351t/Gq4aMch0LxSBDOoGMHPFv4cF+ZJcLZGA74PP4n8Qml00FTejWI7mkBWQUVJQvGTefqBssU5qzv1m1ADRRrsOETlOHIQ1gzwFCHJfWqJgNT99ASVNC1zWIxEMn4VYeH3oou65wAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AElYYsOh; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-938bf212b72so228997939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759854431; x=1760459231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBD2hSu0l0klHe2PgM26i3kvAILb+lcpLzVDDzltvlo=;
        b=AElYYsOh5LkGgAQisYEdTwuZtPulVmji31w6KJlAPOf0c3v+tiKmMUSmOWB8dKkKCe
         FAgeVzP222q3JDi4M4vlVipYcg4aIm4YjDRbAdUwdXpV2xi31BRSUK62bA/UlvmEFIUh
         7Zs1AS3J5i5S53r+2EPfq6zOVY3mSlsQJHv6f7fwQeDvVXaKOcXy+vMZqhEFjXHi6LnJ
         CFBG7IkloR6Ohz138B91H6ktipvMTHMK8/Re61+R9Nxdqrx2d2/EayqhGgVyY0kB6Z3Q
         RwnpZnyvxhJ2tKZ/rZ8cbtvN+4cYMfP0EnPiSasBh0xFuT5plf0Rqk64PpIw6Wd0eA2+
         LPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854431; x=1760459231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBD2hSu0l0klHe2PgM26i3kvAILb+lcpLzVDDzltvlo=;
        b=LZyCA+za974+ug3ZtjjrkjV5ADEQ0fP5jJoKiotUya40Vu3VZjGaEkmaeCbjo3tgQC
         Ct/+mDnlTVarA9fK40QM5Jrx4ArsCWdhnu/nR+yLe9Gjy3Na+gmG3YtNnYHyxBkPxJ1Z
         7kpHMvHeQTiAAKfOFGilmFb6vlScjJmCiwQgZphMtcuCcS2cVf4bhiRtUEdmqWsbN5eS
         8Kfa2Y4ZLG+OQbaPqFkddm0oniJqDwVDfhyUUKhRdgfPlaz4uV8czpuO309p3mFQ+bk7
         dGP2pJcVlzeIlu8Smr4TSr76kYzQ4Cum7V52KUvV4MZcHn097njUGZcJIjlBRC4Jk12G
         C/eg==
X-Forwarded-Encrypted: i=1; AJvYcCWZjHmPvWBiPd60CXzA55zs6du71GMS5UdgkA/hng2OlhUS3HwDrJF65wUAIb0SSQo5aitDP76RYsfJnoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kpwvy/FyXFlBO6xM69+mdfgfRLS5oCFMazsMZp9KQ7ehaOIV
	tt2L0iIeih5+9SHPXFbh2osj2xaaIcbECrZfebGqIpuSaJwTSrXX2grD5S4s3ABoIL02LNjb6W7
	fG71doxUFI/TmKr5tiVzsGKM7+qRe5fc=
X-Gm-Gg: ASbGncuWwbLEAdr4TdLOMj7RcyFn2zFILmgR/6phUARHmGuQputg4N7wTRhcM4i7b0E
	enUtfmGYKLTHpXXtB6EaPCpYS2QaskZNvenkwZKXlZox2TLD7eu8xOzp+9GnGd8/w2IRStlIrVm
	xPdxa87bOyvZroVtD4K3oDp9MBifqbHmHcMQlWfNfsiUsiOI9g/Ggs9w8BUq9uQ+N8K5jSRo6KE
	N/CnLafHKSpbzqyaA34cTKXQ7eF
X-Google-Smtp-Source: AGHT+IGLCFTglTAa2kP1ck6r7iG/OBxuOc/X5vnBoy2Ox8YpkFznUIu4nAdIvA5gwoNVKy9bdZ/E6m0Pbw/Ia4pBasM=
X-Received: by 2002:a05:6e02:2581:b0:426:e20b:f5d4 with SMTP id
 e9e14a558f8ab-42e7ad16b0bmr217493585ab.10.1759854431265; Tue, 07 Oct 2025
 09:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
In-Reply-To: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Oct 2025 09:26:59 -0700
X-Gm-Features: AS18NWDyUXxAHm2OhgOIQBVisQRhBDWipv0GA7qDF0rBOZJ41WWj-kV3nnRnazA
Message-ID: <CAKEwX=O2CMnufzuU7n32BD+SD5Oapmct=YGUUQFZ=2w+u2kGvA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 6:25=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> wro=
te:
>
> __mlock_folio() does not move folio to unevicable LRU, when
> folio_activate() removes folio from LRU.
>
> To prevent this case also check for folio_test_mlocked() in
> folio_mark_accessed(). If folio is not yet marked as unevictable, but
> already marked as mlocked, then skip folio_activate() call to allow
> __mlock_folio() to make all necessary updates. It should be safe to skip
> folio_activate() here, because mlocked folio should end up in
> unevictable LRU eventually anyway.
>
> To observe the problem mmap() and mlock() big file and check Unevictable
> and Mlocked values from /proc/meminfo. On freshly booted system without
> any other mlocked memory we expect them to match or be quite close.
>
> See below for more detailed reproduction steps. Source code of stat.c is
> available at [1].
>
>   $ head -c 8G < /dev/urandom > /tmp/random.bin
>
>   $ cc -pedantic -Wall -std=3Dc99 stat.c -O3 -o /tmp/stat
>   $ /tmp/stat
>   Unevictable:     8389668 kB
>   Mlocked:         8389700 kB
>
>   Need to run binary twice. Problem does not reproduce on the first run,
>   but always reproduces on the second run.
>
>   $ /tmp/stat
>   Unevictable:     5374676 kB
>   Mlocked:         8389332 kB
>
> [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
>
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

