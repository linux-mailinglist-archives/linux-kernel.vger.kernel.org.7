Return-Path: <linux-kernel+bounces-836729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D0BAA6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0231C6496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C7C256C6C;
	Mon, 29 Sep 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjq+57lo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65811248881
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173028; cv=none; b=sTOZQmWzdbola9vfsNWt8DLorqjcXfGlzwGkn4ef+xOYYvvO8F7+YvneQ/Zb+0JXaKgX71E6Wf0I1MvzQpHB6i3J/MKJ8W0OpZwtq7YYnlNuyxY+sQGwVjVcmVoFTuXdMzha9euVSKxSKR5290EPb+G50YMd2Dg1ryYsG7v3I0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173028; c=relaxed/simple;
	bh=j+HQknQTfzkjZ4xFlsxP9F2RoiYAYddrRiH9YR54Xig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKl4kkLVcRPC/kEhuv5nY7ihhtMfFa+VQi8ru7OZz4K5t8IeldJQrCjGEsn24LVS7YbvJT21DdXPmSHB5f2xKk3bdjhnc/UFt22eRBweC2wWvtqKEBwOPNMSs3I5dR93tcVhKlHgb16m07T3f/0ZYi8iZ7IU7AO0cappu/fhUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjq+57lo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2699ef1b4e3so10441655ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759173027; x=1759777827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbyv5anoG1BNn6L0Yq9G7qMWdoR9ixzEKLdO2/vKKjU=;
        b=hjq+57loC6BmELIj1CTjewr8eqV7mb2WR2IUvZeWxrywn9Hp65wmoEFbrMWH3DYIbD
         4E7vizqV6wb/8SfVF7/G5TRGqKDjuoTToRqGxYHRBmoLSWsbC5bGKASQDYMWJM3Dhlkh
         VValDT0YXTo6j4PQlrCRtdw/LUK3AGgsRtCADQXiM4y80iYOiyDlLF0Jo/cXauy4aZ/+
         thHPS1FnASDNyFLcB1FVskBDrFqV0YihanwgI13vKfgOxTjLW+F5zy3EytxV9QF5pfLo
         lL6ZqQrk2h9UlUBAwRCxEFfKWSQRLIJlm5ssOIEJbJ3YQ5Kbde1jAnvWY41fW8Ji4vZQ
         ih1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759173027; x=1759777827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbyv5anoG1BNn6L0Yq9G7qMWdoR9ixzEKLdO2/vKKjU=;
        b=scOW6Ykd5sDrGnUTLX9Pyjo+Ybh087aOGN8/O95snN3AHUU9dFHuA6NOPaIR+816Jt
         WHvOktIlJZHpXVK6I1ZSf8XPQMVG2SE6mDUapfRWWB0CJsahA2WS5Vd9ZO+qjWZurWpM
         avDG/Px6F/cDt7+U3Z7+Zhwwa3pVBj23qXliZahnna8z2g2jEOyU/sV+4oBZ/QJGuLCr
         d1pERrF2p9GfUJFkS+ga9OL3kV1ThatGux7CWuWPlqrkSCAtD5HmDjiIowCIHkasiwUE
         K8ioLZSb+HOqJCoO3CbPxKWRTHe/M//an+BlqppMWFhmnkAbuD+3YYcVeyBX1NUpPNf6
         XegQ==
X-Gm-Message-State: AOJu0YxcMH+lVEQMwWFn/vEdyN6BoFpddY4p1Qx7sdTHXpgGtt8h57G4
	cV0vmYqKGI4XzSNuNBdeecc1aSwrlxjDFMmX1l5lP9QETZit+WR85/9HIpC7lzHuAQpG1DAwGqb
	9noMLikSwJMo3cLQAqoutVfqGkzGIFP4=
X-Gm-Gg: ASbGncvRQ40uBu1oC7B8tWahsthkN2DmwAdSzDT9SlcCr2TE2riibekesu1iLKJmVmL
	bYwmV80iqFBmp4fhAbunWhbCu7nUc4PNOlvSGjpsJq2eDxf4h30ILDGp0IQsdJjNJkCN73RVUK0
	Qf/rmPplIn2z83OnovDCQ34/AaSO4ASGgRc3WTXumNQ60eWPgIgFBlVn0O8uG3sX3tiIVd2S8k1
	syYgGnW4Mt6KRG+sCsfJQKe0zfPYyv8YANfrnKDxuDodI/Av9jE7Mo4f/qfik8myjmQPOzo86cO
	EGiAQyh5P70e7NXIFxbCHS5rPWN5Vc5h/o78
X-Google-Smtp-Source: AGHT+IHJfxwimwqHtxPSuwPNKC5Xdv5PQdgeEEYnfZcIqRTmdN8auKfzEBWl5enpV2OwAsXugr39tmET7lj+OfhzNeY=
X-Received: by 2002:a17:902:ec8b:b0:28d:1904:6e77 with SMTP id
 d9443c01a7336-28d19046f64mr5721095ad.3.1759173026637; Mon, 29 Sep 2025
 12:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917165106.22262-1-djfkvcing117@gmail.com>
In-Reply-To: <20250917165106.22262-1-djfkvcing117@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Sep 2025 21:10:14 +0200
X-Gm-Features: AS18NWAGXgc3wBE_CDcBhG-vL1PxyrSHmDSXhC-cCijt9jb47hjgZF0eIevusNc
Message-ID: <CANiq72n7Na7mjgZ9PwXwij5=AuHd5b3qjTc9Yh11ubMqawAYVg@mail.gmail.com>
Subject: Re: [PATCH v4] rust/fs: use intra-doc link for `EBADF` in
 `BadFdError` docs
To: djfkvcing117@gmail.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Onur <work@onurozkan.dev>, gregkh <gregkh@linuxfoundation.org>, lossin@kernel.org, 
	gary@garyguo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:51=E2=80=AFPM <djfkvcing117@gmail.com> wrote:
>
> From: Tong Li <djfkvcing117@gmail.com>
>
> In rust/kernel/fs/file.rs, replace `EBADF` with [`EBADF`].
>
> This helps rust-analyzer to resolve such references.

I would instead say:

    rust: file: add intra-doc link for `EBADF`

or similar, since that is what those are -- they are rendered by
`rustdoc` (and of course possibly used by other tooling).

The change itself looks fine to me.

However, it isn't sent to the right maintainers (VFS) -- please use
`scripts/get_maintainer.pl` to get them :)

Thanks!

Cheers,
Miguel

