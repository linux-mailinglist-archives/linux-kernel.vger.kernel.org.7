Return-Path: <linux-kernel+bounces-751871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3CB16E98
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DDC18909F4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6592BDC0A;
	Thu, 31 Jul 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6WZ8i/C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382129CB5F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954014; cv=none; b=AmacRTEaQZ9nFZG0A2K6xWtpCQxwQ80dpI9+MtP8/JnXkPx/7+5OijkfeJkpdWD7q/mLzTWyiEsqMg3fmDdkU+/8fLwSJowimkN96l832EvOzwTKUxjvLvDctMgIsuGm6VTgMmOIH35ABYj3vn/4Cu63VYuU/cyB7ZWELELk31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954014; c=relaxed/simple;
	bh=HAE0M07kfmwm2bIgd0EFhrhI8SCbhCJBgk4/kTr52q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kE1yFyZQP3lHZJxag/gXOcx+0XyprTOv9T+NTLY+hTz7Ylh4kTJJx3mYsHDTIh1DRKLBXFZdPpE1vodRSLJUE5gK6lEo9MfqeQpXcxKV31/CCn7Q/XXf97+DpNzwrNCE1k4GsJ0sNDy/66bJ1AwNwqwQ2vPjAAFzSYdSq21BxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6WZ8i/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753954012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibTg+SRgN11l3CBDii5Rlz1jYBOrGbR0x6FnQRT7AjU=;
	b=X6WZ8i/C5kifhg+mwBc2O5IgwwttATRbB116RI7cxREx8L0wiw4L9MdC2yPbfQUAWTx9nb
	9mBGbrWVJQ0gc/3jFIF412QFFsa9yYSwLw/JGmV+zlTHnWMPkMDcLSuTuLlAS7oUn+upo8
	d4xgV2M/1ZaRx9bt8BXp1tSq+X1zwCY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Ka0vJepdNaOoPzYI4AgmkQ-1; Thu, 31 Jul 2025 05:26:49 -0400
X-MC-Unique: Ka0vJepdNaOoPzYI4AgmkQ-1
X-Mimecast-MFC-AGG-ID: Ka0vJepdNaOoPzYI4AgmkQ_1753954008
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5551b49f3c6so434654e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753954008; x=1754558808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibTg+SRgN11l3CBDii5Rlz1jYBOrGbR0x6FnQRT7AjU=;
        b=CCLffdmHNt4uakx0RkmN+Hi5+rowMRpIarBG7SBgIvouLnnfHGTuW7WOS+althz2VM
         BSv42SpmCofq1VKuO6xILX8eGvja0mQ6HMxyWz3+bU5CGUNpCatml1ih3yqiGBGufVNz
         pMEo5vaYjq/587kxAb8c5PN9HgNqBc01gG1DDcSUrVKZqLtyB+n2UHBD8oPC1IabLVYq
         jWW5Ez/7Hp1JFLxXWUSGunzAlBbs5CJZgD9SWf85fQ1vQKTpLJ0lhVEOX0eIWIbDYCtB
         JMuW0D8jfxnW36nkMB+vota4GzOjWXbLjzFpcA28We+GC/wDd75NpTzQ6jDKAu3MlKOT
         Qbdg==
X-Forwarded-Encrypted: i=1; AJvYcCVJjJQ7UbsZYwKq7tNIwb5NxlSzELhRvcnGH242ntBiVPSkPWvKsWuOjUQVXD6TMNrmMtWrYeYlbMrUroQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXm3Y1/h+X8CM+E4zKBz+AfnqQYh79tXYaI0yjknAQqK0AVVs
	7+anAGAbRSyotBdDMlHc8tYcKNQcnVwsatNQlnhK0AOJJdaqsyJkQ+biQzQj1qeMztLW9NuWxwt
	X0tdQmPPvjousB9DPXKV9ahsK8MTyKbxsMvQjmBp14wapOZb4g52VmFY3D0IwLP3VWAw/hj2m4U
	EFE0gxYL7Hv3rWpjCwpgHtEY/HyTMyfXEEfFOzpnDW
X-Gm-Gg: ASbGncucz2DCkwxRLoHnabITdcQLS5Z/2z32Yo2plwuu24mgdgsRa6cs64RxpWXefPe
	EDXbubZSzz3nMXa35cgJmHTu4uEKB29ihN4ClPRivH2atwPDU5X5RzD7mcFwQXUE+wEFGPBm0bx
	/bW0CeEHaUG3xYvNZrnptPjg==
X-Received: by 2002:a05:6512:ac6:b0:553:34b7:5731 with SMTP id 2adb3069b0e04-55b7c01c215mr2392884e87.3.1753954008185;
        Thu, 31 Jul 2025 02:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE6w2XDOCOmK9k6ZYQLq7cJeDiihFurFL/7bI1T0/78yuOQamPsKrbCnQYFIzjpGMXgWrAJFuIIpVjZd5I+aM=
X-Received: by 2002:a05:6512:ac6:b0:553:34b7:5731 with SMTP id
 2adb3069b0e04-55b7c01c215mr2392869e87.3.1753954007682; Thu, 31 Jul 2025
 02:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729182142.4875-1-makb@juniper.net> <aInKb8qr689ytM41@darkstar.users.ipa.redhat.com>
 <14D2606C-3492-4A32-A55D-428F1ADA9327@juniper.net>
In-Reply-To: <14D2606C-3492-4A32-A55D-428F1ADA9327@juniper.net>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 31 Jul 2025 17:27:27 +0800
X-Gm-Features: Ac12FXwS3FbJHa6wq7k1KIlDvA_sJjQJcjFuKheLdux5xeNdmmqeCSyBgT_ih2o
Message-ID: <CALu+AoQzQGypYRWXLiu1zfipL+H++x2H3pnL1uZgXPCFvumDiw@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
To: Brian Mak <makb@juniper.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Thu, 31 Jul 2025 at 01:02, Brian Mak <makb@juniper.net> wrote:
>
> On Jul 30, 2025, at 12:31 AM, Dave Young <dyoung@redhat.com> wrote
>
> >> +#ifdef CONFIG_OF_FLATTREE
> >> +     if (initial_boot_params) {
> >> +             setup_dtb(params, params_load_addr, setup_data_offset);
> >> +             setup_data_offset += sizeof(struct setup_data) +
> >> +                                  fdt_totalsize(initial_boot_params);
> >
> > I suppose current boot dtb should be valid for the current runnning
> > kernel, if you use kexec to load another kernel the next kexec reboot
> > could fail due to unmatching dtb.
> >
> > Make this unconditionally could break the previous working kexec?
>
> Hi Dave,
>
> Thanks for taking the time to look at this change!
>
> The behavior on ARM64 for carrying over the current boot DTB is
> unconditional, which is why I've made it unconditional here as well. I'm
> open to suggestions on this though. Realistically, would there be a case
> where having no DTB wouldn't break, but carrying over the current DTB
> would?

I worry about it since dtb is for providing boot related information,
weird things could happen if the kernel versions are different.

About arm64 and powerpc I think maybe just nobody noticed this
problem.  IMO it is wrong as kexec is designed to load different
kernels not limited to current running kernels.

Otherwise the current kexec_file_load syscall only supports passing
kernel_fd, initrd_fd and cmdline,  no extra param designed for dtb,  I
don't know if there are other ways via attaching dtb to kernel or
initrd.

Probably you can try to add a new flag to the kexec_file_load syscall,
 when this flag is set 1 then use the current dtb, otherwise do
nothing.  For arm64 and power,  ideally doing the same is better,  but
I'm not sure if we should change the old behavior, maybe they can go
with  default to load the dtb, but users can choose not to do that.


Thanks
Dave


