Return-Path: <linux-kernel+bounces-853239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085BBDAFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C5F8356425
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88429B200;
	Tue, 14 Oct 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ppx2mzVn"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499D23D7EF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468645; cv=none; b=b0F8uzzPsaHKkMv87ErIpz/Vsa6xr+CWLLs6I6dlYf7Ve7P3t/1haydrlZazo4p1SOKN2CV6k7PjTAokeOgIeCo5ubJsIbdEP3umiRc9V6vQwxzQqwjenu9VtmeQZgaCOo6h4SB+HVVbSIluZzCGssfUw9Nend76tKutZhkfqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468645; c=relaxed/simple;
	bh=5y68QruZPAM2nXoI+E7P7xRzvuupmLhKZeN/D7gAGiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4tA3Ed4g/9zMlO6vXIvJhabWUzX+WL+3tT0mFJEJrHSUO3Lss8rrCXBVnF7oQMqP4lTutfHV4ek1FDVny3VOPFMke3cR7vDp5a5iCbZN9hGSPtT88J3zMGYyd8MBDY+ML85zmKJHN6lVjPlAF4vrIcTUyhUbGgGsoZwN7ozKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ppx2mzVn; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430a0a715f9so53845ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760468642; x=1761073442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3xKBu+Miamd+V4YG8p75v/z/lqDKmiLl9I4U7VNKAE=;
        b=Ppx2mzVnPLeu4TFcFXZxN0nE6DjB8K/K1QQE12e5N8lVuAsSTQ6mdCuaEldl/dS2tb
         CQbvILd4J+uHmy/Iv3R7CcOMcuuo8n+F4SQDrWBGY2DjfrDilmhSN+GsxFK19t+035yz
         PfeufSIrozS9/LTirFbmBG69l6B9/czimJMaLa5BKowMnFoTCRcowSlzYC9DSV+xKcAr
         CDzg7o1/QxvJF2QGrgd+8nw+KtEsQK4srGPjDfQDCkM94rKEcfT4fXCPY/h48hbk06ha
         6t1To4syX0lDPFid+GdE4ImzbftCTRm5Pr1IFh7DAq0Y4u+sQE78VWMPPDPIDAh/zVdB
         OTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468642; x=1761073442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3xKBu+Miamd+V4YG8p75v/z/lqDKmiLl9I4U7VNKAE=;
        b=Ea+NntLPRzYPDWS+4HJMyZH2iVSywkcjgrNpCi8GVUyWcRQso5ry5fArnmjwWUhRno
         6S1HM5xrZx8J22UoAz3+85owy/JsihQkYg0dbaVr8sjdvLPPytruGmM32z70hs6quQ6M
         9rtuB8R+/2sdqvr5EgUifUqebJ6qwvzSJQSfJiGhcsUYgiZFt+kFFdYr7VA7ZYJMXD8E
         0gFCik40tr8x+GK7AH6XurxO1zVeZQFdu5uqBQfW5B/wtBTVUuOY9Ig2t77SmSlfxggj
         B8Sr0UUv54ezgBPtFW/KL9NRZvGQNycTwUjdx5rfvYtUNLmetlWw8TtU7WZqIdh7s2OQ
         KWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9rQ8mxsfUfJwHRxS7+K5ZZUYndqwiRs43wVlYkck2b7VsZSAXK+MNABlNmxhgnQziuIHUX3FJYR9AnXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLSs7wRp8KgZREenRYkFsS1LuYGcjR5Yw/NgBobUnwxOB9HRk
	rUJsRkV4sJC3IpkQN4iiDxXe2288Hve47TmTP0vLoeZpjLAF/6Z64Zj4lgDbO5hdKCJYoLp0end
	tfEnThWK/0HkhuyACch0gRvHWBtKOE6YG49zoEomk
X-Gm-Gg: ASbGncuAcaRTF0abpPceJfKgk9hEMKje3Pk0rwgRaKmz9Hz5cW8HCftGjPFRz5KdOV3
	pDFXl8bPuMsrif+HGzKASitzbY8kpLLZV1tomKMZUAsL59l52ratK3KpvOGqJ2h37iQsxxZu5te
	LMNdK4U4TimSxQW/VWZ5oI1aDN7EWLxUV4NpZrZl9vkX/CKziTT+LiZLdduuqroiRzYhkEVOjwB
	JHau2U5xA6bdHfjgqsvaIOkWSImjf4r/QKEpa+dPCIgnV5TLRzEhQcfuumh5TY=
X-Google-Smtp-Source: AGHT+IGFq8+m5EUm1S0rfkHGcGMkfEEEniNyZUS3jih3A0xj2nWF9JKKfX2BM83QEzN490MbMoUDvrGaR7EKS8gi/HA=
X-Received: by 2002:a05:622a:6081:b0:4b7:9e3a:3804 with SMTP id
 d75a77b69052e-4e882f377e0mr272151cf.16.1760468641464; Tue, 14 Oct 2025
 12:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010210134.2066321-2-xur@google.com> <aOsO5gO+5/OkZXVn@rli9-mobl>
In-Reply-To: <aOsO5gO+5/OkZXVn@rli9-mobl>
From: Rong Xu <xur@google.com>
Date: Tue, 14 Oct 2025 12:03:49 -0700
X-Gm-Features: AS18NWAPmte4S6P8LMDWE8am8OtuITHNTNfP7cWAg9SzB0qhAN67sAjUYloyCJA
Message-ID: <CAF1bQ=QQQLp=m677dYGDwor=cbHR1JDeQuL92+MrZkQ-OQ_J3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: Disable AutoFDO and Propeller flags for
 kernel modules
To: kernel test robot <lkp@intel.com>
Cc: Alexey Gladkov <legion@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Bill Wendling <morbo@google.com>, Han Shen <shenhan@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Yabin Cui <yabinc@google.com>, Sriraman Tallam <tmsriram@google.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll filter -pie from vmlinux_o build (which produces a relocatable
object) in the new patch.

Thanks,

-Rong

On Sat, Oct 11, 2025 at 7:14=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on kees/for-next/kspp]
> [also build test ERROR on linus/master kees/for-next/pstore v6.17 next-20=
251010]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/xur-google-com/kbu=
ild-Disable-AutoFDO-and-Propeller-flags-for-kernel-modules/20251011-050345
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git fo=
r-next/kspp
> patch link:    https://lore.kernel.org/r/20251010210134.2066321-2-xur%40g=
oogle.com
> patch subject: [PATCH 2/4] kbuild: Disable AutoFDO and Propeller flags fo=
r kernel modules
> :::::: branch date: 26 hours ago
> :::::: commit date: 26 hours ago
> config: loongarch-defconfig (https://download.01.org/0day-ci/archive/2025=
1012/202510120709.Wx3q4Ppg-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd70=
8029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251012/202510120709.Wx3q4Ppg-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202510120709.Wx3q4Ppg-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: -r and -pie may not be used together
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

