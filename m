Return-Path: <linux-kernel+bounces-814030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B849CB54E66
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797DAAC089A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D630EF66;
	Fri, 12 Sep 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HkmJrg+m"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB530C614
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681312; cv=none; b=sUIAjuwOC4RON3p5+T2LQ1QuszWsZagcuT63wZVBpZz7dpWPb7TThSjQvP7jYZbC8XSWdzN+2t3KEOmEJMxacjRAR9lJ0MZvKGjsX+MPx9A7T8kpxUyYtJvD5kf5TJdDN7cekyAI9/ZtP7jaBzI8cIgMIeZ8fsHpNgU+OS9A7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681312; c=relaxed/simple;
	bh=W2Do7P+lCvL8d6sw1htS5uhjgo1iwh2ZcwSHREXCl7o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pBvbYTkWUsXaS3LfPMeqfy/tklSvLYMrMqvQF/HzyFgIW7lkNYB06RvJU2jW0A+yJMy0OuJwLCRYrueaOxKbxQR+RpI2GePJhn4tKTLpuqj+Y3XzFTkn/KXJ9qJjtkhGW9h016on+fJQBgsWYhqSJ1DAtf2k8o9dMGcfHVcjZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HkmJrg+m; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757681306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL7JO++Q7ebDk6pnXvHTsS19g6iMYqqChi1RqThV9CA=;
	b=HkmJrg+mMrppIasXNvQVeCpET13y1bq8glGlYP1V2XPWP9scdkCLANvhZfhm8HjcJC4KLK
	PByAdTAnV5kpTdjMI0Fv/tELbfO5gxo8mT6tK/cNOtDYnwS25Llnv53CE0KKOqrCcoQ4bD
	5h7+0gBTn9+OQZp2R4pDjb/O7cOYFm4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] drm/amdkfd: Replace kmalloc + copy_from_user with
 memdup_user
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CADnq5_MFDZdJg3XFFw9+tWB=_LP47PwE3HXgPK=sryOx+_0wGQ@mail.gmail.com>
Date: Fri, 12 Sep 2025 14:48:13 +0200
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FED6FFD1-2C51-45F4-BF34-76484C415C83@linux.dev>
References: <20250909151146.760450-2-thorsten.blum@linux.dev>
 <CADnq5_MFDZdJg3XFFw9+tWB=_LP47PwE3HXgPK=sryOx+_0wGQ@mail.gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Alex,

On 9. Sep 2025, at 17:35, Alex Deucher wrote:
> Applied.  Thanks!
>=20
> On Tue, Sep 9, 2025 at 11:29=E2=80=AFAM Thorsten Blum =
<thorsten.blum@linux.dev> wrote:
>>=20
>> Replace kmalloc() followed by copy_from_user() with memdup_user() to
>> improve and simplify kfd_criu_restore_queue().
>>=20
>> No functional changes intended.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---

I just learned that calling kfree() on an error pointer doesn't work, so
this patch should probably be reverted/not applied.

Thanks,
Thorsten


