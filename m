Return-Path: <linux-kernel+bounces-826181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C2B8DC59
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0E117A263
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721F2D73B3;
	Sun, 21 Sep 2025 13:36:52 +0000 (UTC)
Received: from hrbeu.edu.cn (mx1.hrbeu.edu.cn [202.118.176.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884A04A1A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.118.176.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461811; cv=none; b=EX60xehc/aylEI6IPRKCEdNCMwYYAffM3Lnwcw4tNvu/O5hgFTEu//z0pRtmtPBfz6RAbZ5CzAI/pZXh6ReA2lHB5s0egpXcRTVy/D0AjvEuMvesLHuL2rc7zK4jT50SjAwoJ8VKOFw3nz8qabAD8lScpnn76dcmJ2g0CkxS7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461811; c=relaxed/simple;
	bh=/nB8Lo2t4EPmQ++7brsEpEkBAtuQ/yfZbpgztCvjRjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RBph7r51aZbHE7OnnFW7ksXeaIj8C9Q+qDZzT+gm+Cgprt81cMKx3S2buSW26IJvymAOzCiyQxsso9sWWTNmoLCTqochGu0kvWI4x2NzJVsvUQ07CsTi87z4bmGQ0QeuNgJ3B6Jd7KdY8mnVTALw5YXVy+NWyuk3KsP0MBHFDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hrbeu.edu.cn; spf=pass smtp.mailfrom=hrbeu.edu.cn; arc=none smtp.client-ip=202.118.176.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hrbeu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hrbeu.edu.cn
Received: from baishuoran$hrbeu.edu.cn ( [172.83.159.137] ) by
 ajax-webmail-Front (Coremail) ; Sun, 21 Sep 2025 21:35:28 +0800 (GMT+08:00)
Date: Sun, 21 Sep 2025 21:35:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: huk23@m.fudan.edu.cn, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Re: Re: possible deadlock in smp_call_function_many_cond
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT5 build
 20250609(354f7833) Copyright (c) 2002-2025 www.mailtech.cn hrbeu.edu.cn
In-Reply-To: <87frcuro62.ffs@tglx>
References: <758991c1.13f67.197f9cccf9b.Coremail.baishuoran@hrbeu.edu.cn>
 <877c02vejr.ffs@tglx> <C0FEC6BF-BCC8-4301-BBE6-8A49A05D50D6@m.fudan.edu.cn>
 <87o6taq6bk.ffs@tglx>
 <775c18ba.1d7b5.199098fbc3f.Coremail.baishuoran@hrbeu.edu.cn>
 <87frcuro62.ffs@tglx>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <43954530.4f11.1996c7c9799.Coremail.baishuoran@hrbeu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:CbB2ygDXcdsg_89ob+dVAA--.12026W
X-CM-SenderInfo: pedl2xpxrut0w6kuuvvxohv3gofq/1tbiAQIMCmjP04UA9gAAsC
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gQ2FuIHlvdSBwbGVhc2Ugc3RvcCB0b3AtcG9zdGluZz8KClNvcnJ5IGZvciB0aGF0LCBJIGRp
ZG7igJl0IG5vdGljZSB0aGlzIGlzc3VlIGJlZm9yZS4gV2XigJl2ZSB0YWtlbiBzb21lIHRpbWUg
dG8gcmUtbGVhcm4gdGhlIGVtYWlsIGNvbW11bmljYXRpb24gcnVsZXMgYW5kIHdpbGwgcGF5IG1v
cmUgYXR0ZW50aW9uIGluIHRoZSBmdXR1cmUuIEFnYWluLCBteSBhcG9sb2dpZXMgZm9yIHRoZSBp
bmNvbnZlbmllbmNlLgoKPiBJIHRvbGQgeW91IGxhc3QgdGltZToKPiAKPiA+PiA+IFsgICAgMC40
MjczMDJdWyAgICBUMF0gVW5rbm93biBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlcnMgImhy
dGltZXJfZXhwaXJlX2VudHJ5IGhydGltZXJfZXhwaXJlX2V4aXQgc3BlY19zdG9yZV9ieXBhc3Nf
ZGlzYWJsZT1wcmN0bCBuYmRzX21heD0zMiIsIHdpbGwgYmUgcGFzc2VkIHRvIHVzZXIgc3BhY2Uu
Cj4gPj4gCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eCj4gPj4gSG93IGlzIHRoaXMgaGVscGZ1bD8KPiAKPiBUaGlzIGRvZXMgbm90IGVuYWJsZSB0
aGUgdHJhY2UgZXZlbnRzLiBZb3UgbmVlZDoKPiAKPiAgICB0cmFjZV9ldmVudD0iaHJ0aW1lcl9l
eHBpcmVfZW50cnksaHJ0aW1lcl9leHBpcmVfZXhpdCIKPiAKPiB0byBtYWtlIHRoYXQgd29yay4K
PiAKCldlIHVwZGF0ZWQgdGhlIG5ldyB0ZXN0IGxvZywgd2hpY2ggaW5jbHVkZXMgaHJ0aW1lcl9l
eHBpcmVfZW50cnksaHJ0aW1lcl9leHBpcmVfZXhpdCBhbmQgZnRyYWNlX2R1bXBfb25fb29wczoK
CkxvZzogaHR0cHM6Ly9naXRodWIuY29tL3BnaGsxMy9LZXJuZWwtQnVnL2Jsb2IvbWFpbi8wNzAy
XzYuMTQvSU5GTyUzQSUyMHJjdSUyMGRldGVjdGVkJTIwc3RhbGwlMjBpbiUyMHN5c19zZWxlY3Qv
MTIybG9nOS4yMC50eHQKCuKAlOKAlOKAlOKAlAp0aGFua3PvvIwKQmFp

