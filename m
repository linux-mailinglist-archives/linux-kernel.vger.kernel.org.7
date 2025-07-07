Return-Path: <linux-kernel+bounces-720505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADBAFBCAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B5422C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E7221F01;
	Mon,  7 Jul 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eTIxVTc8"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A821FF30
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920782; cv=none; b=pMYoPOYK4ABlBr2j5WJKgdafGrt8Mm+9y9rULZgOkLwcBl1+pmvwaWWci4j1lm+4Kqod9cV1DLfEWpVuUklAbYUbhLfH9seGR6yVO4tTJrClOF6uN/0XyVC4iez4Q2fLE1j7WRSw4xDs/XaT3lUM8q5ZmvpuNrzFRzhGBO0joCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920782; c=relaxed/simple;
	bh=DS0Ik4lCY6Q+xvJbyW4/tfkU5AzHV1B2sGMi5QtBO0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1yyLKnxHcLHBlarV02dHUz8sZ/5cTPqFxlKOxo/2ZEYmJd2qOZGUhIZ+amrfN1L3EkpWeuGg+DZp0NHXfMwFROv7NMOHemIqqHLVpjYPREdKolwWkO5q13swIQtrq3tuUBCTKwKHW3eWl/WoXeGZJK6UoZ0umpoJWEfPHs5ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eTIxVTc8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so770276466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751920778; x=1752525578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wxneTq/NEhl6VnNWjnUkmFTXqxmN3JS5+IvNj36XqKc=;
        b=eTIxVTc8hYc5y5tFaRCM1TcOUi0i5U5g9sfFpeDy3uEYriUobPWV2jimNU5n5ZIuPO
         d4eUVFNsr0Lfoa1t9Dv+ucXu2BFmIlXWBJroX9cAJ7xAHkolqasLbmKC9TfOmUBysb1/
         CHXtxmnpL1VIKMs3+qtw8zEunLRN1mzhkqcU/7NBDsMfB+IVwlWpWwVVxJUSB1gaDK4y
         10eVy33W5RKQo7H07NGLVDAEDyNNSutVWhuQ9XFZeJE5A3ReLGkhQpZ4XUpZLu3OHOz6
         /CnKLfuLgWpg//MMv4EPDuHxu9p21WNuo50Y8FZzIAcNZDEGNyCR8AcnnuYPw9cGZMwp
         0WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920778; x=1752525578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxneTq/NEhl6VnNWjnUkmFTXqxmN3JS5+IvNj36XqKc=;
        b=Mc/oGwgp1a9SZdnsXbr2adv+PC5Yo2ABmH5nk4f0xKU63XHggUZlLDzkMMyzAkXKxX
         3mw1BV+0BOS82vFFm1qlQhPIF8X7w1tq8gtfZ/ZZXLYln292xzc6BzRaxUPmhWYM3C19
         gNxpczCNZ2Nn4pbNcvMnLCDuxlia5vKEf44pQ5TzBTRqr9Lkp4iDotpKgl1OPYqms/bQ
         PRD9Ibtz4yFI3rV144FSTXanMpqinI2y/MEG62scgpxkG8cfr09adXPP1hXEitsaB+TY
         WjPOQh+akCd5NX7UbaitnRnOzGALNSeqZ+u1QMfcXk75qTM0PL3nEZtNuuQKuzGHtTKK
         0G5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiMeuHcDy7TftEQPsTPU0nD6YLAUuQF9Ud0j/zKdgpkFv6t5cLbdAJsHVWtJqzFvwVFUb0lfttnV+voh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYn7fa01GFu1nSgNfpikPBH2xLlN/cS3xgAylKqG0FKvj+30u
	Kpmt++abIQfRXARodcbe184yodkgVopUIMQ8pO8hpfCvczS8Nrp64shHfMYzD2F4WuBEGiA8Oug
	hhIUWw7jtARzsxB7kChoAtcuzqe2HOMLqvc4uCedHFw==
X-Gm-Gg: ASbGncsnIn15aJ7pHlsTUJCZdtfWCiIDb5Mw3AHOHGCNHrYKLRsELI5e7HXt/9knHKZ
	WUw8dirqfYtQhAoePSv2Hf0+cfdmBviKZLWJynVD91bbMGnFIk53Sbh0xVgG4NUxD6GFezwclKM
	OfX+s+BZ1HKUH/IYqyYHyMXDrKi9PzslDKIhBJVPEc1Q/BULua73cigzs/qPQxaZd+sFT6FsE=
X-Google-Smtp-Source: AGHT+IFD0kxT+rxwBgYryZvBpViuuGbUUU+OvXDXcQVMrFJz/GHF0CiJmFY0JzIyqNJf2bDWYdHKYJMlmYX3uupYorY=
X-Received: by 2002:a17:907:6ea5:b0:ae3:5e2d:a8bf with SMTP id
 a640c23a62f3a-ae3fe5bde90mr1373459766b.14.1751920778431; Mon, 07 Jul 2025
 13:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk> <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV> <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
In-Reply-To: <20250707203104.GJ1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 22:39:27 +0200
X-Gm-Features: Ac12FXzvinwPocSJyMmR80b6ITnmJc5FsPq_b5MBTNt-hi1_HdEgvQERnOThAoE
Message-ID: <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Busy loop here means that everything in the tree is either busy or already
> in process of being torn down *by* *another* *thread*.  And that's already
> in process - not just selected for it (see collect2 in the same loop).

The busy process isn't doing anything. All it does is busy-wait for
another task to complete the evict() call. A pointless waste of CPU
cycles.

> The interesting question is what the other thread is doing...

ceph_evict_inode() is waiting for the Ceph server to acknowledge a
pending I/O operation.

