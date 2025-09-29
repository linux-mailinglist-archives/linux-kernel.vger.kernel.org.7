Return-Path: <linux-kernel+bounces-836853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E1BAABB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA23189D78E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A28261B67;
	Mon, 29 Sep 2025 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W2BJXyl1"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEE157487
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759187226; cv=none; b=L/zPVxrnD18wgCF2UQ9Ta+2wRYEde61DapZp4pAFh4QXKNIFhGcTIU+WRMeOxRD+V1jGohpZrc08cauqVk6HEdfLyv+3O1kKjOpemjkUfIFwxaBVCZnVkaGyXKHvxSDmLhDQtinvniOK/Wls67YlqVYV4wS+Eqr4xDuCrVrjktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759187226; c=relaxed/simple;
	bh=wu1KGNRdhDdGs6m9Gl8AjcK1q1hiLghDaK4RTYdc98o=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=CH6+AX3d53pRVYZLP5naHI0oKxCDujo9Y0WwmpIqoYtDlvD0jyKSD2Wz/RsVfuxYRzHC1qJp559zxOYrucPiPAjnzR/sRbIaTK5FdkG8vhXa9GXoqHOhHeWEQMofg72u/gwGKloBNMBMRTgSJ1PqEnpqX1cQ7lmkYXGOdkAOhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W2BJXyl1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-912d4135379so128220239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759187223; x=1759792023; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EobsfKa3SA6txkS49PTKfAB53aP3dI7KTTjFoiIFxO0=;
        b=W2BJXyl1te4MbLOm5gjihqEcuUTJlayBI7P/EKe+akDs+sBjzETgflxLRQSgLFkleX
         dm4rCj5PglEWRhJhWbXMJ+KdJtzpC5rPtKMShJJed94plnzz3yL63k0axd5NdwjoCkMy
         F08fHWqAr+dDddCtw/OJKAbWGvDFSTCTN4CRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759187223; x=1759792023;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EobsfKa3SA6txkS49PTKfAB53aP3dI7KTTjFoiIFxO0=;
        b=GjNf/9vPlr1YgoAN3aHl+lBLaJnbqi4bO/xLMgYtIWj4JpQ22rNaONGl/mRruB5znr
         LEcifcwFxDu4T7ClY1N3QvKOgYVq9XCWmgOZWj7sDxC0t5Nx5xOLRG+ncVUMfmjijnS0
         3XDejwoq0GY4ebkOXUFMma7EawsezPj27Y5HNSpaiS0hLvepVTTzov9iGVxJyKClylp4
         Bn8FGhrnbUaxdAYyiAaJRjEuyMrojVWvYUw6iBLSFaVwY0z/K+RMWbrqZHBWsE44yQhw
         u2hc5kttrIxA8BLLdAW1p7Gs/y5crFdHk7mvpLkZN5dWzeNbSQTPROYjFtxu652iimHi
         K3rA==
X-Forwarded-Encrypted: i=1; AJvYcCWpgCr+KGaF4ufRXZU8cyuzpDh8xPvQaPHiq0PNt4JCCnmEFGWmYeR+dLPm5K0lu0Llcefx5ZHZHDqN5Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeI0rz3OMfCCZDWO/G4yCo03zSiyeqNQB0kFHvzOfzxHcY4WIU
	qnSXvTQ9GW1jJSt+QQvygFUwvXBVs7+U3547zc+Ta2VXDkmcPrv1EIE8Pgn3q4YxhfE=
X-Gm-Gg: ASbGncuadQrNMhQQq95K5a6wOaS6I0+faenIaJYMBUFZkPSVvQroaMHSBuvUsphTrdM
	K2qQs15Yh9YEYq7TkVynTYtx87o8cbGB35WonlOl15Xu5QsXsKij0ryO8t/bK1zYNnyj44YXZYK
	21qOrVmBaulwNLffUsAfOlYUZSlLeH0Z3jinhHTKA/RsivS/T81zn/l+l/+jOwAnc3cNuGbX5PP
	pcW1f8HFESt47uaMACI+yobXsJXkqEHBeSHSqpV/alzjMZL3L/xT40wENa+tpZxTaapCsM4W3e2
	ystXS2HOHmxed3hS28MPW5x8GrNnr1Hpc6qog1dr8V2EHXfL7Fol4aXPhrjeJxia5wft93hWD6I
	Q7GqMuAaV/3EXW4J6CpjWFRfa/XLpvS6hJWY=
X-Google-Smtp-Source: AGHT+IHGvB0j1rjfY73BYvENasOHft9kBzoipyIKAahb14XwGGbhijFDZkJjT8CiU10UPddevI1oMQ==
X-Received: by 2002:a05:6e02:2308:b0:42a:e972:456a with SMTP id e9e14a558f8ab-42ae9724931mr92878885ab.20.1759187223517;
        Mon, 29 Sep 2025 16:07:03 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5ae6bcsm5056183173.69.2025.09.29.16.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 16:07:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------sz2Yw1spEIUtwL3hncukFBaD"
Message-ID: <faf206d8-ccd8-48b5-8e7e-d596ddbbcbb6@linuxfoundation.org>
Date: Mon, 29 Sep 2025 17:07:02 -0600
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
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest next update for Linux 6.18-rc1

This is a multi-part message in MIME format.
--------------sz2Yw1spEIUtwL3hncukFBaD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull this kselftest next update for Linux 6.18-rc1.

- Fixes watchdog test to exit when device doesn't support keep alive
- Fix missing header build complaints during out of tree build
- A few minor fixes to git ignore
- MAINTAINERS file change to update dma_map_benchmark

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

   Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.18-rc1

for you to fetch changes up to 19692013415486febf71343f5cc539a343a2994b:

   MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers (2025-09-28 14:41:34 -0600)

----------------------------------------------------------------
linux_kselftest-next-6.18-rc1

- Fixes watchdog test to exit when device doesn't support keep alive
- Fix missing header build complaints during out of tree build
- A few minor fixes to git ignore
- MAINTAINERS file change to update dma_map_benchmark

----------------------------------------------------------------
Akhilesh Patil (1):
       selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING not supported

Dylan Yudaken (1):
       selftests/kexec: Ignore selftest binary

Qinxin Xia (1):
       MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers

Thomas Weißschuh (1):
       selftests: always install UAPI headers to the correct directory

Yi Lai (1):
       selftests/kselftest_harness: Add harness-selftest.expected to TEST_FILES

  MAINTAINERS                                        | 5 +++--
  tools/testing/selftests/kexec/.gitignore           | 2 ++
  tools/testing/selftests/kselftest_harness/Makefile | 1 +
  tools/testing/selftests/lib.mk                     | 5 ++++-
  tools/testing/selftests/watchdog/watchdog-test.c   | 6 ++++++
  5 files changed, 16 insertions(+), 3 deletions(-)
  create mode 100644 tools/testing/selftests/kexec/.gitignore
----------------------------------------------------------------

--------------sz2Yw1spEIUtwL3hncukFBaD
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.18-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.18-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggZjYyMDY5NjNl
ZmJmLi5kZWRjNjgxZjI2MzIgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5U
QUlORVJTCkBAIC03MjE4LDEwICs3MjE4LDExIEBAIEY6CWluY2x1ZGUvbGludXgvZG1hZW5n
aW5lLmgKIEY6CWluY2x1ZGUvbGludXgvb2ZfZG1hLmgKIAogRE1BIE1BUFBJTkcgQkVOQ0hN
QVJLCi1NOglYaWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgorTToJQmFy
cnkgU29uZyA8YmFvaHVhQGtlcm5lbC5vcmc+CitNOglRaW54aW4gWGlhIDx4aWFxaW54aW5A
aHVhd2VpLmNvbT4KIEw6CWlvbW11QGxpc3RzLmxpbnV4LmRldgogRjoJa2VybmVsL2RtYS9t
YXBfYmVuY2htYXJrLmMKLUY6CXRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYS8KK0Y6CXRv
b2xzL2RtYS8KIAogRE1BIE1BUFBJTkcgSEVMUEVSUwogTToJTWFyZWsgU3p5cHJvd3NraSA8
bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMva2V4ZWMvLmdpdGlnbm9yZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tl
eGVjLy5naXRpZ25vcmUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAw
Li41ZjNkOWUwODlhZTgKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9rZXhlYy8uZ2l0aWdub3JlCkBAIC0wLDAgKzEsMiBAQAorIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cit0ZXN0X2tleGVjX2p1bXAKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJuZXNzL01ha2VmaWxlIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0X2hhcm5lc3MvTWFrZWZpbGUKaW5k
ZXggMDYxNzUzNWE2Y2U0Li5kMjM2OWMwMTcwMWEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJuZXNzL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJuZXNzL01ha2VmaWxlCkBAIC0yLDYgKzIs
NyBAQAogCiBURVNUX0dFTl9QUk9HU19FWFRFTkRFRCA6PSBoYXJuZXNzLXNlbGZ0ZXN0CiBU
RVNUX1BST0dTIDo9IGhhcm5lc3Mtc2VsZnRlc3Quc2gKK1RFU1RfRklMRVMgOj0gaGFybmVz
cy1zZWxmdGVzdC5leHBlY3RlZAogRVhUUkFfQ0xFQU4gOj0gaGFybmVzcy1zZWxmdGVzdC5z
ZWVuCiAKIGluY2x1ZGUgLi4vbGliLm1rCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9saWIubWsgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saWIubWsKaW5kZXgg
NTMwMzkwMDMzOTI5Li5hNDQ4ZmFlNTc4MzEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xpYi5taworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saWIubWsK
QEAgLTIyOCw3ICsyMjgsMTAgQEAgJChPVVRQVVQpLyU6JS5TCiAJJChMSU5LLlMpICReICQo
TERMSUJTKSAtbyAkQAogZW5kaWYKIAorIyBFeHRyYWN0IHRoZSBleHBlY3RlZCBoZWFkZXIg
ZGlyZWN0b3J5CitraGRyX291dHB1dCA6PSAkKHBhdHN1YnN0ICUvdXNyL2luY2x1ZGUsJSwk
KGZpbHRlciAlL3Vzci9pbmNsdWRlLCQoS0hEUl9JTkNMVURFUykpKQorCiBoZWFkZXJzOgot
CSQoUSkkKE1BS0UpIC1DICQodG9wX3NyY2RpcikgaGVhZGVycworCSQoUSkkKE1BS0UpIC1m
ICQodG9wX3NyY2RpcikvTWFrZWZpbGUgLUMgJChraGRyX291dHB1dCkgaGVhZGVycwogCiAu
UEhPTlk6IHJ1bl90ZXN0cyBhbGwgY2xlYW4gaW5zdGFsbCBlbWl0X3Rlc3RzIGdlbl9tb2Rz
X2RpciBjbGVhbl9tb2RzX2RpciBoZWFkZXJzCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy93YXRjaGRvZy93YXRjaGRvZy10ZXN0LmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy93YXRjaGRvZy93YXRjaGRvZy10ZXN0LmMKaW5kZXggYTFmNTA2YmE1NTc4Li40
ZjA5YzVkYjBjN2YgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3dhdGNo
ZG9nL3dhdGNoZG9nLXRlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy93YXRj
aGRvZy93YXRjaGRvZy10ZXN0LmMKQEAgLTMzMiw2ICszMzIsMTIgQEAgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlpZiAob25lc2hvdCkKIAkJZ290byBlbmQ7CiAKKwkv
KiBDaGVjayBpZiBXRElPRl9LRUVQQUxJVkVQSU5HIGlzIHN1cHBvcnRlZCAqLworCWlmICgh
KGluZm8ub3B0aW9ucyAmIFdESU9GX0tFRVBBTElWRVBJTkcpKSB7CisJCXByaW50ZigiV0RJ
T0NfS0VFUEFMSVZFIG5vdCBzdXBwb3J0ZWQgYnkgdGhpcyBkZXZpY2VcbiIpOworCQlnb3Rv
IGVuZDsKKwl9CisKIAlwcmludGYoIldhdGNoZG9nIFRpY2tpbmcgQXdheSFcbiIpOwogCiAJ
LyoK

--------------sz2Yw1spEIUtwL3hncukFBaD--

