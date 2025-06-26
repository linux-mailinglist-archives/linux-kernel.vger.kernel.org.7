Return-Path: <linux-kernel+bounces-703939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFAAE9710
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 09:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463BE6A23C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76523C4E6;
	Thu, 26 Jun 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4FTH9oF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BF23B624
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923809; cv=none; b=CVrSA+KV2vu0dWymhfdDbKWfKb3SEako8Q3GIM0jFdKauMT6aEvFZ5pagzOKsOq9mzl36hUNnnFPfdRd0YTl7dT9JXNH49Zz0z92/Q5RhQEiwyD5rzt7hJZR5HwAO9h+Q5IUp9H9KL7nrUHwoDKdoBnM/jfii7Gziku0WPc+FtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923809; c=relaxed/simple;
	bh=KI5RRrT+8qFW9KL2Rz5vlVXhQEzfuPx/wdew5UcDikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpJrWnW20bB2hn60PIbCH4Zj0muwRI6rTcwMM3VpDXDvPuF3tXReoFzwp9oglQvf+PbkVctFa4copTeFmsC7JsLAE/7i5AOtnAPi29/ogj5KC9PkcCudsXuINjYmxfK2efIgfNhXaLUMFqqu+8VBBUpKsdIgNwtB8Zf7zZGh9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4FTH9oF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750923806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S095HgRt+AMwYYx/gtDIex8fmqUB3o0NTlzdEf9Q8QQ=;
	b=U4FTH9oFlvgbiPbgsvF22a5bg/bzkawrpfH+pgkE7vO9w1M/lz+YNoVopWFwW7lPD2BVRQ
	PxCxnkayyaw7y4yZYrdV4TD7TCCHfcU/zc0pfCns33PBjcF7t6Yu1jtyQSD90F5ErGYaNL
	u2jLtXU34o+YclfeTvG+kJIZDKcrTlg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-Cvd0OTi8Mv-8nylEvvxVVg-1; Thu,
 26 Jun 2025 03:43:21 -0400
X-MC-Unique: Cvd0OTi8Mv-8nylEvvxVVg-1
X-Mimecast-MFC-AGG-ID: Cvd0OTi8Mv-8nylEvvxVVg_1750923799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0829A180135B;
	Thu, 26 Jun 2025 07:43:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.244])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E63018003FC;
	Thu, 26 Jun 2025 07:43:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id F01CB18000B2; Thu, 26 Jun 2025 09:43:15 +0200 (CEST)
Date: Thu, 26 Jun 2025 09:43:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa
 pages too
Message-ID: <jqwz74wv6sbqtabmmhxmsmgojojrj53oxsqyhbznm2iq7u227p@qpudglm5enr2>
References: <20250602105050.1535272-1-kraxel@redhat.com>
 <20250602105050.1535272-3-kraxel@redhat.com>
 <20250624130158.GIaFqhxjE8-lQqq7mt@fat_crate.local>
 <rite3te5udzekwbbujmga5kyyjjm5gfphhqoxlhtsncgckq6rm@7m7owl5jgubz>
 <20250625124016.GCaFvuMA9oApInTVyI@fat_crate.local>
 <4kk67edghl7wvqzuyubgr45mhols37yqsorbxxvkypm3xwnuvc@2oek5mladprs>
 <20250625142644.GEaFwHJHFO2gbSN3GJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625142644.GEaFwHJHFO2gbSN3GJ@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jun 25, 2025 at 04:29:36PM +0200, Borislav Petkov wrote:
> On Wed, Jun 25, 2025 at 03:21:47PM +0200, Gerd Hoffmann wrote:
> > This is inside a loop, so returning in case the caa address is NULL will
> > skip ghcb setup for all but the first CPU.
> 
> Then you should not piggyback on this loop but map the CAs in a separate step,
> only when a SVSM is running.

v3 sent.

take care,
  Gerd


