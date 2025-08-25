Return-Path: <linux-kernel+bounces-784395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A99B33B12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB64202149
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D932C08CA;
	Mon, 25 Aug 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO2ZIclx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313E2C027B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113984; cv=none; b=MGheEwc7MuijfsSFKUKnMtoUqA/SYDLy3t/X3wxAbvtAOnklnJgb4yMaHK8m44bAq5gZ/JMCTNxz9aEbv1MOOtNfxoRuBKZtUXSrEGHkdd7M+O+Vq3OR0OaILHS2mUTOh03FLQrE0KoktrYG85PJ7WfxZwka3l/X7I8i7oK3E1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113984; c=relaxed/simple;
	bh=cIzdmcvXdg7hxkkZDexpcsEff8DWNSt3EqI8LIw59v8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kP34SVJYhJrtTC1wdB8bB7sk8O1DxDk4rOGZWBwVtVnEBe61o+LTi9ZYf093NMgrfRDMmwH99fMq/k+yx1LWh7e02wXAtKlXiMRIEJOVevo3mp707zm99nCo84wFQxl+0CZUP0Jy0k6efJnJFr2IHPh3wzAJCrA/jKhqdCxQosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO2ZIclx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756113979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=58sTOuEGPWt/oh3phiU0Ohm2TNJomRF2T7ceM8gERPs=;
	b=WO2ZIclx7JFGeE5p1QwUWOJ3PJqYWGrDGP/ps7Pne7L31r0CAEeUQwfoNeFUe/0CpKWAKl
	V6ysu4jbPdN6O296+wqa6QC5eSm+7gJtMwHCmgx7W8jcYuvJ2fOuAy1dTy9BP3goj/Nnqw
	dnsE1U5NAqAlE40nZMiSyEwKZsdVKWE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-OVttxm5WMLqfO-Nw3GtKtw-1; Mon,
 25 Aug 2025 05:26:17 -0400
X-MC-Unique: OVttxm5WMLqfO-Nw3GtKtw-1
X-Mimecast-MFC-AGG-ID: OVttxm5WMLqfO-Nw3GtKtw_1756113976
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04627180028D;
	Mon, 25 Aug 2025 09:26:16 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0B5E1800447;
	Mon, 25 Aug 2025 09:26:14 +0000 (UTC)
Date: Mon, 25 Aug 2025 11:26:12 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, john.stultz@linaro.org
Subject: CLOCK_AUX stepping
Message-ID: <aKwsNNWsHJg8IKzj@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There is an issue with the new system auxiliary clocks. When I make
a larger step of a CLOCK_AUX clock (by clock_settime() or
adjtimex(ADJ_SETOFFSET)), the system slows down significantly to
almost being unusable. This didn't happen with the original
tglx/timers/ptp/driver-auxclock branch, but happens with 6.17-rc1
and later.

Reproducer:
- echo 1 > /sys/kernel/time/aux_clocks/0/aux_clock_enable
- git clone -b staging https://github.com/mlichvar/linuxptp.git
- cd linuxptp && make
- ./phc_ctl CLOCK_AUX0 set

"echo 0 > .../aux_clock_enable" revives the system.

I'm not sure if this isn't just a symptom, but the top functions
reported by perf are:
  87.10%  swapper          [kernel.kallsyms]       [k] queued_spin_lock_slowpath                                    
   6.84%  rcu_exp_gp_kthr  [kernel.kallsyms]       [k] queued_spin_lock_slowpath                                    
   1.90%  rcu_exp_gp_kthr  [kernel.kallsyms]       [k] smp_call_function_single                                     

-- 
Miroslav Lichvar


