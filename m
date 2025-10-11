Return-Path: <linux-kernel+bounces-849315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131CEBCFCE8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA263BAECC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961C242D7F;
	Sat, 11 Oct 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wW/lyZVm"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADA2356D9
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760219260; cv=none; b=h29QlKTGVj1lRza7jXApclbONQdwoc556dOndQ54H2T5D3oCg8YGMIXRRQEnFT9mv+RD5CGyxg6eXj5MamCTnVjXKCzb1Kx7KzPQgIPKV038LbOyQqqYwnoeJeSTYo5R54DJHsFMUGW84S1JWW834SAOWzlhjgtJVuU/fpKd5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760219260; c=relaxed/simple;
	bh=k3isVL9WAak5fCunvMYwDOeBvT+ja7+ZdbuXDmgU/9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAMjPkHfnYCMearWxz+hwhGThudcbnhCtlJJHNKlXaQsW/c6EYSwIrFiYtQPfTb+ZYXEPWmthO+al2dNiV9aG0SaAiCS1hDleBZL5Y2nTjzNl4eUg0mTCAUq1I2AKnjQRuNsUStuqKdsdcsuSltB6i7W/Iy8rgweKb7DcDaetIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wW/lyZVm; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42d7d0c58f9so212815ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760219256; x=1760824056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edG0NGbrr85u0FtLnw6wkiSc/A0YKw/98Yub9scsGaw=;
        b=wW/lyZVm5AupW76q7nFiypqNoSUrP4wIU3w7OvjfmDdQ4fxCmjZdDXCpViF/jAej0+
         6MJ3/SIELl1MOxVr7OCXpfSJdUylm7KtB9q4y8l39K9EMDWznAvqnroP6ZZ+YYWc2/qC
         lAuoQQb62hLzW76krlC3mlpm3a6yOtEwVLJxKdxYFJb8X3ZD1hQlTtuBBq5WwrAeNm8d
         vqeLzRjjOGTLyAqyoBgp+N3Akf/tk14txFn8+UsGLh8Dc81fv0NtYRmZggJCfAMtauod
         V6ogBG/TSn06OrxgmIaDlk9BW6bVmGgbpXXiW8toa0A9D/efMEsCA89XAytR2roqBYCa
         0oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760219256; x=1760824056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edG0NGbrr85u0FtLnw6wkiSc/A0YKw/98Yub9scsGaw=;
        b=TCChqRCq+iMw2ADC/8YmVcdM4IwGfoKAkOHrsjGFyJjCxDYsD+GwvCgyQ1xAqbVWUa
         S4HSX6agAZpv6WWBxvAgkcWObyKPl5OFo2eqX9Eyy01maWK7mpXTEWddZmYZ8fL34tK5
         B45f/e1UN5JgapqrTPHC4CeTX0lxZwhr5AKpkYAilmKp6hUY8DIFciVzPiTJ2ID5fS9P
         OgstHJVp30xkowrAm3T61WjVeIfPdmT3r2/oCtIWG2PBNWVSi1Lg8O1dNpdbPbBGw8Tt
         Qu4ULTSqMPACNNkhdsGH9yTr81G+31XsiZIXvBzHjnG0oJocBygg0a2NIiP/ZwXs8FO/
         18yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAIbaiLoDCUbf/9zdSQZYVKNaG5W+L0Xds/dfBAFuGvjZba+QUBwLaqAtCaTk1F+/ClICwrpmUBkz/UUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQuM380p9TDUy8XMYFMEP7Ae4XsbVQRI5sfqluyn6WyIUy2xH
	g2qxiawSbcPM5Pghcdq+IZugZVDxS1YdqzQbqlZgmMXxBhsOMQWZemm9Vro/YdQVUcnjKjM+gZO
	wcYVGYqB83qQFLGHJGlL++lAAHRzGkwRexEiBkRiF
X-Gm-Gg: ASbGnctOkkMnr/pSj7OuCbU2zEobg8xVjzYGxBNhdTRy9ILJeDrExNaOuVN4xU/8xif
	aA98RPf0st926gE5vld3pBZU5SsctP86I37BldGD82/O07VcADs5BeXFzsPdhmfCWGVzppL1VE3
	hWpJIvq+3AyKLwcwaxCynsVaxy+P1hQHRCraLoC/CAn7I/LOoZJCRNAtH13tftc9WsN0qBUnFz7
	8PNO3QnnnOZMkjwBpxoGKEOQhgUxCY=
X-Google-Smtp-Source: AGHT+IFFaqWGr6zppAMQlQaEOPe0SaZYdxA84DzbcLcqHShRGwrEbPejok43SDIXTETu3rLoVc/dTHFUc/Jq0m7QB2s=
X-Received: by 2002:a05:622a:808d:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4e6eaeaaf5dmr21268691cf.3.1760219255521; Sat, 11 Oct 2025
 14:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-6-surenb@google.com> <202510111059.aKceYLLH-lkp@intel.com>
In-Reply-To: <202510111059.aKceYLLH-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 11 Oct 2025 14:47:24 -0700
X-Gm-Features: AS18NWDufVi4cEGnv1sKGIKBBNV8Et6IGfR8sPmz2Ei8b77bsJTwPJgzvhpHvVI
Message-ID: <CAJuCfpHKr392MiS=gnjpomwdzTnesgBpXSkVk5h87wLJwo7qVQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] mm/tests: add cleancache kunit test
To: kernel test robot <lkp@intel.com>
Cc: akpm@linux-foundation.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, willy@infradead.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 7:58=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Suren,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 70478cb9da6fc4e7b987219173ba1681d5f7dd3d]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan=
/mm-implement-cleancache/20251010-134501
> base:   70478cb9da6fc4e7b987219173ba1681d5f7dd3d
> patch link:    https://lore.kernel.org/r/20251010011951.2136980-6-surenb%=
40google.com
> patch subject: [PATCH 5/8] mm/tests: add cleancache kunit test
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/2=
0251011/202510111059.aKceYLLH-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd70=
8029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251011/202510111059.aKceYLLH-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510111059.aKceYLLH-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> mm/tests/cleancache_kunit.c:358:6: warning: variable 'unused' set but =
not used [-Wunused-but-set-variable]
>      358 |         int unused =3D 0;
>          |             ^
>    1 warning generated.

Right, I'll remove it.

>
>
> vim +/unused +358 mm/tests/cleancache_kunit.c
>
>    353
>    354  static void cleancache_backend_api_test(struct kunit *test)
>    355  {
>    356          struct folio *folio;
>    357          LIST_HEAD(folios);
>  > 358          int unused =3D 0;
>    359          int used =3D 0;
>    360
>    361          /* Store inode folios into cleancache */
>    362          fill_cleancache(test);
>    363
>    364          /* Get all donated folios back */
>    365          for (int fidx =3D 0; fidx < FOLIO_COUNT; fidx++) {
>    366                  KUNIT_EXPECT_EQ(test, cleancache_backend_get_foli=
o(test_data.pool_id,
>    367                                                  test_data.pool_fo=
lios[fidx]),  0);
>    368                  set_page_refcounted(&test_data.pool_folios[fidx]-=
>page);
>    369          }
>    370
>    371          /* Try putting a refcounted folio */
>    372          KUNIT_EXPECT_NE(test, cleancache_backend_put_folio(test_d=
ata.pool_id,
>    373                                          test_data.pool_folios[0])=
, 0);
>    374
>    375          /* Put some of the folios back into cleancache */
>    376          for (int fidx =3D 0; fidx < FOLIOS_PER_INODE; fidx++) {
>    377                  folio_ref_freeze(test_data.pool_folios[fidx], 1);
>    378                  KUNIT_EXPECT_EQ(test, cleancache_backend_put_foli=
o(test_data.pool_id,
>    379                                                  test_data.pool_fo=
lios[fidx]), 0);
>    380          }
>    381
>    382          /* Put the rest back into cleancache but keep half of fol=
ios still refcounted */
>    383          for (int fidx =3D FOLIOS_PER_INODE; fidx < FOLIO_COUNT; f=
idx++) {
>    384                  if (fidx % 2) {
>    385                          folio_ref_freeze(test_data.pool_folios[fi=
dx], 1);
>    386                          unused++;
>    387                  } else {
>    388                          used++;
>    389                  }
>    390                  list_add(&test_data.pool_folios[fidx]->lru, &foli=
os);
>    391          }
>    392          KUNIT_EXPECT_NE(test, cleancache_backend_put_folios(test_=
data.pool_id,
>    393                                          &folios), 0);
>    394          /* Used folios should be still in the list */
>    395          KUNIT_EXPECT_EQ(test, list_count_nodes(&folios), used);
>    396
>    397          /* Release refcounts and put the remaining folios into cl=
eancache */
>    398          list_for_each_entry(folio, &folios, lru)
>    399                  folio_ref_freeze(folio, 1);
>    400          KUNIT_EXPECT_EQ(test, cleancache_backend_put_folios(test_=
data.pool_id,
>    401                                          &folios), 0);
>    402          KUNIT_EXPECT_TRUE(test, list_empty(&folios));
>    403  }
>    404
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

