Return-Path: <linux-kernel+bounces-762237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D1B203D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B4C3A8336
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC772DE6E2;
	Mon, 11 Aug 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="Kn8LIF4a"
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EF9EA2D94AF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904857; cv=none; b=Pg2sqJxPnqv6QMirQpcx1v9bJk1/VnaokHa09msfsOz5irTVMaAxKbP0HKc+TmhBfc4oYPkEUKppyuTHEJ0Oti9qh+AR5ahLD0ExgYX9K5z/BlRj9EPO+4FFr7muQBuk6kcQrAtWF2a2pAtYs3a9JkbDYTEW7br+x1MjWDCA0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904857; c=relaxed/simple;
	bh=ymjq4f0feFEXVmBppl/K9K9Sf2wMwD/Qx6rX26sVtB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=DuOEB7wzp+t9bw8hKWhDkXyrQ9a6b4JAeA1gVstRneDcipYv2kvmdZkY0r5y2xDQynijXvH7pr0DvWbPqvGp7Efkqo0kO3pTr9nw10b6EdWnyERLyisZahW5iFN3nDSiOtUsxaEfoe+AZ0VWIQwjYWxlVyRFwNsxtdOhgTx6BUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=Kn8LIF4a; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.20])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id C37A8198EB986E;
	Mon, 11 Aug 2025 17:30:19 +0800 (CST)
Received: from BJ01-ACTMBX-07.didichuxing.com (10.79.64.14) by
 BJ01-ACTMBX-01.didichuxing.com (10.79.64.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 17:31:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ01-ACTMBX-07.didichuxing.com (10.79.64.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 17:31:00 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Mon, 11 Aug 2025 17:31:00 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.64.20
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.sang@intel.com" <oliver.sang@intel.com>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH 2/2] drm/i915: Fix incorrect error handling in shmem_pwrite()
Thread-Topic: [PATCH 2/2] drm/i915: Fix incorrect error handling in
 shmem_pwrite()
Thread-Index: AQHcCqKmgqLv7STYsk2KonnlWsv+sQ==
Date: Mon, 11 Aug 2025 09:31:00 +0000
Message-ID: <20250811093050.38930-2-chentaotao@didiglobal.com>
In-Reply-To: <20250811093050.38930-1-chentaotao@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1754904622;
	bh=ymjq4f0feFEXVmBppl/K9K9Sf2wMwD/Qx6rX26sVtB4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Kn8LIF4aWmOfrVkGRWP3vpe9W8taNhIXfAk3cKHNXBXEUWrbOtZa7gAjNdt2R8iu+
	 bQROw/XVOcZ39MoECD11ALGKtGQKvjcuKxwBI3kBizJU/onMeyYaLAIx16jhuN6cm1
	 /86j5hFfIj9XbKy/GV0c3SBNOjg+QU+MUVldgHg8=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCnNobWVtX3B3
cml0ZSgpIGN1cnJlbnRseSBjaGVja3MgZm9yIHNob3J0IHdyaXRlcyBiZWZvcmUgbmVnYXRpdmUg
ZXJyb3INCmNvZGVzLCB3aGljaCBjYW4gb3ZlcndyaXRlIHJlYWwgZXJyb3JzIChlLmcuLCAtRUZC
SUcpIHdpdGggLUVJTy4NClJlb3JkZXIgdGhlIGNoZWNrcyB0byByZXR1cm4gbmVnYXRpdmUgZXJy
b3JzIGZpcnN0LCB0aGVuIGhhbmRsZSBzaG9ydA0Kd3JpdGVzLg0KDQpGaXhlczogMDQ4ODMyYTNm
NDAwICgiZHJtL2k5MTU6IFJlZmFjdG9yIHNobWVtX3B3cml0ZSgpIHRvIHVzZSBraW9jYiBhbmQg
d3JpdGVfaXRlciIpDQpTaWduZWQtb2ZmLWJ5OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRp
Z2xvYmFsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1l
bS5jIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2Vt
X3NobWVtLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYw0KaW5k
ZXggMmI1M2FhZDkxNWY1Li43MDI1MzJlZWYyMDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
Z2VtL2k5MTVfZ2VtX3NobWVtLmMNCkBAIC00NDEsMTIgKzQ0MSwxMiBAQCBzaG1lbV9wd3JpdGUo
c3RydWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iaiwNCiAJd3JpdHRlbiA9IGZpbGUtPmZfb3At
PndyaXRlX2l0ZXIoJmtpb2NiLCAmaXRlcik7DQogCUJVR19PTih3cml0dGVuID09IC1FSU9DQlFV
RVVFRCk7DQogDQotCWlmICh3cml0dGVuICE9IHNpemUpDQotCQlyZXR1cm4gLUVJTzsNCi0NCiAJ
aWYgKHdyaXR0ZW4gPCAwKQ0KIAkJcmV0dXJuIHdyaXR0ZW47DQogDQorCWlmICh3cml0dGVuICE9
IHNpemUpDQorCQlyZXR1cm4gLUVJTzsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoyLjM0
LjENCg==

