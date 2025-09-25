Return-Path: <linux-kernel+bounces-831699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BFB9D591
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2389B1BC3463
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C212E6CDB;
	Thu, 25 Sep 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN0YdjDj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5432AE8D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772772; cv=none; b=G/k2cl9vfGaS53h3G4GQMlNgWdL2gnwhP/sZRgMvlDlTBJo/cFHN+13sVBqj6rohOYsuELjssLu52DX/ctlqd7Hmu1Ms3Wj+AYe0PzKjiw3OrZd2GeJe+HEeDny9dSrxhOJOLhZlQAz4Au1CsuXN2PRlHjYGhaKSvFEU4zk4FgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772772; c=relaxed/simple;
	bh=HPv4vSzoBu8JThytGjdGbKxgJmi4vPkfPjeTQDWF6j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoG+/eZo5QpeEfQjFDI55rlfdYw7G2JQ4J7/DsMJ/QCo09erLoZpivVdPK1paMvxLlZvEoUu0jG2RLCKgUNUqNTV3C3eI7en9wIatqMQMXA2CkD67KH1uNQVhuiOKrNaurBul6rg0nLIqOq19761TbrKTWQARchSHqAHpnWWuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN0YdjDj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so498761a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758772770; x=1759377570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qo3Gw2aldDy8S+SFdy/VgsjaY7xrxXzEhcJKjVaEe5g=;
        b=FN0YdjDjNqJsVxyQ1SZFtaLffq+wDuxJGG0Uc02H0PPWmN6uxQIqIoDg8vpm4FX3yk
         VYT0IoMnZH3tX9a+IbhI22tnHzYlCluN8tv0Cvm0CiHjczLvb4/iqYnckz7Ar7uu3PxK
         XTUClRgXew8C2nhKKD047gPZbqvTdO8NOPyOMco3tAD4ymSAiSmrSqrc8xg/9zFKkBSy
         XSqPrFeW611uYlckDQS6LXEC3CAroodh0RKQrOfOt1bm2AxoDmNs948s9iKdBV2ITXId
         d8gURBh/GpH+IQqKi1lhs64ybe44I1jsQj87uUo3nqfU5YG5VxmkcLAzhQoIBPWgsAuG
         n1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758772770; x=1759377570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo3Gw2aldDy8S+SFdy/VgsjaY7xrxXzEhcJKjVaEe5g=;
        b=Jo3HGZvy1SSO1st5zpREno4azMjjai6ONgYdCTiTTSN9s/CLGtp/CrvzXPsMHuZjI/
         hTo1aJ8BCNQvMkVu58EQmxuydxxVW92Z6ZDjoVkQF3fiwbMT+QdVnRQgXOZjLST3OPu4
         9qGg/ok23NHRQbEu43rryNo1KGz/ODsgzCGzx3wocnAS4PY1/HU+mcawPr0kbfw9vqWJ
         +yCiFx3L5eJHiftWlASNw75bKrh4dri8RLEnCADy3CTGNRddawWjX18i9M+lAgIXutbZ
         qqWOZhvVDjSc1ungUVjUwK2jdZq+llrW2+NkuI2jEa23Ol/BTXUElVxxXHZZGLnP5imH
         ZXUg==
X-Forwarded-Encrypted: i=1; AJvYcCVZZ58e/YIAwCOz6F2Odz2SBkCSRwCy/MsE8aSxqe1HLgwxqYXhLyj4vL6/DPpIWFF2+eGc5kdU773ytCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qiynH3XPrY+hutPSqh621n/nuf7U4/tFc45dIOMgTwMr9new
	ZcY+JGTeyh20k9kguoihw1ZJiuFsqtrvPrDCS20jMBRtyfTvP3TWTxGA
X-Gm-Gg: ASbGncsdOCqVNwz//ecQzWyRXxObdkKJmDLnXVJwSzhm4+k+5caCloqH2qP41mvJ42K
	6dMnoO43OF7rBlOCsAyUv1prZ1oiABDIcVnx5GSjaaSXwDi5fywYKpz2xtYHsfxKMD3S+obBMg+
	NBWzEoNkHh5845gTAFPtPw8aOxivFzYrYgLPb8IWlcmHaI3rnfbbCYAOH5iPk6wXYbs46nMhU1B
	vNVxFGizszGTP76jiA7qkuiUcjVNFp4ef80GKP2vf/3GbmFdANiRFpfhyYXu1uOmiT2OBvjmFZ7
	bazq4KkW3v9gE0KfupG+8X+Ji+OZk41xkbfFPbrz4ZbjbdPZuXHezRnxGMlYYewKGzlx/VTEPnB
	+ohertMtuhmSefVXYUNznBRpcen1jew3twN3P0QeMNoRRi16Vyw==
X-Google-Smtp-Source: AGHT+IGA8RsHIjBG0k1aXxxaNhSe1BGhPJx2qvJCYAhDLSPQSQC6J583+cbdCvov1XBpJdYbBe81Tw==
X-Received: by 2002:a17:90b:3849:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-3342a257810mr2866527a91.15.1758772770187;
        Wed, 24 Sep 2025 20:59:30 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b2fdsm695859a91.10.2025.09.24.20.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:59:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:59:26 +0800
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
Message-ID: <aNS+Hk5QTzGq+AUO@visitorckw-System-Product-Name>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
 <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
 <51518b935e7649e3b5413e3a119d549b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51518b935e7649e3b5413e3a119d549b@realtek.com>

On Wed, Sep 24, 2025 at 12:43:56AM +0000, Ping-Ke Shih wrote:
> Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > On Mon, Sep 22, 2025 at 05:50:50AM +0000, Ping-Ke Shih wrote:
> > > Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > > > Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
> > > > and 'str_read_write()'.
> > > >
> > > > The change improves readability and enables potential string deduplication
> > > > by the linker, which may slightly reduce binary size.
> > >
> > > Have you measured the change of binary size? Maybe you can share the result
> > > here.
> > >
> > 
> > I tested the patch and did not observe any measurable change in the binary size.
> > The commit message was refers to the description in string-choice.h:
> > 
> > "3) Deduping by the linker, which results in a smaller binary file."
> 
> It might rely on LTO (link-time optimization). 
>

I re-tested with 'LTO_CLANG=y', and the code size remains unchanged before
and after the patch. I will remove the statement
("may slightly reduce binary size") from the v2 commit message.



