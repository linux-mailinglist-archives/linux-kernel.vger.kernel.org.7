Return-Path: <linux-kernel+bounces-805838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC4B48E17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFEB34332E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4C305073;
	Mon,  8 Sep 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="CK4MNrA5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139D305064
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335749; cv=none; b=aqvJmtwV8rXJy7sZ1Akv9M/QlERAi1THSSJYb5GO72LIoXY1xI9vhB6Yf3cBTG1GMFdJote8GaREYYTL1u3OICq4SPQ7p5ARczCr2xKsG5wp2/OQitEzR4R4hBXCy68x3m4LTNo3gEBKNSlS5EE+O7vkFY2t8ZCyjlq7kiGWXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335749; c=relaxed/simple;
	bh=oAslyF7M/uHmSID/9KflasiN7O1bWH94H0b3AjFaVKI=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=DZIR8alT6VihF94oEYfH2TC814ZLDeOX1eMSqWpHgXXA0kQWTePXuY6qzI2ppqQb8qmreFIVJNoUwXzmOZoQWUieFJurpci1/Inw5Y4wR8rD0jUOuVOCjEJfFV9ZAbXFc+Idp4lBPQMoXfENvBuM/PQiE1q24JRlwaqmrWPuGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=CK4MNrA5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772843b6057so3475431b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757335747; x=1757940547; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0cvFJDvjr4YU4mgWJwpMj6Y/9dcnIOsVS+VeFHLv6W0=;
        b=CK4MNrA5zRbvKtbLqiMA29eC+Mxqgt/9WKhzdw42bycKmLgLFtFw6/bRJwZs6LCN19
         /7AvPHqGyYqyMlS9ijfJU9njduKEJ7Xo5CPLH0goRmCTuR4g9HKalSKCDEEjlVvllC6J
         D2kAOrno9FbWeo/BS6/nKhT9HyhSH9m8FUxAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335747; x=1757940547;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cvFJDvjr4YU4mgWJwpMj6Y/9dcnIOsVS+VeFHLv6W0=;
        b=qK2HZxkpOYtReILK3mM9GNZtyhFYXEM8LJA6JZL9CHQ3rrfFGbwoWhN4myDDTxBE2E
         5GzQp8gq9Al7ObVx5cD8M718gb2LGoVVJJOysdi1P7Orge0O+ZuU8V3KG5Dg5KPsKtqU
         TwdEQfjkggEig1r76QCCDGEA+eL7qSCf6m3BVhEDmGc2qSWpCuzPb2NPtzHMVVaIuiFb
         70a4NuSkSH1Q+dC2fPjc/2NW5Dpps0JzQ53fDVf5e6rkRcEyGV0ZKlgU6VyyBzh2ICW9
         S99pFXeRqJDQsUEB2UMiEf8q+luCwLne4Ot44cuEkHDMkNkiYjufpPg7CImZqca9uj48
         3qLg==
X-Forwarded-Encrypted: i=1; AJvYcCWxpHMzO8VdVoAHemvL4bPH2tFcSaoWQydIrU7n8qYymi0dQ5or2ULz72OLLJHtyfcqr19LjN+wWUs8RpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTL55h5AxFYjTUv3xavLK0uyhm2g871ccVv9p8zW5yVCC/+9rQ
	Ztc6Tz1RylwkGClCwh0ftc7bbg6nAnWoGn3u6SDCZ87KzAVAqfWtlgVcNGRIns23kew=
X-Gm-Gg: ASbGncsYSKFrLRKx0HGRuZ8XkZ5ijHQ2IBUJ6WThe7iX7hUCLcCuLSBSeVXzsr5ryGV
	0wrOhvKKYpEX5l7VPYIH6o3dy5SFGvL6rcqpDCfzxsvBCLEmfbS73c7jjXcimJsKlsgbgyovQ7A
	OaPTe8BrIu37vAWwDnbRYhIIgwJg3Q2nVFby6wuLrihrsVkN2OhEoolXfm3p/XkBEn7HahqnM59
	9bIEXrNYKNzk9HFSAFVFFEyMqX35e3QcduOqypFRfmXnu23k9FooZc4xJrQTWLAJjKYPrrzzC/f
	ej/OJ/UNj7APdzjCT26kWbFe2AufIXPpqAc2ZghrpGAGHDTNAkx7m9OZqiqDdIIdlsRRO5xyfxb
	evJzG5c8HPyqaBm1Oh1BX3xfS+sCuIQ3VcUlb3UraCLDpogB7pQjyth5h
X-Google-Smtp-Source: AGHT+IGuVZptP7eiCvGiNnkkAXjmzVvrQCbT3xTJux7aEQ2PESk032U3lPMfV9Wt3EhhtQQA7GeHzA==
X-Received: by 2002:a05:6a00:929d:b0:774:2274:a56e with SMTP id d2e1a72fcca58-7742de11ed9mr11369476b3a.25.1757335747216;
        Mon, 08 Sep 2025 05:49:07 -0700 (PDT)
Received: from [192.168.1.2] ([179.105.152.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772608b1b5asm20882482b3a.46.2025.09.08.05.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:49:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------wX2quirtuaTXvggDAiEUCwWd"
Message-ID: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com>
Date: Mon, 8 Sep 2025 09:49:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
From: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()

This is a multi-part message in MIME format.
--------------wX2quirtuaTXvggDAiEUCwWd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello all,

The function btrfs_encode_fh() does not properly account for the three 
cases it handles.

Before writing to the file handle (fh), the function only returns to the 
user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or 
BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).

However, when a parent exists and the root ID of the parent and the 
inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROOT 
(10 dwords, 40 bytes).

If *max_len is not large enough, this write goes out of bounds because 
BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than 
BTRFS_FID_SIZE_CONNECTABLE originally returned.

This results in an 8-byte out-of-bounds write at 
fid->parent_root_objectid = parent_root_id.

A previous attempt to fix this issue was made but was lost.

https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com/

Although this issue does not seem to be easily triggerable, it is a 
potential memory corruption bug that should be fixed. This patch 
resolves the issue by ensuring the function returns the appropriate size 
for all three cases and validates that *max_len is large enough before 
writing any data.

Tested on v6.17-rc4.

Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---

fs/btrfs/export.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

--------------wX2quirtuaTXvggDAiEUCwWd
Content-Type: text/x-patch; charset=UTF-8;
 name="btrfs_out_of_bounds_in_btrfs_encode_fh.patch"
Content-Disposition: attachment;
 filename="btrfs_out_of_bounds_in_btrfs_encode_fh.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2V4cG9ydC5jIGIvZnMvYnRyZnMvZXhwb3J0LmMKaW5k
ZXggN2ZjOGEzMjAwYjQwLi4wODZhOTdjMmFhNjkgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2V4
cG9ydC5jCisrKyBiL2ZzL2J0cmZzL2V4cG9ydC5jCkBAIC0yMyw3ICsyMywxMCBAQCBzdGF0
aWMgaW50IGJ0cmZzX2VuY29kZV9maChzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1MzIgKmZoLCBp
bnQgKm1heF9sZW4sCiAJaW50IHR5cGU7CiAKIAlpZiAocGFyZW50ICYmIChsZW4gPCBCVFJG
U19GSURfU0laRV9DT05ORUNUQUJMRSkpIHsKLQkJKm1heF9sZW4gPSBCVFJGU19GSURfU0la
RV9DT05ORUNUQUJMRTsKKwkJaWYoYnRyZnNfcm9vdF9pZChCVFJGU19JKGlub2RlKS0+cm9v
dCkgIT0gYnRyZnNfcm9vdF9pZChCVFJGU19JKHBhcmVudCktPnJvb3QpKQorCQkJKm1heF9s
ZW4gPSBCVFJGU19GSURfU0laRV9DT05ORUNUQUJMRV9ST09UOworCQllbHNlCisJCQkqbWF4
X2xlbiA9IEJUUkZTX0ZJRF9TSVpFX0NPTk5FQ1RBQkxFOwogCQlyZXR1cm4gRklMRUlEX0lO
VkFMSUQ7CiAJfSBlbHNlIGlmIChsZW4gPCBCVFJGU19GSURfU0laRV9OT05fQ09OTkVDVEFC
TEUpIHsKIAkJKm1heF9sZW4gPSBCVFJGU19GSURfU0laRV9OT05fQ09OTkVDVEFCTEU7CkBA
IC00NSw2ICs0OCw4IEBAIHN0YXRpYyBpbnQgYnRyZnNfZW5jb2RlX2ZoKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHUzMiAqZmgsIGludCAqbWF4X2xlbiwKIAkJcGFyZW50X3Jvb3RfaWQgPSBi
dHJmc19yb290X2lkKEJUUkZTX0kocGFyZW50KS0+cm9vdCk7CiAKIAkJaWYgKHBhcmVudF9y
b290X2lkICE9IGZpZC0+cm9vdF9vYmplY3RpZCkgeworCQkJaWYoKm1heF9sZW4gPCBCVFJG
U19GSURfU0laRV9DT05ORUNUQUJMRV9ST09UKQorCQkJCXJldHVybiBGSUxFSURfSU5WQUxJ
RDsKIAkJCWZpZC0+cGFyZW50X3Jvb3Rfb2JqZWN0aWQgPSBwYXJlbnRfcm9vdF9pZDsKIAkJ
CWxlbiA9IEJUUkZTX0ZJRF9TSVpFX0NPTk5FQ1RBQkxFX1JPT1Q7CiAJCQl0eXBlID0gRklM
RUlEX0JUUkZTX1dJVEhfUEFSRU5UX1JPT1Q7Cg==

--------------wX2quirtuaTXvggDAiEUCwWd--

