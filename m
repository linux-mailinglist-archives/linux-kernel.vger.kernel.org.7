Return-Path: <linux-kernel+bounces-759681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E9B1E10D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A3F18A0985
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F41C84A0;
	Fri,  8 Aug 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/8iqj1"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD81ACED7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625371; cv=none; b=cJw1BypAtr7iegEL6X8IDWNY/UZuFF6oU6mWTHh3xB1B7m30pOclCiKJOjwROsEVh+oDRVD9hUKhaBPnAxuwfmst78/4np6nHhB6fDw8uYWKN4FU8KAYdO2wDvGX4N8cesbhDYeis3q4Q0h6l5x4wjqIsk3Ai/j4c+eJPL0FS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625371; c=relaxed/simple;
	bh=LPT+6Ghs0Kau6M6zEtkEZojzaRwaCaZLzxSypX4IJDk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GaFoNhHxT1GgQg6FeQiSO+Q8ZUk3Zjfj0vk1iRFDwkYXfG1i81dA/TRMs2BjyqZhdFg/9L9tqtKCaQJh7NPrOXkc3rHL0BD6XTjhAfK5KJMo6KtKNBCbw19hW77q1FMtjixycAfKvDF7FQsMQLzJsEVtNIEFzYky7Rh07zpftUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ/8iqj1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71b49bbb95cso16620027b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 20:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754625369; x=1755230169; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPT+6Ghs0Kau6M6zEtkEZojzaRwaCaZLzxSypX4IJDk=;
        b=dJ/8iqj1DWIANkYB3FOrQNBt6OikoXAs6kiXxISEHU3f4U8+anTcnhdxpzpqNkzP3e
         ENCW1TEVVtzla70VSsrp7xqW13kwFaIYpa+LAMM+b5wJFClTr32wSPVhuB1z9Oz+Zw82
         cQfvUgEwCmFGrB+B57bRlf1kN2xxa9mOJwj8wZzV7+MgZuC3bt18WC5Ttj69MCsJtEED
         WxwGAaTCzxtOB6EFAh4OhQ56kd42vtteFqAl3OoGlpI2TybrR1I1RrK1zOV+oQCyF55a
         /wYsItqZDk4Ke98RhVjPPS55omgTO2bx4ui4nOyo1rwSWsTtODhtZtedEvVryJTMitxk
         bx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754625369; x=1755230169;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPT+6Ghs0Kau6M6zEtkEZojzaRwaCaZLzxSypX4IJDk=;
        b=MfS6gqynL1dZCMAUvYZ2rYuglSXFmMl9UagowaKET4EXBKFMnskwnngOzYFck5sCdd
         1t3TfgcFdiM4qJajhwoZfj0Jld72BXohs5GjYYYFrMCgRTHmECOfcHJOLSEPccfJijzo
         uzNwXRvEE92EiHuMLDYHN/e1MRshYXaibde6+Oh6I7uTPujZnC7IBYipuciFa6lI2o6Z
         zeOwMYw7kksiGdNGx/nm53hcpr1BJx/uf+JavItU/Zq+8N0qTI8z19G/QlwN6hcw2gHX
         RF3sUDbext1TXjkEWn/BPZBKmD1nkJD1ru2/cafPxz27kpIiq+P3poEjjpWUMBjMleDl
         I0iA==
X-Forwarded-Encrypted: i=1; AJvYcCUBguZX5Zejq/fXwmMxZO0O6Sh2g/EfzL4rp8B+oiOZcPanYUlNsFO6CCE0FCn/fuRKTaZtCaWgCdkPA3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hEMlOAcEJV0Lkxg5w6M/zOoj7bMv7BB04TZifomRiOa3K1wF
	d52/qVbS1QuE1kV69f+N/F7mAy/vcOzcPwniM+awfRv0m9pejzluL1PL3evq8q6uc1kw5tJF1EO
	nh4B14aCFReJ89H7AgAdLnXvcVkK/gxa21/dYpmQ=
X-Gm-Gg: ASbGncuSbEChoSjrEhGljtdHkVYpmrojyF1rjl1ZCmO+eQ4fX+Y3bpjehMbiYXySziG
	M1lTOewKXkjmx0bpW3rTFb/kmDF/K0omQmcUgDVQY9m/wBZESDLq7Rm/WbVdT1xXOHdyUVwgaxS
	54szh1U+X34vNHenvsTJPE9s8rEfb3wnD9CL6G05JzqU4hglJnIuXz8a5AvlfB+Dv2YpY4Ymv4u
	zBOR8yslGpjZ3yrevtB+jiX65SV52YRxfMIhm2x0NOl1GgNa9PL
X-Google-Smtp-Source: AGHT+IE/Dr59I8niuNpDCO0FHNO+ih8hV8KGwzAiD272wI/+srnEhK8+X70J410fhSWjSMHxFnPSFR+asyRR341U5Og=
X-Received: by 2002:a05:690c:690d:b0:712:d70b:45d5 with SMTP id
 00721157ae682-71bf0e5a9b8mr17734227b3.33.1754625368560; Thu, 07 Aug 2025
 20:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yes PANG <pangyes608@gmail.com>
Date: Fri, 8 Aug 2025 11:55:56 +0800
X-Gm-Features: Ac12FXzPFSMDrTWKxDFQuaManT6Oy7pFF7Db41MsVNl4GGpu4mrOY2SeRnS2frk
Message-ID: <CAJLDUOdBiYMarq1Ye4Yygzmgh1TKXYLyuYHL-24xJ9V2M+X4vA@mail.gmail.com>
Subject: kernel BUG in jfs_evict_inode
To: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, brauner@kernel.org, sandeen@redhat.com, 
	willy@infradead.org, dan.carpenter@linaro.org
Content-Type: multipart/mixed; boundary="000000000000cf2346063bd28dd2"

--000000000000cf2346063bd28dd2
Content-Type: multipart/alternative; boundary="000000000000cf2343063bd28dd0"

--000000000000cf2343063bd28dd0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux maintainers and reviewers:
We are reporting a Linux kernel bug titled **kernel BUG in
jfs_evict_inode**, discovered using a modified version of Syzkaller.
Following my previous bug report, here is a structured analysis from our
fault localization tool "CoHIKER". These may be helpful for your fixing and
patches.
**root cause analysis**
Core Fault:
Invalid inode state handling during JFS filesystem cleanup phase,
specifically in the inode eviction path (fs/jfs/inode.c).

Trigger Conditions:
Mounting JFS with specific vulnerable configuration:
Mount flags =3D 0x0
Filesystem parameter =3D 0x5e5b
Subsequent filesystem operations
Inode eviction during cleanup (unmount/process termination)

Failure Mechanism:
The combination of these mount parameters creates inconsistent inode states
that aren't properly handled during eviction, leading to a kernel BUG when
the system attempts to flush/clean up these inodes.

Evidence from Mutations:
Successful mutations all modified mount parameters:
Changing mount flags (0x0=E2=86=920x1)
Adjusting mount configuration (0x1=E2=86=920x0)
Modifying FS-specific parameter (0x5e5b=E2=86=920x5e5a)
Failed mutation (process creation flags) confirmed the bug is
filesystem-specific

Impact Scope:
Subsystem: JFS filesystem implementation
Component: Inode management subsystem
Phase: Cleanup operations (particularly inode eviction)

Root Cause Conclusion:
The bug manifests due to insufficient validation of inode state transitions
when JFS is mounted with specific non-default parameters, combined with
particular sequences of filesystem operations. The invalid state isn't
detected until cleanup phase, causing a fatal kernel error.
This appears to be a filesystem-specific logic error in state management
rather than a generic memory or concurrency issue.

**result of file and method level fault localization"
Top-10 of the buggy file:
1. fs/jfs/inode.c
2. fs/jfs/super.c
3. fs/jfs/jfs_incore.h
4. fs/jfs/jfs_dinode.h
5. fs/jfs/jfs_metapage.h
6. fs/jfs/file.c
7. fs/jfs/namei.c
8. fs/jfs/jfs_inode.h
9. fs/inode.c
10. fs/jfs/dir.c
Top-10 of the buggy method:
1. jfs_evict_inode
2. jfs_truncate_nolock
3. jfs_write_inode
4. jfs_commit_inode
5. jfs_iget
6. jfs_dirty_inode
7. jfs_truncate
8. jfs_releasepage
9. jfs_invalidatepage
10. evict_inodes
Attached:
complete output of fault localizaiton

--000000000000cf2343063bd28dd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Linux maintainers and reviewers:<br>We are reporting =
a Linux kernel bug titled **kernel BUG in jfs_evict_inode**, discovered usi=
ng a modified version of Syzkaller.<br>Following my previous bug report, he=
re is a structured analysis from our fault localization tool &quot;CoHIKER&=
quot;. These may be helpful for your fixing and patches.<br>**root cause an=
alysis**<br>Core Fault:<br>Invalid inode state handling during JFS filesyst=
em cleanup phase, specifically in the inode eviction path (fs/jfs/inode.c).=
<br><br>Trigger Conditions:<br>Mounting JFS with specific vulnerable config=
uration:<br>Mount flags =3D 0x0<br>Filesystem parameter =3D 0x5e5b<br>Subse=
quent filesystem operations<br>Inode eviction during cleanup (unmount/proce=
ss termination)<br><br>Failure Mechanism:<br>The combination of these mount=
 parameters creates inconsistent inode states that aren&#39;t properly hand=
led during eviction, leading to a kernel BUG when the system attempts to fl=
ush/clean up these inodes.<br><br>Evidence from Mutations:<br>Successful mu=
tations all modified mount parameters:<br>Changing mount flags (0x0=E2=86=
=920x1)<br>Adjusting mount configuration (0x1=E2=86=920x0)<br>Modifying FS-=
specific parameter (0x5e5b=E2=86=920x5e5a)<br>Failed mutation (process crea=
tion flags) confirmed the bug is filesystem-specific<br><br>Impact Scope:<b=
r>Subsystem: JFS filesystem implementation<br>Component: Inode management s=
ubsystem<br>Phase: Cleanup operations (particularly inode eviction)<br><br>=
Root Cause Conclusion:<br>The bug manifests due to insufficient validation =
of inode state transitions when JFS is mounted with specific non-default pa=
rameters, combined with particular sequences of filesystem operations. The =
invalid state isn&#39;t detected until cleanup phase, causing a fatal kerne=
l error.<br>This appears to be a filesystem-specific logic error in state m=
anagement rather than a generic memory or concurrency issue.<br><br>**resul=
t of file and method level fault localization&quot;<br>Top-10 of the buggy =
file:<br>1. fs/jfs/inode.c<br>2. fs/jfs/super.c<br>3. fs/jfs/jfs_incore.h<b=
r>4. fs/jfs/jfs_dinode.h<br>5. fs/jfs/jfs_metapage.h<br>6. fs/jfs/file.c<br=
>7. fs/jfs/namei.c<br>8. fs/jfs/jfs_inode.h<br>9. fs/inode.c<br>10. fs/jfs/=
dir.c<br>Top-10 of the buggy method:<br>1. jfs_evict_inode<br>2. jfs_trunca=
te_nolock<br>3. jfs_write_inode<br>4. jfs_commit_inode<br>5. jfs_iget<br>6.=
 jfs_dirty_inode<br>7. jfs_truncate<br>8. jfs_releasepage<br>9. jfs_invalid=
atepage<br>10. evict_inodes<br>Attached: <br>complete output of fault local=
izaiton</div>

--000000000000cf2343063bd28dd0--
--000000000000cf2346063bd28dd2
Content-Type: text/plain; charset="UTF-8"; name="complete_output.txt"
Content-Disposition: attachment; filename="complete_output.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_me2amqbv0>
X-Attachment-Id: f_me2amqbv0

RmlsZS1sZXZlbCBvdXRwdXTvvJoNCnsNCiAgInRob3VnaHRfcHJvY2VzcyI6IHsNCiAgICAic3Rl
cDEiOiB7DQogICAgICAiYnVnX2xvY2F0aW9uIjogImZzL2pmcy9pbm9kZS5jIGxpbmUgMTY5IGlu
IGpmc19ldmljdF9pbm9kZSgpIiwNCiAgICAgICJidWdfdHlwZSI6ICJLZXJuZWwgQlVHIChpbnZh
bGlkIG9wY29kZSkgc3VnZ2VzdGluZyBtZW1vcnkgY29ycnVwdGlvbiBvciBpbnZhbGlkIHN0YXRl
IGR1cmluZyBpbm9kZSBldmljdGlvbiIsDQogICAgICAibW9kdWxlIjogIkpGUyBmaWxlc3lzdGVt
IiwNCiAgICAgICJ0cmlnZ2VyX29wZXJhdGlvbiI6ICJJbm9kZSBldmljdGlvbiBkdXJpbmcgZmls
ZXN5c3RlbSBjbGVhbnVwIg0KICAgIH0sDQogICAgInN0ZXAyIjogew0KICAgICAgInRlc3RfcHJv
Z3JhbV9hbmFseXNpcyI6IHsNCiAgICAgICAgInN5c2NhbGxzIjogWw0KICAgICAgICAgICJzeXpf
bW91bnRfaW1hZ2UkamZzKCk6IE1vdW50cyBKRlMgZmlsZXN5c3RlbSIsDQogICAgICAgICAgInN5
el9jbG9uZSgpOiBDcmVhdGVzIHByb2Nlc3MgY29udGV4dCIsDQogICAgICAgICAgIm9wZW5hdCgp
OiBDcmVhdGVzIGZpbGUgd2l0aCBleHRyZW1lbHkgbG9uZyBwYXRobmFtZSINCiAgICAgICAgXSwN
CiAgICAgICAgInRlc3RfZm9jdXMiOiAiSkZTIGZpbGVzeXN0ZW0gYmVoYXZpb3IgdW5kZXIgY29u
Y3VycmVudCBhY2Nlc3Mgd2l0aCBwYXRob2xvZ2ljYWwgZmlsZW5hbWVzIg0KICAgICAgfQ0KICAg
IH0sDQogICAgInN0ZXAzIjogew0KICAgICAgInN1Y2Nlc3NmdWxfbXV0YXRpb25zIjogWw0KICAg
ICAgICB7DQogICAgICAgICAgImNoYW5nZSI6ICJNb3VudCBmbGFnIDB4MCDihpIgMHgxIiwNCiAg
ICAgICAgICAiYW5hbHlzaXMiOiAiTW91bnQgb3B0aW9ucyBhZmZlY3QgaW5vZGUgaGFuZGxpbmcg
ZHVyaW5nIGV2aWN0aW9uIg0KICAgICAgICB9LA0KICAgICAgICB7DQogICAgICAgICAgImNoYW5n
ZSI6ICJNb3VudCBwYXJhbWV0ZXIgMHgxIOKGkiAweDAiLA0KICAgICAgICAgICJhbmFseXNpcyI6
ICJTcGVjaWZpYyBtb3VudCBjb25maWd1cmF0aW9uIHByZXZlbnRzIGJ1ZyINCiAgICAgICAgfSwN
CiAgICAgICAgew0KICAgICAgICAgICJjaGFuZ2UiOiAiTW91bnQgcGFyYW1ldGVyIDB4NWU1YiDi
hpIgMHg1ZTVhIiwNCiAgICAgICAgICAiYW5hbHlzaXMiOiAiUHJlY2lzZSBmaWxlc3lzdGVtIHBh
cmFtZXRlcnMgY3JpdGljYWwgZm9yIGNvcnJlY3Qgb3BlcmF0aW9uIg0KICAgICAgICB9DQogICAg
ICBdLA0KICAgICAgImNvbmNsdXNpb24iOiAiQnVnIGlzIHNlbnNpdGl2ZSB0byBKRlMgbW91bnQg
Y29uZmlndXJhdGlvbiBhbmQgaW5vZGUgbWFuYWdlbWVudCINCiAgICB9LA0KICAgICJzdGVwNCI6
IHsNCiAgICAgICJmYWlsZWRfbXV0YXRpb24iOiB7DQogICAgICAgICJjaGFuZ2UiOiAiQ2xvbmUg
ZmxhZ3MgMHg0MDQwMDAg4oaSIDB4NDAwMDAwIiwNCiAgICAgICAgImFuYWx5c2lzIjogIlByb2Nl
c3MgY3JlYXRpb24gZmxhZ3MgaXJyZWxldmFudCB0byBidWcsIGNvbmZpcm1pbmcgZmlsZXN5c3Rl
bS1zcGVjaWZpYyBuYXR1cmUiDQogICAgICB9DQogICAgfSwNCiAgICAic3RlcDUiOiB7DQogICAg
ICAiZGVmZWN0X2NoYXJhY3RlcmlzdGljcyI6IFsNCiAgICAgICAgIkpGUy1zcGVjaWZpYyBpbm9k
ZSBoYW5kbGluZyBpc3N1ZSIsDQogICAgICAgICJUcmlnZ2VyZWQgZHVyaW5nIGV2aWN0aW9uIHBh
dGgiLA0KICAgICAgICAiU2Vuc2l0aXZlIHRvIG1vdW50IGNvbmZpZ3VyYXRpb24iLA0KICAgICAg
ICAiTm90IHByb2Nlc3MtY29udGV4dCBkZXBlbmRlbnQiLA0KICAgICAgICAiTGlrZWx5IHJlbGF0
ZWQgdG8gaW5vZGUgc3RhdGUgbWFuYWdlbWVudCINCiAgICAgIF0NCiAgICB9LA0KICAgICJzdGVw
NiI6IHsNCiAgICAgICJmaWxlX2NsYXNzaWZpY2F0aW9uIjogew0KICAgICAgICAiY29yZV9qZnMi
OiBbDQogICAgICAgICAgImZzL2pmcy9pbm9kZS5jIiwNCiAgICAgICAgICAiZnMvamZzL3N1cGVy
LmMiLA0KICAgICAgICAgICJmcy9qZnMvbmFtZWkuYyINCiAgICAgICAgXSwNCiAgICAgICAgImlu
b2RlX2hhbmRsaW5nIjogWw0KICAgICAgICAgICJmcy9qZnMvamZzX2luY29yZS5oIiwNCiAgICAg
ICAgICAiZnMvamZzL2pmc19kaW5vZGUuaCIsDQogICAgICAgICAgImZzL2pmcy9qZnNfaW5vZGUu
aCINCiAgICAgICAgXSwNCiAgICAgICAgImZpbGVzeXN0ZW1fb3BzIjogWw0KICAgICAgICAgICJm
cy9qZnMvZmlsZS5jIiwNCiAgICAgICAgICAiZnMvamZzL2Rpci5jIiwNCiAgICAgICAgICAiZnMv
amZzL3hhdHRyLmMiDQogICAgICAgIF0sDQogICAgICAgICJtZW1vcnlfbWFuYWdlbWVudCI6IFsN
CiAgICAgICAgICAiZnMvamZzL2pmc19tZXRhcGFnZS5oIiwNCiAgICAgICAgICAiZnMvamZzL2pm
c19kbWFwLmgiDQogICAgICAgIF0sDQogICAgICAgICJ2ZnNfaW50ZXJmYWNlcyI6IFsNCiAgICAg
ICAgICAiZnMvaW5vZGUuYyIsDQogICAgICAgICAgImZzL3N1cGVyLmMiDQogICAgICAgIF0NCiAg
ICAgIH0NCiAgICB9LA0KICAgICJzdGVwNyI6IHsNCiAgICAgICJmYXVsdF9maWxlX2NoYXJhY3Rl
cmlzdGljcyI6IFsNCiAgICAgICAgIkhhbmRsZXMgaW5vZGUgZXZpY3Rpb24gcGF0aCIsDQogICAg
ICAgICJNYW5hZ2VzIGlub2RlIG1ldGFkYXRhIiwNCiAgICAgICAgIkludGVyYWN0cyB3aXRoIG1v
dW50IG9wdGlvbnMiLA0KICAgICAgICAiQ29udGFpbnMgSkZTLXNwZWNpZmljIGxvZ2ljIiwNCiAg
ICAgICAgIlBvdGVudGlhbGx5IG1hbmFnZXMgbWVtb3J5IGJ1ZmZlcnMiDQogICAgICBdDQogICAg
fQ0KICB9LA0KICAic3RhbmRhcmRfb3V0cHV0IjogWw0KICAgICJmcy9qZnMvaW5vZGUuYyIsDQog
ICAgImZzL2pmcy9zdXBlci5jIiwNCiAgICAiZnMvamZzL2pmc19pbmNvcmUuaCIsDQogICAgImZz
L2pmcy9qZnNfZGlub2RlLmgiLA0KICAgICJmcy9qZnMvamZzX21ldGFwYWdlLmgiLA0KICAgICJm
cy9qZnMvZmlsZS5jIiwNCiAgICAiZnMvamZzL25hbWVpLmMiLA0KICAgICJmcy9qZnMvamZzX2lu
b2RlLmgiLA0KICAgICJmcy9pbm9kZS5jIiwNCiAgICAiZnMvamZzL2Rpci5jIg0KICBdDQp9DQpN
ZXRob2QtbGV2ZWwgb3V0cHV0Og0Kew0KICAidGhvdWdodF9wcm9jZXNzIjogew0KICAgICJzdGVw
XzEiOiB7DQogICAgICAiZGVzY3JpcHRpb24iOiAiQnVnIFVuZGVyc3RhbmRpbmciLA0KICAgICAg
ImRldGFpbHMiOiAiVGhlIGJ1ZyByZXBvcnQgaW5kaWNhdGVzIGEga2VybmVsIEJVRyBhdCBmcy9q
ZnMvaW5vZGUuYzoxNjkgaW4gdGhlIGZ1bmN0aW9uIGBqZnNfZXZpY3RfaW5vZGVgLiBUaGUgY3Jh
c2ggb2NjdXJzIGR1cmluZyBpbm9kZSBldmljdGlvbiwgc3VnZ2VzdGluZyBhbiBpc3N1ZSB3aXRo
IGNsZWFudXAgb2YgSkZTIGlub2RlIHJlc291cmNlcy4gVGhlIGNhbGwgc3RhY2sgc2hvd3MgdGhp
cyBpcyB0cmlnZ2VyZWQgZHVyaW5nIGZpbGVzeXN0ZW0gdW5tb3VudC9jbGVhbnVwICh2aWEgYGV2
aWN0X2lub2Rlc2AgLT4gYGdlbmVyaWNfc2h1dGRvd25fc3VwZXJgKS4iDQogICAgfSwNCiAgICAi
c3RlcF8yIjogew0KICAgICAgImRlc2NyaXB0aW9uIjogIlByb2dyYW0gSW50ZW50aW9uIiwNCiAg
ICAgICJkZXRhaWxzIjogIlRoZSB0ZXN0IHByb2dyYW0gbW91bnRzIGEgSkZTIGltYWdlLCBjbG9u
ZXMgYSBwcm9jZXNzLCBhbmQgb3BlbnMgYSBmaWxlLiBUaGlzIGV4ZXJjaXNlcyBmaWxlc3lzdGVt
IGNyZWF0aW9uLCBwcm9jZXNzIGJlaGF2aW9yLCBhbmQgZmlsZSBvcGVyYXRpb25zLiBUaGUgYnVn
IG1hbmlmZXN0cyBkdXJpbmcgY2xlYW51cCAodW5tb3VudCBwaGFzZSkuIg0KICAgIH0sDQogICAg
InN0ZXBfMyI6IHsNCiAgICAgICJkZXNjcmlwdGlvbiI6ICJTdWNjZXNzZnVsIE11dGF0aW9uIEFu
YWx5c2lzIiwNCiAgICAgICJkZXRhaWxzIjogIk5vIHN1Y2Nlc3NmdWwgbXV0YXRpb25zIHdlcmUg
cHJvdmlkZWQsIGJ1dCB0aGUgYnVnJ3MgcGVyc2lzdGVuY2UgYWNyb3NzIHRlc3RzIHN1Z2dlc3Rz
IGl0J3MgYSBmdW5kYW1lbnRhbCBpc3N1ZSBpbiBKRlMncyBjbGVhbnVwIHBhdGggcmF0aGVyIHRo
YW4gYSByYWNlIGNvbmRpdGlvbiBvciB0aW1pbmcgaXNzdWUuIg0KICAgIH0sDQogICAgInN0ZXBf
NCI6IHsNCiAgICAgICJkZXNjcmlwdGlvbiI6ICJGYWlsZWQgTXV0YXRpb24gQW5hbHlzaXMiLA0K
ICAgICAgImRldGFpbHMiOiAiU2luY2UgYWxsIG11dGF0aW9ucyBmYWlsLCB0aGUgYnVnIGFwcGVh
cnMgY29uc2lzdGVudGx5IHRyaWdnZXJlZCBkdXJpbmcgaW5vZGUgZXZpY3Rpb24sIHJlZ2FyZGxl
c3Mgb2Ygc3BlY2lmaWMgb3BlcmF0aW9ucyBwZXJmb3JtZWQgZWFybGllci4iDQogICAgfSwNCiAg
ICAic3RlcF81Ijogew0KICAgICAgImRlc2NyaXB0aW9uIjogIkRlZmVjdCBQYXR0ZXJuIGFuZCBM
aWZlY3ljbGUgSW5mZXJlbmNlIiwNCiAgICAgICJkZXRhaWxzIjogIlRoZSBidWcgb2NjdXJzIGR1
cmluZyB0aGUgY2xlYW51cCBwaGFzZSAoaW5vZGUgZXZpY3Rpb24pLCBzdWdnZXN0aW5nIGVpdGhl
cjogKDEpIGluY29ycmVjdCByZXNvdXJjZSBmcmVlaW5nLCAoMikgbWlzc2luZyBjbGVhbnVwIG9m
IEpGUy1zcGVjaWZpYyBpbm9kZSBtZXRhZGF0YSwgb3IgKDMpIGNvcnJ1cHRpb24gb2YgaW5vZGUg
c3RhdGUgcHJpb3IgdG8gZXZpY3Rpb24uIg0KICAgIH0sDQogICAgInN0ZXBfNiI6IHsNCiAgICAg
ICJkZXNjcmlwdGlvbiI6ICJGdW5jdGlvbiBDbGFzc2lmaWNhdGlvbiBhbmQgTWFwcGluZyIsDQog
ICAgICAiZGV0YWlscyI6ICJLZXkgZnVuY3Rpb25zIGFuYWx5emVkOlxuLSBgamZzX2V2aWN0X2lu
b2RlYDogQ3Jhc2ggcG9pbnQsIGhhbmRsZXMgSkZTLXNwZWNpZmljIGlub2RlIGNsZWFudXBcbi0g
YGpmc190cnVuY2F0ZWAvYGpmc190cnVuY2F0ZV9ub2xvY2tgOiBDb3VsZCBsZWF2ZSBpbmNvbnNp
c3RlbnQgc3RhdGUgaWYgbm90IHByb3Blcmx5IGNsZWFuZWRcbi0gYGpmc193cml0ZV9pbm9kZWAv
YGpmc19jb21taXRfaW5vZGVgOiBJZiBtZXRhZGF0YSBpc24ndCBwcm9wZXJseSBzeW5jZWQgZWFy
bGllclxuLSBgamZzX2lnZXRgOiBJZiBpbm9kZSBpbml0aWFsaXphdGlvbiBpcyBpbmNvbXBsZXRl
XG4tIFZGUyBmdW5jdGlvbnMgKGBldmljdF9pbm9kZXNgLCBgaXB1dF9maW5hbGApIGFyZSBsZXNz
IGxpa2VseSBjdWxwcml0cyBhcyB0aGV5J3JlIGdlbmVyaWMiDQogICAgfSwNCiAgICAic3RlcF83
Ijogew0KICAgICAgImRlc2NyaXB0aW9uIjogIlN1c3BpY2lvbiBJbmZlcmVuY2UiLA0KICAgICAg
ImRldGFpbHMiOiAiUmFua2luZyBjcml0ZXJpYTpcbjEuIERpcmVjdCBpbnZvbHZlbWVudCBpbiBj
cmFzaCBwYXRoIChgamZzX2V2aWN0X2lub2RlYClcbjIuIEpGUy1zcGVjaWZpYyBjbGVhbnVwIGZ1
bmN0aW9uc1xuMy4gRnVuY3Rpb25zIHRoYXQgbW9kaWZ5IGlub2RlIHN0YXRlIHBlcnNpc3RlbnRs
eVxuNC4gRnVuY3Rpb25zIGNhbGxlZCBkdXJpbmcgZWFybGllciBwaGFzZXMgdGhhdCBtaWdodCBs
ZWF2ZSBpbmNvbnNpc3RlbnQgc3RhdGVcbjUuIFByZXNlbmNlIGluIHRvcCBzdXNwaWNpb3VzIGZp
bGVzIChmcy9qZnMvaW5vZGUuYyBpcyBwcmltYXJ5KSINCiAgICB9LA0KICAgICJzdGVwXzgiOiB7
DQogICAgICAiZGVzY3JpcHRpb24iOiAiRmluYWwgT3V0cHV0IiwNCiAgICAgICJkZXRhaWxzIjog
IlRvcCBzdXNwZWN0cyBhcmUgSkZTIGZ1bmN0aW9ucyBpbnZvbHZlZCBpbiBpbm9kZSBzdGF0ZSBt
YW5hZ2VtZW50IGFuZCBjbGVhbnVwLCBwYXJ0aWN1bGFybHkgdGhvc2UgdGhhdCBtaWdodCBsZWF2
ZSBpbmNvbnNpc3RlbnQgc3RhdGUgaWYgbm90IHByb3Blcmx5IGhhbmRsZWQgZHVyaW5nIGV2aWN0
aW9uLiINCiAgICB9DQogIH0sDQogICJzdGFuZGFyZF9vdXRwdXQiOiBbDQogICAgImpmc19ldmlj
dF9pbm9kZSIsDQogICAgImpmc190cnVuY2F0ZV9ub2xvY2siLA0KICAgICJqZnNfd3JpdGVfaW5v
ZGUiLA0KICAgICJqZnNfY29tbWl0X2lub2RlIiwNCiAgICAiamZzX2lnZXQiLA0KICAgICJqZnNf
ZGlydHlfaW5vZGUiLA0KICAgICJqZnNfdHJ1bmNhdGUiLA0KICAgICJqZnNfcmVsZWFzZXBhZ2Ui
LA0KICAgICJqZnNfaW52YWxpZGF0ZXBhZ2UiLA0KICAgICJldmljdF9pbm9kZXMiDQogIF0NCn0=
--000000000000cf2346063bd28dd2--

