Return-Path: <linux-kernel+bounces-734521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27DB082B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7452358405F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992741B412A;
	Thu, 17 Jul 2025 02:02:45 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AD1B983F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717765; cv=none; b=tm1LrrdFE11sK4Faz+a7/sUG6f3aoe9erD11RF9w9qUenrQdKL4JnezCA7jjYEb+HJQoB/XbnzHWRZ8huUQgOzFl6VogybNpMLaNWADU+OYLN/yKxblMY9iPgJ+Bviocu1TlwPMHBxvHW9lDoPQf27krA/lyvCMvpAUAL9gweu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717765; c=relaxed/simple;
	bh=cu/yDUrxST+1uvsl2WRsJcz+fPWrEMdPUqli4QG1bzU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pu+xQSsuBBEgMl92SvnHO6OtyUbh4b3X6nfaYRBGQALJpjoyo5HkhxKYwvbDIB8MZOhhREt+a5Kxfav1tEMNOxxSarg116ZLjOJ9sDzljnGYNe1BGiZ2IupoVxLa5XfML5Ti9w/rvre0YpATNUyj9TISu367SHzOVczIbhAet/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 56H22LlB062816;
	Thu, 17 Jul 2025 10:02:21 +0800 (+08)
	(envelope-from haiyan.liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bjGKN62JQz2K925k;
	Thu, 17 Jul 2025 09:58:00 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Jul
 2025 10:02:18 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.048; Thu, 17 Jul 2025 10:02:18 +0800
From: =?utf-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>
To: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>,
        Matthew Maurer <mmaurer@google.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda
	<ojeda@kernel.org>,
        =?utf-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?=
	<Ping.Zhou1@unisoc.com>,
        =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?=
	<Ziwei.Dai@unisoc.com>,
        =?utf-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?=
	<lina.yang@unisoc.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?=
	<shuang.wang@unisoc.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Andrey Konovalov
	<andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino
	<vincenzo.frascino@arm.com>,
        "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?=
	<arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen
	<maco@android.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Christian Brauner
	<christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>,
        "Jamie
 Cunliffe" <Jamie.Cunliffe@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: =?utf-8?B?5pKk5ZueOiBNZWV0IGNvbXBpbGVkIGtlcm5lbCBiaW5hcmF5IGFibm9ybWFs?=
 =?utf-8?B?IGlzc3VlIHdoaWxlIGVuYWJsaW5nIGdlbmVyaWMga2FzYW4gaW4ga2VybmVs?=
 =?utf-8?Q?_6.12_with_some_default_KBUILD=5FRUSTFLAGS_on?=
Thread-Topic: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Thread-Index: AQHb9r7T3quLQs5+RfaRTr3Yr7SnUQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 17 Jul 2025 02:02:18 +0000
Message-ID: <484211314e1f4a7990a43852db79fb20@BJMBX01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 56H22LlB062816

5YiY5rW354eVIChIYWl5YW4gTGl1KSDlsIbmkqTlm57pgq7ku7bigJxNZWV0IGNvbXBpbGVkIGtl
cm5lbCBiaW5hcmF5IGFibm9ybWFsIGlzc3VlIHdoaWxlIGVuYWJsaW5nIGdlbmVyaWMga2FzYW4g
aW4ga2VybmVsIDYuMTIgd2l0aCBzb21lIGRlZmF1bHQgS0JVSUxEX1JVU1RGTEFHUyBvbuKAneOA
gg==

