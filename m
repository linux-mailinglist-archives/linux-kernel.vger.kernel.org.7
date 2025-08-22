Return-Path: <linux-kernel+bounces-782740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139A3B324A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2BD3A32AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA1548EE;
	Fri, 22 Aug 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNQ/EBlH"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E811393DCD;
	Fri, 22 Aug 2025 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898506; cv=none; b=h2YDaceIWCXjYR24cWzlvWip6547TyM6QsLYfDGiCcgvoOz7kx0H/kfzcIsx/47cvE0EsWnSYwhctBvRTHqAjggjAu83oFfvQgekm2rG40sMbtm5p/hjdj9AQ9gout9V1+fi8t5+XNODYqP0mdy2aSNg/KcTt2oTpb4+O3kv+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898506; c=relaxed/simple;
	bh=RRZgDsK7SJs9xBRL8/xCSryJMyOUNtYMhgWEYcMp8NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDVYvupHkOEYjRN93ajWtbueTE3meiZ+cNPE7UqRsxbNkA3szcQYBuDQ2mcIPI1PQDMYn0y1taF4ESilkTuFsEoNL4AZUBu/mXEusHGCG5iQnIybhPLH5lIYxrUsaFqGCMJ23PWMjFDzq/d81XxD1RzwJteBQaxJsEcHhVHeQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNQ/EBlH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b475b63ab66so454804a12.3;
        Fri, 22 Aug 2025 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898505; x=1756503305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRZgDsK7SJs9xBRL8/xCSryJMyOUNtYMhgWEYcMp8NU=;
        b=VNQ/EBlHkitRIFnXRfDgpWUY9TXme/sEB/8rAyqjSJjjRns0Ap2Q9gk5Yt48QHFhdS
         MBc7aqlDd+RxSSK1IdU9vTbgmlR9QuiKdEzJuHmwUe+yqtex7GtjVPAfJwMNAKhZiFwd
         B+FmgTJhfciTr0iKKNZvbwMzw4oFWsrK2eYMEyq5ba7cmKanDPF9ry9LHTDu3rif9wMG
         iG/jvdF300FLup9unk4r7GMaKQaZIa7pakXC9878xKDtqgQWsHwvhYnJtDk6NaEGjFU9
         7YjucJCtmi6Iso2zET7qYkeXVUKKfGiBx0864jpHpeHgYSY0BZwcOfAFBkHAvu2vR8l6
         TdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898505; x=1756503305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRZgDsK7SJs9xBRL8/xCSryJMyOUNtYMhgWEYcMp8NU=;
        b=nkgOCeIGDVThIMTY9u/hrBVdPLQWomVEEoA4ahk5OrN2rNNGB8dPrUbOQCCIoFGdWw
         /oJfhKOfQD47P7xBU+uQyIXYo4uCrEHz7gUbeN3QBIquXAvm9AkkOvy+kHAMQmuptZ+V
         7UuODkhZlWLjl+jCsYN4+7fHkwgIStjsy2BCbVmS4yF6yfB5xZcSHP4IQKgx2qZSDxRz
         uziukx92R+6/7UTMi1IzlY+gY3fY8F5kEo4HUKAYZ668W2HpDoyDdhwnh0pC1KI+teyv
         jpnEbj2TMwtjfeCW67JJOb4xz95X9TFOVjW1ar74XNvRhjKFImdF/Hs7LnXaTjFPNwgY
         F3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrlw2reXhy3OqfPWm39m8N/pb6hPejIq7BGlLGb6bvdbWsZIj3VWLjUi25yx7hrK4t9n8IMAEIfAciHoU=@vger.kernel.org, AJvYcCVvIZ6KhsvyT/qycWGVI25NesrlmkbTSpcFzKRiWoeu+oQAnYwWYy2VRzuQZJSirNAB0A7RSNunL+Sw9CW99TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVf3ilLxGwfQT5vi9WNXquK5ou8XhynPXCT0IxP+14Q8psDiV
	qER1MJud505/GE35giMI/me2FwFTCrPvMbZR9YPS/feQMilboE5+YMURfCrKbbyXAKSQwoKs8M0
	CcTdcR20aEVGk7nTK/BR87UhROyMJo2JWoz3m
X-Gm-Gg: ASbGnct2DLyAINt3eCaFBzESfRiupW4P2WAoG7ohIRuA+4w9QJCrWHXW6G3ISQYxRSK
	1C4dis3SdE32TYlGzxdzYpCvEZR2cSD0QRn/W11QFaBormz5Grhr4wMkgVQSQ90Ty25au0TG9DK
	bbkdJAnOSWbtBSyJXjCPhX6DfrqdeJ88oO2SZ2ALnGdakNBthZLTX1Zuq3k2wZEMdCvaYffU8yj
	fJl9DBxzbJHmZyvAduaipYBZ0IVCoF9ZotH+5hIxIkm/WbmTyjWkFTgS2Nfl9zK6LzG1+4zkge7
	hwQNKhFiwTZsHu3od6lSSbEn9A==
X-Google-Smtp-Source: AGHT+IFxOFWKAjOPJFE8qZjcQf9Z8n+LVcy69DcC8U/cMh//BSaq/Vcoz7nypFA+tf98PQYzLpbV0O06Nc2KLf9G5eA=
X-Received: by 2002:a17:903:124c:b0:245:f85c:8c6f with SMTP id
 d9443c01a7336-2462ee8b1eemr31230645ad.3.1755898504852; Fri, 22 Aug 2025
 14:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822205715.83437-1-samidanielpersonal@gmail.com>
In-Reply-To: <20250822205715.83437-1-samidanielpersonal@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 23:34:52 +0200
X-Gm-Features: Ac12FXwsk9My5pfuY9JrKfPg41QkcE-6SEqha5RqtysivfxS9lnzHi--I9RZARM
Message-ID: <CANiq72=CHTBvWq2wb79kbk8U=f5XdnO5bvqWg96Bbj5=X-E+gQ@mail.gmail.com>
Subject: Re: [PATCH] rust: Improve CStr UTF-8 conversion methods
To: samidanielpersonal@gmail.com, Tamir Duberstein <tamird@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:57=E2=80=AFPM Sami Daniel
<samidanielpersonal@gmail.com> wrote:
>
> Add safe conversion from CStr to &str with UTF-8 validation.
>
> - Returns Result<&str, Utf8Error> for safe conversion
> - Complements existing str methods on str.rs

Is there a use case in mind?

Please also note that we are trying to move to the `core` `CStr`, so
is this needed if that succeeds?

Cc'ing Tamir.

Thanks for the patch!

Cheers,
Miguel

