Return-Path: <linux-kernel+bounces-850496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BEBD2FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D81624E23A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE792609FD;
	Mon, 13 Oct 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="c2M7eyLg"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883643147
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358753; cv=none; b=CO6ZngBPgEKKNBNlqjTLXYCObjLBYgSKOC/JxnYPMDLADI01Pd9pbZ4gbnn+jTGy2Z7HPlUmtFQvdqL0avMxKIVWhCsb5ayf+gqyJNRxUF6ge51kZFt5SdW+RuxU+1hSUb1I0nOuU6+BjTmS3Xabr1EBsB0vXWTTVOPPeeiTCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358753; c=relaxed/simple;
	bh=91kaGWv8dj0DGFmN0ZpJjSCDxQ69lVxfnjD1g1GRA7w=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=pg+mB4AJHUEIDV6OyLMenrRuyM8vaDAQhukqyJeE/RyLK3+TA6BXEM9AH6+hNGRrzsw6oa1GeHaTYSU3p1wZfJD8Ja10vsrZkj+LjQHpbE1AX7A1n2MwBChARMI4r2j3/DnWHUUDDEcBto4VEY1bm4XAmNBSMQTGmc8gSkaGw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c2M7eyLg; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1760358699;
	bh=91kaGWv8dj0DGFmN0ZpJjSCDxQ69lVxfnjD1g1GRA7w=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=c2M7eyLgxD2UbIdk6jhoJiLdQ6obhwylZCX945uJrClI8w/Q9hbB7v4R4ixJ6XhkN
	 sM0UpByk7/qOQ3nSWuwSS2AoNhwLOqkGVcHzoQuy7eS1rCFBbvBJnxD9VuIbZhV3dK
	 jhpc4KsvrbWzdsW5IfbtZSz0xj8zeHnMtDb20tJk=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRRDMu1q775QruR7Y790WuywJEQvw7b5Zs=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: iVfuAiKHQsGwbSBff9QSpP4qLqzTV78dPeF7a24XmU2RTlcKvZ+XUiO6ss0hewXylwklq2EGG2SzSkuH/tUVzw==
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1760358693t96879f4c
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?U3Jpbml2YXMgS2FuZGFnYXRsYQ==?=" <srini@kernel.org>
Cc: "=?utf-8?B?bWlxdWVsLnJheW5hbA==?=" <miquel.raynal@bootlin.com>, "=?utf-8?B?bXdhbGxl?=" <mwalle@kernel.org>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?V2FuZ1l1bGk=?=" <wangyl5933@chinaunicom.cn>
Subject: Re: [PATCH] nvmem: layouts: fix nvmem_layout_bus_uevent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 13 Oct 2025 20:31:33 +0800
X-Priority: 3
Message-ID: <tencent_65227CF727A9DD23421005DB@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20251013115910.702784-1-guanwentao@uniontech.com>
	<f9274080-9a2f-4e10-ad5f-fa84d7615c15@kernel.org>
In-Reply-To: <f9274080-9a2f-4e10-ad5f-fa84d7615c15@kernel.org>
X-QQ-ReplyHash: 1966752157
X-BIZMAIL-ID: 18124013134138920775
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 13 Oct 2025 20:31:35 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NmeSCG7SlH6+BZE8EdIuhPGEY7sZkc/HlkpKafmeuU20dwtdeDio2KX8
	a1h+DAR6yiRGEbmxjH555r7CYcsQB7A29O19FJK/wEJL63GGQHkhVzw0YFcYCb8DyPLYUgA
	a0+6tGnRiM8EpGRIA1HpNKAB+WIsKs0mbS9Y5NNegAjaI/XnY1Um+XbkvRVQ1iw0sGLKjpq
	15XKZc9RBzc7/wcGZhMe8azlWKcA2whZTRbdzwp3tHH+VEVWpG0iwD/zMZJeEPTkPOlU5ix
	nBhzYFaaPIwW3rdszrdLbkklOuDfS0Io1WwRcmsCGNC/3CMjiCjNRz2GKQCYLIoRYO1ekpc
	tQbALNYC8D/DaTR6oWpxPmpKZm5wBIq5iOCYDKTJWUKzZweGoN+yn6uP6QRrNdABAiEvzvm
	vhwpvhnsYexvF9PnFfn3sc1L6C9wTlGRvXQMttpKnNd1NqmNhxLdIAag/FOz1vQsxSd7Ddj
	YQhxeJX39VDRTcSwdZ6RLRFoNJQZ6fLiuqWiZ/59pgUjnD5i3t5geo+neTQIatLljJNeMs3
	EUr9H1AtY+kYbmfRbRDX7HpyAISoAg8l3TFm1PkuJ1eb2GoaL4UCyK406U8PY9dv26t2eJL
	AqEb4ECQXTXjPeAOztoVJ5hrQpVu+8cnWTLcHvIzOYiQQraXkQFz1+m1FKdM3+QEeuynS8b
	IIfeLnZbGi3Jaxl6j+iffeNmRSiwMPTF7aYyXTjlh65iOMXHHDHNs5dndRPsdTq4WMuw15m
	0OYOu+aheV/BZpdMUzq1rQ57E3JmYnGWWWwbiGiVI9v4RwTW+ujtNJTCAyOAiOLK+IfqZ1z
	Za+8a7FLgQU/EUIPsGk0G6/L2FbzjE42GYvDK1feJlRNRoPviYjU73tDoMSVwMAVEImwJEV
	5Mvu4jhwaA0SPD6dBXCfF2HIyzdvfVFeBXUj4Bzb8Ryoa4bU9AQ4CaXoMe24O1wV3oeY9aR
	ROD+l+XQ6oQw3NlIRfkWmO4XbXQqzTuqbH4gLIZTEoam7U7+AV85Iys6ukiT/yhdXFdPvay
	i6dBaoApH3DxwgfEw4gQlAts+ccfABs9DZSBIIkfBr+CxbrP/np9yxuMlSuZK87bQ2g2OMb
	w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

SGksDQoNClRoYW5rcyBmb3IgeW91ciByZXBseS4NCkhvdyB0byBhZGQgdGhlIENDIHN0YWJs
ZSBub3c/DQpTZW5kIHYyIG9yIGFkZCBlbWFpbCBDQyBvciAuLi4/DQoNCkJScw0KV2VudGFv
IEd1YW4=


