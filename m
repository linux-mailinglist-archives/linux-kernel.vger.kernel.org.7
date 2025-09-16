Return-Path: <linux-kernel+bounces-819199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB2B59CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2497C2A38F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3D280014;
	Tue, 16 Sep 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ep1/oysy"
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334925B1D2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038475; cv=none; b=RLMa1kC2YkD+IRzKFl9krK1cnqWP5HqNgFagojwpPCfWXlfHuqAfAGx7cTIAxId3s/znxQvuPzxOSBM51JvKfwgbySNqpNlzTmgcWvSiBcgVzLh1EQy7n2IBFJ3m2ZfWarQnGbeLis7HNbVlNPfGj/kxK/i8TR3tL2vsbxzKMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038475; c=relaxed/simple;
	bh=hpUw8W5+cnm9fvCvLxzyMXjefa4TjV1m+7m1d3xJMyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qps7NIn2C6Bpe34EQMuYw4Pi8PJ5/HEde0olTqjLyKwT2uJvaVHUxWWYgcxHnThW0h/OVRdwNZbpskYKcvSnba/ngRe86X1NIpxJIFgJc6mTSDbPASlUoHXZNGbvY4Zk9TCAAn5jnuhzraCj83A7e0TU5LAOwKyNF/fz2wLLoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ep1/oysy; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758038473; x=1789574473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpUw8W5+cnm9fvCvLxzyMXjefa4TjV1m+7m1d3xJMyU=;
  b=Ep1/oysyaX2gJzjHZ+3NKQ+Y8yWE472FVlQXkQn/Az9TyIQE6+hfP1R+
   M7cTLg3Vm3Y5TtSc2r4sOEhXydzrULijZGVcNFQ702wilHjuXWT8zI6q0
   +VrKtp/Adcibn7+KVfLj17+l+tZuZOHJj1M9RF3/LlefdZqyGAQoEtj4L
   hbOnSaJycmQbew/POhyk+mEB+kOYLgaLpIEXW9zhiN4CrP2ZpFVXBV5Qi
   xWdSaPN38PBJGSUJDZ9oNk1Yc8vBxOa3cfZaEhp2kvZv3ikUFXE4sINQQ
   I78pbb2VKI2fZH59JThCBtwbHvlBYYs9hEDxym8TpU+0qS3ssbdFFvwUN
   g==;
X-CSE-ConnectionGUID: OSCbBS2fQUK/Eg8hSZOMfw==
X-CSE-MsgGUID: izjZ7urrTy2YhIcaCOlGvg==
X-IronPort-AV: E=Sophos;i="6.18,269,1751241600"; 
   d="scan'208";a="2200005"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 16:01:03 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:9521]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.36.68:2525] with esmtp (Farcaster)
 id 2912b711-80ed-42fa-9ad3-79858e40f9d0; Tue, 16 Sep 2025 16:01:03 +0000 (UTC)
X-Farcaster-Flow-ID: 2912b711-80ed-42fa-9ad3-79858e40f9d0
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 16:01:02 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.227) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 16:00:55 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <sieberf@amazon.com>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <dwmw@amazon.co.uk>,
	<graf@amazon.com>, <jschoenh@amazon.de>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<tanghui20@huawei.com>, <vincent.guittot@linaro.org>,
	<vineethr@linux.ibm.com>, <wangtao554@huawei.com>, <zhangqiao22@huawei.com>
Subject: Re: [PATCH v2] sched/fair: Forfeit vruntime on yield
Date: Tue, 16 Sep 2025 18:00:35 +0200
Message-ID: <20250916160036.584174-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916140228.452231-1-sieberf@amazon.com>
References: <20250916140228.452231-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWZ0ZXIgZnVydGhlciB0ZXN0aW5nIEkgdGhpbmsgd2Ugc2hvdWxkIHN0aWNrIHdpdGggdGhlIG9y
aWdpbmFsIGFwcHJvYWNoIG9yCml0ZXJhdGUgb24gdGhlIHZydW50aW1lIGZvcmZlaXRpbmcuCgpU
aGUgdnJ1bnRpbWUgZm9yZmVpdGluZyBkb2Vzbid0IHdvcmsgd2VsbCB3aXRoIGNvcmUgc2NoZWR1
bGluZy4gVGhlIGNvcmUKc2NoZWR1bGVyIHBpY2tzIHRoZSBiZXN0IHRhc2sgYWNyb3NzIHRoZSBT
TVQgbWFzaywgYW5kIHRoZW4gdGhlIHNpYmxpbmdzIHJ1biBhCm1hdGNoaW5nIHRhc2sgbm8gbWF0
dGVyIHdoYXQuIFRoaXMgbWVhbnMgdGhlIGNvcmUgc2NoZWR1bGVyIGNhbiBrZWVwIHBpY2tpbmcK
dGhlIHlpZWxkaW5nIHRhc2sgb24gdGhlIHNpYmxpbmcgZXZlbiBhZnRlciBpdCBiZWNvbWVzIGlu
ZWxpZ2libGUgKGJlY2F1c2UgaXQncwpwcmVmZXJyYWJsZSB0aGFuIGZvcmNlIGlkbGUpLiBJbiB0
aGlzIHNjZW5hcmlvIHRoZSB2cnVudGltZSBvZiB0aGUgeWllbGRpbmcKdGFzayBydW5zIGF3YXkg
cmFwaWRseSwgd2hpY2ggY2F1c2VzIHByb2JsZW1hdGljIGltYmFsYW5jZXMgbGF0ZXIgb24uCgpQ
ZXJoYXBzIGFuIGFsdGVybmF0aXZlIGlzIHRvIGZvcmZlaXQgdGhlIHZydW50aW1lIChzZXQgaXQg
dG8gdGhlIGRlYWRsaW5lKSwgYnV0Cm9ubHkgb25jZS4gSS5lIGRvbid0IGRvIGl0IGlmIHRoZSB0
YXNrIGlzIGFscmVhZHkgaW5lbGlnaWJsZT8gSWYgdGhlIHRhc2sgaXMKaW5lbGlnaWJsZSB0aGVu
IHdlIHNpbXBseSBpbmNyZW1lbnQgdGhlIGRlYWRsaW5lIGFzIGluIG15IG9yaWdpbmFsIHBhdGNo
PwoKUGV0ZXIsIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMgb24gdGhpcy4KClRlc3RpbmcgZGF0
YSBiZWxvdyBzaG93aW5nIHRoZSB2cnVudGltZSBmb3JmZWl0IHlpZWxkcyBiYWQgbWF4IHJ1biBk
ZWxheXM6CnZydW50aW1lIGZvcmZlaXQ6CuKAoiAqKnlpZWxkX2xvb3AqKjogNC4zN3MgcnVudGlt
ZSwgbWF4IGRlbGF5IDI3Mi45OW1zCuKAoiAqKmJ1c3lfbG9vcCoqOiAxMy41NHMgcnVudGltZSwg
bWF4IGRlbGF5IDU1Mi4wMW1zCgpkZWFkbGluZSBjbGFtcDosCuKAoiAqKmJ1c3lfbG9vcCoqOiA5
LjI2cyBydW50aW1lLCBtYXggZGVsYXkgNC4xMW1zCuKAoiAqKnlpZWxkX2xvb3AqKjogOS4yNXMg
cnVudGltZSwgbWF4IGRlbGF5IDcuNzdtcwoKVGVzdCBwcm9ncmFtOgojZGVmaW5lIFBSX1NDSEVE
X0NPUkVfU0NPUEVfVEhSRUFEIDAKI2RlZmluZSBQUl9TQ0hFRF9DT1JFX1NDT1BFX1RIUkVBRF9H
Uk9VUCAxCiNlbmRpZgoKI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNs
dWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVkZSA8c3RkbGliLmg+
CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKSB7CiAgICBpbnQgc2hvdWxkX3lpZWxk
ID0gKGFyZ2MgPiAxKSA/IGF0b2koYXJndlsxXSkgOiAxOwogICAgdGltZV90IHByb2dyYW1fc3Rh
cnQgPSB0aW1lKE5VTEwpOwoKICAgIC8vIENyZWF0ZSBjb3JlIGNvb2tpZSBmb3IgY3VycmVudCBw
cm9jZXNzCiAgICBwcmN0bChQUl9TQ0hFRF9DT1JFLCBQUl9TQ0hFRF9DT1JFX0NSRUFURSwgMCwg
UFJfU0NIRURfQ09SRV9TQ09QRV9USFJFQUQsIDApOwoKICAgIHBpZF90IHBpZCA9IGZvcmsoKTsK
CiAgICBpZiAocGlkID09IDApIHsKICAgICAgICAvLyBDaGlsZDogeWllbGQgZm9yIDVzIHRoZW4g
YnVzeSBsb29wIChpZiBzaG91bGRfeWllbGQgaXMgMSkKICAgICAgICBpZiAoc2hvdWxkX3lpZWxk
KSB7CiAgICAgICAgICAgIHRpbWVfdCBzdGFydCA9IHRpbWUoTlVMTCk7CiAgICAgICAgICAgIHdo
aWxlICh0aW1lKE5VTEwpIC0gc3RhcnQgPCA1ICYmIHRpbWUoTlVMTCkgLSBwcm9ncmFtX3N0YXJ0
IDwgMzApIHsKICAgICAgICAgICAgICAgIHNjaGVkX3lpZWxkKCk7CiAgICAgICAgICAgIH0KICAg
ICAgICB9CiAgICAgICAgd2hpbGUgKHRpbWUoTlVMTCkgLSBwcm9ncmFtX3N0YXJ0IDwgMzApIHsK
ICAgICAgICAgICAgLy8gYnVzeSBsb29wCiAgICAgICAgfQogICAgfSBlbHNlIHsKICAgICAgICAv
LyBQYXJlbnQ6IHNoYXJlIGNvb2tpZSB3aXRoIGNoaWxkLCB0aGVuIGJ1c3kgbG9vcAogICAgICAg
IHByY3RsKFBSX1NDSEVEX0NPUkUsIFBSX1NDSEVEX0NPUkVfU0hBUkVfVE8sIHBpZCwgUFJfU0NI
RURfQ09SRV9TQ09QRV9USFJFQUQsIDApOwogICAgICAgIHdoaWxlICh0aW1lKE5VTEwpIC0gcHJv
Z3JhbV9zdGFydCA8IDMwKSB7CiAgICAgICAgICAgIC8vIGJ1c3kgbG9vcAogICAgICAgIH0KICAg
IH0KCiAgICByZXR1cm4gMDsKfQoKUmVwcm86CnRhc2tzZXQgLWMgMCwxIGNvcmVfeWllbGRfbG9v
cCAxICYgICNhcmcgMSA9IGRvIHlpZWxkCnRhc2tzZXQgLWMgMCwxIGNvcmVfeWllbGRfbG9vcCAw
ICYgICNhcmcgMCA9IGRvbid0IHlpZWxkCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50cmUgKFNv
dXRoIEFmcmljYSkgKFByb3ByaWV0YXJ5KSBMaW1pdGVkCjI5IEdvZ29zb2EgU3RyZWV0LCBPYnNl
cnZhdG9yeSwgQ2FwZSBUb3duLCBXZXN0ZXJuIENhcGUsIDc5MjUsIFNvdXRoIEFmcmljYQpSZWdp
c3RyYXRpb24gTnVtYmVyOiAyMDA0IC8gMDM0NDYzIC8gMDcK


