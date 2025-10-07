Return-Path: <linux-kernel+bounces-844883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC1FBC2FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99BF83420E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BB23F42D;
	Tue,  7 Oct 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkssbSvt"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F323E35B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880864; cv=none; b=n0b8mqO2Y+jw+HZCZsGe1/GgxAGGBGoM6mH1ljX18ZOYRDi+cA1BQcgK62Jg9UH7ldaHy5vsB/IeRZt0i06N0mvAxAdf/0ujrhupedHl4Iz8soNEB8kHSjR5Bib5ygGLfcps0AE6HRGn2/GEC03BvcG+pS9BshDc0rj0s//Wlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880864; c=relaxed/simple;
	bh=e8uqJbociTCPUWHWK2qTozHBwaCrC9wN6OtLhywvsgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISubPwtfvZvYdOTMxdulpYMom/HCDqT86hTBgpLlftFXUR97iOJ2xirS+KxluRX7VP5Ygd7QWBgnBtujTbglxLjibpZ7ET/GFMXrQ2XkkqtxNn/PKIHRqDJ5PYN8tbRGiF7xuHGUI5l/F//T2kmUMkr+1DNI05Ht4dxrJr8uDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkssbSvt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f62c671a3so22975515ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880862; x=1760485662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8uqJbociTCPUWHWK2qTozHBwaCrC9wN6OtLhywvsgk=;
        b=ZkssbSvtPYvpIHpkkZ1P68dueck+sOhIe4i0pqxoX5xJf8LrAZAgT7T0ISa1eopicB
         ICtnL1w4qibLgBUE8IkZ84qhYYk1x9V3f9PUqfpx+e3y9Q5hYWzrodmYnJlEqCR/crmD
         J/f8QPo73cUFr/LRrr9Gy1k0M8wIIPPdLshyRIjIYbz+gCqryvqMG6PvrNf8uR1o/wHP
         1kGlp/ddkGXlOmVJTsmAlNn+YLh9mNGBKsqRtrpB5ldyj4qTx7WaAJ43K2sH3W1N3GXw
         jXytsqKghndM0kZdVzx+i1hqiO5XfEfcS2cG8ZN3d0IKPEB6tG7hhFw4x5nm9tXarakg
         KGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880862; x=1760485662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8uqJbociTCPUWHWK2qTozHBwaCrC9wN6OtLhywvsgk=;
        b=MGUTeqwNDjocBBImYvRmkIf6aFSlwCOdHn/rEdnZG2puozA2xTRRmD8yls9iS5AxBq
         bga58P+ufDKhd5H5tRaaGG49nAxF0e/E9q9ERJ+jlM+Q90MsYd//NaLWMy0GHXSGbgLw
         E/dtVHo5AVHV8Nyv0bPFPImpDYrOu/HV/idRDBfThCzMsWzMKWnStbPEikOXfSGcOLed
         tg5bEGrwOOZhxIQXu2bVYnkF8nxGnTr7OacDZ9g/n3HTtsXObAq8W8GWNr7Nay12GPV0
         MI6fH60o/v3bPPDqYM7FKnpEaL2TMg6OW/QunMYGXiNisSk9D74dGQx5yg5i3rD6Hu0+
         2p4A==
X-Forwarded-Encrypted: i=1; AJvYcCWRDdhvfWmaWAdjXsc2fSG67DGbDNxicN7YqxpUVGa14FiWnDAdw05sALTg5ifDvPGp0GjYpqPMeUOJMJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxbn7f+UrGPtdyqKMeWGF9by7bQVe+wzHHn+ANMd+Zrgd1b6Z
	YQFdodgskcnTIX6HlhEf3bXj0PUNIKLA1SpjMZrPdclCt+vmOkBkTJalqmvovbfHNs4hgaKoIqU
	uYLBtJ7pD662fA22Ou0U4dvov6jqCFz4=
X-Gm-Gg: ASbGncvpksuUzckSfggTYbeckyKSVAXD/c5qw+sL2c2yKgBok1231LbeANfHqv3R+bH
	hnnATzVb6jbMsXCB9KUi3cTr83FSK4aG0WrCibTpknHw/AchoCFjCUyahJaKn2ekb0Vlq/GAOTC
	mROlHw/13oZ9EUlptcUtugTil5Zm78DGM4kA3aJZXzay31mKBXn2amon1PHmfk3HKPUM1UbRbuW
	1ga3bdKS1WsgWAxM1h1WQBkwV+jq3rm3G/VudEFDbZCm0yFS7+Vgw002g==
X-Google-Smtp-Source: AGHT+IEOJY+PdMJ6V7JuvY1Ev+IpEta4MF1QsBaLVOP1B3MDOAgcBn3U3Oy9frc2219+tl0gG9cbLnSiIgiHzr58/0k=
X-Received: by 2002:a05:6e02:218e:b0:427:d62b:45f7 with SMTP id
 e9e14a558f8ab-42f8743ba4amr12086685ab.27.1759880862230; Tue, 07 Oct 2025
 16:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Oct 2025 16:47:31 -0700
X-Gm-Features: AS18NWBHmLfrrKKqG3H79QtZObTXiBcAvofr9N7p5pHKmfoJZayOaz3kmQE_c2I
Message-ID: <CAKEwX=Oa3HPQSE5rrFh1DdfoSMtZ4Og5cfTyri5cOqHYzjnkDg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm, swap: rename helper for setup bad slots
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> The name inc_cluster_info_page is very confusing, as this helper is only
> used during swapon to mark bad slots. Rename it properly and turn the
> VM_BUG_ON in it into WARN_ON to expose more potential issues. Swapon is
> a cold path, so adding more checks should be a good idea.
>
> No feature change except new WARN_ON.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

