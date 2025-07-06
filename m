Return-Path: <linux-kernel+bounces-714857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDAAF6D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94AD4E8653
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493F2C327B;
	Thu,  3 Jul 2025 08:46:28 +0000 (UTC)
Received: from hrbeu.edu.cn (mx1.hrbeu.edu.cn [202.118.176.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC94291C06
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.118.176.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532388; cv=none; b=MxOm3I8VDPHNNGJXHk30pXWFkP8N28e35YkUrjIZh0fcVB0bzkchEfJ0ccdXy6yCpm4nBEE+Yr7AcRnBQqzTAgz4dpAM05A5PyDUzhnMTmjNKaEE5pGOwizpc//+A0E1NRpuLMmrcxw/cElBmazNfnP+l7gZKqVrktuqNBTml6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532388; c=relaxed/simple;
	bh=OLZZrnGwIXMel88WGve2VF6slVpsq5u0Rxf8ssSzbD0=;
	h=Date:From:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=e1c6UR4MT69XTLZTk4sJh/JoWZicV0AJLo/Hh+VIl3nTfgRuoav0UrVNTnktxg4zFQDdjm+FZX76C9Hp8+yM2uyRiF+CDI2dW0O3V6a/qcKGCnR1HzOg1hUhEo0VOBDkCLhbxlkKXCC4I0I3ucVTdKK7fEOdy3wXW64S3NFHavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hrbeu.edu.cn; spf=pass smtp.mailfrom=hrbeu.edu.cn; arc=none smtp.client-ip=202.118.176.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hrbeu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hrbeu.edu.cn
Received: from baishuoran$hrbeu.edu.cn ( [118.74.253.71] ) by
 ajax-webmail-Front (Coremail) ; Thu, 3 Jul 2025 16:45:25 +0800 (GMT+08:00)
Date: Thu, 3 Jul 2025 16:45:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
Cc: "Kun Hu" <huk23@m.fudan.edu.cn>, "Jiaji Qin" <jjtan24@m.fudan.edu.cn>,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: BUG: spinlock bad magic in lock_timer_base
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20241202(ebbd5d74) Copyright (c) 2002-2025 www.mailtech.cn hrbeu.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3e3a7f31.12282.197cf7648d4.Coremail.baishuoran@hrbeu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:CbB2ygD38WglQ2Zo7kwEAA--.797W
X-CM-SenderInfo: pedl2xpxrut0w6kuuvvxohv3gofq/1tbiAQIMCmhlA2QJAQAAsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBNYWludGFpbmVycywKCldoZW4gdXNpbmcgb3VyIGN1c3RvbWl6ZWQgU3l6a2FsbGVyIHRv
IGZ1enogdGhlIGxhdGVzdCBMaW51eCBrZXJuZWwsIHRoZSBmb2xsb3dpbmcgY3Jhc2ggKDExMHRo
KXdhcyB0cmlnZ2VyZWQuCgoKSEVBRCBjb21taXQ6IDY1MzdjZmIzOTVmMzUyNzgyOTE4ZDhlZTdi
N2YxMGJhMmNjM2NiZjIKZ2l0IHRyZWU6IHVwc3RyZWFtCk91dHB1dDpodHRwczovL2dpdGh1Yi5j
b20vcGdoazEzL0tlcm5lbC1CdWcvYmxvYi9tYWluLzA3MDJfNi4xNC9CVUclM0ElMjBzcGlubG9j
ayUyMGJhZCUyMG1hZ2ljJTIwaW4lMjBsb2NrX3RpbWVyX2Jhc2UvcmVwb3J0MTEwLnR4dCAKS2Vy
bmVsIGNvbmZpZzpodHRwczovL2dpdGh1Yi5jb20vcGdoazEzL0tlcm5lbC1CdWcvYmxvYi9tYWlu
LzA3MDJfNi4xNC9jb25maWcudHh0CkMgcmVwcm9kdWNlcjpodHRwczovL2dpdGh1Yi5jb20vcGdo
azEzL0tlcm5lbC1CdWcvYmxvYi9tYWluLzA3MDJfNi4xNC9CVUclM0ElMjBzcGlubG9jayUyMGJh
ZCUyMG1hZ2ljJTIwaW4lMjBsb2NrX3RpbWVyX2Jhc2UvMTEwcmVwcm8uYyBTeXpsYW5nIApyZXBy
b2R1Y2VyOmh0dHBzOi8vZ2l0aHViLmNvbS9wZ2hrMTMvS2VybmVsLUJ1Zy9ibG9iL21haW4vMDcw
Ml82LjE0L0JVRyUzQSUyMHNwaW5sb2NrJTIwYmFkJTIwbWFnaWMlMjBpbiUyMGxvY2tfdGltZXJf
YmFzZS8xMTByZXByby50eHQgT3VyIHJlcHJvZHVjZXIgdXNlcyBtb3VudHMgYSBjb25zdHJ1Y3Rl
ZCBmaWxlc3lzdGVtIGltYWdlLgogCiAKVGhlIGVycm9yIG9jY3VycyBpbiB0aGUgbG9ja190aW1l
cl9iYXNlICh0aW1lci5jIGxpbmVzIDE3NzAtMTc5MCBvciBzbykuIEl0IGhhcHBlbnMgY2xlYW51
cF9zcmN1X3N0cnVjdCBkdXJpbmcgdGhlIEtWTSBWTSBzaHV0ZG93biBwcm9jZXNzLCBhbmQgaXQg
aXMgbGlrZWx5IHRoYXQgdGhlIG1lbW9yeSBwb2ludGVkIHRvIGJ5IHRoZSB0aW1lciBvYmplY3Qg
aGFzIGJlZW4gZnJlZWQuIFRoZSB0aW1lcl9iYXNlIHBvaW50ZXIgcmV0dXJuZWQgYnkgdGhlIGdl
dF90aW1lcl9iYXNlICh0ZikgcG9pbnRzIHRvIGFuIGludmFsaWQgbWVtb3J5IGFyZWEgKF9faW5p
dF9iZWdpbisweDJhNTAwKQpXZSBoYXZlIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZSBzZXZlcmFsIHRp
bWVzIG9uIDYuMTQgYWdhaW4uCgoKCklmIHlvdSBmaXggdGhpcyBpc3N1ZSwgcGxlYXNlIGFkZCB0
aGUgZm9sbG93aW5nIHRhZyB0byB0aGUgY29tbWl0OgpSZXBvcnRlZC1ieTogS3VuIEh1IDxodWsy
M0BtLmZ1ZGFuLmVkdS5jbj4sIEppYWppIFFpbiA8amp0YW4yNEBtLmZ1ZGFuLmVkdS5jbj4sIFNo
dW9yYW4gQmFpIDxiYWlzaHVvcmFuQGhyYmV1LmVkdS5jbj4KCgoKCkJVRzogc3BpbmxvY2sgYmFk
IG1hZ2ljIG9uIENQVSMyLCBzeXouNi4zOTkvMTgxMjkKIGxvY2s6IF9faW5pdF9iZWdpbisweDJh
NTAwLzB4NDEwMDAsIC5tYWdpYzogMDAwMDAwMDAsIC5vd25lcjogPG5vbmU+Ly0xLCAub3duZXJf
Y3B1OiAwCkNQVTogMiBVSUQ6IDAgUElEOiAxODEyOSBDb21tOiBzeXouNi4zOTkgTm90IHRhaW50
ZWQgNi4xNC4wICMxCkhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJ
SVgsIDE5OTYpLCBCSU9TIDEuMTMuMC0xdWJ1bnR1MS4xIDA0LzAxLzIwMTQKQ2FsbCBUcmFjZToK
IDxUQVNLPgogZHVtcF9zdGFja19sdmwrMHgxMTYvMHgxYjAKIGRvX3Jhd19zcGluX2xvY2srMHgy
MmMvMHgyZTAKIF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHg0NS8weDYwCiBsb2NrX3RpbWVyX2Jh
c2UrMHgxMjUvMHgxYzAKIF9fdHJ5X3RvX2RlbF90aW1lcl9zeW5jKzB4N2YvMHgxNjAKIF9fdGlt
ZXJfZGVsZXRlX3N5bmMrMHgxMjAvMHgxYzAKIGNsZWFudXBfc3JjdV9zdHJ1Y3QrMHgxMjIvMHg1
YTAKIGt2bV9wdXRfa3ZtKzB4N2M5LzB4YTEwCiBrdm1fdmNwdV9yZWxlYXNlKzB4NGIvMHg3MAog
X19mcHV0KzB4NDE3LzB4YjYwCiBfX2ZwdXRfc3luYysweGE2LzB4YzAKIF9feDY0X3N5c19jbG9z
ZSsweDhiLzB4MTIwCiBkb19zeXNjYWxsXzY0KzB4Y2YvMHgyNTAKIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YKUklQOiAwMDMzOjB4N2ZhZmRhZDFlYmRiCkNvZGU6IDAz
IDAwIDAwIDAwIDBmIDA1IDQ4IDNkIDAwIGYwIGZmIGZmIDc3IDQxIGMzIDQ4IDgzIGVjIDE4IDg5
IDdjIDI0IDBjIGU4IDYzIGZjIGZmIGZmIDhiIDdjIDI0IDBjIDQxIDg5IGMwIGI4IDAzIDAwIDAw
IDAwIDBmIDA1IDw0OD4gM2QgMDAgZjAgZmYgZmYgNzcgMmYgNDQgODkgYzcgODkgNDQgMjQgMGMg
ZTggYTEgZmMgZmYgZmYgOGIgNDQKUlNQOiAwMDJiOjAwMDA3ZmZkZThjOTViMjAgRUZMQUdTOiAw
MDAwMDI5MyBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAwMwpSQVg6IGZmZmZmZmZmZmZmZmZmZGEg
UkJYOiAwMDAwMDAwMDAwMDAwMDA2IFJDWDogMDAwMDdmYWZkYWQxZWJkYgpSRFg6IGZmZmZmZmZm
ZmZmZmZmZmYgUlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwNQpSQlA6
IDAwMDA3ZmZkZThjOTViZjggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDdmYWZkYTgw
MTVhNgpSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiAwMDAwMDAwMDAwMDAwMjkzIFIxMjogMDAw
MDdmYWZkYWZhNWZhMApSMTM6IDAwMDAwMDAwMDAwMmYzZWEgUjE0OiBmZmZmZmZmZmZmZmZmZmZm
IFIxNTogMDAwMDdmYWZkYWZhNWZhMAogPC9UQVNLPgoKCgoKCgp0aGFua3MsCkt1biBIdQo=

