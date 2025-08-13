Return-Path: <linux-kernel+bounces-767341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CCB25310
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793E35C0179
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8432C0F60;
	Wed, 13 Aug 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FNe50wlv"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE21F3B9E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109851; cv=none; b=dh0jylNDv4DbjP5qGMezVa9UC6AHsXaCz6olNYlZ/RL5AJIP/yCuWaiy+HDO1pUdSG1Q1CBT9c2yAN6UPgwlVgsm6752zCGYHzkhIoaXUt5TXDK2gYxxg8srkFRqlKcZi616O6wJNgnF1+Kdpy3EQAzJuU6hhgs7dOA+F5mRga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109851; c=relaxed/simple;
	bh=XdL0TUshpwJwe2FBD2O+LQUaiSTV2621UzbsTI0+YMc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J8jCy7kAzH6SDN5BOLoMjBR9lHKlM/tF43XPYl1pX72HeHraAqpNFiQFYzQHYVrn9CrhPvpsJCb+FnWbD+Rn3yAINhx2ctWQL4j1Gwl2QpUNbt/CuIiMA1YvgmGjVU+u2O9mymOnepB5i65rJZKPvGZzsA5WPwyRfMVtqbLOjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FNe50wlv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4716fbc443so42219a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755109848; x=1755714648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XEz3LZlf7+t/zKok/pcoBegtCr+jM4yJUhGj1cRsPWc=;
        b=FNe50wlv/fM+OfnZDOK5h/+n3+910Bn42E/hjB6Xn9TGhy1FT0IKsSePWzgr+x5j39
         +8FT1F8n4ZUHasuIhK/bDUNyIbv9YwD9+tMujWovjg3ZMLkipWUkcdV6xpOrWrdH/mmD
         BBQ84r0mgUkEqaWMdUwQ+uJrB4e1cM9L/8ElaM3a9eoIV8vQ125ewi4eWKsokUYUnLEI
         seM8DK/Q63tI1S43ASee6x6CvumDOsHwo7VL/UM0jt3dY2jpj+AH3QaBnHI4Am0gTTyJ
         /lIL8vKNu28a1+zh5KU08hCwvLe/11TWdC0ImNtUDYHMMhvxELUZawqheBbcRfHUg7Sq
         wYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109848; x=1755714648;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEz3LZlf7+t/zKok/pcoBegtCr+jM4yJUhGj1cRsPWc=;
        b=Nvx6d/2spbkd9dmLz8uPDVtZgBqHX70T9RlxAJNEFk8RYW+SzwQV9glkQPhKMywlDG
         j5nq8h0t/bajEH5P9Wa0/Bn6Ue9eIVI7C4p//j8AoOU6zUGef9V622BoqHT1DIs+3N7v
         yuqDcF8GlsBf+Mjp7KEP7YnnChE5KA+8uK/JVTrzRnVzkfAZ6AIxUZSHBqZrdXICHoIn
         yzVUIgxy5rACGok6SVxcL1C2+D516mqheB3olw748gDDpnLlGKrBewu+Qttc3/5PNrF2
         NLumuLtC6MjxTtE2huf1fbZFI35dgZtAheduEcCx9LusyTc7tFgHOoZ2sh9NEymy7J59
         UWsQ==
X-Gm-Message-State: AOJu0Yy5fjfYTT//Z3kEMko0RXfRTFWV4A33Uv3q4h1pSuIFAxxLiDbn
	6meiKdQIet3f0Jd0NsGoZeAy9D/C2nDghUSsfhoycdFANj0AblQQNRWDijUIciYh1UKMrCWEjoe
	yL2nSsabzq0bdlVPLEy+owNnQUtCOO46obOARheS+W/YAhaZ9A5e9GbTCdQ==
X-Gm-Gg: ASbGnctz+rw4E6fkUXRpYiBnS3Uo8wmOxSctQsPAEhYYiNxdyz54Vv9g2dQfippbALs
	VtDNrakkwAtjghwDA0Q+PiuqcyfIFIIya0O3jD8XXcdBFxHDl5Z6yCXGkKm+r5NmG17XoxMnfEx
	TyWcTMWwqxQCC6fwTAYTAFrH2QWqxTarQg7JW1ljdIcoiZ3BsV49v5fXgbJDK7LbBlZ2XWzX545
	JNd/ogm
X-Google-Smtp-Source: AGHT+IEbksXz9sAgHGJs8z3bupWkEwJNetlsoSNrtUxz5xTaP1N0YmWXxFeGjZ3f11VocNBU1IjQOxs9J8UW1Sjhsxc=
X-Received: by 2002:a17:903:2a83:b0:23f:aec2:c880 with SMTP id
 d9443c01a7336-244584f5110mr1519715ad.19.1755109848197; Wed, 13 Aug 2025
 11:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Nanji Parmar (he/him)" <nparmar@purestorage.com>
Date: Wed, 13 Aug 2025 11:30:36 -0700
X-Gm-Features: Ac12FXz7isZJLMsaNtY-l85sBAl2LTPqfKGh6rGs-I4R6NPcL_vTeJMTamJIYgo
Message-ID: <CAEK+-Oe8GszRBDDF8jKAmVQNUEvgVqJYDp31P+mZTbqzneEZzA@mail.gmail.com>
Subject: [PATCH] hung_task: Skip hung task detection during core dump operations
To: akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000b73cd063c435bab"

--0000000000000b73cd063c435bab
Content-Type: multipart/alternative; boundary="0000000000000b73cb063c435ba9"

--0000000000000b73cb063c435ba9
Content-Type: text/plain; charset="UTF-8"

Hi,

This patch fixes false positive hung task warnings during core dump
operations for processes with large memory footprints.

During testing with processes having GBs or >1TB memory, core dump
generation
takes many minutes, causing hung task detector to incorrectly flag threads
as hung. The fix checks for both PF_DUMPCORE and PF_POSTCOREDUMP flags
before reporting tasks as hung.

Tested on the systems with large memory processes.

Best regards,
Nanji

---
From 45460c6882b602669b25a57f3a2f7ea8a8ea0f84 Mon Sep 17 00:00:00 2001
From: Nanji Parmar <nparmar@purestorage.com>
Date: Wed, 13 Aug 2025 12:14:35 -0600
Subject: [PATCH] hung_task: Exclude core dump tasks from hung task detection

Tasks involved in core dump operations can legitimately block for
extended periods, especially for large memory processes. The hung
task detector should skip tasks with PF_DUMPCORE (main dumping
thread) or PF_POSTCOREDUMP (other threads in the group) flags to
avoid false positive warnings.

This prevents incorrect hung task reports during legitimate core
dump generation that can take xx minutes for large processes.

Signed-off-by: Nanji Parmar <nparmar@purestorage.com>
---
 kernel/hung_task.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..0fc3352d0f0e 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -217,6 +217,13 @@ static void check_hung_task(struct task_struct *t,
unsigned long timeout)
         */
        sysctl_hung_task_detect_count++;

+       /* Skip hung task detection for tasks involved in core dump
operations */
+       if (t->flags & (PF_DUMPCORE | PF_POSTCOREDUMP)) {
+               pr_info("Skipping hung task check for coredump-related task
%s:%d (blocked %ld seconds)\n",
+                       t->comm, t->pid, (jiffies - t->last_switch_time) /
HZ);
+               return;
+       }
+
        trace_sched_process_hang(t);

        if (sysctl_hung_task_panic) {
--
2.50.1

--0000000000000b73cb063c435ba9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>This patch fixes false positive hung task warni=
ngs during core dump<br>operations for processes with large memory footprin=
ts.<br><br>During testing with processes having GBs or &gt;1TB memory, core=
 dump generation<br>takes many minutes, causing hung task detector to incor=
rectly flag threads<br>as hung. The fix checks for both PF_DUMPCORE and PF_=
POSTCOREDUMP flags<br>before reporting tasks as hung.<br><br>Tested on the =
systems with large memory processes.<br><br>Best regards,<br>Nanji<br><br>-=
--<div>From 45460c6882b602669b25a57f3a2f7ea8a8ea0f84 Mon Sep 17 00:00:00 20=
01<br>From: Nanji Parmar &lt;<a href=3D"mailto:nparmar@purestorage.com">npa=
rmar@purestorage.com</a>&gt;<br>Date: Wed, 13 Aug 2025 12:14:35 -0600<br>Su=
bject: [PATCH] hung_task: Exclude core dump tasks from hung task detection<=
br><br>Tasks involved in core dump operations can legitimately block for<br=
>extended periods, especially for large memory processes. The hung<br>task =
detector should skip tasks with PF_DUMPCORE (main dumping<br>thread) or PF_=
POSTCOREDUMP (other threads in the group) flags to<br>avoid false positive =
warnings.<br><br>This prevents incorrect hung task reports during legitimat=
e core<br>dump generation that can take xx minutes for large processes.<br>=
<br>Signed-off-by: Nanji Parmar &lt;<a href=3D"mailto:nparmar@purestorage.c=
om">nparmar@purestorage.com</a>&gt;<br>---<br>=C2=A0kernel/hung_task.c | 7 =
+++++++<br>=C2=A01 file changed, 7 insertions(+)<br><br>diff --git a/kernel=
/hung_task.c b/kernel/hung_task.c<br>index 8708a1205f82..0fc3352d0f0e 10064=
4<br>--- a/kernel/hung_task.c<br>+++ b/kernel/hung_task.c<br>@@ -217,6 +217=
,13 @@ static void check_hung_task(struct task_struct *t, unsigned long tim=
eout)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sysctl_hung_task_detect_count++;<br><br>+ =C2=A0 =C2=A0 =C2=A0 /* Skip =
hung task detection for tasks involved in core dump operations */<br>+ =C2=
=A0 =C2=A0 =C2=A0 if (t-&gt;flags &amp; (PF_DUMPCORE | PF_POSTCOREDUMP)) {<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info(&quot;Skippin=
g hung task check for coredump-related task %s:%d (blocked %ld seconds)\n&q=
uot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 t-&gt;comm, t-&gt;pid, (jiffies - t-&gt;last_switch_time) / H=
Z);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>+ =C2=
=A0 =C2=A0 =C2=A0 }<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_sched_process=
_hang(t);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sysctl_hung_task_panic) {<=
br>--<br>2.50.1<br></div></div>

--0000000000000b73cb063c435ba9--
--0000000000000b73cd063c435bab
Content-Type: application/octet-stream; name="hung_task_fix.patch"
Content-Disposition: attachment; filename="hung_task_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_meab185w0>
X-Attachment-Id: f_meab185w0

RnJvbSA0NTQ2MGM2ODgyYjYwMjY2OWIyNWE1N2YzYTJmN2VhOGE4ZWEwZjg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW5qaSBQYXJtYXIgPG5wYXJtYXJAcHVyZXN0b3JhZ2UuY29t
PgpEYXRlOiBXZWQsIDEzIEF1ZyAyMDI1IDEyOjE0OjM1IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0g
aHVuZ190YXNrOiBFeGNsdWRlIGNvcmUgZHVtcCB0YXNrcyBmcm9tIGh1bmcgdGFzayBkZXRlY3Rp
b24KClRhc2tzIGludm9sdmVkIGluIGNvcmUgZHVtcCBvcGVyYXRpb25zIGNhbiBsZWdpdGltYXRl
bHkgYmxvY2sgZm9yCmV4dGVuZGVkIHBlcmlvZHMsIGVzcGVjaWFsbHkgZm9yIGxhcmdlIG1lbW9y
eSBwcm9jZXNzZXMuIFRoZSBodW5nCnRhc2sgZGV0ZWN0b3Igc2hvdWxkIHNraXAgdGFza3Mgd2l0
aCBQRl9EVU1QQ09SRSAobWFpbiBkdW1waW5nCnRocmVhZCkgb3IgUEZfUE9TVENPUkVEVU1QIChv
dGhlciB0aHJlYWRzIGluIHRoZSBncm91cCkgZmxhZ3MgdG8KYXZvaWQgZmFsc2UgcG9zaXRpdmUg
d2FybmluZ3MuCgpUaGlzIHByZXZlbnRzIGluY29ycmVjdCBodW5nIHRhc2sgcmVwb3J0cyBkdXJp
bmcgbGVnaXRpbWF0ZSBjb3JlCmR1bXAgZ2VuZXJhdGlvbiB0aGF0IGNhbiB0YWtlIHh4IG1pbnV0
ZXMgZm9yIGxhcmdlIHByb2Nlc3Nlcy4KClNpZ25lZC1vZmYtYnk6IE5hbmppIFBhcm1hciA8bnBh
cm1hckBwdXJlc3RvcmFnZS5jb20+Ci0tLQoga2VybmVsL2h1bmdfdGFzay5jIHwgNyArKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEva2VybmVsL2h1
bmdfdGFzay5jIGIva2VybmVsL2h1bmdfdGFzay5jCmluZGV4IDg3MDhhMTIwNWY4Mi4uMGZjMzM1
MmQwZjBlIDEwMDY0NAotLS0gYS9rZXJuZWwvaHVuZ190YXNrLmMKKysrIGIva2VybmVsL2h1bmdf
dGFzay5jCkBAIC0yMTcsNiArMjE3LDEzIEBAIHN0YXRpYyB2b2lkIGNoZWNrX2h1bmdfdGFzayhz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnQsIHVuc2lnbmVkIGxvbmcgdGltZW91dCkKIAkgKi8KIAlzeXNj
dGxfaHVuZ190YXNrX2RldGVjdF9jb3VudCsrOwogCisJLyogU2tpcCBodW5nIHRhc2sgZGV0ZWN0
aW9uIGZvciB0YXNrcyBpbnZvbHZlZCBpbiBjb3JlIGR1bXAgb3BlcmF0aW9ucyAqLworCWlmICh0
LT5mbGFncyAmIChQRl9EVU1QQ09SRSB8IFBGX1BPU1RDT1JFRFVNUCkpIHsKKwkJcHJfaW5mbygi
U2tpcHBpbmcgaHVuZyB0YXNrIGNoZWNrIGZvciBjb3JlZHVtcC1yZWxhdGVkIHRhc2sgJXM6JWQg
KGJsb2NrZWQgJWxkIHNlY29uZHMpXG4iLAorCQkJdC0+Y29tbSwgdC0+cGlkLCAoamlmZmllcyAt
IHQtPmxhc3Rfc3dpdGNoX3RpbWUpIC8gSFopOworCQlyZXR1cm47CisJfQorCiAJdHJhY2Vfc2No
ZWRfcHJvY2Vzc19oYW5nKHQpOwogCiAJaWYgKHN5c2N0bF9odW5nX3Rhc2tfcGFuaWMpIHsKLS0g
CjIuNTAuMQoK
--0000000000000b73cd063c435bab--

