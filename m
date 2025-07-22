Return-Path: <linux-kernel+bounces-740518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB20B0D52F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6261883AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F12D9EF4;
	Tue, 22 Jul 2025 08:59:18 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D972D97A2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174757; cv=none; b=B3ldYK1jgOr3whyuH2NpPK9y2RPOdEbQiNNe8vqEmJDiPX1gInoL+SqPpHt99pJysHnzO9dHxGGG/pk2xhKDMt0K7T9IT4MsfyvJ1ur+MTrLF1l9JWyo0PEAhKZSWy9q5JcbGzFDr4RfZFFc/+k3Agu4AZujpmZAWcQADwRmbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174757; c=relaxed/simple;
	bh=uqHNZxCZyF1IF0Dfkg2tes1n3S4D3fyDGFGhfe2/pTs=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=jozKIx6LbXYtB1hxsJYT4K6j55nymHl268hm/SAEep3OlIck1RJRZKcW0Wh4UXTF0kP5An+FMsi2D/yZCKIKbk0d+mrK2N6Y8Xj10O520G2fuidhiAp/0VE/3ElbQsHekmZE0SLiO4/NSa+PdkM14o7E0rlOnaRFRE/NoSpxBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bmWQv2ym3z5B13Z;
	Tue, 22 Jul 2025 16:59:03 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 56M8wdpw017840;
	Tue, 22 Jul 2025 16:58:39 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 22 Jul 2025 16:58:41 +0800 (CST)
Date: Tue, 22 Jul 2025 16:58:41 +0800 (CST)
X-Zmail-TransId: 2afb687f52c116c-8e651
X-Mailer: Zmail v1.0
Message-ID: <20250722165841838ou4ZoIujZCCgIG2HAu1T8@zte.com.cn>
In-Reply-To: <a2440b5e-2c6c-42b2-9c85-9701e65b1305@kernel.org>
References: 20250721094049958ImB8XG_imntcPqpQn1KfG@zte.com.cn,a2440b5e-2c6c-42b2-9c85-9701e65b1305@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <krzk@kernel.org>
Cc: <jiang.kun2@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <akpm@linux-foundation.org>, <xu.xin16@zte.com.cn>,
        <bbonev@devuan.org>, <linux-kernel@vger.kernel.org>,
        <bsingharora@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eCBuZXh0XSBNQUlOVEFJTkVSUzogYWRkIG1haW50YWluZXJzIGZvciBkZWxheXRvcA==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 56M8wdpw017840
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 22 Jul 2025 16:59:03 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687F52D7.001/4bmWQv2ym3z5B13Z



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

Pj4gQEAgLTE5NTI0LDYgKzE5NTI0LDE2IEBAIFM6ICAgIE1haW50YWluZWQNCj4+ICBGOiAgICBp
bmNsdWRlL2xpbnV4L2RlbGF5YWNjdC5oDQo+PiAgRjogICAga2VybmVsL2RlbGF5YWNjdC5jDQo+
PiANCj4+ICtUQVNLIERFTEFZIE1PTklUT1JJTkcgVE9PTFMNCj4+ICtNOiAgICBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPj4gK006ICAgIFdhbmcgWWF4aW4gPHdh
bmcueWF4aW5AenRlLmNvbS5jbj4NCj4NCj4NCj5UaGVyZSB3ZXJlIG5vIGNvbnRyaWJ1dGlvbnMg
ZnJvbSBhYm92ZSBhZGRyZXNzLiBOb3QgYSBzaW5nbGUNCj5jb250cmlidXRpb24uIE5vdCBhIHNp
bmdsZSByZXZpZXcsIG5vdCBhIHNpbmdsZSBtZXNzYWdlIG9yIGNvbW1lbnQuIElmDQo+dGhlIHBl
cnNvbiB3YW50cyB0byByZXZpZXcsIHdoeSByZXZpZXdpbmcgZGlkIG5vdCBoYXBwZW4gc28gZmFy
Pw0KDQpIaSBLcnp5c3p0b2YsDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suIEkgY29tcGxl
dGVseSB1bmRlcnN0YW5kIHlvdXIgY29uY2VybnMgYWJvdXQNCnRoZSBtYWludGFpbmVyIHJvbGUs
IGFuZCBJ4oCZZCBsaWtlIHRvIHByb3ZpZGUgc29tZSBjb250ZXh0IHRvIGNsYXJpZnkgdGhlDQpz
aXR1YXRpb24uDQoNCjEpIGRlbGF5dG9wIGNvbnRyaWJ1dGlvbnMNCkRlbGF5dG9wIGlzIHVzZWQg
dG8gb2JzZXJ2ZSBzeXN0ZW0td2lkZSBsYXRlbmN5IHRvcC1uIHRhc2tzLCB3aGljaCBoZWxwcw0K
aW4gbG9jYXRpbmcgbGF0ZW5jeS1yZWxhdGVkIHN5c3RlbSBwZXJmb3JtYW5jZSBpc3N1ZXMuIA0K
QXMgQW5kcmV3IG1lbnRpb25lZCwgZGVsYXl0b3AgaXMgaW5kZWVkIGEgbmV3IG1vZHVsZSBjdXJy
ZW50bHkgb25seSBpbg0KbW0uZ2l0LCB3aGljaCBpcyB3aHkgdGhlcmUgYXJlIG5vIHJlbGF0ZWQg
cGF0Y2hlcyBpbiBtYWlubGluZSB5ZXQuDQpUaGUgcmVsYXRlZCBwYXRjaGVzIGFyZSBhcyBmb2xs
b3dzOiAgDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA2MTkyMTE4NDM2MzNoMDVn
V3JCRE1Ga0VINnhBVm1fNXlAenRlLmNvbS5jbi8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI1MDcxMDEzNTQ1MTM0MF81cE9ncElGaTBNNUFFN0g0NFcxREB6dGUuY29tLmNuLw0KDQoy
KSBsYXRlbmN5LXJlbGF0ZWQgY29udHJpYnV0aW9ucw0KSeKAmXZlIGFsc28gY29udHJpYnV0ZWQg
dG8gbGF0ZW5jeSBtb25pdG9yaW5nIGluIHRoZSBwYXN0IChlLmcuLCBtYXggbGF0ZW5jeSBwYXRj
aGVzKSwNCnNob3dpbmcgYSBjb250aW51ZWQgaW50ZXJlc3QgaW4gdGhpcyBhcmVhLg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMjAzMTY0ODQ4ODA1Q1M2MkNRUFFXRzlHTGRRajJf
QnhTQHp0ZS5jb20uY24vDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDEyMjAxNzMx
MDU5MDZFT2RzUGh6ak1MWU5KSkJxZ3oxZ2FAenRlLmNvbS5jbi8NCg0KMykgbWFpbnRhaW5lciBy
b2xlIGludGVudA0KU2luY2UgdGhlIG1vZHVsZSBpcyBuZXcsIHdlIHJlY29nbml6ZSB0aGF0IGJy
b2FkZXIgY29tbXVuaXR5IHJldmlldyBhbmQgYWRvcHRpb24NCndpbGwgdGFrZSB0aW1lLCBhbmQg
d2XigJlyZSBjb21taXR0ZWQgdG8gc3VwcG9ydGluZyB0aGF0IHByb2Nlc3MuDQoNCj4+ICtNOiAg
ICBGYW4gWXUgPGZhbi55dTlAenRlLmNvbS5jbj4NCj4NCj5BbmQgZnJvbSBoZXJlIGp1c3Qgb25l
IHBhdGNoc2V0IG5vdCBldmVuIHJlbGF0ZWQgdG8gZGVsYXl0b3AuDQo+DQo+U28gY29tYmluaW5n
IGFib3ZlIGl0IGlzIHJlYWxseSBzdXJwcmlzaW5nIHRoYXQgeW91IHdhbnQgdG8gbWFpbnRhaW4N
Cj50aGlzIHBhcnQuDQoNClRoZSBkZXZlbG9wbWVudCBvZiBkZWxheXRvcCAoaW5jbHVkaW5nIHRo
ZSBpbml0aWFsIHBhdGNoZXMpIHdhcyBhIGNvbGxhYm9yYXRpdmUgZWZmb3J0LA0KYXMgcmVmbGVj
dGVkIGluIHRoZSBDby1kZXZlbG9wZWQtYnkgdGFncy4gQXBwbHlpbmcgdG8gYmUgdGhlIG1haW50
YWluZXIgaXMgdG8gZW5zdXJlDQp0aGUgbG9uZy10ZXJtIGV2b2x1dGlvbiBvZiBkZWxheXRvcCwg
d2hpbGUgYWxzbyBtYWtpbmcgaXQgZWFzaWVyIGZvciBvdGhlciBkZXZlbG9wZXJzIHRvIENDIHVz
LiAgDQoNCknigJlkIGJlIGhhcHB5IHRvIGFkZHJlc3MgYW55IGZ1cnRoZXIgcXVlc3Rpb25zIG9y
IHN1Z2dlc3Rpb25zLiBUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbiEg
DQoNCllheGluDQpUaGFua3M=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsmZ3Q7IEBAIC0xOTUyNCw2ICsxOTUyNCwx
NiBAQCBTOiZuYnNwOyAmbmJzcDsgTWFpbnRhaW5lZDwvcD48cD4mZ3Q7Jmd0OyZuYnNwOyBGOiZu
YnNwOyAmbmJzcDsgaW5jbHVkZS9saW51eC9kZWxheWFjY3QuaDwvcD48cD4mZ3Q7Jmd0OyZuYnNw
OyBGOiZuYnNwOyAmbmJzcDsga2VybmVsL2RlbGF5YWNjdC5jPC9wPjxwPiZndDsmZ3Q7Jm5ic3A7
PC9wPjxwPiZndDsmZ3Q7ICtUQVNLIERFTEFZIE1PTklUT1JJTkcgVE9PTFM8L3A+PHA+Jmd0OyZn
dDsgK006Jm5ic3A7ICZuYnNwOyBBbmRyZXcgTW9ydG9uICZsdDtha3BtQGxpbnV4LWZvdW5kYXRp
b24ub3JnJmd0OzwvcD48cD4mZ3Q7Jmd0OyArTTombmJzcDsgJm5ic3A7IFdhbmcgWWF4aW4gJmx0
O3dhbmcueWF4aW5AenRlLmNvbS5jbiZndDs8L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7PC9wPjxwPiZn
dDtUaGVyZSB3ZXJlIG5vIGNvbnRyaWJ1dGlvbnMgZnJvbSBhYm92ZSBhZGRyZXNzLiBOb3QgYSBz
aW5nbGU8L3A+PHA+Jmd0O2NvbnRyaWJ1dGlvbi4gTm90IGEgc2luZ2xlIHJldmlldywgbm90IGEg
c2luZ2xlIG1lc3NhZ2Ugb3IgY29tbWVudC4gSWY8L3A+PHA+Jmd0O3RoZSBwZXJzb24gd2FudHMg
dG8gcmV2aWV3LCB3aHkgcmV2aWV3aW5nIGRpZCBub3QgaGFwcGVuIHNvIGZhcj88L3A+PHA+PGJy
PjwvcD48cD5IaSBLcnp5c3p0b2YsPC9wPjxwPlRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4g
SSBjb21wbGV0ZWx5IHVuZGVyc3RhbmQgeW91ciBjb25jZXJucyBhYm91dDwvcD48cD50aGUgbWFp
bnRhaW5lciByb2xlLCBhbmQgSeKAmWQgbGlrZSB0byBwcm92aWRlIHNvbWUgY29udGV4dCB0byBj
bGFyaWZ5IHRoZTwvcD48cD5zaXR1YXRpb24uPC9wPjxwPjxicj48L3A+PHA+MSkgZGVsYXl0b3Ag
Y29udHJpYnV0aW9uczwvcD48cD5EZWxheXRvcCBpcyB1c2VkIHRvIG9ic2VydmUgc3lzdGVtLXdp
ZGUgbGF0ZW5jeSB0b3AtbiB0YXNrcywgd2hpY2ggaGVscHM8L3A+PHA+aW4gbG9jYXRpbmcgbGF0
ZW5jeS1yZWxhdGVkIHN5c3RlbSBwZXJmb3JtYW5jZSBpc3N1ZXMuJm5ic3A7PC9wPjxwPkFzIEFu
ZHJldyBtZW50aW9uZWQsIGRlbGF5dG9wIGlzIGluZGVlZCBhIG5ldyBtb2R1bGUgY3VycmVudGx5
IG9ubHkgaW48L3A+PHA+bW0uZ2l0LCB3aGljaCBpcyB3aHkgdGhlcmUgYXJlIG5vIHJlbGF0ZWQg
cGF0Y2hlcyBpbiBtYWlubGluZSB5ZXQuPC9wPjxwPlRoZSByZWxhdGVkIHBhdGNoZXMgYXJlIGFz
IGZvbGxvd3M6Jm5ic3A7Jm5ic3A7PC9wPjxwPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MDYxOTIxMTg0MzYzM2gwNWdXckJETUZrRUg2eEFWbV81eUB6dGUuY29tLmNuLzwvcD48cD5o
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA3MTAxMzU0NTEzNDBfNXBPZ3BJRmkwTTVB
RTdINDRXMURAenRlLmNvbS5jbi88L3A+PHA+PGJyPjwvcD48cD4yKSBsYXRlbmN5LXJlbGF0ZWQg
Y29udHJpYnV0aW9uczwvcD48cD5J4oCZdmUgYWxzbyBjb250cmlidXRlZCB0byBsYXRlbmN5IG1v
bml0b3JpbmcgaW4gdGhlIHBhc3QgKGUuZy4sIG1heCBsYXRlbmN5IHBhdGNoZXMpLDwvcD48cD5z
aG93aW5nIGEgY29udGludWVkIGludGVyZXN0IGluIHRoaXMgYXJlYS48L3A+PHA+aHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMjAzMTY0ODQ4ODA1Q1M2MkNRUFFXRzlHTGRRajJfQnhT
QHp0ZS5jb20uY24vPC9wPjxwPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTIyMDE3
MzEwNTkwNkVPZHNQaHpqTUxZTkpKQnFnejFnYUB6dGUuY29tLmNuLzwvcD48cD48YnI+PC9wPjxw
PjMpIG1haW50YWluZXIgcm9sZSBpbnRlbnQ8L3A+PHA+U2luY2UgdGhlIG1vZHVsZSBpcyBuZXcs
IHdlIHJlY29nbml6ZSB0aGF0IGJyb2FkZXIgY29tbXVuaXR5IHJldmlldyBhbmQgYWRvcHRpb248
L3A+PHA+d2lsbCB0YWtlIHRpbWUsIGFuZCB3ZeKAmXJlIGNvbW1pdHRlZCB0byBzdXBwb3J0aW5n
IHRoYXQgcHJvY2Vzcy48L3A+PHA+PGJyPjwvcD48cD4mZ3Q7Jmd0OyArTTombmJzcDsgJm5ic3A7
IEZhbiBZdSAmbHQ7ZmFuLnl1OUB6dGUuY29tLmNuJmd0OzwvcD48cD4mZ3Q7PC9wPjxwPiZndDtB
bmQgZnJvbSBoZXJlIGp1c3Qgb25lIHBhdGNoc2V0IG5vdCBldmVuIHJlbGF0ZWQgdG8gZGVsYXl0
b3AuPC9wPjxwPiZndDs8L3A+PHA+Jmd0O1NvIGNvbWJpbmluZyBhYm92ZSBpdCBpcyByZWFsbHkg
c3VycHJpc2luZyB0aGF0IHlvdSB3YW50IHRvIG1haW50YWluPC9wPjxwPiZndDt0aGlzIHBhcnQu
PC9wPjxwPjxicj48L3A+PHA+VGhlIGRldmVsb3BtZW50IG9mIGRlbGF5dG9wIChpbmNsdWRpbmcg
dGhlIGluaXRpYWwgcGF0Y2hlcykgd2FzIGEgY29sbGFib3JhdGl2ZSBlZmZvcnQsPC9wPjxwPmFz
IHJlZmxlY3RlZCBpbiB0aGUgQ28tZGV2ZWxvcGVkLWJ5IHRhZ3MuIEFwcGx5aW5nIHRvIGJlIHRo
ZSBtYWludGFpbmVyIGlzIHRvIGVuc3VyZTwvcD48cD50aGUgbG9uZy10ZXJtIGV2b2x1dGlvbiBv
ZiBkZWxheXRvcCwgd2hpbGUgYWxzbyBtYWtpbmcgaXQgZWFzaWVyIGZvciBvdGhlciBkZXZlbG9w
ZXJzIHRvIENDIHVzLiZuYnNwOyZuYnNwOzwvcD48cD48YnI+PC9wPjxwPknigJlkIGJlIGhhcHB5
IHRvIGFkZHJlc3MgYW55IGZ1cnRoZXIgcXVlc3Rpb25zIG9yIHN1Z2dlc3Rpb25zLiBUaGFuayB5
b3UgZm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbiEmbmJzcDs8L3A+PHA+PGJyPjwvcD48
cD5ZYXhpbjwvcD48cD5UaGFua3M8L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


