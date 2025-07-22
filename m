Return-Path: <linux-kernel+bounces-740092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43963B0CFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AD4542FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A061C07D9;
	Tue, 22 Jul 2025 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="N60RubnK"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CCE1A3172
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151163; cv=none; b=NzSMpQUHfFo2A9+A2LWuhyTlNVDPHI4GCREgqvVyUSxhwGERSg+3QUAZSZFDteUUfQL2uZicWwgYJCOb6WBCytnP/EzJPIAxq07J/BUENw/Un6WwyfptJUgp8ejBBYsUJmz60UFijahIY/2Pkg2CtvrRj8sDkAGa4aVRaKF26fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151163; c=relaxed/simple;
	bh=wmgjnn0LAOZvIo5oEmrzZfWX39RXEORohD/jyIPrn/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iaF7uaWdUhANOUCvzKGRJtiUfEx2VgYRlfOIZR6Qb5bC24YNQr5Ut1RvfFuusENN6xhWR5sagYvM4nEpxARP1D1YONlQJdCnEUEZgVi9dcVVM0h5QMoedwpvPKjDD35HdUce2Oi14N0DPcm61d2Nyg91nGRIu444kh5Eg/s9pzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=N60RubnK reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=F3/1wngqX+Wu+6lJd15onh+YsYAHkVuHju6ffWNz/Ys=; b=N
	60RubnKQTQSyjckW9X7NJikEvhIHYF86Z27XDEWwqgdtE9jVCzgMgzgI4hKTpVkc
	WCB+GNRiZ71hhLoMkUvI+XWolCanQxiaOimPKmVF837NM3k8yAIjHdyJmMlHK3gO
	116V6irr/FcNutrxFjXml0GpZGFB4ju657cmd/3BZs=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Tue, 22 Jul 2025 10:24:41 +0800
 (CST)
Date: Tue, 22 Jul 2025 10:24:41 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>,
	"Algea Cao" <algea.cao@rock-chips.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>,
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	"Andy Yan" <andy.yan@rock-chips.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"David Airlie" <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Andrzej Hajda" <andrzej.hajda@intel.com>,
	"Neil Armstrong" <neil.armstrong@linaro.org>,
	"Robert Foss" <rfoss@kernel.org>,
	"Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
	"Jonas Karlman" <jonas@kwiboo.se>,
	"Jernej Skrabec" <jernej.skrabec@gmail.com>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH 1/5] drm/rockchip: vop2: Add high color depth support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250721-rk3588-10bpc-v1-1-e95a4abcf482@collabora.com>
References: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
 <20250721-rk3588-10bpc-v1-1-e95a4abcf482@collabora.com>
X-NTES-SC: AL_Qu2eAf2evkgj5yOeYukfmUkTh+o2Xca5uf0j3YBWOZh+jCDp+QI/WUd7PHfV+c6FAj2WqyCvXhFv2v9ITLdpdJIwTpaeYzlfUPg8tbtiKtr9eA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3ceb2c70.2145.1982ff28b9c.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD3V1dp9n5ohpQDAA--.33785W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0huSXmh+8qp0lQABsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhlbGxvIENyaXN0aWFu77yMCgpBdCAyMDI1LTA3LTIyIDAxOjM5OjA0LCAiQ3Jpc3RpYW4gQ2lv
Y2FsdGVhIiA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+VGFrZSB0
aGUgYml0cyBwZXIgY29sb3IgY2hhbm5lbCBpbnRvIGNvbnNpZGVyYXRpb24gd2hlbiBjb21wdXRp
bmcgRENMSwo+cmF0ZS4KPgo+U2lnbmVkLW9mZi1ieTogQ3Jpc3RpYW4gQ2lvY2FsdGVhIDxjcmlz
dGlhbi5jaW9jYWx0ZWFAY29sbGFib3JhLmNvbT4KPi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9yb2Nr
Y2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jIHwgMyArKysKPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2No
aXBfZHJtX3ZvcDIuYyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9w
Mi5jCj5pbmRleCAxODZmNjQ1MmE3ZDM1OWYwNzk2NjJiYzU4MDg1MDkyOTYzMmVhOGZlLi5hNzE0
YmNiYjAyZGUxNjI2N2U3ZmViYmFlYjFlYjI3MGM3MGFhZWYyIDEwMDY0NAo+LS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMKPisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jCj5AQCAtMTczMSw2ICsxNzMxLDkgQEAg
c3RhdGljIHZvaWQgdm9wMl9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRj
LAo+IAkJY2xvY2sgKj0gMjsKPiAJfQo+IAo+KwlpZiAodmNzdGF0ZS0+b3V0cHV0X2JwYyA+IDgp
Cj4rCQljbG9jayA9IERJVl9ST1VORF9DTE9TRVNUKGNsb2NrICogdmNzdGF0ZS0+b3V0cHV0X2Jw
YywgOCk7CgoKVGhpcyBzZWVtcyBub3QgcmlnaHQsICByZWdhcmRsZXNzIG9mIHRoZSB2YWx1ZSBv
ZiBicGMsIHRoZSBkY2xrIG9mIFZPUCBtdXN0IGJlCmNvbnNpc3RlbnQgd2l0aCBtb2RlLT5jcnRj
X2Nsb2NrLgpJZiB0aGUgZGNsayBvZiBWT1AgaXMgaW5jcmVhc2VkIGluIGFjY29yZGFuY2Ugd2l0
aCB0aGUgQlBDIHJhdGlvIGhlcmUsIHRoZW4gdGhlIHJlZnJlc2ggcmF0ZSBvZiBWT1Agd2lsbCBh
bHNvIGluY3JlYXNlIHByb3BvcnRpb25hbGx5LgpUaGlzIHdvdWxkIGJlIGluY29uc2lzdGVudCB3
aXRoIHRoZSB0aW1pbmcgZGVzY3JpYmVkIGluIHRoZSBtb2RlLgpGb3IgYSBoaWdodCBjb2xvciBk
ZXB0aCwgIHRoZSBmcmVxdWVuY3kgbmVlZHMgdG8gYmUgaW5jcmVhc2VkIGZvciB0aGUgSERNSSBQ
SFkncyBjbG9jay4KCgo+Kwo+IAl2b3AyX3ZwX3dyaXRlKHZwLCBSSzM1NjhfVlBfTUlQSV9DVFJM
LCAwKTsKPiAKPiAJLyoKPgo+LS0gCj4yLjUwLjAK

