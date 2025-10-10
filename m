Return-Path: <linux-kernel+bounces-848820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD3BCEA26
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31CA44FF323
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDE303A2D;
	Fri, 10 Oct 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hrs+fymx"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370A303A32
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132587; cv=none; b=uISUZmCwuHleygSXNFLCCfiqtcwCgngQp3/z3km4BvSLLyubWNNMhkHbU4Fp7kPIBfb6lNHSsmlWcegpfJ/6Q4VlJL8x8/PWdIJ6e6dHY+JXtiEaOEdS0L36t/u8c0a6FYe+zNFdpcXHElS1a+TG5oPRO6cgQ74HaNg+E5B8oXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132587; c=relaxed/simple;
	bh=fwjcVIiQrqDfhLwRQIz7WRB+b/8kgGHlcJpHFwbz7Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw8hRqH4URJaoH+sAYOTQXkJoBW0ljm9Wrnx2xt3CcFDPJ6MAP3uchm8AKdkFnAUNJOqONJdvksdvmVLk0B3rrSHtQeirCGK3gWxNjDBXWeNNTGt6hTOHhfW8aCPk0iOkGOogWTZsq0sSWawVw0wU9K2fPlngYQrJvub5LWzBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hrs+fymx; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42f8e736ecaso175545ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760132585; x=1760737385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTEdXIM9TCGjTEQmnu4q5KwtmIgjop26pFrSD5vSjaM=;
        b=Hrs+fymxA1ax0L/3DkBlgZdq6Y+stH6GEYaxf1if1c1ZwFFqH9JjdTgP9Bd3QSR6lr
         sAZcRQlRmQIsjz/Aor0xJHN/RofrOnF9utufRxb5Mulo8qFzQ4BWPh8+rk6twYYotY66
         zttljJjUkVU7T4OzlB2inCcJ/frOvM+CtxGpACv0A8uYbBR8n6yJYS8SmyP9St9Gr8Ch
         78Cjklied+CaueJ5iXuCt5l66sJj/9NcpEcj7TERVEg0v80punhmtDjJMQPLj2DlAicj
         XWiOLdBezXwHfL0Av7BTtwlY0e6gvuj7mEs3iXbJkmYL1LuyfTZdzk+Gx8K3ECF5mYKp
         U63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132585; x=1760737385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTEdXIM9TCGjTEQmnu4q5KwtmIgjop26pFrSD5vSjaM=;
        b=UA5JyRK2gv+YVP/2lEEmb9T1QcnHDmBmink0SuySntvWmLH6AuW4vyIXDfQKLkXIFb
         2sXobZO4YVeZcv2jR+Y9hPbr9Sot4S+mZVw1/qJyQzbuNetlEsY1IzkwaZLJSNoIfKXx
         Eib4+2ITRta+pG6DBN2xcZojqiwYqVQanncVFZmmXxkn63sxOMwgHPbMwl2knxZJWdsu
         0hhOO17pDXwB2i7IIX/peM7Xvq8os+wcyinZgYS2DAuDG/7ipmEW0lIs2xEFyssSgCJh
         bb1GdjCocjRq0z4YkaS9Q+Wt3MQbwTY9hW1Y+qWDN0IFBsPJx/NXZjhUp59yklH8PIpC
         Km6g==
X-Forwarded-Encrypted: i=1; AJvYcCXMeCSp9jRXB9NMN6cMyhod9dz146l+mgR/BkY9b4EEoMSnO1rI4WCW0jP4EFsapxOOrOJwCYRyFzHgdso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIUbB0dzazvxthW8vtXZfbb573BPr82LxCzqU0WXjxRSP973Q
	u6S9idUAYmHRkuJidX3evOOEhAVmGck3r7hfZDrb/QXCpvfxn1wwZHrrP86DGApbEJ9NHGOVwwi
	D1FMV9TzX9D06F0q2wCVbWGmYo8HvtJPLoCdZIwE3
X-Gm-Gg: ASbGncv8EAKSsXzhokeLNruJtNHBoPsOo4y4lYuboqgZMjKOYD/RJDcqvQTjd5gYY2a
	EDVm6r3M0XOxNYxCbpv9WieMUZrqIM57L9ELkHAv21PMVnLjLGhTgNe9UQUX1wfkICubSAmVPAz
	1Y8coXaIc/0q9lD3EJ/3ZvLtEhsJnwGBAm+a9upltgSPTWei7epA1iPD4RmyPttQ2adkTi2pRXT
	NO8bRZVBXcMw6rRA9yp1zfx3Z404Jf+hwPakjiFWw==
X-Google-Smtp-Source: AGHT+IFYO/m3ZokqgLgfZFSBuJ8vQyfm/3HMocIoflB016BCepHu8r9v6klK4bxjJEyMNFam7jZJfb7DI/PhTm+ebno=
X-Received: by 2002:a05:622a:348:b0:4b7:a274:d54b with SMTP id
 d75a77b69052e-4e6eac0ca05mr25279901cf.12.1760132584434; Fri, 10 Oct 2025
 14:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-2-surenb@google.com> <202510110501.92Srmvgx-lkp@intel.com>
In-Reply-To: <202510110501.92Srmvgx-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 14:42:53 -0700
X-Gm-Features: AS18NWCwzOb_Fs69JrpmWw3AQRynK9NMKzj3B1QDKKaakj7u0qI0Eoy3eq_sHTw
Message-ID: <CAJuCfpEa2rdLuu81SJ807M1vuGd1eY4GMO2CrrfU8gY=VRtPcA@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
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

On Fri, Oct 10, 2025 at 2:18=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Suren,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 70478cb9da6fc4e7b987219173ba1681d5f7dd3d]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan=
/mm-implement-cleancache/20251010-134501
> base:   70478cb9da6fc4e7b987219173ba1681d5f7dd3d
> patch link:    https://lore.kernel.org/r/20251010011951.2136980-2-surenb%=
40google.com
> patch subject: [PATCH 1/8] mm: implement cleancache
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/2=
0251011/202510110501.92Srmvgx-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd70=
8029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251011/202510110501.92Srmvgx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510110501.92Srmvgx-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> mm/cleancache.c:119:13: error: casting from randomized structure point=
er type 'struct address_space *' to 'struct cleancache_inode *'
>      119 |         *ccinode =3D (struct cleancache_inode *)folio->mapping=
;
>          |                    ^
>    1 error generated.

Matthew's suggestion to use unions for members with multiple uses will
remove the need for typecasting and should solve this issue.

>
>
> vim +119 mm/cleancache.c
>
>    113
>    114  static void folio_attachment(struct folio *folio, struct cleancac=
he_inode **ccinode,
>    115                               unsigned long *offset)
>    116  {
>    117          lockdep_assert_held(&(folio_pool(folio)->lock));
>    118
>  > 119          *ccinode =3D (struct cleancache_inode *)folio->mapping;
>    120          *offset =3D folio->index;
>    121  }
>    122
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

