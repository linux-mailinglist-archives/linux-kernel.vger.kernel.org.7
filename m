Return-Path: <linux-kernel+bounces-847578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584CABCB3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D217D19E2745
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89DB28B4F0;
	Thu,  9 Oct 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="ELILpa6V"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42D286D4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054168; cv=none; b=f1eTITi9ERJyiNlxsYk3921lbdpErhpy9Xz3Ui6Z9xDzkvXZg4ZJobryq6oIMzh0KJ/aBU3K8fdaEPopQpaULGTuXwsGWmxhCtIeOx3Jl+2XkgFwaswYf718U3oJVcJJLsCgXUWPMU93SeXU7Y41FvQoqRz/u25iAo5/dXe+Zg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054168; c=relaxed/simple;
	bh=RDNvFhXMLtxlMPAmEwgJ5B25rN9h8pzeMm/QC1MG2K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUOKHB1gd5OdAl3bqxrvBxYzHS61eizQLg/7jHRndGbhOxFbtsdMqCBihO7D4fo5tv7t0df4TuKnHfKrzPkZB0TYfI11zQYE+wZaAj4eyzl+JNcOMg5AeYZeHqmqTMkwBiChbb5XmM9l+pPs7dq1f2WzUt01uM9rcoClFMRpcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=ELILpa6V; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87499a3cd37so10462356d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1760054165; x=1760658965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTFpCR/KI1F13hy7CFFNjYUFOgplKs84/KujihK2OhQ=;
        b=ELILpa6VR9Olpdiv3EKXAmynU6o/R16QKAOxGOgyao6DalcOQmEfv/B4kwrcSdXMA9
         YX0giBHDi2iiQBzmm8TVfM/g812LGbCuxYFqlDNYXouYWMxGo/LHEuLj21X6NiIxUKam
         zzDAd8rz6uj1ybXPb3L4Qs8T7I49won7cvevXm7vU0Qe3US5NrVFDshoauNNtCUXqeDr
         0/5vVbnsufptPDKcwOLO/7OgXCQyyhmmTGKSdZawTnU9zgsB6w0Y6yG3jkRfWtyq2WJY
         UhHKizE6VzZ2YZyJ0rBVsCzukp6okfqN1vo9jenqMSDXzth3+Xn0JVmCMY3jSGVNI/wc
         uz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760054165; x=1760658965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTFpCR/KI1F13hy7CFFNjYUFOgplKs84/KujihK2OhQ=;
        b=d2EjXZzB0g9aRK3eqyTbom7a/CoDU0amHzLZU+bN+o5XKJeUj47a4/8easAjzatcSn
         QFzRvjKJUMajUB/zo24Ijk00rjHXGDmgk8paBAMx12Ea0IdPTB15mr7lDWW5U3dLxm74
         8eNoEr2uIooDGiB3iOVHLUl0lX4PpjTHSohxks6dog1YM6WERfdJaN6EnMBDaNlT6geT
         MqHxz5JccLQxQkkfhMGZqQ7Ez5DOFV/Q4iTmVDVQ2e4SyeevvoWUz97W6EuTIpN3mTQJ
         lsj4xLJaWrP4SSzpA5fR5AUjmW9XxHYgCU19GUHl+eBBnZBX43TAIkW23uVd/UMQB47y
         n+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR1m6rNmG3as/bwtdC/fiaXz7fHHojoS5Ibmb+3Se9Xmp/9mGRJz5DYr2BtqR57FLv6vzs9fFSkhftHO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCkwKluDt/k6hykZT+igGKhOp7Vm+M7rm3l++oR36jPz7ZxBA
	lmbfjPyMHQsjbMV6IR6G/ctVOJ1aIpYyESnxsgeXYCEgn7Sz8IAaf55pk4rHWUG3oMA=
X-Gm-Gg: ASbGncszvMpYQ68eanq04EUXS5F+ADltJ7Va0e61hKfSjtCsm2yhnXtB9WAQ5vkpIpw
	UUyKPyozV/HLgZcxvLyDqGnjJA3y7pE4EjjPzlTLBUSMYjNKoCLz95Ac6LdZPVeVqgGf+7QQOQ/
	xGQWrBXRPzcMPzgZJUxxFR7DCHgeT3oU9x+Y3XpOGZQdF/defDU0y3wtdTBTRNf2cz69YG0Utle
	YYO/r7g6iN4uLLyBB5rPT3pIXd4TKebslkJL4YBgSV8b9y+6KcjMTnVFHDWP6yqAFLXW4+4/e+g
	2Y+2BMBynBf/n1WQXCSE3/QsXGLuPRj5VjuiLN5U1s3IacfQPwKMkTzGFtJHjV9L/EUvWAk6zPU
	FssaaG7TXRZp7nAKz0yablc3/iUA1oE0lcH/TYinE87yVXxtsVF+rB0zPyS/hPZJ1UvtcDn00rS
	5u
X-Google-Smtp-Source: AGHT+IH6Ltx5J9UQ1h01zMMBVoitoSRQwM7F5bZvt3pvVezHa8vMsYH7ROgPUCpj3UYMdCE/cK73yw==
X-Received: by 2002:a05:6214:f23:b0:80f:abfe:819b with SMTP id 6a1803df08f44-87b2102679amr124997606d6.26.1760054165314;
        Thu, 09 Oct 2025 16:56:05 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e706b97ba7sm7574841cf.4.2025.10.09.16.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:56:04 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:56:03 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: AST2500 BMC video output disabled by reboot (regression)
Message-ID: <hyyyuqsyf7c3ed2ku57fp4sjwkpcacygtrwnkgupn2xdq7ez4u@sg6xeg4shkdd>
References: <wpwd7rit6t4mnu6kdqbtsnk5bhftgslio6e2jgkz6kgw6cuvvr@xbfswsczfqsi>
 <CAD=FV=Xp7zOQ2iEVf896P074RW911F-e2Qa36deD0e8fWksFBA@mail.gmail.com>
 <u7ek3ccya4c3c4rteliskjjfczpmrt4vmqo5c6kjdotxdgitn7@ko24dpb35pq4>
 <ef6558a9-c44a-4c66-967c-187f260f73e1@suse.de>
 <xeipdyk2i2lpkg4rrvz4cl2l3ch62sl4zoa73qvlms3ek3zkci@y7xqbgjulaet>
 <cox6kpackepnunrlhpsssvgdmjd24477cc7mide52xptmmoxyr@ijjotb3xju3v>
 <f1de37ae-2ae4-4513-98fd-18617016704a@suse.de>
 <5949fd73-3ca4-4bd9-8092-2d9923dcbfd3@suse.de>
 <qjyncqymjja57h2wxxv3ebuqpip5qu7yjalccons5xmtzfw5h5@m3u4rvbqzcxt>
 <e0104f10-9230-41e5-acd1-4ca95c38220e@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0104f10-9230-41e5-acd1-4ca95c38220e@suse.de>

Hello,

On Tue, Oct 07, 2025 at 10:51:29AM +0200, Thomas Zimmermann wrote:
> Am 04.10.25 um 02:31 schrieb Nick Bowler:
> > But it introduces a new problem: the screen no longer turns back on if
> > I boot the patched kernel from the "display off" state.  The unpatched
> > 6.17 kernel would at least turn the display back on from this.
> > Furthermore, rebooting from this state keeps the display off.
[...]
> Thanks again for testing. Looks like your BMC is especially picky about
> these settings. :)
> 
> Attached are two patches; each trying to eliminate one of the possible
> causes. Could you please test them individually and report the results?

0001-ast-Use-VGACR17-sync-enable-and-VGACRB6-sync-off.patch
  ^ Everything appears to work fine with this patch applied on
    top of 6.17.

0001-ast-Use-VGACR17-sync-enable-and-VGASR01-screen-disab.patch
  ^ This one has the same problem as the last patch: the screen
    does not turn back on if it was previously off during bootup.

Thanks,
  Nick

