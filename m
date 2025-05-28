Return-Path: <linux-kernel+bounces-664969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF438AC62C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5233AED74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230C24467D;
	Wed, 28 May 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMj61BIp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324691F872D
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416620; cv=none; b=nATlgQD1LEsf1Ocpupv+lal6l13cufmgdxv/Gcb4m8F0OlezNpF3dZs+DI2J/jGQKNeqWBb2haaAhSN/lZTY04KiPkTt9h4FYBTXW6BTVT+d0bc9PVQpoEMUn+Av5wuel4kD2ZODoR2ylLdJt/9hypRs4NrknLgtQm9eJJstWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416620; c=relaxed/simple;
	bh=hq8gWYqnKKoKi9YMyMtjzxe802L2vhu5zZ+wC637M+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBjD03EukzjDPvk82DJIUPh5CeN/ogV/L+0H5vustROoHMDt0SgVmELjVLrKjynhJqpRRhtpu2I4fKPcYA7ZcSeNN3h6RXHKqBaULo69y25Df/C20aom6uq2AdxJSugTCMR6dyQaROI6hnoSbUreqxL/rK44DG3Z/Zm/zPKvTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMj61BIp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748416618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uqW+fuUszjgO5HVBpIHxHEyysrbpSb3yza49f7EKaE=;
	b=YMj61BIpwb3jD9+zT9y/DecVjE982lAIX70XpoD3gweOMO23baaJVcmz8lJuM65B9rKHhl
	LN7WLo7ahL7qLM0rGzz3FB5PFbziK/B6ou/rOravYk38csiK9ERkJqZMOA5roH6EMehPWJ
	ptq4NPKNg8KN7BPvfC34xL+ugEiB0Ws=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-iECNX6LXPheDA8EPYCXsjg-1; Wed,
 28 May 2025 03:16:53 -0400
X-MC-Unique: iECNX6LXPheDA8EPYCXsjg-1
X-Mimecast-MFC-AGG-ID: iECNX6LXPheDA8EPYCXsjg_1748416612
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7359195609E;
	Wed, 28 May 2025 07:16:51 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.45.224.91])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FBD018003FC;
	Wed, 28 May 2025 07:16:50 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
	id F262E450776; Wed, 28 May 2025 09:16:47 +0200 (CEST)
Date: Wed, 28 May 2025 09:16:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa pages
 too
Message-ID: <4qola3kscsxwpxmfowsigotjwx5f4meramwjww5ut4nzq3pu6o@n4b2fco644ap>
References: <20250527144546.42981-1-kraxel@redhat.com>
 <20250527144546.42981-2-kraxel@redhat.com>
 <CAAH4kHYMyJ0Td47KShOJGntRPs6RLcJ97oajA7z9VPdUbjT+WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHYMyJ0Td47KShOJGntRPs6RLcJ97oajA7z9VPdUbjT+WQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, May 27, 2025 at 09:44:34AM -0700, Dionna Amalie Glaze wrote:
> > index a4b4ebd41b8f..1136c576831f 100644
> > --- a/arch/x86/platform/efi/efi_64.c
> > +++ b/arch/x86/platform/efi/efi_64.c
> > @@ -215,7 +215,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
> >          * When SEV-ES is active, the GHCB as set by the kernel will be used
> >          * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
> >          */
> > -       if (sev_es_efi_map_ghcbs(pgd)) {
> > +       if (sev_es_efi_map_ghcbs_caas(pgd)) {
> >                 pr_err("Failed to create 1:1 mapping for the GHCBs!\n");
> 
> nit: update error to reflect the expanded scope?

Yep, missed that, will fix for v2.

take care,
  Gerd


