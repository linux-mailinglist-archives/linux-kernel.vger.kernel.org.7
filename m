Return-Path: <linux-kernel+bounces-783894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A8B333EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7D3B8028
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10A222DFB5;
	Mon, 25 Aug 2025 02:28:49 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633B393DCC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088929; cv=none; b=F0gabe6Ut13EgnpvIzSmPtPKkqszjDLtlpP9ws19LT5vjtF0AshbnAsd2thUVyqVU1Vf8Vb+fvRUDHSR/g5TxLYSIWCpHpDeij3m50O5liL/XzuuhwV+rkPPQqVGnW+5gTOkNpBs+YfJ+hh5QiEQ7oWmvgUYwin72nvG1Z7mLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088929; c=relaxed/simple;
	bh=7fCCuMgtgCwFugKYlGknU1YQmGykr3blxZBGdiTWGqk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b946mro6Ceemsjw4A+DywcSrbJSeNQckFqGQllZfjG0Wv4DbbVT4eRIgWOTefxBAkYFhKMv+0aE5/+X2u48sQzUZevxryPIDHQ7OCaBJvOdKFPdfXlGlDMcAL6YouVECHYBWwotI+/O/biBQ+XhrCoM9AETVmi35sSaFS2YjcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "osalvador@suse.de"
	<osalvador@suse.de>, "Xu,Wenjie(ACG CCN)" <xuwenjie04@baidu.com>
Subject: RE:  Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Thread-Topic: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
Thread-Index: AdwVZvlMyZG+t/+FSoO+KsNcdGLEBA==
Date: Mon, 25 Aug 2025 02:27:58 +0000
Message-ID: <5516a0e446294c158492c410100f4bc9@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.14
X-FE-Policy-ID: 52:10:53:SYSTEM

PiANCj4gSGkgdGhlcmUuIFRoZSA5MCUgc3BsaXQgaXMgc29saWQuIFdvdWxkIGl0IG1ha2Ugc2Vu
c2UgdG8gKGEpIGxvZyBhIG9uZS10aW1lDQo+IHdhcm5pbmcgaWYgdGhlIHNlY29uZCBwYXNzIGlz
IHRyaWdnZXJlZCwgc28gb3BlcmF0b3JzIGtub3cgd2h5IGJvb3Qgc2xvd2VkLA0KDQpPaw0KDQo+
IGFuZCAoYikgbWFrZSB0aGUgOTAlIGNhcCBhIEtjb25maWcgZGVmYXVsdCByYXRpbywgc28gZGlz
dHJvcyBjYW4gbG93ZXIgaXQNCj4gd2l0aG91dCBwYXRjaGluZz8gQm90aCBhcmUgbG93LXJpc2sg
YW5kIGRvbuKAmXQgY2hhbmdlIHRoZSBBQkkNCj4NCg0KSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8g
YWRkIGEgY21kbGluZSBvcHRpb24NCg0KLUxpDQoNCg0K

