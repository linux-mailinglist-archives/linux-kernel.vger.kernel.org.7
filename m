Return-Path: <linux-kernel+bounces-795885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9722B3F8F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68432054E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D82E92B2;
	Tue,  2 Sep 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="USXEe7IO"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DA2E8B8F;
	Tue,  2 Sep 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802612; cv=none; b=mp4bJXD/r/q48E1y9Wp1laeAH26WRlWZEeA//nAsVt+noJ7T+l6FweQx28/Cc4RoQ3poZaT98exbDHBoxhVRPfOAQzn+ANfzfN+WcZzw55qbDddk//kTeUTGG3LyJW7hH1n89+uamKl+omVT5X3kMbccRrg+xU+5f0sPllszW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802612; c=relaxed/simple;
	bh=JOhdePyrldq83s7uzbBWtQrWObepHL7/NVcs8ZomnrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dtQx033yhHWpWOUtc0xIts1HX/7IbKDVgGHyzcxX+G10igwMP/gSX1x/U0Ya+hGPYZzBNOtEieiWDZyMa5ioG9ambCh7lA6CQuRLwJIZmNrIOd888JrlFAFvJKQbRRMyu5URoEVJoi1lsLwtZJksyegl8e2xrqRhonsI1Ti0Kis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=USXEe7IO reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=cEoytsRSZ7lw9spftoCa7nl7vw+AKfeCGaB+qA3p5/Q=; b=U
	SXEe7IOZmhXc24z/WY+QBdZA5G00bzLFSJ+yHcxSUJ4DtRwQgjVAXZMiiJmCdKJF
	MmYVO265B8XNtf3aViy8zrrmpIj1ofXjN/TH23WnLCjQ1Z6iONNQYuJNZ5ejKwOW
	6uDywsGBsa7tjaeD06rK3AHIr6aptPO12mHVkeQPso=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-116 (Coremail) ; Tue, 2 Sep 2025 16:42:41 +0800 (CST)
Date: Tue, 2 Sep 2025 16:42:41 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Andy Yan" <andy.yan@rock-chips.com>,
	"Andrzej Hajda" <andrzej.hajda@intel.com>,
	"Neil Armstrong" <neil.armstrong@linaro.org>,
	"Robert Foss" <rfoss@kernel.org>,
	"Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
	"Jonas Karlman" <jonas@kwiboo.se>,
	"Jernej Skrabec" <jernej.skrabec@gmail.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"David Airlie" <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re:[PATCH next] drm/bridge: synopsys: Fix an error return in
 dw_dp_video_need_vsc_sdp()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aLaPyJrFsSFuqC1R@stanley.mountain>
References: <aLaPyJrFsSFuqC1R@stanley.mountain>
X-NTES-SC: AL_Qu2eBPSbvU0t5yKcZ+kfmUgWjuw/WsG1v/Ul1YBSP556jD3p4zIfY19KDFLO6/uKGTmTvRGeVDJ+2NRqdIdzW58VIsIXS9JjI+R6w8EF2qEi4g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5f9e8942.7fec.1990997b4de.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCgvCgD33+4BrrZobmwnAA--.2358W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwO8Xmi2pu7zZQABsT
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhlbGxvIERhbiwKCkF0IDIwMjUtMDktMDIgMTQ6MzM6NDQsICJEYW4gQ2FycGVudGVyIiA8ZGFu
LmNhcnBlbnRlckBsaW5hcm8ub3JnPiB3cm90ZToKPlRoaXMgZHdfZHBfdmlkZW9fbmVlZF92c2Nf
c2RwKCkgZnVuY3Rpb24gaXMgdHlwZSBib29sIHNvIHJldHVybmluZwo+LUVJTlZBTCBtZWFucyBy
ZXR1cm5pbmcgdHJ1ZS4gIFJldHVybiBmYWxzZSBpbnN0ZWFkLgo+Cj5GaXhlczogODZlZWNjM2E5
YzJlICgiZHJtL2JyaWRnZTogc3lub3BzeXM6IEFkZCBEVyBEUFRYIENvbnRyb2xsZXIgc3VwcG9y
dCBsaWJyYXJ5IikKPlNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJA
bGluYXJvLm9yZz4KCgpSZXZpZXdlZC1ieTogQW5keSBZYW4gPGFuZHlzaHJrQDE2My5jb20+CgoK
Pi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYyB8IDIgKy0KPiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYwo+aW5kZXggOWJiZmU4ZGEzZGUwLi4zM2JlNGVh
ZTJiMjAgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRw
LmMKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctZHAuYwo+QEAgLTEx
NDksNyArMTE0OSw3IEBAIHN0YXRpYyBib29sIGR3X2RwX3ZpZGVvX25lZWRfdnNjX3NkcChzdHJ1
Y3QgZHdfZHAgKmRwKQo+IAo+IAlzdGF0ZSA9IGR3X2RwX2dldF9icmlkZ2Vfc3RhdGUoZHApOwo+
IAlpZiAoIXN0YXRlKQo+LQkJcmV0dXJuIC1FSU5WQUw7Cj4rCQlyZXR1cm4gZmFsc2U7Cj4gCj4g
CWlmICghbGluay0+dnNjX3NkcF9zdXBwb3J0ZWQpCj4gCQlyZXR1cm4gZmFsc2U7Cj4tLSAKPjIu
NDcuMgo=

