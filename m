Return-Path: <linux-kernel+bounces-869114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0915C06FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C135416E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F9325488;
	Fri, 24 Oct 2025 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CcCitAe7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AF254AFF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320047; cv=none; b=fwojkTgBRPArAsIc3mhyKmTxU293zQzw5VYxz/Zn+PUv/QNiywTgjQ3qraU6Mi/rzsAKL1pY+rptH5i8vAuiz+I/MUEPjjtOerxyl97WEid+nMcEG5UfVAFAt3cwrJuIqrAQ9HIPqsIH/XxfVyILB97YHXpdD+9lYjZQrOyIjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320047; c=relaxed/simple;
	bh=are2xt86yIlpc4HL3GdNhNk2Nk9IKxa3I/LJcQcthQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/VE+k7zJI97SRwotlt/p6HDtUxIcrrc/CygD2tN81802JL+1UQyfigUx3+h7pOGoEeEfulPMJyOn2R2CPn1i0+x4st4TCPxg9dOSTw6FvUsCG0zES/yBnvK/A7TqifdNvpxQ4Zwn8zin+mDMlp09HGPX5djQAIDQSJbuZNpceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CcCitAe7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso3466522a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761320043; x=1761924843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=are2xt86yIlpc4HL3GdNhNk2Nk9IKxa3I/LJcQcthQo=;
        b=CcCitAe7h2YJ6QBV/Cay2BUOhxWYlSZRo9mEq4Zy5ZUSpbiiophcZUOiaPtMsYCUfP
         Mht5GOxKq+FZhG/vnmH33NgDSKVM7YZa+rjMhmZfbUGU2OX8HFHJ/MgnLdrn1Qk3zbnd
         ae+oVwsivjOJiIkjMh7/olmsnkkIioG2IHwfEgDfbAh09ygNWHv4rHjD2xyj38jUH1gX
         o7QBbYoGbOQEj66AuiFj4q31edE9fTwQHT3BSK4A/LwhCN9OX1RENjb/BYOPe/YtKU9t
         0OrAKtzD7EyXisFJr91ksDs3drdGdGAoxqnOR5Uvw+Py3U9Ity/c3Xur299S5WdTmSGw
         0yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320043; x=1761924843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=are2xt86yIlpc4HL3GdNhNk2Nk9IKxa3I/LJcQcthQo=;
        b=d4oAEWAghbnLmoDT2vm9/kIqw0NMFMp4cKrDB6BoRgNJs87LOz4iva8nUb+mGn2isu
         sIrei62F1TKnRasGWCvyvUvTYytVrE9qQ4Czo3KNMwMRTr0W6HfXqmxiBSgs1xzI8X6I
         /iaAYHcFfFmQ4M99bEpTzfunBCg/pLqE4zRwxoSTtyXL6cl1j/Q8hBGoMtLsRS/81Hko
         i9LE/MSUfKxT+QCRZjCcoeyHXwZtLzzl0xPa8WtMkeUkzW4DcNLCHqDCWPZUK6YCsovp
         eKkSrBHWbpcNvApZZ6d979iLzYHsxw6VxGeVPYr4UxlIZ8lkk0gfhfiosoKzgSbDE9vq
         alEw==
X-Forwarded-Encrypted: i=1; AJvYcCWxShuQ9FnKekceDmN8O5RtnQUVP3mp9DEBuJ0uPwNprll6x8V7q8tbl3ArsTos966p6LmXV0IxVb0w0FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ztt0jfZn5r58A+vcCco6jsuHIXMoOQbs72Ei1mP8/Iuh1JUe
	ClIKQ0hg3fhW3qm/sG2vgvnx72j6c4FKiymcyLTp1sePk38k13qPGy/ngkmX4rSFOuSJASHEkVc
	hcLvIRgsedRPFJ6XplcgYnuO9qHXkmAYrwiTJp2iyoQ==
X-Gm-Gg: ASbGncsB/ffIugrwis45oIAn3CZ/0azomLe8gKRKogxlWb4XZ9JrsrmekzY6CXS/FBG
	TjtNw+5t72Ig5EV4397VIKwyNO3Kop8ab+VgiuZaf8VxvaDXUmg2uwXDkBZJ2vM8A3hF5ImTw48
	Npn+kdqsX9yUzrE64GpPhnfiFIprSeBR75b8p5SZvRpYIxGlCiPGsnGsjc6iN7as76yYN1+94k5
	TuFcJLFDPigrlsDWAs5l2ye7kyOewXL19NuStcxMRdlVPjiDIxXicP3WML4lNN8VA1l
X-Google-Smtp-Source: AGHT+IFfTkje+cUGlXkTFymJUSte5krNn/bEG5EhN31gNJr/7cVMgJy9Ry/5kSN5HjqZ3SuvQkYNIfXAVoLsVbdbd8M=
X-Received: by 2002:a05:6402:40c5:b0:637:e4d1:af00 with SMTP id
 4fb4d7f45d1cf-63c1f677665mr27513307a12.10.1761320043188; Fri, 24 Oct 2025
 08:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-6-pasha.tatashin@soleen.com> <mafs0a51jfar1.fsf@kernel.org>
 <aPnXVmD3cNmYNRF_@kernel.org> <CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
 <mafs0wm4ke2wq.fsf@kernel.org>
In-Reply-To: <mafs0wm4ke2wq.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 11:33:26 -0400
X-Gm-Features: AWmQ_bnJ5szaFV-enEeq3wfvmO3Zq6ympB-Z6lOOZF2BoJ-F4vXI0M6cDC_xrXY
Message-ID: <CA+CK2bARUpZaymPTusZWM-kzXcUp_d1UK9nUudu3tHitpeAH5Q@mail.gmail.com>
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

> If any of the kho_preserve_pages() fails, the notifier block will fail,
> cause an abort, and eventually all memory will be unpreserved.

This is a wrong behavior. Why should the memory that I preserved be
unpreserved if there is finailziation failure or abort? reserve_mem
should still keep memory as preserved in case KHO later will be
finalized right? I have tested that this patch works with kho
self-test: preserve, finalize, abort, finalize again, and the pages
are properly preserved.

KHO Test and memblock do not need to ever unpreserve pages, as they
preserve them once during boot.

> Now that there is no notifier, and thus no abort, the pages must be
> unpreserved explicitly before returning.
>
> Similarly, for test_kho, kho_test_notifier() calls kho_preserve_folio()
> and expects the abort to clean things up.
>
> Side note: test_kho also preserves folios from kho_test_save_data() and
> doesn't clean them up on error, but that is a separate problem that this
> series doesn't have to solve.
>
> I think patch 3/7 is the one that actually causes this problem since it

I updated that patch with your suggested fix.

Pasha

