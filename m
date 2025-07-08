Return-Path: <linux-kernel+bounces-722280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815DAFD73C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302483B7774
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FBD224249;
	Tue,  8 Jul 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JeSfSNiE"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD421FF5F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003633; cv=none; b=qfC1VsBIkkpfhCVhHcmWNOC0ozOWaUKXg2aQzuQyBSqRZfwE8Y5OHzZ65rIkp87Fhb1wmNKGsFHSeMDf5q8YYKjnt33SGHlT5iVAysJry/d/ApotHpFkGna9pD7TmVXaw0qHzxaR+koDPVjhhYfiIutd3FIN+bl0MK0fPPT7x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003633; c=relaxed/simple;
	bh=dB0CumTGWtJGkpBYar++Rj0PACqzVwrkyMsciBSXkLs=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=DOxxv16nu4QE/hu4G9O4AP09hmyHYP6SlK3Ze1kDTiRFxsdIfavGH7+/FK3ThwpybfqMLFIrkHTc4YpAGHuPTCY8O0109qXyQJdQXfRUF+jPm/TvKFret/GyDYVw/GUqFS+PpohcYwiwO+Z2O5NdVFBvqztE2jhEty9y9ulKMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JeSfSNiE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86cdb330b48so441499239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752003629; x=1752608429; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2aT+wselAJy48WsFwg2kxwprmngL6RERUExxyAIax9A=;
        b=JeSfSNiEtiSTXn1CTW+T9kCCDlwbkt5n43TnecMMWKqvmHw3+B9xzI4pCDhVshizST
         lab7e7iDD2rP+BI09Ue0JVrAh/oN//3WoPshLOUT8ZyH4vWiLkpmI8b8ZtwfdttsxxKx
         uT9g0AUFRWjJzFZz2hwESV0w/EEcUDitb4Hnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003629; x=1752608429;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aT+wselAJy48WsFwg2kxwprmngL6RERUExxyAIax9A=;
        b=L/8XEpyAcNa8T6VlVkIJCAKFvtw9Ao/ypWaY/OVBzCbCRSYhXpZPbCcKbYT9Dp7yCg
         HVXLYit3J2jZxtv/owsnIrEgGuIqQr0jHu6kuKK3EvU8KNHGYRyLVRsVWqd5fOp9b2sf
         wqkSPFtdSEjQSDytQR85oSnfi9SLm0SmCNaeOob+NJXTuICVoRQ8kbdiE7KNBbMTG+lL
         DKCMlYHF7Zp8owd0F2+sKmFi/IkKqv7LsC24CyWEncJXkzooHTjLMBbhI0k/5VmG4n8b
         GoLAbrpVdicl/so8ghobuv8GvT0QY/kkCnmo481BIXCA0OB8X8tYOgM0dw8JFjnNIhMV
         4LmA==
X-Forwarded-Encrypted: i=1; AJvYcCWc0pCDpiC8YGpDZFWbPs6WZqzy4eNGQUb4br5gti3q2P93M/7GJBk16DCK9DswSk5JTD6g2tVrnqiuVWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGrKHtp2eX7DVXKx22UlEPkDsveziAv28fnCPFCKdHMDe4zV1
	k4PEMPnXfs2q2JX6tnMgHyaU8uxLBxh8r9o6kr4G2bKtTfSXI/ZwgEmxrDPANOhRZNNNepXdz3m
	aigkE
X-Gm-Gg: ASbGncukFpL+tkDcrIlspYw8o5TxDz7g0atnAGuT2Jqx0nYmVXOLKsnKhDv7AqYJ0Jw
	XtWwA4vbManZ5kiqCpV0F7FiUPLASdahoO8lSPX7VdMlj6i/1v6KgeQJMInDNM6cuAdlKu0Fv9+
	45cSKibQf7pj1Q+hU+CO414YqZmZ8TxCXFe9qBljSTc+jkAjjK2rXAYPbzD9vQARdmbCm/CBdwy
	9DGypG0QmvogLUqnhER4/F6ybmyqI6pWkWxlDLjdRb/2tDptYy1X4N5eDvnwtD6TeTg062lACUj
	Wjdkff4LQON4VTm7LemZlc6QrmG1EWhEKQmFSTKWhwq5Ii6EEYgjwU9DWVjH1yaaATy9LHRsqw=
	=
X-Google-Smtp-Source: AGHT+IEjj39711rTkfOAsDLT8KEkdMOlxGB1B1vXgPqa+jmbk6jS6kTHoRYbAn3Ymb/KtmaWNOLnww==
X-Received: by 2002:a05:6602:2d96:b0:86a:256e:12df with SMTP id ca18e2360f4ac-8794b432c1cmr551069039f.2.1752003629195;
        Tue, 08 Jul 2025 12:40:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5c8f7f2sm2338426173.145.2025.07.08.12.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 12:40:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1GPtmu3oopRfGuZOvTz2t2bY"
Message-ID: <ebbb6534-5968-4530-b9c8-0f6b21a96992@linuxfoundation.org>
Date: Tue, 8 Jul 2025 13:40:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.17-rc1

This is a multi-part message in MIME format.
--------------1GPtmu3oopRfGuZOvTz2t2bY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.17-rc1.

Fixes
  - snapshot-order of tsc ,mperf, clock in mperf_stop()
  - printing of CORE, CPU fields in cpupower-monitor

Improves Python binding's Makefile

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e044b8a9545cd8265c7110c179aeec2624c16455:

   cpupower: split unitdir from libdir in Makefile (2025-06-09 10:17:46 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.17-rc1-fixed

for you to fetch changes up to b74710eaff314d6afe4fb0bbe9bc7657bf226fd4:

   cpupower: Improve Python binding's Makefile (2025-07-01 10:58:00 -0600)

----------------------------------------------------------------
linux-cpupower-6.17-rc1-fixed

Fixes
  - snapshot-order of tsc,mperf, clock in mperf_stop()
  - printing of CORE, CPU fields in cpupower-monitor

Improves Python binding's Makefile

----------------------------------------------------------------
Gautham R. Shenoy (2):
       pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()
       pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor

John B. Wyatt IV (1):
       cpupower: Improve Python binding's Makefile

  tools/power/cpupower/bindings/python/Makefile              | 12 +++++++-----
  tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c |  4 ----
  tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    |  4 ++--
  3 files changed, 9 insertions(+), 11 deletions(-)
----------------------------------------------------------------
--------------1GPtmu3oopRfGuZOvTz2t2bY
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.17-rc1-fixed.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.17-rc1-fixed.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtl
ZmlsZSBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZQpp
bmRleCA4MWRiMzlhMDNlZmIuLjQ1MjdjZDczMmI0MiAxMDA2NDQKLS0tIGEvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Bvd2Vy
L2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZQpAQCAtNCwyMCArNCwyMiBAQAog
IyBUaGlzIE1ha2VmaWxlIGV4cGVjdHMgeW91IGhhdmUgYWxyZWFkeSBydW4gYG1ha2UgaW5z
dGFsbC1saWJgIGluIHRoZSBsaWIKICMgZGlyZWN0b3J5IGZvciB0aGUgYmluZGluZ3MgdG8g
YmUgY3JlYXRlZC4KIAotQ0MgOj0gZ2NjCitDQyA/PSBnY2MKKyMgQ0ZMQUdTID89CitMREZM
QUdTID89IC1sY3B1cG93ZXIKIEhBVkVfU1dJRyA6PSAkKHNoZWxsIGlmIHdoaWNoIHN3aWcg
Pi9kZXYvbnVsbCAyPiYxOyB0aGVuIGVjaG8gMTsgZWxzZSBlY2hvIDA7IGZpKQogSEFWRV9Q
WUNPTkZJRyA6PSAkKHNoZWxsIGlmIHdoaWNoIHB5dGhvbi1jb25maWcgPi9kZXYvbnVsbCAy
PiYxOyB0aGVuIGVjaG8gMTsgZWxzZSBlY2hvIDA7IGZpKQogCi1QWV9JTkNMVURFID0gJChm
aXJzdHdvcmQgJChzaGVsbCBweXRob24tY29uZmlnIC0taW5jbHVkZXMpKQotSU5TVEFMTF9E
SVIgPSAkKHNoZWxsIHB5dGhvbjMgLWMgImltcG9ydCBzaXRlOyBwcmludChzaXRlLmdldHNp
dGVwYWNrYWdlcygpWzBdKSIpCitQWV9JTkNMVURFID89ICQoZmlyc3R3b3JkICQoc2hlbGwg
cHl0aG9uLWNvbmZpZyAtLWluY2x1ZGVzKSkKK0lOU1RBTExfRElSID89ICQoc2hlbGwgcHl0
aG9uMyAtYyAiaW1wb3J0IHNpdGU7IHByaW50KHNpdGUuZ2V0c2l0ZXBhY2thZ2VzKClbMF0p
IikKIAogYWxsOiBfcmF3X3B5bGliY3B1cG93ZXIuc28KIAogX3Jhd19weWxpYmNwdXBvd2Vy
LnNvOiByYXdfcHlsaWJjcHVwb3dlcl93cmFwLm8KLQkkKENDKSAtc2hhcmVkIC1sY3B1cG93
ZXIgcmF3X3B5bGliY3B1cG93ZXJfd3JhcC5vIC1vIF9yYXdfcHlsaWJjcHVwb3dlci5zbwor
CSQoQ0MpIC1zaGFyZWQgJChMREZMQUdTKSByYXdfcHlsaWJjcHVwb3dlcl93cmFwLm8gLW8g
X3Jhd19weWxpYmNwdXBvd2VyLnNvCiAKIHJhd19weWxpYmNwdXBvd2VyX3dyYXAubzogcmF3
X3B5bGliY3B1cG93ZXJfd3JhcC5jCi0JJChDQykgLWZQSUMgLWMgcmF3X3B5bGliY3B1cG93
ZXJfd3JhcC5jICQoUFlfSU5DTFVERSkKKwkkKENDKSAkKENGTEFHUykgJChQWV9JTkNMVURF
KSAtZlBJQyAtYyByYXdfcHlsaWJjcHVwb3dlcl93cmFwLmMKIAogcmF3X3B5bGliY3B1cG93
ZXJfd3JhcC5jOiByYXdfcHlsaWJjcHVwb3dlci5zd2cKIGlmZXEgKCQoSEFWRV9TV0lHKSww
KQpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaWRsZV9tb25pdG9y
L2NwdXBvd2VyLW1vbml0b3IuYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVf
bW9uaXRvci9jcHVwb3dlci1tb25pdG9yLmMKaW5kZXggYWQ0OTMxNTdmODI2Li5lOGIzODQx
ZDVjMGYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9u
aXRvci9jcHVwb3dlci1tb25pdG9yLmMKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRp
bHMvaWRsZV9tb25pdG9yL2NwdXBvd2VyLW1vbml0b3IuYwpAQCAtMTIxLDEwICsxMjEsOCBA
QCB2b2lkIHByaW50X2hlYWRlcihpbnQgdG9wb2xvZ3lfZGVwdGgpCiAJc3dpdGNoICh0b3Bv
bG9neV9kZXB0aCkgewogCWNhc2UgVE9QT0xPR1lfREVQVEhfUEtHOgogCQlwcmludGYoIiBQ
S0d8Iik7Ci0JCWJyZWFrOwogCWNhc2UgVE9QT0xPR1lfREVQVEhfQ09SRToKIAkJcHJpbnRm
KCJDT1JFfCIpOwotCQlicmVhazsKIAljYXNlCVRPUE9MT0dZX0RFUFRIX0NQVToKIAkJcHJp
bnRmKCIgQ1BVfCIpOwogCQlicmVhazsKQEAgLTE2NywxMCArMTY1LDggQEAgdm9pZCBwcmlu
dF9yZXN1bHRzKGludCB0b3BvbG9neV9kZXB0aCwgaW50IGNwdSkKIAlzd2l0Y2ggKHRvcG9s
b2d5X2RlcHRoKSB7CiAJY2FzZSBUT1BPTE9HWV9ERVBUSF9QS0c6CiAJCXByaW50ZigiJTRk
fCIsIGNwdV90b3AuY29yZV9pbmZvW2NwdV0ucGtnKTsKLQkJYnJlYWs7CiAJY2FzZSBUT1BP
TE9HWV9ERVBUSF9DT1JFOgogCQlwcmludGYoIiU0ZHwiLCBjcHVfdG9wLmNvcmVfaW5mb1tj
cHVdLmNvcmUpOwotCQlicmVhazsKIAljYXNlIFRPUE9MT0dZX0RFUFRIX0NQVToKIAkJcHJp
bnRmKCIlNGR8IiwgY3B1X3RvcC5jb3JlX2luZm9bY3B1XS5jcHUpOwogCQlicmVhazsKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9tcGVy
Zl9tb25pdG9yLmMgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9pZGxlX21vbml0b3Iv
bXBlcmZfbW9uaXRvci5jCmluZGV4IDczYjZiMTBjYmRkMi4uNWFlMDJjM2Q1YjY0IDEwMDY0
NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9pZGxlX21vbml0b3IvbXBlcmZf
bW9uaXRvci5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRv
ci9tcGVyZl9tb25pdG9yLmMKQEAgLTI0MCw5ICsyNDAsOSBAQCBzdGF0aWMgaW50IG1wZXJm
X3N0b3Aodm9pZCkKIAlpbnQgY3B1OwogCiAJZm9yIChjcHUgPSAwOyBjcHUgPCBjcHVfY291
bnQ7IGNwdSsrKSB7Ci0JCW1wZXJmX21lYXN1cmVfc3RhdHMoY3B1KTsKLQkJbXBlcmZfZ2V0
X3RzYygmdHNjX2F0X21lYXN1cmVfZW5kW2NwdV0pOwogCQljbG9ja19nZXR0aW1lKENMT0NL
X1JFQUxUSU1FLCAmdGltZV9lbmRbY3B1XSk7CisJCW1wZXJmX2dldF90c2MoJnRzY19hdF9t
ZWFzdXJlX2VuZFtjcHVdKTsKKwkJbXBlcmZfbWVhc3VyZV9zdGF0cyhjcHUpOwogCX0KIAog
CXJldHVybiAwOwo=

--------------1GPtmu3oopRfGuZOvTz2t2bY--

