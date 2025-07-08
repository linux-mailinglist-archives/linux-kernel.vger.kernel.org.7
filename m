Return-Path: <linux-kernel+bounces-721190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB2AFC5EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6863A824D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58F2BE03D;
	Tue,  8 Jul 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbAJxTN8"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE22BD016
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964009; cv=none; b=a2Dk8zoe+gqVoyfM1SdUWeu089rU6WGQ6xVqFbi3zD2AHuCMr2cXB4/ZKBb9Yh2ribyQ0J2zueBZWUSVJq5ujJP2jEmd12Ru1991OnulPQaixMTbHzkU7kz8rqi7681H7e0nKzU7fKzrfRp3mjWvw/GgzFGfSRmAwkh+D2/agr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964009; c=relaxed/simple;
	bh=oaSnugCEdeQcBT4v6FEIbhEgdiJTD1Msrq8MfPMc5iU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mmTIOHu2+c46EGFq9ivQw2xbUyk8XGHf2R5XsowFivP6eR8H/ftUZiymxPYuarvtl5TkS87wriZRY/VC3Pi5AOkI8K//n6Ivvgs0w5XPHUUXcfmbwg1AU6DWG4t7HIvv+phMj3upJqXtbVAf9QyzDA8i2N4TDL9fuKlYT89s2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbAJxTN8; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-716ee8947cdso29784127b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751964007; x=1752568807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gl0QAD/tbVzDvZuawsafKO1HsSUYi+swaKefHPvsCQM=;
        b=RbAJxTN8gBlzBf1fz+cmn1hLmFTtiOf2kz/KgisDZ8Dp1yDyRLXialPr2w/U/HR0hH
         aA58jewsDljlwBRVz6L3EjzqoWhQy83SGtesCBgbKoRBCRWIgcHoDbJyxmtjJyuk9b1k
         rTYsdxet+roIIDIwxE8tbZ4Y5FlnU3HWF1Q650WARoR0sNceu6G2WYz9ah3ZNneSK266
         fLrMVaKUO+0fNn/4X6HKpVhCbprfv0TVzgax2dE8JT8HgqmTzRPyGeVSQ5tTaSghxRVw
         ljfx1KkhEPAvMuIeYrWlPKLYc9omaE59N2rRQOIQoCTHzBHcHp/Q5ah+YZJUf8HRB0Jr
         /wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751964007; x=1752568807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gl0QAD/tbVzDvZuawsafKO1HsSUYi+swaKefHPvsCQM=;
        b=t6FxNdATGPsNuYWqdtQOhVyNpXqgJRi8qA1OnS18B7dujXS4UPw0E3/oHUacyibj+a
         ZHtkrUb6kd7x36vXeIqW8uQlzXYLHMmBCTo5V7PfPYYkYlJ9umn96BJ3aqZbPxJMhxax
         XSW3drLjybexkOS9pXYwRvPodMsN7VfLYoaoEUg3W8GWJywXgokWri+l5VEZV00iwlDA
         51yFl2A9vzdcIqKbDkdsTuiYWUUdyUoKDwR2F6xQrPE04jA8v5ud1fED9MQd1wob4ImO
         SGLlO4c6ebL79FyaM6X/TyqKYirBRnf60vAMNkKpKY+yEGu5aZqNrrGtxDXq5tyAVmE5
         d1hg==
X-Forwarded-Encrypted: i=1; AJvYcCUoxofiOZFmyMEycnJ5WiyRPlNtDezjWwbaPoNONSaFfbVnFyzq7WcZ8/Lnpx9Zg6oxGtVqy+GPfmnGW3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRaaZz8peQG6VkKMn1hr1Fwcvj4rKg+8HTQWIDDe4osjlBr97
	+TJL9vJN8SVkXZEbSd3O+4xRHfpTxW6p/3ct1VZNjWgWNbaMS9J23WJHHvu9AEnoa0W5plvNdzb
	ROgfiMeDTtBciFX8xDbGK8jxd3pSIKRk=
X-Gm-Gg: ASbGncvc5A1nWbnbAchbqFxx/J8NA3nCrb1d7jcQfA9dO5xI2cCvNVXNQ7z3UPul2gW
	2F/dKTvJrHEiVSXWPePhsqjWA2XL99Wq8V+7dLJBiNgdZv0UTnuQcsv2wuUWwXxKEinCWi8d0MR
	IqXJox9mSNV99tFS3LQz5k4+SK/8nY91ez4RC5ialc6W4nDAC73/Waz1l9wDuPQXjNaMhnfGm3U
	f8k
X-Google-Smtp-Source: AGHT+IFVSqFV+JHejEaMrQ/AcobiDs3n3dnlQorVuoAZYAXAjM1srOc9PMjjID6k+C5uO2bRlqNjtZJkfHvqbDsFdLk=
X-Received: by 2002:a05:690c:60c1:b0:70f:83ef:ddff with SMTP id
 00721157ae682-71668d47390mr217482997b3.30.1751964007285; Tue, 08 Jul 2025
 01:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Tue, 8 Jul 2025 01:39:55 -0700
X-Gm-Features: Ac12FXzBCT5EBKeLYS0vb_uaT7F7BBoWv3Jo27oObiDeVLb3zges4wxI2j_RbzA
Message-ID: <CAF3JpA5UK1iRiHTbPZNej5izQZNVwi3phN5f0pzCzadqn7K0+Q@mail.gmail.com>
Subject: [syzbot] [ntfs3?] WARNING in ni_rename
To: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000507a1d063966e8b7"

--000000000000507a1d063966e8b7
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000507a1d063966e8b7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs3-reject-zero-length-BITMAP-when-index-blocks-ar.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs3-reject-zero-length-BITMAP-when-index-blocks-ar.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcu9wgkq0>
X-Attachment-Id: f_mcu9wgkq0

RnJvbSBhN2U5NGFkNDk1OWU0NmFjZjM4NjFmYTBjNzI1YTJkMGMzMzczZWJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogVHVlLCA4IEp1bCAyMDI1IDAxOjE3OjEzIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
bnRmczM6IHJlamVjdCB6ZXJvLWxlbmd0aCAkQklUTUFQIHdoZW4gaW5kZXggYmxvY2tzIGFyZQog
YWxsb2NhdGVkCgpBIG5vbi1lbXB0eSBpbmRleCBhbGxvY2F0aW9uIHJlcXVpcmVzIGF0IGxlYXN0
IG9uZSBiaXQgaW4gJEJJVE1BUAp0byB0cmFjayB1c2FnZS4gUmVqZWN0IG1hbGZvcm1lZCBvbi1k
aXNrIHN0cnVjdHVyZXMgd2l0aCB6ZXJvLWxlbmd0aApiaXRtYXBzIGFuZCBhbGxvY2F0ZWQgaW5k
ZXggYmxvY2tzLgoKU2lnbmVkLW9mZi1ieTogTW9vbiBIZWUgTGVlIDxtb29uaGVlLmxlZS5jYUBn
bWFpbC5jb20+Ci0tLQogZnMvbnRmczMvaW5kZXguYyB8IDEyICsrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9udGZzMy9pbmRleC5j
IGIvZnMvbnRmczMvaW5kZXguYwppbmRleCAxYmYyYTY1OTNkZWMuLjE1ZjNhNzExZWEwYSAxMDA2
NDQKLS0tIGEvZnMvbnRmczMvaW5kZXguYworKysgYi9mcy9udGZzMy9pbmRleC5jCkBAIC00Nzgs
NiArNDc4LDcgQEAgc3RhdGljIGludCBpbmR4X2ZpbmRfZnJlZShzdHJ1Y3QgbnRmc19pbmRleCAq
aW5keCwgc3RydWN0IG50ZnNfaW5vZGUgKm5pLAogCXN0cnVjdCBBVFRSX0xJU1RfRU5UUlkgKmxl
ID0gTlVMTDsKIAljb25zdCBzdHJ1Y3QgSU5ERVhfTkFNRVMgKmluID0gJnNfaW5kZXhfbmFtZXNb
aW5keC0+dHlwZV07CiAJaW50IGVycjsKKwl1NjQgYm1fc2l6ZTsKIAogCWIgPSBuaV9maW5kX2F0
dHIobmksIE5VTEwsICZsZSwgQVRUUl9CSVRNQVAsIGluLT5uYW1lLCBpbi0+bmFtZV9sZW4sCiAJ
CQkgTlVMTCwgTlVMTCk7CkBAIC00ODgsNiArNDg5LDE3IEBAIHN0YXRpYyBpbnQgaW5keF9maW5k
X2ZyZWUoc3RydWN0IG50ZnNfaW5kZXggKmluZHgsIHN0cnVjdCBudGZzX2lub2RlICpuaSwKIAkq
Yml0bWFwID0gYjsKIAkqYml0ID0gTUlOVVNfT05FX1Q7CiAKKwlibV9zaXplID0gYi0+bm9uX3Jl
cyA/IGxlNjRfdG9fY3B1KGItPm5yZXMudmFsaWRfc2l6ZSkgOgorCQkJICAgICAgIGxlMzJfdG9f
Y3B1KGItPnJlcy5kYXRhX3NpemUpOworCisJLyoKKwkgKiBBbGxvY2F0ZWQgaW5kZXggYmxvY2tz
IHJlcXVpcmUgJEJJVE1BUCB0byBjb250YWluIGF0IGxlYXN0CisJICogb25lIGJpdCBmb3IgdXNh
Z2UgdHJhY2tpbmcuIEEgemVyby1sZW5ndGggYml0bWFwIGluIHRoaXMKKwkgKiBjYXNlIGluZGlj
YXRlcyBhIG1hbGZvcm1lZCBvbi1kaXNrIHN0cnVjdHVyZSBhbmQgY2Fubm90IGJlIHVzZWQuCisJ
ICovCisJaWYgKHVubGlrZWx5KGJtX3NpemUgPT0gMCAmJiBpbmR4LT5hbGxvY19ydW4uY291bnQp
KQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCWlmICghYi0+bm9uX3JlcykgewogCQl1MzIgbmJpdHMg
PSA4ICogbGUzMl90b19jcHUoYi0+cmVzLmRhdGFfc2l6ZSk7CiAJCXNpemVfdCBwb3MgPSBmaW5k
X25leHRfemVyb19iaXRfbGUocmVzaWRlbnRfZGF0YShiKSwgbmJpdHMsIDApOwotLSAKMi40My4w
Cgo=
--000000000000507a1d063966e8b7--

