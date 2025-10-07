Return-Path: <linux-kernel+bounces-844574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBFBC2403
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E88D3AA5C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761E2E8B9D;
	Tue,  7 Oct 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCCKVWet"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD882E090C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858126; cv=none; b=ObLGUhOtK1Pl9uzf0fP8dwR4ZaQMs2Vxkf7MYN7IX11s15emf9RTWoVhrt7Zgng7V81YSbRSYubDRXY+dmRorgdOkpeLYJc2Hf5vCAGTxVXfVmPep7NXxnvaRF4Tmp4zBzsUcEluDbFkT1Hw+yVxPKE9U4rsTj5P7DZBFyUBWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858126; c=relaxed/simple;
	bh=2iGA8velqQRRCZJfqt1BqaTxz6Dq18/F9B0OZGpk+AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8ZL+GL8lgC8I1QtS2M1k+bESboExkXzOQIiLesVznsgGMEEa1hQkNp2wBp0msXsLQcmXz3ay6MzAEhT1kZV4nBIq9nYJ37MjejS9v8ThpKSiBxVGyVLaOvWq0IKxfF619vg3oiRmBVyxYtSedQOKvqIG1nRzv4OgIMFtR84p8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCCKVWet; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2698d47e6e7so12098635ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759858124; x=1760462924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+z1+ZFlIhihDnc0DazYJHSsjaq/b1tc4ebSOM/fyJo=;
        b=FCCKVWetR7ns15iFkRfydXfrwIXjbirMEWatFdr5VVb0+V7sRzxiZ9G1OiMe+wIe2e
         HC5mU5WZgQJJQjbRkx6sLRe0M5HcIi+W9KM76LXww5gVZ5REDy3FHMxKjCrsL2cyFoLx
         qhzs0ygACpIleRp4JRvmky1N5a45VVNXOnc/EfcOE2TeZy6f1/B43KbVU2IREAzxm655
         HPnPqQ+h9flGa+9wHgeIrp15YY4Ffu+GVu4stLBx/+8pns1i/1ioH66dA46iBhYUvuVK
         1xzhdXWba+kAmwSEKXfkkCnDmETOA15mlw9w3zyBgPAR3j0MabDvi/PaChARaFcj8bmP
         Q12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759858124; x=1760462924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+z1+ZFlIhihDnc0DazYJHSsjaq/b1tc4ebSOM/fyJo=;
        b=jofoTInE4mnEpnXaT2qcTtc1h2uFgToAtLK1Y5BfbjTHBs7VB/GVNGH8VFJY8DawRq
         Rc4lM5pO8Ojv9QFlY2CEjAVBmVv6LTn+1i8LN6DaSe2PfNZJ7Jxa82z09M2XrTh7mbs+
         0DdJ2DadSkEGqHmt4tXtlDKiXm4vM2HLdTFBB6ER6Kio2LnJ3eB6/2uSQUb1pfsXAp0Q
         xQzF283DMCIUP866vplDN/Ia3ZPDa1/miDrGWmzI77R7u9G/7cq+OmEvDj7BYc3esV3t
         1JJLzho2vNgVj9Y2gP3cWvIzVPpybVlguo4tPUa/sjGxYDriwwzcm6cChm/V5J+ZCl4b
         XfRw==
X-Forwarded-Encrypted: i=1; AJvYcCWpOSY56SDMNCS5pd9MS6BMHQbiebqEnZRsjeBwXyTBu0JZQq2qlyklAxofdILLD/Kqflao3NHlHIM2hz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHQIS+0u+VwGQVCjkzu651U8ja9ARPXiCOQeX2dmYtgvtiE/H
	qmHA+GFPz/tmKTVazEaM5xgUjfSkw7aWZ6jkXzKQAHTMQeWpM3OKuIPxXt34h2SqxcnBj6AP5sp
	jnWwWIg/mQfXjb5ifiQbq1VR9uFF2B4M=
X-Gm-Gg: ASbGncvTvYqJGDrUJQ+qF8ipY7DMp8cOvJhR+H18Yu/JfMAXcdjKNdAngZ9Qj5uxEYJ
	vmCwtv+Wuw+Ae8SfkWkNx9AXefRAciXu/XDEUwDmF4iVsTByQfsH5N4irZ9qnJBBp9D9971vgVM
	KAyWV7cVluvIrmS+ddNrz0juVQm0g5EW+Lrv9njywAFZ5MZdR6G81x1rQdyqZLu91ZNhdE6ypjw
	IxKXnMjpSTqvzMlZL17ClDHdA96kMZSMYcFeMrdCuyh0iBDD3giNkZQVxskkCS+zQvsLKNB2FJ/
	o5Rhb2vmaX+EKdsj+GlIIAgcp+6lCwXNjOdAlandNtmPjtyHWRjGkoCprgdj
X-Google-Smtp-Source: AGHT+IGSC3vYYX3XNS4moOyGgDDt00n4NuuDIcKIpjVCiEkfgzJtsytjtTtPmpkZMn1rRbkUYIK9juPhDi0k8/UeVwE=
X-Received: by 2002:a17:902:f68c:b0:267:c4fa:e269 with SMTP id
 d9443c01a7336-290273c4cb6mr3742675ad.1.1759858124355; Tue, 07 Oct 2025
 10:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006163024.18473-1-work@onurozkan.dev> <20251006163024.18473-3-work@onurozkan.dev>
 <aOTx-Oj_VN6fVV_s@google.com> <20251007152724.2b33a899@nimda.home>
In-Reply-To: <20251007152724.2b33a899@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 19:28:31 +0200
X-Gm-Features: AS18NWADYkZvc6vCbj1UuDcLWaZRX69N2MiK2vPEu5TbDOY6IxUVYA4ThBJP1cc
Message-ID: <CANiq72m8t2j3+XoELfYFG9ivymueOGdwpZnFhRVZ8f3Xw9ygiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: xarray: abstract `xa_alloc_cyclic`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
	dakr@kernel.org, linux-kernel@vger.kernel.org, acourbot@nvidia.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:19=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> Why do we not like to use the bindings type directly?

For public APIs, we generally try to avoid exposing C types:

    https://docs.kernel.org/rust/general-information.html#abstractions-vs-b=
indings

Sometimes it still makes sense, of course, e.g. a method may return
an inner type so that it gets used by other abstractions to call into
C. But generally we want to avoid exposing those for drivers and other
abstractions wherever possible.

Cheers,
Miguel

