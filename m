Return-Path: <linux-kernel+bounces-742122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2CDB0ED8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04741C83D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A42277C8B;
	Wed, 23 Jul 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh0C+Ik9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98326C3A6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260282; cv=none; b=Y2OxTUvEhNIJuQlofuE7UMhdFXgidy3pD7aDG0tPU74wRzCzitJSReNxOXjo2fssZSglDud7WVatIUlQnzVNY6BDUJLO5f1AnW+2aiBYGpIz/jv45jFTqyRj6pBrEReEXXk+1ZnmsIltUyye0t2IW+7nVvkpunAU3/VZrCabnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260282; c=relaxed/simple;
	bh=pWvEMS6fqjqBI7s4q8+W3E3k2HumT+dDpCTc43kFNdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS0jBDPlxnxFKpWAmJxYj06LtgqQ7V69qNt2n+SM3r96TgkEfc/aHq4lfN1b+GhpReNf+/1Q6Vs7ZMygFUdsSiptjr8ofgPpwjDdy7TQrOtaKOyTiWDoAQ0EZCnwhbQpCedUFkpmfBPC8CRhQrPMbKutxtd41zFweFbBvpCcjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh0C+Ik9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so1033422366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753260278; x=1753865078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmT3Xd0fCgFsmeU54UaZ/j1/K9rqcuzzBJu38L/GcB0=;
        b=Fh0C+Ik9BWHOfHHKA3zYZnqHe1mpaJtC9jm0fQe6CBk+1ogEag66QuWJ8cjVTH4uxD
         YYiOManuPlFsSMiHaYIadPQUZB6bz8ANQVjOIwOtwsZB2xUjQZH0N7d3Ti6s0TalKh/H
         u/WnB8XWgCy/9uFIzySQUs7tAl3CK12druoPIi1MRpV8uEe47nojjuilLm6vjXTZCbxS
         VgrZqAhSy9Y4JwxR2Xcu5nG5MQ3ZwNbe/46Th6RxS28H58sce6zsZa//f4SuYxMVdIji
         QH32Xo6QVMk29s9ULrEPAV6geXWNQbsytkUer2oJ3eexgWuYflOeR+7zy17YogHNZneo
         qsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260278; x=1753865078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmT3Xd0fCgFsmeU54UaZ/j1/K9rqcuzzBJu38L/GcB0=;
        b=mB5fAMeZYwTuOhOpoY2TxqNIQVVss1NI1JYxW479Mv8xWdFUuWg4zXM4dxLR66rSnV
         SkDVmo8phqdlkobWsUtjfgXecGcQ3xlE+ZyZ+2VppPaMvpdlT6DlrwjCZhJIfo5fcxo7
         m2t2wU/C7FpY9oPs+Yx+jmAjcRdpVEBruWlsfn4GkD7Ti01T/4pRxr8I6ae3NPuq9wAj
         ngyKw1gEpBSzcWIj8tlqKyQPAUO+noNVZUb3QlRfZDYj7gdDqcKq6nyngvg5+AdKLSQp
         l5OrM0JxUT98MUC1WGnUH1ysOOJ4cCw0alQKBcPg8ytUXQL5SHm4dLgsoWIFtmawk4yD
         uAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgPrEns/VJFDa5jI4UUvTikuGRhigmAe0gCpUIJVxRUOn4o8a7Cus/7BrTYIbTJpeMQiRHQHvdKx9BkjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4cluHL5tkRiw1L3HYm+etQPAqTbKbQHeCMNRkEH+pf4QoUkg
	pXlazAWloISQcenpHanEDxt76XSQ5gNJs58gu40LxJkf8C2lBgaIF+Nxhmo+aNxWeAfdEhkKDVO
	bPFPEOmZN1Ln3l9dzdopYmkpmUQezUDuOL5YYtHIbhA==
X-Gm-Gg: ASbGncuvQU2rgOSkVmtXkLS2PRzhfrZkrEMsxvyCQStp0LD3vz1GjyM4Q5F90fHtMqE
	b7YGaUWf8npg8/c2+ElUr6vvkvIK3+8r/cjnh1AxN8Vl3+Dm/53iTMtn/6a0Q0RxzFKZC5XnOuT
	yjYz30QNsJapVLF+RYd9o/ztSVQQi7LNJzYi5l0Zl5IZhU1yHVRl6xP8GUrWnUtNGcdbEvy6C8Z
	SKa/caT
X-Google-Smtp-Source: AGHT+IFLoopykPAqNjtd5W6TlSWzjDWsawJ2toIWTAtblBp5S97TdAnSiXv4oGkhVDw4RAbSB9WhWLXl+SLYi5ShPb0=
X-Received: by 2002:a17:907:9415:b0:ae6:f8bc:3f82 with SMTP id
 a640c23a62f3a-af2f9271ac6mr200013166b.52.1753260277945; Wed, 23 Jul 2025
 01:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751617911.git.zhoubinbin@loongson.cn> <f4c546b0160294296c98b6b12b0ab1d2000dd44c.1751617911.git.zhoubinbin@loongson.cn>
 <20250710100323.GI1431498@google.com> <CAMpQs4LQME7oO8i2FWgUsAQqwThcp=R3jubPGqZ1Vr-pvEHvoA@mail.gmail.com>
 <20250718135246.GH11056@google.com> <CAMpQs4+AOc2bkOFSWW_hX-+akyRT9vTBb6mFJGKpjt9fSsF7MQ@mail.gmail.com>
 <20250723073125.GL11056@google.com> <CAMpQs4Ld75Ej7wn82iwMu4VeyoTUBeD7UttYoiKXwTqCK6yTzQ@mail.gmail.com>
 <20250723082111.GO11056@google.com>
In-Reply-To: <20250723082111.GO11056@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 23 Jul 2025 16:44:23 +0800
X-Gm-Features: Ac12FXzKZe24rmw-T7HjbIkZgLdtAblZt7fSQoAbY_MNcvk4GacSAWm8ndgOBEk
Message-ID: <CAMpQs4JMSZ-079Am2YnukgajU75j=GPt=qoh=f0=vRwqw8mVZw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
To: Lee Jones <lee@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io, 
	kexybiscuit@aosc.io, wangyao@lemote.com, Chong Qiao <qiaochong@loongson.cn>, 
	Corey Minyard <corey@minyard.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee:

On Wed, Jul 23, 2025 at 4:21=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 23 Jul 2025, Binbin Zhou wrote:
>
> > Hi Lee:
> >
> > Thanks for your reply again.
> >
> > On Wed, Jul 23, 2025 at 3:31=E2=80=AFPM Lee Jones <lee@kernel.org> wrot=
e:
> > >
> > > On Mon, 21 Jul 2025, Binbin Zhou wrote:
> > >
> > > > Hi Lee:
> > > >
> > > > Thanks for your reply.
> > > >
> > > >
> > > > On Fri, Jul 18, 2025 at 9:52=E2=80=AFPM Lee Jones <lee@kernel.org> =
wrote:
> > > > >
> > > > > On Fri, 11 Jul 2025, Binbin Zhou wrote:
> > > > >
> > > > > > Hi Lee:
> > > > > >
> > > > > > Thanks for your review.
> > > > > >
> > > > > > On Thu, Jul 10, 2025 at 6:03=E2=80=AFPM Lee Jones <lee@kernel.o=
rg> wrote:
> > > > > > >
> > > > > > > On Fri, 04 Jul 2025, Binbin Zhou wrote:
> > > > > > >
> > > > > > > > Since the display is a sub-function of the Loongson-2K BMC,=
 when the
> > > > > > > > BMC reset, the entire BMC PCIe is disconnected, including t=
he display
> > > > > > > > which is interrupted.
> > > > > > > >
> > > > > > > > Quick overview of the entire LS2K BMC reset process:
> > > > > > > >
> > > > > > > > There are two types of reset methods: soft reset (BMC-initi=
ated reboot
> > > > > > > > of IPMI reset command) and BMC watchdog reset (watchdog tim=
eout).
> > > > > > > >
> > > > > > > > First, regardless of the method, an interrupt is generated =
(PCIe interrupt
> > > > > > > > for soft reset/GPIO interrupt for watchdog reset);
> > > > > > > >
> > > > > > > > Second, during the interrupt process, the system enters bmc=
_reset_work,
> > > > > > > > clears the bus/IO/mem resources of the LS7A PCI-E bridge, w=
aits for the BMC
> > > > > > > > reset to begin, then restores the parent device's PCI confi=
guration space,
> > > > > > > > waits for the BMC reset to complete, and finally restores t=
he BMC PCI
> > > > > > > > configuration space.
> > > > > > > >
> > > > > > > > Display restoration occurs last.
> > > > > > > >
> > > > > > > > Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> > > > > > > > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > > > > > > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > > Acked-by: Corey Minyard <corey@minyard.net>
> > > > > > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > > > > > ---
> > > > > > > >  drivers/mfd/ls2k-bmc-core.c | 328 ++++++++++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 328 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k=
-bmc-core.c
> > > > > > > > index 50d560a4611c..1ae673f6a196 100644
> > > > > > > > --- a/drivers/mfd/ls2k-bmc-core.c
> > > > > > > > +++ b/drivers/mfd/ls2k-bmc-core.c
> > > > > > > > @@ -10,8 +10,12 @@
> > > > > > > >   */
> > > > > > > >
> > > > > > > >  #include <linux/aperture.h>
> > > > > > > > +#include <linux/bitfield.h>
> > > > > > > > +#include <linux/delay.h>
> > > > > > > >  #include <linux/errno.h>
> > > > > > > >  #include <linux/init.h>
> > > > > > > > +#include <linux/iopoll.h>
> > > > > > > > +#include <linux/kbd_kern.h>
> > > > > > > >  #include <linux/kernel.h>
> > > > > > > >  #include <linux/mfd/core.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > > @@ -19,6 +23,8 @@
> > > > > > > >  #include <linux/pci_ids.h>
> > > > > > > >  #include <linux/platform_data/simplefb.h>
> > > > > > > >  #include <linux/platform_device.h>
> > > > > > > > +#include <linux/stop_machine.h>
> > > > > > > > +#include <linux/vt_kern.h>
> > > > > > > >
> > > > > > > >  /* LS2K BMC resources */
> > > > > > > >  #define LS2K_DISPLAY_RES_START               (SZ_16M + SZ_=
2M)
> > > > > > > > @@ -29,6 +35,48 @@
> > > > > > > >  #define LS2K_IPMI3_RES_START         (LS2K_IPMI2_RES_START=
 + LS2K_IPMI_RES_SIZE)
> > > > > > > >  #define LS2K_IPMI4_RES_START         (LS2K_IPMI3_RES_START=
 + LS2K_IPMI_RES_SIZE)
> > > > > > > >
> > > > > > > > +#define LS7A_PCI_CFG_SIZE            0x100
> > > > > > > > +
> > > > > > > > +/* LS7A bridge registers */
> > > > > > > > +#define LS7A_PCIE_PORT_CTL0          0x0
> > > > > > > > +#define LS7A_PCIE_PORT_STS1          0xC
> > > > > > > > +#define LS7A_GEN2_CTL                        0x80C
> > > > > > > > +#define LS7A_SYMBOL_TIMER            0x71C
> > > > > > > > +
> > > > > > > > +/* Bits of LS7A_PCIE_PORT_CTL0 */
> > > > > > > > +#define LS2K_BMC_PCIE_LTSSM_ENABLE   BIT(3)
> > > > > > > > +
> > > > > > > > +/* Bits of LS7A_PCIE_PORT_STS1 */
> > > > > > > > +#define LS2K_BMC_PCIE_LTSSM_STS              GENMASK(5, 0)
> > > > > > > > +#define LS2K_BMC_PCIE_CONNECTED              0x11
> > > > > > > > +
> > > > > > > > +#define LS2K_BMC_PCIE_DELAY_US               1000
> > > > > > > > +#define LS2K_BMC_PCIE_TIMEOUT_US     1000000
> > > > > > > > +
> > > > > > > > +/* Bits of LS7A_GEN2_CTL */
> > > > > > > > +#define LS7A_GEN2_SPEED_CHANG                BIT(17)
> > > > > > > > +#define LS7A_CONF_PHY_TX             BIT(18)
> > > > > > > > +
> > > > > > > > +/* Bits of LS7A_SYMBOL_TIMER */
> > > > > > > > +#define LS7A_MASK_LEN_MATCH          BIT(26)
> > > > > > > > +
> > > > > > > > +/* Interval between interruptions */
> > > > > > > > +#define LS2K_BMC_INT_INTERVAL                (60 * HZ)
> > > > > > > > +
> > > > > > > > +/* Maximum time to wait for U-Boot and DDR to be ready wit=
h ms. */
> > > > > > > > +#define LS2K_BMC_RESET_WAIT_TIME     10000
> > > > > > > > +
> > > > > > > > +/* It's an experience value */
> > > > > > > > +#define LS7A_BAR0_CHECK_MAX_TIMES    2000
> > > > > > > > +
> > > > > > > > +#define LS2K_BMC_RESET_GPIO          14
> > > > > > > > +#define LOONGSON_GPIO_REG_BASE               0x1FE00500
> > > > > > > > +#define LOONGSON_GPIO_REG_SIZE               0x18
> > > > > > > > +#define LOONGSON_GPIO_OEN            0x0
> > > > > > > > +#define LOONGSON_GPIO_FUNC           0x4
> > > > > > > > +#define LOONGSON_GPIO_INTPOL         0x10
> > > > > > > > +#define LOONGSON_GPIO_INTEN          0x14
> > > > > > > > +
> > > > > > > >  static struct resource ls2k_display_resources[] =3D {
> > > > > > > >       DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "=
simpledrm-res"),
> > > > > > > >  };
> > > > > > > > @@ -62,6 +110,273 @@ static struct mfd_cell ls2k_bmc_cells[=
] =3D {
> > > > > > > >       MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +/* Index of the BMC PCI configuration space to be restored=
 at BMC reset. */
> > > > > > > > +struct ls2k_bmc_pci_data {
> > > > > > > > +     u32 pci_command;
> > > > > > > > +     u32 base_address0;
> > > > > > > > +     u32 interrupt_line;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +/* Index of the parent PCI configuration space to be resto=
red at BMC reset. */
> > > > > > > > +struct ls2k_bmc_bridge_pci_data {
> > > > > > > > +     u32 pci_command;
> > > > > > > > +     u32 base_address[6];
> > > > > > > > +     u32 rom_addreess;
> > > > > > > > +     u32 interrupt_line;
> > > > > > > > +     u32 msi_hi;
> > > > > > > > +     u32 msi_lo;
> > > > > > > > +     u32 devctl;
> > > > > > > > +     u32 linkcap;
> > > > > > > > +     u32 linkctl_sts;
> > > > > > > > +     u32 symbol_timer;
> > > > > > > > +     u32 gen2_ctrl;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct ls2k_bmc_pdata {
> > > > > > > > +     struct device *dev;
> > > > > > > > +     struct work_struct bmc_reset_work;
> > > > > > > > +     struct ls2k_bmc_pci_data bmc_pci_data;
> > > > > > > > +     struct ls2k_bmc_bridge_pci_data bridge_pci_data;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static bool ls2k_bmc_bar0_addr_is_set(struct pci_dev *ppde=
v)
> > > > > > >
> > > > > > > Nit: This is usually called pdev.
> > > > > >
> > > > > > OK.
> > > > >
> > > > > Snip things you agree with please.
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > +static void ls2k_bmc_events_fn(struct work_struct *work)
> > > > > > > > +{
> > > > > > > > +     struct ls2k_bmc_pdata *priv =3D container_of(work, st=
ruct ls2k_bmc_pdata, bmc_reset_work);
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * The PCI-E is lost when the BMC resets, at which po=
int access to the PCI-E
> > > > > > > > +      * from other CPUs is suspended to prevent a crash.
> > > > > > > > +      */
> > > > > > > > +     stop_machine(ls2k_bmc_recover_pci_data, priv, NULL);
> > > > > > > > +
> > > > > > > > +#ifdef CONFIG_VT
> > > > > > >
> > > > > > > #ifery in C-files is generally frowned upon.
> > > > > > >
> > > > > > > Is the any pieces of run-time data you can use instead?
> > > > > > >
> > > > > > > Or a stub which culminated in a no-op if !CONFIG_VT?
> > > > > >
> > > > > > Emm, I'm not sure if I understand correctly, but is the followi=
ng way suitable?
> > > > > >
> > > > > >         if (IS_ENABLED(CONFIG_VT))
> > > > >
> > > > > It's better than #if, but even better would be a stub in a header=
 file.
> > > >
> > > > Hmm... The declarations for vt_move_to_console()/set_console() are =
in
> > > > two VT-related header files [1]. Adding the relevant stub functions
> > > > involves the VT subsystem, which does not seem to be relevant to th=
e
> > > > subject of our patch set.
> > > > Therefore, I think the above modification is more suitable for us.
> > >
> > > All of the subsystems in the kernel are open source, last time I chec=
ked. :)
> > >
> > > But okay, I won't insist on it.
> > >
> > > > [1]:
> > > > vt_move_to_console:
> > > > https://elixir.bootlin.com/linux/v6.15/source/include/linux/vt_kern=
.h#L141
> > > > set_console: https://elixir.bootlin.com/linux/v6.15/source/include/=
linux/kbd_kern.h#L69
> > > >
> > > > >
> > > > > >                 /* Re-push the display due to previous PCI-E lo=
ss. */
> > > > > >                 set_console(vt_move_to_console(MAX_NR_CONSOLES =
- 1, 1));
> > > > > >
> > > > > > >
> > > > > > > > +     /* Re-push the display due to previous PCI-E loss. */
> > > > > > > > +     set_console(vt_move_to_console(MAX_NR_CONSOLES - 1, 1=
));
> > > > > > > > +#endif
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static irqreturn_t ls2k_bmc_interrupt(int irq, void *arg)
> > > > > > > > +{
> > > > > > > > +     struct ls2k_bmc_pdata *priv =3D arg;
> > > > > > > > +     static unsigned long last_jiffies;
> > > > > > > > +
> > > > > > > > +     if (system_state !=3D SYSTEM_RUNNING)
> > > > > > > > +             return IRQ_HANDLED;
> > > > > > > > +
> > > > > > > > +     /* Skip interrupt in LS2K_BMC_INT_INTERVAL */
> > > > > > > > +     if (time_after(jiffies, last_jiffies + LS2K_BMC_INT_I=
NTERVAL)) {
> > > > > > > > +             schedule_work(&priv->bmc_reset_work);
> > > > > > > > +             last_jiffies =3D jiffies;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return IRQ_HANDLED;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * Saves the BMC parent device (LS7A) and its own PCI conf=
iguration space registers
> > > > > > > > + * that need to be restored after BMC reset.
> > > > > > > > + */
> > > > > > > > +static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, s=
truct ls2k_bmc_pdata *priv)
> > > > > > > > +{
> > > > > > > > +     struct pci_dev *parent =3D pdev->bus->self;
> > > > > > > > +     int base, i =3D 0;
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(parent, PCI_COMMAND, &priv->bri=
dge_pci_data.pci_command);
> > > > > > > > +
> > > > > > > > +     for (base =3D PCI_BASE_ADDRESS_0; base <=3D PCI_BASE_=
ADDRESS_5; base +=3D 4, i++)
> > > > > > > > +             pci_read_config_dword(parent, base, &priv->br=
idge_pci_data.base_address[i]);
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(parent, PCI_ROM_ADDRESS, &priv-=
>bridge_pci_data.rom_addreess);
> > > > > > > > +     pci_read_config_dword(parent, PCI_INTERRUPT_LINE, &pr=
iv->bridge_pci_data.interrupt_line);
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(parent, parent->msi_cap + PCI_M=
SI_ADDRESS_LO,
> > > > > > > > +                           &priv->bridge_pci_data.msi_lo);
> > > > > > > > +     pci_read_config_dword(parent, parent->msi_cap + PCI_M=
SI_ADDRESS_HI,
> > > > > > > > +                           &priv->bridge_pci_data.msi_hi);
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_=
EXP_DEVCTL,
> > > > > > > > +                           &priv->bridge_pci_data.devctl);
> > > > > > > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_=
EXP_LNKCAP,
> > > > > > > > +                           &priv->bridge_pci_data.linkcap)=
;
> > > > > > > > +     pci_read_config_dword(parent, parent->pcie_cap + PCI_=
EXP_LNKCTL,
> > > > > > > > +                           &priv->bridge_pci_data.linkctl_=
sts);
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(parent, LS7A_GEN2_CTL, &priv->b=
ridge_pci_data.gen2_ctrl);
> > > > > > > > +     priv->bridge_pci_data.gen2_ctrl |=3D FIELD_PREP(LS7A_=
GEN2_SPEED_CHANG, 0x1)
> > > > > > > > +                                     | FIELD_PREP(LS7A_CON=
F_PHY_TX, 0x0);
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(parent, LS7A_SYMBOL_TIMER, &pri=
v->bridge_pci_data.symbol_timer);
> > > > > > > > +     priv->bridge_pci_data.symbol_timer |=3D LS7A_MASK_LEN=
_MATCH;
> > > > > > > > +
> > > > > > > > +     pci_read_config_dword(pdev, PCI_COMMAND, &priv->bmc_p=
ci_data.pci_command);
> > > > > > > > +     pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &priv=
->bmc_pci_data.base_address0);
> > > > > > > > +     pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &priv=
->bmc_pci_data.interrupt_line);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int ls2k_bmc_pdata_initial(struct pci_dev *pdev, st=
ruct ls2k_bmc_pdata *priv)
> > > > > > > > +{
> > > > > > > > +     int gsi =3D 16 + (LS2K_BMC_RESET_GPIO & 7);
> > > > > > > > +     void __iomem *gpio_base;
> > > > > > > > +     int irq, ret;
> > > > > > > > +
> > > > > > > > +     ls2k_bmc_save_pci_data(pdev, priv);
> > > > > > > > +
> > > > > > > > +     INIT_WORK(&priv->bmc_reset_work, ls2k_bmc_events_fn);
> > > > > > > > +
> > > > > > > > +     ret =3D devm_request_irq(&pdev->dev, pdev->irq, ls2k_=
bmc_interrupt,
> > > > > > > > +                            IRQF_SHARED | IRQF_TRIGGER_FAL=
LING, "ls2kbmc pcie", priv);
> > > > > > > > +     if (ret) {
> > > > > > > > +             dev_err(priv->dev, "LS2KBMC PCI-E request_irq=
(%d) failed\n", pdev->irq);
> > > > > > >
> > > > > > > Please don't use function names in error messages.
> > > > > > >
> > > > > > > Make them human readable inclusive of non-kernel engineers.
> > > > > >
> > > > > > How about:
> > > > > >
> > > > > > dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ %d.\n"=
, pdev->irq);
> > > > > >
> > > > > > also, the error message regarding GPIO IRQ is as follows:
> > > > > >
> > > > > > dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n",=
 irq);
> > > > >
> > > > > Yes, much better.
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > +     priv =3D devm_kzalloc(&dev->dev, sizeof(*priv), GFP_K=
ERNEL);
> > > > > > > > +     if (IS_ERR(priv)) {
> > > > > > > > +             ret =3D -ENOMEM;
> > > > > > > > +             goto disable_pci;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     priv->dev =3D &dev->dev;
> > > > > > > > +
> > > > > > > > +     ret =3D ls2k_bmc_pdata_initial(dev, priv);
> > > > > > >
> > > > > > > priv (ddata) already contains dev - you don't need both.
> > > > > >
> > > > > > Yes, we just pass priv(ddata), and
> > > > > >
> > > > > > struct pci_dev *pdev =3D to_pci_dev(ddata->dev);
> > > > >
> > > > > I would pass dev ... hold on, where do you store priv for reuse?
> > > >
> > > > Sorry, I am not entirely sure I understand your question. It does n=
ot
> > > > appear that priv needs to be reused.
> > >
> > > Then why does it exist at all?
> >
> > Emm...
> > Perhaps I have strayed from the topic of our discussion. Let's try to
> > get back on track.
> > After replying to your previous email, I thought about whether your
> > question was whether we need something similar to
> >
> > pci_set_drvdata(dev, priv);
> >
> > Looking at the code as a whole, perhaps it is because I am used to
> > using `priv` as a function parameter, so in most cases I use `priv`
> > directly, except in interrupt routines and INIT_WORK
> > I hope we are on the right track with our discussion.
>
> Okay, use priv for now.  But only pass other parameters when they cannot
> be derived from priv.  Also ddata tends to be preferred over priv in
> this subsystem.

Okay, if you don't mind me using `priv(ddata)` as the parameter for
ls2k_bmc_pdata_initial(), then my V8 patchset[1] has addressed all of
your comments in V7.

[1]: https://lore.kernel.org/all/cover.1752548073.git.zhoubinbin@loongson.c=
n/

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--=20
Thanks.
Binbin

