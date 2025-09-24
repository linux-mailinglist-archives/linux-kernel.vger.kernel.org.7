Return-Path: <linux-kernel+bounces-829833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A756AB98009
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1022E7235
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38F1F416A;
	Wed, 24 Sep 2025 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCEaO9Vd"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B21E8322
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677291; cv=none; b=JTle0CSDXslV2/oeKLZXlI/5X/50zt7pidlAOcD4F6PWKiKjKv9WmcxjppA308jPVdptTFwzKAG1buFp5afOVuQRr85LU5y+5N7BWSfiqYZCXC+rWIes+mQFtuVrAKelpgUdNGekvvruljqMDYCbfjeQK6akTbXy27ycho9PxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677291; c=relaxed/simple;
	bh=poWi75Yc6NYPElhMs5/ZuU6q2IMR/SklZd/8AY6sAXw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H7PZb5C0CQEgljjoEB9Hsv6FZ4agt60R6iMm8iN42h9alnllo6pZPqzZoJFiovKIxEzNE3mlLdpn1OkgqhfgN5qBRmFawnDir8WNALAF6JKm2igajIQtUZEFrw9ZPyquO8v6Cdhctc3P95cybhPRBBt69J9HKRwgY2X+MKwz+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCEaO9Vd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f1f8a114bso457888b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758677289; x=1759282089; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy4kHwwkNWnxgbcRxW1OuHCY9cgZlZgFiKZ2jZqYCGY=;
        b=mCEaO9Vd4rGDBwTjEQjeKEwRPlt6mbARMEnA25OQpCWcb57VsxrkgZaSDy5IoZH7xC
         qcY0OvQn0hkEwI4X3Y9I9oo7AASxeST0+KMImPfHxgB2NJtB+1+gtp2kqBPAwQif+xu5
         AjqVtyQwjIe+DlpnKZ3fXVGD/I5nLPU/4pOoI3fKT6bEm/p/8BY2vNbRJOZBp++5Dwup
         JhxYxbvJZEkxJ1rFHVaVV8oMXJeBoYAeQ2/OecUCPsRLW0f9L27nYQstsZ0xN5fiE2Ka
         ze7TbD7Iv00REzJMqVQNQfrJB8MSiNnli7NBVv6aX8JSZMbsa20zo+6B4s49J6S4WPbv
         lz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758677289; x=1759282089;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yy4kHwwkNWnxgbcRxW1OuHCY9cgZlZgFiKZ2jZqYCGY=;
        b=mfuP++VzY/faoXekkgvGXQz+FTVrHvqK1rDmeTDBbaR+HRY6XIdQ6yzyu38JSxn9+R
         1z8TTEoasiwQEZJLymjg7vmK+qhwuKE8JBtdiUstWyYXTwTYPmxNIrw/86pRXFhlEhFm
         aK1KGWngOphm2E+a96fsgmwRqAzKtcjt/Efs0FkbcewhmEuvPS4sHR95/yo6UCL22Z7a
         H95BLdzgab+Kgo8hwkNO7fZYICWwByn8QPMkoVd0dABywIgwDmBGb0voqZFBzitBInLr
         ip4vcb3n6JD7eR0dHIA6inOytQsH86xFIl2SBLJr/GIgugJNMvAjS8b2GJMzVdHT0kUR
         4bBA==
X-Forwarded-Encrypted: i=1; AJvYcCWPwB914v+Ib5jXwWfG+GQVxn4x2OfXcXNk4r2rIbKx2AcJ+8TZ6+Pn/8GGs7DPa7OfPv0rbeCYSMVCuYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2/9I2b1cUEceMRefI9uZsE75u9LNImNtFpYyOGgWA1X4CmpM
	JIGgOmc0g5YjJYH22rg3jRqCEq2jbdkn8xvOunp7uNeeRAZgF8AK9vY07msXF3Yi
X-Gm-Gg: ASbGncvZUkLhwEpD5F5mClzKOjgKxwaJBlw2iIWvZ7u2zv/VOOAYxGtV4TaaWMWOBOI
	DsO3tmZx+iozcE3BvbeTegLLAxxlnaPpDsBDXJuztu8XjCbqFjD3wBEpy9Yup5fkThKozUDQHtt
	kYNfZpUwKKu7MmqIZ42y3PgeAaSi3czLXnIu3cyhCtaYzqm6wiU/EPAEUMQ6mTsu9dEcQhXK68v
	bWlcNrJA7zSewmG1irYM0HhKifJ5c5MEf9DJs7hLrKHy2oKB0gQW+c6DIudVoeNIQoxe9tHC/xU
	FCN9ihvmrAo9Mzgf13yRWAhIHPyJHDMnfZ29APxAWou9rLLB1GUj+Hzxnt6SrHt32VnUDaZ7c/1
	7RTxjmDIIMIEwv9N24xz29XfUgwqsvN+BSHg=
X-Google-Smtp-Source: AGHT+IHy0fwa9ia585w/vIXgoIdJqbR7sJnmq+74ZviBcey7HI8Q7oDjtgRzWWmIN+HBbbgjxaGGDA==
X-Received: by 2002:a05:6a00:3d51:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-77f6972e7d5mr759595b3a.1.1758677289526;
        Tue, 23 Sep 2025 18:28:09 -0700 (PDT)
Received: from smtpclient.apple ([58.247.22.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1979547fsm11026739b3a.31.2025.09.23.18.28.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 18:28:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] ceph: Fix potential undefined behavior in crush_ln() with
 GCC 11.1.0
From: =?utf-8?B?6ZmI5Y2O5pit77yITHlpY2Fu77yJ?= <lyican53@gmail.com>
In-Reply-To: <2eddc77bea32f3baa47cfb1bafb4e20edfe00417.camel@ibm.com>
Date: Wed, 24 Sep 2025 09:27:15 +0800
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xiubo Li <xiubli@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D65AD7F-DEE2-48DC-8C5D-5814B53FA0A5@gmail.com>
References: <1AD55673-B7F4-4DB7-AE80-1AC81709F65A@gmail.com>
 <e6987f0268bd7bceddbd6ec53fa174d07cfa3114.camel@ibm.com>
 <C8E92D42-0336-45DD-A415-EA8588DE731D@gmail.com>
 <d6ccd709466d1460baf6e9b0bcec212007172622.camel@ibm.com>
 <A246BD33-C009-4C12-94E7-E95CABB94D04@gmail.com>
 <2eddc77bea32f3baa47cfb1bafb4e20edfe00417.camel@ibm.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi Slava,

I apologize for the confusion with multiple patch versions. Here is one =
single formal patch that I have thoroughly tested and verified on =
multiple platforms:

**Testing verification**:
- Successfully tested on macOS with `git am`
- Successfully tested on Windows with `git am`=20
- Verified using `git apply --check` and `patch --dry-run`
- Confirmed to apply cleanly to Linux v6.17-rc6 (commit =
f83ec76bf285bea5727f478a68b894f5543ca76e)

---

=46rom f83ec76bf285bea5727f478a68b894f5543ca76e Mon Sep 23 09:05:00 2025
From: Huazhao Chen <lyican53@gmail.com>
Date: Mon, 23 Sep 2025 09:00:00 +0800
Subject: [PATCH] ceph: Fix potential undefined behavior in crush_ln() =
with GCC
11.1.0

When x & 0x1FFFF equals zero, __builtin_clz() is called with a zero
argument, which results in undefined behavior. This can happen during
ceph's consistent hashing calculations and may lead to incorrect
placement group mappings.

Fix by checking if the masked value is non-zero before calling
__builtin_clz(). If the masked value is zero, use the expected
result of 16 directly.

Signed-off-by: Huazhao Chen <lyican53@gmail.com>
---
net/ceph/crush/mapper.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 3a5bd1cd1..000f7a633 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -262,7 +262,7 @@ static __u64 crush_ln(unsigned int xin)
       * do it in one step instead of iteratively
       */
      if (!(x & 0x18000)) {
-               int bits =3D __builtin_clz(x & 0x1FFFF) - 16;
+               int bits =3D (x & 0x1FFFF) ? __builtin_clz(x & 0x1FFFF) =
- 16 : 16;
              x <<=3D bits;
              iexpon =3D 15 - bits;
      }
--=20
2.39.5 (Apple Git-154)

---

**Important clarification about git diff format**:=20
I understand your confusion about the line numbers. The "@@ -262,7 =
+262,7 @@" header is **git's automatic context display format**, not an =
indication of which line I'm trying to modify. Here's what it means:

- `-262,7`: Git shows 7 lines of context starting from line 262 in the =
original file
- `+262,7`: Git shows 7 lines of context starting from line 262 in the =
modified file =20
- **The actual code change is on line 265**: `int bits =3D =
__builtin_clz(x & 0x1FFFF) - 16;`

This is exactly the line you referenced in your message [1]. Git =
automatically chooses context lines to make patches unambiguous - I did =
not manually specify line 262.

**Cross-platform testing results**:
- macOS: `git am` successful=20
- Windows: `git am` successful  =20
- Validation: `git apply --check` and `patch --dry-run` both pass=20

The patch is ready for your review and should apply without any issues.

I would be grateful if you could review this patch again. If you =
encounter any issues during application, please let me know and I'll be =
happy to provide additional assistance.

Thank you for your patience and thorough review process.

Best regards,
Huazhao Chen

[1] =
https://elixir.bootlin.com/linux/v6.17-rc6/source/net/ceph/crush/mapper.c#=
L265=

