Return-Path: <linux-kernel+bounces-712843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64BAF0FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110581C27BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF3248F58;
	Wed,  2 Jul 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C616y9zV"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5123E355
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447853; cv=none; b=sHgbsOaHi8IGOOxRxUT1Ekv5cofjxc/mns1xbdYphsZapk/a956+X49UaeEFe5MrCFmUDorvMFZ5KQjPAO94P9J8D/9OU5j177huyMMex/CmYmLqXESR9+XTTrZAeqAH5LFUUrvCSqMnDVlr4vT0UTqPPONc2aTPquNb81cC080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447853; c=relaxed/simple;
	bh=bHPVeNBoTnZElvxKe/8KwnQOOGHpXQgJXaxKscKwyT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BbvcNA8uaCTOUBVyJ6F8/EU9+kumAx8qhU+6AtrPO+DAYNAkGY+es0pRRlMkCZOuR+ySFdDkPOjMaQ+fJTvp+DZIOJL1/bKm0C/upZyQDzX+ZJhMv0lo7e/8Dagvk8v9c2blEYHsVqqYoeLWdFgKPZewcnMvTr39pCZM+aip5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C616y9zV; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bHPVeNBoTnZElvxKe/8KwnQOOGHpXQgJXaxKscKwyT4=; b=C
	616y9zVPvy0WzLVZ9taP+BjCsl5yxenJl7BavwxWZ7YHetQtay12mOK96WlZt3aB
	bXCVxc7kyaDUdSz52HJHzrjR9hbIyiwhOFTaJlxrNnQa7ERU5TaWbZU87ALC7v+p
	t93AstM3FADCW3FQx4PmeK/jUgqtEmMXMNMictbN+4=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Wed, 2 Jul 2025 17:16:34 +0800 (CST)
Date: Wed, 2 Jul 2025 17:16:34 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH] drm: Fix one indentation issue in drm_auth.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250516092343.3206846-1-andyshrk@163.com>
References: <20250516092343.3206846-1-andyshrk@163.com>
X-NTES-SC: AL_Qu2eA/ifuE8i4ieYYekfmkcVgOw9UcO5v/Qk3oZXOJF8jC/rxCoxfntMEmPnyfOOFCWcrheYUhhh58BWV4JgQoINpAFmLe8dcvu7fJU9O2zIlw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <130edc4.8bc8.197ca6c7416.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgDnP4Ty+GRoErQAAA--.6847W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAh+Xmhk9BukqAABsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CnBpbmcKCkF0IDIwMjUtMDUtMTYgMTc6MjM6MzgsICJBbmR5IFlhbiIgPGFuZHlzaHJrQDE2My5j
b20+IHdyb3RlOgo+VGhpcyBzaG91bGQgYmUgb25lIHNwYWNlLgo+Cj5TaWduZWQtb2ZmLWJ5OiBB
bmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4KPi0tLQo+Cj4gaW5jbHVkZS9kcm0vZHJtX2F1dGgu
aCB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pgo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9hdXRoLmggYi9pbmNsdWRlL2RybS9kcm1f
YXV0aC5oCj5pbmRleCA1MDEzMTM4M2VkODEuLjgzMDM4NjgwNGY5MSAxMDA2NDQKPi0tLSBhL2lu
Y2x1ZGUvZHJtL2RybV9hdXRoLmgKPisrKyBiL2luY2x1ZGUvZHJtL2RybV9hdXRoLmgKPkBAIC04
Niw3ICs4Niw3IEBAIHN0cnVjdCBkcm1fbWFzdGVyIHsKPiAJICogSUQgZm9yIGxlc3NlZXMuIE93
bmVycyAoaS5lLiBAbGVzc29yIGlzIE5VTEwpIGFsd2F5cyBoYXZlIElEIDAuCj4gCSAqIFByb3Rl
Y3RlZCBieSAmZHJtX2RldmljZS5tb2RlX2NvbmZpZydzICZkcm1fbW9kZV9jb25maWcuaWRyX211
dGV4Lgo+IAkgKi8KPi0JaW50CWxlc3NlZV9pZDsKPisJaW50IGxlc3NlZV9pZDsKPiAKPiAJLyoq
Cj4gCSAqIEBsZXNzZWVfbGlzdDoKPi0tIAo+Mi40My4wCj4KPmJhc2UtY29tbWl0OiBhNGYzYmU0
MjJkODc5NThlZjlmMTdkOTZkZjE0MmU1ZDU3M2QyZjIzCj5icmFuY2g6IGRybS1taXNjLW5leHQK


