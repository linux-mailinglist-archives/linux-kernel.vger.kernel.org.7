Return-Path: <linux-kernel+bounces-691139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F0ADE0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 04:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863DB189A8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 02:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838681922DE;
	Wed, 18 Jun 2025 02:02:17 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674832904
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212137; cv=none; b=d+jrdng389Sx5CPssBCUxQOB251fuYvDTXoJ9kXoFjyOhYVGvH0Ne7NDEClqv+AWhGVfIAPzjCSYbh1qFM7M3iiX4MY4+w4OLSTPeRcLULWkH8zv7JQ9kA/Q/GLfhMjseTImvKS560qiX1uxsl1747sim0ulLSFYZhGiAsqjcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212137; c=relaxed/simple;
	bh=ul62Y0qLkAI7EV3T+Mt2Sj29ch4kVanJFPx5nHbcABc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=q+pLH8HkL2aagDYWJEhot0Dst4aV06ayX8y2yFjTKFKZqYvmPs1Sh541wSJZQIhfxtvDxzOWRKge0PLridAhZVYMmPmWaHs76K6toFdYOZp8TcUKMof27fHVnGtMp2+4fz03tZ0h/ohTf63vcrGVg0coaO+ozUNif1NCjHKLmSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bMRnM6lHcz8RTWX;
	Wed, 18 Jun 2025 10:01:59 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 55I21qOP018640;
	Wed, 18 Jun 2025 10:01:52 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 18 Jun 2025 10:01:53 +0800 (CST)
Date: Wed, 18 Jun 2025 10:01:53 +0800 (CST)
X-Zmail-TransId: 2af968521e11ffffffffad8-e8144
X-Mailer: Zmail v1.0
Message-ID: <20250618100153468I5faNUAhCdtMA01OuuTKC@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <jgross@suse.com>
Cc: <sstabellini@kernel.org>, <oleksandr_tyshchenko@epam.com>,
        <jiang.peng9@zte.com.cn>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB4ZW4veGVuYnVzOiBmaXggVz0xIGJ1aWxkIHdhcm5pbmcgaW4geGVuYnVzX3ZhX2Rldl9lcnJvcgogZnVuY3Rpb24=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 55I21qOP018640
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68521E16.000/4bMRnM6lHcz8RTWX



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogUGVuZyBKaWFuZyA8amlhbmcucGVuZzlAenRlLmNvbS5jbj4NCg0KVGhpcyBwYXRjaCBm
aXhlcyBhIFc9MSBmb3JtYXQtc3RyaW5nIHdhcm5pbmcgcmVwb3J0ZWQgYnkgR0NDIDEyLjMuMA0K
YnkgYW5ub3RhdGluZyB4ZW5idXNfc3dpdGNoX2ZhdGFsKCkgYW5kIHhlbmJ1c192YV9kZXZfZXJy
b3IoKQ0Kd2l0aCB0aGUgX19wcmludGYgYXR0cmlidXRlLiBUaGUgYXR0cmlidXRlIGVuYWJsZXMg
Y29tcGlsZS10aW1lDQp2YWxpZGF0aW9uIG9mIHByaW50Zi1zdHlsZSBmb3JtYXQgc3RyaW5ncyBp
biB0aGVzZSBmdW5jdGlvbnMuDQoNClRoZSBvcmlnaW5hbCB3YXJuaW5nIHRyYWNlOg0KZHJpdmVy
cy94ZW4veGVuYnVzL3hlbmJ1c19jbGllbnQuYzozMDQ6OTogd2FybmluZzogZnVuY3Rpb24gJ3hl
bmJ1c192YV9kZXZfZXJyb3InIG1pZ2h0IGJlDQphIGNhbmRpZGF0ZSBmb3IgJ2dudV9wcmludGYn
IGZvcm1hdCBhdHRyaWJ1dGUgWy1Xc3VnZ2VzdC1hdHRyaWJ1dGU9Zm9ybWF0XQ0KDQpTaWduZWQt
b2ZmLWJ5OiBQZW5nIEppYW5nIDxqaWFuZy5wZW5nOUB6dGUuY29tLmNuPg0KLS0tDQogZHJpdmVy
cy94ZW4veGVuYnVzL3hlbmJ1c19jbGllbnQuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX2Ns
aWVudC5jIGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c19jbGllbnQuYw0KaW5kZXggNTFiMzEy
NGIwZDU2Li5lNzNlYzIyNWQ0YTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3hlbi94ZW5idXMveGVu
YnVzX2NsaWVudC5jDQorKysgYi9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX2NsaWVudC5jDQpA
QCAtMjAyLDYgKzIwMiw3IEBAIGludCB4ZW5idXNfd2F0Y2hfcGF0aGZtdChzdHJ1Y3QgeGVuYnVz
X2RldmljZSAqZGV2LA0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTCh4ZW5idXNfd2F0Y2hfcGF0aGZt
dCk7DQogDQorX19wcmludGYoNCwgNSkNCiBzdGF0aWMgdm9pZCB4ZW5idXNfc3dpdGNoX2ZhdGFs
KHN0cnVjdCB4ZW5idXNfZGV2aWNlICosIGludCwgaW50LA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBjaGFyICosIC4uLik7DQogDQpAQCAtMjg3LDYgKzI4OCw3IEBAIGlu
dCB4ZW5idXNfZnJvbnRlbmRfY2xvc2VkKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYpDQogfQ0K
IEVYUE9SVF9TWU1CT0xfR1BMKHhlbmJ1c19mcm9udGVuZF9jbG9zZWQpOw0KIA0KK19fcHJpbnRm
KDMsIDApDQogc3RhdGljIHZvaWQgeGVuYnVzX3ZhX2Rldl9lcnJvcihzdHJ1Y3QgeGVuYnVzX2Rl
dmljZSAqZGV2LCBpbnQgZXJyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBjaGFyICpmbXQsIHZhX2xpc3QgYXApDQogew0KLS0gDQoyLjI1LjE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IFBlbmcgSmlhbmcgJmx0O2ppYW5nLnBl
bmc5QHp0ZS5jb20uY24mZ3Q7PC9wPjxwPjxicj48L3A+PHA+VGhpcyBwYXRjaCBmaXhlcyBhIFc9
MSBmb3JtYXQtc3RyaW5nIHdhcm5pbmcgcmVwb3J0ZWQgYnkgR0NDIDEyLjMuMDwvcD48cD5ieSBh
bm5vdGF0aW5nIHhlbmJ1c19zd2l0Y2hfZmF0YWwoKSBhbmQgeGVuYnVzX3ZhX2Rldl9lcnJvcigp
PC9wPjxwPndpdGggdGhlIF9fcHJpbnRmIGF0dHJpYnV0ZS4gVGhlIGF0dHJpYnV0ZSBlbmFibGVz
IGNvbXBpbGUtdGltZTwvcD48cD52YWxpZGF0aW9uIG9mIHByaW50Zi1zdHlsZSBmb3JtYXQgc3Ry
aW5ncyBpbiB0aGVzZSBmdW5jdGlvbnMuPC9wPjxwPjxicj48L3A+PHA+VGhlIG9yaWdpbmFsIHdh
cm5pbmcgdHJhY2U6PC9wPjxwPmRyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmM6MzA0
Ojk6IHdhcm5pbmc6IGZ1bmN0aW9uICd4ZW5idXNfdmFfZGV2X2Vycm9yJyBtaWdodCBiZTwvcD48
cD5hIGNhbmRpZGF0ZSBmb3IgJ2dudV9wcmludGYnIGZvcm1hdCBhdHRyaWJ1dGUgWy1Xc3VnZ2Vz
dC1hdHRyaWJ1dGU9Zm9ybWF0XTwvcD48cD48YnI+PC9wPjxwPlNpZ25lZC1vZmYtYnk6IFBlbmcg
SmlhbmcgJmx0O2ppYW5nLnBlbmc5QHp0ZS5jb20uY24mZ3Q7PC9wPjxwPi0tLTwvcD48cD4mbmJz
cDtkcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX2NsaWVudC5jIHwgMiArKzwvcD48cD4mbmJzcDsx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspPC9wPjxwPjxicj48L3A+PHA+ZGlmZiAtLWdp
dCBhL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmMgYi9kcml2ZXJzL3hlbi94ZW5i
dXMveGVuYnVzX2NsaWVudC5jPC9wPjxwPmluZGV4IDUxYjMxMjRiMGQ1Ni4uZTczZWMyMjVkNGE2
IDEwMDY0NDwvcD48cD4tLS0gYS9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX2NsaWVudC5jPC9w
PjxwPisrKyBiL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmM8L3A+PHA+QEAgLTIw
Miw2ICsyMDIsNyBAQCBpbnQgeGVuYnVzX3dhdGNoX3BhdGhmbXQoc3RydWN0IHhlbmJ1c19kZXZp
Y2UgKmRldiw8L3A+PHA+Jm5ic3A7fTwvcD48cD4mbmJzcDtFWFBPUlRfU1lNQk9MX0dQTCh4ZW5i
dXNfd2F0Y2hfcGF0aGZtdCk7PC9wPjxwPiZuYnNwOzwvcD48cD4rX19wcmludGYoNCwgNSk8L3A+
PHA+Jm5ic3A7c3RhdGljIHZvaWQgeGVuYnVzX3N3aXRjaF9mYXRhbChzdHJ1Y3QgeGVuYnVzX2Rl
dmljZSAqLCBpbnQsIGludCw8L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGNvbnN0IGNoYXIgKiwgLi4uKTs8L3A+PHA+Jm5ic3A7PC9w
PjxwPkBAIC0yODcsNiArMjg4LDcgQEAgaW50IHhlbmJ1c19mcm9udGVuZF9jbG9zZWQoc3RydWN0
IHhlbmJ1c19kZXZpY2UgKmRldik8L3A+PHA+Jm5ic3A7fTwvcD48cD4mbmJzcDtFWFBPUlRfU1lN
Qk9MX0dQTCh4ZW5idXNfZnJvbnRlbmRfY2xvc2VkKTs8L3A+PHA+Jm5ic3A7PC9wPjxwPitfX3By
aW50ZigzLCAwKTwvcD48cD4mbmJzcDtzdGF0aWMgdm9pZCB4ZW5idXNfdmFfZGV2X2Vycm9yKHN0
cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsIGludCBlcnIsPC9wPjxwPiZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBjb25zdCBjaGFyICpmbXQsIHZh
X2xpc3QgYXApPC9wPjxwPiZuYnNwO3s8L3A+PHA+LS0mbmJzcDs8L3A+PHA+Mi4yNS4xPC9wPjxw
IHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0
IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u
6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZTox
NHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxw
IHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0
IFlhSGVpOyI+PGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


