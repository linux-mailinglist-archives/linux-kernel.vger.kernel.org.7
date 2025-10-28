Return-Path: <linux-kernel+bounces-874579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F167EC169DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FC63B5E15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E134E750;
	Tue, 28 Oct 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ePnUyuR4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923C34F47D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679773; cv=none; b=lbUopxt+p95dEYZ0NOFSmR3J0L6xqkFFmb4U4l1cZxdeQ2hepZBnTIiC7Vy8TXAYhFWbWYduCWKoFPiATfkngavLB3/FbU0NofCFSdenEf1hCYZovkTUcXN5oemGuUMiSH/fgm8jBOiVkcHNMWLB/8zA2P0Y/U3gGAGhKjB3Yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679773; c=relaxed/simple;
	bh=VvgYQDa9o3KaJgGwDm3yCh/9qrhwc7at0o8bcejUs6o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BppXGQRObbvhmcaW9I9y8Gc75Gd4prtKtGpccq0Haivv+pLqj+iqBFaNhR/aXfjseFNeVe7/qIkwHINDHAUjH2j0jW5GbhU1ugiU0kx+uL/t01Le7PN4DqlhsaYXOxtbhUgvAIs9vW82zFAnQoXI/x1moHS1XV92rMTnZ/YY7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ePnUyuR4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d83bf1077so311512966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761679769; x=1762284569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nef3blRC0kHEzReOsPdqe7sl7fzrgsdNhD+HkakEipA=;
        b=ePnUyuR4HqOl1klX1Semds6gkhv9lVqyG3pn+qjJ63JKMdDVXYrfnLeF7YOKo3vM6F
         ++pHuoeRlDHii/M+xipOD76bVaGWSL2GjzGmbI523j8/+9NXamhsRejthmXX7hGkAluQ
         vrXH7vJA+GrELGE3JPV7uMZaJZ3bwFsM89XF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679769; x=1762284569;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nef3blRC0kHEzReOsPdqe7sl7fzrgsdNhD+HkakEipA=;
        b=P3aXpKvqXD0Y7Q95imrf8GwFMsK5q7cwBZERjr/Qs2EKunO0BleC+ybIaWLUxz8h0q
         PywH9SltEoHajWkK0Gr3YjenabYB67v34c6ckKe/HJzENM8Fy36blVsXmwit0nTzCmvp
         XYHNlH1YAFshxCtB07a+9awH4reaCcGJtxKPPWQDYQLcD9TKEXJrbN5TYMPtwcb8VGmc
         qwj/Ypz6f4YHmEiWpAyNPJz8DbapOnkhXhwTFdo4s4KZxREjxVo9j/uVA6yc3OcdpohF
         cwH5BCvP2qhsO0uhCnGkT6jJ3IlGnO3AvCmFNjc8cOEZIQVwJZKYBmCOnCRDRroxjwzz
         i0ng==
X-Gm-Message-State: AOJu0YzcjKsXrOYSgMY8atZnRcNtqt66Rq6O/FjWdPH7WQwh+0KoazEl
	taCwCQ1nJCl8BDaJLWAmqGynlOr2C5BHPCD8FB6R6iXMJn4FmxWNmW9fqKTQqPBDGuVHq66isVU
	ST7PC9ihX+g==
X-Gm-Gg: ASbGncvtFtjbi8q+fCB+PdHRJLeWufNmDo6SABqkYMCW47M6oPV6p7lz2PRuCyUIRaT
	OULxMZrEk8ldT9Sd9/KJvmptBerGv+0pBhz3VsoXGONiSWFAEMpk3O7eLdc0zCDrx1tCR/3csdr
	z4vsFEw4Z7x/GC3K/0gntZr5Y+EHnYLJdklqotNx0O93Rol3+uQI3iIfXAdUYYGBOrOWhpIshng
	01b95ZHDIVTYfy1T40DR7DhsShNX4tkAw647KqPYbPD6PKB3qxAZgqPwfD+VURiYK9K7c9+KjOl
	BuhFhAhvrm1GZlZxkOxvDCFDI7jmfm2ZbVZOAlUKCQgrIBoq1G1z7seKG6dXef4DVbD7140Ve+z
	JsPC+KiGEMiFwkV03ZdClUDKK2TypRUC81By7p82JGq/4+Qyi1dRYVC9SBRI3rT46wUb0x9I4P4
	B5b7afXSMiFrJfMuRm8ijG4apiWKqf18Iqhfmvm4hsdUgjPvtrOQ==
X-Google-Smtp-Source: AGHT+IE8y6B6DJn+iKUtr90dX0lUAiKJtif9fwIgdC3gGkhoHrYDWgu3MHtGSTO1/+VudOt1aw5j3Q==
X-Received: by 2002:a17:907:7f13:b0:b6d:5718:d43f with SMTP id a640c23a62f3a-b703d4d5f6amr15538066b.39.1761679769495;
        Tue, 28 Oct 2025 12:29:29 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e75sm1156722766b.66.2025.10.28.12.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:29:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso9621970a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:29:28 -0700 (PDT)
X-Received: by 2002:a05:6402:5216:b0:63b:dc7d:7308 with SMTP id
 4fb4d7f45d1cf-6404418ad49mr174177a12.5.1761679768332; Tue, 28 Oct 2025
 12:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 12:29:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
X-Gm-Features: AWmQ_bkYVnRGEf-TB-ILqQ47h7AUjpF-A96MZBsK6u917ODRigTUUQ4LkkIcTmo
Message-ID: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
Subject: odd objtool 'unreachable instruction' warning
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cd114706423d0859"

--000000000000cd114706423d0859
Content-Type: text/plain; charset="UTF-8"

Josh, Peter,
 due to another entirely unrelated discussion, I ended up resurrecting
my "make asm readable" patch that I have had in my local tree when I
want to look at the actual generated code for user accesses.

That is a local hack that just removes the alternative noise for the
common ops, so that I actually see the fences and clac/stac
instructions as such, instead of seeing them as nops in the object
file or as horrible noise in the assembler output.

So that patch is not something I'd ever commit in general, but it's
really useful for checking code generation - but it results in odd
objdump warnings these days (I say "these days", because I've used
that patch locally over the years, and the objdump warning hasn't
always been there).

It's a pretty odd warning, because the code looks fine to me, but I
might be missing something obvious.

Anyway, this is clearly not a big and urgent problem, but I'd love for
you to take a look. I'm attaching the patch I use so  you can see what
I mean.. Any ideas what triggers that warning? Because I'd love to
keep this patch in my local tree without having objtool be upset with
me....

                   Linus

--000000000000cd114706423d0859
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Avoid-alternative-assembler-noise-for-common-ops.patch"
Content-Disposition: attachment; 
	filename="0001-Avoid-alternative-assembler-noise-for-common-ops.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhaymcm80>
X-Attachment-Id: f_mhaymcm80

RnJvbSA5N2MxNmJkMWY0NDI4N2Y5NWYxYmU4MjE4NTYzMWQ2NTRhNjAyMmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFdlZCwgMyBBcHIgMjAyNCAxMDozMzoxMiAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIEF2b2lkIGFsdGVybmF0aXZlIGFzc2VtYmxlciBub2lzZSBmb3IgY29tbW9uIG9wcwoK
SnVzdCBoYXJkY29kZSB0aGUgb25lcyBJIGhhdmUgZm9yIFNNUCBhbmQgTEZFTkNFCi0tLQogYXJj
aC94ODYvaW5jbHVkZS9hc20vYWx0ZXJuYXRpdmUuaCB8ICA3ICstLS0tLS0KIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL2JhcnJpZXIuaCAgICAgfCAgMiArLQogYXJjaC94ODYvaW5jbHVkZS9hc20vc21h
cC5oICAgICAgICB8IDE4ICsrKysrKy0tLS0tLS0tLS0tLQogYXJjaC94ODYvbGliL2dldHVzZXIu
UyAgICAgICAgICAgICB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYWx0ZXJu
YXRpdmUuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FsdGVybmF0aXZlLmgKaW5kZXggMTViYzA3
YTVlYmIzLi4yODFjODIzYTg2OWUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Fs
dGVybmF0aXZlLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYWx0ZXJuYXRpdmUuaApAQCAt
NDIsMTIgKzQyLDcgQEAKICAqLwogCiAjaWZkZWYgQ09ORklHX1NNUAotI2RlZmluZSBMT0NLX1BS
RUZJWF9IRVJFIFwKLQkJIi5wdXNoc2VjdGlvbiAuc21wX2xvY2tzLFwiYVwiXG4iCVwKLQkJIi5i
YWxpZ24gNFxuIgkJCQlcCi0JCSIubG9uZyA2NzFmIC0gLlxuIiAvKiBvZmZzZXQgKi8JCVwKLQkJ
Ii5wb3BzZWN0aW9uXG4iCQkJCVwKLQkJIjY3MToiCisjZGVmaW5lIExPQ0tfUFJFRklYX0hFUkUK
IAogI2RlZmluZSBMT0NLX1BSRUZJWCBMT0NLX1BSRUZJWF9IRVJFICJcblx0bG9jayAiCiAKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JhcnJpZXIuaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2JhcnJpZXIuaAppbmRleCBkYjcwODMyMjMyZDQuLjJiOTExYzg4NDY3YiAxMDA2NDQK
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYmFycmllci5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2JhcnJpZXIuaApAQCAtNDUsNyArNDUsNyBAQAogCV9fbWFzazsgfSkKIAogLyogUHJl
dmVudCBzcGVjdWxhdGl2ZSBleGVjdXRpb24gcGFzdCB0aGlzIGJhcnJpZXIuICovCi0jZGVmaW5l
IGJhcnJpZXJfbm9zcGVjKCkgYWx0ZXJuYXRpdmUoIiIsICJsZmVuY2UiLCBYODZfRkVBVFVSRV9M
RkVOQ0VfUkRUU0MpCisjZGVmaW5lIGJhcnJpZXJfbm9zcGVjKCkgYXNtIHZvbGF0aWxlKCJsZmVu
Y2UiOjo6Im1lbW9yeSIpCiAKICNkZWZpbmUgX19kbWFfcm1iKCkJYmFycmllcigpCiAjZGVmaW5l
IF9fZG1hX3dtYigpCWJhcnJpZXIoKQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
c21hcC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc21hcC5oCmluZGV4IDRmODRkNDIxZDFjZi4u
NjEzYjI0YTU4YjI2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zbWFwLmgKKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc21hcC5oCkBAIC0xNSwyNCArMTUsMjAgQEAKIAogI2lm
ZGVmIF9fQVNTRU1CTEVSX18KIAotI2RlZmluZSBBU01fQ0xBQyBcCi0JQUxURVJOQVRJVkUgIiIs
ICJjbGFjIiwgWDg2X0ZFQVRVUkVfU01BUAorI2RlZmluZSBBU01fQ0xBQyAiY2xhYyIKIAotI2Rl
ZmluZSBBU01fU1RBQyBcCi0JQUxURVJOQVRJVkUgIiIsICJzdGFjIiwgWDg2X0ZFQVRVUkVfU01B
UAorI2RlZmluZSBBU01fU1RBQyAic3RhYyIKIAogI2Vsc2UgLyogX19BU1NFTUJMRVJfXyAqLwog
CiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgY2xhYyh2b2lkKQogewotCS8qIE5vdGU6IGEg
YmFycmllciBpcyBpbXBsaWNpdCBpbiBhbHRlcm5hdGl2ZSgpICovCi0JYWx0ZXJuYXRpdmUoIiIs
ICJjbGFjIiwgWDg2X0ZFQVRVUkVfU01BUCk7CisJYXNtIHZvbGF0aWxlKCJjbGFjIjogOiA6Im1l
bW9yeSIpOwogfQogCiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc3RhYyh2b2lkKQogewot
CS8qIE5vdGU6IGEgYmFycmllciBpcyBpbXBsaWNpdCBpbiBhbHRlcm5hdGl2ZSgpICovCi0JYWx0
ZXJuYXRpdmUoIiIsICJzdGFjIiwgWDg2X0ZFQVRVUkVfU01BUCk7CisJYXNtIHZvbGF0aWxlKCJz
dGFjIjogOiA6Im1lbW9yeSIpOwogfQogCiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVk
IGxvbmcgc21hcF9zYXZlKHZvaWQpCkBAIC01OCwxMCArNTQsOCBAQCBzdGF0aWMgX19hbHdheXNf
aW5saW5lIHZvaWQgc21hcF9yZXN0b3JlKHVuc2lnbmVkIGxvbmcgZmxhZ3MpCiB9CiAKIC8qIFRo
ZXNlIG1hY3JvcyBjYW4gYmUgdXNlZCBpbiBhc20oKSBzdGF0ZW1lbnRzICovCi0jZGVmaW5lIEFT
TV9DTEFDIFwKLQlBTFRFUk5BVElWRSgiIiwgImNsYWMiLCBYODZfRkVBVFVSRV9TTUFQKQotI2Rl
ZmluZSBBU01fU1RBQyBcCi0JQUxURVJOQVRJVkUoIiIsICJzdGFjIiwgWDg2X0ZFQVRVUkVfU01B
UCkKKyNkZWZpbmUgQVNNX0NMQUMgImNsYWMiCisjZGVmaW5lIEFTTV9TVEFDICJzdGFjIgogCiAj
ZGVmaW5lIEFTTV9DTEFDX1VOU0FGRSBcCiAJQUxURVJOQVRJVkUoIiIsIEFOTk9UQVRFX0lHTk9S
RV9BTFRFUk5BVElWRSAiY2xhYyIsIFg4Nl9GRUFUVVJFX1NNQVApCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9saWIvZ2V0dXNlci5TIGIvYXJjaC94ODYvbGliL2dldHVzZXIuUwppbmRleCA5ZDU2NTRi
OGE3MmEuLjFjNTk1MmM2MzdjZSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvbGliL2dldHVzZXIuUwor
KysgYi9hcmNoL3g4Ni9saWIvZ2V0dXNlci5TCkBAIC0zNyw3ICszNyw3IEBACiAjaW5jbHVkZSA8
YXNtL3NtYXAuaD4KICNpbmNsdWRlIDxhc20vcnVudGltZS1jb25zdC5oPgogCi0jZGVmaW5lIEFT
TV9CQVJSSUVSX05PU1BFQyBBTFRFUk5BVElWRSAiIiwgImxmZW5jZSIsIFg4Nl9GRUFUVVJFX0xG
RU5DRV9SRFRTQworI2RlZmluZSBBU01fQkFSUklFUl9OT1NQRUMgbGZlbmNlCiAKIC5tYWNybyBj
aGVja19yYW5nZSBzaXplOnJlcQogLmlmIElTX0VOQUJMRUQoQ09ORklHX1g4Nl82NCkKLS0gCjIu
NTEuMS41MzQuZzZkMmI0YmYyZjQKCg==
--000000000000cd114706423d0859--

