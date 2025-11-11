Return-Path: <linux-kernel+bounces-895753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F220C4ED06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A094818991D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3C3587A8;
	Tue, 11 Nov 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaist.ac.kr header.i=@kaist.ac.kr header.b="QfQBa1ME"
Received: from send004.gov-dooray.com (send004.gov-dooray.com [211.56.2.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08482EAB79
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.56.2.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875481; cv=none; b=rKgHngXo7ASGZEwjgYBOY6BgtJcaPhR5PVvjJ6nyPyep5QpIcWmevVYJ7HS2v8587QFtnjl/Zzdr1CP60yjrB+59+5H19WS3yjfGggPpInO/4Ue6e5HajcM3BEOK/9nFKsCdsmvnotaImOzL/8HIhDVCVUxXziTIqVWM6fFbzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875481; c=relaxed/simple;
	bh=hz4l2YAmbApubXE/DyWcLMkmPPD/9P8vW2pMCK6+nw0=;
	h=From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:Date; b=ib324JwIdS9O/VFPqZ4MtoVBy5Iw2Q5fJRYuPR6a8Ad+FxaFLXgXfYrDVV1pFKd1hiojr+Vb8uXbCzd9d/Xw70UkijsCIjvLzZ0uRQBRx6/LPGlxifZ1TaSvp7RfbX5pCJKMdi1wO+COneG8OgbB8gkNBNmUCmSxszbW0L9rfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaist.ac.kr; spf=pass smtp.mailfrom=kaist.ac.kr; dkim=pass (2048-bit key) header.d=kaist.ac.kr header.i=@kaist.ac.kr header.b=QfQBa1ME; arc=none smtp.client-ip=211.56.2.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaist.ac.kr
DKIM-Signature: a=rsa-sha256;
 b=QfQBa1ME9HYi7qB3YUb9VFfk3/L1ROXieEFcPDuSBTn8WFofxL8QThs4sqpal9mG5NN1p7naWk
  7XlARRMSA49ciHn6KR6OBUrGIty6dagsCj4In2E304fYSusg3Xip2YiYoL+apUjw4xI9JmDGfRex
  ajM7TLqWlt1jfIrUUF0UVW6Px0Fo4OvpY3avJL+eUW7tWcknGszx4oYtqH+lph0ObLP+rEUkzKiS
  jjLA7I/0ddPvG0WJIGflCxpPgj/2fuk6ofeg2Q1V1y2LcEiU8mT8G43DWPf5BeTA1TUAy6F/8ozX
  39nAcdB/bw5q1UjQ/3FMxFmppToy2qH8OWZpWinA==;
 c=relaxed/relaxed; s=dooray; d=kaist.ac.kr; v=1;
 bh=hz4l2YAmbApubXE/DyWcLMkmPPD/9P8vW2pMCK6+nw0=;
 h=From:To:Subject:Message-ID;
Dooray-Meta-Signature: wSOqMZWRKdGTgC0DkpRMwcW2KCo3EALNC6NAuK/V/KJKisFB9yWKU
  QD8mFjJOtwgpNdmjwyNDuTnnrvk3LuwAp67hZuqvy66co7oGDaA0i0WgJHQzW4jWuX1mgcPtBed/
  NuFTfC6HNwhX1jjTdswcHIam5CHwFtoykRBdU5EX1uWP6BSWAV7dIghyaNO21GTCZU4gy3S04N2v
  0DBfSpuYyXxEKali0VBoIr02wvKuGGg+kjelb3zJouvP7C4v1j5H4ZVdMj4+WpmmcPl73TklNq1M
  FDrtyQLVXeGPfKM/3Kgz4K+CBtpGvbioWni8sdkXgg9MZo/xxCrHIwQjGNQMWvQl4/IfMlpj3o0f
  A7Wz49mIJFHaQ5tTD0RcCzKhtN7
Received: from [183.107.24.242] (HELO 183.107.24.242) ([183.107.24.242]) by
 send004.gov-dooray.com with SMTP id aca878c469135852; Wed, 12 Nov 2025
 00:37:54 +0900
From: Haein Lee <lhi0729@kaist.ac.kr>
To: Takashi Iwai <tiwai@suse.de>, perex@perex.cz
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Message-ID: <vwhzmoba9j2f.vwhzmob9u9e2.g6@dooray.com>
Subject: =?UTF-8?B?W1BBVENIIHYzXSBBTFNBOiB1c2ItYXVkaW86IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gc25kX3VzYl9taXhlcl9jb250cm9sc19iYWRk?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Dsn-Request: true
X-Dooray-Agent: mail-api
X-Dooray-Mail-Id: 4199096924239175367
Importance: Normal
X-Priority: Normal
X-MSMail-Priority: Normal
X-Dooray-Attached: c3+LUOpPU/IB7Wl+oemm0lw5HiI/bJHHYClX72L8E3o=
Content-Transfer-Encoding: base64
Sender: "Haein Lee" <lhi0729@kaist.ac.kr>
X-Dooray-Big-Attached: false
X-Dooray-ClientIp: 183.107.24.242
Date: Wed, 12 Nov 2025 00:37:54 +0900 (KST)

SW4gc25kX3VzYl9jcmVhdGVfc3RyZWFtcygpLCBmb3IgVUFDIHZlcnNpb24gMyBkZXZpY2VzLCB0
aGUgSW50ZXJmYWNlCkFzc29jaWF0aW9uIERlc2NyaXB0b3IgKElBRCkgaXMgcmV0cmlldmVkIHZp
YSB1c2JfaWZudW1fdG9faWYoKS4gSWYgdGhpcwpjYWxsIGZhaWxzLCBhIGZhbGxiYWNrIHJvdXRp
bmUgYXR0ZW1wdHMgdG8gb2J0YWluIHRoZSBJQUQgZnJvbSB0aGUgbmV4dAppbnRlcmZhY2UgYW5k
IHNldHMgYSBCQUREIHByb2ZpbGUuIEhvd2V2ZXIsIHNuZF91c2JfbWl4ZXJfY29udHJvbHNfYmFk
ZCgpCmFzc3VtZXMgdGhhdCB0aGUgSUFEIHJldHJpZXZlZCBmcm9tIHVzYl9pZm51bV90b19pZigp
IGlzIGFsd2F5cyB2YWxpZCwKd2l0aG91dCBwZXJmb3JtaW5nIGEgTlVMTCBjaGVjay4gVGhpcyBj
YW4gbGVhZCB0byBhIE5VTEwgcG9pbnRlcgpkZXJlZmVyZW5jZSB3aGVuIHVzYl9pZm51bV90b19p
ZigpIGZhaWxzIHRvIGZpbmQgdGhlIGludGVyZmFjZSBkZXNjcmlwdG9yLgoKVGhpcyBwYXRjaCBh
ZGRzIGEgTlVMTCBwb2ludGVyIGNoZWNrIGFmdGVyIGNhbGxpbmcgdXNiX2lmbnVtX3RvX2lmKCkg
aW4Kc25kX3VzYl9taXhlcl9jb250cm9sc19iYWRkKCkgdG8gcHJldmVudCB0aGUgZGVyZWZlcmVu
Y2UuCgpUaGlzIGlzc3VlIHdhcyBkaXNjb3ZlcmVkIGJ5IHN5emthbGxlciwgd2hpY2ggdHJpZ2dl
cmVkIHRoZSBidWcgYnkgc2VuZGluZwphIGNyYWZ0ZWQgVVNCIGRldmljZSBkZXNjcmlwdG9yLgoK
U2lnbmVkLW9mZi1ieTogSGFlaW4gTGVlIDxsaGkwNzI5QGthaXN0LmFjLmtyPgotLS0KIHNvdW5k
L3VzYi9taXhlci5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlci5jIGIvc291bmQvdXNiL21peGVyLmMKaW5kZXggNmYw
MGUwZDUyMzgyLi43MmI5MDA1MDVkMmMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3VzYi9taXhlci5jCisr
KyBiL3NvdW5kL3VzYi9taXhlci5jCkBAIC0zMDg2LDYgKzMwODYsOCBAQCBzdGF0aWMgaW50IHNu
ZF91c2JfbWl4ZXJfY29udHJvbHNfYmFkZChzdHJ1Y3QgdXNiX21peGVyX2ludGVyZmFjZSAqbWl4
ZXIsCiAJaW50IGk7CiAKIAlhc3NvYyA9IHVzYl9pZm51bV90b19pZihkZXYsIGN0cmxpZiktPmlu
dGZfYXNzb2M7CisJaWYgKCFhc3NvYykKKwkJcmV0dXJuIC1FSU5WQUw7CiAKIAkvKiBEZXRlY3Qg
QkFERCBjYXB0dXJlL3BsYXliYWNrIGNoYW5uZWxzIGZyb20gQVMgRVAgZGVzY3JpcHRvcnMgKi8K
IAlmb3IgKGkgPSAwOyBpIDwgYXNzb2MtPmJJbnRlcmZhY2VDb3VudDsgaSsrKSB7Ci0tIAoyLjM0
LjEK


