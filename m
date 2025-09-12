Return-Path: <linux-kernel+bounces-813023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6933B53FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA716C2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3DF12CD8B;
	Fri, 12 Sep 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaBpwuhL"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A272F4A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640142; cv=none; b=odXEwzP3lv28N43HzZ6B11W5kt8GeIRotd7yHRjYNTUweq1sbt2lwuEEDP4dUq8fmDmizRMymWaRx0Eln95wUByNU1APTNQzYYlPvaXAxG5uNP2Px59Qpj8Hop4tUbn6y5bW10SYlMvhGwtN3D/wQJ6UQHXalcJhVZYgzaFQNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640142; c=relaxed/simple;
	bh=OWs8kXFb2L4DqgQPMylpV2TV1VfDwdy8OxC6W+nA+hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT4IaB3rIvWm11GPw51xd8ujPo/PWSVIwDS2Oc1/OP+vADkzbbkILOEa/oP03XKn6bZiCNrSRx5OzqMFXfJNGNxOGAkomWhOSXv4FGac6wYSFEWaYb6z8C9dQrDDD+SS2nrtrv3NM3dv1+0rQxpWfdWi/ev40j42gBn6EozOMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaBpwuhL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so1692586a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757640139; x=1758244939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqEJRFTqkXTHPxe+anHjP+6b7P+oYHlI0fjlwqZC7wk=;
        b=jaBpwuhLr9fo3IuLuWYTYcGhQWu50O9EzW9DiPG00vPU3cLMXJBFKBOy5+SjMiY3ig
         t7ZOztLI3KilWwiW7Oxp+2t6SGbGNODExnOINEU2eayfSNk21a3G9UYUQOVx2IKsi7Vh
         7uZe9uW31dkZwPtIrJkNYrgB811g0KtySO3twrHRU88dcyjfWmjVxE0DnCmjKq4flV3R
         IBKpi13iPf0zrOu18biOpmsdFEpbhrC61tsA52LFqxzK0FfXsUZ7MYMs5CrWtrmvL0nX
         VGD+tKFOnihqxNgd7Yfr3hQkxfFQ9H38p0sUPSOXuGgv3MjMoWPCVDHuRVks5JuuqOuz
         B12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757640139; x=1758244939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqEJRFTqkXTHPxe+anHjP+6b7P+oYHlI0fjlwqZC7wk=;
        b=jreCPc9y6ZQqRTJQaiiKSlvgjaY2pF/gkkuSi60SCEqwItMCpa0vuVAf+f7pH8+Hw6
         wotoTUnAEH0RUBftfO1aHmIq0hNF2lehaVnMa4OxNn5leeuYQbcX7+LAZmkMSzK1InMR
         B1Kf9usXI585Ebx0k77FOJONf+U3RI2KRlCtI4BpWhUMU+GWPKMFBv5xJ5yk4kZMYI5A
         k5nAAG/pIi/jGRGqXImqDCP+UEiCa6XOOSy4BcxxV/O06NkITk4QJz+lgyIt/MTcac1P
         MuTlbiuD4eQvanYnDNj2+Fb6HsEZpGlo7XOGAgiJrPrjSpBpN5UtR6IxEuy/Y/xlzzqO
         Oo6g==
X-Forwarded-Encrypted: i=1; AJvYcCUJEnYfw8wwDAGhcNpkmRL/8JJuMe+WxHlz8zA1tV5bl6Q91TeArNDBv2u1g+9nEC7Ni0yQSR1nOhDg+QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+dQPMYB5nQ7KMIDkQsRw9Gsf/C44VDhS9XuF8iA44DuflMkF
	o+ClwzKnv5HnTfo722K477zeeXymWlghV2F3mr2rBSj+GP/2LmIonyUwMjoKOAtOlV4ikAKsTVf
	6nk6xaidXbSAQygRbLZriGWQmEsbaDik=
X-Gm-Gg: ASbGncsEyCkv46Vz2Y58iVzwLUHGo+Z61PMSqWXGxXv/6FTHMByvFe5UE12M7eFHEs7
	BYPvzHfJ+OVqxJ52Hl+iDIIgN7DULr+iZwUYXZ4n/mx2msfW4YC1tMXwVFBhKRDpyudu0F3ACWB
	YWAvsFMHoiIekWwZ12vBpCtKEnvZlZVGEn+BSXQR4Y0XuooujBEx7v9RgMOIC5A/zrutlk2J2dL
	UzKeuPIb1ab+E/bVg==
X-Google-Smtp-Source: AGHT+IGt/CLEu8nR5Ze+5xkikkjJ2cYfz+ATtY+dq2NhWYwDAqW/E0WWlDo1nJkUnD4bsOlbYioLZpU2LK1U54XCsZI=
X-Received: by 2002:a17:907:1c1d:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-b07c35cd754mr106362266b.28.1757640138949; Thu, 11 Sep 2025
 18:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756987761.git.zhoubinbin@loongson.cn> <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
In-Reply-To: <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 12 Sep 2025 09:22:06 +0800
X-Gm-Features: AS18NWAv152H9tlVnEaqIuU7dXqcdClzdZ--91I9sBvedtXMJlWCJzVaZLWxQLM
Message-ID: <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
To: Lee Jones <lee@kernel.org>
Cc: Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	jeffbai@aosc.io, kexybiscuit@aosc.io, wangyao@lemote.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee:

On Thu, Sep 11, 2025 at 10:33=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > This patchset introduces the Loongson-2K BMC.
> >
> > It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> > And it is a multifunctional device (MFD), such as display as a sub-func=
tion
> > of it.
> >
> > For IPMI, according to the existing design, we use software simulation =
to
> > implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> >
> > [...]
>
> Applied, thanks!
>
> [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
>       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
>       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3

Thanks for acknowledging my patchset.

I can't confirm why you didn't apply the IPMI patch, but this appears
to break the patchset's integrity, potentially causing missing Kconfig
dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).

Additionally, as Corey previously explained[1], this patch can be
applied through your side.

[1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>

--
Thanks.
Binbin

