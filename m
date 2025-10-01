Return-Path: <linux-kernel+bounces-839470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031BBB1ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D571C6666
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819322EE5F0;
	Wed,  1 Oct 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZS0TGsy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60114A60F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350326; cv=none; b=TWzbp5eS6R8YpmJZT2/OMnY+L9VwqqLWtEPlifpttEmVpjJ4NcEXONMQbImY+2zU73Z9X6Dn2a3OEOZFZ7amTIb6yaAFdRySSFrHFI4LuRPEZAL0nzpF7BqIsfbZqlf4v3Dan6i7ROyS3nbGGrXDUBysbdyj/4qGdUV6Db7dSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350326; c=relaxed/simple;
	bh=cDMQ/Miw1V0mOMDj+NmDGCe9tUvPtu2fAp4XgseFJ9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=CGIdRnjuZoQcAKGeS2Iq3oWVNtzk3rPR3HV56qVV2t8U2G3n0h0NwAocoRaJ/RpChDutztloT0tUnSN0SXbh46vTKr6I4ZFcxY3Dh/VEgJ2JJYSfxW5rTwJ5FYEck3f3P8f1yj/+wEvu4xM2bKItSvNwcedFpbIyIlWj0ivwNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZS0TGsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE7AC4CEF1;
	Wed,  1 Oct 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759350326;
	bh=cDMQ/Miw1V0mOMDj+NmDGCe9tUvPtu2fAp4XgseFJ9g=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=PZS0TGsycQoKnA6NetFuERcWGqOTKxUTYvMvOkHT2kJm0KC2/JVDw/B6OawN7tsDE
	 ubGnFkdgVQMXciI4Z0YjGsVTl+jAYQyaoFQb2o2/YNuylG5nlzxuXEPALYXqI3ONiM
	 DfvT66jFQZccEkLYA23HAyEIjZanqtp4xECeshpWF7IYkacK+coT+TUHjx+qJvGsfO
	 /79qi32odWuiCgHA/ZgnlvaydADi8odQEjrkeOmvfKH7I0aujcay9f1WQ9JPtXy0h2
	 6NrNqo37Amiaz4VzdNf/r+hjPESZASSFruWBlHVSplBRGv2ymzK7x+cU/sch5vlPpU
	 ZOgAcE6zP2XGw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 22:25:23 +0200
Message-Id: <DD79N0TCT29D.24XVMO4AIFJZN@kernel.org>
To: "Dave Airlie" <airlied@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [git pull] drm for 6.18-rc1
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Sima Vetter"
 <sima@ffwll.ch>, "dri-devel" <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>

On Wed Oct 1, 2025 at 6:06 AM CEST, Dave Airlie wrote:
> The other big thing here is rust stuff. There is a pin-init rework
> which may also be merged in other trees (I can't remember).

I have taken the pin-init PR through the drm-rust tree for this cycle -- no
other tree involved.

- Danilo

