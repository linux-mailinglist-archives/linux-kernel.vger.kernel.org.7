Return-Path: <linux-kernel+bounces-829194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E33B967EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 591304E18AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228622256B;
	Tue, 23 Sep 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UEmynh1u"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04C18E20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639961; cv=none; b=P2Nr28XF7vXdtlINw3nzPGTJ4Xqsc8EbFD+g6xnZZxu0LIsfuhOYHtQ3izsTBjXbKkd70DTod+UzhVYfjdEZ5djPMzE31DUkPA40JJp8TLnQVdekRSBnrpGW/FAVo06EHsrXiwQbQnAIypLGkYqaybBWPUbOO8IRyInlK590lKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639961; c=relaxed/simple;
	bh=H/DoxZF7P4nKqwBqst7vh1I9d9VymNgrxJ0Xnlc4ZXo=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=N5l9nflA73KydxS39T9iswjUS99I+ramh7Nzp2eC1TBUbd21T3FZGshopFv4iClecY0tU52HS5GYoABeuVP/5iYDAiwbeckDUYFUqj10WXV5KNlXGnezIt6V1hil7YQJ61RZezejcDZb62B0eiLj6vLmJYaGBPa4zeYjhvx0Xoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UEmynh1u; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758639943; bh=H/DoxZF7P4nKqwBqst7vh1I9d9VymNgrxJ0Xnlc4ZXo=;
	h=From:To:Cc:Subject:Date;
	b=UEmynh1uO8GFK2HusQzLDqqLoFzUOaIfi/zaJhA4T2P+rN4retGNCuRlFuDoBkBRU
	 8ftUlMo4mZR0k5GgQKGuv9iBeTEDn3ktOZ6IvYwpJBssJPT2o/1iAEDQi8wNWKrwWE
	 +x2bAQsymvDY3VdctFJb9sw5nMKZ6lzp1uckG9E8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-XMAILINFO: N+XrBeZ/LGN6CuENrvAnMc4J53T/tB/LXoiayzw4dNn1ZjfUy5T2NEr1Y6v78s
	 7s9Q9fJoa4gLONPRl99j6O5t50LhRJcj1QXsLtv5zuVQQDkHi6ebTbZthXmOWjmZ9xwbaPdZEzGCg
	 wGO8N/rinrEVvaoBCeztVRLUhi8IF0QUbS+Vl6TDsgh1+q6GXbF82Zm3nqSNlVW0Wwqxj49ulY1qZ
	 cORLaKqyas4IxU7drT+G16XcT7MDJwpGw4k45RTCApRv9bbz3w2Wir6dxFpSZoRnGTWQSbZsW567S
	 pUq2HFu4V9Z5CSGpr8gqL/Aaq5EOKXkipW7wlmeix912747B2etp0QrD6l2tgxf14cIRAX0zUDqwb
	 TchtBBMwMjnE1HoqBmUWm+r5lA+Xlcsr2QctR0YqDrvDmMam00gcQJqfedFUKItaOdVhmCImlEikg
	 SUdVjukTnxe0XQmJij+UrV9JV6r0Zef3D9fCaeGq0hTiktn/B1dHfEw3AIs8NweoTEcTdsw8cxvKL
	 BpszuypnKF3wNSphLRBJIpcZxkxWRNs8ULsTuPlPMIVHIxOXWF1GgAAGMZuKhzh1Q8LVhof7OW15c
	 LWV47xRGL/w0zdfpsFACv+N+C0dFOxse4eIHr7Zz5SclBpMxU6NWdHZVAIqlECHTzoyXgeSl7VyIa
	 Jp4WWsPn4573hMZFXTSSfJCzpB0e1RJjc9UvD07PR6LUP/PiceRWfZlCnwdTMBI47zTQx0vWx2Tjd
	 H8vjV0A7Civv3b/arU9lKzH2500hnhKpttdTOqv8jeuvuo6gjEe39z8Ty9OCFNRuTawX04EmXE9YW
	 Uk87H/8kEUzm7WcE7gQH3OkuadRS2UBYN8iVvEMrWq+DBnXxhHSM0vvnUY7LPyk6Na5IKU1Tltm9r
	 6YlIQRas3LTrbMXC6IFNsI4FVbk8az1tsXkXQCn9aEllV7Xd5QV5yHAAkVyC2xrd6zwwn2SD67AYo
	 PIYtaK89QgLJ7aOmVQxlwHlvbnj4kD1LFnGU8CYTyjDVk5Pc9o26Lj9fMHOQh5kEwAWt5C6VYW6Av
	 SG4cg/tFieBsydgUTM5kpN+d4mfFHYOfIBuzsBp1H1YY3bOS/iySv1PlZdG3TxI1esvwPwfP+INPD
	 hdRcvs+CihQk5ZrQorJQamgDAFhei2SzQvqRuebxbEe1xICR9FDhTWIAf4vHQbEddV8qrfHf61fu+
	 w==
From: "=?utf-8?B?c2hlbmdtaW5naHU1MTI=?=" <shengminghu512@qq.com>
To: "=?utf-8?B?bGlubWlhb2hl?=" <linmiaohe@huawei.com>, "=?utf-8?B?bmFvLmhvcmlndWNoaQ==?=" <nao.horiguchi@gmail.com>, "=?utf-8?B?YWtwbQ==?=" <akpm@linux-foundation.org>
Cc: "=?utf-8?B?bGludXgtbW0=?=" <linux-mm@kvack.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?aHUuc2hlbmdtaW5n?=" <hu.shengming@zte.com.cn>, "=?utf-8?B?c2hlbmdtaW5naHU1MTI=?=" <shengminghu512@qq.com>, "=?utf-8?B?emhhbmcucnVu?=" <zhang.run@zte.com.cn>
Subject: [PATCH V2] mm/memory-failure: Ensure collect_procs is retried when  unmap fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 23 Sep 2025 22:57:09 +0800
X-Priority: 3
Message-ID: <tencent_EDEED996FC685E61AADA14A23BCE9CCDAF09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezc43-1t1758639429tsinbf3h5

RnJvbTogU2hlbmdtaW5nIEh1IDxzaGVuZ21pbmdodTUxMkBxcS5jb20+CkRhdGU6IFR1ZSwg
MjMgU2VwIDIwMjUgMjA6NTY6MjggKzA4MDAKU3ViamVjdDogW1BBVENIIFYyXSBtbS9tZW1v
cnktZmFpbHVyZTogRW5zdXJlIGNvbGxlY3RfcHJvY3MgaXMgcmV0cmllZCB3aGVuCiB1bm1h
cCBmYWlscwoKSW4gdGhlIG1lbW9yeV9mYWlsdXJlIHByb2Nlc3MsIGlmIGNvbGxlY3RfcHJv
Y3MgaXMgbm90IGV4ZWN1dGVkIHdpdGggdGhlCmZsYWcgc2V0LCB0aGUgdG9fa2lsbCBsaXN0
IG1heSBiZSBlbXB0eS4gRXZlbiBpZiB0aGVyZSBhcmUgcGFnZXMgdGhhdCBmYWlsCnRvIGJl
IHVubWFwcGVkLCBTSUdLSUxMIG9yIFNJR0JVUyBjYW5ub3QgYmUgc2VudCB0byB0aGUgcHJv
Y2VzcyB2aWEKY29sbGVjdF9wcm9jcy4KClRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIGJ5
IHJlLWV4ZWN1dGluZyBjb2xsZWN0X3Byb2NzIHdoZW4gdGhlIHRvX2tpbGwKbGlzdCBpcyBl
bXB0eSBhbmQgdW5tYXAgZmFpbHMuIFRoaXMgY29sbGVjdHMgcHJvY2Vzc2VzIHdpdGggdW5t
YXAgZmFpbHVyZXMKaW50byB0aGUgdG9fa2lsbCBsaXN0LCBhbGxvd2luZyBTSUdCVVMgb3Ig
U0lHS0lMTCB0byB0ZXJtaW5hdGUgdGhlbSBpbgpzdWJzZXF1ZW50IGNvZGUuCgpWMjoKICAt
IFJlc2VudCBhcyBwbGFpbiB0ZXh0IChwcmV2aW91cyB2ZXJzaW9uIHdhcyBIVE1MKS4KICAt
IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4KClNpZ25lZC1vZmYtYnk6IFNoZW5nbWluZyBIdSA8
aHUuc2hlbmdtaW5nQHp0ZS5jb20uY24+Ci0tLQogbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDUg
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUu
YwppbmRleCBhMjQ4MDZiYjhlODIuLjgxNTc4MjNjN2ZiNyAxMDA2NDQKLS0tIGEvbW0vbWVt
b3J5LWZhaWx1cmUuYworKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jCkBAIC0xNjAwLDkgKzE2
MDAsMTIgQEAgc3RhdGljIGJvb2wgaHdwb2lzb25fdXNlcl9tYXBwaW5ncyhzdHJ1Y3QgZm9s
aW8gKmZvbGlvLCBzdHJ1Y3QgcGFnZSAqcCwKIAljb2xsZWN0X3Byb2NzKGZvbGlvLCBwLCAm
dG9raWxsLCBmbGFncyAmIE1GX0FDVElPTl9SRVFVSVJFRCk7CiAKIAl1bm1hcF9zdWNjZXNz
ID0gIXVubWFwX3BvaXNvbmVkX2ZvbGlvKGZvbGlvLCBwZm4sIGZsYWdzICYgTUZfTVVTVF9L
SUxMKTsKLQlpZiAoIXVubWFwX3N1Y2Nlc3MpCisJaWYgKCF1bm1hcF9zdWNjZXNzKSB7CiAJ
CXByX2VycigiJSNseDogZmFpbGVkIHRvIHVubWFwIHBhZ2UgKGZvbGlvIG1hcGNvdW50PSVk
KVxuIiwKIAkJICAgICAgIHBmbiwgZm9saW9fbWFwY291bnQoZm9saW8pKTsKKwkJaWYgKGxp
c3RfZW1wdHkoJnRva2lsbCkpCisJCQljb2xsZWN0X3Byb2NzKGZvbGlvLCBwLCAmdG9raWxs
LCAxKTsKKwl9CiAKIAkvKgogCSAqIHRyeV90b191bm1hcCgpIG1pZ2h0IHB1dCBtbG9ja2Vk
IHBhZ2UgaW4gbHJ1IGNhY2hlLCBzbyBjYWxsCi0tIAoyLjI1LjE=


