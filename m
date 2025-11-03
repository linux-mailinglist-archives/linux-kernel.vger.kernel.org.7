Return-Path: <linux-kernel+bounces-883084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4CC2C710
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5141892FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C052836B1;
	Mon,  3 Nov 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj8qVCEU"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84780280332
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180863; cv=none; b=n2MeR0WRsj84aT0WcwXsRDeud2pvsG1gvNzKtcjPs0q6/S1pCM1n51hmUOgJpOlregA9SBL77STYgwkErm0OyyVQa7DgIJjy5rbzHJTONcs6WTklMPcWZFImMqHZxxwHKXzHxk+eh8G+Hs3VvNPEv6hTAobrhBO3YUqg43cjkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180863; c=relaxed/simple;
	bh=eWQeiP2zrgkz9osY0cSaodeycX0GFcYa/gGTxashC7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI7reyp9nSaaLOHfUme2x5UUqojw53ZR347q1GnwD0GdYhA6TKWMjoRZBrSMBkE3S9/AXGjIWqt6dvh9BI6TSJWBvffm1H9/cJ4ODZvcCxNuCYFpiGsrlnoi0mP1qYmMl+ffexMG+ijHGHINvXPdBjniUUlGjFgOU5Qh4Z+OvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj8qVCEU; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-429cf861327so1091018f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762180860; x=1762785660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhnWCeGj7VSUUXora3GrZpUnZAZG0ncmkOPbfdU7JnI=;
        b=Sj8qVCEUHq+xVD89nZZlQYDWpgbAnq60qhc9SiXS/hgQZD9jFCHMFEOltneCfqR/rD
         qfCQqSiIRSV2Iv3+tgLg5vE98Ek8rIYZL+wx/9SqwNuYKFyUG3KOCjotOOg77hF2Kx0x
         IW//bb0wOyxEGLQIlOT8Xp3IRjtKAMvjx6okpi0+cR2BX2rtl07aVEg7r+1OCTU13aVc
         jiIJrcRfY3/ZMKSd4YJZkew5U/lQNW2yFNP2FcTbZeyJV3bL01xSXoQtRjx25LkCukjQ
         ByOkz0Z4H+RyCpC9pxTyj0G/9lMz1d9tsj6elwuzKL6uzkL2yIIZHXzpsZkMhdpihBfn
         LrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180860; x=1762785660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhnWCeGj7VSUUXora3GrZpUnZAZG0ncmkOPbfdU7JnI=;
        b=Mah5iH+9qLOVCGevLIXTaNztfkkLij1dRHGpQE/jE9AySURxjHXotHQvadjanZSWR+
         1H/+jbWq1He2G7wAXNyfhkBG6jfgXUkhc0d5UlBp3P+wm1zXuLCZ0puj0iJjYMU3mKHd
         v6HRlz5FXFbcxYiG8tshAxboSnsPpGDrpxm01kqnFK8NRofwAGNXgsERE3iz5kKyFmyT
         yCd9c18yS/k/1bf30jqByogI904yJMDuBNWYFEi6+wJl2oZ8Vv0TWTVlCjx2SWS4y/Lk
         W/NRM5P5r3FAk9Az+LV5gxmv0pu9jM+T13RFjWcWq6hzER9EH3dRqQd5xZLmIUyIenv0
         1BEw==
X-Forwarded-Encrypted: i=1; AJvYcCUmmg8vYA+HJzmreJeN8lAyEbq6+O8h1imAeUh2GvIlNSO51uw22KM4EGIKFPdLHy3BWGvPPJTlwn3Eb6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OgL3ocOyM+kM4/zgkoyAdO9VR4Ffw8n5N7Be93xsHj5gxGeI
	B0GUiZH3Chw2wARebYdFsOyXlHfnupxf4vDthxGpekgWZbIy9GEnNM3W
X-Gm-Gg: ASbGnctOPi05wimhI83/6mTR1HZqhzjIBS90smYjVwGBH5Dqh9TnmigaorbxG+Xj+Ll
	rwF3iv5RMZeav+LNqEx1l750ELMgy/dpDRDkKd/CepvTS06NsBrT0otGiFDmp+9N0XD1VNJvozz
	KRAJ8CXwIVZnBYuTNs6t3cwuyvShYQmZnf9g6WIQvr7P4wBLg4Qhz7/tsOeJmoUpfYOYA5xU0zl
	MIB3ikbvgjuj1z53jxEe+SyVYwMYMxE6aaVq0iC0WFbfAL2JZhmitzl0jo+y4df1RqqNmlu1fmF
	UIzpy+1cWSQgZ6pACkNAR964fflRSIP6kD5QH0IT50lyAq3r910NiUsKJXBeRxU9frBAd3cvZKJ
	rz0BStH2kHISCY0XlnewI+wnBxVY6A5KGjsHvuscKQRTKvy1JTujzg9SNYkSSEdSUxcBN8FRBMK
	e7ry4nXvmGhkVGF0rkxKZkjZcoKaAC7pwf+XinwfL0disrfwoiigXt
X-Google-Smtp-Source: AGHT+IH/4xizOy+DuRDg4T/+1/r/B0yFQ05VGmFHc5NJhCGA96e19qMqEBWxN2MdSABc4RNojADaRw==
X-Received: by 2002:a05:6000:178d:b0:429:b6e2:1ecf with SMTP id ffacd0b85a97d-429bd682973mr11766202f8f.22.1762180859783;
        Mon, 03 Nov 2025 06:40:59 -0800 (PST)
Received: from workstation (ip7-114-231-195.pool-bba.aruba.it. [195.231.114.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48ee52sm162113385e9.2.2025.11.03.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:40:59 -0800 (PST)
Date: Mon, 3 Nov 2025 15:40:58 +0100
From: Francesco Pompo' <francescopompo2@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub/x86: Add fallback for SMBIOS record lookup
Message-ID: <pt44dx2hnzvqrqsboa53p67qw4dhkslo3xme4uu5r333ygei2m@czvvf5btllhq>
References: <20251103123335.1089483-1-francescopompo2@gmail.com>
 <CAMj1kXHO8Mxk+zPEwx2+VP1FF_LoDu58tbDOm+-Y8m07d3nitw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHO8Mxk+zPEwx2+VP1FF_LoDu58tbDOm+-Y8m07d3nitw@mail.gmail.com>

On Mon, Nov 03, 2025 at 02:47:22PM +0100, Ard Biesheuvel wrote:
> On Mon, 3 Nov 2025 at 13:33, Francesco Pompo <francescopompo2@gmail.com> wrote:
> >
> > Some Apple EFI firmwares do not provide the SMBIOS Protocol,
> > causing efi_get_smbios_record() to fail. This prevents retrieval of
> > system information such as product name, which is needed by
> > apple_set_os() to enable the integrated GPU on dual-graphics Intel
> > MacBooks.
> >
> > Add a fallback that directly parses the SMBIOS entry point table when
> > the protocol is unavailable.
> >
> > Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c | 107 +++++++++++++++++++++++-
> >  1 file changed, 106 insertions(+), 1 deletion(-)
> >
> 
> OK, I've pushed this to the efi/next branch now. I did apply some
> cosmetic tweaks, though, so please double check that I did not break
> anything.

Seems fine to me. I compiled it and it's working correctly on my
hardware.

Thank you! :)

