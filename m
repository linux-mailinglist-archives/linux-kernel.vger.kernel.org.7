Return-Path: <linux-kernel+bounces-726857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2FBB0120E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8863A2EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BED1A0BE0;
	Fri, 11 Jul 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PfujcV1i"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED626B660;
	Fri, 11 Jul 2025 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207386; cv=none; b=s77xSMzKNYoAaY8tGTKv4G9kYPckJEElHMnRai2SfJlG+I+6m3revjL/gtrMNaxyvPeFz1dEPHhnrIuYjgQfSdmdZmYvZYKhQxTVu/dAVjgXk0vqZXP8P1jVQjdyqWZt3Ib+Xrk+K7RyPwJOhmnsnUBJqgNPWP4H9jNyKfS5DL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207386; c=relaxed/simple;
	bh=mCQaV6UksmWLTWLnG32apzggSUlVTICCRgDsrCK+xJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=T7HmQ/rWP9y24LuCjaQjZPiYM2GZBCTT+mRg2QG/xKiFYghx4D1puUiKK4geggwZOVe8D4e4YfaNT0h+tR7M6eR//NIPAM4fOCpkRT4ZhFAqQqG+a59gFUoqyM84kMtUd6+j/lffQGj0VRYIboHZyBLIrhPUnolIPEOpJXidL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=PfujcV1i reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1wA3FN+4ZRs727KqLiOvCjQ7mfds2gOwjHXg09NIDZY=; b=P
	fujcV1iBIVz++Xf3q1JZiuU8Jt6MkPryfS0PQlkBY6maqysHe6101Y4S1xfjA4PS
	uHE6/TemRGvaEtu0LuCcrQ+8lt8zYJEzFV5HILW2PXXm/oOkaqbY27Hbaah14NuC
	sWV07ydE24KO+84ONDeMOyBfHG8NAXou1KkJAnIbCQ=
Received: from 00107082$163.com ( [111.35.191.166] ) by
 ajax-webmail-wmsvr-40-148 (Coremail) ; Fri, 11 Jul 2025 12:14:35 +0800
 (CST)
Date: Fri, 11 Jul 2025 12:14:35 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Casey Chen" <cachen@purestorage.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev,
	corbet@lwn.net, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
	vbabka@suse.cz, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	yzhong@purestorage.com, souravpanda@google.com
Subject: Re: [PATCH v3] alloc_tag: add per-NUMA node stats
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CALCePG3a6wG+3Nu7-JHha+LMtyRRNF3sXp13sS-=Xv1pvsX09Q@mail.gmail.com>
References: <20250711002322.1303421-1-cachen@purestorage.com>
 <CALCePG3a6wG+3Nu7-JHha+LMtyRRNF3sXp13sS-=Xv1pvsX09Q@mail.gmail.com>
X-NTES-SC: AL_Qu2eAP6buEos4yObbekZnEYQheY4XMKyuPkg1YJXOp80uSbI5RslTU9jLEHX7saWByq0gCizVzt24/lKT5lgXLqVQzyBj4NOox5qbZ4RMkhJ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2272d95.4512.197f7b1354f.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:lCgvCgD3t_Ksj3BoXX4BAA--.12169W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEgyHqmhwe9ijVwADs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDctMTEgMDg6NDI6MDUsICJDYXNleSBDaGVuIiA8Y2FjaGVuQHB1cmVzdG9yYWdl
LmNvbT4gd3JvdGU6Cj5IaSBBbGwsCj4KPlRoYW5rcyBmb3IgcmV2aWV3aW5nIG15IHByZXZpb3Vz
IHBhdGNoZXMuIEkgYW0gcmVwbHlpbmcgc29tZSBjb21tZW50cwo+aW4gb3VyIHByZXZpb3VzIGRp
c2N1c3Npb24KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUp1Q2ZwSGhTVWh4ZXItNk1Q
MzUwM3c2NTIwWUxmZ0JUR3A3UTlRbTlrZ040VE5zZndAbWFpbC5nbWFpbC5jb20vVC8jdQo+Cj5N
b3N0IHBlb3BsZSBjYXJlIGFib3V0IHRoZSBtb3RpdmF0aW9ucyBhbmQgdXNhZ2VzIG9mIHRoaXMg
ZmVhdHVyZS4KPkludGVybmFsbHksIHdlIHVzZWQgdG8gaGF2ZSBzeXN0ZW1zIGhhdmluZyBhc3lt
bWV0cmljIG1lbW9yeSB0byBOVU1BCj5ub2Rlcy4gTm9kZSAwIHVzZXMgYSBsb3Qgb2YgbWVtb3J5
IGJ1dCBub2RlIDEgaXMgcHJldHR5IGVtcHR5Lgo+UmVxdWVzdHMgdG8gYWxsb2NhdGUgbWVtb3J5
IG9uIG5vZGUgMCBhbHdheXMgZmFpbC4gV2l0aCB0aGlzIHBhdGNoLCB3ZQo+Y2FuIGZpbmQgdGhl
IGltYmFsYW5jZSBhbmQgb3B0aW1pemUgdGhlIG1lbW9yeSB1c2FnZS4gQWxzbywgRGF2aWQKPlJp
ZW50amVzIGFuZCBTb3VyYXYgUGFuZGEgcHJvdmlkZSB0aGVpciBzY2VuYXJpb3MgaW4gd2hpY2gg
dGhpcyBwYXRjaAo+d291bGQgYmUgdmVyeSB1c2VmdWwuIEl0IGlzIGVhc3kgdG8gdHVybiBvbiBh
biBvZmYgc28gSSB0aGluayBpdCBpcwo+bmljZSB0byBoYXZlLCBlbmFibGluZyBtb3JlIHNjZW5h
cmlvcyBpbiB0aGUgZnV0dXJlLgo+Cj5BbmRyZXcgLyBLZW50LAo+KiBJIGFncmVlIHdpdGggS2Vu
dCBvbiB1c2luZyBmb3JfZWFjaF9wb3NzaWJsZV9jcHUgcmF0aGVyIHRoYW4KPmZvcl9lYWNoX29u
bGluZV9jcHUsIGNvbnNpZGVyaW5nIENQVSBvbmxpbmUvb2ZmbGluZS4KPiogV2hlbiBmYWlsaW5n
IHRvIGFsbG9jYXRlIGNvdW50ZXJzIGZvciBpbi1rZXJuZWwgYWxsb2NfdGFnLCBwYW5pYygpCj5p
cyBiZXR0ZXIgdGhhbiBXQVJOKCksIGV2ZW50dWFsbHkgdGhlIGtlcm5lbCB3b3VsZCBwYW5pYyBh
dCBpbnZhbGlkCj5tZW1vcnkgYWNjZXNzLgo+KiBwZXJjcHUgc3RhdHMgd291bGQgYmxvYXQgZGF0
YSBzdHJ1Y3R1cmVzIHF1aXRlIGEgYml0Lgo+Cj5EYXZpZCBXYW5nLAo+SSBkb24ndCByZWFsbHkg
dW5kZXJzdGFuZCB3aGF0IGlzICdncmFudWxhcml0eSBvZiBjYWxsaW5nIHNpdGVzJy4gSWYKPk5V
TUEgaW1iYWxhbmNlIGlzIGZvdW5kLCB0aGUgY2FsbGluZyBzaXRlIGNvdWxkIHJlcXVlc3QgbWVt
b3J5Cj5hbGxvY2F0aW9uIGZyb20gZGlmZmVyZW50IG5vZGVzLiBPdGhlciBmYWN0b3JzIGNhbiBh
ZmZlY3QgTlVNQQo+YmFsYW5jZSwgdGhvc2UgaW5mb3JtYXRpb24gY2FuIGJlIGltcGxlbWVudGVk
IGluIGEgZGlmZmVyZW50IHBhdGNoLgoKSSB0aGluayBteSBjb25jZXJuIG1vc3RseSBkdWUgdG8g
bXkgbGFjayBvZiBrbm93bGVkZ2UgYW5kIGV4cGVyaWVuY2Ugb2YgTlVNQSwKYnV0IEkgc3RpbGwg
d29uZGVyaW5nIHdoYXQgYWN0aW9uIHRvIHRha2Ugd2hlbiAiIHRoZSBjYWxsaW5nIHNpdGUgY291
bGQgcmVxdWVzdCBtZW1vcnkKYWxsb2NhdGlvbiBmcm9tIGRpZmZlcmVudCBub2RlcyIsIGRvZXMg
dGhlIGNhbGxpbmcgc2l0ZSBuZWVkcyB0byBkZXRlY3QgbnVtYSB1bmJhbGFuY2UgYXQgcnVudGlt
ZQogb3IgaXQgc2hvdWxkIGNoYW5nZSB0byBoYXJkIGNvZGVkIG51bWEgbm9kZT8KCkJ5ICdncmFu
dWxhcml0eSBvZiBjYWxsaW5nIHNpdGVzJywgaSBtZWFudCB0byBlbXBoYXNpemUgdGhhdCBpbmZv
cm1hdGlvbiBpcyBsb2NhbCBwZXIgY2FsbGluZyBzaXRlLApub3QgZ2xvYmFsLiAgV2hhdCBpZiB0
aGUgbnVtYSBub2RlcyB1c2FnZSBhcmUgYWxtb3N0IGJhbGFuY2VkIGdsb2JhbGx5LCBidXQgc3Ry
YW5nZWx5IHVuYmFsYW5jZSBsb2NhbGx5IGZvciBzb21lIGNhbGxpbmcgc2l0ZS4KCiJ3aGF0IGFk
anVzdG1lbnQgdGhlIGNhbGxpbmcgc2l0ZSB3b3VsZCBtYWtlIHRvIHNvbHZlIG51bWEgdW5iYWxh
bmNlIiBpcyB0aGUgKmJpZyogcXVlc3Rpb24gdG8gbWUgIAoKVGhhbmtzCkRhdmlkCgo+Cj5UaGFu
a3MsCj5DYXNleQo+Cg==

