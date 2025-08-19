Return-Path: <linux-kernel+bounces-775940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935DB2C69C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F1E1BC53EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE717218ACC;
	Tue, 19 Aug 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J0LjJdue"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDB2110
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612454; cv=none; b=gbU8qqzQKoZYl/T18M9KQ5rjKrCJe74Tv19NV8/Eytt+2H/AHwI2XxAeC3jSv384xTNoPcB8lbHMRBVALqJMN9Gj2ilfoBr8YIZYqq68NisY0hfa8txrM+OGlSuOWytyW52JYhEU5YKHt7uy7sPZuFlkPFadhDoZo7whD+lKIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612454; c=relaxed/simple;
	bh=I/r7XFfAmZT7gE1c9PozZ4C2qUQHNUKLRFQPvVIdUC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdgEHIqLaAWI6XU/vGdV+iqWZiXYkGyEXYjQiiL5n87YVYESQH3T0srxKMuIK81VzhL3KuDevkO+azu7l2+wzm7Nf8w7xfAUDid/LsIscYq6Pt7OwvXc8+aigy7utc2a+m8i/5Jd3lIN5YK90Job+Ewgt6w6qOdIC5JMumsPL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J0LjJdue; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b134a5b217so27644231cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755612451; x=1756217251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/r7XFfAmZT7gE1c9PozZ4C2qUQHNUKLRFQPvVIdUC8=;
        b=J0LjJdue71a+qYjzMx+CQjn73jm0Od0nLJupjShdsW5TAaD31FADG4T9WR/Aad4bze
         AlJerWoK1jvfGIwMRp4AyM7PRC8mMwW1Wy6Hjnmrx2kw7KcBvUg1767NRI6Z2DtGqZxk
         n/z3ztMa8vs1BeCeoMKAvxtjcY5HCCbn9Hk9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612451; x=1756217251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/r7XFfAmZT7gE1c9PozZ4C2qUQHNUKLRFQPvVIdUC8=;
        b=PQIui5nSGDa4sRJaTvNpFeWLmUTeQIMJxvixo8RCoIqPlCitCsVlP7HzA4fKbmLSKo
         5+iuHk1PpH9vGd2snEFj7kLBqvEEVAtBUSCUYf+qTd78DY1+Oy++lPG5ywH/rGoL5fQH
         VD2zEzsQFdrv8AcAcJ450iVu/VAGJNghs2y3EWo8zvxTALJ6nH+6CgCF7YhrY5fgcC1v
         Si7K1LnxFIlPIkCvzkbYtKvssT8PjxhrosmrQaYLM4CG/ULBcDas/10h5mxDC/CikMrN
         y+3b0gdj6VUN4957hbTz7Yt7taWStEJfGIfGJwTT98Q1ByoWSCWHapEwe4tqsbEJn+qo
         Nd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeWz2d/70oW0UvMhlJKpfI8KpN6QXOfFZrl2xjV0l/+TaVXQTCDY9kX7uG/l43wZkz3JHPopVZzve1sp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynczYXUS/PBpUpynBxfk4MfVn+kzL21edyAVXX1y4Pg2PkmNvi
	8lEcwojgY5ClSPKMZoEUTsHFgA0Yf7exzxm63tD3jJsCU6T3GSN9MC0kfhFutJn8kWGYHpu3rtU
	X6XUEewkfIXNwnySWyZpC+SMXEIJWb1i9ueHeklUxkA==
X-Gm-Gg: ASbGnct26A9Uxy/sBWHcEIh4YlDFZqMVhK/661A7JPFhCtNrb0dq16TSKvPzUOMTuK/
	fNc0lveAE8oDCSAzkI/3L1y8asGvLU4Ad5vmeMOKweGDsdwUqKiFYvGstf8Wt2FBfHyqWq4YD6I
	r6NK39Je3eOYORMVU29CGx4RyzbGknk5Lb872Z0788EV8CVbAbbksNj+FKrA4i3E0m0yf0Dr+pZ
	PlfYRCMBQ==
X-Google-Smtp-Source: AGHT+IEm+RDY4x+KUMjDy2xSe/+nwcq7x6ypDW5zM5ME3kChnUS0sUlVc9tK6EdPKsiQBcM6wp5ioyyEcctMgWEXnIE=
X-Received: by 2002:a05:622a:1801:b0:4b2:8ac4:f083 with SMTP id
 d75a77b69052e-4b28ac4fe9amr13087951cf.65.1755612450990; Tue, 19 Aug 2025
 07:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818132905.323-1-luochunsheng@ustc.edu>
In-Reply-To: <20250818132905.323-1-luochunsheng@ustc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 16:07:19 +0200
X-Gm-Features: Ac12FXyDNAF4QEKI6FENCC8ukwJbwkgNXuP0OKFGWgQOjTPz6NfZYwdmQefpnMI
Message-ID: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: clarify extending writes handling
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 15:29, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
> Only flush extending writes (up to LLONG_MAX) for files with upcoming
> write operations, and Fix confusing 'end' parameter usage.

Patch looks correct, but it changes behavior on input file of
copy_file_range(), which is not explained here.

Thanks,
Miklos

