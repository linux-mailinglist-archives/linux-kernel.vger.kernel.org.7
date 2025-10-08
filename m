Return-Path: <linux-kernel+bounces-845591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B594BBC5781
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 448144EACFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E532EBBAF;
	Wed,  8 Oct 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JWcf1aol"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085F2AD31
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934612; cv=none; b=tk/2DBn88PFvTW6hhcUF/FGVf+pcaX1JU9lFzA4y8TTDev7O3VeiltLY7TYxYKum+aonxgZCOF3VMlPa8IxKxgAdLvrvpF8oaz/nDTuQPcg/iU0WCcikQE1hc1Pu2fjmnSTw+2tOD9LXLWB8YCbzcz7AvVnq18TRzEKYSRk56E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934612; c=relaxed/simple;
	bh=+Mwd6O/6R0+UhWbbwOh4kyOOOxzLz+tRUgxLNNbpuYc=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=qzbHiKBwolWBKJHS82UgfUKktAoQ751ZXUATtLScVM8c6vVJTR4aJgOqBbEhDnY3e8EMg74/0DQ677v5jFdMy2lZQsEuhFifBnxi680o060RsMQxs1U+85819wL4eEsjhNPg8xmoMCApLf21ViGGOjCKCjt25whx4Fg0xb66nhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JWcf1aol; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759934601; bh=+Mwd6O/6R0+UhWbbwOh4kyOOOxzLz+tRUgxLNNbpuYc=;
	h=From:To:Cc:Subject:Date;
	b=JWcf1aolFnCsggqCCK5ov//c3DoKQMZ1+AQUlBHC+YbssHBkFlqhnPeEXrmWgxsb6
	 S+k9IxmyF7ThX2SYYCvoUU6Uwz8Uexi80YT1dJLC4wkS76eeXWoZIg+3yJ+599Zz3E
	 tnLoD07X7iIVLSge6/djpZNmLqWx3SyKuGHmu8uk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: NNde6qybtQwECC0vR34hGWq6wGRWwpT8CnG+b7xWG5a7I0wtAcX9HXtHcDZsM3
	 0R3XkOnXIC17HgETTaw9RxA64lNgpy67X6PtJcRuh6d4GigJuIPeuc9HTYokPZgpnbKWQLIFJyJ4p
	 JWXB93o1A96WlgtYtCY9DDZNlVtXAW2Wi5AAVHfHcgqOGReWHdBRIoNTzmdLw0JhDvYVYmpr4LnGU
	 fFqNaLdJ8tWUYmWN50uxEPAluAH65lzDq1jKj1+ndocW0qHXMCc5LpDShcKDQJUietHvLa4Vwymh1
	 M9+9eSMS5Kyv8DaOSEkI+D8Np47QK+sUpoaQzZi+u8SNqu4O+JTW2jwJP/Olcq2vbaNyOnnX4xeF7
	 z8VI2ate8Mr/UWIWQcQ2tDXEOYI98GgZDhTTFmPbvyx9b8+vYlLIlV/u63Dz6LetQ/T1JOz5PnJZg
	 ETU8NtK+BKY/EAfNTcIwJ/xPJnh9rTB/FGE3gtYLnGZNIDv25uRZAmkiCycmzUrTsa1ApqVLaBa/N
	 i+nHR+M5ywjBsJOv6zhnaYfV0+8UGr91BgfagBIbj/oVOE0H34BkIplX8nxDg4sreHpIXitCqLY0T
	 UxT+TL9WrCr2kwWGysdw7k8DrmI4nWBfhBpNWrnW3mzcV9BwcgSpJVAmUDsryrcb+mprAeHfr6hrY
	 jjhCFWIvBajPx2FKdhTubl+U+SgRSijA5N1nyRLpAR5moQKRV3zmEO8m5TzB08Hkp2Ow8EdN+EEFf
	 PBTdZLBcn+vXtYvzxrm4AUAeHEJyBUIvZ4ju0Szj/yRqwEGRQ0DKcfU4aOP52NZ7yAoVYuDw7lqVN
	 rILkTf0jEq0Th5FxEI/z97Jzm2tIQz0nGSGqdkAW/N7xCwwLxg4S2A25aO/ndYOoNmvswrbFaDt9L
	 ZVCxEKXKNXcZoiWLBvolGelToP1zuRRyvrO3cJ5LGsGA8OMbVzAGzkH0l1V0y5rM0X3s0TEuhHmHT
	 dAao+4PuPym16lLrWJpnQ/O0siwU/vo5aybKotzjMjxNXwSepB65am8EWPws9wuZFU38Cxc/mmSJH
	 g4AoNjBFUDBRMX69sfV43wMzP5gjjarA4tWrqK9xmq2svqZgBD0hFLfOArTvvBH/VEbvf
From: "=?utf-8?B?c2hlbmdtaW5naHU1MTI=?=" <shengminghu512@qq.com>
To: "=?utf-8?B?dGdseA==?=" <tglx@linutronix.de>, "=?utf-8?B?bWluZ28=?=" <mingo@redhat.com>, "=?utf-8?B?YnA=?=" <bp@alien8.de>, "=?utf-8?B?ZGF2ZS5oYW5zZW4=?=" <dave.hansen@linux.intel.com>, "=?utf-8?B?eDg2?=" <x86@kernel.org>
Cc: "=?utf-8?B?aHBh?=" <hpa@zytor.com>, "=?utf-8?B?YnJvb25pZQ==?=" <broonie@kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?emhhbmcucnVu?=" <zhang.run@zte.com.cn>, "=?utf-8?B?aHUuc2hlbmdtaW5n?=" <hu.shengming@zte.com.cn>
Subject: [PATCH v1] x86/boot: Use pgd_index(__START_KERNEL_map) instead of  hardcoded 511
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 8 Oct 2025 22:43:00 +0800
X-Priority: 3
Message-ID: <tencent_AB982BDF5B2FBDD110C0ECB5A5474B9C4D0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezc43-1t1759934580tulx4ocqe

RnJvbTogU2hlbmdtaW5nIEh1IDxzaGVuZ21pbmdodTUxMkBxcS5jb20+CkRhdGU6IFdlZCwg
OCBPY3QgMjAyNSAyMTo0NjowMyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjFdIHg4Ni9ib290
OiBVc2UgcGdkX2luZGV4KF9fU1RBUlRfS0VSTkVMX21hcCkgaW5zdGVhZCBvZgogaGFyZGNv
ZGVkIDUxMQoKVGhlIGluZGV4IDUxMSBpcyB1c2VkIHRvIHNldCB1cCB0aGUga2VybmVsIGhp
Z2ggbWFwcGluZyBpbiB0aGUKdG9wLWxldmVsIHBhZ2UgdGFibGUuIAoKUmVwbGFjaW5nIHRo
ZSBtYWdpYyBudW1iZXIgd2l0aCBwZ2RfaW5kZXgoX19TVEFSVF9LRVJORUxfbWFwKSAKaW1w
cm92ZXMgY29kZSByZWFkYWJpbGl0eSBhbmQgZnV0dXJlLXByb29mcyB0aGUgY29kZSBhZ2Fp
bnN0IApwb3NzaWJsZSBjaGFuZ2VzIGluIHBhZ2luZyBzdHJ1Y3R1cmUuCgpTaWduZWQtb2Zm
LWJ5OiBTaGVuZ21pbmcgSHUgPHNoZW5nbWluZ2h1NTEyQHFxLmNvbT4KLS0tCiBhcmNoL3g4
Ni9rZXJuZWwvaGVhZDY0LmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvaGVh
ZDY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMKaW5kZXggZmQyOGI1M2RiLi42NWQ0
YzQ4NWEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYworKysgYi9hcmNo
L3g4Ni9rZXJuZWwvaGVhZDY0LmMKQEAgLTI4Niw3ICsyODYsOSBAQCBhc21saW5rYWdlIF9f
dmlzaWJsZSB2b2lkIF9faW5pdCBfX25vcmV0dXJuIHg4Nl82NF9zdGFydF9rZXJuZWwoY2hh
ciAqIHJlYWxfbW9kZQogCWxvYWRfdWNvZGVfYnNwKCk7CiAKIAkvKiBzZXQgaW5pdF90b3Bf
cGd0IGtlcm5lbCBoaWdoIG1hcHBpbmcqLwotCWluaXRfdG9wX3BndFs1MTFdID0gZWFybHlf
dG9wX3BndFs1MTFdOworCXVuc2lnbmVkIGludCBrZXJuZWxfcGdkID0gcGdkX2luZGV4KF9f
U1RBUlRfS0VSTkVMX21hcCk7CisKKwlpbml0X3RvcF9wZ3Rba2VybmVsX3BnZF0gPSBlYXJs
eV90b3BfcGd0W2tlcm5lbF9wZ2RdOwogCiAJeDg2XzY0X3N0YXJ0X3Jlc2VydmF0aW9ucyhy
ZWFsX21vZGVfZGF0YSk7CiB9Ci0tIAoyLjM0LjEK


