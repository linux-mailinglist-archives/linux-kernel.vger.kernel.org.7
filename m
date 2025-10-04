Return-Path: <linux-kernel+bounces-841878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1347BB873D
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 02:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9318C3C642D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC1EEAB;
	Sat,  4 Oct 2025 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="IjqWWm+d"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271ADF49
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759537916; cv=none; b=IzrYS/40tO9DOwaRuE6iJaN/jioNw18Ls8vlT+UT2VdLdWFt1eHtgSzANTrJMGbbrxNm9oA5YOopHEUGrCCeFDRgilFjIvNAJdh+SbRnUX+cdM8SkWIqJG6nwB1K1yEhgkpuYgdxFJDAob8YHFNQsIXDTOt+pIwIZM+2SSdWVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759537916; c=relaxed/simple;
	bh=fLCm2GBp5HRL6zxysxEr4pDI57fJyTlWsY3Wgv//eJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHjBobD659vhbBDbNUAShlJPAK1qeCoKILEH3k8cpcVhYC3KnTuNPyaM/TfYS0YShrtxkWwmlsHoiR6XHJtQR/4nljJuZxBkFB/w3cJ7aSU2LUYbJB0n25IpXUiT6fZGpMeQceqHZ8iLNBIDsaIwqselahPpWoqnzardixDNBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=IjqWWm+d; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-79599d65f75so23772166d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1759537914; x=1760142714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Hve5D5bXNWxh8nAKCs1hmgTLg+XAURZWqKyON8mhFU=;
        b=IjqWWm+du61Z4PKEO8hR6/SZU9PrXp/B6AxwwqxZ5VfwyBz4y5XkbEhs97/wDFowE8
         KYr2j8Uy1vwfiDlCIWzUt0CZzt8WHetp1jWmI5oyZZpA1aEnNrXrA6/7ymbO1TOlkM+h
         MVXvZ2M8DzshSwzfbyG77gRsRMMG9/S00vtrL6WafY7FMVMNpyn0WeA6be04CO/k8Qzo
         ZN1J94sUP3l5pqk7g0n5+tD8ArNgsc11nERZ6gB782xozRecisf1XIKOjsFWnYN8pS6S
         SvbagTK6GPd0qJQd/AOkd+YYUqGC5Pwjth8JOLpHe4x8SlQ31KjRVU5EPp6vOJcmzxJw
         ngEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759537914; x=1760142714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hve5D5bXNWxh8nAKCs1hmgTLg+XAURZWqKyON8mhFU=;
        b=DlT/0cua6pA60yWfQ78Sa9qcPJyu8mORpLpTvUa2IqYYw4vH55/WA2PxxnDWpzLEIa
         ynEkS9tQxzlCxOeXiit3MFmN8yTNWKFKCffvfSzE3NLdgeVmZWM6FVRcrgU8FfvtPsV3
         /YbgoJTvY+wm2x2D5BMK7SAieABFIA8TSOGcJeWDgMUUQ9DgPH/ncFQyGfWcD4ksFgWR
         QSnljUqZ2Tp/GdnbKhUce1XEA/7tV9W5mvyfhdYwVaFyzbbc9cFSqjK5rweqCWsmNxUq
         V1/R6xRdw00cp4T/E7zzlgMeERHJAoBBwoglkHakg7o6FhUnkLhZfMJ0KTqNZalY3SAs
         7PPw==
X-Forwarded-Encrypted: i=1; AJvYcCVazqDrlLA5EaffY9Ex4hTcU7vJ2bC/3o6WqAYCx1n9cTgk2z+NtdqI9qbDqsG6t5rYtskw8GZ5j1ItqwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtV+eXVkk8UJG9IsD2sytK7gQEJk/kK623BXcG6bylS2PFzd5+
	Rs7/zpjKyXsV7NSZuzB/QIfN1xlIxeLXK4rI1lLdxtvSUAGQjfvNPQhR1MVLzrQ9amA=
X-Gm-Gg: ASbGncsJFOeVcxmm2yaJFOe3ScSZEro5SX0y7p4YCGmEbFjPbC/m1d51RMdF0JudiQH
	DcaWeQka6W/U75aAT0fwLef5DLoinq9I5xYke2+G/0viw15c6hPqy5nVUNPr+H9HsBmss0pvQfx
	jM8FlhtMkrgLsqDxiwTCRqGxmJIXa0aET2EdXAEnjX7Ynx+U3derUZk1+qdfzA36x4wykyoeRad
	6FUau6iId+evpzwrkUq6zUbfalTXyMox1JSvoljKoCMHdHzsNBl2WZOj1tJuH2MbVOV5up7q45j
	qfZZM/sZYWQcP60ZY9X3SNmdDDWoolygpPvEIrLGdbSyAfu0C0ja7wY4EHHCA7yNP/FKYLIWzOL
	pJyXinyCkuFRMYmo/N5UinGa52GAD6LpSzRqEH1DU3OmeOvnLt45bgcFpJTJNowMz6nA/QBrskk
	yBcLiC4TgPpjc=
X-Google-Smtp-Source: AGHT+IEsRjI8gCuEno0aPQByvaMn1RbhQu1LEY6DoWqtshtx58svm3JOMSvxRR1frC8lP1Smp+Sc7Q==
X-Received: by 2002:ad4:5ae3:0:b0:820:a83:eaed with SMTP id 6a1803df08f44-879dc79b792mr57956596d6.24.1759537913717;
        Fri, 03 Oct 2025 17:31:53 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-878bb53e3f8sm51778496d6.26.2025.10.03.17.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 17:31:52 -0700 (PDT)
Date: Fri, 3 Oct 2025 20:31:51 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: AST2500 BMC video output disabled by reboot (regression)
Message-ID: <qjyncqymjja57h2wxxv3ebuqpip5qu7yjalccons5xmtzfw5h5@m3u4rvbqzcxt>
References: <wpwd7rit6t4mnu6kdqbtsnk5bhftgslio6e2jgkz6kgw6cuvvr@xbfswsczfqsi>
 <CAD=FV=Xp7zOQ2iEVf896P074RW911F-e2Qa36deD0e8fWksFBA@mail.gmail.com>
 <u7ek3ccya4c3c4rteliskjjfczpmrt4vmqo5c6kjdotxdgitn7@ko24dpb35pq4>
 <ef6558a9-c44a-4c66-967c-187f260f73e1@suse.de>
 <xeipdyk2i2lpkg4rrvz4cl2l3ch62sl4zoa73qvlms3ek3zkci@y7xqbgjulaet>
 <cox6kpackepnunrlhpsssvgdmjd24477cc7mide52xptmmoxyr@ijjotb3xju3v>
 <f1de37ae-2ae4-4513-98fd-18617016704a@suse.de>
 <5949fd73-3ca4-4bd9-8092-2d9923dcbfd3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5949fd73-3ca4-4bd9-8092-2d9923dcbfd3@suse.de>

On Wed, Oct 01, 2025 at 09:26:28AM +0200, Thomas Zimmermann wrote:
> Am 18.09.25 um 13:17 schrieb Thomas Zimmermann:
> > Am 18.09.25 um 04:04 schrieb Nick Bowler:
> > > On Wed, Sep 17, 2025 at 11:14:45AM -0400, Nick Bowler wrote:
> > > > On Fri, Aug 29, 2025 at 03:07:14PM +0200, Thomas Zimmermann wrote:
> > > > > The ast driver doesn't do much during shutdown. Could you
> > > > > please out-comment the lines at either [2] xor [3] and report
> > > > > on either effect?
[...]
> > > > > [2] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_mode.c#L835
> > > > > [3] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_mode.c#L839
[...]
> > >    - Deleting [3] (only) appears sufficient to make things work again,
> > >      that is, deleting the following line in ast_mode.c:
> > > 
> > >        ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, vgacrb6);
> > 
> > Please test if the attached patch fixes the problem for you.
> 
> Have you been able to test the patch?

In the normal scenario where everything is working and I reboot, then
the display remains on for the firmware (this would seem to be an
improvement).

But it introduces a new problem: the screen no longer turns back on if
I boot the patched kernel from the "display off" state.  The unpatched
6.17 kernel would at least turn the display back on from this.
Furthermore, rebooting from this state keeps the display off.

The earlier change [3] above has no such problems.

Thanks,
  Nick

