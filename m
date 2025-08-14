Return-Path: <linux-kernel+bounces-769490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8ADB26F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63802585C05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A723506F;
	Thu, 14 Aug 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFz2Ma6e"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED67226D1B;
	Thu, 14 Aug 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197663; cv=none; b=hrbDuvGQSGh5D475s7jfg75fKBOze5pNX9zFA6qMZpDwHxdGmVghrHxHqz5FOB2qt0n11SDKK3YJ01lrVptzQlW4P4iKgUxOZ4ylkC63NgjJtmO5TuVjbxJ9rWONAcIT3LSYnK077SpXox2TzvQ4i9HHTzWWTBKWbQ28nJeA9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197663; c=relaxed/simple;
	bh=OYZVGa1PYJPNGIjnnm7Kj/36+cnPl22d4hWZLZI5SBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+TomC7vmG8Z0tSFS9FGciow1nhoQEU63YB2cif/S0WEcogczhsazlL3p2Tp+omK7vGHE5vIvQLRhMl+Km1ad/eDtuxS4nPPP/wAqRmk5nZA+qD3gXhPtM8ekL43TYXkpWue7IHjIrtdmnuRUEapgaThmxfebe6nL4K1vwWV/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFz2Ma6e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e20aeeso250175a91.2;
        Thu, 14 Aug 2025 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197661; x=1755802461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYZVGa1PYJPNGIjnnm7Kj/36+cnPl22d4hWZLZI5SBs=;
        b=gFz2Ma6eHVFcevxfE0/brh9YS3UALnfEV1rBhIC/erT7b0nkL+jw1OsCmuajCH0xU2
         CagOymMfNsbXw5cX/F3/Nong4DNqCc799NHoPQSqqZnTwDjlHEkFr7jj0rFUw4k8atm9
         nVxSTxDJakYkRmAp10ok6eLeyx4J/jzBhUgpbspctDvW0tsT2xo7fNLw2s0Yy1uu4YfN
         0x+U/HJ3aZ0PaPoNwZtRYm/vTGOuO0Xa0wd0c8yzFJIoAbNGurcfbjFNkiRZfxuV1HTm
         5wxa+LHGMClRCIyB9SHTo+NA8a5tO4WTUrlOSz0AFjpb0aHL8ca3UCNoEK1j1XtT1gc3
         Dsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197661; x=1755802461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYZVGa1PYJPNGIjnnm7Kj/36+cnPl22d4hWZLZI5SBs=;
        b=oy26eFcw851KMWiTVsiL/HKNzzSUszClbHtB9glRYKRkqPlhv/u2wjUY0eG6lin6qV
         YE5S1qoQZxddlQvCxdmdyHoxaymx3FCWZjadcHZNTokJkI7js5FdwTJqHZW4IXFKdhKW
         3azaV2txO+RkJTiHUq1YVYBr7Ba1gnjhOAIAbFHZ2bz7MqdieDa5QtrDsy4jM2Lcitm+
         4+I/zhQeR6WuhEVI/QeumIPVUTMCroSZUo24RV9gsRjE8K5kSLwYJ6eLQtGjtVribt5D
         EuP0VxZ3BwVq1DVrm0sUbNpe+olqD8sfKL/hn0XhPp8PRppq4c37pWgazV77WJdi+mVt
         J+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWzsRFPccU7QPNfp3SSM96NGkNe9OW02aUgDnzSYhDkAgkIaXjDbEKqHcB9BiCvobmaii01KML0c+WAt+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUmtbN/r2lPmpHYlPvC1p7bF7XoP593T4I29cp9RWVgoZ5kUC
	78oCkxbhdTgx1oJuQ4XYYmtIfEM2WoEYqSE2F3/R5ZEyeOlPojNVXu/qyLWBKN0rrvdSQfDAgul
	A7aaVhdXu3qc4bOKNOEd+fmKkZbZ9/bQ=
X-Gm-Gg: ASbGncu1j1kQsPsNXkn/72LfWamFoMMTjxJ6sUAskHCBEc9IXu8R+QojOfgPZNrKbuf
	WyfE2RgiNUPQHgyKYcZyy1Bp++fCgBx4dTa8X3ZaGDDInsr+FrOuJHlZrZF58HgpPcWX0XnY0ef
	+yaCw6VVFtwRtE8QOfPlH2ExzN7UmHaCOT7f9JhOAhZPr2IXKOd/eJ8MRuoW/+Pjhdk1EaNAB87
	Pohqjup
X-Google-Smtp-Source: AGHT+IG2OpBwgrzW1tGXTKHhCvFJxT6+QTACraQ+4La5od/G8sAeSk6s5/oSwHcphG/Rbx7PyRjjmu0zbq04Wz+pt1M=
X-Received: by 2002:a17:902:e551:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2445855d35amr27380075ad.5.1755197660947; Thu, 14 Aug 2025
 11:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec0dcd14-e974-43ff-b4f4-3dfe2f31a91c@t-8ch.de>
 <20250814162211.566168-2-areejhamid8560@gmail.com> <CANiq72mbTqu8KuKn1uKM8czesrg+or-S3K9e_ohJz1b6kzdffw@mail.gmail.com>
In-Reply-To: <CANiq72mbTqu8KuKn1uKM8czesrg+or-S3K9e_ohJz1b6kzdffw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 20:54:08 +0200
X-Gm-Features: Ac12FXxybBvTV1eECTHV-8gFuZ3Wi3EHZqw-1RbS55cKepkyOA4bq0h6O62VfBs
Message-ID: <CANiq72k0-dggqh-z5JLhrUbuQf_RHCOCjd=iYF+Fv+wLT8=x0w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: lib: add if_cfg! macro for conditional compilation
To: Areej Hamid <areejhamid8560@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	viresh.kumar@linaro.org, tamird@gmail.com, dingxiangfei2009@gmail.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 8:49=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Finally, we may want to consider putting this into somewhere else,
> rather than the root file of the crate.

By the way, there are some strange addresses in Cc: Thomas at domain
dot com, Andreas at Linaro, etc.

Where are you fetching those from? Please use the ones from the
`MAINTAINERS` file.

Thanks!

Cheers,
Miguel

