Return-Path: <linux-kernel+bounces-796980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5BB40A51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CE23A4CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5303375DA;
	Tue,  2 Sep 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pno2CNkH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1A2B9A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829643; cv=none; b=fPaWaOLX+Kf1B07qOr33xWSM4zigD+GYFJZtKxkG43BpSfEpzmq3d2kUCmKBidmjCS8NvuiyWZarNfQsze1AaXe3isqH8iDtmL48T2XjOCyjFMV74HqiMsUhrzhjbAobA9QwoYBRznXiuOwCF49l18FzUAxb3v7kjaw72MqwIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829643; c=relaxed/simple;
	bh=jytiQaq8S3k51Q/Ee5XOzpJH6a5+6DrfPCaoRasu0fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srb30vAVZm8ghqW1I8a93HpmDB2O0kmYcyWX12pz8USJi2YAd4+n5E7m1io3yUY7aUaJ5TBqPpSBZoGsPQyW62W5VmXEQ4kSb22WWo/nj34yE9tegg7jFQgrzx5o627enYlWGLawJYRPZOCQBXrEfjFQ8kX5Lj057gdK2m+enFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pno2CNkH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61ed395ba46so2881a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756829640; x=1757434440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jytiQaq8S3k51Q/Ee5XOzpJH6a5+6DrfPCaoRasu0fI=;
        b=Pno2CNkHl+6p+yPhaXbldE9Kni5onSJ4BWjB64MilVpwak0T2AJEYeQXOfx8ZX/Cp5
         XTAZCyGMRotLZFMWS7NZ1fGVMfFWJdM2Dd8hHXxpykfgOzewrcwc1cNOPmG5iv7B0sJb
         J9jioye7EWDqCJ/hXDYoFXhmVvn8qGnHAhTsoFCb26JT9IORNm2RQj+iYw1ZXdIczSwK
         0BTdFs8AY7Ryxiw918QE6OHmjFggqloScAS0arR/cpv7EzCkrb5dkigAOcZYub/r1MKp
         DHpckG7l2Yz7YTPthe8xq9pGAfyoJ9DZ+20UopPO15kexrBBXVNeyTUoQLILiDAWgC5A
         e8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829640; x=1757434440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jytiQaq8S3k51Q/Ee5XOzpJH6a5+6DrfPCaoRasu0fI=;
        b=g/1RvtZp8WTbAXXHyl/McNNZgLS5NnleXPmbViB6tbX8GmytTdosfKYXhXFeJSylPm
         CF1FAQys2TOQJQXb2ha/pmy7X2zQBs5XpfdBK97v4GiuXGdvTrMD8OPaQQPut2g/5CLn
         XVSSzwO3+DBu3SwbzzyURxwYEm7TSuwv5Q6m0Bjky+M1mOQyVr0lle34BEEYGD5W8GNS
         M+j876Okwn972ZGqHXOzViyv5Rlpx5N8T/VZLtBztSjg5IZit+ZAwydlHmnQRTpHeBHT
         TAA519S+NSnHAjeutQlL/VUlD0e6dYVSYWblXQpaqIyGxazVni0lErw9Mjawy6m2mL+0
         eUxw==
X-Forwarded-Encrypted: i=1; AJvYcCUTnUSXEuV5wc3+zU/SWfDdYjaWP6xPw5M+g/CtBd3SiR2sZG+qoG4j6St96GeUhI18WP+QYRxnMlxhuzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30XEDCCymg4Ih1CG9wxEekFGCV0bDeZZ6YNoUT0bjvbVWm9eT
	V0ZK02iw3/8n/n8AwiSjVcVPZXNV8k32JcmC1lxaXGIaIXR27z5TaEUAozneO7e5wLvZG7nHyGO
	9uLUweGFgDdAzd66mfF2zGCSKITHqQtqxT9RdYeyY
X-Gm-Gg: ASbGncty4FgI5J/ZH7ogAa8UXWJPv53DZe3ZXreEO+3uliJQcGN3uJ+0Bw7XIXL5UUL
	3OTBO6BfKd5jrfL/ZKOhva3PI4ZdHk/vvncGBcFDh/+Xi+UTmJUGsaj6ZEa/I3MILlZn5Sm+koK
	LKm5tMZJxnELL4MXc8QSAsSgAr5piS0QAqqDHUPV58rRmUbLVIKqKsj8D70EBmm/xZzExerXSgX
	MZZ6G2sIb7lvIEuerNKKXX3EqkfES5BzopdTF77swgoTOz80IRZ
X-Google-Smtp-Source: AGHT+IGEaYL/6YHpIvXgBQHV5Wk76XcCDRpGWCraR3NtcuU4rAn6Ck90h/ykNLFpnEGnjKO50Et6jzVvGjXPfXbldrs=
X-Received: by 2002:a50:f617:0:b0:61e:c6ae:7a58 with SMTP id
 4fb4d7f45d1cf-61ec6ae7f13mr61921a12.0.1756829640144; Tue, 02 Sep 2025
 09:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226030129.530345-1-riel@surriel.com> <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com> <CAG48ez1q_Sgk5nr7Bngyt0UB3FkYb6e0cHv18wqD=sLEdrZkmw@mail.gmail.com>
In-Reply-To: <CAG48ez1q_Sgk5nr7Bngyt0UB3FkYb6e0cHv18wqD=sLEdrZkmw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 2 Sep 2025 18:13:24 +0200
X-Gm-Features: Ac12FXwyx0L9zIZrTUl0hsCo4DRTysWot4oLg__Szbm5KqsLu80QgAIdMR5Q9ks
Message-ID: <CAG48ez03UYAdqZcQxG9ejJFnSNE=ADU=mn-_zk9fmyBzTHo7QA@mail.gmail.com>
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, peterz@infradead.org, dave.hansen@linux.intel.com, 
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com, thomas.lendacky@amd.com, 
	kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	jackmanb@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali.Shukla@amd.com, mingo@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	baolu.lu@intel.com, david.guckian@intel.com, damian.muszynski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:05=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> To me this looks like a change that is correct but makes it easier to
> hit IOMMU flushing issues in other places.

(This was ambigous; to be clear, I meant that 4a02ed8e1cc3 looks
correct to me, and that the suggested fix doesn't look to me like it
fixes anything.)

