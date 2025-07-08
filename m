Return-Path: <linux-kernel+bounces-722418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992CAFDA29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E88E1C25D78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35881217709;
	Tue,  8 Jul 2025 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzLZvghA"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE017C21E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011155; cv=none; b=SC2JkgWyH+vHwSiMp+D+y7CHd8rwKRK4RN9N2KqWn7bzFC8KiSx0saxZ8jikohksmvyfchQrtDiMB0NtUh7cpQaNW5t8QvGHMwuiTBg6hPcDeITzCVzYjNb68DKEGS/2PtvezWYzyClHN/FlcqFJA6Vkjv/a/Ul55icuOY5idlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011155; c=relaxed/simple;
	bh=AupsQCF0dWNjnaeNPs3+9yWwIfidJH7lNb8ftuw+vSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NKae2QTIg/aVYb5Io7dmOF2pDGxCrCorkoG7Q1bnTVBjQVjzzjzgSVEP/RY9Mc456qkgNMsgvzw2ChFjPFdMW1CjL50rj9y5l3uNPSMPpdSlahgeLqlHLxI5YyGUvem+iHo5a2IaLsA+6vTn085//lbIN6/bmrs4jYoj/fuw3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzLZvghA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e75f30452so32744997b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752011153; x=1752615953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0qfiTnhb6RgnIzn3Y/7jQJsasnXGa87k1HcGtvIkI6I=;
        b=EzLZvghARE0EUX7Vt8NNqpqY+/JDxTpzwrVFwEO47dvpOuOx8BTUpHBoa5G+o+RlKl
         L254jKbrFCoLGRcWzoRf6gIwK/vQGKbeO0V9XMg4IQoEQwb5Xw9w3/6eMqqIS401tQIE
         7CYRh/4S+U09E102LtOO663TTdxfRwT/lgcD5xkhOpHiAAV2MNmmO06OrIj8tyzJwXsY
         FLXYKI7u4n8sK6vwTyPcQkIbcQjs8FZi7e7NbBK4HHGr+CiRBECoFe7c7XEgG46Ya5FR
         MgYw2T2VwP2JsbL0v1BhaWCj68/YBULcGFWMt1TylGUNL/z3UUKbj8oexnvU4Cso7bBF
         Yqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752011153; x=1752615953;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qfiTnhb6RgnIzn3Y/7jQJsasnXGa87k1HcGtvIkI6I=;
        b=DlHfYoQsGOWwReW1yfI37PTZ8KSYbL+8+tj8ImGdtc6RwVX9/t82ddquCzxZaOlfWh
         nnIm3Mz/KF1OvPKqMvg/rr/iXegXhwLVBalJsOF0k4bfFns50plqTUtU0jGz8T4joOcB
         +VaG45gFCXf2PI1hLgi9sBNJg0FHJhNhVeQv0oy42IAroU3n3FOVkWVxUmucPqkw1quC
         F/Sbvbvi2fjA0ZJS2D6pQLXqtMgPDOReokBKgZ2lKGK6adh1h5p3VcTL/qlQyrAVt0Pf
         2NGCya+ReMyD9eSNsTf5XRjbzZQGxTMtUI/gx0PXzjdXTLE3XFPAn4Heesrj39UX6zOJ
         dHEA==
X-Forwarded-Encrypted: i=1; AJvYcCV8tIIUYAU6SfmwiSZhTbxmmv2f1aYAfePdMW2HRaOzy6Lte4JO61HSbzHC8X9Pc4VQk1mhqfDHp0CrDIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nSnmIf6Wd2dlETzM0cyyrb4bprYNEYkXVyFtLZtHFJ1I9cXA
	C5fdygzo1YbSMEBQDgf8yT2tZfQdO4vbTR6bL8nTbZP0uVWCXARWkm5KH3Fapi5RlDquVNiM7v8
	cBrmovXXiHPD8iSNrxoFqdyah/RCn3Wg=
X-Gm-Gg: ASbGncvpWU1AHGs5hDbYkJWazfsZNDsL6jzQmkmf/q1ryEdYcECIhd6TzncEgLUG1W3
	sVxEsE8faAvbNhyEYcL68mO6TJb1y7tfcMzxs/VRyOFN50uTqNGB0vb8nlyHka7o4RB28/HzBBs
	RdnMHwclWE48TTa3NfZvhEElHdUQZKIYnZh4jmyHdUrN5I6mhI1uWY5pytvGZrGJ523AjaxY+pD
	3sr
X-Google-Smtp-Source: AGHT+IFDLywOhIoTBUVsoUXWMjLAi/bix2Ut3Dp8N3IqRRXkqv60tAX3F1JWBWLSzGhwiJM/NwjKVWrmeXn+BAiuCho=
X-Received: by 2002:a05:690c:8d05:b0:712:de91:53d4 with SMTP id
 00721157ae682-717b1999941mr4403417b3.24.1752011152881; Tue, 08 Jul 2025
 14:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Tue, 8 Jul 2025 14:45:41 -0700
X-Gm-Features: Ac12FXy6yZ6UCj-hjSdotBfvazCVnQYha1jcywIWZh69lrvJ-Cm7wQoK6JdoTQk
Message-ID: <CAF3JpA7yXEB_Fj3AMtFG1OYLX2g9P3LFQ5f3qSSEcheB4axVKg@mail.gmail.com>
Subject: [syzbot] [ntfs3?] WARNING in ni_rename
To: syzbot <syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000006965b2063971e29b"

--0000000000006965b2063971e29b
Content-Type: text/plain; charset="UTF-8"

#syz test

--0000000000006965b2063971e29b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs3-validate-BITMAP-size-when-index-blocks-are-pre.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs3-validate-BITMAP-size-when-index-blocks-are-pre.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcv24lot0>
X-Attachment-Id: f_mcv24lot0

RnJvbSA3ZmExZjRiMzk5YzJkNDdkMWFiMzAxYzI2NjJmNmE2MGMyMDk4YzQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogVHVlLCA4IEp1bCAyMDI1IDE0OjM5OjQzIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
bnRmczM6IHZhbGlkYXRlICRCSVRNQVAgc2l6ZSB3aGVuIGluZGV4IGJsb2NrcyBhcmUgcHJlc2Vu
dAoKUmVqZWN0IGRpcmVjdG9yaWVzIHdpdGggYWxsb2NhdGVkIGluZGV4IGJsb2NrcyBidXQgemVy
by1sZW5ndGggJEJJVE1BUCwKYXMgdGhpcyBpbmRpY2F0ZXMgYW4gaW5jb25zaXN0ZW50IG9uLWRp
c2sgc3RydWN0dXJlLgoKU2lnbmVkLW9mZi1ieTogTW9vbiBIZWUgTGVlIDxtb29uaGVlLmxlZS5j
YUBnbWFpbC5jb20+Ci0tLQogZnMvbnRmczMvaW5kZXguYyB8IDEwICsrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvbnRmczMvaW5kZXgu
YyBiL2ZzL250ZnMzL2luZGV4LmMKaW5kZXggMWJmMmE2NTkzZGVjLi42ZDFiZjg5MDkyOWQgMTAw
NjQ0Ci0tLSBhL2ZzL250ZnMzL2luZGV4LmMKKysrIGIvZnMvbnRmczMvaW5kZXguYwpAQCAtMTUw
OCw2ICsxNTA4LDE2IEBAIHN0YXRpYyBpbnQgaW5keF9hZGRfYWxsb2NhdGUoc3RydWN0IG50ZnNf
aW5kZXggKmluZHgsIHN0cnVjdCBudGZzX2lub2RlICpuaSwKIAkJCWJtcF9zaXplID0gYm1wX3Np
emVfdiA9IGxlMzJfdG9fY3B1KGJtcC0+cmVzLmRhdGFfc2l6ZSk7CiAJCX0KIAorCQkvKgorCQkg
KiBJbmRleCBibG9ja3MgZXhpc3QsIGJ1dCAkQklUTUFQIGhhcyB6ZXJvIHZhbGlkIGJpdHMuCisJ
CSAqIFRoaXMgaW1wbGllcyBhbiBvbi1kaXNrIGNvcnJ1cHRpb24gYW5kIG11c3QgYmUgcmVqZWN0
ZWQuCisJCSAqLworCQlpZiAoaW4tPm5hbWUgPT0gSTMwX05BTUUgJiYKKwkJICAgIHVubGlrZWx5
KGJtcF9zaXplX3YgPT0gMCAmJiBpbmR4LT5hbGxvY19ydW4uY291bnQpKSB7CisJCQllcnIgPSAt
RUlOVkFMOworCQkJZ290byBvdXQxOworCQl9CisKIAkJYml0ID0gYm1wX3NpemUgPDwgMzsKIAl9
CiAKLS0gCjIuNDMuMAoK
--0000000000006965b2063971e29b--

