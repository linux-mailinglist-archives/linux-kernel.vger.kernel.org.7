Return-Path: <linux-kernel+bounces-721811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7CAFCE29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402B71895F75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5B226CFC;
	Tue,  8 Jul 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+hXCrdU"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992621ADA2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986001; cv=none; b=PMwD69Nfc7oZmWjQfGc2/TzaOCYuYd78JtWxFTmGuhs5LVRjN+v3xwaX7r3CAg9sBb8U75Jb2OKGh64nPJDxkZu+p/hNRO1fwTNmp+70bDhEFibT9uY6qSH+q8zQgSj20c1hteXeNc5LiMKJahcVNCmDOSduxhncpeb8UFatbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986001; c=relaxed/simple;
	bh=rdaHkwEgySzssWJnGXU8iu178barphVuPjFKEHZYUfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3ohEG2mI6i4CUZgS9gzkwXxT2nnNLhweGmWW4wHjlrs+7qiUjZa5wFTtKJEvR8IvGxB4ymZrEtP544HMe0Xhj135L02nU63BLUGEvrHvVVOVel9hhSHOfBl5KfQ+tuhpdIO99kvmxey+ohSIYidHBEGUpt4N3+W/09VdBx/8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+hXCrdU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af6a315b491so3943831a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985997; x=1752590797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0P5JXJKoQne0+91AzBGnZ+7c0bfri6L6epqykQQTaN0=;
        b=Z+hXCrdUIOk3EEQBEyUlUrSkqfzdnkkQE3oElAiB2VRH3BQ9h/cdYLwNMvZRl1G7dt
         ei915ZDeD0zbjFGR9Hz4RTrzJOtZcacW7VARBVVhKuuo769Nl9Iy3pCPJWKewnK8aB7Q
         gKiYvXkz8S90zElrpS1qdia1M8V0Mb8p+0+RDHJLOS5vfoqQ85zojYJl4zPVUnwXglOY
         nyCIdC1FXdiI8l0S0AMSGWyO26TWdfjZuAZqKUKfDbWZOxhe5ui4l94dhAWxNiJ1O/+2
         m57lsyaibGIvafUHrC6EicYy6SsLg2Dddg34CzvYWOAlfyvQ0oSvU3EHgHIV3QR0xDOT
         Fk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985997; x=1752590797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P5JXJKoQne0+91AzBGnZ+7c0bfri6L6epqykQQTaN0=;
        b=U3chnq+m+Rd+00nI6sdiUNYcOKzJx6NIZsggnQUrUvOVIoujwQzgZewOXrbWHWFpgM
         6k9ukABUKONHWfBmSjxTb3PeDKbqg9ZTA5WbF5fhgs7XxIZucocVZ0t1ZLPTXer3TWCi
         MeWoMEhTIr+bsnOc9HCxdQgv3XdWEshIxt2w4EcreKDFIT1tESjMGbXnue6aNzS7vH6i
         SwyjY8vYV/IktSfIkPoAiV6EjjQNdWHUGrOJVPGQFC4rfkEb+hMPEhCDHAqT4ykLPHTL
         p1h9McYl3y+RXqR1qkKiLXaYgmtNofKt0VxJ0/9GK74KAimdKmWi59j9rNeftc8X5EuR
         oC5w==
X-Forwarded-Encrypted: i=1; AJvYcCW/uawsi5xr4uXqIGI2YlS6ZgPPkoWCLqh9wQF/6asGAagZmc/PzAbtQDYcCfzjEkSH3HVJXZCRK/OyhgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEn7vXOIoh/m9/Y0CpPsVnkp3Zv0ylZ9tvaKBvcBPhvzn53sW
	YIxIv1X+3YQXLCmsRlJpomKPYuyK5E1txB2eEgnvz7zBJLq48+daFnRuqMKmrg==
X-Gm-Gg: ASbGncuncpBu02sNt9mbI5uXgeJQ14Xef/jwcavV9svRq4V0gU/WOdqnziHl6WJIYOL
	vzO7Cem4dbQWh2a5CfQdxxMlDkb5FmFg1N67t6Zviagsp/nBPJgQHy0XrbgiScvUy5wrDCbUNOg
	t7+vea/R+E0Mn3udDTHKcIpas9Twnu/au6PVIQ6wrIxdXqm/naZoHe9gsA3k45sK3/pjSR3KES6
	e0MgsejJJKMnbLDa5eOy2zD7dRamE0iGeQJMVY8EF1ZVpZ+Ph6pPSuuofHXQ8FHAOJ1hD/6L4DB
	3TFuuAV2CwJb6BJqDOtZP8plIbyEsi+XLpB2uP+5jKFoSRPsOQ5rduaZ/QpraQ==
X-Google-Smtp-Source: AGHT+IFiqdSlCbU4zD//x0lPXI7pA7rphxHL2l3rMZn1TfraBPWBfii1gmAYrhU1Zmp/y07HuF1+6g==
X-Received: by 2002:a05:6a20:258e:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-225b7f19802mr30657387637.7.1751985996536;
        Tue, 08 Jul 2025 07:46:36 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee476152sm11695895a12.24.2025.07.08.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:46:36 -0700 (PDT)
Date: Tue, 8 Jul 2025 10:46:33 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, catalin.marinas@arm.com,
	will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
	james.morse@arm.com
Subject: Re: [PATCH 2/2] bitfield: Ensure the return value of
 type##_replace_bits() is checked
Message-ID: <aG0vScXkDROkdASW@yury>
References: <20250703135729.1807517-1-ben.horgan@arm.com>
 <20250703135729.1807517-3-ben.horgan@arm.com>
 <aGv2WoAtxnEgqV4y@yury>
 <03a76e9a-86ac-4791-9f0a-494b28c07fcc@arm.com>
 <86tt3n9fsh.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86tt3n9fsh.wl-maz@kernel.org>

On Tue, Jul 08, 2025 at 10:45:50AM +0100, Marc Zyngier wrote:
> On Tue, 08 Jul 2025 10:42:06 +0100,
> Ben Horgan <ben.horgan@arm.com> wrote:
> > 
> > Hi Yury,
> > 
> > On 7/7/25 17:31, Yury Norov wrote:
> > > Hi Ben,
> > > 
> > > On Thu, Jul 03, 2025 at 02:57:29PM +0100, Ben Horgan wrote:
> > >> As type##_replace_bits() has no side effects it is only useful if its
> > >> return value is checked. Add __must_check to enforce this usage. To have
> > >> the bits replaced in-place typep##_replace_bits() can be used instead.
> > >> 
> > >> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> > >> ---
> > >>   include/linux/bitfield.h | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >> 
> > >> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > >> index 6d9a53db54b6..39333b80d22b 100644
> > >> --- a/include/linux/bitfield.h
> > >> +++ b/include/linux/bitfield.h
> > >> @@ -195,8 +195,8 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
> > >>   		__field_overflow();					\
> > >>   	return to((v & field_mask(field)) * field_multiplier(field));	\
> > >>   }									\
> > >> -static __always_inline __##type type##_replace_bits(__##type old,	\
> > >> -					base val, base field)		\
> > >> +static __always_inline __##type __must_check type##_replace_bits(__##type old,	\
> > >> +							base val, base field)	\
> > >>   {									\
> > >>   	return (old & ~to(field)) | type##_encode_bits(val, field);	\
> > >>   }									\
> > > 
> > > So, would it make sense to mark _encode_bits() and _get_bits() as
> > > __must_check as well? At least from the point of unification, it
> > > would.
> > Could do. It seems less important as there are no obvious foot-guns
> > that these would guards against. Would you like me to add this in a
> > v2?

Yes please.
 
> > > How would we move this - with my bitmap-for next or with arm branch?
> > 
> > I'm not familiar with the branch machinery so can't comment on this.
> 
> The first patch will definitely go in via the KVM/arm64 tree, probably
> as a fix for 6.16.

OK. Then I'll take patch #2 v2 by myself.

Thanks,
Yury

