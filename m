Return-Path: <linux-kernel+bounces-752828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FFB17B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81703BB750
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC11465A1;
	Fri,  1 Aug 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGXnGqJm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CB12FF6F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017371; cv=none; b=MZz4LGNIEM6lge4EJ3HexSW03u62R6Wn+QRJzkfHq8aYej0EHcWIEVGQj/wT9/9pv+HcJa+Qoqu4kSWw3VVTSmgScet3n7tE8SY2+UBnhYMiEkhAr6FLBdUB9MWly1Yp5nJrKbwdiHWc2I2lnwCeN+voRQk964IQQNWTkRI8MsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017371; c=relaxed/simple;
	bh=p20Xxl+itiPTVTN9K/Rj5u1N4M+6Q1+WogOfcN8095M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJi94PQk+SQjhKC17OHqJmSaACf1092UtjW/7H+UMmWmTiJfjc4+RyfPjizgibP0jbbRGxFM8ooi5zOrEMwtXHODxGB3ftGhnEywSG3rd7sJMG/uAfd/8RgZx+s0p5vCgQT1kVNurNl+T2MSbKeDvFSMJuG5FgquYxkH2ee9KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGXnGqJm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754017369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlRwIOX39loAW8Ndc7IEtOq9p1vayc9rGBUA9qXU/0w=;
	b=YGXnGqJm9xBbw/SALAnQo7w4S06W8Q0jv1nGvvi5Re7p9dTH8qC6LHoBY5qkFTWlaKBX8W
	1AbFW+4VJQRfhAKEahcM7vZ/BSh2zWi7dEyK/Oy1rMWN+95T/BXmN/RKtnLVlsZQAJIRqW
	MwDKJCZnPS8LdCe8le8uxeFQfl/B+Fg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ATep_vWVM4mb-Cfc0HRovQ-1; Thu,
 31 Jul 2025 23:02:42 -0400
X-MC-Unique: ATep_vWVM4mb-Cfc0HRovQ-1
X-Mimecast-MFC-AGG-ID: ATep_vWVM4mb-Cfc0HRovQ_1754017360
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D9DA1800374;
	Fri,  1 Aug 2025 03:02:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.183])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD09D3000199;
	Fri,  1 Aug 2025 03:02:36 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:02:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, x86@kernel.org,
	kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Message-ID: <aIwuSFKSUJDI6ULl@MiWiFi-R3L-srv>
References: <20250729182142.4875-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729182142.4875-1-makb@juniper.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/29/25 at 11:21am, Brian Mak wrote:
> The kexec_file_load syscall on x86 currently does not support passing
> a device tree blob to the new kernel.
> 
> To add support for this, we copy the behavior of ARM64 and PowerPC and
> copy the current boot's device tree blob for use in the new kernel. We
> do this on x86 by passing the device tree blob as a setup_data entry in
> accordance with the x86 boot protocol.

I see how, but no why. Why do we need to add DTB for x86?


