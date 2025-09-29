Return-Path: <linux-kernel+bounces-835754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6AFBA7FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283C73C25DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523C239E67;
	Mon, 29 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKfj5hM5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581315442C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759122870; cv=none; b=cp4ZvAtZKr31577Oy6+oYUm8dCzj0PnusbLrqaljTvrYD+dfzDEovFthjpxmmv1DLQRtLO2MnE/GdlhXlPKqRNWtoYZV6W32sjE6upoAg+j0NSifkwuiTxySagciILNbd74NjAFYmElsxtMSlDyczxGj6EvMisJeREP9F0TE/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759122870; c=relaxed/simple;
	bh=2nWBXd4KZrZn3Kozyj/dcu9GKU3e+h/EJFrqN3KQUNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Htu8lV7YRUSb24rZW4erLgAAJaqhXHJ+SHzBabIJcXK1bWKZjHA9SKBtM6qFqBz/sKqEUqzOgghzW+qiDUa+d6tEIM0OmxybuxYaiVXR0dFirHi37A2ijstiEP8skZGWMtUDgC79u7Bw9vPIOZb8NUgjXTwwSEoHLfzhr6yn6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKfj5hM5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759122866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nWBXd4KZrZn3Kozyj/dcu9GKU3e+h/EJFrqN3KQUNk=;
	b=dKfj5hM506iB0h/xWqWcV+27fNAukRSLcowRDH/H9BQMGInAp2j0UsowBb2bvFSjq1Kw1t
	p1ON1h2SA6ZR4xS0HJf0DQLAuO86d54ClpW6gur8gACoUeaZxQoU+kwQgJ7I8ybgul39qc
	7NnM30fx5Pwkbv383z0rGUejQ0IHpLU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-3i2YZ09mO0WznSoc3wfDxA-1; Mon, 29 Sep 2025 01:14:25 -0400
X-MC-Unique: 3i2YZ09mO0WznSoc3wfDxA-1
X-Mimecast-MFC-AGG-ID: 3i2YZ09mO0WznSoc3wfDxA_1759122864
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5b0ad39e10cso1377048137.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759122864; x=1759727664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nWBXd4KZrZn3Kozyj/dcu9GKU3e+h/EJFrqN3KQUNk=;
        b=P9GMaysn9mC2jBdAz6ZJ+0k3gVzEFZhkh4Om5PZcBVadkTkIfwGlIdjN9FG7azw7gD
         2kz52K4CPg9ybdphi7LSPsQSFxciHKhtkA5LDDkpt28ToOVbyQB6a9BPsEn/Xh65K6Kg
         DQsvi8AAFlo4aNt5WioOFR2iN5XFfgz42Bo+7ms9XI24n5hmpFkTpQI3ntzHS2XdVYm2
         jtkAdE4V4nYSsAyjeHbTPUjuUL/tXtKm7oQ5KqtmqW8wy/ilMG7fSeI2tlTp0lZ3a9te
         IARkxk0QWwZ2vNWAuxK8j40oIh89P92PfUat9MAEqx70q+cOrJ5wm7HVH7keF8qeKN4y
         ltxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9otRg5M8SVt5U3LTRvJsm7qvyUwU99wy+PyBQGLzQVTtyUcCxMQWlzNia+v8VR5pDJAcAYHqYGxsYbN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17QyPqf5Y0trfIndfvYgmhu9bAUhxRmzhECVmqmEyXjwe533b
	XKiEOf0tAVDXOaF8HrQzWdC3Ov45l2vXNO62Ous+WyvVsZcUlUrLMeTQ19TRZQE5IX49zMH3IUC
	3/Sv6c99Te1TXxkWWPjY2mbMuY34ZiSgGLC9DcqUFU4/IHZqxONZ7QF/ojMcNJ6gQ68alP3u75L
	yMdzunx/Tvar7AlMnKJxLHvHxXBEAJpISQuxo0gIqsr0x87SQaWDU=
X-Gm-Gg: ASbGncvKqbYwQyuw2K8HYZb4ETTqroiR3uuFTDDcQRDQF5lnv/QleSAoqYbdt/pOYKh
	c301Mu8u7NttPHlgndJuoRKvajURhdtg7ttLIRTKpYWDQa1xltVPO7mYwfsn+Ls5tqTT31BNk1Z
	qZqRA6cO1B9R7Ld+sZ6Y1Fcw==
X-Received: by 2002:a05:6102:e0b:b0:4f9:d929:8558 with SMTP id ada2fe7eead31-5acc83f70fbmr5692679137.10.1759122864367;
        Sun, 28 Sep 2025 22:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBBAQ7Gy8XVwAW8aHjkNgwg3zjuam2zWgWYcrltjztGrwXHhbkc163/MD/lKu5otxjmKnF0CE/e5UEeiuG7UY=
X-Received: by 2002:a05:6102:e0b:b0:4f9:d929:8558 with SMTP id
 ada2fe7eead31-5acc83f70fbmr5692675137.10.1759122864049; Sun, 28 Sep 2025
 22:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926121231.32549-1-me@linux.beauty>
In-Reply-To: <20250926121231.32549-1-me@linux.beauty>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 29 Sep 2025 13:14:13 +0800
X-Gm-Features: AS18NWDXKiUqoWOcUr7IEczOPRgfBRc3SIC3-S6lJC4tqxwzN33sIh-Pgku9MGg
Message-ID: <CAFj5m9LN80E3xyNY+3nGjncr8WauoUi4QUKEX-vtmGfHrzE48A@mail.gmail.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
To: Li Chen <me@linux.beauty>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:13=E2=80=AFPM Li Chen <me@linux.beauty> wrote:
>
> loop_change_fd() and loop_configure() call loop_check_backing_file()
> to validate the new backing file. If validation fails, the reference
> acquired by fget() was not dropped, leaking a file reference.
>
> Fix this by calling fput(file) before returning the error.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>

Good catch:

Fixes: f5c84eff634b ("loop: Add sanity check for read/write_iter")

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


