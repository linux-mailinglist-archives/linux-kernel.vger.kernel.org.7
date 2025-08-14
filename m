Return-Path: <linux-kernel+bounces-768990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3013B268CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558AC3BD1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147EC31EFF8;
	Thu, 14 Aug 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N9PzrbPR"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52A3112DF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179953; cv=none; b=Saao9i5IBpLkP/qDXMyvXuxwqraa1/FCcuvXEfUOPXhrgpjiw6BJ4xvwBu/2goRt6o7XY4CVRgbGVmjvzMo1DoSrOSyzmkL/+hgTW3ZU8TJH/voxerlqJGmbcRTpSAeHXXMe2d1dan8hVJHqADwEOZf3bE5Cbh/QShvYs+vzdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179953; c=relaxed/simple;
	bh=4ExxKGDx0fgiOXw8CTywAcBsJ8ogwJcpwNnL1i5YNn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEqAgw+4xUjiZeaBr6KontaHut9DCriuGZUwiZL+IvrcXlunBfpLaz9q2EIsuyI1P/62at6bpCap2V0hBQgZ+HgBJq1ctFv0ijHoOoB3G+U6gwaAdiZyWFMaih2q/5Yb4IYwtSBbp0HGcZHxuPD3T8+PvbWdiOAWEqnOY5kGuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N9PzrbPR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87035a7c3so123159985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755179950; x=1755784750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZZu0s3S5A8+/SIi2GUbQjh84N2xIaZ27oBHRZEOGZ0=;
        b=N9PzrbPROtxWyZbVaEBxCJ+BwqqrykRK9dMm5PlCwrgj52BJTh0yaIKl6U+TBukioz
         BPxbfO2yXzEC2/eypvErSF9CJUW2sfKkMpg9uPwPErqosswfRFh3t0BTbhDI54npUagA
         lilmlNGdIvGBEGMnLDjZnPV+IPwZ9Rp6Swc0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179950; x=1755784750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZZu0s3S5A8+/SIi2GUbQjh84N2xIaZ27oBHRZEOGZ0=;
        b=DeBxzfl/V8pVNPfxgQh8squxaiqpp/4xN36QtN0i0ERLKmNs9HnD8eBUgcIGAqahJT
         VaSgVX0wefxrk+p4jMmODbRX7zNwyEZr6Ud66j0PeqgXUpFTmQ6s0wNAqnyU0VQlL6E2
         XK7S0OdA4mh+hGAniAmnc4me7qcE6poigOsFyJsJsq/mUz1/3Y/AmX9MvvpnCSiZtg+u
         xPgblLHpb/pq4CI86WaCv4ia4HbtLaW70wtkChZ1TO4bG0zFpulKPwe2jFkw+v8bsWut
         0vSGj+BWAmVTUwHw5JJlK1Af6P6I4u7j4zuxhepBMmhwIbSCATK2okeiU9rADwqSrPX5
         3INQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqeNiszAnUJuUsd+fWNljtoovztBrAHvYF5q4CuDDEuxwe/aygH9LDqlJRPQNC4a0wDUbTuJUqPKt4Bj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7/26l9U+VHIUtgOlEbB3KBG9YoX2ieiaklWypr0B6ANOQqeX
	+CMn7tyIlymN/AvBAvrXVslqVgedIzH6i6QoO+VjQUi3QU2KjUx2b6tQOulCfGyw52ITqEWXhzU
	j5N2lUVmmnOvmu721ixY8On43XZzHi7+IPtBOeeL1Tg==
X-Gm-Gg: ASbGncvsgl2kvZsBoFftlnNVshrlFgR76Vn+bxxa0RxLQtU8ASUhJZrTpZL1EPMzZnZ
	fh0wa/nZLJY5uPZPgcIpmZocGcsI/mIYwyp+7aYNl0kCGwAZvgiS0jXHucpe+XPHsVKovvRJylp
	AuEScL+O9V+djR2bj/rl6T3BdYHtEM1GWaJ4oaROfa+/Ic8K4mZjQsirZZOmGlxLkgxPUiap70M
	o58
X-Google-Smtp-Source: AGHT+IHDCZisldsHFROueT1mDv+N2w5BriAS/91vOctNmeG6Etw7NNZmRk8u6yHZ87xrdPA7iktx621LgwaHh85teV4=
X-Received: by 2002:a05:620a:e0a:b0:7e6:8545:5505 with SMTP id
 af79cd13be357-7e8705a2a88mr419769985a.55.1755179950579; Thu, 14 Aug 2025
 06:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
In-Reply-To: <20250703185032.46568-15-john@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 15:58:58 +0200
X-Gm-Features: Ac12FXxPrNeYbLt2gO4V6U2nB86--yn65EeQtUloUgMUUdsnzFSb_AaNjXQhYqI
Message-ID: <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
>
> * The new GET_DAXDEV message/response is enabled
> * The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_dable yet.

This is rather convoluted, the server *should know* which dax devices
it has registered, hence it shouldn't need to be explicitly asked.

And there's already an API for registering file descriptors:
FUSE_DEV_IOC_BACKING_OPEN.  Is there a reason that interface couldn't
be used by famfs?

Thanks,
Miklos

