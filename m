Return-Path: <linux-kernel+bounces-749458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06338B14E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377883B781F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0311A0B08;
	Tue, 29 Jul 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzQTY4MM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5029D0D;
	Tue, 29 Jul 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796684; cv=none; b=FAA/Lg1P6SW3KQNdYDahcLL0ooANlmg1Gp0TJT9Biya0+1zDRn9YyDWmEnDzuJYLCy8BBKcPdfTikDd/HhvakFslK2lITgvtbp9+Ogjg30ga5B+17yxskeCJt5luH0kmhT4MoPq2TLHKKP+fCgzmJ+1pJB+sg3LhvnfYxyQcB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796684; c=relaxed/simple;
	bh=VZdbrG5fpMlMUtdUV+2Oi1rJl1JV2TJ0vNDU+akmrKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXs1LAOkwxJL/AlnrYolIbGGlk7x87114WjAoFgK3ugYR6kYGA45P1MV4VZn6lDiQHkvp8dUXqtfKOEY0Yn632sstZRdwyW151t0dKgu13EOoEBQo+cGaIjEJL8LIA4PiBoIoZpWGBabNx8HaIlro+ogM2lq5bNhM2QEWwDkIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzQTY4MM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1398C4CEEF;
	Tue, 29 Jul 2025 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753796683;
	bh=VZdbrG5fpMlMUtdUV+2Oi1rJl1JV2TJ0vNDU+akmrKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gzQTY4MMZQO6OJdtoyM5Ldojem3RmzZgNFua4t8TLdnbHQT8aPlHUF2VGENZ9TUgJ
	 2jo0PLjI7p+owHc1lQRbP0hsWf7bIMDi8sFpCCu96mcGH8TZMZqkhJNe+O4LNWFQR7
	 NsGYUfNILYMKzj4kZeI9KJxc//W11nU4+xTtIzl9sVoP2omaMWQ3j3zxsecsDIRQvi
	 5pNzInUcpbJXicpn7/ZAwerEW85RTXsAkeg0+8fPkRuyNRaS2Yle6JGYaapC0O+iwn
	 sZ7Ew8yKnvR53KbsV4OS9yqepzpSze9oJToqK4UYuvCxfi19N71b72A5JsREyK5PGY
	 fV3v08U8+kaEQ==
Date: Tue, 29 Jul 2025 15:44:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
Message-ID: <20250729154437.6cbd2788@sal.lan>
In-Reply-To: <fd1372a9fb57a1372db5b3c0992a929f90183f83@intel.com>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
	<58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
	<20250712163155.GA22640@pendragon.ideasonboard.com>
	<20250713002517.7f52b0e9@foz.lan>
	<875xfhabv0.fsf@trenco.lwn.net>
	<20250724194306.27b98194@foz.lan>
	<83d12d5293e23c622ae390204fed8fd4453014b1@intel.com>
	<20250728173306.2ab1409a@sal.lan>
	<fd1372a9fb57a1372db5b3c0992a929f90183f83@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 29 Jul 2025 13:45:26 +0300
Jani Nikula <jani.nikula@intel.com> escreveu:

> On Mon, 28 Jul 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Considering the above, for me it seems that the bus already departed:
> > there are several cases where Python is required during build time.  
> 
> FWIW, if it was up to me, I'd make Python 3+ a non-optional build
> dependency. I'd also forget about any Python 2 backward compat stuff.

I don't think we should do much effort to support Python 2, but it comes
almost for free: only shebang needs to be different, and, if the comments
inside the doc contains non-utf8 chars, an encoding line.

The current tools during Kernel build currently supports it (again,
except for shebang).

Anyway, from my side I'm happy either way.

> I would find it very useful for code/header generation during build
> time, instead of having to resort to C hostprogs. Similar to what MSM is
> doing.
> 
> That said, I know there's going to be people vehemently opposed.

Fine from my side ;-) There are some precedents here, so I guess it
should be up to each subsystem to decide using it or not.

> > So, adding a "depends on TOOL_PYTHON" doesn't seem to be trivial.  
> 
> Agreed. Forget about that idea.
> 
> 
> BR,
> Jani.
> 
> 

