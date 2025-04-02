Return-Path: <linux-kernel+bounces-585214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B00A790E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35861171AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282E238D39;
	Wed,  2 Apr 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="FJsoM969"
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2523875A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603172; cv=none; b=n31gfYmod6nwuK7jMdHARpQzGm9gNkXdolPRueixabl/TNniwY5J4ZXsMRqMAoqrhFqfQOPEVPBe/DN3g2rQJoasE/PXXqu/E5wptSAElZ7biiEu1pBEsaw2A2k0fB/oXbPz6TjrE/wJjAOA2A3pyrN2+sswJGf8F6PYXlIS488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603172; c=relaxed/simple;
	bh=LW6r9FmmgL8wgSDH1rANqK2rFnzYBzbw9u9WPWj5At8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hfA4H2MswuVVzCqW0ydewGHMvMwgwK+AUGzsUfuD/tgXPfZIrbt3PDP4uX7cv2cBSyngxwGfsHvBTW2rd/tlPqbPrjSnyDJNiOmsqzIbjOLcf/Yj26Sk2bKpK1eSd59GKPrITE5KZV7jj5dLyD2Gc4WRSgSJqgOd/qTiOn4aj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=FJsoM969; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 532ECOEp031968-532ECOEr031968
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 2 Apr 2025 17:12:24 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 2 Apr
 2025 17:12:25 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 2 Apr 2025 17:12:25 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Felix Kuehling <Felix.Kuehling@amd.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Alex Deucher <alexander.deucher@amd.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH v3] drm/amdkfd: Change svm_range_get_info return type
Thread-Topic: [PATCH v3] drm/amdkfd: Change svm_range_get_info return type
Thread-Index: AQHbo9lC4BY/VWq2e0yOP4nLCPzxPA==
Date: Wed, 2 Apr 2025 14:12:25 +0000
Message-ID: <20250402141219.372650-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/17/2025 9:52:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=LW6r9FmmgL8wgSDH1rANqK2rFnzYBzbw9u9WPWj5At8=;
 b=FJsoM969Fh78xU6SpjBQxzC2WiTfbku1m8KnjnVhzN8HHu3dvLlxZ1Zh5BRhtESs4MFM/f9Okn2s
	38oZrzigKPyv1NVND7bPRHh/wyMJmGHvoT6d5z3QlHp7vbKm/dmYU4JIMZLalA6c86cmjT06SYyn
	kN69oxLJ7Y9d/9s1MoyNCvFMXd70WkMPP0ST5qyqcTuNWGKFoJ6vC9H5oWxFPuDM+KenzvZbSNcr
	JozRUPFdDXNL1SJRG7s2bFJ1U1dt7BNbdnmAsEpbW3h68idMgJ07WlSUtPUUs8LvWE4gj9koLrHG
	7tZuh4dSAND2ux/DbGQUL32kgiwWocdd7PNb9Q==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KU3RhdGljIGFu
YWx5c2lzIHNob3dzIHRoYXQgcG9pbnRlciAic3ZtcyIgY2Fubm90IGJlIE5VTEwgYmVjYXVzZSBp
dCBwb2ludHMNCnRvIHRoZSBvYmplY3QgInN0cnVjdCBzdm1fcmFuZ2VfbGlzdCIuIFJlbW92ZSB0
aGUgZXh0cmEgTlVMTCBjaGVjay4gSXQgaXMNCm1lYW5pbmdsZXNzIGFuZCBoYXJtcyB0aGUgcmVh
ZGFiaWxpdHkgb2YgdGhlIGNvZGUuDQoNCkluIHRoZSBmdW5jdGlvbiBzdm1fcmFuZ2VfZ2V0X2lu
Zm8oKSB0aGVyZSBpcyBubyBwb3NzaWJpbGl0eSBvZiBmYWlsdXJlLg0KVGhlcmVmb3JlLCB0aGUg
Y2FsbGVyIG9mIHRoZSBmdW5jdGlvbiBzdm1fcmFuZ2VfZ2V0X2luZm8oKSBkb2VzIG5vdCBuZWVk
DQphIHJldHVybiB2YWx1ZS4gQ2hhbmdlIHRoZSBmdW5jdGlvbiBzdm1fcmFuZ2VfZ2V0X2luZm8o
KSByZXR1cm4gdHlwZSBmcm9tDQoiaW50IiB0byAidm9pZCIuIA0KDQpTaW5jZSB0aGUgZnVuY3Rp
b24gc3ZtX3JhbmdlX2dldF9pbmZvKCkgaGFzIGEgcmV0dXJuIHR5cGUgb2YgInZvaWQiLiBUaGUN
CmNhbGxlciBvZiB0aGUgZnVuY3Rpb24gc3ZtX3JhbmdlX2dldF9pbmZvKCkgZG9lcyBub3QgbmVl
ZCBhIHJldHVybiB2YWx1ZS4NCkRlbGV0ZSBleHRyYSBjb2RlLg0KDQpGb3VuZCBieSBMaW51eCBW
ZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXkgVmF0b3JvcGluIDxhLnZhdG9yb3BpbkBjcnB0LnJ1Pg0KLS0tDQp2
MSAtPiB2MjogYWxzbyBjaGFuZ2UgcmV0dXJuIHR5cGUgb2Ygc3ZtX3JhbmdlX2dldF9pbmZvKCkg
cGVyIEZlbGl4IEt1ZWhsaW5nIHN1Z2dlc3Rpb24NCnYyIC0+IHYzOiBkZWxldGVkIGV4dHJhIGNv
ZGUgaW4gdGhlIGZ1bmN0aW9uIGtmZF9jcml1X2NoZWNrcG9pbnRfc3ZtKCkNCg0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAgNCArLS0tDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jICAgICB8ICA5ICsrLS0tLS0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaCAgICAgfCAxMSArKysrKy0tLS0tLQ0KIDMgZmlsZXMg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQppbmRleCAxZTlkZDAwNjIwYmYuLmEyMTQ5YWZh
NTgwMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCkBAIC0y
MDM5LDkgKzIwMzksNyBAQCBzdGF0aWMgaW50IGNyaXVfZ2V0X3Byb2Nlc3Nfb2JqZWN0X2luZm8o
c3RydWN0IGtmZF9wcm9jZXNzICpwLA0KIA0KIAludW1fZXZlbnRzID0ga2ZkX2dldF9udW1fZXZl
bnRzKHApOw0KIA0KLQlyZXQgPSBzdm1fcmFuZ2VfZ2V0X2luZm8ocCwgJm51bV9zdm1fcmFuZ2Vz
LCAmc3ZtX3ByaXZfZGF0YV9zaXplKTsNCi0JaWYgKHJldCkNCi0JCXJldHVybiByZXQ7DQorCXN2
bV9yYW5nZV9nZXRfaW5mbyhwLCAmbnVtX3N2bV9yYW5nZXMsICZzdm1fcHJpdl9kYXRhX3NpemUp
Ow0KIA0KIAkqbnVtX29iamVjdHMgPSBudW1fcXVldWVzICsgbnVtX2V2ZW50cyArIG51bV9zdm1f
cmFuZ2VzOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9z
dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KaW5kZXggMTAwNzE3
YTk4ZWMxLi5lYmRiYmI2MjBiMTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfc3ZtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0u
Yw0KQEAgLTQwNzYsOCArNDA3Niw4IEBAIGludCBrZmRfY3JpdV9yZXN0b3JlX3N2bShzdHJ1Y3Qg
a2ZkX3Byb2Nlc3MgKnAsDQogCXJldHVybiByZXQ7DQogfQ0KIA0KLWludCBzdm1fcmFuZ2VfZ2V0
X2luZm8oc3RydWN0IGtmZF9wcm9jZXNzICpwLCB1aW50MzJfdCAqbnVtX3N2bV9yYW5nZXMsDQot
CQkgICAgICAgdWludDY0X3QgKnN2bV9wcml2X2RhdGFfc2l6ZSkNCit2b2lkIHN2bV9yYW5nZV9n
ZXRfaW5mbyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsIHVpbnQzMl90ICpudW1fc3ZtX3JhbmdlcywN
CisJCQl1aW50NjRfdCAqc3ZtX3ByaXZfZGF0YV9zaXplKQ0KIHsNCiAJdWludDY0X3QgdG90YWxf
c2l6ZSwgYWNjZXNzaWJpbGl0eV9zaXplLCBjb21tb25fYXR0cl9zaXplOw0KIAlpbnQgbmF0dHJf
Y29tbW9uID0gNCwgbmF0dHJfYWNjZXNzaWJpbGl0eSA9IDE7DQpAQCAtNDA4OSw4ICs0MDg5LDYg
QEAgaW50IHN2bV9yYW5nZV9nZXRfaW5mbyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsIHVpbnQzMl90
ICpudW1fc3ZtX3JhbmdlcywNCiAJKnN2bV9wcml2X2RhdGFfc2l6ZSA9IDA7DQogDQogCXN2bXMg
PSAmcC0+c3ZtczsNCi0JaWYgKCFzdm1zKQ0KLQkJcmV0dXJuIC1FSU5WQUw7DQogDQogCW11dGV4
X2xvY2soJnN2bXMtPmxvY2spOw0KIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHByYW5nZSwgJnN2bXMt
Pmxpc3QsIGxpc3QpIHsNCkBAIC00MTMyLDcgKzQxMzAsNiBAQCBpbnQgc3ZtX3JhbmdlX2dldF9p
bmZvKHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwgdWludDMyX3QgKm51bV9zdm1fcmFuZ2VzLA0KIA0K
IAlwcl9kZWJ1ZygibnVtX3N2bV9yYW5nZXMgJXUgdG90YWxfcHJpdl9zaXplICVsbHVcbiIsICpu
dW1fc3ZtX3JhbmdlcywNCiAJCSAqc3ZtX3ByaXZfZGF0YV9zaXplKTsNCi0JcmV0dXJuIDA7DQog
fQ0KIA0KIGludCBrZmRfY3JpdV9jaGVja3BvaW50X3N2bShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAs
DQpAQCAtNDE0OSw4ICs0MTQ2LDYgQEAgaW50IGtmZF9jcml1X2NoZWNrcG9pbnRfc3ZtKHN0cnVj
dCBrZmRfcHJvY2VzcyAqcCwNCiAJc3RydWN0IG1tX3N0cnVjdCAqbW07DQogDQogCXN2bXMgPSAm
cC0+c3ZtczsNCi0JaWYgKCFzdm1zKQ0KLQkJcmV0dXJuIC1FSU5WQUw7DQogDQogCW1tID0gZ2V0
X3Rhc2tfbW0ocC0+bGVhZF90aHJlYWQpOw0KIAlpZiAoIW1tKSB7DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3N2bS5oDQppbmRleCA2ZWEyM2M3ODAwOWMuLjAxYzdhNDg3NzkwNCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaA0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5oDQpAQCAtMTg0LDggKzE4NCw4IEBAIHZvaWQg
c2NoZWR1bGVfZGVmZXJyZWRfbGlzdF93b3JrKHN0cnVjdCBzdm1fcmFuZ2VfbGlzdCAqc3Ztcyk7
DQogdm9pZCBzdm1fcmFuZ2VfZG1hX3VubWFwX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYsIGRtYV9h
ZGRyX3QgKmRtYV9hZGRyLA0KIAkJCSB1bnNpZ25lZCBsb25nIG9mZnNldCwgdW5zaWduZWQgbG9u
ZyBucGFnZXMpOw0KIHZvaWQgc3ZtX3JhbmdlX2RtYV91bm1hcChzdHJ1Y3Qgc3ZtX3JhbmdlICpw
cmFuZ2UpOw0KLWludCBzdm1fcmFuZ2VfZ2V0X2luZm8oc3RydWN0IGtmZF9wcm9jZXNzICpwLCB1
aW50MzJfdCAqbnVtX3N2bV9yYW5nZXMsDQotCQkgICAgICAgdWludDY0X3QgKnN2bV9wcml2X2Rh
dGFfc2l6ZSk7DQordm9pZCBzdm1fcmFuZ2VfZ2V0X2luZm8oc3RydWN0IGtmZF9wcm9jZXNzICpw
LCB1aW50MzJfdCAqbnVtX3N2bV9yYW5nZXMsDQorCQkJdWludDY0X3QgKnN2bV9wcml2X2RhdGFf
c2l6ZSk7DQogaW50IGtmZF9jcml1X2NoZWNrcG9pbnRfc3ZtKHN0cnVjdCBrZmRfcHJvY2VzcyAq
cCwNCiAJCQkgICAgdWludDhfdCBfX3VzZXIgKnVzZXJfcHJpdl9kYXRhLA0KIAkJCSAgICB1aW50
NjRfdCAqcHJpdl9vZmZzZXQpOw0KQEAgLTIzNywxMyArMjM3LDEyIEBAIHN0YXRpYyBpbmxpbmUg
aW50IHN2bV9yYW5nZV9zY2hlZHVsZV9ldmljdF9zdm1fYm8oDQogCXJldHVybiAtRUlOVkFMOw0K
IH0NCiANCi1zdGF0aWMgaW5saW5lIGludCBzdm1fcmFuZ2VfZ2V0X2luZm8oc3RydWN0IGtmZF9w
cm9jZXNzICpwLA0KLQkJCQkgICAgIHVpbnQzMl90ICpudW1fc3ZtX3JhbmdlcywNCi0JCQkJICAg
ICB1aW50NjRfdCAqc3ZtX3ByaXZfZGF0YV9zaXplKQ0KK3N0YXRpYyBpbmxpbmUgdm9pZCBzdm1f
cmFuZ2VfZ2V0X2luZm8oc3RydWN0IGtmZF9wcm9jZXNzICpwLA0KKwkJCQkgICAgICB1aW50MzJf
dCAqbnVtX3N2bV9yYW5nZXMsDQorCQkJCSAgICAgIHVpbnQ2NF90ICpzdm1fcHJpdl9kYXRhX3Np
emUpDQogew0KIAkqbnVtX3N2bV9yYW5nZXMgPSAwOw0KIAkqc3ZtX3ByaXZfZGF0YV9zaXplID0g
MDsNCi0JcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IGtmZF9jcml1X2NoZWNr
cG9pbnRfc3ZtKHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwNCi0tIA0KMi40My4wDQo=

