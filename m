Return-Path: <linux-kernel+bounces-889112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B6C3CC11
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B06874EE510
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACA34D917;
	Thu,  6 Nov 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHu8QXwK"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8B34403F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448904; cv=none; b=Qi6r/WKje9IPusl0kRVydljke8NJ3vkXxrKcTVqIEooNilJK2J9i9pq20eED5HpzM3EGE7CaE9rQMG87bzVBxOKu4vA0Bv3q8JTcTKtBsJ7XCka1StQRHc7GVXpxpgXWgT13lzQzPmqTRjOBYyf9sCSKV7SUDenCTprPXDclI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448904; c=relaxed/simple;
	bh=zOTaZMQBfTdrgEtVmwzmnPcqWwD6jnNQXB9lToGTo9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8xGV7Oh/3EdkEy15BdAcZp7QKnL0XbAPQbhBEDwPQMDBE9OoOqs/frJtSuWPibzXvso8ca/Jk+BNqZWDwVSSjyf0H5sFRsuqdaQR3coAjlAZr5Rd6s9BEQv3WM47XiFqegn+U8Q8o7el7axCpsWZPm07vHXEAS1j60GcTnLCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHu8QXwK; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-294fe7c2e69so13470275ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762448901; x=1763053701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=igZsw+VHb3F2oODDk3y9EP32fa29hnEO+2WLrYTePMw=;
        b=AHu8QXwKjw38HXggmTzxfM6q5ZnxGTf1J6l2ocB4GWHtW+d8eTJQuugBfIjDcQQTio
         mewiGqy6TDesgSV+XPibsfXbn9GxKOtFAK6W6Y0lMytt8wuE5ZuXKGju/Aj+R65Uh3/g
         qpFJoAQOS/BZ6IhPvjMThCTwtZRiCu3X2XOLPBh4Tf6QhHoib39IfJZvCc5q8tBYlWGp
         Cw8UiLWtE9X4diz+vSqSDwFgZJd2qDyvAmzT+J2hG+mYOQIVt2ZA8Jlbze1GxrjjAbwK
         0pFDc8QkobPkug4JiwfpuPcqgIRWpWa9reou7+tLThJv9jNRqNc6D8xvpsY1U4/XtqQQ
         Qg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448901; x=1763053701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igZsw+VHb3F2oODDk3y9EP32fa29hnEO+2WLrYTePMw=;
        b=lGNlJ9HnMNeSmgOq1VQ2xf0mtVuLBHiKv0OlcvxKGmklTNg93+gZsbrvI1o4efqMG7
         JA9PdQHPACIQDzs1yLErDh7kaSIeRnicbJycPwsycjWkP/PFBo+8UKz5gSHcldCVFOT2
         NxGHuFLEwpRmAQGxdVEy5ihVE0OmakH4xnW7WiLcJSF8VVik7GLrNZp0MZ7SQ6Xp3z1Z
         doFANCUgcBmWR8JWM4UomhJ0FhVyd6MaUhvSoy+AbtGNbF+s4SH8E0jYa0m9YmClTmXG
         YLhm7u04xKVrSnysmm15taCA/9O25/Cl6530Rbl6yIwwQLMpWXP7b5USI9IZcOtDFv6v
         4IwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIpRWbDGYnnmNqOq8FAcgJZ80IAP6vQEalOCyBa/BPnljHwgP34+sIMrNdd6Pw9SLj3mOk9QJvT3AfLQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MXYjoJgrH75jSh46wkQKDgI41w5W+Ku/qSqorJGsBwZpREOO
	bSAfFA0HT1iSZH+Cqh65ybjHImvmXOKOmNlSsfVaUFoOmh5Va71fBUU+BYfDnVojSg==
X-Gm-Gg: ASbGncs3Jjw1GeXzChQvS4pP/lwd8fy4G+7/iOM3SM2FRzUcGOYPvVdMY6dtmCEJHxl
	xOjB+W8fXjWcpqySVs92Mv+UFeoVtGYI8I1h4xMtDegyk5Og2IR7/Yi7zcFHduBMWbz3O9GqUlW
	E4+eJ3Y8Wy8Eftgpl4TVLN36LZLIVnONFU8AH9He5nzAumdnUe5qMvMJD8hLvc4jiwYoJpRJeoE
	7aYuv2zTX+Z+I1YAqpmdY57cdLWVO3Wx9XJmrHdiJaIq3Tn2pIgS18xKRASqynnoFcyEyah2UsN
	azIKKG6mKSfv/sDSFplNgg2FcPKdH6kRTJXkIcpvjrCY6LDmlYzIjylU8bIwzFKky7X0s+DIJgF
	WOZq/xEYiWMi7R9upJ0OvWysW+r98RYCRtXemSUyW6kOmMwUfkKkP0KEER4ud4I1/XxFVn3QHVz
	euV3HLooeg0WmxAcI4LVzfUe/imFNrrvJzTztdhm52cx/9GCILyBrj
X-Google-Smtp-Source: AGHT+IFxnLQXa2QzBiKv9F+tRewohN2WBdVZFUDy9IUDgCpSgm1P/pWA5GujKa6Og8jVcirUq0QX6Q==
X-Received: by 2002:a17:902:e786:b0:295:570d:116e with SMTP id d9443c01a7336-297c045433bmr2165605ad.41.1762448900878;
        Thu, 06 Nov 2025 09:08:20 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968235sm34095635ad.16.2025.11.06.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:08:20 -0800 (PST)
Date: Thu, 6 Nov 2025 17:08:15 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] vfio: selftests: Export vfio_pci_device functions
Message-ID: <aQzV_2DXwxNSQxVK@google.com>
References: <20251104003536.3601931-1-rananta@google.com>
 <20251104003536.3601931-3-rananta@google.com>
 <aQvu1c8Hb8i-JxXd@google.com>
 <CAJHc60ztBSSm4SUxxeJ-YULhdYuCHSprtns0xt_WVJPvgmtsBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60ztBSSm4SUxxeJ-YULhdYuCHSprtns0xt_WVJPvgmtsBA@mail.gmail.com>

On 2025-11-06 10:13 PM, Raghavendra Rao Ananta wrote:
> On Thu, Nov 6, 2025 at 6:12 AM David Matlack <dmatlack@google.com> wrote:
> >
> > On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> > > Refactor and make the functions called under device initialization
> > > public. A later patch adds a test that calls these functions to validate
> > > the UAPI of SR-IOV devices. Opportunistically, to test the success
> > > and failure cases of the UAPI, split the functions dealing with
> > > VFIO_GROUP_GET_DEVICE_FD and VFIO_DEVICE_BIND_IOMMUFD into a core
> > > function and another one that asserts the ioctl. The former will be
> > > used for testing the SR-IOV UAPI, hence only export these.
> >
> > I have a series that separates the IOMMU initialization and fields from
> > struct vfio_pci_device. I suspect that will make what you are trying to
> > do a lot easier.
> >
> > https://lore.kernel.org/kvm/20251008232531.1152035-1-dmatlack@google.com/
> >
> Nice! I'll take a look at it. By the way, how do we normally deal with
> dependencies among series? Do we simply mention it in the
> cover-letter?

What I usually do is:

 - Mention in the cover letter that this series applies on top of
   another series, and provide a lore link to the exact series version
   it's on top of.

 - Upload your series (with the dependent series) somewhere pulic like
   GitHub so that it's easy for reviewers to check out your code without
   having to apply multiple different series of patches. Include a link
   to this in your cover letter too.

See this series from Vipin for an example of doing this:

  https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/

> > Can you take a look at it and see if it would simplifying things for
> > you? Reviews would be very appreciated if so :)
> Absolutely! Sorry, I have it on my TODO list to review the changes,
> but didn't get a chance. I'll get to it soon. Thanks for the reminder
> :)

Thanks!

