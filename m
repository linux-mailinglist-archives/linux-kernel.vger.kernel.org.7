Return-Path: <linux-kernel+bounces-757903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB8B1C823
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30DE67B17AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1C28DB77;
	Wed,  6 Aug 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leIuBUx0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FF221F15;
	Wed,  6 Aug 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492603; cv=none; b=K5OWy/cJDjbkTmpwXjOo75TmPwHB1Hmw67xFpUF4dusCVlwz4zbc2A/gBUpHH9rWivtnANtNei7FpNerY7BudDMRcRqFM30okEegJesFGyQ+JOZVil+avoDC4IaJeGTW4/6qXz2DiHCNOY6ilYxmUprDSD5xXQhsueFucabgM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492603; c=relaxed/simple;
	bh=iFu0pWsfcILZb8LZ/l3Tb7SolyPesNFvt5mBj5bdVrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVE6IkrtK+RGsdxiQdi+QnW1bOdKk1NCArX2eCIgIIcf58lIvqL92QFK3ACrRXXL5eAbRpcFtGAdKozUr/HHq5EsOcbMVNRcTTDyFBKqmlHk226xLS8Ayxh4ZzHDH0hVhaFS3N/CxnRsmJ1GC7ldJ6Oaw3zDV6Z3oxHNgTyjpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leIuBUx0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1025129566b.1;
        Wed, 06 Aug 2025 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754492600; x=1755097400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFu0pWsfcILZb8LZ/l3Tb7SolyPesNFvt5mBj5bdVrg=;
        b=leIuBUx0ZESHw6icIrWHfbMxmK7Kjs01d1nWCaIpEfZm5RvO4AlftZb9UVEMFpJcTP
         A4qRrtZtsS15908BB74Po3MgrOi5cQqa3M+13eoeH8Mqr/QwTEwI/cRmfdtZgwdYIoWC
         GOR/D904korZ8s2KhhlgoGBbXQzdxyEzUazcoAj1FRc0TMHuM2Bg817aaHWasxg1YqQ6
         P1xqjmAM30EhWUgMsgRYsJqY23702N0SvT5PZKqDLIQMpZr6NpFXET8HhXy8ms4zQLSI
         uGtI9OozeJt6ZyIHKJE+/ATmnJJxVfjfqTtvYCjZ+z5V0X8Sc0STkt+gTBABYnB5v4qy
         O/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492600; x=1755097400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFu0pWsfcILZb8LZ/l3Tb7SolyPesNFvt5mBj5bdVrg=;
        b=aweahux/SjkacXSvV3hA3g9CPiUdk9a72soD4f7lqmiKLWVGgt0sa1S3ofQEt6xYa4
         SPRGbiLeSTgkBjbFzCAqhrmndDRRiK+G+fw9IA7ujY87inpXbsmDIUcBCT9/4tGjg4Lj
         HF7QMVVv20MDZGsrJrAnHCMtRB76euwY/tsZAFv92vqteCJq1qrsMIJwzWEhWTv94XQf
         CkkDIHbFiO5onOQwi6vDCfru1EDz2ia9Fy5Cwz530vfAxCxvUOjqFQhyQ+EQH1THSI8l
         BJFQsaP3jyU3iQNTGFN6kmiSBQw9ZWEtxnc1MyisA6FKIQHHaN+OfweZ5Ofsg/Dy0Yls
         l4bA==
X-Forwarded-Encrypted: i=1; AJvYcCX+mphohSgC/U8VL8vna19BBLXW9f0kw1t2rTICx6UHGgkVzmJM5QsJLitwv9ZK2a34UMpo4yt3ynesrib/MNyO@vger.kernel.org, AJvYcCXUXhjH132oaS2RUaRoduHVAQQOu6JCWkykLhkk1ZrEahEwPFoEPAPFuyhH2q8C2guoD+LSifAqDD3swC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6qvapkLvorO0pkwtSh3LBtfkMm/Pgjc6b3nplpSVNq0gzm3b
	74zFodLU0iNERT6fRhj0sH54l4B1g1fAvLVBsR6/X2tNsmY1uKnr7J1sxd61jax9BVqkkq5zbPK
	vb98qFxI+LGkwPilJIsksdQjPiB7oAPSE11U=
X-Gm-Gg: ASbGncuAUhIrlQUy9Y9Pb6PySwGRadK3zdj6H19SdnV4hroFtTOzyNjDflehVh+GbPL
	fIJuvqvfmaWjBKgmoRMk/EUf3JVl4hRQcEcO4TO8doiYTAGwQd8U3y6Cb83/hdcE5tIvGyGXHQ6
	Ti0fPSxpzNAk2UMUZyy8CQLYMlEb+PsztWNq9wMhL9VwKg8tjh54HOwYzTrICFDlBqE3sm8oE7C
	/L2gVW/
X-Google-Smtp-Source: AGHT+IEZYVBGGdm7ifa/677lkbqiMDvUOGxIoRGGZKM7VIEDoaDXaXHDOKNKwB3i6BTpzO0ipF/19F6/rdK3/B66Aac=
X-Received: by 2002:a17:907:1c0c:b0:af9:61b1:e180 with SMTP id
 a640c23a62f3a-af99042fb75mr332188266b.41.1754492599426; Wed, 06 Aug 2025
 08:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250702152057.4067-1-ujwal.kundur@gmail.com>
 <aGf_W_ZgIf63dmAz@x1.local> <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
In-Reply-To: <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Wed, 6 Aug 2025 20:33:06 +0530
X-Gm-Features: Ac12FXyBN9EIPVNc1w1eJK7DrGiyYTVGlwIjmM8qS18Y2yez0bBv1aehsTuPYTs
Message-ID: <CALkFLLLoXfTNtigbcyD4RdJfY+b5Rh5-5Zta1QM9dBQxZd19cQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, jackmanb@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ping -- please let me know if there's anything else I must address.
I've ensured v6 still applies on mm-new.

Thanks,
Ujwal

