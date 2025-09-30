Return-Path: <linux-kernel+bounces-837896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C3BADFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B559319414CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F36306B3B;
	Tue, 30 Sep 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="c8UtdB6J"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2D296BD0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248254; cv=none; b=r8+sQJa/hKnI96k1bHUEgshRsy0pcs2F+rkQdPgAW0tR0l7yemSa4C+pvk0GW75bqiMEIStKMtGprmO6wsYWqKCiWmbhQOFIUzhpwgLnYKG9aPsXNjcjZVHJNopAFkYl6QQI44gpo1/ULvj4YlGSP3NLNBPhtoAkNJHdSSnb1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248254; c=relaxed/simple;
	bh=iI8EyaxV1PZIX5CvPkYn7Mxe5gaWENrMcHvGkB9q5KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ2Z+VDLCb+vAX24UoEEFiJD2veqiUWxuUDQy57umF++JtMhLRT2SCG4JA8OXjUtnVcLfGE53xid/WxEEFd2cMpAv3Wa4p/OAAqly/ZM7PP5MMEe+sbvs45JYdnnidPJtXgfPQSs4AfVWpOIySoqYnVfdJm6RVIgSsr1I38mDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=c8UtdB6J; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-429a0630be3so25861725ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1759248251; x=1759853051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Wuxh3KpxC8Lkh1UJGiIRJzDlJEtmWKRckmgw+qPKU=;
        b=c8UtdB6J9hSNb55C9sI2wrZKiFuh5/MPLi1P3MM/blRruQIN/YoUWNRkfANKSuoIyk
         jFUUQ3hgEo1SV/CSjLfuJoNpcimaf9DvACX+Jdg35A2LeEzqgMWM4hRfmngisfAFLsYi
         DraxHf4MO0yYWQAeKQvvYnNQ5Vd0cctlzAMvFdfCCnhGOkuHnwkOzb9nzSvclX3qdpdU
         Ft8St56WqmafHmenqCikJp7h9iUy5RjzRwm1TVF7aJlF9+lQ6RtSJy4arttxqqS36lzP
         x4/yV749lyp3Xu4ihPcXdykA1erjmEtNtQxPHfr9YULQ4Tuw0BrULI3IbAs+4/nCARAu
         Yeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248251; x=1759853051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Wuxh3KpxC8Lkh1UJGiIRJzDlJEtmWKRckmgw+qPKU=;
        b=uJjgYNvOTMrCq3k4HrXUeqDMMu6eVNqsJI9XcXcp5fjFrwio/SPNZqzBLuw76EZ9be
         d6KNqq31f84QheI5vopYBFF1NUzqJVzk1v204noO+hecvBDYWGfxFWBshiSQgVAhp1gu
         vboaM5j1VDgygYwaUoEBLlWLbYkFH3kIQv6/qyBGyElWUccJrT6pae3rrdlLfLviUsud
         wfPJzffJ+MO00IYOB01N73riLkEeEM2C39/BsxVsiFm+UujnBs6+w8zgq6drQN78SkXW
         aErn/gyeVmQIFLeVAhHwF7l8ooOos4185rCErYiDIy7mnmRS9qdwxz3tdk1n0pfR8oeD
         9v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPqh0ZQUFr9o4tFOXD7WJvJd+LwC4TjJocZoAoKVGf8DMA0AMWWeTGjm8tnXMiY5Ttm+pM8RTkbS+j5kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHudy//N/zkhd0nY3Wx8h7P2uCM3OSMBVMTBYFDKgPwC552XdH
	RuBsYO35fkY8yHZeTCW8ZhR6kv1rycnbTM1x0KGH+PPqK8mhgmgdO3B32M9vbuId0BXCB8pGnky
	h1p3GMXygObPRUUQdC63raHnZMCfAw2KKdMx9/jCuLQ==
X-Gm-Gg: ASbGncvQRtYqMW0134dtDTrUrj23uod39mnA18ogip4FaZXpDOVpNSkcfwje4UKybin
	byhi4UqPy8JS8WHUh4WQyfHyFu8p/WRC0N2I1TOnOYtBgeSQ+aLJwixbNiGj4VYfF0orAWP+nHs
	gWUDQ1c6qpe5SzBFIrgsOLWFTXP+oplQKWzDOZn0tuEsN4vPojgdKU24SNcVtnBFr2fmQZ1Pz3l
	0+qOHCjuPbCb57I3e7cHjegAbL+AcXCpZghNPIAjoXF1xfK15ciJBLage3SKkd42mWfqwmWZfI=
X-Google-Smtp-Source: AGHT+IHa0Q/M3yEjUHR+I8sb1jd3MrfyzrVb1oMdomRNhwVu8KBID5BV1CuaUDQJKIUd0NqlUv9NqYEerL6M83q9mWQ=
X-Received: by 2002:a05:6e02:258e:b0:427:9523:2e98 with SMTP id
 e9e14a558f8ab-42d8165ea08mr7065745ab.29.1759248251332; Tue, 30 Sep 2025
 09:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c458915ba9a4d1ba3413232206c88fcffbf832cb.1759243480.git.geert+renesas@glider.be>
In-Reply-To: <c458915ba9a4d1ba3413232206c88fcffbf832cb.1759243480.git.geert+renesas@glider.be>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 30 Sep 2025 21:33:59 +0530
X-Gm-Features: AS18NWBu2ojz4bam210cXxlz1KhmK5JyYJRCTGEigLxMZntZt2MCQYiJKNfSU9I
Message-ID: <CAAhSdy0-PYjmLeMDquDhvTF52zB1qFjBk18eaFdidbR=y2iNyw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: RISCV_SBI_MPXY_MBOX should be disabled by default
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rahul Pathak <rpathak@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:19=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The help text for RISC-V SBI Message Proxy (MPXY) Mailbox support states
> "If unsure say N", so the driver should not default to enabled.

This is a very critical RISC-V driver providing mailbox channels to
other drivers such as clock, system MSIs, etc.

I suggest changing the config description instead of changing to
not enabled by default.

Regards,
Anup

>
> Fixes: bf3022a4eb119c6b ("mailbox: Add RISC-V SBI message proxy (MPXY) ba=
sed mailbox driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/mailbox/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c488725aa2a5d4b0..acc4bd93136cb720 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -372,7 +372,6 @@ config BCM74110_MAILBOX
>  config RISCV_SBI_MPXY_MBOX
>         tristate "RISC-V SBI Message Proxy (MPXY) Mailbox"
>         depends on RISCV_SBI
> -       default RISCV
>         help
>           Mailbox driver implementation for RISC-V SBI Message Proxy (MPX=
Y)
>           extension. This mailbox driver is used to send messages to the
> --
> 2.43.0
>
>

