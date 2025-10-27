Return-Path: <linux-kernel+bounces-872725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 113B6C11E21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23DA24F6100
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E6D334378;
	Mon, 27 Oct 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUievGYk"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4F334367
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605090; cv=none; b=qTL9Nb4qYYPay0Tg52GjC6hPvTymUmiTe6vbSLm+OBw2MViDwyJNxVyTgIgsP4w8vSAMJTNY2tLOA50No3UHelmoWiuU7rKxYTy4332WjcAzatD9FHsHQxlXGitUXTb0IlZCu66BgNwd4XoNuXFw9p1Nzzxv5Yp02gzF/6x9rNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605090; c=relaxed/simple;
	bh=mpFgcIdHbFI/F7QbErGEpVQ+1+4Natrjp8cskIzQExM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFXCMgNEf06I78dOwKJHOeDn3jqlHo8JpH2J8DLf5eMfhUHCFy+xTDNvnB3G7EZT11OGS54cQ6IJ0xf/f+y09yuhuPICEbPn6y+mm0y4R/zQseIGTS7JYZjXHRCq6twcL38JOblnU+izzchL3AVSuaZTkAllMAik4GR0maPrj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUievGYk; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so3865468241.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761605088; x=1762209888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpFgcIdHbFI/F7QbErGEpVQ+1+4Natrjp8cskIzQExM=;
        b=XUievGYkrGiE0sHUbJ8sPRwbOntBSBv59mlf82qg0knx8X5xWKiHUX4tHaMAOZOWq+
         TfwspFMAjCcc461Ao9h4L7bYStuX24aqWk0rNTV+pkKiAXz6RdIMOPf8Aee7aps1Q2IV
         njKTn4GkidWb3hNKU/XzO1TcqPTxWvTteSuKMvFnNrJMOqdQSyWrT+clT5bagXLHbNx3
         1xcNUleY/4yZC+7gjuMv4zHMb4mQUdOyccXwBREztFu/dsJsH43n6hHOqpySQPf1tOJ7
         AjsSb2qOUwOk9Ny+ScBSYkuPUWENytx2irXYLonqdozL7zq4b+E0aRH56gF86Xt0jAFp
         fFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605088; x=1762209888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpFgcIdHbFI/F7QbErGEpVQ+1+4Natrjp8cskIzQExM=;
        b=QhGACfa3RwsWUyaB9ofTRiTzkMNXDcKSjNDUeu7B3vTzw/eUBcTOroqQTn8pPl+biK
         dftAUIkEyBECMFC0quuPTnYeR2tZH97ZlgE2f8ALPy7q+3GncF0jJDcBDIns9MbISRxV
         ryHLbOckGsg4jAS4MkQbYDoJFiUNB3oQA5XkQYfyPrBkfgZuSCtPsOBoYjc82WfPF7aV
         Bm7dNBn0KlqVINPCDHzvvtLucfZagGw9dEgnZVryQbbGJ2vIFOuYR5iOROo/kGQFIUvk
         qdV9UhGNLx9WF7KBNHAbBsPz1sFRMOCRPMaRZJQrsX/GM3eC89/tyhB/tyRz/4KRFJU4
         0EiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTOV0XrglRVD9zY2YrahSoTFeJMcHhkhYpCVimU9fg9vcQ0i6lbz/bHLqTUBoNWeYdElo7qJcyRTMR/Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRxgKC8NZ+nIYM4hbOfQ6tD8ph+B9PoKCNkaFZMSPWnUJNN4F
	1mx5ZLYD6mJ/KUri/rKBSyg0tLgQ+xY6fQh0542zlsS5Pm3UBvo1ddxCitWzcUjkMtqKPgIXHbS
	vJaXDApKJKgTddSu7ORoaOHungJOL0bup7Vt/2oUA
X-Gm-Gg: ASbGnct/PCXA8w5usx+qY/26O1D8tYacDWYZvaYgWnuCoRmLcxuIRviHJc3TyA6Odc9
	Ak9KTFSCsdxeaRPqaoWEpbEh3nqAn9JzHAYyf/Rd1qAcPdds2cao164mUk+antrf6Pz7mWahNsB
	qPDkRn2vs9gE6T7NRN3dWGZadNIxZTVgHOpCmNC96/2qTcOLNoNxcGK8hv0yZOkC1pgUhSHe3Bb
	2ahU1C6Lv8iOA40AIVsW3r2G5rYDlNaipmdtUcRWi1J9v48lRe+QvmuwuI3O+FFjWIG8PE=
X-Google-Smtp-Source: AGHT+IG8Ejwp50BSLB3roZMqzNKK3fdMxgSprm5enFcaaSJHsvTJPOSCN+WzTYJlIeeVTdHuRCAFpYySmA/1mTyvWxw=
X-Received: by 2002:a05:6102:458f:b0:5cd:e513:384d with SMTP id
 ada2fe7eead31-5db7ddfd811mr330196137.0.1761605087687; Mon, 27 Oct 2025
 15:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-3-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-3-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 15:44:19 -0700
X-Gm-Features: AWmQ_bm9flIwjCIEktZFbqFsVLPTvjpFwWRND4pJrUQRYbrA52ouzPHjdJgenhI
Message-ID: <CALzav=cprjK-WutXYKii28e37R=F7jPZfA5_=_Qh4HH5p2Um=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> KHO memory preservation metadata is preserved in 512 byte chunks which
> requires their allocation from slab allocator. Slabs are not safe to be
> used with KHO because of kfence, and because partial slabs may lead
> leaks to the next kernel. Change the size to be PAGE_SIZE.

> -#define PRESERVE_BITS (512 * 8)
> +#define PRESERVE_BITS (PAGE_SIZE * 8)

nit: A comment somewhere (maybe here?) about the requirement that KHO
metadata are not stored on slabs would be helpful to avoid someone
"optimizing" this back to 512 in the future.

