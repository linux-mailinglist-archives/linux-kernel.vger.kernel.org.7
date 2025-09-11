Return-Path: <linux-kernel+bounces-811674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79EB52C61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9177AC222
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26C2E6CC0;
	Thu, 11 Sep 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DkTvEnnk"
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB0329F09
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581156; cv=none; b=cHFag3MQLqj+S3wfvxvK3UfzDE13Q02D+nbG29u3wuA5jcE+dCeKmnxfG2NtnqllteWNDgWhgHYB12qwnPdVwdLM2r6pkB6+Zmkz9cgacx2GlEZT0YC8y3t5f0gga6hcGPYSl/W8X/Ut4mVRxFbq/jJSF1ic5/JqpM2sE84y38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581156; c=relaxed/simple;
	bh=lPFuFth3LtF8PyqQ8PKRH72fHpUv6OJSmDx6KuEGzBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLKMu77KA4tob70/3qg1cdmzrT/4I+08vVpMbcGtVJeLPhMIdGkT1PC/PiiI/AXLrLEJV9Fs2h8GFfetkTWXkS15crZfNcLaPah9tSqZjelVSScwy+WuEAQ+GTaBWEYih2clZVBENvGlZNCPtyw+7Vn0A+vVX5g+/O1CvJ5CZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DkTvEnnk; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757581154; x=1789117154;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lPFuFth3LtF8PyqQ8PKRH72fHpUv6OJSmDx6KuEGzBs=;
  b=DkTvEnnk0Y/SU40Yg98GlDUMBJnxbrU0zoLX+epr1Bs79kh39h8pp2SS
   39/8hCsDgGBCIB0Y5T8mNUtN2UGwuxlyAkrNjhpPMHsySIUwIDnDvR+U0
   NkR5hbVlfYZLk+uGn1lZSLmt1pEHCHGopb7GGCtUAPRXiSvfIdPYDfWyR
   tUYQ/AyqULJa5dx8dfe9zCxH7xIez0U6J15JPkqO7xr5LCMKLYWu24gPo
   XThHaBQuhW1W2xBSLkZ0GrECyZ1xy3zul/eF+W1eGta5YCr1frIHdI3Gk
   8nJSAVODaQIt8CRliKPSjgQHm50keA4z9jgH1PRom1eyFoNnuZJzt2cyF
   g==;
X-CSE-ConnectionGUID: WyJJCXoYSCKMoBKbF3Acuw==
X-CSE-MsgGUID: 18Z5O92mQ3y9x9lfjoiWCg==
X-IronPort-AV: E=Sophos;i="6.18,256,1751241600"; 
   d="scan'208";a="1845391"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 08:59:03 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:23756]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.48:2525] with esmtp (Farcaster)
 id 27f1d6e4-4f82-4887-8615-0403675c2ebb; Thu, 11 Sep 2025 08:59:03 +0000 (UTC)
X-Farcaster-Flow-ID: 27f1d6e4-4f82-4887-8615-0403675c2ebb
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 08:59:03 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.110) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 08:58:57 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] sched/fair: use cpumask_weight_and() in sched_balance_find_dst_group()
Date: Thu, 11 Sep 2025 10:58:39 +0200
Message-ID: <175758085303.159541.15261282962506645321.b4-ty@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911034454.494852-1-yury.norov@gmail.com>
References: <20250911034454.494852-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Transfer-Encoding: base64

T24gV2VkLCAxMCBTZXAgMjAyNSAyMzo0NDo1MiAtMDQwMCwgWXVyeSBOb3JvdiB3cm90ZToKPiBJ
biB0aGUgZ3JvdXBfaGFzX3NwYXJlIGNhc2UsIHRoZSBmdW5jdGlvbiBjcmVhdGVzIGEgdGVtcG9y
YXJ5IGNwdW1hc2sKPiB0byBqdXN0IGNhbGN1bGF0ZSB3ZWlnaHQgb2YgKHAtPmNwdXNfcHRyICYg
c2NoZWRfZ3JvdXBfc3Bhbihsb2NhbCkpLgo+Cj4gV2UndmUgZ290IGEgZGVkaWNhdGVkIGhlbHBl
ciBmb3IgaXQuCj4KPgoKTEdUTQoKUmV2aWV3ZWQtYnk6IEZlcm5hbmQgU2llYmVyIDxzaWViZXJm
QGFtYXpvbi5jb20+CgotLQpUaGFua3MsCkZlcm5hbmQKCgoKQW1hem9uIERldmVsb3BtZW50IENl
bnRyZSAoU291dGggQWZyaWNhKSAoUHJvcHJpZXRhcnkpIExpbWl0ZWQKMjkgR29nb3NvYSBTdHJl
ZXQsIE9ic2VydmF0b3J5LCBDYXBlIFRvd24sIFdlc3Rlcm4gQ2FwZSwgNzkyNSwgU291dGggQWZy
aWNhClJlZ2lzdHJhdGlvbiBOdW1iZXI6IDIwMDQgLyAwMzQ0NjMgLyAwNwo=


