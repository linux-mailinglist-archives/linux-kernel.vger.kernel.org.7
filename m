Return-Path: <linux-kernel+bounces-789381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F938B394BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5D7C7B24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949332D24BE;
	Thu, 28 Aug 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SiEBwDhk"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339E2D0612
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364821; cv=none; b=RNFYZfIEMag2/F/cgofrECLurJCbNRwXtacXvOpAaTVlkKCM6ewQ+/10yGOKEtdF6n7n27njluEpgpCrMEaDm/3jqCafOuHeRV0t6jfvJJihceYG7Z56XR6WcqVal8Ly4//AI0KlIlM587tGWs9diwOM1LkO5/WPCCc2okOWevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364821; c=relaxed/simple;
	bh=iXYkDS/xZa2AbKSL4NnkU91Vx0JuRxZnRduo7ytTzwU=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=K9UoWAc4jf8qsbcotGsJpm+wng7zLrJGraqt/LchF4nS/GCZ0BsPagppc+xSkwmFB7LCI8CTpIY6H6zY7/r2CIteMj9aRdTWnUaE0vs+oYfW2qbgjM8VWFG0Qy0GNlMYRHOC+A17RgDqjZCaeUb5w8Vw/NkvDyISihgi1Y7oZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SiEBwDhk; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756364777;
	bh=iXYkDS/xZa2AbKSL4NnkU91Vx0JuRxZnRduo7ytTzwU=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=SiEBwDhkJbez3zWACv5h6+szVl2/89E900WbfNFKpnRPBHaMYCxgzW1hNtaiKZ9vb
	 v+FDrdBMaSxESApYQ5cz9YAo+62zZhmFgzW2YZsh4HSezlE5WaI3zAQipg6376blMg
	 BHiPPb8cdAbwLIIlP36diZR7oh4plMC5fuFtBgPE=
EX-QQ-RecipientCnt: 6
X-QQ-GoodBg: 1
X-QQ-SSF: 0040000000000000
X-QQ-FEAT: 1LZBGsge1Z42dw8meDLbRnaNYOtDu44q
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: iP39a7Lhf4uQnPcdOfXuMGmaJC52/MKbrO3g+EtIuY2HdMW2zOKSGA+OV8BlDwHdLvf4tjVCcKWa9UJbsvx2+g==
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1756364773tbdd6b7d2
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?WGkgUnVveWFv?=" <xry111@xry111.site>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>
Cc: "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS no-bultin-memcpy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 28 Aug 2025 15:06:12 +0800
X-Priority: 3
Message-ID: <tencent_6579F3317CCF94D00EC3C7DD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250826113225.406238-1-guanwentao@uniontech.com>
	<20d3df642aaff2a771e74452b81463709f7c16d1.camel@xry111.site>
In-Reply-To: <20d3df642aaff2a771e74452b81463709f7c16d1.camel@xry111.site>
X-QQ-ReplyHash: 3242655864
X-BIZMAIL-ID: 12844274570607954762
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 28 Aug 2025 15:06:14 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MA25rb7c/K0AGj94oJEjB3MJ9uP7MTuq6tOTQDhwBjJCOWqJpxzy+rRl
	h4pcsEuGVR0iFIFwQnGHwHphVwK3nwmiUA+7fg/x+SCMdPD5nfQZXD2rbtY/tEZV1TwlxXy
	cwRP13yL59VZfVBnDP94ETctyU8m6Ii4lXyH3z4rXDZuLiuGA1msIDphO1qqv+lHN6k6qNZ
	K1h/7m1H88qwk6Eu6lplg6kbDtX1Oll3UmtDeVBmXrk8CpzEG8rKzzBZci/elF1oCpJxuyB
	i3tM29CJCfQccDOTmGflIC+caeuArdhakXQFDtzWAl0cUBDc0MpX9jkJaY8ENRpKVqIWL3V
	HLa+TRtBBPaXv5eEm219Kh1u29o5dOl9e+sTK/VCcGuajG2XuKuzWONcXPBb38T2b7LCxRU
	jiZA2RpEdBAvReLvWrXnn4PSZOjv+5ZIIPjA5CmUZZmPK2utpeUHV6faDS5xW3BI/pRgUPX
	VWH0+8M287JxTqJUtRA4WscjVdDslHc1wSHAPgGzD5RPxgJsHEFz8T7Ig3aVxjg0Ibyfsbs
	F+1n6map0BPJ2yKWNve8hjMVtrPw7sTdmQXaKin3wnb47Y1QEqXptAGNbgzWiDg/TvTtAkT
	y121x3Mk3mK0nEGxjKGkQ16X9BAscE4wio5Kk34sFp/uIBU9U1zRzjF7E4dwCo7sK9yZVie
	7kUBR7WPNV0dG1te10uhqDcq1z8EON5/0CKymvDMeXqA3Agmy0oEO6tvZ1gawClq1ga0Lbc
	MTzdCxZ+y07Ft9Rk6YToqMyog3MLBALXykI6QqTzXmXlw6RMxhZk+utPDYzN56qpj6MyF28
	P6LhdiCblmQFW34FSTZSnVCXM8CZiHlGnAYB4mZeErCUA+CqE+aTIi+4fChYpCooDfschQD
	X/bMuk6F2Url8BGrJStpXRxFyV3CQtrWnt75t6imlQduL0pmmhEwJ78lInK8IZtIatlbIYJ
	p+DZzRBc1WKDfibmYKF2zwnx8sy1EyripAAtCOchnfUP3D1vuTQebsi6IaLADRApvdVxqte
	8ZxY7+LRpPFCqZSpovbG18pEVwOU4A8ia9d4K4XXT7uQlMeOptHSymeUgRGjfChMaGs4kqi
	cxzktIVr2F9
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

SGVsbG8gUnVveWFvLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KSSB3aWxsIHRlc3Qg
YW5kIHNlbmQgdGVzdCByZXN1bHRzIGxhdGVyLg0KKHVzZSBkaWZmZXJlbnQgZ2NjIHZlcmlv
bnMgYW5kIHJlbW92ZSB0aGUgdGhyZWUgZmxhZ3MuKQ0KDQpCUnMNCldlbnRhbyBHdWFu


