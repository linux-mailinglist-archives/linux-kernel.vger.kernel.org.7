Return-Path: <linux-kernel+bounces-791009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C86B3B113
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633B31B23A96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E40219301;
	Fri, 29 Aug 2025 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="iCjW/2kD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDD215F7D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435260; cv=none; b=c4AChEkGEFqaNOi0aNH+lgswBfZ48NYyJYQR4Dq3VuizK80lKqImfhna8i8L8SJOm4K5Zpttf9ywtvG85Yi+eS5ZF0XJbjqWs9PgApYz2aA1g0FwcedmgidBLHr2e0nUgkYcooMoJbwyTpbBB5MRs00MCE9oLgnwQbgkiSK/yVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435260; c=relaxed/simple;
	bh=u6k22OXUn+7j3Y/3mk8ZEYkE5BmT7T+f6heJbSAEenI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbSOpOMKafxa+o0P0OCy6d7BR7feyFuUn+avcYQfy9ueKOxbMOSBzts1cFSxvAm//qtJ11YABT7a2d0Lb2ItGSA5D7yDveQzMc59mWqklhdiyiEiYQ9wDQFGR3JKM1tiSm4PZic1Mxm+dt2DkBU5auLc8SnKIIBa3LB3qWMLV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=iCjW/2kD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756435255; x=1757040055; i=efault@gmx.de;
	bh=u6k22OXUn+7j3Y/3mk8ZEYkE5BmT7T+f6heJbSAEenI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iCjW/2kDXL4qsn0QWXrR38zFz9MHn/Kp1N/sDacJvRGqLwWDjY515WZc/CMstlWa
	 DPbLfu1rHjs0UgnHETGGobtebDKhvXQXELhiAKegrjkqi9pjv8cVVpXHsG814Re8e
	 fmBygbIgNzuqIGsQQyRCBV8uslfzjVJs9/QKKGiC2QRY4R4K0ECr3MKiBpCJ9tYKT
	 Ntr8tHNsh2Cmm9LbLSPMTSmzyItqOIO3G6uD7q3eeBGXx9QXhAUYImU3z1DoVMSeA
	 132fti8fZcLf23hBDewI/+r1QAX/BV7+48/UPvt7NYbOgL1Zle2VBXNX7kcZtdDXx
	 bjNtL3m/GPYVl2sA6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.115]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1uVjmg2KEj-00ynTP; Fri, 29
 Aug 2025 04:40:55 +0200
Message-ID: <1d439b1961a4f6b019e2cc56977e0860b3a7b937.camel@gmx.de>
Subject: Re: [patch] net, bcmgenet: Fix locking of netpoll facing functions
From: Mike Galbraith <efault@gmx.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>, lkml
	 <linux-kernel@vger.kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Breno Leitao <leitao@debian.org>
Date: Fri, 29 Aug 2025 04:40:54 +0200
In-Reply-To: <9b69b764-5691-4bcd-8784-eb657f13a3a4@broadcom.com>
References: <bfb21521a33b8335216ec2523bc461583ea6f7a7.camel@gmx.de>
	 <9b69b764-5691-4bcd-8784-eb657f13a3a4@broadcom.com>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:fJvPHd4AgY3VVIcOIVYA5wdRNjK+P9RA4oE+2DHzjvkusJc/MlS
 9yQgVCg6JKB4Fq1JZU55zrpTyNmUUcdujlKvaeAGlkgMz01GG9ZZ/P+GUy25DmQN4qxbPLO
 BWTEQgN8FOzSLGKQUWhoyF9QfxvsWM0KuwDubp+/PVHpU1wh/TrSkyOtNx7mvYuruErXTZk
 2luZC6yunVQqDH19us03w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HA+itFEmoIM=;PM5G8tjxNQ0Lx3S7VbN/pkMmN5a
 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
 apcOR4P7cYgT0PKK+LA

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDExOjU5IC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Ogo+IE9uIDgvMjYvMjUgMDE6MjQsIE1pa2UgR2FsYnJhaXRoIHdyb3RlOgo+ID4gTG9ja2RlcCBy
ZXBvcnRzIHJpbmctPmxvY2sgdG8gbm90IGJlIGlycSBzYWZlIGR1cmluZyBuZXRwb2xsL25ldGNv
bnNvbGUKPiA+IHNlc3Npb24sIHJlc3VsdGluZyBpbiBhIHBvdGVudGlhbCBkZWFkbG9jayBzY2Vu
YXJpby4KPiA+IAo+ID4gwqAgQ2hhaW4gZXhpc3RzIG9mOgo+ID4gwqDCoMKgICZob3N0LT5sb2Nr
IC0tPiB0YXJnZXRfbGlzdF9sb2NrIC0tPiAmcmluZy0+bG9jawo+ID4gwqDCoCBQb3NzaWJsZSBp
bnRlcnJ1cHQgdW5zYWZlIGxvY2tpbmcgc2NlbmFyaW86Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIENQ
VTDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDUFUxCj4gPiDCoMKgwqDC
oMKgwqDCoMKgIC0tLS3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtLS0t
Cj4gPiDCoMKgwqAgbG9jaygmcmluZy0+bG9jayk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvY2FsX2lycV9kaXNh
YmxlKCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxvY2soJmhvc3QtPmxvY2spOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2NrKHRh
cmdldF9saXN0X2xvY2spOwo+ID4gwqDCoMKgIDxJbnRlcnJ1cHQ+Cj4gPiDCoMKgwqDCoMKgIGxv
Y2soJmhvc3QtPmxvY2spOwo+ID4gwqDCoCAqKiogREVBRExPQ0sgKioqCj4gPiAKPiA+IFByZXZl
bnQgdGhhdCB2aWEgdXNlIG9mIGlycXNhdmUvcmVzdG9yZSBzcGlubG9jayB2YXJpYW50IHdoZW4g
cG9sbGluZy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWlrZSBHYWxicmFpdGggPGVmYXVsdEBn
bXguZGU+Cj4gCj4gWW91ciBwYXRjaCBkaWQgbm90IG1ha2UgaXQgdG8gdGhlIGFkZXF1YXRlIG1h
aWxpbmcgbGlzdCB3aGljaCBzaG91bGQgYmUgCj4gYXQgbGVhc3QgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZy4gVGhpcyBpcyBlZmZlY3RpdmVseSBhIHBhcnRpYWwgcmV2ZXJ0IG9mIAo+IGIwNDQ3ZWNi
NTMzMjcwY2Y4NTdlYmVlMTEzM2NiOGZmNjcxMTU0MjMgKCJuZXQ6IGJjbWdlbmV0OiByZWxheCBs
b2NrIAo+IGNvbnN0cmFpbnRzIHRvIHJlZHVjZSBJUlEgbGF0ZW5jeSIpIHRoZXJlZm9yZSBJIHdv
dWxkIHdhbnQgRG91ZyB0byBjaGltZSAKPiBpbiBhbmQgcmV2aWV3IHRoaXMuCgpBaCwganVzdCBk
cm9wIGl0LCBoZSdsbCBsaWtlbHkgZG8gc29tZXRoaW5nIHdheSBiZXR0ZXIuCgoJLU1pa2UK


