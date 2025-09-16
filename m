Return-Path: <linux-kernel+bounces-818452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F50B591E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DC4189ACB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2678285C88;
	Tue, 16 Sep 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="WHVn/UDh"
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2CFB913D521;
	Tue, 16 Sep 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014164; cv=none; b=V9qiT2fOhOur55oYZ5IIp8t9ZzkPs1RU072S6jGtPG0snEUll4iZvi+qxSKTB0jgioYMZ/TQ3OJZlwQWOlK3rET8jM7Io2w+joQOxo5zeM9ZuMjpPxtCoEKfaW14VAbaAS6yZpg4E7hnhbNG6Cw2/DqXFMngvecwbKgrIf7Qt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014164; c=relaxed/simple;
	bh=vE0FUyT5oH1hcr2hQGwiIk13m1P6obpxXLjw7VqLXqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=O5GyFbmcKH7AJk3Tg0lS49t7aB2y2qs6/5wNK9+Ft4LBQd8MEw6IqJPpBchIJBPc9Tn/1q1fRyflJxqXvXbPPUFwuBzl7jg/FLymhNqC8Mo4cMw7Nr47yVxXWL5qSBtw56EuIHlZEVbgouPz3qTk/dNWv0A9L0DgPm0NF+A+EMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=WHVn/UDh; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 2DD8E1867FB8B3;
	Tue, 16 Sep 2025 17:11:16 +0800 (CST)
Received: from BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Sep 2025 17:12:39 +0800
Received: from BJ02-ACTMBX-01.didichuxing.com ([fe80::3bf1:97df:b93f:7b9a]) by
 BJ02-ACTMBX-01.didichuxing.com ([fe80::3bf1:97df:b93f:7b9a%7]) with mapi id
 15.02.1748.010; Tue, 16 Sep 2025 17:12:39 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To: "wang.yaxin@zte.com.cn" <wang.yaxin@zte.com.cn>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"fan.yu9@zte.com.cn" <fan.yu9@zte.com.cn>, "corbet@lwn.net" <corbet@lwn.net>,
	"bsingharora@gmail.com" <bsingharora@gmail.com>, "yang.yang29@zte.com.cn"
	<yang.yang29@zte.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"jiang.kun2@zte.com.cn" <jiang.kun2@zte.com.cn>, "xu.xin16@zte.com.cn"
	<xu.xin16@zte.com.cn>, "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>,
	"zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH v3] delayaccy/sched: add SOFTIRQ delay
Thread-Topic: [PATCH v3] delayaccy/sched: add SOFTIRQ delay
Thread-Index: AQHcF/3osvkJybP17kqnkBalFYy+0LR6ONoAgBtrQgA=
Date: Tue, 16 Sep 2025 09:12:39 +0000
Message-ID: <C126DFBF-863E-46AB-BD62-A9E720B3E68F@didiglobal.com>
In-Reply-To: <20250830142944929e1M6lffs_PwvPfl7J-R1g@zte.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <13F1C55F83C8894A97D7ADE59C983E49@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1758013881;
	bh=vE0FUyT5oH1hcr2hQGwiIk13m1P6obpxXLjw7VqLXqU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=WHVn/UDh+SVnJhTusjLUM5qeR7XNSQfqd7OVT4DiXtEcLHXs6FhO/75fzMvnqXDeZ
	 Tb/FkVNiAxB5Vd08Xai+AdevqWi4611W2jV56YTt5u0d5sf6JMAAzZzo6OMzySIZBv
	 XA8CdvAVnpk4RsY2uGfjfyVH74JcJo362jzuXZl4=

DQo+PkludHJvIFNPRlRJUlEgZGVsYXksIHNvIHdlIGNhbiBzZXBhcmF0ZSBzb2Z0aXJxIGFzIFNP
RlRJUlEgZGVsYXkNCj4+YW5kIGhhcmRpcnEgYXMge0lSUSAtIFNPRlRJUlF9IGRlbGF5Lg0KPj4N
Cj4+QSB0eXBpY2FsIHNjZW5hcmlvIGlzIHdoZW4gdGFza3MgZGVsYXllZCBieSBuZXR3b3JrLA0K
Pj5pZiB0aGV5IGRlbGF5ZWQgYnkgcnggbmV0IHBhY2tldHMsIGkuZSwgbmV0X3J4X2FjdGlvbigp
LA0KPj5TT0ZUSVJRIGRlbGF5IGlzIGFsbW9zdCBzYW1lIGFzIElSUSBkZWxheTsNCj4+aWYgdGhl
eSBkZWxheWVkIGJ5LCBlLmcsIGJhZCBkcml2ZXIgb3IgYnJva2VuIGhhcmR3YXJlLA0KPj5TT0ZU
SVJRIGRlbGF5IGlzIGFsbW9zdCAwIHdoaWxlIElSUSBkZWxheSByZW1haW5zIGJpZy4NCj4+DQo+
PkV4YW1wbGVzIHRvb2wgdXNhZ2UgY291bGQgYmUgZm91bmQgaW4NCj4+RG9jdW1lbnRhdGlvbi9h
Y2NvdW50aW5nL2RlbGF5LWFjY291bnRpbmcucnN0DQo+Pg0KPj5TaWduZWQtb2ZmLWJ5OiBUaW8g
WmhhbmcgPHRpb3poYW5nQGRpZGlnbG9iYWwuY29tIDxtYWlsdG86dGlvemhhbmdAZGlkaWdsb2Jh
bC5jb20+Pg0KDQoNCj5SZXZpZXdlZC1ieTogV2FuZyBZYXhpbiA8d2FuZy55YXhpbkB6dGUuY29t
LmNuIDxtYWlsdG86d2FuZy55YXhpbkB6dGUuY29tLmNuPj4NCg0KDQo+VGhhbmtzDQo+WWF4aW4N
Cg0KSGkgUGV0ZXIsDQoNCkdlbnRsZSBwaW5nLiBXb25kZXJpbmcgaWYgeW91IGhhdmUgYW55IGZ1
cnRoZXIgY29tbWVudHM/DQoNClRoYW5rcyBmb3IgeW91ciB0aW1lLg0KDQpCZXN0LA0KVGlvIFpo
YW5nDQoNCg==

