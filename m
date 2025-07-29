Return-Path: <linux-kernel+bounces-750006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47EAB155D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5BD3AAD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59428540B;
	Tue, 29 Jul 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWvamWEb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B025281526
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830980; cv=none; b=QUayjaXSYZQFqjT1E7tDHg8GDf9U9vlQUk+PNylzQ579GrNJAyk6oS+5JFLI62odVbnRCfAQ71A/E9Aie6RixI/8ZlcV66MZUIizbvFMd66e9nyZVf+s5l9JAkC+3HiZide9gbGCLnUYOHl17lrReOzuGponJ+Q2246YY9bhtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830980; c=relaxed/simple;
	bh=89oO5yBwKXogRnHzKM7W3myuaKHzc+gF2Cis+Twd0oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8VbasOPDHCm++DsivrveEeU7vDd2noBa6Nb7+tLoWeaQggp+10Lgp/gjOr+Pxu++pWQsya4tk3xKjKNxvEjXymbNez3Hesp9LHvrY6evy9vDKgm7zlBjA3k1lxE9xMl6HC6WWpCUji1OxOuO4VcRpYBBSDU1Mz/Pr6jTEsEbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWvamWEb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so1208795066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753830977; x=1754435777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7MELq/l6D9hMY/qV+9sozKMnnecRDmbGpZ3SGFvMEw=;
        b=VWvamWEbifZIHSofvr8JzqF2g6a+eRfmDp/q7kNPgLr01QGm7lt09yI8zmy1+XjP8c
         qUHrvMSSRSO7W9XMaWIXeGId0knoA8kC8deeXWFQKSuzS8pCXBRHVE9RIwgaZUenFnR9
         QiWQcuSauhtW3Bb+k4GxzXqxb7fSExxcfQ8Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753830977; x=1754435777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7MELq/l6D9hMY/qV+9sozKMnnecRDmbGpZ3SGFvMEw=;
        b=mii2YC1OquVEN30x5rdkXLH1KmEvziM6uLqnsOebGB/yPGZ4M2Y9+rx3PlRK65yCpC
         29BDOpM6bE/EfNUT9eiHGQybU2yGvsJg7LcGzidvEyzIEbnNwU2CZGpyxNDVnPHIcGSA
         SuZ4j0eDKJbqw8I7UlmALOkXYipFpt+kK04aNCeRfccZbCRj/+Z7cIKElmSyX9ZnE+FE
         JvJ0j5+bwsI07jYo/UtYOEQ/2EOAwHituRHYJeoVj8KAx3v4QOnkPdP46XdhjViM514M
         UIGfF/FG6gn8jbCT8GF4D0H0RoUvtvN6w0XxKI3oYis3rARsAMtqv24TXgfTG7OBZvTN
         6U4g==
X-Forwarded-Encrypted: i=1; AJvYcCVdVwBxLnXODuBwRz7gkFAoDVmYhw31M85HlDtMPBbDgJqZxsnVBVmAXIbAvEE1OyFPXVlNpXzaRmeHUu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rPRKr/pTKm6F/Pk3SmduDViL7qGikrwMqWXmD6zVbVZhpfPB
	aa9cuBQYnpFP5csNdhMjgXjhQlVq639xJqJEdaHmqB8rfaKV4BMqkGd21IqR255Pktmj9T2JWiB
	mdTakdnY=
X-Gm-Gg: ASbGncvzfHdCGtS9tbFf6rC4Xr9Y321KwLR0Lu2SBAQBAhdv09xrGcjJV2yNPtlWvKE
	AGXbVDYxlPYPbdWNC9aQjTqNldSfOkD4p+kb2vVROqGU6otz3DGUKzleUko+nj9yz1uu3VUzFwj
	o7909DN+XoP47TeJhB9e1LXfCP6nilCItHd4l6Krhm7sJo+P5DApoFXyjieOEGtC0Uw2ETSOUEx
	3NGUV4r9Cz3V6T1nWkBanXRGVdDMJi4Hlfw/Nh7JKvPA1t5eIMjMbgYjRw/0ueKqSscBJDtT7Do
	TiB7J31BNYCwG/GpXWeOEZ8hAVOKytsQ775UIGfgFnIyDzStWNFStXdX9ulMgYfpqJL5KYJsEKL
	hfBswbWad8fY7FHx1Eo2QVJZkk2SYSnUUF8fkZDk5arpTwEcL2EUfmJyZi4XgYD5zSyjP9f0=
X-Google-Smtp-Source: AGHT+IFInoMBwIqBUZhUIs5x/cp3XCPB3naOAvQa7EkTlK6Z712mp2PRXQuKexo3tQuHqDOPuFr4pQ==
X-Received: by 2002:a17:907:9454:b0:add:f2c8:7d3f with SMTP id a640c23a62f3a-af8fd9873f1mr128226866b.33.1753830976749;
        Tue, 29 Jul 2025 16:16:16 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a1c32sm654979866b.55.2025.07.29.16.16.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 16:16:15 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so1282645a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:16:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ3H9M92t+x/uLreV0OqGLZtA5u4T+jwZZHLTYnV5wlXW6BHx8ti3pAkwrDupEBcZDA8bJ0EFFQHE5ki4=@vger.kernel.org
X-Received: by 2002:aa7:c558:0:b0:615:684c:c2d6 with SMTP id
 4fb4d7f45d1cf-615870b6891mr1084772a12.22.1753830974956; Tue, 29 Jul 2025
 16:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729224325.work.019-kees@kernel.org> <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>
In-Reply-To: <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 29 Jul 2025 16:15:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9qD2tY4+C9mjPviAZLHJ+Bix3KyBfKKYfYbP1XxnUVw@mail.gmail.com>
X-Gm-Features: Ac12FXwyykh4eQS4aG6NfTaU_pPeuzIhKc2c8ZPYUithrQ3wXc60zMPaSd8W1iw
Message-ID: <CAHk-=wh9qD2tY4+C9mjPviAZLHJ+Bix3KyBfKKYfYbP1XxnUVw@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, 
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, "Kirill A . Shutemov" <kas@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Michael Kelley <mhklinux@outlook.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 16:01, Marco Elver <elver@google.com> wrote:
>
> I think this belongs into compiler-clang.h, we've typically refrained
> from ifdef CC_IS_CLANG/GCC in the generic headers.
> See __nocfi for an example, where compiler_types.h provides a default
> empty definition, and compiler-clang.h provides a non-empty
> definition.

Yeah, I think that would be a lot cleaner and matches the other things
like this.

               Linus

