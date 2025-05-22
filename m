Return-Path: <linux-kernel+bounces-659337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CDAC0EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38411887B24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9F28DF2B;
	Thu, 22 May 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLtw3qnB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FE28CF74
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925570; cv=none; b=RJiA2n5MrqN2bm4kGsGTJl4pdqkf+fpl/706h3hxQmJnoD+LIaVADmrqlkH/Fa5fUuub0OAgoE5ZI9z1OC/NJeEAOJG+f6Aaj6aP4GGx4F7pNsvHyQrZCdgoiTGpLggcI7fka3XdJp+oSrDMlHdTFTr+v/VdSHu60yZLFBn1HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925570; c=relaxed/simple;
	bh=7uAUNv82+LtkHA55DSD3QR6OnOrjU66RtE2T6otPNFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPadByqsHb/sO0F4x1Xg/PByxxuno/iAagFO4QVG+ExuPzpZPJ2DLWSk3Ih0XRpWcHF8V4AoUstEyZfCgi/6dBj7sE8suWJpZFl8v57U1JUl4C5mZ5yjN5ysmHfVMG40/6zC31NbxEEq+/Vb8AlMrMfNf0aFdX76tQZYnDeWa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLtw3qnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747925566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRqvAWIG+gW89awdSOcbpmSa/4HXlHRyH1DkS4kHixo=;
	b=CLtw3qnBKcV53XvXZanT8KqJSCvoV6yMoEWnGpHM4YqvBcmdL+HjWSzbgk2K95wcRXLkrc
	NYdWMizxnNJaOt5hANVPSlkHnSdfQoav8MQspp488BIkCzU0o6v+eVIMozRo+HGyt7grPb
	M1HkzAa49Uv8hTtVOg9j4yX16p4gfjw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-CcOIsM9IPI2ikLnRdLq8jw-1; Thu,
 22 May 2025 10:52:44 -0400
X-MC-Unique: CcOIsM9IPI2ikLnRdLq8jw-1
X-Mimecast-MFC-AGG-ID: CcOIsM9IPI2ikLnRdLq8jw_1747925563
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D92619560AA;
	Thu, 22 May 2025 14:52:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60F0218001D8;
	Thu, 22 May 2025 14:52:40 +0000 (UTC)
Date: Thu, 22 May 2025 22:52:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, piliu@redhat.com, prudo@redhat.com
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	coxu@redhat.com, ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <aC86NSypHlER2C3L@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 05/22/25 at 07:08am, Mimi Zohar wrote:
> On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
> > On 05/21/25 at 08:54am, Mimi Zohar wrote:
> > > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > > > CC kexec list.
> > > > 
> > > > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> > > > > extra memory. It would be very helpful to allow IMA to be disabled for
> > > > > kdump kernel.
> > 
> > Thanks a lot for careufl reviewing and great suggestions.
> > 
> > > 
> > > The real question is not whether kdump needs "IMA", but whether not enabling
> > > IMA in the kdump kernel could be abused.� The comments below don't address
> > > that question but limit/emphasize, as much as possible, turning IMA off is
> > > limited to the kdump kernel.
> > 
> > Are you suggesting removing below paragraph from patch log because they
> > are redundant? I can remove it in v2 if yes.
> 
> "The comments below" was referring to my comments on the patch, not the next
> paragraph.  "don't address that question" refers to whether the kdump kernel
> could be abused.
> 
> We're trying to close integrity gaps, not add new ones.  Verifying the UKI's
> signature addresses the integrity of the initramfs.  What about the integrity of
> the kdump initramfs (or for that matter the kexec initramfs)?  If the kdump
> initramfs was signed, IMA would be able to verify it before the kexec.

Kdump initramfs could be generated each time when loading once change is
detected, e.g newer kernel, kdump config tuning. It's different than
UNI's normal initramfs. We don't need verify it as far as I know
according to discussion with UNI dev, so ima=off can be set by default
in kdump kernel. Even though one day that's really needed, ima=on|off is
a switch, not a hard code.

Add people woiking on kdump UKI to CC.

> 
> As for the next paragraph, based on Coiby's response, please remove it.

Got it, thanks.


