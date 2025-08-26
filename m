Return-Path: <linux-kernel+bounces-786588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F5B35EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11A7D4E41C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907A83093B2;
	Tue, 26 Aug 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3+pRQgF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A3259CB6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209978; cv=none; b=jzq2bQR312yxOxHG4DNTbUc5vQXJ5P0A5GAZL4LNcI0qHMdj26USH1U5oVMgJKYj3NoiWmWPe70LZ8x+CVOwYCodQF7wSIBn17rQLME0vQLe2BPPZdC5Fd15YSn10aOQypMfRyqDNK7aHXF1qlC6MM071dg9kcLjbJk8NHMDkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209978; c=relaxed/simple;
	bh=bSRRUAqhvp44h3dVi1WARRkNFMByO0ADl300jk30jNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqrrgsbRyPKKtWsED2LVYgjoFKweCPhzN4VcIlvfSUeqtW4Lfpw6HjkBaSgltoLneK41Kp9ytl5FC0mow4783+E0oIBq5UuUResbUlM1ZUwsE2gkqYoE8kE4aqC1iiUPc49h5pSeLm49KUWRoLKGsYl+vy6VZTdESqWp89HJmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3+pRQgF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so816274366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756209975; x=1756814775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxFjkTB2P79PoUaLxLAUp+gv0c2aOYdZxNYZuNh3BDw=;
        b=F3+pRQgFkpzCCYJ7wQ3Odb12m1NnauCMjLfwz3R88V/o068VVmnJwLdcbZ3TKgeER0
         j4QTlKzDI/eTaobO9531MJDSjHATCSqZoKUNfMxJgx8LfagE5YZ/jn1YgplEKVLBrGay
         rot0DUgC//tgLU2brQm4i4q/pJdWaY4QfY+HFsVHwYdFeWLA43wdAqrf7tJnIXlaY1Xh
         Y5udcfd7K7KIJqtQ1tq3paHmiQMqgynhay41Gv29Le5E6dbXGdsgZVMa9k1hzQ5CZJRr
         mVaD4QVyNi2mJWXfu7WxrOutA+HTEPGLsueBVlkCbNWpnS1K3Lk4AyZ7ngDRCod0LP08
         x+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209975; x=1756814775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxFjkTB2P79PoUaLxLAUp+gv0c2aOYdZxNYZuNh3BDw=;
        b=SOVR6EsR6Awsr0lHn/gv8o3VY4JL+bzl9257RJlKlwggwRmwKqA1GNK9YojxdSaHtH
         9PJF5BHnMqRfch3AVSJwE6++824qYumMu6XyJMtwZu+XKtjjA+J07uJSpxqUryN8/gtT
         KSnNLV+YrLm1WgOSCOYQQpO+IvuW55yoGxcWjTpRfIHpsgW2VGR06IfHkQOXBMVrAqAF
         OohgV3RoI6bhz5Ol6kLyNkk8coHsRP2YxCG20rEzrciHP9iSzV5Er6fbxL9PMb6BnFAa
         uafvgpCT5fi/3i7xonhi+GQwmnNII38/JGtBifEV+awI0tzolij+fkzvwB5qJCNYSILn
         hYrg==
X-Forwarded-Encrypted: i=1; AJvYcCXCLEDaKYNSiTAQ8E1WAOBoVNVAMA3FtbR89VAAfTrxTqQB1notSBtE5Pxt5ZxQ51LQ+yDAgiCbitRnFxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgkaTOXgJKMuGX0hu1tUSV69WjB9YvbehUhxf06XLLuzgMWFe
	ofuEhKomJfWEc3ANlzvI/6aZnCGcGQcQi4mMA5f97w5QJt+//Xcez+BmqiVFU1I1bapIAfsXrBi
	/vmByIwn/PCjiAl/G9gokaDvICT8+7hRuycZDqEhFmw==
X-Gm-Gg: ASbGncvUAeodbG19p9xRXk4jf7ztlG3e5LneLE36PpR1s8qV1rcw4b5bof5X3nmNls1
	lHc/SAg179zx5+BVkWUilO+whu5vcF1mxtfpigz90hDDGobnyji/r7B+H8sBM+5E35JEhKxz0FD
	TsCNckfNNe+S357RjEXcyj6nYUa7/F5i1+ts2CtoO3PYdbgWudfECoMmFidtK+JGSbdU9nLLSKD
	Aq8Lz/6HZ2O/zBgQIUrZhuhapVUCpOB5nZFjcY=
X-Google-Smtp-Source: AGHT+IHCPPogA5I5xYJjZ3AF2Jj1OEbjkizkVIqqQo3oG7dsb9k66ChvqgzLqUtgok2+xdd2moMuf4gTw379MNCuFxA=
X-Received: by 2002:a17:907:3f0f:b0:ae0:b3be:f214 with SMTP id
 a640c23a62f3a-afe28ec592dmr1369727666b.9.1756209975430; Tue, 26 Aug 2025
 05:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124458.334548733@linuxfoundation.org> <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
 <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
 <CACMJSeu_DTVK=XtvaSD3Fj3aTXBJ5d-MpQMuysJYEFBNwznDqQ@mail.gmail.com> <2025081931-chump-uncurled-656b@gregkh>
In-Reply-To: <2025081931-chump-uncurled-656b@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 26 Aug 2025 14:06:04 +0200
X-Gm-Features: Ac12FXzW7NUCjgYWSamJwSOH-347hP9Z3Gi-swjOizdLDz6f5VXnlkQBVvbGglE
Message-ID: <CACMJSesMDcUM+bvmT76m2s05a+-T7NxGQwe72yS03zkEJ-KzCw@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, srinivas.kandagatla@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 13:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 19, 2025 at 01:30:46PM +0200, Bartosz Golaszewski wrote:
> > On Tue, 19 Aug 2025 at 12:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 19 Aug 2025 at 00:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > >
> > > > Boot regression: stable-rc 6.15.11-rc1 arm64 Qualcomm Dragonboard 410c
> > > > Unable to handle kernel NULL pointer dereference
> > > > qcom_scm_shm_bridge_enable
> > >
> > > I have reverted the following patch and the regression got fixed.
> > >
> > > firmware: qcom: scm: initialize tzmem before marking SCM as available
> > >     [ Upstream commit 87be3e7a2d0030cda6314d2ec96b37991f636ccd ]
> > >
> >
> > Hi! I'm on vacation, I will look into this next week. I expect there
> > to be a fix on top of this commit.
>
> Ok, I'll go and drop this one from the queues now, thanks.
>
> greg k-h

Hi!

The issue was caused by only picking up commit 7ab36b51c6bee
("firmware: qcom: scm: request the waitqueue irq *after* initializing
SCM") into stable, while the following four must be applied instead:

23972da96e1ee ("firmware: qcom: scm: remove unused arguments from SHM
bridge routines")
dc3f4e75c54c1 ("firmware: qcom: scm: take struct device as argument in
SHM bridge enable")
87be3e7a2d003 ("firmware: qcom: scm: initialize tzmem before marking
SCM as available")
7ab36b51c6bee ("firmware: qcom: scm: request the waitqueue irq *after*
initializing SCM")

Bartosz

