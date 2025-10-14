Return-Path: <linux-kernel+bounces-853489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3ABDBCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F9189953B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375E2E62D4;
	Tue, 14 Oct 2025 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jHzp/zUR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF281DB122
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484377; cv=pass; b=IinMw6ope61ogtG+aXh1EP+K5iYmCHGKJEdbXscBBNNLjWJe5+UPPUL9Z8VZpui1DBEAUrWE729E6R25XK62WrnzQmyXcfT+W4+3AvVc6ZAVfGUI0zVxgbi9UD+bCcKu9sNqgBM5SH81UTH8DxeJymmQdnlbpyrzaKmujy6KsCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484377; c=relaxed/simple;
	bh=oer4k1kYVxL29x3Z+c80IUZi4Z44i9jq1hZ/CsvBSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWVoRnKn3cLsAwLKVS+Pz+ZogHHMv1ZEgA8cfsIPUgoWMPnhn6g1l+tC48JNQEiUNu2Ti3GOxQGXA2Z13GywJQvmlSX/Fo6Keu42ceePbS4EiwYeWIkwx2nk839C3JiPp65n21FFNv3TnhXtUWqSGIegNEpyG1jwnAkcbsu364A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=jHzp/zUR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760484355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l3aEtCGOBFmw34kvncruL5I0CAdmjLd3ugm7GxNnrDugRlCX1pNAn1nGj+UCi8IF+iZWZP+bphH2YeYCmBe22nu2AIqvMnnXUxUMYJpVTLBKwkm6qU87LBZ9f0X5zhrTb3GEnQYicbEF/1sEdzuCcnjaxNEtRcmsWHWV7mQO4h8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760484355; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Wi2ZRrHxNn49/AQiAXirHuf6hBMU43LJAxsXybMZx9M=; 
	b=OvXJKhdvXFT+1mRA3lrvqzmVSlsS061cLS4Qq/zklmCCihLBuMEkoNDeLKKfpPpgZ635w9OWtSLhs2p/CB6F+uX66Th6l6LasIxPVAmAJnLwaAH9VR7OiuKyPxgVlDxnBsqb1Bk2MZRzv7z0E+W/fm8VAFVHdxRCBbxVBcmg8t8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760484355;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=Wi2ZRrHxNn49/AQiAXirHuf6hBMU43LJAxsXybMZx9M=;
	b=jHzp/zUROnFSKCcXwfpokPJi3hn+exWK8MY378jA/sx8UqtGFN6zk+4+onS4Cpch
	uXOKmaunxZ61XfqiDBegacWKWHH3NyouKTI0fjdFGkl1ytYcj/VFeW9pfBXK6oZKfx8
	vyxie3ebiqzH1Hn9CepsNrbD/wFJAji83KHmYPxA=
Received: by mx.zohomail.com with SMTPS id 1760484353782985.1438714110084;
	Tue, 14 Oct 2025 16:25:53 -0700 (PDT)
Date: Wed, 15 Oct 2025 00:25:46 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@collabora.com>, 
	kernel@collabora.com
Subject: Re: [PATCH v5 12/12] MAINTAINERS: Add Adrian Larumbe as Panfrost
 driver maintainer
Message-ID: <mrp2orrfpxhb2w66lzrjnqpnhf67ahkqislc6tjbzzwjm57a35@c7hod3cwkzou>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
 <20251007150216.254250-13-adrian.larumbe@collabora.com>
 <971fd0e3-474a-4685-ade2-f4563372f74d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <971fd0e3-474a-4685-ade2-f4563372f74d@arm.com>

On 09.10.2025 16:47, Steven Price wrote:
> On 07/10/2025 16:01, Adrián Larumbe wrote:
> > Add Adrian Larumbe as Panfrost driver maintainer.
> >
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>
> Acked-by: Steven Price <steven.price@arm.com>
>
> Welcome! And thank you for helping out.

Thanks a lot, I'm very glad to be onboard.

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5257d52679d6..cb68fdec3da4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2066,6 +2066,7 @@ F:	drivers/gpu/drm/arm/display/komeda/
> >  ARM MALI PANFROST DRM DRIVER
> >  M:	Boris Brezillon <boris.brezillon@collabora.com>
> >  M:	Rob Herring <robh@kernel.org>
> > +M:      Adrián Larumbe <adrian.larumbe@collabora.com>
>
> NIT: it looks like you've used spaces not a tab.

Oops, thanks for catching this.

> Also while we're here...
>
> @RobH: Does it still make sense for you to be listed as a maintainer? I
> haven't seen you active on Panfrost for a while.
>
> >  R:	Steven Price <steven.price@arm.com>
>
> And given that I've been doing a fair bit of the merging recently I'm
> wondering if I should upgrade myself to 'M'?

I'll resend a new series flagging the two of us as maintainers.

> Thanks,
> Steve
>
> >  L:	dri-devel@lists.freedesktop.org
> >  S:	Supported

Adrian Larumbe

