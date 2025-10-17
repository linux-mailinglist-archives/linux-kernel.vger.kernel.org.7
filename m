Return-Path: <linux-kernel+bounces-857646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB06BE7556
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD604628D09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1012D5C8E;
	Fri, 17 Oct 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="BCNdO21o"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0F21B185;
	Fri, 17 Oct 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691523; cv=none; b=Iywn5GWl4hOZsWkaiIy4TESvxjo9Ia+xkzoPfnOfNGTOqpbvR5L3J/sHVnp3K88Y+VaOuHsYiFaHu+gLrhM5I2WdyxKKaPEwICvcM+kPIxMmDFvVKeh7RZJC/4HG/90CLVOZ4mNOLB0FqD6LLUSLrwezZaamZtpjlNffOUBoNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691523; c=relaxed/simple;
	bh=Y+TxpN+8v3D/wFUbqbHk8ljRzYJDzRbfCfOGr2ucmQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YJuXktGLmNgOgLGez46mGNexVEBGF9JijPfnQH1i8Ds3x81y1a4d1G+AoYy9amWxw/Ma++wsiWylG+wAHU6ZjvZqmUHPNIV3zijdQFeo2gGdzOtYInr97/TLGnST7uKGM06PX+f/G6GOuJmfp8xzjh411gSnq1bjY12vJhfQCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=BCNdO21o reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0I00pQnbY1u48SLSbfkjT/kC6CPcVg5dby2NqOBL3+k=; b=B
	CNdO21oTuVDDYpNEGDxqBTpsymKzpM4FzG/XkmpdVAk9FZEHsrHwtoFzZBBsj6si
	w7FLyqTo7h1hEPjRZqZUHKJqUkReB0k5FyxNNWSTls0p+d/8FjzRUdF3/twcUef8
	JkMF4RsTTxEu8yC4QwDVohHV862zRxhK0WwwmR9LcA=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Fri, 17 Oct 2025 16:56:38 +0800
 (CST)
Date: Fri, 17 Oct 2025 16:56:38 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Maud Spierings" <maud_spierings@murena.io>
Cc: Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
	andy.yan@rock-chips.com, devicetree@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
	heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
	knaerzche@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re:Re: [PATCH v8 2/2] MAINTAINERS: Add entry for Innosilicon hdmi
 bridge library
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <040d8fe8-da2f-4aa5-a2c3-1aec0cf2e8f0@murena.io>
References: <20251016083843.76675-3-andyshrk@163.com>
 <040d8fe8-da2f-4aa5-a2c3-1aec0cf2e8f0@murena.io>
X-NTES-SC: AL_Qu2dAvqSvksi7iKcZekfmUgWjuw/WsG1v/Ul1YBSP556jC/r8zkjQUF9DEnN7/uOLACpsBq9WjdwxuR2UoVeWLsLcVeD6Y6TtCYHViqiBA2GRw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <671fc19.84e3.199f162a66c.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgAnDpjGBPJodsENAA--.5725W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gTpXmjyAwEUgwACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIZWxsbyBNYXVk77yMCgpBdCAyMDI1LTEwLTE3IDE1OjU4OjIyLCAiTWF1ZCBTcGllcmluZ3Mi
IDxtYXVkX3NwaWVyaW5nc0BtdXJlbmEuaW8+IHdyb3RlOgo+SGkgQW5keSwKPgo+PiBGcm9tOiBB
bmR5IFlhbiA8YW5keS55YW5Acm9jay1jaGlwcy5jb20+Cj4+IAo+PiBBZGQgZW50cnkgZm9yIElu
bm9zaWxpY29uIGhkbWkgYnJpZGdlIGxpYnJhcnkKPj4gCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHkg
WWFuIDxhbmR5LnlhbkByb2NrLWNoaXBzLmNvbT4KPj4gLS0tCj4+IAo+PiAobm8gY2hhbmdlcyBz
aW5jZSB2MSkKPj4gCj4+ICBNQUlOVEFJTkVSUyB8IDggKysrKysrKysKPj4gIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTCj4+IGluZGV4IGY5Zjk4NWM3ZDc0NzkuLjBhZGNmYjFjMjY0YTEgMTAwNjQ0Cj4+
IC0tLSBhL01BSU5UQUlORVJTCj4+ICsrKyBiL01BSU5UQUlORVJTCj4+IEBAIC0xMjI5OSw2ICsx
MjI5OSwxNCBAQCBNOglTYW11ZWwgSG9sbGFuZCA8c2FtdWVsQHNob2xsYW5kLm9yZz4KPj4gIFM6
CU1haW50YWluZWQKPj4gIEY6CWRyaXZlcnMvcG93ZXIvc3VwcGx5L2lwNXh4eF9wb3dlci5jCj4+
ICAKPj4gK0lOTk9TSUxJQ09OIEhETUkgQlJJREdFIERSSVZFUgo+PiArTToJQW5keSBZYW4gPGFu
ZHkueWFuQHJvY2stY2hpcHMuY29tPgo+PiArTDoJZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+PiArUzoJTWFpbnRhaW5lZAo+PiArVDoJZ2l0IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNr
dG9wLm9yZy9kcm0vbWlzYy9rZXJuZWwuZ2l0Cj4+ICtGOglkcml2ZXJzL2dwdS9kcm0vYnJpZGdl
L2lubm8taGRtaS5jCj4+ICtGOglpbmNsdWRlL2RybS9icmlkZ2UvaW5ub19oZG1pLmgKPj4gKwo+
PiAgSU5PVElGWQo+PiAgTToJSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPj4gIFI6CUFtaXIgR29s
ZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4+IC0tIAo+PiAyLjQzLjAKPgo+SSBiZWxpZXZl
IHRoaXMgcGF0Y2ggc2hvdWxkIGJlIHNxdWFzaGVkIGludG8gdGhlIHBhdGNoIHRoYXQgYWN0dWFs
bHkgCj5jcmVhdGVzIHRoZSBmaWxlcyBsaXN0ZWQgaW4gdGhlIE1BSU5UQUlORVJTIGVudHJ5LCBs
aWtlIEkgZG8gaGVyZSBbMV0uIAo+Q2hlY2twYXRjaCBzaG91bGQgYmUgY29tcGxhaW5pbmcgYWJv
dXQgcGF0Y2ggWzEvMl0gaWYgSSdtIG5vdCBtaXN0YWtlbiwgCj53aGVuIHlvdSBydW4gYGI0IHBy
ZXAgLS1jaGVja2AuCgpXZSB0YWxrZWQgYWJvdXQgc29tZXRoaW5nIHNpbWlsYXIgaGVyZVsyXe+8
mgpNYXhpbWUgYmVsaWV2ZXMgdGhleSBzaG91bGQgYmUgc2VwYXJhdGUgcGF0Y2hlcywgCkFuZCBJ
J3ZlIHNlZW4gbWFueSBtZXJnZWQgY29tbWl0cyBpbiB0aGUga2VybmVsIGFyZSBhbHNvIGhhbmRs
ZSBNQUlOVEFJTkVSUyBlbnRyeSBhcyBzZXBhcmF0ZSBwYXRjaGVzCgoKWzJdaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtcm9ja2NoaXAvM3lncW5qNGlkZXk3dTRtN2x0bHY3cG5maGtrdmNl
cG1wZmRpamRzemN0YWVvcHEza3lAcXRlZzMzY29tamwzLwoKPgo+TGluazogCj5odHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNTEwMDktbWF4MjUwMTQtdjQtMS02YWRiMmEwYWEzNWZAZ29j
b250cm9sbC5jb20vIAo+WzFdCj4KPktpbmQgcmVnYXJkcywKPk1hdWQK

