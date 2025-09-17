Return-Path: <linux-kernel+bounces-820165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB58B7D8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146223A95C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464773043A4;
	Wed, 17 Sep 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKiGCY21"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3322F618A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094962; cv=none; b=Wapnjo0CUbmEFKg5ChSUeR6BLD56xhAKPJunJwiDbV2Q/nB92QUJjFaHLZN3JrIy/JscqzCBjFwqx9yNErn3SSr7ERBHluViRFcSq1CyrIKzBasqih+oqZE2UT5wwkkCbjC14HBQ3+tMAJ7fglovuL/Ri29m9SDb/wSXlcgkvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094962; c=relaxed/simple;
	bh=9GwEnzSffbw5H8CgU8KOdFD0FcDNiTS5Mae2BARQKLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjUWP4BQuVVJYpPkeUQkGtEe5+uv9Sl9Q5kNGu6dNOZk5fBIlUFDSVxXwDsZSfeJO9uHmV4P+2LfrsaNi/QOTLYOAfwb8zdTbb2DE23d0/QVoFCZqAkOyLGJJyeK4JADFIrIK7dQLCMyAKXoLpIFL4xuU0JKygKGY6Vpjts8NME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKiGCY21; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece1102998so103099f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758094959; x=1758699759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMzCzcs4sKSWk/z9LxqQB9n4/0J+86L6TlxBIp5RzGs=;
        b=VKiGCY21YZwrWcA+PGDhvLFNIqu3pHgNrvP9Ddu6T7TrxIykxezULeEu23yD8rW2aE
         qIv0x+QFfMsGGrQU6yGfQ6wbLTPnlNV+CdWxgQU9IWhcqrkHkxSJUho6vzwwEHW9KGrA
         OfS5VVTi3JLtN0UjlCkQRdIXV+/aH/akEPK0ZtltLubwwQP8YL/BhztsnsIk5yU9p7UL
         jKwb5SlB3vq5Za7BJcnurbcQSSOB2g8GNXXuOLwoV+ul5JpNPf4U5f4HvWmv2GNeXTVA
         UB8XMuh55/usFvrFqEYSJ7s5foMm/5p5Fsz2i+xP5sQIapgATk/miTdhjX4HCEQk2zTQ
         v7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094959; x=1758699759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMzCzcs4sKSWk/z9LxqQB9n4/0J+86L6TlxBIp5RzGs=;
        b=ubqDlcxrs6xezZFjm37ByruVYzakxjD2GG7x4xK1lhabtx8SHUUvhKjXvr/eBKYVp2
         AxDZP5JBxuwnbznPBWL1ld1DmBfPyaGIMI0NEFkksoQ1adHS4p3YAEdp8LltExLIJWs9
         +nuLW0tjyBQCmmbhVo7QEpB5/qCmYCJx/f8wHdleg2gGJF5xaHW6g7CUNw7FLN9rURWF
         TapOSZGkak2X+7RWM7Y7/QRCOASPQ/J93p9lFlwkcnHb7Q6h7quUnqnWZcr5E24vtFy8
         HHTrpdNdMDO0AAA8xwzX6PSYgBkocfVs/vxYvq8aUjDRl0dc+fSBvko1L/k/0WT+g0wv
         EkiA==
X-Forwarded-Encrypted: i=1; AJvYcCVwd8h3yg9NQ6o19eu7J5KlxXAdowVP/shn5D9abRQZwTs78dDJkUBSiapAvyQF8hTwBKL690P6xv5FSDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGKclp+f4xyh5kP6yS6S/uupkZynrxkA3Bl6SNazYXusTRlcn
	zSfVGNkZQ3KFqboRSdRTfxqDnPexI8s4EEmPUIvd3/k22lF/vVcMNo9icw6kNNfq+t0=
X-Gm-Gg: ASbGncvWnn3b59QIMUjKfc7fjLFauEFbMwAVb3bTlIZkmNgBatDsZLvTWXs8tItx4gH
	JAz9HMgeZhbry2h3Hw+5AwyxJitHWiZqGhLFO6mVAYkiJwbgk420vWBdKuS2rxaY8oDk0Ik7eSu
	t6jkHjCgz1Gukbpq5xCm/ATxxMwWYJU+tzwjAQBGIFPyQlx8J2Tlx1SzBVIBsvhaGU7iFNHBERC
	iL/tW+8yOpq4HJik+vv3DKur6jc4Ozv5ySBkuMJQhcBdTCNrMViO7xwClLesUOckoaslJrdmZtl
	YwgPXj7aEt4Njxq/xHoBtAGqYiD/jvS1+gFRBGxpNhDi6TS7X9bsQR8Bsl/PFbddc7sV9FYHODe
	+3tbxC1shZs4rDMoA/NT4oEU9zLk=
X-Google-Smtp-Source: AGHT+IFnhuMCQzSPR3g4mNraRS235VJdldWT6BwGNxpmI42pebjJriNR/dcn2WvXRaSO9d0EpAF1Nw==
X-Received: by 2002:a05:6000:178e:b0:3e0:2a95:dc9e with SMTP id ffacd0b85a97d-3ecdfa3b817mr1007435f8f.57.1758094959152;
        Wed, 17 Sep 2025 00:42:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3eaa6476fadsm11990670f8f.45.2025.09.17.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:42:38 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:42:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	rust-for-linux@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
Message-ID: <aMpma-2UokTo0u9j@stanley.mountain>
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
 <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
 <27366f94-67d4-4b73-b420-cacdbe9d603f@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27366f94-67d4-4b73-b420-cacdbe9d603f@heusel.eu>

On Tue, Sep 16, 2025 at 06:46:06PM +0200, Christian Heusel wrote:
> On 25/09/16 09:56PM, Naresh Kamboju wrote:
> > On Tue, 16 Sept 2025 at 11:17, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > The following build warnings / errors noticed on the arm arm64 and x86_64
> > > with rust config build on the Linux next-20250915 tag.
> > >
> > > First seen on next-20250915
> > > Good: next-20250912
> > > Bad: next-20250915
> > >
> > > Regression Analysis:
> > > - New regression? yes
> > > - Reproducibility? yes
> > >
> > > * arm, build
> > >   - rustclang-lkftconfig-kselftest
> > >   - rustgcc-lkftconfig-kselftest
> > >
> > > * arm64, build
> > >   - rustclang-lkftconfig-kselftest
> > >   - rustgcc-lkftconfig-kselftest
> > >
> > > * x86_64, build
> > >   - rustgcc-lkftconfig-kselftest
> > >   - rustclang-nightly-lkftconfig-kselftest
> > >
> > > Build regression: next-20250915: error[E0425]: cannot find function
> > > `atomic_read_acquire` in crate `bindings`
> > 
> > Anders bisected this build regressions and found,
> > 
> > # first bad commit:
> >  [eb57133305f61b612252382d0c1478bba7f57b67]
> >  rust: sync: Add basic atomic operation mapping framework
> 
> Is this still an issue on next-20250916? As far as I can tell this has
> been fixed, but now there is another rust build issue, see
> https://lore.kernel.org/regressions/0fee48bb-7411-4414-b4e7-395a8c3d0f6c@heusel.eu/
> for more information.
> 
> Cheers,
> Chris
> 

next-20250916 still fails but with a different Rust issue.

$ make
  SYNC    include/config/auto.conf
  HOSTCC  scripts/basic/fixdep
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  RUSTC L rust/kernel.o
error: expected one of `,` or `}`, found `;`
  --> rust/kernel/block/mq/gen_disk.rs:12:23
   |
12 |     fmt::{self, Write};
   |                       ^
   |                       |
   |                       expected one of `,` or `}`
   |                       help: missing `,`

error: aborting due to 1 previous error

make[2]: *** [rust/Makefile:553: rust/kernel.o] Error 1
make[1]: *** [/home/dcarpenter/progs/kernel/devel/Makefile:1286: prepare] Error 2
make: *** [Makefile:248: __sub-make] Error 2

regards,
dan carpenter


