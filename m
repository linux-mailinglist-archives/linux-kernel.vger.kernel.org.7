Return-Path: <linux-kernel+bounces-735655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5104EB0922F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B9C1C4094D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A72FCFC1;
	Thu, 17 Jul 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGNALOzq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824C2FCE2A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770941; cv=none; b=l+TyDUct0t+S/EdkXjTT46B85Mh0j4dmIqBMunwoVzxw6uOKYxcjJUkVLAbc4RXMJMnMsNs2Mq3NBMvnrnwLDBvyJWqK22iH0KNzU26jWVHbIxzImPEVwwWugoxjaeQOCR2VNU+IuexgGvYNSIHMGD5vJulK4ShZMvweAVux6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770941; c=relaxed/simple;
	bh=ATfb/Vyv7N7+qY0CZhZfMQ/VkrzG4iMeplRhL+HK3KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM6zZm8TBz9RPGZMMxI1oRSgx6DmuYI7jJBJvA3TZwI0uHfk5sZk+X8u4l4i3cPcgbTadEcpLdBKXwfWxrblSSgyLGiHHlbiCSosH7+fbu+wKtPpuPI5jPX+D3Mug1QA0X6IuROY1IWB7f4GQTZHKQmNZt62u81gDsPmP44c1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGNALOzq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2357c61cda7so1675ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752770939; x=1753375739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATfb/Vyv7N7+qY0CZhZfMQ/VkrzG4iMeplRhL+HK3KU=;
        b=HGNALOzq1gm/5++mNEQ469Zr9O0+XTu0KXCYhkTp9HeIXXXu7fC9PA3IKBaYT0ubEy
         Uze0/qXvumhYgnXz3mjDDjvTGXiZl5AZA991UCL8uhFpvHFU10lW/2KPmRU2kmy9mO2E
         G8ojKmREUuXCztik/x5IANFJULbGEldnB8mKzpv/GrljQB++bEBngFT45GYogOdMXir4
         rqMn7BLX7B93+nXYB6GdudU227w+s+TobzHiN986B7sKwcdCqr/zdM0UK+iZwf+gvd1t
         IY4y50s+Z0x2Rzl5ECY/QvLmNRljShB7LSuqasX/YKVX5XboQul1RkTP7HWINrVMLcl7
         iwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770939; x=1753375739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATfb/Vyv7N7+qY0CZhZfMQ/VkrzG4iMeplRhL+HK3KU=;
        b=OeZUZhysIdf/jz4p06yQKMxeofTRErnr2Bh8NbcjrF0nSj6pEjbhAjxZCuyyH/BWMS
         RAXuKVJbYMRpmO/aoGHn+VJX0u3nN0f4micxavbRT0JvCHtB25Q4ysTfUfrBmp0JheNe
         WPis3CC3y+2QSOQip5/1nWPKuEAtoJ5g0B/0A1uP5y+hc0af2QcoLgk7fd8BSP6Bksu8
         RoP1AlcLyB2CGy2fJnOCP9ddotO/tkIxBjl7+gzaQQFLrGn6c56X4/xLVd7HsgR4Rgro
         XUTeFwRFhzYnfzYryFH1zxA0X8RYC40S3K2pp+4UBtHGBiPBapRrsA8zjTjvbAuXjjUd
         ji3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdEomyzv+K92JSJ7sTqCohOmbAwyz6/oSMeXGmgDm7jXALkNBP1tca7JfktLHOmoeElXRBK40/mD2Gf/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gRfsnbhLskxEbQkf/p4X6a6dVN1e0+SG0Pq1e5kY3S1gcoHA
	zOIAAfeG+cncqkeVBG8B4FVHGjpkUZAN73/MW7v2B5YgLl3zSbXQnsxFJftexQ/CLoU5lQSBhhL
	FjkOxDAJTTjusCRChyYlh3GVWARnol2eOmCW8c4nI
X-Gm-Gg: ASbGncvYgtazYl+qudttVSqozI/jLZoJt/ISXJ8/RS83ZkgL8KSkl9Qi7ghNmP3+YFz
	jFzI1f6gwAaIBs45oMPgr8w40dluCwjf1yjXuhcN293Ct68Anzq7S95/+SWC608PvdUnk8ZR7k9
	ms4OUz2ZYDgEmmTR1WLRxv7EQ2WWSCDCOWcZEO+nHAphQmnXvu+0hJGCRZvgdrL6LgPw9moamsx
	xuh
X-Google-Smtp-Source: AGHT+IE+PDwwXnWhFQm24s8cPhGCQ5EY64CdyLsDsuABTQ+2CmXVfJv7P3ynyPa5W8nuCz7rsH1o5Cw3ZUsHX0Zgg+0=
X-Received: by 2002:a17:903:2342:b0:23c:5f63:b67 with SMTP id
 d9443c01a7336-23e39268bacmr302515ad.4.1752770938454; Thu, 17 Jul 2025
 09:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org> <CANiq72kPmb+7Ygk_Qvsiq+22EJVSPjjwn4whdLuTGCPwvTAssQ@mail.gmail.com>
 <CANiq72nqg79xB=iV4GCH8XCak2jCn+XxUX4Hm1s6n5L=5cLuvw@mail.gmail.com>
In-Reply-To: <CANiq72nqg79xB=iV4GCH8XCak2jCn+XxUX4Hm1s6n5L=5cLuvw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 17 Jul 2025 09:48:21 -0700
X-Gm-Features: Ac12FXzbJOlwBZd244gzQ7hjYG8HHbdgWFdeM8CQEG3LxeALfQRXXRCHDtw62hI
Message-ID: <CABCJKufPphD3en91N89yekUam4Nv7+C7YPJMv7h2SmZcyhGhdA@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:08=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 17, 2025 at 11:51=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > It would be nice to have a quick sentence inline summarizing how it
> > will be used, e.g. what kind of functions will need to be annotated.
>
> By the way, related to the use case question: would we eventually want
> such an attribute for Rust too? If so, happy to help.

I would definitely like to see Rust support for this too. Otherwise,
we would have to drop the attribute when Rust is enabled to avoid CFI
type mismatches with C code.

Sami

