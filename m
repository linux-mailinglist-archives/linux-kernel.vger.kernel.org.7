Return-Path: <linux-kernel+bounces-778462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02680B2E60B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1025E271F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684627B35D;
	Wed, 20 Aug 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="EXZgzHI4"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCAB24A054
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720389; cv=none; b=GjWSmgVLNo9uiqoySZfCh2FY8DJMLgPld/DsPoqehV5ZKiAhdt/GKItUk/io937bJwvDrHJA5XeW7VSUdYrRbrzgORtW/Z4zHXzag59lcIhZ7tc0GCOIyfUdzw2UjYwPB3v7PrKbvqgU8BZCl4+bhAsClkECS/BedB86FoHOWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720389; c=relaxed/simple;
	bh=ztEsOKgOGhkOLLBEaxQErT0eY/aEkvcpopDJpCjcwqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPz54Phundphxz+h3p3Ua9wzSXD45+qc2jkTRen3PCvm/dTsrqPjdDuX5pWpmZpZ+opM7tCuhMnzdo/2gy7wt1GtwbZoTADgpx7uC2Z7g6zILB79jjqtESJt3hGvsF9XIPKWntm/6hA2bjsGn4UFfjtSdZ8n3zQQQ7tfmwTSTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=EXZgzHI4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9dc5c8ee7so261519f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1755720386; x=1756325186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPRIORLZJLic/0oP6MjeZBOD75ymlcPvAsVkfv5abFk=;
        b=EXZgzHI4+vecfCg4WAvD6JbDNl5yTXYeyTFw1DLa9df1N8NE4cGI5wvQeOtd9cwFxi
         3/JduaesuRe4DgmhrjG0lyXMN9mp/FgiuxaJfU43ZgpCj0DA22SIRNK4Q5rhVHSoR+zK
         9fnqdNYK0Lo+AvARHJbitxUNt/YKj5PzzzAdJzGGgcCeaKzXfSdO/FlKIrZtQ7ydIyU4
         ouPR6mdkEY1N3HHU2FuMwtep73ssaf/xiIqSIl89+yOpxnIe5ys/GqSEVSxb85NRnpHC
         xnHj0GfV70/DnbkHpouZsAq/uZMqlRgBpDOptNTrDFs8p1As9hZxHh6M2ZJJY+j8L/5c
         hyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755720386; x=1756325186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPRIORLZJLic/0oP6MjeZBOD75ymlcPvAsVkfv5abFk=;
        b=dDmQC4otRfICjgwGaMZeGWjErxKizhPygLh4SbGwDbr8lIuVrJTWjqI+UACroUCAZ3
         u0zK9yu+TKQ3PInwmJpSVdJ1VMsMMCCVTBmTgM8y2IQkUNZ7fJiPRo8wYOf5aCBVpkrV
         e0Rjl3DMcPqIYuiV2MTIEZA1IC8lHl55Oh7eXjErNl5dZumOwAEvnqQH2pxmnhg/feCJ
         9NrzqkRaHCiKlmDrd+7o2MgZ53DiYMsPE+IZP+9CJ4+sd3CYXU05S2NmcdO+Cp6nb9l4
         s9xrlcgzkvHgiSYRTdw+kxFSYS2UMrYfYoiCzNFv8Q2vO790dE11yfwyL3HAPzt2Cjbv
         /q3g==
X-Forwarded-Encrypted: i=1; AJvYcCXkigj1+zw04FNTsZnvOk8ZUhUerym57NURDz7qsyPhQPybPbqasBwdRFLCc8UlO8gE3OljbridUanIUwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCDSiFbxa2T+w5Uo0cCyPNgv71Do27hbdFWMfsz+fK6Fu61Zr
	+wpirKgElqcdYpryJ2mhgHF0N4freF0rISyYmwD/du5FZVu2lCau4z5ycb5A0jbnEEs=
X-Gm-Gg: ASbGnctj9HoCV7fiSw5SPHtcCPZx4E/zso2p/mednL83UvBs5Z1nQ6R0JuzuLopJbs5
	C5MgnsdDq7raZjo4OB/ww/b/ETqvQn6VwEUghJ//ThhtErLfjk6OUYeOG7kmwCCMvUOCiq5vO8i
	e/ULl+kocYyjwCKXA3aaQKVuPeGhBMuspDV+w6RQpBPRFXgBlmhMkQ5dD1ApjH/oCfmRX26egn1
	t37NTvZ2VQjymAle7RjLSwD9U64alkvyrjg1XBp7fjWyMkwLEZ22BnlIpPmdp46NPLN+HlYXMVo
	v/pIrvyFR7i3e+0ttXh6m2/+RETBkS45vvVfbPyHvJoAUAVReycY4Z4mx7koVZeIKJecGYFVXqT
	eiUh3awDpuPfJipZLn0VAZmoku3BidJWbYX74YLnVzGUCWlOZUFi+u5gfs9qFvkBi/J5cF2wmkw
	c6OiyG
X-Google-Smtp-Source: AGHT+IFZoRI0AMFMAPaDlpVvz3RfQCKXg26W6gF/w2Djot9dOTMU/+XmyPpjyGfYLRjptRJSFPlD/w==
X-Received: by 2002:a05:6000:4284:b0:3b8:d32e:9222 with SMTP id ffacd0b85a97d-3c495d47553mr84126f8f.38.1755720385979;
        Wed, 20 Aug 2025 13:06:25 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c42cf1sm49041585e9.12.2025.08.20.13.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:06:25 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:06:23 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: David Wang <00107082@163.com>
Cc: Bart Van Assche <bvanassche@acm.org>, phil@philpotter.co.uk,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com
Subject: Re: [BUG] general protection fault when connecting an old mp3/usb
 device
Message-ID: <aKYqvyfSO-jSTZAr@equinox>
References: <20250818095008.6473-1-00107082@163.com>
 <2899b7cb-106b-48dc-890f-9cc80f1d1f8b@acm.org>
 <7c8215f8.87f8.198c6edb9f0.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8215f8.87f8.198c6edb9f0.Coremail.00107082@163.com>

On Wed, Aug 20, 2025 at 06:02:05PM +0800, David Wang wrote:
> 
> >Phillip, is this behavior perhaps introduced by commit 5ec9d26b78c4
> >("cdrom: Call cdrom_mrw_exit from cdrom_release function")? Please do
> 
> I manage to reproduce this, but It turns out this is not about my old mp3 device, but about my phone:
> Just connect-umount-discnnect, and repeat, after several rounds, an error log would show up.
> (I should pay attention to the USB Product  name in log......
> It is just that I check the log only when I have trouble  connecting my mp3 device, and assuming the log is about my mp3 device.)
> 

Interesting. It seems your phone is emulating a CD-ROM/optical device,
which is why the driver is being loaded and attached to it.

> 
> 
> And after I upgrade to 6.17-rc1, it could not be reproduced ( I managed to test 10+ rounds of connect/umount/disconnect cycle)
> So I think commit 5ec9d26b78c4 does fix my problem.
> 
> Thanks
> David
> 
> >Bart.

Yes, as you point out, this commit became part of 6.17-rc1 - it was not
present in 6.16.0. It actually removes the cdrom_mrw_exit call from the
module unregistration function, and puts it in cdrom_release instead.

This seems to have helped with the original issue - that of crashes when
removing USB optical drives on Chromebooks, and has likely helped here
for the same reason. Good to hear, and thanks for testing/confirming
that 6.17-rc1 has helped.

Regards,
Phil

