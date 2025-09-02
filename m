Return-Path: <linux-kernel+bounces-795590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC3B3F4ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030577A8568
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58192D593E;
	Tue,  2 Sep 2025 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="fxlPIQ7x"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FD224B1E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792828; cv=none; b=Rsa7BNECWDfTM0ojXJZTWgr7crqA8e/ZoO42F2VrEkEbRJLAj/Zu713pk9j/AmNCFwNj6T1MyxCGmVeREPAdjFNQJ9T1JgzCw85xYJzYMfv82p2Uh2wRq+Ft49o//435bbeP7X0Qxa9UEz3/WpqYi7qR8IU8PKLE3fu9RyjbAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792828; c=relaxed/simple;
	bh=/nCt3yYubsqf0KYHoUtLdkp0TQwTvmkyUbrTyciVsvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HTxrsothHarDlAiTM9q10UlSqgTluI9K2vQ2lhoBLtdXW64w4HPIdn1bTrV8rqTqxZl61MwqnKfGMpUNdqdoXfCf11Qa77bvo/wKwQH4BtBoDTiv+3bYLzB25wXrRIzhzpssaXF8wpzEv9/Zzje/neq+Z+bg+G32bf/q3maRBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=fxlPIQ7x; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 790BB14807F6;
	Tue,  2 Sep 2025 08:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756792816; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=/+fDJbS7gRZJNUAGRDP5IS2JtRY0a2+P5vA2nvVqsWA=;
	b=fxlPIQ7xNAv1G/CNB9CsJYRDIGRjirfueZNta3gLCMc9c+Vj2f44ZlZfm/ookhAsfp6Nud
	TnDpkXXLaZtl4ZSCW+6CWxV/MxGUmysVHoTtfaKobIaVNKFXaiG/SlEp3NoV02ejNIyP3I
	2sjnMB+DdL0QrG6a+SLa4ZzjVSgKLfDKIe30NE9KFKtlfcDvavXvCWss0TyHwIxQU+1xE6
	JqZDY+A7oHk5eKqM/Fz7Qypur2eE6bS7U3PUIieClhmaEQkEx0pIkDLGiCpPtHCpjZKvgv
	sIDsXhw6dduyezmAdZMTjJ5dwo+97jVdzaf6iXsmTsTtWo3+xBJ4EjswrzPBrw==
Date: Tue, 2 Sep 2025 08:00:11 +0200
From: Alexander Dahl <ada@thorsis.com>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: State of the UBI fastmap feature
Message-ID: <20250902-yarn-from-020874b4da63@thorsis.com>
Mail-Followup-To: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

after using UBI for almost 15 years now without fastmap, I'm currently
experimenting with that feature.  The help text in Kconfig menu
(drivers/mtd/ubi/Kconfig) still says "Experimental feature" and
further down:

> Important: this feature is experimental so far and the on-flash
> format for fastmap may change in the next kernel versions

Is this still the current state?  I can not remember seing any patches
touching fastmap in the last time.  Are there plans to stabilize this?
Will there be changes in the on-flash format?  Do folks even use this
feature?  In production?

Happy to get some opinions here.

Greets
Alex


