Return-Path: <linux-kernel+bounces-850058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A85BD1BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4169718938E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F242E7BD3;
	Mon, 13 Oct 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPd8AJ1+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EF2E6CAA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339326; cv=none; b=D1DgcsCOWot+jBQsp5ynmvaE7eVYFf+uw3nV0YMIz4GnBwisbe15mA1xGShA2/oICG66cpwq/zUxegqyKqDlLBVxKP3xo6IvuMp+oL5tF5/0Sq7cU5zzcYIvZlT3bs3Os2xx4CdxmE/qW2CSPDV71hVCB1tJIVhRr+J+Wheqetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339326; c=relaxed/simple;
	bh=EXSGqGhcx0qA0mCe99DWII7ndXEYJ5l3+tgWWwgSXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXb6MzqUa3tYdcYV1stjl0/3JboUDmJNcAIyqjsWJilxZDfticwj4V9eK8Swm3r5A9JiuYkaBJiOqTf8TXavDjROpSPsSKy0AjepLZtwrV79yjxrVuhoGglS+U1k5L//c9NMt8hCf/NYz7uekLwG3BTLcM0vmIY30aaKYCUaHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPd8AJ1+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e29d65728so22244485e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760339323; x=1760944123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q73G+890UFAW8zpG9IZiGO239bC+EqQ7jfRlndkYTr8=;
        b=MPd8AJ1+ApYGdScPRFaPmp9mNHTRe6jwabjGgmkzWZpnrrZBVgWJp4kn5zL9+FhCkJ
         avMDAd9JNSx+0/PdIWPqHpr49KykzuwW4D59Fpi/nMjvIMUI4OzCiK0HBuWdEtTjZIzc
         1JoknmYvvDVd38jQZyh6O+wuO/6wk2w9lRwCYM9a83HUj1JYVu6AE93swWq0IBhSGahV
         x71qLNS34bLQqei2cm2ZtRiLd6mQF8SakhO3gUE0+gehUNapm/5RosZgWXJMuffQIi3J
         1oYjHeJmWb1GGc86fsHI+SETMz9sv/BX0E0EtnO4g6A3ii6N3bsZ2I/OyxR0dNYHlsYn
         SCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760339323; x=1760944123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q73G+890UFAW8zpG9IZiGO239bC+EqQ7jfRlndkYTr8=;
        b=Fg2yYqH+LR+mYf6aHQa3nzECWURFHqLA8rlMyqHRyKNa17C0qDNAmou+98SKBpUjOJ
         9g1r/EDyLZMLcVyiPdDAsyKB9mmUJao1aaebiR4GhSapCo2RKe5W4LFELBV87V4zBKRt
         dosiy65mR5AIh/qgr0GDQSnZ6ORfcr4ElHpuh9YvfFvMnd9YvUHi0nJgOjvdw3+N//K2
         2TRmrYxFyTmZYszDVU/eEQjhFZI/BHOi1xgsojo58yF3ailjk1Kx4NPLOH/MDbq2AsVG
         gdW0WId3FYoWFXJjKHQKNX0mmCfNZtZ5UUkqu/fNG1nThpdUNfjpgdr7I3TTbXU3Pefc
         QygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpoSLWqZIVi8AxoAZX6mnFAhdINhl5eOsM6H7lOmLu9NsW2rY/NaQ3mBNNdU72D48s8nIgSeSFoouyBBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxepzapawMAbKlldsNg/yIss38pvGrU1m5G54rRD9yHL+QiVM
	s+nq5bfYf7WVQEyWvODhGq/+Ezxc62RLtdDpvc0sCqAhkkRJP4iMEPHO
X-Gm-Gg: ASbGnctJe+FBYqHsEyVMUWVA0ljTBVbMH5FgYcTIggIfovBINTeeTNJXHgC2kSfpGD3
	Ykno+2J6N95aNabuaQPDtUXiQyQwxfjOYyXlNP0SJZhKatys3t1vq5jG6+rc064TgPeXzZpm72p
	Tr9tkY9j+hnOGyWzWZhmH10ENbqLR3o8YLRv6ESw/oJIvxFnUNccSByX8Gjg01AxFA4CuABfCCA
	gMKqzuJLda1FqgOqbeBqIk1tjvChaRuVsvUgYkZnegOsJQIcehaKyASmQRDU4iN1mCWxF5+q+4f
	mdtgGEkuYopauASiPw2LmJPVb3B5cY07lzroIF5/HYMCxUHUOECrv3AfHDAzO83I/Bw2qxzoDbI
	/n4/XDtz3FO2NtPQqeSGJF3NYIAun1NmjP3gKL1HbG9MioYUgjfMWjaMs7bGjINEw6j96K49EJD
	o=
X-Google-Smtp-Source: AGHT+IGBQf5WfAQnt4odn+Dih9KpdOHpl0uzgnYj7ezJng23Hlwl5FAPDXpl3Fy1D1TvSkPSSqAKIw==
X-Received: by 2002:a05:600c:a148:b0:46f:c55a:5a8c with SMTP id 5b1f17b1804b1-46fc55a5bbamr20650895e9.4.1760339322745;
        Mon, 13 Oct 2025 00:08:42 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d447sm17161836f8f.9.2025.10.13.00.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 00:08:41 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E0A3BBE2DE0; Mon, 13 Oct 2025 09:08:40 +0200 (CEST)
Date: Mon, 13 Oct 2025 09:08:40 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Weikang Guo <guoweikang.kernel@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Raphael La Greca <raphael.la.greca@gmail.com>
Subject: Re: [QUESTION] Plans for GDIX1003 Support in Goodix Touchscreen
 Driver
Message-ID: <aOyleKvZe336pSSx@eldamar.lan>
References: <CAOm6qnnhR9++REgtjhZpqNXkBbBAZsGAY8Oy89cXUF9S=Vy-9Q@mail.gmail.com>
 <8c7b5560-27d0-42bc-8f25-0797500fb889@redhat.com>
 <CAOm6qnmYSQz_YVaWw1c-fMm3NCVV9MoQhLQ0XGzK9o2RybLHmw@mail.gmail.com>
 <72619870-bf83-47f9-9b66-6678e245364c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72619870-bf83-47f9-9b66-6678e245364c@redhat.com>

Hi,

On Sat, Mar 01, 2025 at 12:36:40PM +0100, Hans de Goede wrote:
> Hi WeiKang,
> 
> On 27-Feb-25 12:36 PM, Weikang Guo wrote:
> > Hi, Hans
> > 
> > On Tue, 25 Feb 2025 at 20:09, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi WeiKang,
> >>
> >> On 25-Feb-25 3:04 AM, Weikang Guo wrote:
> >>> Hi Bastien, Hans, Dmitry,
> >>>
> >>> I am currently working on the Ayaneo Flip DS device, which I installed Kali
> >>> Linux with kernel version 6.8.11-amd. This device has two touchscreens,
> >>> but only one is functional. After investigating, I found that the second
> >>> touchscreen has the device ID GDIX1003(confirmed by exporting the results
> >>> through acpidump), and upon comparing with the current driver, I noticed
> >>> that only GDIX1001, GDIX1002, and GDX9110 are supported.
> >>>
> >>> I have also reviewed the ACPI description and can provide the details if
> >>> needed. Any guidance or updates on this would be greatly appreciated.
> >>
> >> I think this might just work with the existing goodix driver, just
> >> add the new GDIX1003 HID to the goodix_acpi_match table:
> >>
> >> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> >> index a3e8a51c9144..4b497540ed2d 100644
> >> --- a/drivers/input/touchscreen/goodix.c
> >> +++ b/drivers/input/touchscreen/goodix.c
> >> @@ -1519,6 +1519,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
> >>  static const struct acpi_device_id goodix_acpi_match[] = {
> >>         { "GDIX1001", 0 },
> >>         { "GDIX1002", 0 },
> >> +       { "GDIX1003", 0 },
> >>         { "GDX9110", 0 },
> >>         { }
> >>  };
> >>
> >> Note I'm not sure this will work, but is worth a try.
> >>
> > 
> > It works, thank you very much.
> 
> Thank you for testing.
> 
> I've submitted a patch upstream to add this new hardware-ID
> to the kernel:
> 
> https://lore.kernel.org/linux-input/20250301113525.6997-1-hdegoede@redhat.com/

Raphael La Greca has reported this issue as well in Debian at
https://lists.debian.org/debian-kernel/2025/10/msg00013.html an
confirmed the change to work.

Any chance this can be applied as proposed? Did the patch submission
felt trought the cracks?

Regards,
Salvatore

