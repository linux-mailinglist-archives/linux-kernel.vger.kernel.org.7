Return-Path: <linux-kernel+bounces-849919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257FBD154E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929503B9961
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95C270EDF;
	Mon, 13 Oct 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="aneSQ49u"
Received: from ironport.ite.com.tw (hc210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9234BA42;
	Mon, 13 Oct 2025 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327400; cv=none; b=GgLygGozcsWhjxpX9QdY0kPinT7EwkVp3LUCRVxEpjMS2AYHhmYJcg5ezqqxtz0jC/Ppbkeat1NlRE3zHS6liZ7ZtB2hCbLbwD2hXD/yu0e/cafvaO93BGjzT90MecM5iDF62c3dEWvQWXVvsnWQSQd/hzr/c2UYeG95x+P8I1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327400; c=relaxed/simple;
	bh=bs+ML9yntkB+CbmtvinOzIDQScni1iGM7XWFx0NwunM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJL2z3/iLI4dPML0eScXGE3kgGBZfJ9XthjlJa0KFZ6Hi670Qd2hiWOLmdRrDWS04hSW8o7xNADxdNNjVF4UL+0ifpr1wo/hbZMyALXakBExESGcKPt+YUBQxlI4fejWrqf+hX8pK7bMNdzgdhAsenvGzOTTbJMTf7/SK56Yfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=aneSQ49u; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bs+ML9yntkB+CbmtvinOzIDQScni1iGM7XWFx0NwunM=;
  b=aneSQ49uaXI7vYdWAaiyh9W+gcqcMc867Iefu3KUJu5GV/3oDTmgxPRc
   krVdkotwQ6E2yuGLdg8iOYDjQB4mAt69CEby4Ny/hs+iyWf+q9i2U0dqk
   CSo9Nq2ONQxrWymiUi8polFt8HgWDHgeHMD3sQf57OHpi38/h9JVU9O0k
   4cBI4JnVEB7mU9sN2YCNvtb5R1kqTH6gBBAn6V/YeCqOF9Ao1/CpBK2VB
   ud/c/WFs4wmYO/9hGl5PvN7/g7Nfkqee6sAf665byx2ZF1PugVngn2Xpj
   aBs8Dc6NMuFMKXSCelRLcrWpW1UxPt7ElQHnZXHJwBxn3GOOPFqRgaHDg
   w==;
X-CSE-ConnectionGUID: B28KHWmERwaCjQN3HPgoUw==
X-CSE-MsgGUID: FPkfBvSuTnqOgfRosDhGmw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 13 Oct 2025 11:49:47 +0800
Received: from hscmail1.internal.ite.com.tw (HSCMAIL1.internal.ite.com.tw [192.168.35.58])
	by mse.ite.com.tw with ESMTP id 59D3njdd065613;
	Mon, 13 Oct 2025 11:49:45 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from HSCMAIL1.internal.ite.com.tw (192.168.35.58) by
 HSCMAIL1.internal.ite.com.tw (192.168.35.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 13 Oct 2025 11:49:44 +0800
Received: from HSCMAIL1.internal.ite.com.tw ([fe80::5982:8700:397a:7e59]) by
 HSCMAIL1.internal.ite.com.tw ([fe80::5982:8700:397a:7e59%12]) with mapi id
 15.01.2507.057; Mon, 13 Oct 2025 11:49:44 +0800
From: <Pet.Weng@ite.com.tw>
To: <krzk@kernel.org>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Hermes.Wu@ite.com.tw>,
        <Kenneth.Hung@ite.com.tw>, <treapking@google.com>
Subject: RE: [PATCH v3 1/3] dt-binding: display: Add ITE IT61620 MIPI DSI to
 HDMI bridge
Thread-Topic: [PATCH v3 1/3] dt-binding: display: Add ITE IT61620 MIPI DSI to
 HDMI bridge
Thread-Index: AQHcOPMgDiPvcIbynU2m6IMtDFZcK7S5VcKAgAAAOACABh63EA==
Date: Mon, 13 Oct 2025 03:49:44 +0000
Message-ID: <663a3ee90e81451894d280a06ea4ecb5@ite.com.tw>
References: <20251009-it61620-0714-v3-0-5d682d028441@ite.com.tw>
 <20251009-it61620-0714-v3-1-5d682d028441@ite.com.tw>
 <fc4b2eff-5224-4c73-b21a-16716e833b8c@kernel.org>
 <cad5f48b-5992-4e29-8ca1-57535dfe3251@kernel.org>
In-Reply-To: <cad5f48b-5992-4e29-8ca1-57535dfe3251@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 788B34A5970BC518487BDBBFBF034C3A70197968B3751062F46B98A561817EFF2002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 59D3njdd065613

SGkgS3J6eXN6dG9mLA0KPiBPbiAwOS8xMC8yMDI1IDIzOjEzLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiA+IE9uIDA5LzEwLzIwMjUgMTc6MDIsIFBldCBXZW5nIHdyb3RlOg0KPiA+PiAr
ICBUaGUgSERNSSB0cmFuc21pdHRlciBzaWRlIHN1cHBvcnRzIHVwIHRvIDRLeDJLQDMwSHogcmVz
b2x1dGlvbnMsIGFuZCBpcw0KPiA+PiArICBjb21wbGlhbnQgd2l0aCBIRE1JIDEuNGIgYW5kIEhE
Q1AgMS40Lg0KPiA+PiArDQo+ID4+ICsgIEZvciBhdWRpbywgdGhlIElUNjE2MjAgc3VwcG9ydHMg
dXAgdG8gOC1jaGFubmVsIExQQ00gdmlhIEkyUyAobXVsdGktbGluZSBvcg0KPiA+PiArICBURE0g
bW9kZSksIHdpdGggb3B0aW9uYWwgUy9QRElGIG9yIERTRCAoZm9yIFNBQ0QpLiBJdCBzdXBwb3J0
cyBhdWRpbw0KPiA+PiArICBzYW1wbGluZyByYXRlcyB1cCB0byAxOTJrSHouDQo+ID4+ICsNCj4g
Pj4gK2FsbE9mOg0KPiA+PiArICAtICRyZWY6IC9zY2hlbWFzL3NvdW5kL2RhaS1jb21tb24ueWFt
bCMNCj4gPj4gKw0KPiA+PiArcHJvcGVydGllczoNCj4gPj4gKyAgY29tcGF0aWJsZToNCj4gPj4g
KyAgICBjb25zdDogaXRlLGl0NjE2MjANCj4gPj4gKw0KPiA+PiArICByZWc6DQo+ID4+ICsgICAg
bWF4SXRlbXM6IDENCj4gPj4gKw0KPiA+PiArICBpbnRlcnJ1cHRzOg0KPiA+PiArICAgIG1heEl0
ZW1zOiAxDQo+ID4+ICsgICAgZGVzY3JpcHRpb246IGludGVycnVwdCBzcGVjaWZpZXIgb2YgSU5U
IHBpbg0KPiA+PiArDQo+ID4+ICsgIHJlc2V0LWdwaW9zOg0KPiA+PiArICAgIG1heEl0ZW1zOiAx
DQo+ID4+ICsgICAgZGVzY3JpcHRpb246IEdQSU8gc3BlY2lmaWVyIG9mIFJFU0VUIHBpbg0KPiA+
DQo+ID4NCj4gPiBJZiB5b3UgYXJlIGdvaW5nIHRvIHNlbmQgbmV3IHZlcnNpb246IGRyb3AgZGVz
Y3JpcHRpb24sIHByZXR0eQ0KPiA+IHJlZHVuZGFudC4gQ2Fubm90IGJlIGFueXRoaW5nIGVsc2Uu
DQo+ID4NCj4gPj4gKw0KPiA+PiArICBpdmRkLXN1cHBseToNCj4gPj4gKyAgICBkZXNjcmlwdGlv
bjogY29yZSB2b2x0YWdlDQo+ID4+ICsNCj4gPj4gKyAgb3ZkZC1zdXBwbHk6DQo+ID4+ICsgICAg
ZGVzY3JpcHRpb246IEkvTyB2b2x0YWdlDQo+ID4+ICsNCj4gPj4gKyAgb3ZkZDE4MzMtc3VwcGx5
Og0KPiA+PiArICAgIGRlc2NyaXB0aW9uOiBmbGV4aWJsZSBJL08gdm90YWdlDQo+ID4+ICsNCj4g
Pj4gKyAgcGluY3RybC1uYW1lczoNCj4gPj4gKyAgICBpdGVtczoNCj4gPj4gKyAgICAgIC0gY29u
c3Q6IGRlZmF1bHQNCj4gPj4gKw0KPiA+PiArICBwaW5jdHJsLTA6DQo+ID4+ICsgICAgbWF4SXRl
bXM6IDENCj4gPg0KPiA+DQo+ID4gQm90aCBwaW5jdHJsIHByb3BlcnRpZXMgYXJlIHVzdWFsbHkg
cmVkdW5kYW50IGhlcmUuIERvZXMgeW91ciBkcml2ZXINCj4gPiBhY3R1YWxseSByZXF1aXJlIHRo
ZW0/DQo+IA0KPiBBbmQgbm93IEkgY2hlY2tlZCBhbmQgSSBkbyBub3Qgc2VlIGRpcmVjdCB1c2Fn
ZSBpbiB0aGUgZHJpdmVyIG9yIGRpZCBJDQo+IG1pc3Mgc29tZXRoaW5nPw0KDQpBY2tub3dsZWRn
ZWQuIFdpbGwgZHJvcCBgcGluY3RybC1uYW1lc2AgYW5kIGBwaW5jdHJsLTBgIGluIHRoZSBuZXh0
IHZlcnNpb24uDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQoNCkJlc3QgcmVnYXJkcywNClBldA0K

