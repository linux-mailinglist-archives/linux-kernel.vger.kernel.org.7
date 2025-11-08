Return-Path: <linux-kernel+bounces-891660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AAAC432DD
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 19:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B133ACE2C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47390264F9C;
	Sat,  8 Nov 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TR/TRNNS"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E084039
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624930; cv=none; b=QITPQ2/61UddZnHDQUy6Bb/1D3eO8fjnySIi3bLkjMcYmBqwuto5YkpqPE2bLGALRdDxTBJlmfdBhBnZBv0Dl425XuZIYTKtEMZPQOmq4sdT1HjjlB1CXnIepFfgrKG1GvJt+6z6wWdz/hSdDmzw9VX2uKmXcxMw4VA9gTigljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624930; c=relaxed/simple;
	bh=3IAPhhTO3r40ZZf6LZefAtf94Ln9t0PzMSjZoD5Izaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5AUD0kDMIoXOrDawQkSmBaoFnUQY8rsjBrLbPFqSyBUTqeTnOwrzCnQNr9Fq8oYAJFSOcnEgRRRPkC06C+p3W2GpUV88AwsT4CflrDMBRrSEiRgMq1IKIC1azTyQh6YRZiysTJXsAU7ZRm9WhMj0qqDvjv/nBRuFNUavxRs45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TR/TRNNS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so2829614a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762624927; x=1763229727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GWnAPZ9fJcziaRXd9RH/lv4CcYCp+R5b37Pg12ambs=;
        b=TR/TRNNSmCGSVrbV5A1z0ywve0vGWlgCPWFzOZYO/umw0mviLuQ1m8z93newQ9A7zz
         BHRXICmNAE7GXU+XESGpD/FgxCU1vp95Ijc4a9sfGRouBRteq1DUAS0+x9wmWG7L8bAo
         0pKSFc3QdVwjEPzhUVgbnCAnu70+zvXIiQpIE6fBPltq3sRyv+TVOSm6J/xwAeZM0iDO
         xOYW15EhMZGPjzIT1RhgESY6HICAkaurs8yFAm2yfAERjW7T3aQIQUb8ncM8gDjaBX3y
         R/XaaP67PLwZVbG7YrTbD0J44DVQLomKPITchLG/uizeeY2evf1ek+l6SUyUTm+xOT3L
         XYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624927; x=1763229727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GWnAPZ9fJcziaRXd9RH/lv4CcYCp+R5b37Pg12ambs=;
        b=ux+7/PHlt9WM10pLPR2xTiDm6Da8Lckl04A0OGvetd3ONVdhm0BdkliHB8oSjSoeL+
         kE4GHaE5gLJ3HEK5C834mUM0F1xTiRUKZesN6KZzfZkpdUvj+THcU3zhskiRuS/SwYfU
         vyg2yt5dGvMTZfwSZFwBv+L/EBmIp5M1yU6fZNC48+Iz3dTWe+zDT8NGBsEhtNGCBQ7A
         5RpmXxo1Faltbn08gT/pll+T9I10Kaa5mgxPAS/tGh+EXj5J92C+Vw+49M8JnbJv3ZVW
         1WPjHWsDH/g/iZQIozQ+X7Dzz6OM8RGaKDzCoHVnZrmbxcm4Ivw77bRuypoqsEDixbVg
         iwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeS/ngZJrgvYNl0vvE3MOjaIBAqb/UneC+OSZAHb6ugXKSKWlYtuPF9XyEkoml+oGyYlxSllGcWiI+Bbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjsJhL/7CtIgDZooFFvSZE5iTdLybhS4VNlPEWcfAz0p9F3sv
	m9vrCXtuJvCvK/BwY7O803+xfoUomwj2l4RmGV7hbXkflxacSL2WiNcJyaFccnnhJHlAScvDz/E
	METKWKbduiMbkDDtBDxC3Qazhyx+Y9a+mRugFT6XgYQ==
X-Gm-Gg: ASbGncvh7paPZ1Pim3cHgdxYURAtjJxl4YGpAP7HAWS0jtpqSgiPU3Uo2WVDFMNHWoH
	AvkamWTnZyV1fV2ZxjrY7PdktZk42gEGr9/HaoEG7nsDn0UQRMa3Wq9F1UyUU6W5V1lC9C0YRdi
	IInCFmArYRf4szgZ5lMh4NdcRgevrIAQspInvAvqqC6OqQQ7oJcfQ/cpCYdYYa6EXeFwhqGmjbN
	f6WzvcJgkAkNAxZhRKUHxsPu+7LerFSr0psy9UUaaN8/LZFHUnA0YF6nvUNrJdiqidDqNJAEMuH
	mOdkFYeDmmq/AOSYU30HL/zOcscQXkxXxPT5XBM=
X-Google-Smtp-Source: AGHT+IFsBU5ndj9huagaCxIuqQWmECbsaAtYI+vyGpVvxucw0lq5Q3fxfGJV+B8R/tEvXu8DaclLEzTrS4Qfd5oPG4I=
X-Received: by 2002:a05:6402:1e8e:b0:640:9aed:6ab6 with SMTP id
 4fb4d7f45d1cf-6415e6e4832mr2571858a12.24.1762624926681; Sat, 08 Nov 2025
 10:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-8-pasha.tatashin@soleen.com> <20251107142304.6d22289c96023fbb7e99464c@linux-foundation.org>
In-Reply-To: <20251107142304.6d22289c96023fbb7e99464c@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 13:01:30 -0500
X-Gm-Features: AWmQ_bmRKs4A_xQMqsLqTmPYtgSzWfjOGsBbh71PdYDaXz1vtujo3t8KJ5u4TWo
Message-ID: <CA+CK2bAvh9Oa2SLfsbJ8zztpEjrgr_hr-uGgF1coy8yoibT39A@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate
To: Andrew Morton <akpm@linux-foundation.org>
Cc: brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org, 
	pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:23=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sat,  1 Nov 2025 10:23:23 -0400 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
>
> I notice that menuconfig is a bit weird after this.
>
> The "General setup" menu offers the "Live Update and Kexec HandOver"
> menu but there's nothing in there.  If one sets
> DEFERRED_STRUCT_PAGE_INIT then things look normal.
>
> Perhaps we shouldn't be offering "Live Update and Kexec HandOver" at
> all if !DEFERRED_STRUCT_PAGE_INIT.

Hi Andrew, thank you for noticing this, yes, indeed it looks strange
when empty. Let's disable the menu when DEFERRED_STRUCT_PAGE_INIT
until we relax this KHO/deferred init dependency.

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 054f6375a7af..d7344d347f69 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -7,6 +7,7 @@
 #

 menu "Live Update and Kexec HandOver"
+       depends on !DEFERRED_STRUCT_PAGE_INIT

 config LIVEUPDATE
        bool "Live Update Orchestrator"

