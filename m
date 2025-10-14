Return-Path: <linux-kernel+bounces-851615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8FBD6E61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE10A18A571A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFCB1E98EF;
	Tue, 14 Oct 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp/nzGin"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3191F4E4F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760403337; cv=none; b=KlwTi1VSTxpY9dIsC0bJn31yZ00D7P+5tLwvSKEoBHE+xo2r1bgD0cWhrHGdsn5f2QDQ/giqaKiUIRVpE2nNID1OHaRFfx9L+9KfuNT/LurX8g4dHfpVa7FWkJcpMX7w2FtF7htCSP6DJhVUPLhcjIvDX2QhJNIqf7Qpia25jT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760403337; c=relaxed/simple;
	bh=kf9j/5BzOVdGxyqzzdIuSEzvc4B6q5OLpRyAAP0moXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcIHgOpUk4Xe7Al4WbJ62KlcW4CezEJNbPb7111QqKLeLN+xy7c8qWJHvYdjdQLahC820IwXCbFTRF6R+QTysJ4ut7CulIgbVuyFiAUya9QTzvbs3jc4Pi+AsG32WD7KQoFmU4SdQgCfH6NxYF3jucsH7zSRyJ+dk91NGYZsTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp/nzGin; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4180654a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760403335; x=1761008135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=;
        b=Dp/nzGinqJbErOFevH4DuXU7a9qWYxzk5/0egQDjyZVadUBAsgJX3zbARfcPqFRPc6
         6vLsn8lo6g1h9Hzm/mGCbM0im77mEO4xP4ZwihvtvGN4D1ZKR+nsCgIMYCVDj9e1PvTu
         ra9vlSZF0EnZxwO3iBfSa47CLPjZFSGU7ar+6rqn2Mepz772MNWmSbrOYtA2/tAEjeL6
         cJIkDbrr9oHQynV9qb8Zx/LBLvIFvty1RSetl/aniHjI9sgWC7hJ54gxGQhJlQhE2lK3
         El2HJ5iDBalYKuf2Yp7tfcmeu304xGPSdPg/RUSh4bQMYJ0ceW9czzLimlAmxvFxVesb
         UyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760403335; x=1761008135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=;
        b=iFDjtLYFoEw693caSrajXjf85yUDwQeP+43831DmMHOULynHROyBLox/eqU3lqFrDc
         lma5L61XusIUeVluvkv1s3nFemkq6a2f1Mb//RK73sfsMtK0kBGZIT43L1Jc5q+yoCOk
         0eTEUiFiE4EZZzmI53U+wn29aqyb1JKpRCAJwTJbif4Ve+AZS43VZvDNhQUXLSoq5oGk
         43AMH/y4Qt2QSSbdcCAtJOisLsnsuidxpkdOK0LNP32bGP8QzPZ8IuDFVWnkM3Vqhn6U
         ATzWkRGjv4R6jSDlDZYJaRI8CGV9yRnpRSu4Z/yKDbjZfwsIeXihGkeuICwoq7lt9Yge
         dhsA==
X-Forwarded-Encrypted: i=1; AJvYcCWdsCa3N+D6AyjlTKFhj5LxSSUc4bnGQMhdyB7WcaqtVgKV3hKHWLs/2L+Vu6B9/kC1madbSA89JwCuGeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTaPdj14XwGGYgX7IMbBhMTEH7mfgXneEG0fyL6wne8ZzgRtM
	T4iU6dsb/8q5vILnI8majpAvayS/412/Z2+Cp4Q1DhHJUA28Mu9+dfVC
X-Gm-Gg: ASbGnctuNQ/4KqsQMRS/p5lR9i8TZgKAt5rDC1jz0SEUay6rS+IEjvCx1JRNXii0COo
	ugMlFFVywNvNiNfO5k0mzptx8YeKmOxZPnhj08lATklXYnlKT68I1ZgYjS60tARw0ODX/MQuu4H
	z23/sxzWE6Zuo4Ilxgo3zU0XN5hSeVo9JU0+v5aL8I3ji67/q7etoL7SPdpEDsgUle1zkg1riu3
	ysx4lh7wxBJ6L/Aalm13zWn9jeFzM3zG3Tq76RSbkWta5SxALy/1kLIEND3rzmR1GO7GtaJA9Ay
	OXIAbBNCx+oh+n8qUO2FK7BQ/tYvrgjBtXvDpBE37QIGfdBAlFYplYiTHNb2Jb9o2cZQfiSe77/
	4KP7Q1HMoIcxwU7mh7eHm+Tsl52nQ0Rd1hP4pob9G
X-Google-Smtp-Source: AGHT+IGniqk01IgDaiRJwaKVGBcopVfs/CxGUBowAuplH5VoT3lCcXuXMawjfUp7c/hF1vuAQ69KrA==
X-Received: by 2002:a17:902:e5c6:b0:268:db2:b78f with SMTP id d9443c01a7336-29027402c15mr322158845ad.44.1760403334516;
        Mon, 13 Oct 2025 17:55:34 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29040e02648sm112012925ad.116.2025.10.13.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 17:55:34 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:54:49 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Genes Lists <lists@sapience.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <xfzcvv6ezleds24wvha2apkz5kirhcmoydm3on2hnfrxcwuc3g@koj6plovnvbd>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
 <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
 <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>

On Mon, Oct 13, 2025 at 07:45:05AM -0400, Genes Lists wrote:
> On Mon, 2025-10-13 at 16:46 +0800, Inochi Amaoto wrote:
> > On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> > > On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > > > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > > > Mainline fails to boot - 6.17.1 works fine.
> > > > > Same kernel on an older laptop without any nvme works just
> > > > > fine.
> > > > > 
> > > > > It seems to get stuck enumerating disks within the initramfs
> > > > > created by
> > > > > dracut.
> > > > > 
> > > > > ,
> ...
> 
> > > Bisect landed here. (cc linux-pci@vger.kernel.org)
> > > Hopefully it is helpful, even though I don't see MSI in lspci
> > > output
> > > (which is provided below).
> > > 
> > > gene
> > > 
> > > 
> > > 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> > > commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> > > Author: Inochi Amaoto <inochiama@gmail.com>
> > > Date:   Thu Aug 14 07:28:32 2025 +0800
> > > 
> > >     PCI/MSI: Add startup/shutdown for per device domains
> > > 
> > >     As the RISC-V PLIC cannot apply affinity settings without
> > > invoking
> > >     irq_enable(), it will make the interrupt unavailble when used
> > > as an
> > >     underlying interrupt chip for the MSI controller.
> > > 
> > >     Implement the irq_startup() and irq_shutdown() callbacks for
> > > the
> > > PCI MSI
> > >     and MSI-X templates.
> > > 
> > >     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the
> > > parent
> > > startup
> > >     and shutdown functions are invoked. That allows the interrupt
> > > on
> > > the parent
> > >     chip to be enabled if the interrupt has not been enabled during
> > >     allocation. This is necessary for MSI controllers which use
> > > PLIC as
> > >     underlying parent interrupt chip.
> > > 
> > >     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
> > >     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > >     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >     Link: https://lore.kernel.org/all/20250813232835.43458-3-
> > > inochiama@gmail.com
> > > 
> > >  drivers/pci/msi/irqdomain.c | 52
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/msi.h         |  2 ++
> > >  2 files changed, 54 insertions(+)
> > > 
> > > 
> ...
> 
> > 
> > 
> > I think this is caused by VMD device, which I have a temporary
> > solution
> > here [1]. Since I have no idea about how VMD works, I hope if anyone
> > can help to convert this as an formal fix.
> > 
> > [1]
> > https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzo
> > gihz5oplw@gsvgn75lib6t/
> > 
> > Regards,
> > Inochi
> 
> Thank you Inochi
> 
> I tried this patch over 6.18-rc1.
> 
>  It get's further than without the patch but around the time I get
> prompted for passphrase for the luks partition
> (root is not encrypted) it crashes. 
> 
> I have uploaded 2 images I took of the screen when this happens and
> uploaded them to here:
> 
>     https://0x0.st/KSNz.jpg
>     https://0x0.st/KSNi.jpg
> 

This picture is only a WARNING from perf_get_x86_pmu_capability,
and no other information. So I am not sure whether it is caused
by this change. But from the original report I have, it solves
the problem at that time.

By the way, can you test the following change?
https://lore.kernel.org/all/2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5/

If it is OK, I will send a patch for it.

Regards,
Inochi

