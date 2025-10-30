Return-Path: <linux-kernel+bounces-879087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40EC223A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D947B34570E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E020834D3BA;
	Thu, 30 Oct 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOOqTHC4"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6D34D399
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855812; cv=none; b=Eo2leeM19lJey/TJ/8mgjJeLedGTzJfMTNlcEXyghAfqjyQ/VH37IX5E/VAngBg9aTqDZnptfPxg08RK37lFxhhWzOBByQWa1ZPLBx5ra3VuYAKB0RlkNHDlzRDJoP5c5FSENOxrjLXikuC2Y7VBx8BAQDh9BRQ2poaClKzZfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855812; c=relaxed/simple;
	bh=MlzJ5B6r0+3j4EPXrXbwqf6T0HUfZ5wJXo6viDfH6H8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=uwYV3eWZQ30W/ojbIYvqBwO8CSDULBfLxsEcYMMtcgLLgXlv0fh0UCVNGfTgGZMXS7KbVcNlPnusvFHtR2wwCbvRVYfmBzwJQeWBwtHEyNACDGZ4eNZWRk4b/aR1WDZq13fz9026uCCvWgsHbrbwVo7hbKgnaeULeyslBW42dXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOOqTHC4; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-945a42fd465so62753839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761855809; x=1762460609; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vPfJcPgVpU5VuT4Jc6pVlOvtjh3aFfucJllUlD13XuY=;
        b=NOOqTHC4blVraFivTlme3iihTFxloK4XaGVO5mQhi/CzH2AO+XOf7GIddLGfqVY6KV
         pWE1UCSHgDhar1DBueRBMNwHE/dX7d5e4l89Y12K5j5J6ZHW8/Ak7/dyi2gNXw+DjBgX
         SD/DTOtRLTLuOLMhgirGRdtfIkxBqmlZ1NuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855809; x=1762460609;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPfJcPgVpU5VuT4Jc6pVlOvtjh3aFfucJllUlD13XuY=;
        b=rcCsYzEiHcbrocUQ3IsE0ehUll2dWv7jLEGzH8MkBWwgopsXKKpfG+2v88618Gakaq
         x2LlM3GLjwRpCW0imo9S/oaBgCgQXtu6KUU9K1fSohTwGKFucsCay2dPr/V1MkjEkuHC
         q2Mi1c3joK469iwumihMxmbzz5R/RBLCPJro30tlrArzrR6yYj/05G4v/DDxk+eBXdyg
         hH0qp+qkQ9w/UOxVoLqAyKFvI3acFR42ABk+CyHvcdd8zb16MKbsMiEoUKewIyC0W7i0
         0uait90WI5/jRtlKa5QfBFkTa+nQZ13L5xuOvJLxj2P7ARDymJDBc8GLAEnd8hT+UDJ7
         9NuA==
X-Forwarded-Encrypted: i=1; AJvYcCX1alxGJga29AnCXC4+h5OdaBM+k/pSJLLOnKEjIVJxqjpRgDKofn+MrHBiK/YryAiRS8Tu0t/hlvU2FC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3llm9mGj1OF/MswYKHUDrReyaKugLnGd9a9qGaEMczHda2PT
	1IjVPy0cjRpg6KKbHpZTskWRLvr0hujzmwXhVjCbdiwS96rRq4K7TDDqL1jNWrQwR5o=
X-Gm-Gg: ASbGncsa1BAvFRc0CZkcE699yOK2yB3SO0wy5XroAscRGUlUpVaGx3sJzyU3/6qgWkN
	WogsTeH2RVCbskWDArTlc1iWOi5Dowd4wzPVdU7TiS5enU+sxPjaXqm3sJut2HRychoazXJX2c1
	tATABWcYjiyXFhOJvgCFnybRVisgBuzZ2A+sQpCsqjFBibIg0bdSpoT3b5iP+c+MMGTDBLgNnDp
	5QiwDq/7fBOt7oYabVgVfwTLu/xvkjcXDQU1k2ZFkUZEm3+D5pC1gpM73kgeW7lARvMTbVMCWxf
	s58Lygk33fT247efAN4tztqvMwnVLJqg+0rNA5bfxyPYo7/XuytbzCh7zP0WgAOzJepf3moYRGv
	e/0h/c5DOoV94ARUi4TNNWnIft0bWbT+H/jP91rwDHlIMvS4f/qe5MkwltuBPVvqT65mCXL4vl0
	yCO9xq1KdVEkY37IS0Ma62TGw=
X-Google-Smtp-Source: AGHT+IE7nybp/8OgjNb43kcoVp8ksbIRECKRfLtgfo000BMqyTFoQfCDVvVH8ISq3Zcey7+THyElgQ==
X-Received: by 2002:a05:6e02:258c:b0:430:c49d:750c with SMTP id e9e14a558f8ab-4330d1f9b6amr18083705ab.27.1761855809011;
        Thu, 30 Oct 2025 13:23:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67f8d3asm71621555ab.16.2025.10.30.13.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 13:23:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------rws6wvEiGuY1FVZAV4mDVEMh"
Message-ID: <b5aa8141-b80d-487b-b3e9-fea244e69ca8@linuxfoundation.org>
Date: Thu, 30 Oct 2025 14:23:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 raemoar63@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit fixes update for Linux 6.18-rc4

This is a multi-part message in MIME format.
--------------rws6wvEiGuY1FVZAV4mDVEMh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kunit fixes update for Linux 6.18-rc4.

Fixes log overwrite in param_tests and fixes incorrect cast of priv
pointer in test_dev_action(). Updates email address for Rae Moar in
MAINTAINERS KUnit entry.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.18-rc4

for you to fetch changes up to f3903ec76ae6afcdba0347681d1dda005fb145cd:

   MAINTAINERS: Update KUnit email address for Rae Moar (2025-10-29 14:57:54 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.18-rc4

Fixes log overwrite in param_tests and fixes incorrect cast of priv
pointer in test_dev_action(). Updates email address for Rae Moar in
MAINTAINERS KUnit entry.

----------------------------------------------------------------
Carlos Llamas (1):
       kunit: prevent log overwrite in param_tests

Florian Schmaus (1):
       kunit: test_dev_action: Correctly cast 'priv' pointer to long*

Rae Moar (1):
       MAINTAINERS: Update KUnit email address for Rae Moar

  .mailmap               | 1 +
  MAINTAINERS            | 2 +-
  lib/kunit/kunit-test.c | 2 +-
  lib/kunit/test.c       | 3 ++-
  4 files changed, 5 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------rws6wvEiGuY1FVZAV4mDVEMh
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.18-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.18-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhLy5tYWlsbWFwIGIvLm1haWxtYXAKaW5kZXggZDJlZGQyNTZiMTlkLi4y
ZmNmN2U0YTVjZmQgMTAwNjQ0Ci0tLSBhLy5tYWlsbWFwCisrKyBiLy5tYWlsbWFwCkBAIC02
NDIsNiArNjQyLDcgQEAgUWFpcyBZb3VzZWYgPHF5b3VzZWZAbGF5YWxpbmEuaW8+IDxxYWlz
LnlvdXNlZkBhcm0uY29tPgogUXVlbnRpbiBNb25uZXQgPHFtb0BrZXJuZWwub3JnPiA8cXVl
bnRpbi5tb25uZXRAbmV0cm9ub21lLmNvbT4KIFF1ZW50aW4gTW9ubmV0IDxxbW9Aa2VybmVs
Lm9yZz4gPHF1ZW50aW5AaXNvdmFsZW50LmNvbT4KIFF1ZW50aW4gUGVycmV0IDxxcGVycmV0
QHFwZXJyZXQubmV0PiA8cXVlbnRpbi5wZXJyZXRAYXJtLmNvbT4KK1JhZSBNb2FyIDxyYWVt
b2FyNjNAZ21haWwuY29tPiA8cm1vYXJAZ29vZ2xlLmNvbT4KIFJhZmFlbCBKLiBXeXNvY2tp
IDxyandAcmp3eXNvY2tpLm5ldD4gPHJqd0BzaXNrLnBsPgogUmFqZWV2IE5hbmRhbiA8cXVp
Y19yYWplZXZueUBxdWljaW5jLmNvbT4gPHJhamVldm55QGNvZGVhdXJvcmEub3JnPgogUmFq
ZW5kcmEgTmF5YWsgPHF1aWNfcmplbmRyYUBxdWljaW5jLmNvbT4gPHJuYXlha0Bjb2RlYXVy
b3JhLm9yZz4KZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXgg
NDYxMjZjZTJmOTY4Li5lZWZjZmY5OTA5ODcgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisr
KyBiL01BSU5UQUlORVJTCkBAIC0xMzYwMSw3ICsxMzYwMSw3IEBAIEY6CWZzL3NtYi9zZXJ2
ZXIvCiBLRVJORUwgVU5JVCBURVNUSU5HIEZSQU1FV09SSyAoS1VuaXQpCiBNOglCcmVuZGFu
IEhpZ2dpbnMgPGJyZW5kYW4uaGlnZ2luc0BsaW51eC5kZXY+CiBNOglEYXZpZCBHb3cgPGRh
dmlkZ293QGdvb2dsZS5jb20+Ci1SOglSYWUgTW9hciA8cm1vYXJAZ29vZ2xlLmNvbT4KK1I6
CVJhZSBNb2FyIDxyYWVtb2FyNjNAZ21haWwuY29tPgogTDoJbGludXgta3NlbGZ0ZXN0QHZn
ZXIua2VybmVsLm9yZwogTDoJa3VuaXQtZGV2QGdvb2dsZWdyb3Vwcy5jb20KIFM6CU1haW50
YWluZWQKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMgYi9saWIva3VuaXQv
a3VuaXQtdGVzdC5jCmluZGV4IDhjMDFlYWJkNGVhZi4uNjMxMzBhNDhlMjM3IDEwMDY0NAot
LS0gYS9saWIva3VuaXQva3VuaXQtdGVzdC5jCisrKyBiL2xpYi9rdW5pdC9rdW5pdC10ZXN0
LmMKQEAgLTczOSw3ICs3MzksNyBAQCBzdGF0aWMgc3RydWN0IGt1bml0X2Nhc2Uga3VuaXRf
Y3VycmVudF90ZXN0X2Nhc2VzW10gPSB7CiAKIHN0YXRpYyB2b2lkIHRlc3RfZGV2X2FjdGlv
bih2b2lkICpwcml2KQogewotCSoodm9pZCAqKilwcml2ID0gKHZvaWQgKikxOworCSoobG9u
ZyAqKXByaXYgPSAxOwogfQogCiBzdGF0aWMgdm9pZCBrdW5pdF9kZXZpY2VfdGVzdChzdHJ1
Y3Qga3VuaXQgKnRlc3QpCmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVzdC5jIGIvbGliL2t1
bml0L3Rlc3QuYwppbmRleCBiYjY2ZWExYTNlYWMuLjYyZWI1Mjk4MjRjNiAxMDA2NDQKLS0t
IGEvbGliL2t1bml0L3Rlc3QuYworKysgYi9saWIva3VuaXQvdGVzdC5jCkBAIC03NDUsNyAr
NzQ1LDggQEAgaW50IGt1bml0X3J1bl90ZXN0cyhzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRl
KQogCQkJCQkucGFyYW1faW5kZXggPSArK3Rlc3QucGFyYW1faW5kZXgsCiAJCQkJCS5wYXJl
bnQgPSAmdGVzdCwKIAkJCQl9OwotCQkJCWt1bml0X2luaXRfdGVzdCgmcGFyYW1fdGVzdCwg
dGVzdF9jYXNlLT5uYW1lLCB0ZXN0X2Nhc2UtPmxvZyk7CisJCQkJa3VuaXRfaW5pdF90ZXN0
KCZwYXJhbV90ZXN0LCB0ZXN0X2Nhc2UtPm5hbWUsIE5VTEwpOworCQkJCXBhcmFtX3Rlc3Qu
bG9nID0gdGVzdF9jYXNlLT5sb2c7CiAJCQkJa3VuaXRfcnVuX2Nhc2VfY2F0Y2hfZXJyb3Jz
KHN1aXRlLCB0ZXN0X2Nhc2UsICZwYXJhbV90ZXN0KTsKIAogCQkJCWlmIChwYXJhbV9kZXNj
WzBdID09ICdcMCcpIHsK

--------------rws6wvEiGuY1FVZAV4mDVEMh--

