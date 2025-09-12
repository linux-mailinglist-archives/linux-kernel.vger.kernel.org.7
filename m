Return-Path: <linux-kernel+bounces-814163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27454B5501A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D844C179D05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B230DEDA;
	Fri, 12 Sep 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="sa6MSrf6"
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4F14EC62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685302; cv=none; b=TV/aWkaptvHd7QiazAyizcccxzh7g3bkYpdMlzUeg4xDNazj+8tKfEGiNGYy3CNN7uOCKqHMhQaFw9CZdfOOwEmTQaY8sI/rABy152Xv/YhsYsPFi3CRfvjIGbBZhUXtZtLgXx+Egbwi6cCsmVEpTNbyP2AbD18Rm+EgKsEoryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685302; c=relaxed/simple;
	bh=BfXHVYB4E7rZReFJ1D/SFGvpBVucWgNW19iT4trRXJQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzatz8JPHfMDFhw8SkAOjSR4Uv2GAZrMKYXmenZfmUqJmsLEyixc5NO7Yl6/MXLDeZymzPn1N3ILBj4d3OLomAUdVPVCMYLqx7A/RK43Zoqm3m73IEFRqKtJFhAjjNKnrEkEEOUE23xBu05iYprY+a6cqj4FBAMopGr2JCA24q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=sa6MSrf6; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1757685300; x=1789221300;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BfXHVYB4E7rZReFJ1D/SFGvpBVucWgNW19iT4trRXJQ=;
  b=sa6MSrf65lme64jjEgnpg7rJPaqW09IyVo4nz7H7wQqh/UcMHuEEYDFk
   0NtZ2CqAd3n2WLBFRlxmFgepz88EKHCcg9+ILnivLH7F0N2lMcmZM/xij
   7uSZMhsVvKEcBswOHtfpmQgRObVukD7nOs11yc7iZQ506SBb8JTTd9nTc
   4QW8270i53ouehv5WyTsGiT37gGqLWERK5R91pNM97znIruQmoJE5QmuZ
   PPudPpbh1dxYKlat+51rw26pllRSeYc2L5vJaNWsGDt/SfGn0BhLMyiFm
   KNIQdQb96Kz2hE5Y1Kw8eHKyeqDd19Ka1m4uv6Zo1EHKxkl+uqWVEmyLS
   A==;
X-CSE-ConnectionGUID: 6yKoZLNvTaCBFw5Ks/mIHA==
X-CSE-MsgGUID: tcwdF41DQf2Sb9uosIc/Jw==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2904342"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 13:54:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:34317]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.200:2525] with esmtp (Farcaster)
 id 5f3a8b00-0010-4fb6-b6d0-bca8230ba671; Fri, 12 Sep 2025 13:54:57 +0000 (UTC)
X-Farcaster-Flow-ID: 5f3a8b00-0010-4fb6-b6d0-bca8230ba671
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 13:54:40 +0000
Received: from dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com
 (10.13.232.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 13:54:37 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Helge Deller <deller@gmx.de>, "Liam R. Howlett"
	<Liam.Howlett@Oracle.com>, Simon Liebold <lieboldsimonpaul@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: lower MAP_32BIT begin to reduce heap collisions
Date: Fri, 12 Sep 2025 13:54:36 +0000
Message-ID: <h6liptt17wzc3.fsf@dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)





Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


