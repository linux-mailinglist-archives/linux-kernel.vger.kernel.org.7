Return-Path: <linux-kernel+bounces-733242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115EB0720E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDCA3A9C96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6074E2F0E49;
	Wed, 16 Jul 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QccxkNiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EAE2877C8;
	Wed, 16 Jul 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659013; cv=none; b=s2clhrIy9ftdoFvrDGvIC0A3v5eHNuHP4jkwEMW1QSbt6bRBhOdAx0JcSbc3FBHVdWd+NxitP4jDWvNiybtUO79Zxkewc822F4sToQCttn9JwKi789BGkZH3987h/sjWiS/o4CqWBhTOfa/oHOVinEqzExNkYm00LgrfzVmF0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659013; c=relaxed/simple;
	bh=q5LfttOSVPzCartXtZWejPzdbFBiNa7ERB5VCpk6jJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4rj26KL8DaZFqY88OprlilL9ilD5kn2dk9Yg2PDc94Gu+3g8BgeycmCaArFPGavjfldyC++dFa+XJuXpL5GP5MW5CBK9PdlOhTRjEEzTE2o+qQymcOJ2a2vSCg59nY3ywdu6VGfQsQ1aKSU19joCXNsJRuMXzGgF7TmyMHc+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QccxkNiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D82C4CEF0;
	Wed, 16 Jul 2025 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752659013;
	bh=q5LfttOSVPzCartXtZWejPzdbFBiNa7ERB5VCpk6jJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QccxkNiHzqU3CbdaWh8pI3X9zIGdHfPtpPBsv2I/f8ke2IloGRiOuWsWwVyPJqjwm
	 kqE3KFHjnMUgwtcxSnfjQZgOlc5l39L3q2Iey81EXDzttE0ZpmnIzhDIQyTobq3GuQ
	 1ZRqfoEY12f3dQdysOqxn6faTTM616N8B+BN7bN4=
Date: Wed, 16 Jul 2025 11:43:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com
Subject: Re: [RFC v2 10/16] luo: luo_ioctl: add ioctl interface
Message-ID: <2025071602-ditch-danger-f5da@gregkh>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
 <20250515182322.117840-11-pasha.tatashin@soleen.com>
 <20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
 <aGqHFkPWOrD6whv6@kernel.org>
 <mafs0qzypys0j.fsf@kernel.org>
 <aG9rNQ277weSR_dl@kernel.org>
 <20250714143443.GF1870174@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714143443.GF1870174@ziepe.ca>

On Mon, Jul 14, 2025 at 11:34:43AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 10:26:45AM +0300, Mike Rapoport wrote:
> > IIUC Christian's point was mostly not about using VFS APIs (i.e.
> > read/write) but about using a special pseudo fs rather than devtmpfs to
> > drive ioctls.
> >  
> > So instead of 
> > 
> > 	fd = open("/dev/liveupdate", ...);
> > 	ioctl(fd, ...);
> > 
> > we'd use
> > 
> > 	fd = open("/sys/fs/kexec/control", ...);
> > 	ioctl(fd, ...);
> 
> Please no, /sys/ is much worse.
> 
> /dev/ has lots of infrastructure to control permissions/etc that /sys/
> does not.
> 
> If you want to do ioctls to something that you open() is a character
> dev and you accept the limitations with namespaces, coarse permissions
> and so on.

Then use a special filesystem, and not sysfs.  It's easy to embed a
virtual filesystem in a driver, please do that instead.

thanks,

greg k-h

