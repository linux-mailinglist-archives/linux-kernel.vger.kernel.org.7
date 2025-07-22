Return-Path: <linux-kernel+bounces-741600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7256B0E66A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C95D3BA4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90C1AB6F1;
	Tue, 22 Jul 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoZjtG5X"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424C27D781
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223249; cv=none; b=H6j1eBZP0uukbZ6VzEnBkhjtOztBkrK+OoTqckxh6ouwja1yYCa5UPHgrBJVB7Zi9gdJ4fu3waaxnajUNFTvx2DjQncg99BKY5Xcf6fU2nbk7G6ev5jVfUyDf3vPYnVlnjDNXzetMOTOwrUsZo55glokjvbIWnXrWcBoS+7SY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223249; c=relaxed/simple;
	bh=mb4kKTr2b2SV59aU/jYfBTXhmbecwaKvdvs8GM35uqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kz5Q5EvlY5cnxhSVicljG5XDYe139pokxwPDkBkGMEMuO0d4edg2s7nXrTKNxhiVJESKbh9w1bZXscKLVIR4/Yvb77PBFOg9+DmsuIDIv47sh4WQ5vuHv0hTtN+q/Sl9LopFLACabQoA5XJvCk5UiZULhMv8ehAaVHZk0RjnzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoZjtG5X; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31220ecc586so5655896a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753223247; x=1753828047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb4kKTr2b2SV59aU/jYfBTXhmbecwaKvdvs8GM35uqg=;
        b=KoZjtG5XiImMQQOtLEMdnLQ18qvw+btRKfeO+vCQVdORjgucQHPpnxNEOxWqVbzmSK
         imHqs2XomCY2jddhJonEiAvIjz8DK9G51v1RfmdSf9m10qPYrauUCTKSqGGZ+zjv8TRX
         xQ229OagEnUk2/u+zCFdAkwwvL8u6kDFSsGPWMDBo+Fm+iDgkCvNJBdRKSwGdcs72hz+
         MnADrBHYVj2YepqdkHYFmH/pDain7w7ijMKRjCi1i1NYSCwD8I3r907L45L7r7yuGi0E
         85+EFGXzSJ8AcRjK5qQC91dDifR8jpizEGJzCPAODC39bgbLijC4bFwPDDODdOcMdxiq
         aTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753223247; x=1753828047;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mb4kKTr2b2SV59aU/jYfBTXhmbecwaKvdvs8GM35uqg=;
        b=GPZ9EgI4ICR+/+YA1i3yC26bJ16uf1v4YksMPgXLJrMxIs52g6P1qUosiQ3p5bVRa0
         lFr6gwoZcm9/FsKGBo1ahz8nIfkezhLDSevmmfoLOyzCjemZq5QW7xyHOgsiEpiu60Sx
         ULSMoRol5NTyKY2D1LTySWZ1i271qdewzqsiQ9A1eILieReS/yoFEITa5fs1WJJ6D/sX
         yJXbLeyEVvB7tqjyunfo1Jt+fRsFOukHcwoBcpRhWOZryeJevJ5ZDoevY2Vo4NsIYkO2
         jIarJ/b0Sn4md7O2ZvIBmVm1EiNaNW49EPzLjccJWDpM3NqRcwq4LIMAxyMUd/6P6uPk
         pGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRSUZcdYb8WFi4DCVNGd9aiw6tZmwQkIrPi+ud9NUjw+2tqW+ZsnL3BYeEUslnUb14cH6lbztjRUIm2OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYN1buTcpWbsrwpK4VCeOUHCX93S02IQ18H5lWVohhjfFXDHpZ
	OkY9owPSHWDgweJm6X8WH3uzQ+yfyZ2Ngk2ly8cnb17SaeRompNsVcbmdp6upXInbMJMk+eitXA
	JFeALmSELvA==
X-Google-Smtp-Source: AGHT+IHdtzMNdz7v/eZVyhMXcY5p63zKcUoUhYPBqTUBbkO9Ow+dJHxndxUnQJPdWqaO1hNSSqMcGmPDkvj2
X-Received: from pjboh11.prod.google.com ([2002:a17:90b:3a4b:b0:312:e914:4548])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e83:b0:312:e1ec:de44
 with SMTP id 98e67ed59e1d1-31e507dc9e6mr1264437a91.27.1753223247203; Tue, 22
 Jul 2025 15:27:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:27:25 -0700
In-Reply-To: <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com> (Chen
 Ridong's message of "Thu, 17 Jul 2025 21:52:38 +0800")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714050008.2167786-2-ynaffit@google.com> <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8jz3zamk2.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgUmluZG9uZywNCg0KQ2hlbiBSaWRvbmcgPGNoZW5yaWRvbmdAaHVhd2VpY2xvdWQuY29tPiB3
cml0ZXM6DQoNCj4gT24gMjAyNS83LzE3IDIwOjU2LCBNaWNoYWwgS291dG7DvSB3cm90ZToNCj4+
IEhlbGxvIFRpZmZhbnkuDQoNCj4+IE9uIFN1biwgSnVsIDEzLCAyMDI1IGF0IDEwOjAwOjA5UE0g
LTA3MDAsIFRpZmZhbnkgWWFuZyAgDQo+PiA8eW5hZmZpdEBnb29nbGUuY29tPiB3cm90ZToNCg0K
Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2dyb3VwLXYyLnJzdA0KPj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2dyb3VwLXYyLnJzdA0KPj4+IEBAIC0xMDE4
LDYgKzEwMTgsMTQgQEAgQWxsIGNncm91cCBjb3JlIGZpbGVzIGFyZSBwcmVmaXhlZCB3aXRoICJj
Z3JvdXAuIg0KPj4+ICAgCWl0J3MgcG9zc2libGUgdG8gZGVsZXRlIGEgZnJvemVuIChhbmQgZW1w
dHkpIGNncm91cCwgYXMgd2VsbCBhcw0KPj4+ICAgCWNyZWF0ZSBuZXcgc3ViLWNncm91cHMuDQoN
Cj4+PiArICBjZ3JvdXAuZnJlZXplLnN0YXQNCg0KPj4gV2l0aCB0aGUgZ2l2ZW4gaW1wbGVtZW50
YXRpb24gKGFuZCB1c2Ugc2NlbmFyaW8pLCB0aGlzJ2QgYmV0dGVyIGV4cG9zZWQNCj4+IGluDQo+
PiAgICBjZ3JvdXAuZnJlZXplLnN0YXQubG9jYWwNCg0KDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxl
IHRvIGFkZCB0aGlzIGZpZWxkIHRvIGVpdGhlciBjZ3JvdXAuZXZlbnQgb3IgIA0KPiBjZ3JvdXAu
c3RhdD8NCj4gU2luY2UgdGhlIGZyb3plbiBzdGF0dXMgaXMgYWxyZWFkeSB0cmFja2VkIGluIGNn
cm91cC5ldmVudCwgdGhpcyAgDQo+IHBsYWNlbWVudCB3b3VsZCBtYWludGFpbiBiZXR0ZXINCj4g
Y29oZXNpb24gd2l0aCBleGlzdGluZyBtZXRyaWNzLg0KDQo+IFRoaXMgaXMganVzdCBhIHN1Z2dl
c3Rpb24uDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBSaWRvbmcNCg0KVGhhbmtzIGZvciB0YWtpbmcg
YSBsb29rIQ0KDQpJIGRvbid0IHRoaW5rIHRoaXMgd291bGQgKnF1aXRlKiBmaXQgaW4gY2dyb3Vw
LmV2ZW50IGJlY2F1c2Ugd2UncmUNCm1lYXN1cmluZyB3aGVuIHRoZSBjZ3JvdXAgYmVnaW5zIGZy
ZWV6aW5nIGluc3RlYWQgb2Ygd2hlbiBpdCByZWFjaGVzIHRoZQ0KZnJvemVuIHN0YXRlLiBJIGFs
c28gd29ycnkgdGhhdCBoYXZpbmcgdGhlIHZhbHVlIHNvIGNsb3NlIHRvDQpjZ3JvdXAuZnJvemVu
IHdvdWxkIGNhdXNlIGFkZGl0aW9uYWwgY29uZnVzaW9uIGFib3V0IGl0cw0KbWVhbmluZy4gY2dy
b3VwLnN0YXQgc2VlbXMgcmVhc29uYWJsZSwgYnV0IHRoZSB2YWx1ZXMgaW5zaWRlIGFwcGVhciB0
bw0KYmUgYWNjb3VudGVkIGZvciBoaWVyYXJjaGljYWxseSwgd2hpY2ggd291bGRuJ3Qgc3VpdCBv
dXIgdXNlIGNhc2UuDQoNCi0tIA0KVGlmZmFueSBZLiBZYW5nDQo=

