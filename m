Return-Path: <linux-kernel+bounces-831727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FCB9D69C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AA1BC1C79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A972E7BBA;
	Thu, 25 Sep 2025 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIrchR3u"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A2219E8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758776277; cv=none; b=B4zz9rad/ZHH3eErNWSkA25KgxIArSf+fXuH97B2uoLrdEf8kfpaDZX8SloBVRHf/uY5RYIi+jtJcGPiePujyD0VTJhF1iAvBQvF6d3ShR+OAQzd5m9v+Ujydw3iwzAAsdKYRerLm5U08RVq7jz6QeFPxpTBzyvQerkRvbWpDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758776277; c=relaxed/simple;
	bh=kPzxEfe/YqVDgMWOwGmf5DpkjVmJd2Ha6+d5aCqeKDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWe+kP6OwmeYInrOWRotzZT9b7cexji8XaMpUHSghJgAmsBgXgLyGZ6rHTBH+Xs45p/GXgorqpruk8upzG/MHN9i3PWKtFpeU2BUWPWNzvIXL70TDTzWtw2VxNvVyaMxi4kjV2z6rYWZ2ijoOxA41fyl7Rn4K1pV4dPgEs7dDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIrchR3u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78104c8cbb4so199679b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758776275; x=1759381075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWG5UfuLfU/6okMWpcwd8oWIgSQHkPLDSZpFhqy7ksQ=;
        b=VIrchR3uzufvtqAAfTEWhg/OOPHwM7oJgoRlVzPbnWmMU2xMloLrqG2s8k/P4wSPeB
         ba7TPxwrM8b75XVEmtmqNFXjMt8JjCOSSn5F7OkBwG78SLUhBeRtDbg+SCoUdzVl5tKn
         oGYSNiJbMnKJkUdPmwEZOvybrPafbDDZ5HmgybJsEEgmMCsePIDPAjMcmK6rkh1uFMc/
         Zoc9VOjUh+aOU2SThGFUS/PvrEJ6zXsMjl3tdq5sM9hzL2ZKfxqhMB10wnGjCLJ3rBF6
         hbkwPhzRNG+a5umt8iD6z8dkJkY9BLslO/UCUARK/N3drOvXzRBpEMznrH9FLL/oSEnd
         Ww2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758776275; x=1759381075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWG5UfuLfU/6okMWpcwd8oWIgSQHkPLDSZpFhqy7ksQ=;
        b=uZG7FdRTLclgGixJ4dvWrmzYZgmZsJ4t4TCrWbOEGOToyP/VQh+mjy8kLlSMz0qSvh
         c729QAac53NdIL/bjYliigO1jjY8jPmdLYkvBFUprYvMpHsCa3SbnlPYFBkzVkWH5Kw5
         I36GZe/8dsyIUeMkAfRWJFEns80NmBYreNke36twEPeP2hZUU7WhBDuHpxZyKtPYWFQY
         QcTlxgaG54TTbWxH5WJkniw0naVouft8E+xcYuAElDPDKTTHj9r/oYZwcZ+QFg5Z8ZTh
         Nbv3ATgmp5JMXltN8hsRkbp+4HzgAootfHhUacGg9Lc3hb2DEWMx7t0ZDj0IuWJD8hFl
         5nqA==
X-Forwarded-Encrypted: i=1; AJvYcCUxFFfiucW8HFaaPxxhgLcUsPacP5GsWRo0ripQMjoNBIuy1OqZtCL9Q7FToPbvgZlvIODmmDCv2XIMtdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuSMk/HGLkrowRv1mCguU3YbI+ptrzn7uP5lBbkAOyGcwJKfw
	LfDw1BeI/3wwuj+VU/zw93XtVgX7TYJkvAzxONXDhk++Mu7Rgm22OQnT
X-Gm-Gg: ASbGncuPVfVFgdAtNYzUei+XfjYn1bMFSkzqgiy2JBeNBqoWI88m7+zbkXtSv/uI9H0
	alaM7M7eeZf++oxwFvOkpwctOszwxF9hjZyeb9QNpmRqOFiTymETEPG4aZXw28Nc3WX6LeYQKJk
	MYEAEfCKxw0Fb7sFNtEd18xvOsGrtstHCPb4u98p7OHEJ5hleFRTi9N4E+4+Fb5KDZkSCnssg+h
	6U5Gm50HKz2R7AqLN85Bb8ZM2whwjgm0IpLFQ4IZsSHDQJmu5SbBeUfpAdJf+CegZmnzVzZDJ7W
	jdIjZ6WCqDfBcoJToZ9UQVe8gEnAJANYUyfuprSCTcucZfSmU6hKr7ere5hyYWgi+mWUTaYkl9K
	dadgo+W1qZguneQ8kr/VGt9+PncBjugjr/RmwpubNi1CQKJGztg==
X-Google-Smtp-Source: AGHT+IHE0hCkhuBmmUoBQffjMXTlW6TG7kVeaCmRhK+UDQsUnhS7aMf4l0Fb5LPcRfVZ10wDV1Wdkg==
X-Received: by 2002:a05:6a00:2341:b0:77f:67e8:fd with SMTP id d2e1a72fcca58-780fcdfd789mr2323162b3a.3.1758776274966;
        Wed, 24 Sep 2025 21:57:54 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c07696sm708827b3a.74.2025.09.24.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 21:57:54 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:57:51 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"visitorckw@gmail.com" <visitorckw@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with
 helper functions
Message-ID: <aNTLz+SO4AAUeo96@visitorckw-System-Product-Name>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
 <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
 <51518b935e7649e3b5413e3a119d549b@realtek.com>
 <aNS+Hk5QTzGq+AUO@visitorckw-System-Product-Name>
 <0990f8ee74574a30a585f2e0e3831837@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0990f8ee74574a30a585f2e0e3831837@realtek.com>

On Thu, Sep 25, 2025 at 04:28:40AM +0000, Ping-Ke Shih wrote:
> Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > On Wed, Sep 24, 2025 at 12:43:56AM +0000, Ping-Ke Shih wrote:
> > > Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > > > On Mon, Sep 22, 2025 at 05:50:50AM +0000, Ping-Ke Shih wrote:
> > > > > Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > > > > > Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
> > > > > > and 'str_read_write()'.
> > > > > >
> > > > > > The change improves readability and enables potential string deduplication
> > > > > > by the linker, which may slightly reduce binary size.
> > > > >
> > > > > Have you measured the change of binary size? Maybe you can share the result
> > > > > here.
> > > > >
> > > >
> > > > I tested the patch and did not observe any measurable change in the binary size.
> > > > The commit message was refers to the description in string-choice.h:
> > > >
> > > > "3) Deduping by the linker, which results in a smaller binary file."
> > >
> > > It might rely on LTO (link-time optimization).
> > >
> > 
> > I re-tested with 'LTO_CLANG=y', and the code size remains unchanged before
> > and after the patch. I will remove the statement
> > ("may slightly reduce binary size") from the v2 commit message.
> > 
> 
> What is the .o you checked? Have you also checked size of .ko?
> I guess (sorry I'm not familiar with LTO) that LTO only takes effect
> at least doing partial link. 
> 
> As the changes of your patch, maybe you can check rtw89_8851b.o or
> rtw89_8851b.ko.
>

I built all related files directly into the kernel, so my measurement was
on the size of the entire vmlinux, not individual .o files or modules.


