Return-Path: <linux-kernel+bounces-859083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F01BECAD3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF52442139E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C72EB86C;
	Sat, 18 Oct 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+YXrvq1"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD73BB5A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760777318; cv=none; b=IjK+SHS9fBSX46d9UskPoW8IV3T2xQJkDkpZIuYNPuKbr2eRzRVpn6FbLhif6RPiWhwqUlEq7mhuGckVyzQQYCso5jm+nSKuLNlkW358ykV9lwth60HzWWqFyjPQtVu//41WFfbdNPamFPPHFq8+gTEDfMPnBdFnxPFIc9V7U28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760777318; c=relaxed/simple;
	bh=krVQ/wnpCDpBBy+ZH1VvhMN0FqIcllfCgJaAQCKemmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gJnxzz4CRqbTl5NFeKGBSAcgxCV3osVoWBQHnnQ+zMjIbfTpLuYDkkuJPSYkK71MfENDgD5IYEzgfMS83QCf862re9BEnehEVN4ucrrnfhGc9S/mwEhbCZYXRIRqyalEbBBCWiPmaPN/Af7GAI9DcC8P3xA13FpSxWuT1KOg/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+YXrvq1; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-92ec93a8ae4so63343241.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760777316; x=1761382116; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krVQ/wnpCDpBBy+ZH1VvhMN0FqIcllfCgJaAQCKemmw=;
        b=h+YXrvq120n70r73zXKdOn86Gptfmet3C2xNR6vi2VfdQRHsw8ZbCx/3+mczysQuXY
         3I0pHfzDXEc2vU4Gy8OYgjYeZNFFvRfSWf+A+7bTh9+m7g00EUAahtNYgxgSnXU4iZjc
         wM+/U6Md90qsgW3H6jUfghACI2iIt+5NA5fZ80x2acjWqNHCp6Dc1jIqXe3Fpz9eDUTD
         /8KKSwPMDiiLRydp4dkmvf+LlHrgbfQ2qLbSeO8nEdsu4AGp8SbibSAssajsXvWMofxu
         DkXfJ2fJ8EwPlPuHitrk1ZFEYRusmWrCsqFZKXvajA7VDHEf/r7e6T8pqZRbB7ltEI8o
         bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760777316; x=1761382116;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krVQ/wnpCDpBBy+ZH1VvhMN0FqIcllfCgJaAQCKemmw=;
        b=mD25vL06ZzVVexB9rBAw2cDmIcohXEYAsu2HGh07z9ZeY8cuZNuhZESkozsjWSnhor
         Zrp1by1Zsv/iM7AlihRFGsx+FnAR0dHY5WI/fp+dHcpkOLpaQyPzxj20H2tJ25y5uSNd
         4HH6fvMccC49MMfRnKtDkkLMDab2bwE7gv9Zj4pZrSEwyOj3L3wHCDa+EaguLMlwPjl+
         u4HjMEWnAOOtJZGzDy+nqWmreMtezdmuM0WPeq6Tj2k3sN3uHAiAzoL1N2IUmBo5W+Jo
         jwb6BYnafmEHdCtbefkqnO/wuyI+n2HntV9HcfZMTn9Q/j8RB3+KLG/TwKQFT7vs5mFs
         2QTg==
X-Forwarded-Encrypted: i=1; AJvYcCX4w4SU0TtiINAgkpSDaT3fhVFQzKyWakIzvFaUme1MFBKomsTrCI432THlzLaCCgxMMHyjy4Tm4XbEfOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mvTq319iKXVW4/NlfuWz354kcIJkN83ScwCsooh28vNTB/5z
	6t5E2/R9U1BK9Jn2t8BhCTT3NcKGdHXQzBbkkOadeeH3vRqkIIQkjw4ThbgIWbM9Bif1TE2pcgR
	A+H7iWRh36rsN+ji0l4C9oC9GXbYnbDw=
X-Gm-Gg: ASbGnctqkxRDo0CkVQ5LL3Z7tQvfuTdxDGNY1M7r8ls6JO+jZYyT2TNw5ZhJ0bgPZ6/
	7wTS/8x4zAntig1rHi8qEnNt/pyEULP3Rh/v8fQtWshJ8pLlxflBAFrmqz0L7yba/obQ01VzQ4n
	l3JuUQkMxecmYh+YgzHVR6fU/TIebuoBWuppbMbRRTQDR6FUuRZ6kp7J6tYSq34OANPKTbFljiX
	+GK52+iXDiXvQxyNTU/gNsB83t0pj1M0YywJt6hmhGKIxoaRmXxWVH0l3TGNtx3GpGDNEEf
X-Google-Smtp-Source: AGHT+IH+35tkoNkDZi4Kfek0sHfIGm6qquzzBqilO88Ji27d0+BF3jHiGdftot4dUKA6gHYqHTNj90YoNLdNHjUPtCk=
X-Received: by 2002:a05:6102:3a0b:b0:5d4:460:8e6f with SMTP id
 ada2fe7eead31-5d7dd55eedbmr1141234137.1.1760777315808; Sat, 18 Oct 2025
 01:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian <christiansantoslima21@gmail.com>
Date: Sat, 18 Oct 2025 05:48:25 -0300
X-Gm-Features: AS18NWBorZOBAkGsNXDT1dJcGL99kDvhxs1VBNaQlHzRAkXFiimDIYkW6xXq1i4
Message-ID: <CABm2a9ebHfFNatSAsjSCTmRYBa1UeuhnDj8nZtGnKWXiCXOpHw@mail.gmail.com>
Subject: How to start contributing?
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I would like to start contributing to BTRFS and I would like to
know if you have something like "Good First Issue" for newcomers?

