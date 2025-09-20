Return-Path: <linux-kernel+bounces-825551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FAB8C362
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B21889996
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A00279917;
	Sat, 20 Sep 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEvQZ4/Z"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5A26C3B6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354592; cv=none; b=I1HqAAdtUOvLgsTH2s6pnB6EUupC1UvpkZsYF8fsuaYChqrU2u1P2v1j6fEv1n8vU+pJfLpZlKlt2TXG/SsiWDpRlGwL7Z2y7fTxo/SrITirLlXcsRKKQYUXyWg/MeN6zigNHTQdC7vjgO5/Trve2kTyWQgnOAy3xEW76nzrXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354592; c=relaxed/simple;
	bh=Av7lrNl4YgFBqMyVpgO2SYk1KzNjNc1S5U5FzQ/6NHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKnjn4hhWMN0TJIXw1TLlq5503mGoCHNLtiAZiMY6c33/fOaNgnFim5SlgrddpvZrt7j97M9hVal8XPrOTJfZ21xS8THgHWvcq/7Zgu90F3bDutqBBuoFO4WsPT1xJqvE64v4VS3rNuuYYGosPhQwwYKHQnkXxL9afBewr9tktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEvQZ4/Z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a16441so416709366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758354589; x=1758959389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av7lrNl4YgFBqMyVpgO2SYk1KzNjNc1S5U5FzQ/6NHE=;
        b=PEvQZ4/ZcE6+Ab5AQnCgZEQ6IdeB2gSJJGaDwO3/2G/33SSL9+vN+z+QtnuhRGxFYO
         WLGRtjK+RO2UkAxvBrK6vCEbrHafDMnsIDB73wMzkuIxJ3VBd05tEvkQ/qzfySB+F5/d
         DP9eKn/i+NilrYS65H90uYc1znYz9BIPSSF9ViVwG5rtHOh88hO8JN0FfK/PWqK9skbd
         UZ6CfvkQ57rqwhyhnItHiYeOpKgsz+Mf73l0ixJH/Tc7CmHoZ8ihGXZM24IlCu4svS+p
         ogN/QjAfR+IVQmlDsZKUMok2hEIwPpXlbtlqAXtX2xG35D+bZG0uggUpfrkm+7MjVIG0
         jS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758354589; x=1758959389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av7lrNl4YgFBqMyVpgO2SYk1KzNjNc1S5U5FzQ/6NHE=;
        b=bOtHuvHObN5DNmLlwZ9c7W3sgOdYTMVWvpvuIUZrOkRJheSw2MMJjBoGyMzEvtpr/D
         5BxuL4vvZW/lBgGCj2k92yE4Yu/cd+unhJ4DaSivSOBpVt1sx0fCVTKqq6hAMfewU3M5
         A9bD5MyT+mJxoWZs6PLhYuSqvnpo2QBlEoh+frhF5ayeZB6VrFNejd3C5v5uG/57WCjv
         5Rm0Ul5sC0q0+J3MLMW4+0MJkkq2rrKg0pe+uqFDvQ6vVkzBZ4axbcF4Zzo3XMMSZXbo
         F4or1zFcrxAGnzOW8pLOdSmxFLHsiBsMIrc+JehudK33k7cHOjSyqo994ikGJU/KnkKG
         MQlg==
X-Forwarded-Encrypted: i=1; AJvYcCW0DE0Y+m7rLB0rK5Ubr+8Me1zpqf5zvNJQm6BHU7XgflHh2p+qkofTRGHWE2imY+KuU9cGOtXn1IQxVPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBwF7jlPf3yJLcNwYuvnjG5/hcl24X+AUDsE6N3qk484/OYsf
	7Ip/7LVHKcn3o8evZkjb/1LOA5nveRmOHPqXGgL5zfPfVToaJ7mIEDTOVL2BOSgUr6GnF6HsGpo
	CTUhByetgDP6RLxCmX5vr/a8m1KZLOlA=
X-Gm-Gg: ASbGncsgtLy0O2aYHjHNpdO1D4AXpt5aEIx5IKt8wLmijfMI8WqVYlDF+kTcmjfQGpY
	fhSopNcwBSJg2kZ5GEDNoJ09R/Mk9ap0/5aEImDIErhnvfwuwPzmgFjoVHAQMprcBmDCIpADFHO
	yd7pgwBtqY+KY5lxARoh81T48mNjGbJxGz2Wkhijfb5XsOFonu3MuB1T1JN2rntePdiC4UePWE7
	kV42zU=
X-Google-Smtp-Source: AGHT+IHpyjk16PmMGjgpmJ32eHdu+viAzqxrIIM8/PHA08Nc0k6yqdFGL83GkBb2++1I+Uzinp3kHqIP4ACJxvIffzU=
X-Received: by 2002:a17:906:9f8c:b0:b0c:1701:bf77 with SMTP id
 a640c23a62f3a-b24eedb990bmr668692766b.18.1758354588717; Sat, 20 Sep 2025
 00:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917073010.88607-1-zhaoshuo@cqsoftware.com.cn> <f27e3d04-ced6-459c-993f-b5495257fa3f@linux.dev>
In-Reply-To: <f27e3d04-ced6-459c-993f-b5495257fa3f@linux.dev>
From: Alex Shi <seakeel@gmail.com>
Date: Sat, 20 Sep 2025 15:49:12 +0800
X-Gm-Features: AS18NWBB-4cecjuKls_frs--SGWiPru1Rvwx9dDopEec980Nt4tli3aTJo0pdqo
Message-ID: <CAJy-AmnJyGvoOJ3JX=wnon-uo7_ViX3bWiF8m-qMuPQfZJNdvg@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add security lsm-development Chinese translation
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>, alexs@kernel.org, corbet@lwn.net, 
	dzm91@hust.edu.cn, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

QXBwbGllZCwgVGhhbmtzDQoNCllhbnRlbmcgU2kgPHNpLnlhbnRlbmdAbGludXguZGV2PiDkuo4y
MDI15bm0OeaciDE35pel5ZGo5LiJIDE2OjM05YaZ6YGT77yaDQo+DQo+DQo+IOWcqCA5LzE3LzI1
IDM6MzAgUE0sIFNodW8gWmhhbyDlhpnpgZM6DQo+ID4gVHJhbnNsYXRlIC4uLi9zZWN1cml0eS9s
c20tZGV2ZWxvcG1lbnQucnN0IGludG8gQ2hpbmVzZS4NCj4gPg0KPiA+IFVwZGF0ZSB0aGUgdHJh
bnNsYXRpb24gdGhyb3VnaCBjb21taXQgNmQyZWQ2NTMxODViDQo+ID4gKCJsc206IG1vdmUgaG9v
ayBjb21tZW50cyBkb2NzIHRvIHNlY3VyaXR5L3NlY3VyaXR5LmMiKS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNodW8gWmhhbyA8emhhb3NodW9AY3Fzb2Z0d2FyZS5jb20uY24+DQo+DQo+IFJl
dmlld2VkLWJ5OiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAY3Fzb2Z0d2FyZS5jb20uY24+DQo+DQo+
DQo+IFRoYW5rcywNCj4NCj4gWWFudGVuZw0KPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL3RyYW5zbGF0
aW9ucy96aF9DTi9zZWN1cml0eS9pbmRleC5yc3QgICAgIHwgIDIgKy0NCj4gPiAgIC4uLi96aF9D
Ti9zZWN1cml0eS9sc20tZGV2ZWxvcG1lbnQucnN0ICAgICAgICB8IDE5ICsrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL3NlY3VyaXR5L2xzbS1kZXZlbG9wbWVudC5yc3QNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zZWN1cml0eS9pbmRleC5yc3QgYi9E
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zZWN1cml0eS9pbmRleC5yc3QNCj4gPiBp
bmRleCA3OGQ5ZDRiMzZkY2EuLjA1ZDI0ZTNhY2MxMSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zZWN1cml0eS9pbmRleC5yc3QNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zZWN1cml0eS9pbmRleC5yc3QNCj4gPiBA
QCAtMTgsNiArMTgsNyBAQA0KPiA+ICAgICAgY3JlZGVudGlhbHMNCj4gPiAgICAgIHNucC10ZHgt
dGhyZWF0LW1vZGVsDQo+ID4gICAgICBsc20NCj4gPiArICAgbHNtLWRldmVsb3BtZW50DQo+ID4g
ICAgICBzYWsNCj4gPiAgICAgIHNlbGYtcHJvdGVjdGlvbg0KPiA+ICAgICAgc2lwaGFzaA0KPiA+
IEBAIC0yOCw3ICsyOSw2IEBADQo+ID4gICBUT0RPTElTVDoNCj4gPiAgICogSU1BLXRlbXBsYXRl
cw0KPiA+ICAgKiBrZXlzL2luZGV4DQo+ID4gLSogbHNtLWRldmVsb3BtZW50DQo+ID4gICAqIFND
VFANCj4gPiAgICogc2VjcmV0cy9pbmRleA0KPiA+ICAgKiBpcGUNCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vc2VjdXJpdHkvbHNtLWRldmVsb3BtZW50
LnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NlY3VyaXR5L2xzbS1kZXZl
bG9wbWVudC5yc3QNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uN2VkMzcxOWE5ZDA3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NlY3VyaXR5L2xzbS1kZXZlbG9wbWVudC5yc3QNCj4g
PiBAQCAtMCwwICsxLDE5IEBADQo+ID4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQo+ID4gKy4uIGluY2x1ZGU6OiAuLi9kaXNjbGFpbWVyLXpoX0NOLnJzdA0KPiA+ICsNCj4g
PiArOk9yaWdpbmFsOiBEb2N1bWVudGF0aW9uL3NlY3VyaXR5L2xzbS1kZXZlbG9wbWVudC5yc3QN
Cj4gPiArDQo+ID4gKzrnv7vor5E6DQo+ID4gKyDotbXnoZUgU2h1byBaaGFvIDx6aGFvc2h1b0Bj
cXNvZnR3YXJlLmNvbS5jbj4NCj4gPiArDQo+ID4gKz09PT09PT09PT09PT09PT09DQo+ID4gK0xp
bnV45a6J5YWo5qih5Z2X5byA5Y+RDQo+ID4gKz09PT09PT09PT09PT09PT09DQo+ID4gKw0KPiA+
ICvln7rkuo5odHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMDcxMDI2MDczNzIxLjYxOGI0Nzc4
QGxhcHRvcGQ1MDUuZmVucnVzLm9yZ++8jA0KPiA+ICvlvZPkuIDnp43mlrDnmoRMU03nmoTmhI/l
m77vvIjlroPor5Xlm77pmLLojIPku4DkuYjvvIzku6Xlj4rlnKjlk6rkupvmg4XlhrXkuIvkurrk
u6zkvJrmnJ/mnJvkvb/nlKjlroPvvInlnKgNCj4gPiArYGBEb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL0xTTS9gYCDkuK3pgILlvZPorrDlvZXkuIvmnaXlkI7vvIzlsLHkvJrooqvmjqXlj5fov5vl
haXlhoXmoLjjgIINCj4gPiAr6L+Z5L2/5b6XTFNN55qE5Luj56CB5Y+v5Lul5b6I6L275p2+55qE
5LiO5YW255uu5qCH6L+b6KGM5a+55q+U77yM5LuO6ICM6K6p5pyA57uI55So5oi35ZKM5Y+R6KGM
54mI5Y+v5Lul5pu0DQo+ID4gK+aYjuaZuuWcsOWGs+WumumCo+S6m0xTTemAguWQiOS7luS7rOea
hOmcgOaxguOAgg0KPiA+ICsNCj4gPiAr5pyJ5YWz5Y+v55So55qEIExTTSDpkqnlrZDmjqXlj6Pn
moTor6bnu4bmlofmoaPvvIzor7flj4LpmIUgYGBzZWN1cml0eS9zZWN1cml0eS5jYGAg5Y+K55u4
5YWz57uT5p6E44CCDQo=

