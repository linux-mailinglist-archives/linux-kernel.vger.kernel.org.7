Return-Path: <linux-kernel+bounces-859628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D0BEE26D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19391899B61
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93242E2EE7;
	Sun, 19 Oct 2025 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnCfDbKX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED501E5B64
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760866956; cv=none; b=inLH7bQ+npfp+wXjaje0akIT1fMDmkldFLNl/ndjwE9Ttmco/QcPijMYxYdHsIG8M96XQ9rVy27Vk5p6tY/TnGQS6cIPgvu9kfgMGGulR+3hLpKftv75Oo0XAAiYH7Wnuo2XoV/87NqSr0mgZVu4r0hYXrwnQhf5PWnCiL5EmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760866956; c=relaxed/simple;
	bh=BJkZeQJHCDAh/1wDzr79J7l2UMRsy3tnRyrME1bv0+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAwT8avMV520L70DGTYFfdQRZVE4bhsztW1rFLI19QrIzIWHB3CVfPQBuduc6/hUMN/xA/ieYu4I736WejO3vkPtPeAqvZ1WRSFIQDBvkq5645BZJRmmOAFSqWGbgUP3ipOSjepmpE/h8oMv/1gO+iUroTgINXnCQh6roqQELTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnCfDbKX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59066761388so4446739e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760866952; x=1761471752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJkZeQJHCDAh/1wDzr79J7l2UMRsy3tnRyrME1bv0+8=;
        b=bnCfDbKX0veZx2ytEp/gcAyp437Y8Uv35dJ9vguZMGlvztF3lufh4817u+DWGWufR7
         dxBR97TxLQ5cCqzalZrnBbqJ7/Tfzwp6N714Q3VH/sv4CZ6HXtuTURiE36lU8ZrPZmoI
         Lun+Phvn0xGJxbH+uphQ+UCQEqXR0ZxN99Hiszsixwq98a3v1blq7HCkGRLmiB/W0d+0
         lGScC/XnGkDNcaM9doqFLTHxmP5n2NnPuoH1HKLHpaMcnPyvwjgzusgVpUCsE8M6fKyv
         DIL5P8W+BfUOgKs6E+tuZiUBncCPWjsG2gKnuUwiVeDhQLuotmMT1dn5a1ZwP9/tc4CL
         rvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760866952; x=1761471752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJkZeQJHCDAh/1wDzr79J7l2UMRsy3tnRyrME1bv0+8=;
        b=LP4OisdCopli3JFyQkUU7CYDbu92NJ1DDfJ9QjvcaFbSBxw1Gb4ji+b93VaN63XAg/
         El3qGG8iBaUBqk7f+64+ZDD6Q/HGyYr/hQBU3E7Ap8WD6WmNBGILwnnQtJ6C4T97RTcW
         xZHc8anFmyaK0AyHgubeGwoS8g7ADoWXnix8+HvFim+BM4eQG4MD69qwxc3Y8GZ574+L
         xlDoXVrhKm8qDipdRuZNWDqm4TuHQRgATF1fj7gqmr4dxRCjThhwWmryTpKk/fi1wNgR
         y7xaf+N7KvOD2mu0Ir+rjDCSlmp5X+4y1ZGpuKzeLnLl+D7z+C0W9i6udJezmyv5tN50
         M54Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMKrGbStAFp7obKxd3UnTmm2ikYzh7FW/oURaiVWBeuC3oeAo2LMwbzVXDs4tqxCtkwQqOn2XIKfaBCUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynD5/vAWQqhLgmrCYzphA8K4suNv6KcdGWaEyh+Cn504vHEA2J
	fAfYk3L5N1H9IvIhK/cKXiicRw8cQGgvO9MCzsFuo7N6/lK1QlaUghIdK7vXGRrU5zUzagC8TG1
	XSZZ7qMoa5tT69IAJN5j/SxBOEq0IkvQ=
X-Gm-Gg: ASbGncvZmdwgvmg4wPi+dEziUb3cwET4KVa2sVPrplrBNxNqkun9+7UeIKL8Op3brkn
	JWipOZLVPjl2Mw8z4EmXoS/bMDTS4A/cyRuUEPjO4E2fL9M2XXLGWlihKGJXJbA9tSBxBvUgwpW
	WnsXxPiiaIPZfAwPsPw4tmQ/1VLNZrEOW+HRg3+4jbjU1tNvGRI5OMX2slUSXvg68JPyNnB+7G0
	Kv3iLOdgIt+kV+/K2LHVGOVWjKvaB2FZV+gRJiR3HZu4LT9lZsWFKc9GhOdJINI2MY5Vm889HQP
	DXQ1auJAV/zHTpRPHA==
X-Google-Smtp-Source: AGHT+IHRGUjSudRV2+iLzSpcC41cE/KbP4fHngDZHFyswv0L6Igvp4+PdxJ8FqjuwD7xavvcTfDAYgk+D5KDG/l6kNc=
X-Received: by 2002:a05:6512:3e26:b0:57e:3273:93a7 with SMTP id
 2adb3069b0e04-591d0d595a3mr4131060e87.21.1760866951430; Sun, 19 Oct 2025
 02:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018053029.226506-1-hsukrut3@gmail.com> <c2e85681-7ce8-43e3-ba08-63f8b854c8c7@gmail.com>
In-Reply-To: <c2e85681-7ce8-43e3-ba08-63f8b854c8c7@gmail.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Sun, 19 Oct 2025 15:12:18 +0530
X-Gm-Features: AS18NWC_eW-N0hWCemabsbKCneSKDXwgneQOnEzszGH7ffCqdynN8G-JRg8wcVE
Message-ID: <CAHCkknr6o_9zO+DYRaf-W7C46r17JUf2MFnPLm1dik=ei=LxcA@mail.gmail.com>
Subject: Re: [PATCH] jfs: validate budmin to prevent shift-out-of-bounds in dbAllocAG()
To: David Hunter <david.hunter.linux@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, Rand Deeb <rand.sec96@gmail.com>, 
	Edward Adam Davis <eadavis@qq.com>, Ghanshyam Agrawal <ghanshyam1898@gmail.com>, 
	Nihar Chaithanya <niharchaithanya@gmail.com>, Vasiliy Kovalev <kovalev@altlinux.org>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>, 
	"open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>, 
	open list <linux-kernel@vger.kernel.org>, skhan@linux.foundation.org, 
	syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,
On Sun, Oct 19, 2025 at 12:50=E2=80=AFAM David Hunter
<david.hunter.linux@gmail.com> wrote:
>
> On 10/18/25 01:30, Sukrut Heroorkar wrote:
> > Tested-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
>
>
> Hey Sukrut,
>
> Did you do any other testing other than syzbot testing?
I also used the C reproducer to test my fix locally with QEMU and it
no longer triggers error. Do you recommend any
other tests? Please let me know.
Thanks,
Sukrut.
> Thanks,
> David Hunter

