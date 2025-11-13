Return-Path: <linux-kernel+bounces-900085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB13C5996E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 529534E63E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357731618E;
	Thu, 13 Nov 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GbuNqQTM"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6D3112BC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059961; cv=none; b=gUwfBuMD3THqZlRt9FA4oqnLkw3XkWCwUGkRFfiYLSI8C8PpmQZKVaZa/xJbmYBEznOLrlK+8E+aBQ4umzK94wgLb7KicpCNFtZg+N8V79NwCmqOWYhsnL9ZLyG9lmZaGhKOAuCeZVHYZS7qo7b4qwZKi7+BxbNyXbCYV73B6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059961; c=relaxed/simple;
	bh=tY+LqcJi+t4vC6sC8QoxXUZexC4HaIVQqUDXfk6E/Gk=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=oVdIoGnWIy2FfetLg43zLGOZ9mG7UdxSQ8xV0UFw5wUxtqxTqC6XvMKXR5eJKPjk2jzpEB9hTtp87qPInPHUOZiXSJT0YihrWAICE/8M4nx2gXex9ljCYbGBEF0ruBOr/5whpmk78U+GA+SATgCvN3WRuVAt2g5Um2bEAtZsy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GbuNqQTM; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-940d327df21so41901539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763059959; x=1763664759; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1KVDNdeiUNjeLgJncmsFihjy0/HtaAIfwMHOw6agH2w=;
        b=GbuNqQTMV+XQVndGd3Kh0vtc8WgKtJq3hL6KfmKdqZ0VIA6L6+dRZpZClklr99v74e
         2TONNAyAqeNeg29RpBIsa57qShxTZthwFzradSqY90fwDmVdYuoAQJpZ78zDN6DSBT5r
         9Jc4+pM4Y/biE5C3gJIqeOSWGoRut/QGJJ3C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059959; x=1763664759;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KVDNdeiUNjeLgJncmsFihjy0/HtaAIfwMHOw6agH2w=;
        b=bZ4+jPls1nX/cx/fsP1gI07kdnnKiT5Jfugrv6iJJmRXdiwQz3AegaFbBvIEQKfOsY
         D5Zu2IGvonWwVXuEDHqKWmlvcKvXxeXhTDE0jiY9tdyTaBrBERRqU7f2nl8FQe9nYgjB
         puqDhqZCrMHSLiNw/QtwMUt9SRe57rSZDpGmUf9f0isUovrmPIA1yL0HQa06rbo+u7fh
         9YxRcwhFuRPF7FYecYbaezxh/354L/ZV9pt+yN540D+UMyI4rkK4E1wmc1/+GFwRkBuJ
         Qd6B0uFctWOTXptH710qw9SFD+ar8R7QxTRtG97oArqDC7NpAuFa2u4DDNZ0NWti8PXC
         4VpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7tXQbrZIKNbjiP4HQpLS/MmV9kCk4Yn2T4R3XJF3/z5FD2/HGLLI/ouf9PW2Jo43J4Ab1PWJhFwnMpWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LbmA/DuKI2SNfZWOPkvH2cUE+rcD7AR5XLJUMRh7RSNhgrEM
	ehzLO2zs8wi23AaTH+i+I3iDCczMzSxSGHn9SaccClbVOgiRVHTclEMxVXDmcfk0T6s=
X-Gm-Gg: ASbGnctW8yRxpQgXsfIggWE1gJSwI4ud2t/G20g0i1DUc6tl7F5jBq2ireE0t8bo2LQ
	uUrvT8u7rsG3XpUtThdjmr88QRqlnVj6NQt2ubOOYbINGg3VqFsi6ZAaaqMeWHGiVT2J/b4+gQ9
	N57mlFQZ7odG5SraqkQ9A+/jweksHMY9Vpg6OYcy8bMLmfh1brVFuPtTV4xuYlBEaVUpUumHJsp
	GUrzPxoRaZRHKcYjKSb/6cuQY038FAySj0uPCV2Y41w+ZT83cBZioUYAS5gpfAZQxJ2wUcSzcqU
	TwxdGfgCcAldtyPLJbaRMpcbx07xtl9JASH/Eh1V1XjsNGcMdMHbm4TCqr0gyFrVNEP5A9Sepn9
	EaGojBvYBNBgVq/T7tq3m7Bt23oLLHmvm+wsYcBc2GX1vd/zjYKmMP1hnJX8yVq+RZcfvquHcL+
	ki2XLR6XQ1e9kqg5FVw/Z7mHQ=
X-Google-Smtp-Source: AGHT+IF2/bU+eSqXeVfXjfHWK1jKW4KR7t0Or1eO+izL08nGbvipHvjs8ExWqQyzio3nvcGrkZAjVw==
X-Received: by 2002:a05:6602:b8e:b0:886:e168:e087 with SMTP id ca18e2360f4ac-948e0d9843cmr63168639f.13.1763059958939;
        Thu, 13 Nov 2025 10:52:38 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2b75865sm93549939f.5.2025.11.13.10.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:52:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------DzRij7SNZ0lc7eB07u15O7aG"
Message-ID: <e7557516-343b-4dcf-920c-c0d46cde822b@linuxfoundation.org>
Date: Thu, 13 Nov 2025 11:52:37 -0700
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
 Steven Rostedt <rostedt@goodmis.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest fixes update for Linux 6.18-rc6

This is a multi-part message in MIME format.
--------------DzRij7SNZ0lc7eB07u15O7aG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest fixes update for Linux 6.18-rc6

Fixes event-filter-function.tc tracing test failure caused when a first
run to sample events triggers kmem_cache_free which interferes with the
rest of the test. Fix this calling sample_events twice to eliminate the
kmem_cache_free related noise from the sampling.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 920aa3a7705a061cb3004572d8b7932b54463dbf:

   selftests: cachestat: Fix warning on declaration under label (2025-10-22 09:23:18 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.18-rc6

for you to fetch changes up to dd4adb986a86727ed8f56c48b6d0695f1e211e65:

   selftests/tracing: Run sample events to clear page cache events (2025-11-10 18:00:07 -0700)

----------------------------------------------------------------
linux_kselftest-fixes-6.18-rc6

Fixes event-filter-function.tc tracing test failure caused when a first
run to sample events triggers kmem_cache_free which interferes with the
rest of the test. Fix this calling sample_events twice to eliminate the
kmem_cache_free related noise from the sampling.

----------------------------------------------------------------
Steven Rostedt (1):
       selftests/tracing: Run sample events to clear page cache events

  tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc | 4 ++++
  1 file changed, 4 insertions(+)
----------------------------------------------------------------
--------------DzRij7SNZ0lc7eB07u15O7aG
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.18-rc6.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.18-rc6.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmls
dGVyL2V2ZW50LWZpbHRlci1mdW5jdGlvbi50YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5jdGlvbi50YwppbmRleCBj
NjIxNjVmYWJkMGMuLmNmYTE2YWExZjM5YSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9maWx0ZXIvZXZlbnQtZmlsdGVyLWZ1bmN0aW9uLnRj
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2
ZW50LWZpbHRlci1mdW5jdGlvbi50YwpAQCAtMjAsNiArMjAsMTAgQEAgc2FtcGxlX2V2ZW50
cygpIHsKIGVjaG8gMCA+IHRyYWNpbmdfb24KIGVjaG8gMCA+IGV2ZW50cy9lbmFibGUKIAor
IyBDbGVhciBmdW5jdGlvbnMgY2F1c2VkIGJ5IHBhZ2UgY2FjaGU7IHJ1biBzYW1wbGVfZXZl
bnRzIHR3aWNlCitzYW1wbGVfZXZlbnRzCitzYW1wbGVfZXZlbnRzCisKIGVjaG8gIkdldCB0
aGUgbW9zdCBmcmVxdWVudGx5IGNhbGxpbmcgZnVuY3Rpb24iCiBlY2hvID4gdHJhY2UKIHNh
bXBsZV9ldmVudHMK

--------------DzRij7SNZ0lc7eB07u15O7aG--

