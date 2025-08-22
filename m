Return-Path: <linux-kernel+bounces-781530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD98B313AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A686D1718C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13B2F1FE5;
	Fri, 22 Aug 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNFc+wEr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A12EE608
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855075; cv=none; b=pStKoU/ypmtrJpnGwwz77JYe5dFHTxLZhleLfbgH9mI49hf7l2gFBk6v4sdQxvBut/flMMG00qrYHE96nKRWLrMjo8i0MN70jEQIVkWKr6P5yOhIlfJo38xLYz12yRPboJaO/Ue97sz/0V9aUJ0jtnn321lPjrNiSHIfN2PGwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855075; c=relaxed/simple;
	bh=0208ISyKu10cUE7W9YgFPUpUsfgz36ubVskvnrbBoYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR3vYJZKylREK/qPRnvKXO1tuwpNzoNkHFhZr5NlNIdMxxDArZ4yoDQej9Lre4E5U6y0dLRzwYlyecI37Ri5RpmTQR6hlQnjdsBQA8otm/rUTaUDBf+LDJDk+a5h1bkDW4cPIAzRZCW35tWgDtdmmBF3GWY4V98xW33+92bwjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNFc+wEr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so1425654f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855065; x=1756459865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg8+uWPzi2Mjr9MpPBcmahRsPpi30DI4NUSUxz6VBQs=;
        b=rNFc+wEr/fsbRkz67OsdEajGw6jjOXw3VflRwkTLgv6k/n5SIIjfOwyTaphWDuM+5a
         lbdtpXzIZflwbqnFv5bj5dx2lsIukjcdAaGIjJsC9k0ItbHhD7qS1zgif+0ZOSZoG98d
         wTncx7mtA2GuuvmG3roiJW0/quoI0P66YeuS97CPAPkzYPyY/Mo/3tywcztd/dSDEUaK
         z5AbbP3gjmk2y3AjLLc+jJx+v8bYJOllxbgHGmZYAFZ/CJJUWpVXemUaktux5AVeqt1D
         HySCfOPBDVyj4hXf1F9ogBjKTsKZyOKzQAREk5ImrFS53hFpli/4MNLRyfZfdIQUbwGk
         kO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855065; x=1756459865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg8+uWPzi2Mjr9MpPBcmahRsPpi30DI4NUSUxz6VBQs=;
        b=nyXuA2zaEib7WK9+D7+6N07bWpvJ3AnSzvf3OOgJrAlLI+uEQJBRgCvoFKzpFKF9LJ
         ce/U1tdeED3UUwQDJSQR3wUjRRyZHS9e2gqds03AHBX/P1ppr2CqN0fXOOcRgxO+5ou1
         imKO5HxWXkR2CSYGqSd1B28W0WE4BpzAi8TZOzEXe8QHlARixNlOMoG+h1M/CB2icZJ5
         btOOZtcZAoMHIuXQsTcRH3CPF9YTNQ3C6izNSTdz9t++kYdEW2kAWwvdt8bHqmEfDYab
         +x7HyPCDhTIsFveDJ8l+nV5OQAnbWFYKPa22jNM+KQRaLn6yhY4jx+rMLgyLyL7FhBgY
         Bfkw==
X-Forwarded-Encrypted: i=1; AJvYcCVZB/naUC0CTuoONJKx0f/87nVKf/wgJepaIQuNcMZ2njN1Ic8C1gvlLFyecceEIzfAD8Kgg3Mg/qWdUbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyd4KksU3MoNVkx4r1YR4bzjmxHca5vzX5CNqxHCx0FRt19XA
	n/VKo558L64ue4s0IKSTNKfFxvvxFfxIcIAsaN137spb1usJhGz21Q36X60ZKtcpcoA=
X-Gm-Gg: ASbGncucwx0w7D31G53s8631ZuvkV8SJ+e9qO2KcEsMD91jw5YQU0xcKwDS+pi1/uvf
	pZTKEg9O7qgnxQLM0OAbi9Tn4e9MqaukoJd/4y73H1yI7WbK5aniWOBKrWWR8WXAho/H3Tj8D5h
	ZPtVEyfut+DZjI41Gctp2XGVcBRj7PaIWSt1KfiPWNlosORYoOLN1ZonU9A/PPutFeNctPMFNuP
	yEmAn18W8qib67yCG1gRLkG07pTPNwJviI2B4C/Hn+KERX1Mz8elLjJ45F8f18ihj6WtFhQH9MZ
	eIrrhDnwhmVT+j3TsgOjGDQ++Ymu3uzOu7laZ5iOJBifojdLixyCK0wF7hZaZYVyEd+HNz45Xml
	YRpZz8xI6mGP7PP6y0ei1aSi3apg=
X-Google-Smtp-Source: AGHT+IETQifX60xNpED57w605gzuRtVMT1h5myncjmf4CiJxMRcoa/HpI34Al4mQ3T46Kr36eWGX/Q==
X-Received: by 2002:a05:6000:18ad:b0:3b8:fb31:a42d with SMTP id ffacd0b85a97d-3c5dc6385e1mr1345579f8f.34.1755855065462;
        Fri, 22 Aug 2025 02:31:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c598e067b1sm3192314f8f.59.2025.08.22.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:31:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:31:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Joseph Qi <jiangqi903@gmail.com>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <aKg41GMffk9t1p56@stanley.mountain>
References: <20250819122844.483737955@linuxfoundation.org>
 <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 08:06:01PM +0530, Naresh Kamboju wrote:
> On Tue, 19 Aug 2025 at 18:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.16.2 release.
> > There are 564 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> As I have reported last week on 6.16.1-rc1 as regression is
> still noticed on 6.16.2-rc2.
> 
> WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334 start_this_handle
> 
> Full test log:
> ------------[ cut here ]------------
> [  153.965287] WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334
> start_this_handle+0x4df/0x500

The problem is that we only applied the last two patches in:
https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/

Naresh is on vacation until Monday, but he tested the patchset on
linux-next and it fixed the issues.  So we need to cherry-pick the
following commits.

1bfe6354e097 ext4: process folios writeback in bytes
f922c8c2461b ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
ded2d726a304 ext4: fix stale data if it bail out of the extents mapping loop
2bddafea3d0d ext4: refactor the block allocation process of ext4_page_mkwrite()
e2c4c49dee64 ext4: restart handle if credits are insufficient during allocating blocks
6b132759b0fe ext4: enhance tracepoints during the folios writeback
95ad8ee45cdb ext4: correct the reserved credits for extent conversion
bbbf150f3f85 ext4: reserved credits for one extent during the folio writeback
57661f28756c ext4: replace ext4_writepage_trans_blocks()

They all apply cleanly to 6.16.3-rc1.

regards,
dan carpenter



