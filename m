Return-Path: <linux-kernel+bounces-885853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5770C340CA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04173465579
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11E2C08B6;
	Wed,  5 Nov 2025 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAmB8hzh"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409625FA13
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324073; cv=none; b=hV7ayLOpi3xurZ8ZFjOHR9Z5RCGTWptqWsHGynTFUHko7XhfCt6xCQi2h6HVYcx4QP0WcKxo6BqjszmVQg94ilRU5AAg444Grs9bfaaZ/RRjMvxOoIcC90LNBTVvZifAK1R6eUbcJ2N8/4c5i6QMlaR3CYeNXkWDN5Cf8fAyZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324073; c=relaxed/simple;
	bh=jeCq7yHtC5OS5YD2iwjMdqIfwkyzElnJ5GcSaasUr+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/44sc+XnTamxHjgYHTYi2vgjXhGQxlyrkRA3LT31L/gcBPy9YluUMl0su2a/YF1fp3Rqn7Xd40jUNtdSeRRBXyaB0vtJAC/9XFqgVVWkEOZygeSI83KHpWO2CV84ipjB2GtpAssZG0JXKsAm3eitH3I+F0aMVcUakHZ2VZTLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAmB8hzh; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f95dc176fso4339934d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 22:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762324070; x=1762928870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeCq7yHtC5OS5YD2iwjMdqIfwkyzElnJ5GcSaasUr+I=;
        b=bAmB8hzheh1D6x4sT7J/wcYSXLztSuWMiWxtsNC1XaO9aI23QWAl/D0usL5rNRJIDn
         pWVyRatTIWjACN9YcDYcuedkFtFwsOoPSH6u1BLBR5D2MZFyW8m5e6wXUJeaoGsKiyvb
         Dw5DpMvrhg2BaOC6+6iVa6IKty+HqdcpJq0FESz6hDADickMFfIlEJCOHW3FuE/1Y34z
         z038RV6NDEtTHOOhNAJi0vi6OAlTxIr7ui52USEuY5iWJoxDTeIAViQfMOl446pR5P1A
         wERLjaA+rq2HLzRBDo0LTzyo7qx4F85eQ8baa+lzH1DaziR60F3tT/ZUMBssjXVZ7zy5
         nsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324070; x=1762928870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeCq7yHtC5OS5YD2iwjMdqIfwkyzElnJ5GcSaasUr+I=;
        b=o8jWkn+vndjgT/+VNg9uebSsVpIF5IsY2fi6mpOHeucaWk9AYs1j/JyQdUKtj66Ivf
         KeHsBzmVwn1IOESySfMItPBGcVRt90IR/S9Zs7VFGQg8UoAMUTV+qhc9Y9VpqUsRhvT5
         bKDE/r9iEwsEoWXDr0jI78NO42rMhPhY6z+1WiOqtjNiRgJbJWJKG87tzEP7jnsHosFf
         1qrr4wsi1uSAEXM9psHFQQ6qAiliHyNZHEW1uwoOJMHTSYJBInt7T9xvRNAIVSRXX1Uj
         fyRvu6ExAl7zPlPqwcpmiah9bJHu69jlMQR7SS5zYptFZeKGrdZ9xEti+XKe7lPkJ9nw
         lDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiEYuFdzjMQt1k93/PEu6KVk0b9WzVcc/6jaizVrcY02Nsqm6i0rASefmbb9VfewneNoXQr0PSab433Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMGd5thTdM2mTrq2LCsusAltX7aLHB+HDOYwEVGUn1aeSD4yP
	KTupSyEIld7RdX1i8kH4eXdL62hgtMwK3EpHnF0cmoSkOUWzFWyH7B4ErxliKi/z15L19KzP4yH
	8lfxrgq9n1pcHghkQdx2Uh3iPosyzpWM=
X-Gm-Gg: ASbGnct0Ih8DtT8yoGgbEh2ammVuDQo1jWn7pAGIlTZVnPMcD78KvH99a2R8OFbtynG
	dSqrbkvK8KypTvorm7WWgB25R/a1ZEs3f+5aHbHG4tUkxMTNI8wxtQm8O4m5Y3dJAYWL3iCbLaw
	H1p7OeYtHd8ljsTSRaOfMHsQDYLFfAG+DYfhlxFF5xPbdoisLt8sZLv/MMVqwp4lOhq2qmJ6TPn
	f42YpkwJ5eCCsFk3MfjtNC08f0f1W5TGs+XdmpEGN0V04EBttTkUuKBSDE=
X-Google-Smtp-Source: AGHT+IFdiDnyeB/b2R/ETcLVPyA6OCjT4xirxHagJ+oS+nhEajJyKbfrExaD7O6D4NVTjiCeW84j4bp2Z6m2e/DTXUc=
X-Received: by 2002:a05:690e:159c:20b0:63f:b0ca:dc9e with SMTP id
 956f58d0204a3-63fd34bb82amr1456004d50.10.1762324070502; Tue, 04 Nov 2025
 22:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105024016.104413-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20251105024016.104413-1-zhaochenguang@kylinos.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 5 Nov 2025 14:27:23 +0800
X-Gm-Features: AWmQ_bneg4qAV5dCrFxkdyh-1rRJWVF-MjuTsznf6NxfRswv34cIIYqMoTC59Gk
Message-ID: <CAD-N9QVgK24ZRz__BEUG3+yPwYqz+-rLoci0frwvjHafR3HVVA@mail.gmail.com>
Subject: Re: [PATCH linux-next] docs/zh_CN: Sync the translation of changes in kbuild.rst
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBOb3YgNSwgMjAyNSBhdCAxMDo0MOKAr0FNIENoZW5ndWFuZyBaaGFvIDx6aGFvY2hl
bmd1YW5nQGt5bGlub3MuY24+IHdyb3RlOg0KPg0KPiBTeW5jIHRoZSB0cmFuc2xhdGlvbiBvZiBj
aGFuZ2VzIGluIGtidWlsZC9rYnVpbGQucnN0IGFib3V0DQo+IEtCVUlMRF9CVUlMRF9USU1FU1RB
TVAuDQoNClBsZWFzZSBmb2xsb3cgaG93LXRvLnJzdFsxXSB0byByZXZpc2UgeW91ciBjb21taXQg
bWVzc2FnZSBhcyBmb2xsb3dzOg0KDQror7flj4LogIPku6XkuIvkv6Hmga/ov5vooYzovpPlhaU6
Og0KDQpkb2NzL3poX0NOOiBBZGQgc2VsZi1wcm90ZWN0aW9uIGluZGV4IENoaW5lc2UgdHJhbnNs
YXRpb24NCg0KVHJhbnNsYXRlIC4uLi9zZWN1cml0eS9zZWxmLXByb3RlY3Rpb24ucnN0IGludG8g
Q2hpbmVzZS4NCg0KVXBkYXRlIHRoZSB0cmFuc2xhdGlvbiB0aHJvdWdoIGNvbW1pdCBiMDgwZTUy
MTEwZWENCigiZG9jczogdXBkYXRlIHNlbGYtcHJvdGVjdGlvbiBfX3JvX2FmdGVyX2luaXQgc3Rh
dHVzIikNCiMg6K+35omn6KGMIGdpdCBsb2cgLS1vbmVsaW5lIDzmgqjnv7vor5HnmoToi7Hmlofm
lofmoaPot6/lvoQ+77yM5bm25pu/5o2i5LiK6L+w5YaF5a65DQoNClNpZ25lZC1vZmYtYnk6IFlh
bnRlbmcgU2kgPHNpLnlhbnRlbmdAbGludXguZGV2Pg0KIyDlpoLmnpzmgqjliY3pnaLnmoTmraXp
qqTmraPnoa7miafooYzvvIzor6XooYzkvJroh6rliqjmmL7npLrvvIzlkKbliJnor7fmo4Dmn6Ug
Z2l0Y29uZmlnIOaWh+S7tg0KDQrkv53lrZjlubbpgIDlh7rjgIINCg0KWzFdIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90
cmVlL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2hvdy10by5yc3QNCj4NCj4gU2ln
bmVkLW9mZi1ieTogQ2hlbmd1YW5nIFpoYW8gPHpoYW9jaGVuZ3VhbmdAa3lsaW5vcy5jbj4NCj4g
LS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9rYnVpbGQva2J1aWxkLnJz
dCB8IDkgKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
emhfQ04va2J1aWxkL2tidWlsZC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9rYnVpbGQva2J1aWxkLnJzdA0KPiBpbmRleCBlNWUyYWViZTFlYmMuLmJhY2YwNTgyNzJjYSAx
MDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04va2J1aWxkL2ti
dWlsZC5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04va2J1aWxk
L2tidWlsZC5yc3QNCj4gQEAgLTI5MCw4ICsyOTAsMTMgQEAgSUdOT1JFX0RJUlMNCj4gIEtCVUlM
RF9CVUlMRF9USU1FU1RBTVANCj4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIOWwhuivpeeO
r+Wig+WPmOmHj+iuvue9ruS4uuaXpeacn+Wtl+espuS4su+8jOWPr+S7peimhuebluWcqCBVVFNf
VkVSU0lPTiDlrprkuYnkuK3kvb/nlKjnmoTml7bpl7TmiLMNCj4gLe+8iOi/kOihjOWGheaguOaX
tueahCB1bmFtZSAtdu+8ieOAguivpeWAvOW/hemhu+aYr+S4gOS4quWPr+S7peS8oOmAkue7mSBk
YXRlIC1kIOeahOWtl+espuS4suOAgum7mOiupOWAvOaYrw0KPiAt5YaF5qC45p6E5bu65p+Q5Liq
5pe25Yi755qEIGRhdGUg5ZG95Luk6L6T5Ye644CCDQo+ICvvvIjov5DooYzlhoXmoLjml7bnmoQg
dW5hbWUgLXbvvInjgILor6XlgLzlv4XpobvmmK/kuIDkuKrlj6/ku6XkvKDpgJLnu5kgZGF0ZSAt
ZCDnmoTlrZfnrKbkuLLjgILkvovlpoI6Og0KPiArDQo+ICsgICAgICAgJCBLQlVJTERfQlVJTERf
VElNRVNUQU1QPSJNb24gT2N0IDEzIDAwOjAwOjAwIFVUQyAyMDI1IiBtYWtlDQo+ICsNCj4gK+m7
mOiupOWAvOaYr+WGheaguOaehOW7uuafkOS4quaXtuWIu+eahCBkYXRlIOWRveS7pOi+k+WHuuOA
guWmguaenOaPkOS+m+ivpeaXtuaIs++8jOWug+i/mOeUqOS6juS7u+S9lWluaXRyYW1mc+W9kuah
o+aWh+S7tg0KPiAr5Lit55qEbXRpbWXlrZfmrrXjgIJJbml0cmFtZnMgbXRpbWVz5pivMzLkvY3n
moTvvIzlm6DmraTml6nkuo5Vbml457qq5YWDMTk3MOW5tO+8jOaIluaZmuS6juWNj+iwg+S4lueV
jOaXtg0KPiArKFVUQykyMTA25bm0MuaciDfml6U25pe2MjjliIYxNeenkueahOaXpeacn+aYr+aX
oOaViOeahOOAgg0KPg0KPiAgS0JVSUxEX0JVSUxEX1VTRVIsIEtCVUlMRF9CVUlMRF9IT1NUDQo+
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gMi4yNS4xDQo+
DQo+DQo=

