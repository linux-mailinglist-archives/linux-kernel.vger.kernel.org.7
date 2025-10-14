Return-Path: <linux-kernel+bounces-852222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64362BD877E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0C3B4FB65D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D12EB5BF;
	Tue, 14 Oct 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNYjkkD8"
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78642EA724
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434619; cv=none; b=S6BVaPwp6z/t057YNkjRXTJ7yh56cbGQRXK1kez/SnYLNDiwdXJTU8Hcam3Hx71O6/K7+TFTXB+3uzZrDHVs23v6n/GN2d1LsCZQgLKaHQTof/RNV3JKrogaM0rxSPTlHAolgC32XMZy8S2NcBKrFy/fq5CxjqBz8ustJjMQBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434619; c=relaxed/simple;
	bh=glShDIg1aywHSoIVDslh1hsbrjXNgLMkJL1dNWhaR/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ2ZssIHYTUXygQGKa07OMqeNXMHNs++5bun/Cs0w1RgC1JVorYz/AOJ5BEBiTV5bbYYwgDpsRUJ3mUJyi2RcLSvnfiu7J7wATfVWv58OlIgS5xXXQJmJuVfSwd/fga8dXTSrytlIy6APM8MmNPYJ8ndRApNe1ZpjR9pCEvA6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNYjkkD8; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-780c6c40772so6325247b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760434617; x=1761039417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glShDIg1aywHSoIVDslh1hsbrjXNgLMkJL1dNWhaR/g=;
        b=YNYjkkD89fE9uFrJj2npIIPp1FynS94tHd1kkWJHGG4nq5uQ0RPZcOOUbBPe2hSOjM
         4V3GWiQnej8DNhqNMLDlZHIFsOkknJKOYKHYS6Y+EaLcw+b93q+KzQL5ALo6Px2WKfrh
         RgNngJr350972IRkOBwWFD/qQlRI8/ZCLRkTsjP6EKHf1AQzSiC1xwJS10tHENsyI7Nn
         gVto4LKs8/TQbazx7ziOFLJeOljLPfi/rnH7wxgVsGwVxVzJuir047LukK0VUcNjQTzT
         LgGbUHIBzpxyjnQbEhlyCU8Xt6hW/qxuGSFJKMPb7IAcWKEQn+W3vTUXEPp6ZQA1FWhx
         L4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434617; x=1761039417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glShDIg1aywHSoIVDslh1hsbrjXNgLMkJL1dNWhaR/g=;
        b=jvEW4/aqRy0TNvWVzDQiOSA+kOzuw/nsJcy+Weon7Z0pPl81mOrCSKXjiebg0B4C4u
         U03p4J4XpOEfQh0gy5It40wWjSm6mEBgRNgNWAgxaiNvVmQfjwFuGmPAcz/KjB4j4phy
         zEZn+MhjtAHBXMxXAdCa7xvWYdXephi3oLW+OsRgampru1pQD5UIYW/bVdco8pMXQlOa
         TC+fhFni8pibUn8b+jUfZauAdUcu8af2oNgbZQv0YAGSnb8VHyb4i/c10OXhroQLKV/m
         Z9TBJZGO7J45TWfTJk8nwWlX3PuhAkzovGAtCqcjpm3zk0e3/0/d7EtYK6KdjAzqwW9k
         vUlA==
X-Forwarded-Encrypted: i=1; AJvYcCXTYGsaEDE7Kno7+EA+5xfE0kPGLar78TZyXRRlvNRoVMJKDK/oOK6QnACROpfu+rr2BX72pjFwI3R/KcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrJIXDXOAebMe9e9U9llCJD1T5aM83I+vqErGLgN0PfFNJ86Y
	pL5Xo3dEPB1IP/uFtfNz35IphaBh8+qwufKLZp6nxs91vwG9k5ClE0rF68MK9B3iheUoMmfUrXO
	9KDBJDOF2s+DdVNbKkRN+9LkolotjWUg=
X-Gm-Gg: ASbGncsRIE7qe5/ZIvTgj4aTup9anu60ZraF66JVFR8cGf7nNBSKC2ytLsgMT+CZeDW
	CnOCdBs+/ld/dAHppBzGR6X7XkZg/gaJ8+tSBeffHPI8no3Ne/4erPkYHu5l+F6i8jJRjQ6l6EZ
	DYrWuOK2SFUj12Usoi806oc1O3OzaR3a8o6acpmEkW6QS8Xu0/aH02mWTv58aFwsQcjMfUbMgL6
	1J616whK/4a8TfL5emsozH9
X-Google-Smtp-Source: AGHT+IGoAlQ2WFaEYeTOAIe9c4Elf37z78F9EHmjUwLc6pTpWC+0i0M7nVQiV8n3OzJB4gzdKZLAbVWmMRia7P3rC8s=
X-Received: by 2002:a53:c985:0:b0:636:d528:7e9 with SMTP id
 956f58d0204a3-63ccb8c3891mr9629921d50.5.1760434616695; Tue, 14 Oct 2025
 02:36:56 -0700 (PDT)
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
 <CAJnrk1YRNw5M2f1Nxt619SG+wUkF+y2JrMZZCyLqWVd59+-gjA@mail.gmail.com> <CAJfpegvt8Z4ftmQ37ptD8gQu4CHCUB1smxxTgngNpRaDm5=1dA@mail.gmail.com>
In-Reply-To: <CAJfpegvt8Z4ftmQ37ptD8gQu4CHCUB1smxxTgngNpRaDm5=1dA@mail.gmail.com>
From: lu gu <giveme.gulu@gmail.com>
Date: Tue, 14 Oct 2025 17:36:45 +0800
X-Gm-Features: AS18NWBKJYVvlubLST1J_RXyTAxEWJptrylpRY2GHtHNw4S87NtwN5lKcQFhZXc
Message-ID: <CAFS-8+XXdupsG7E3riggVEffSfaAw0YndfsbmcdbQqFaKt8PCQ@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

> > > Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).
> > >
> >
> > I was more wondering if the problem goes away if it were disabled..


Yes, I tried commenting out the invalidate_inode_pages2 function and
ran the LTP test cases in a loop more than ten times, and no data
inconsistency issues occurred.

