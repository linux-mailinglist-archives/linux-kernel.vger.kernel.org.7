Return-Path: <linux-kernel+bounces-743579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC19B10072
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F587B830C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E4207A2A;
	Thu, 24 Jul 2025 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgfxvPTI"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDE1A2396
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337872; cv=none; b=VWWjGrx6ro+accHLLpAqWW0GxGM5Nk13wWxpUCdw+AdQ7FZmZjtXxS55nrl4uS9qGGVUSfSGmXMnAE6U0hM0jao0DV8QFCsHNFefHo6r5yn4Tlpb4WORf61r3wcUWwEjaI/v+paPtcBRudBkrJLo/hj6iOuHaEv5d+zyFaDILIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337872; c=relaxed/simple;
	bh=XOwNOJ6JLOwlJz58r8Dmy3WQ2ZWt8l9U43Q0DWOej5s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CCqJCMdFBWWXK1ESieWD/VhdJ4w7/JJWur3XLlgEMBKZhv4aeViwwvIs5+OsOsqOWy6Fb0uBkc2jMxLC0oEEN/7rbUW8rLv+UyLGQoC/cmhrYRZam5NlyNXRn5yQUDNd+tA2iZyL4R5JPOL4/N5UZxWZ5LOTsajU/ZGx+StjcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgfxvPTI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bbb02b887so452831276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753337869; x=1753942669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zia9dpH97hdF2csEIs1BHr9E6KPrVSwJIn6wpLeAmw=;
        b=ZgfxvPTIO6YCvwdLVpgqzWEIj2YSKuGV9KAKNn2hhfQfyBQlxf0iH1NOjqwlkuyg3S
         lKOOq2uWYcM7xIdivV2lAuipqIwHto/AIESGnrFf/ZPbbR3TpS8A+aFCzR281282Z/fj
         2wHYZTJryQLxMYjqddFrsBFZudP+4kOkzvVqo8/6jBr5vqvesRdHP8qaGrK4szWeBe0F
         Iz2dAuytLfVDT2Zv9p9j77UJsi2dPEGH8oqfHBZe6StAzs1PT8TOx0WUtwXF1ywotE1t
         uGRoVGhnIuc4SdYWG1gRB7F5KRZbVfvh5S37beFyFbMXCRmRPKXj2VTXoe2Khq1GV//+
         N2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337869; x=1753942669;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zia9dpH97hdF2csEIs1BHr9E6KPrVSwJIn6wpLeAmw=;
        b=JbAVrqO1+D8PB9xPqSNuZc3K56iR+foG1zwGDYIMeZldEMOexaH5CCG60LD2YglM9+
         7WzzQ1XLJ/Nry1CzwZMu7Q1BoDyxj5nr7VI5gZOnee3zz3FmFOOQmvaUjzW7zmAlwGWn
         DJR4JQgd0bWrkHmKjTycaFWmv4BOGhonPkVhym1yUjZCSTenRxu8LDyR8XmrKKafWYP4
         oY0MUU6LGxS0/0XiRxjQXSdV9q2243eQ4fmO9zdmF/v8wCFaaG8n2V18Hr3tOOigpVrt
         44+bO0Q2RwH2sgwnBRwpLyZfMw4hGcvI0mdHYPE25+tJHuFs9KiafYlHtBMBNRiJLki1
         /6xg==
X-Gm-Message-State: AOJu0YynoWfK4/CxpNoFmftnvKGEiOA59sFV6N0q6j1NneLYma5mZ3kE
	+x+sS/cgBCu18/GUck1YtXFg4EFPlYtCJQxSr1d25OeKWIRtxikxVbVtZJ5+TIcosYYndg+ayeV
	ddiAlBzuWHnC6ZOPhaRfH23iADqiqLig=
X-Gm-Gg: ASbGncupLBhl3hhjCdN6ld1BAdF5Wh8j3dfjS4NJxEttGKSpNaENKLy4p3b86bPg5uL
	jj4Ro4h0TLfGCXCqSzntTuV+KbKojziESg7Bw/hYY1gXi6jvRFPxaUG4tvQTtwuD+5rMwstaU6q
	ZLgYrR/lzBfaKLoNJAIw2bNDxlHmnFPb1o40WZKIzpJFbnl0u1f0DJlSwHfcumwApfiAQ76EIrj
	EtcdfGD
X-Google-Smtp-Source: AGHT+IFkb1Mm8itlYdZT6OJbP86vxFbaTRkdsHYAtZqEFsu+9L2E8rDPekhu4saVlBP4Irptp44LWf53L/zHt+jr0SI=
X-Received: by 2002:a05:6902:2113:b0:e85:1e91:562c with SMTP id
 3f1490d57ef6-e8dc582961dmr6818538276.14.1753337869373; Wed, 23 Jul 2025
 23:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Wed, 23 Jul 2025 23:17:38 -0700
X-Gm-Features: Ac12FXxURV6NaE8BkKj_HVcgsquE0nsgbHoYP-cOluBBo9u-1VCSzF8qOaNDXcU
Message-ID: <CAF3JpA50PVavHnV3e6hPpQ0xRKPY95K9K6Q40k7Hhi9vmzp7PQ@mail.gmail.com>
Subject: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
To: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000e045f6063aa6c805"

--000000000000e045f6063aa6c805
Content-Type: text/plain; charset="UTF-8"

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
main

--000000000000e045f6063aa6c805
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-wifi-mac80211-fix-use-after-free-risk-in-sta-debugfs.patch"
Content-Disposition: attachment; 
	filename="0001-wifi-mac80211-fix-use-after-free-risk-in-sta-debugfs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdh01xzk0>
X-Attachment-Id: f_mdh01xzk0

RnJvbSBiNDUzNDE0NGIyODhkOTU0NDgwNzI4YmI0YmEyOTExNzhhZjQzZmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogV2VkLCAyMyBKdWwgMjAyNSAyMjo0NTozNyAtMDcwMApTdWJqZWN0OiBbUEFUQ0gg
d2lyZWxlc3MtbmV4dF0gd2lmaTogbWFjODAyMTE6IGZpeCB1c2UtYWZ0ZXItZnJlZSByaXNrIGlu
IHN0YSBkZWJ1Z2ZzCiByZW1vdmFsCgpBIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBtYXkgb2Nj
dXIgaW4gaWVlZTgwMjExX3N0YV9kZWJ1Z2ZzX3JlbW92ZSgpCndoZW4gZGVidWdmc19yZW1vdmVf
cmVjdXJzaXZlKCkgaXMgY2FsbGVkIG9uIGEgZGVudHJ5IHdob3NlIGlub2RlIGhhcwphbHJlYWR5
IGJlZW4gZnJlZWQuIFRoaXMgY2FuIGhhcHBlbiBkdWUgdG8gYSByYWNlIGJldHdlZW4gU1RBIHRl
YXJkb3duCmFuZCBkZWJ1Z2ZzIGNsZWFudXAuCgpGaXggdGhpcyBieSBjaGVja2luZyB0aGF0IGJv
dGggc3RhLT5kZWJ1Z2ZzX2RpciBhbmQgaXRzIGRfaW5vZGUgYXJlCnZhbGlkIGJlZm9yZSBpbnZv
a2luZyBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoKS4KClRoaXMgYXZvaWRzIHRoZSBjcmFzaCBy
ZXBvcnRlZCBpbiBzeXpib3QgYnVnOgoKICB3bGFuMTogc2VuZCBhdXRoIHRvIGFhOjA5OmI3Ojk5
OmMwOmQ3ICh0cnkgMi8zKQogIHdsYW4xOiBzZW5kIGF1dGggdG8gYWE6MDk6Yjc6OTk6YzA6ZDcg
KHRyeSAzLzMpCiAgd2xhbjE6IGF1dGhlbnRpY2F0aW9uIHdpdGggYWE6MDk6Yjc6OTk6YzA6ZDcg
dGltZWQgb3V0CiAgT29wczogZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBwcm9iYWJseSBmb3Ig
bm9uLWNhbm9uaWNhbCBhZGRyZXNzIDB4ZGZmZmZjMDAwMDAwMDAyOTogMDAwMCBbIzFdIFNNUCBL
QVNBTiBOT1BUSQogIEtBU0FOOiBudWxsLXB0ci1kZXJlZiBpbiByYW5nZSBbMHgwMDAwMDAwMDAw
MDAwMTQ4LTB4MDAwMDAwMDAwMDAwMDE0Zl0KICBDUFU6IDAgVUlEOiAwIFBJRDogMTcxIENvbW06
IGt3b3JrZXIvdTQ6NCBOb3QgdGFpbnRlZCA2LjE2LjAtcmM3LXN5emthbGxlciAjMCBQUkVFTVBU
KGZ1bGwpCiAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAw
OSksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMn5icG8xMisxIDA0LzAxLzIwMTQKICBXb3Jr
cXVldWU6IGV2ZW50c191bmJvdW5kIGNmZzgwMjExX3dpcGh5X3dvcmsKICBSSVA6IDAwMTA6a2Fz
YW5fYnl0ZV9hY2Nlc3NpYmxlKzB4MTIvMHgzMCBtbS9rYXNhbi9nZW5lcmljLmM6MTk5CiAgQ29k
ZTogMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAg
OTAgOTAgOTAgOTAgOTAgOTAgNjYgMGYgMWYgMDAgNDggYzEgZWYgMDMgNDggYjggMDAgMDAgMDAg
MDAgMDAgZmMgZmYgZGYgPDBmPiBiNiAwNCAwNyAzYyAwOCAwZiAgIDkyIGMwIGMzIGNjIGNjIGNj
IGNjIGNjIDY2IDY2IDY2IDY2IDY2IDY2IDJlCiAgUlNQOiAwMDE4OmZmZmZjOTAwMDE5Nzc0MDAg
RUZMQUdTOiAwMDAxMDIwMgogIFJBWDogZGZmZmZjMDAwMDAwMDAwMCBSQlg6IGZmZmZmZmZmOGI3
MTMyODYgUkNYOiBjYTVjMTkzM2UzNWYzNzAwCiAgUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTog
ZmZmZmZmZmY4YjcxMzI4NiBSREk6IDAwMDAwMDAwMDAwMDAwMjkKICBSQlA6IGZmZmZmZmZmODI0
MDY3ZjAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogMDAwMDAwMDAwMDAwMDAwMAogIFIxMDog
ZGZmZmZjMDAwMDAwMDAwMCBSMTE6IGZmZmZlZDEwMDg1Y2YyNGMgUjEyOiAwMDAwMDAwMDAwMDAw
MDAwCiAgUjEzOiAwMDAwMDAwMDAwMDAwMTQ4IFIxNDogMDAwMDAwMDAwMDAwMDE0OCBSMTU6IDAw
MDAwMDAwMDAwMDAwMDEKICBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODA4
ZDIxODAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCiAgQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwogIENSMjogMDAwMDAwMWIyZjU1ZmZmZiBD
UjM6IDAwMDAwMDAwNTAzMGEwMDAgQ1I0OiAwMDAwMDAwMDAwMzUyZWYwCiAgQ2FsbCBUcmFjZToK
ICAgPFRBU0s+CiAgIF9fa2FzYW5fY2hlY2tfYnl0ZSsweDEyLzB4NDAgbW0va2FzYW4vY29tbW9u
LmM6NTU2CiAgIGthc2FuX2NoZWNrX2J5dGUgaW5jbHVkZS9saW51eC9rYXNhbi5oOjM5OSBbaW5s
aW5lXQogICBsb2NrX2FjcXVpcmUrMHg4ZC8weDM2MCBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6
NTg0NQogICBkb3duX3dyaXRlKzB4OTYvMHgxZjAga2VybmVsL2xvY2tpbmcvcndzZW0uYzoxNTc3
CiAgIGlub2RlX2xvY2sgaW5jbHVkZS9saW51eC9mcy5oOjg2OSBbaW5saW5lXQogICBzaW1wbGVf
cmVjdXJzaXZlX3JlbW92YWwrMHg5MC8weDY5MCBmcy9saWJmcy5jOjYxNgogICBkZWJ1Z2ZzX3Jl
bW92ZSsweDViLzB4NzAgZnMvZGVidWdmcy9pbm9kZS5jOjgwNQogICBpZWVlODAyMTFfc3RhX2Rl
YnVnZnNfcmVtb3ZlKzB4NDAvMHg3MCBuZXQvbWFjODAyMTEvZGVidWdmc19zdGEuYzoxMjc5CiAg
IF9fc3RhX2luZm9fZGVzdHJveV9wYXJ0MisweDM1Mi8weDQ1MCBuZXQvbWFjODAyMTEvc3RhX2lu
Zm8uYzoxNTAxCiAgIF9fc3RhX2luZm9fZGVzdHJveSBuZXQvbWFjODAyMTEvc3RhX2luZm8uYzox
NTE3IFtpbmxpbmVdCiAgIHN0YV9pbmZvX2Rlc3Ryb3lfYWRkcisweGY1LzB4MTQwIG5ldC9tYWM4
MDIxMS9zdGFfaW5mby5jOjE1MjkKICAgaWVlZTgwMjExX2Rlc3Ryb3lfYXV0aF9kYXRhKzB4MTJk
LzB4MjYwIG5ldC9tYWM4MDIxMS9tbG1lLmM6NDU5NwogICBpZWVlODAyMTFfc3RhX3dvcmsrMHgx
MWNmLzB4MzYwMCBuZXQvbWFjODAyMTEvbWxtZS5jOjgzMTAKICAgY2ZnODAyMTFfd2lwaHlfd29y
aysweDJkZi8weDQ2MCBuZXQvd2lyZWxlc3MvY29yZS5jOjQzNQogICBwcm9jZXNzX29uZV93b3Jr
IGtlcm5lbC93b3JrcXVldWUuYzozMjM4IFtpbmxpbmVdCiAgIHByb2Nlc3Nfc2NoZWR1bGVkX3dv
cmtzKzB4YWUxLzB4MTdiMCBrZXJuZWwvd29ya3F1ZXVlLmM6MzMyMQogICB3b3JrZXJfdGhyZWFk
KzB4OGEwLzB4ZGEwIGtlcm5lbC93b3JrcXVldWUuYzozNDAyCiAgIGt0aHJlYWQrMHg3MGUvMHg4
YTAga2VybmVsL2t0aHJlYWQuYzo0NjQKICAgcmV0X2Zyb21fZm9yaysweDNmYy8weDc3MCBhcmNo
L3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0OAogICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAg
YXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoyNDUKICAgPC9UQVNLPgoKRml4ZXM6IGZjNGEyNWM1
Yjc0MSAoIm1hYzgwMjExOiByZW1vdmUgc3RhX2luZm8gZGVidWdmcyBzdWItc3RydWN0IikKU2ln
bmVkLW9mZi1ieTogTW9vbiBIZWUgTGVlIDxtb29uaGVlLmxlZS5jYUBnbWFpbC5jb20+Ci0tLQog
bmV0L21hYzgwMjExL2RlYnVnZnNfc3RhLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9kZWJ1
Z2ZzX3N0YS5jIGIvbmV0L21hYzgwMjExL2RlYnVnZnNfc3RhLmMKaW5kZXggNDkwNjFiZDQxNTFi
Li45MTJiNjlhYmFiNTIgMTAwNjQ0Ci0tLSBhL25ldC9tYWM4MDIxMS9kZWJ1Z2ZzX3N0YS5jCisr
KyBiL25ldC9tYWM4MDIxMS9kZWJ1Z2ZzX3N0YS5jCkBAIC0xMjc2LDcgKzEyNzYsOCBAQCB2b2lk
IGllZWU4MDIxMV9zdGFfZGVidWdmc19hZGQoc3RydWN0IHN0YV9pbmZvICpzdGEpCiAKIHZvaWQg
aWVlZTgwMjExX3N0YV9kZWJ1Z2ZzX3JlbW92ZShzdHJ1Y3Qgc3RhX2luZm8gKnN0YSkKIHsKLQlk
ZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoc3RhLT5kZWJ1Z2ZzX2Rpcik7CisJaWYgKHN0YS0+ZGVi
dWdmc19kaXIgJiYgc3RhLT5kZWJ1Z2ZzX2Rpci0+ZF9pbm9kZSkKKwkJZGVidWdmc19yZW1vdmVf
cmVjdXJzaXZlKHN0YS0+ZGVidWdmc19kaXIpOwogCXN0YS0+ZGVidWdmc19kaXIgPSBOVUxMOwog
fQogCi0tIAoyLjQzLjAKCg==
--000000000000e045f6063aa6c805--

