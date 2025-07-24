Return-Path: <linux-kernel+bounces-743574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56078B10064
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7536B7A5C20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84685205E02;
	Thu, 24 Jul 2025 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9lqsAaK"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F519A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337337; cv=none; b=O8D/s/xPC+V1EKc+tlRANL6keGRspR2Y7PouVOG+9P/+jaVy9QhP6TCrio3jdA60KP/37qF3XtXlpkzUBkMbAb3otD72Q2nKoS/c6Rh1VRfzkVywYb0ZPcgxCHCZy6WMRDy+LEdmaEUITDEZlHODqshkzefx03wfZJGRQkpI5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337337; c=relaxed/simple;
	bh=FuZXk0xFDuwU9y0/iXtf7lx/4eCRTYoYYizmVmi5tf0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HHaKRf+9LkPd8sWdgVvqBRBSgJms4DHlWErZ78OUhwMYQJUwo44pYTNroYbuFAYJHIBuqtyq84fEHE+OiglqP3N9irfKVsxYT8H2ynKnwDe5OaWtKYcx9dxo5B3z/43HxuAQa94D9G4/Tu5//gfzlWvdR2vYyc5q1S0Una7N1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9lqsAaK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8d7122c3a5so481519276.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753337335; x=1753942135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWBW4FV+EMdSNJ1KdMPUsNL3iRvUTYOlhLJggMOT+UU=;
        b=W9lqsAaKK3+8iS7rCWl2pKRrQKmGfutM0sXtaIOLqBI0wTjjfo7Tna9JV8687V3aYY
         xXcAd6enw1p8du5PDGnJDolhoWPCejI0dVaYk1Mq8I1HVDBS1iSzdRiBY35Oqgmdt8fS
         tNhCUPnXqyjMmo2GaALfGCK1i1us/TrerU73Fd7/ovCiOfK8Ka16z1n3VQZVJww6d92T
         1r+5Eg48W6NqHggzxiDmyAyll6L4iE6RJPbZHCJ+9XJ7ZX3Wk7ycVqSmNvDNyTx7MTpE
         QcX2XQD3pG2cLVSWkci/YVPu2upmLGrWJetLarme2YXyOK5gTmNhzV2f6tHz0CNEUAvB
         YyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337335; x=1753942135;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWBW4FV+EMdSNJ1KdMPUsNL3iRvUTYOlhLJggMOT+UU=;
        b=JRS6HjcnQJgwGqitkwEzQ3RIw/2039Tf4B2/1tbbGvlPuhvLCncsEYjN64TG6h8rrj
         QeX0A+nedplaEp7UC7AB/4elNRYBnO6Ya4ut/MTY108bFm4CVQtT1LEr6Ay5CDpG6vQL
         wDz6Rlu1kw7gROFUCGBwrUveWrl2RvSxgbuov09j3GD5Hl5Z5FI8Tp7onRphdbb6elW5
         Llt1WXa04dV0FGrJA5uMZP1vrryqgxcMnSDPBmbio+Fb29c5oledPub1DbYZMv0EAfuz
         xp4Kj0cNgEvwZ4Q+YEg7aOItgJ0pB6/baXHMeT/5uzn+mQGimt4w9TBenR0Eko8u65vV
         5E5Q==
X-Gm-Message-State: AOJu0YzsxycZMSHB82LuONmYIJ7OD0bQHb8TfaZgnmU9Aejo9d6H1sdm
	rUCZpxa0ck9a1/VLwJmSVR0g0juDiM5mM40Hhf2opIw+TMVfMKOt18QklhzGBnQfWmR7NcBg/42
	4BX9LeuHsbbrhLEjdhwwN5iuopLN9GAE=
X-Gm-Gg: ASbGncsZuGuYZ5QoU5wU/n90vzJ+lTdEw26T25Z4YEKk36bPtwi+1G++P2rvpRrfQbT
	u334KNhtpXIBMlosXwplMZl+/XOscFRlP2uUn6XjdNeWgd0B30cFiZK/fwvO3b8Tgp98zto75UV
	526jDmeneyhWRF4A4pKBYM5UOa5oFohjxLaxuGfulrd3kEZSWHlASx+rN/co1kj/ci9cx2uOf/k
	SK7uUk+
X-Google-Smtp-Source: AGHT+IHhHsUyUdnrD5cfcbbQPGE5HbdqOtR2agfHgs04MHrBItFg/khljlw7NGBELFFJDocLAG56nfqDL7BMo0kvx3M=
X-Received: by 2002:a05:6902:430d:b0:e8d:6ff0:b4b3 with SMTP id
 3f1490d57ef6-e8dc5a271b9mr5335476276.31.1753337335053; Wed, 23 Jul 2025
 23:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Wed, 23 Jul 2025 23:08:43 -0700
X-Gm-Features: Ac12FXwMG2AKxCUyjqJYJqXpQMk8Eo9mwzBzqHzTYQBSnaql8qtp3mrLHRgPvjQ
Message-ID: <CAF3JpA72uvA4=hkHxbGui=2shumVZTSAUmyha_0AAkLmx-xcjg@mail.gmail.com>
Subject: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
To: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000073624063aa6a990"

--000000000000073624063aa6a990
Content-Type: text/plain; charset="UTF-8"

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
main

--000000000000073624063aa6a990
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mac80211-fix-use-after-free-risk-in-sta-debugfs-remo.patch"
Content-Disposition: attachment; 
	filename="0001-mac80211-fix-use-after-free-risk-in-sta-debugfs-remo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdgzh7d00>
X-Attachment-Id: f_mdgzh7d00

RnJvbSBhM2FkNTBiZDFiMTUyOGRlMzAyZDJkMGE1YzViZGZmY2YwNTllNGU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogV2VkLCAyMyBKdWwgMjAyNSAyMjo0NTozNyAtMDcwMApTdWJqZWN0OiBbUEFUQ0gg
d2lyZWxlc3MtbmV4dF0gbWFjODAyMTE6IGZpeCB1c2UtYWZ0ZXItZnJlZSByaXNrIGluIHN0YSBk
ZWJ1Z2ZzIHJlbW92YWwKCkEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIG1heSBvY2N1ciBpbiBp
ZWVlODAyMTFfc3RhX2RlYnVnZnNfcmVtb3ZlKCkKd2hlbiBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNp
dmUoKSBpcyBjYWxsZWQgb24gYSBkZW50cnkgd2hvc2UgaW5vZGUgaGFzCmFscmVhZHkgYmVlbiBm
cmVlZC4gVGhpcyBjYW4gaGFwcGVuIGR1ZSB0byBhIHJhY2UgYmV0d2VlbiBTVEEgdGVhcmRvd24K
YW5kIGRlYnVnZnMgY2xlYW51cC4KCkZpeCB0aGlzIGJ5IGNoZWNraW5nIHRoYXQgYm90aCBzdGEt
PmRlYnVnZnNfZGlyIGFuZCBpdHMgZF9pbm9kZSBhcmUKdmFsaWQgYmVmb3JlIGludm9raW5nIGRl
YnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZSgpLgoKVGhpcyBhdm9pZHMgdGhlIGNyYXNoIHJlcG9ydGVk
IGluIHN5emJvdCBidWc6CgogIHdsYW4xOiBzZW5kIGF1dGggdG8gYWE6MDk6Yjc6OTk6YzA6ZDcg
KHRyeSAyLzMpCiAgd2xhbjE6IHNlbmQgYXV0aCB0byBhYTowOTpiNzo5OTpjMDpkNyAodHJ5IDMv
MykKICB3bGFuMTogYXV0aGVudGljYXRpb24gd2l0aCBhYTowOTpiNzo5OTpjMDpkNyB0aW1lZCBv
dXQKICBPb3BzOiBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBub24tY2Fu
b25pY2FsIGFkZHJlc3MgMHhkZmZmZmMwMDAwMDAwMDI5OiAwMDAwIFsjMV0gU01QIEtBU0FOIE5P
UFRJCiAgS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAxNDgt
MHgwMDAwMDAwMDAwMDAwMTRmXQogIENQVTogMCBVSUQ6IDAgUElEOiAxNzEgQ29tbToga3dvcmtl
ci91NDo0IE5vdCB0YWludGVkIDYuMTYuMC1yYzctc3l6a2FsbGVyICMwIFBSRUVNUFQoZnVsbCkK
ICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklP
UyAxLjE2LjMtZGViaWFuLTEuMTYuMy0yfmJwbzEyKzEgMDQvMDEvMjAxNAogIFdvcmtxdWV1ZTog
ZXZlbnRzX3VuYm91bmQgY2ZnODAyMTFfd2lwaHlfd29yawogIFJJUDogMDAxMDprYXNhbl9ieXRl
X2FjY2Vzc2libGUrMHgxMi8weDMwIG1tL2thc2FuL2dlbmVyaWMuYzoxOTkKICBDb2RlOiAwZiAx
ZiA4NCAwMCAwMCAwMCAwMCAwMCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5
MCA5MCA5MCA5MCA2NiAwZiAxZiAwMCA0OCBjMSBlZiAwMyA0OCBiOCAwMCAwMCAwMCAwMCAwMCBm
YyBmZiBkZiA8MGY+IGI2IDA0IDA3IDNjIDA4IDBmICAgOTIgYzAgYzMgY2MgY2MgY2MgY2MgY2Mg
NjYgNjYgNjYgNjYgNjYgNjYgMmUKICBSU1A6IDAwMTg6ZmZmZmM5MDAwMTk3NzQwMCBFRkxBR1M6
IDAwMDEwMjAyCiAgUkFYOiBkZmZmZmMwMDAwMDAwMDAwIFJCWDogZmZmZmZmZmY4YjcxMzI4NiBS
Q1g6IGNhNWMxOTMzZTM1ZjM3MDAKICBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZm
ZjhiNzEzMjg2IFJESTogMDAwMDAwMDAwMDAwMDAyOQogIFJCUDogZmZmZmZmZmY4MjQwNjdmMCBS
MDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAwMDAwMDAwCiAgUjEwOiBkZmZmZmMw
MDAwMDAwMDAwIFIxMTogZmZmZmVkMTAwODVjZjI0YyBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKICBS
MTM6IDAwMDAwMDAwMDAwMDAxNDggUjE0OiAwMDAwMDAwMDAwMDAwMTQ4IFIxNTogMDAwMDAwMDAw
MDAwMDAwMQogIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MDhkMjE4MDAw
KDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAw
MDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCiAgQ1IyOiAwMDAwMDAxYjJmNTVmZmZmIENSMzogMDAw
MDAwMDA1MDMwYTAwMCBDUjQ6IDAwMDAwMDAwMDAzNTJlZjAKICBDYWxsIFRyYWNlOgogICA8VEFT
Sz4KICAgX19rYXNhbl9jaGVja19ieXRlKzB4MTIvMHg0MCBtbS9rYXNhbi9jb21tb24uYzo1NTYK
ICAga2FzYW5fY2hlY2tfYnl0ZSBpbmNsdWRlL2xpbnV4L2thc2FuLmg6Mzk5IFtpbmxpbmVdCiAg
IGxvY2tfYWNxdWlyZSsweDhkLzB4MzYwIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzo1ODQ1CiAg
IGRvd25fd3JpdGUrMHg5Ni8weDFmMCBrZXJuZWwvbG9ja2luZy9yd3NlbS5jOjE1NzcKICAgaW5v
ZGVfbG9jayBpbmNsdWRlL2xpbnV4L2ZzLmg6ODY5IFtpbmxpbmVdCiAgIHNpbXBsZV9yZWN1cnNp
dmVfcmVtb3ZhbCsweDkwLzB4NjkwIGZzL2xpYmZzLmM6NjE2CiAgIGRlYnVnZnNfcmVtb3ZlKzB4
NWIvMHg3MCBmcy9kZWJ1Z2ZzL2lub2RlLmM6ODA1CiAgIGllZWU4MDIxMV9zdGFfZGVidWdmc19y
ZW1vdmUrMHg0MC8weDcwIG5ldC9tYWM4MDIxMS9kZWJ1Z2ZzX3N0YS5jOjEyNzkKICAgX19zdGFf
aW5mb19kZXN0cm95X3BhcnQyKzB4MzUyLzB4NDUwIG5ldC9tYWM4MDIxMS9zdGFfaW5mby5jOjE1
MDEKICAgX19zdGFfaW5mb19kZXN0cm95IG5ldC9tYWM4MDIxMS9zdGFfaW5mby5jOjE1MTcgW2lu
bGluZV0KICAgc3RhX2luZm9fZGVzdHJveV9hZGRyKzB4ZjUvMHgxNDAgbmV0L21hYzgwMjExL3N0
YV9pbmZvLmM6MTUyOQogICBpZWVlODAyMTFfZGVzdHJveV9hdXRoX2RhdGErMHgxMmQvMHgyNjAg
bmV0L21hYzgwMjExL21sbWUuYzo0NTk3CiAgIGllZWU4MDIxMV9zdGFfd29yaysweDExY2YvMHgz
NjAwIG5ldC9tYWM4MDIxMS9tbG1lLmM6ODMxMAogICBjZmc4MDIxMV93aXBoeV93b3JrKzB4MmRm
LzB4NDYwIG5ldC93aXJlbGVzcy9jb3JlLmM6NDM1CiAgIHByb2Nlc3Nfb25lX3dvcmsga2VybmVs
L3dvcmtxdWV1ZS5jOjMyMzggW2lubGluZV0KICAgcHJvY2Vzc19zY2hlZHVsZWRfd29ya3MrMHhh
ZTEvMHgxN2IwIGtlcm5lbC93b3JrcXVldWUuYzozMzIxCiAgIHdvcmtlcl90aHJlYWQrMHg4YTAv
MHhkYTAga2VybmVsL3dvcmtxdWV1ZS5jOjM0MDIKICAga3RocmVhZCsweDcwZS8weDhhMCBrZXJu
ZWwva3RocmVhZC5jOjQ2NAogICByZXRfZnJvbV9mb3JrKzB4M2ZjLzB4NzcwIGFyY2gveDg2L2tl
cm5lbC9wcm9jZXNzLmM6MTQ4CiAgIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBhcmNoL3g4
Ni9lbnRyeS9lbnRyeV82NC5TOjI0NQogICA8L1RBU0s+CgpGaXhlczogZmM0YTI1YzViNzQxICgi
bWFjODAyMTE6IHJlbW92ZSBzdGFfaW5mbyBkZWJ1Z2ZzIHN1Yi1zdHJ1Y3QiKQpTaWduZWQtb2Zm
LWJ5OiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNvbT4KLS0tCiBuZXQvbWFj
ODAyMTEvZGVidWdmc19zdGEuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL2RlYnVnZnNfc3Rh
LmMgYi9uZXQvbWFjODAyMTEvZGVidWdmc19zdGEuYwppbmRleCA0OTA2MWJkNDE1MWIuLjkxMmI2
OWFiYWI1MiAxMDA2NDQKLS0tIGEvbmV0L21hYzgwMjExL2RlYnVnZnNfc3RhLmMKKysrIGIvbmV0
L21hYzgwMjExL2RlYnVnZnNfc3RhLmMKQEAgLTEyNzYsNyArMTI3Niw4IEBAIHZvaWQgaWVlZTgw
MjExX3N0YV9kZWJ1Z2ZzX2FkZChzdHJ1Y3Qgc3RhX2luZm8gKnN0YSkKIAogdm9pZCBpZWVlODAy
MTFfc3RhX2RlYnVnZnNfcmVtb3ZlKHN0cnVjdCBzdGFfaW5mbyAqc3RhKQogewotCWRlYnVnZnNf
cmVtb3ZlX3JlY3Vyc2l2ZShzdGEtPmRlYnVnZnNfZGlyKTsKKwlpZiAoc3RhLT5kZWJ1Z2ZzX2Rp
ciAmJiBzdGEtPmRlYnVnZnNfZGlyLT5kX2lub2RlKQorCQlkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNp
dmUoc3RhLT5kZWJ1Z2ZzX2Rpcik7CiAJc3RhLT5kZWJ1Z2ZzX2RpciA9IE5VTEw7CiB9CiAKLS0g
CjIuNDMuMAoK
--000000000000073624063aa6a990--

