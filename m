Return-Path: <linux-kernel+bounces-869289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00671C0789C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79B874F0F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85232F771;
	Fri, 24 Oct 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvekdrI1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1033DED3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326980; cv=none; b=hyd3aIWv5o8GBOkhhNOlJrgflchkuGCSBBfvqOiW02jK2X3S4gP/2dUjpf74KPR3oJtNGMjddFTvHKbmXKfT6rXCJG3Ujt7Tn7jKgqi6vXxyZODHCkkx6cBIZlSMwibWtUcH+fJjbNwieAP3qsz27twydjjVvd9w+4ZFyjEeI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326980; c=relaxed/simple;
	bh=tkAGkZZm4VXBDBIYaN4VChrZKvpzE6+s6VHxe8EmXVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXcnGoi8tALVsJ8BGtBkbOZylr/4elnPnDrpmFqJHVxUIdOUklQ6gTQSdcMDNdmNerxCmwPRDbBDDlVozcoqfFAqVhgWsaT4GpYzZHc2m1nxdQmMtt+T3nSxzSayCigFA83Kni19fWTEoQMc2FZ6LsmZ8cMNNKLnjmdY9HWdtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvekdrI1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78118e163e5so3151360b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761326979; x=1761931779; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cN7ZMnvf82THEzrEsUSGywR0GGJwzb8nUT5u5I/IIf0=;
        b=PvekdrI1sfGT/nnrDK/4lvinqsF0m20DVEwXO0UX9hqTyKcp4E4ARfEaUZvOvgYGQp
         jk/ZQ3LAct8fwMMLSl66z6DoLfMgmF8H9m9cEO6sxxTAeN+z8GFitULOoQ57p+b3vf4T
         tHq9PWml9e7wyq9dXJ79D6Wzm6lY8TrANZk+YaosMRIcNlMPadDItX7CbDeLlw38rmyl
         FzAwqVcv/337/WLkbtEFKPCZhTfj/nsJzp3JDSwLu/lZPgrLi3422ojpckVRcml22Fcd
         f+ccTzC3XmmBgelIAjKkLw8zk+Q7JA/ta/m5IWN+dXRuxI5FchvLRi256mQQL5a6POZn
         LkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326979; x=1761931779;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cN7ZMnvf82THEzrEsUSGywR0GGJwzb8nUT5u5I/IIf0=;
        b=A33YHDDA7acd2xGHzG3Yt+xdrC9kHq/tzcZKp4EJu1ajOFuCvjxukvUGU6TqcW4XnF
         ESjEX3uOqpbTkgCU7Et/v6TjdHw9CKMss+1QTUyLgsfOb+8xa3B6aE5wktIpnM1N6efc
         TaA1sl+3cP70Uf/TqKZt0zzMgmB5HmdnifKwH//r7vpQOVvJPjNV3Fgku3Vca317b2Zf
         ohHDgQYRFxeMLTvTSjGhTrOnWYgje4vw26Jf4wBCsqEQGxrGKTB7KUy1hrJ+ouUpvaep
         xMEit3UPDocdRkrmGltqMknMhcjdgcwRPWs0uokthsoTj3b5R4vTTCNsWFqXe9QJQAaP
         N5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWM6G+HZvvCxVAgoxZXwn76H/GpSHar+TfJCE8ZNLZuqjsKwOPMExvJtdKbP2gDY3TJcp4FQCkaPXbQeiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmVqLRxneXwkyi7pBtdzjkpoyREqk1e5M6Wx8SvbD/0zzEmkD
	+zTLADVxRndwaUs55xY8c1sfze3nN8RINwXK0gbsV7k93aC18T1+htOG
X-Gm-Gg: ASbGnctTZV+8RkE9uhOzkHePLV7ZnNRLUQMDj+pXWj5ak5u+6peo0q60UjTDeRitRVV
	OxiSrnK3eEttmCcOkNDdTpGNOWQ6ODrpx22AxuIR+iCZsXEDsuAjqhM4XuBqY18HOEoOzzRJg8x
	J8ZsKR+39doQgnt+wzHb6zBSHtOCBmzdyyejsfQk0mIGKdRQfnA7dZrUELcoqY1RVbYX7sNCx9I
	I1KInLgS8JCZ270/9Prp9U6IwbiOAvCBCRRZmYC9Fhl0mjTe18wbr14GZ+U7e3NMV7x1590Bgq4
	yig3QiBiql9iI+MgTmNSC+f+iZuBLtTGCpZ97owvK5OFSgDcF7MfrkCBGRhB5h+1/h4h5i5G+5L
	z2HeVWQ41gsK8Jytoq9vGqMKrLn5FDXp7Q1I74HYnlLToN8sfgapCd549dH4RW5DTJc+ppXNERP
	GsMefBQT7B2g==
X-Google-Smtp-Source: AGHT+IExEqGK30pExEfkyV0gBzPWyWgac7N27+lB/OIuXkwNcep/BAxe9MOY1u0pDHlpOqqViu7rWw==
X-Received: by 2002:a17:903:1aa4:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-29489d970b9mr43892925ad.11.1761326978569;
        Fri, 24 Oct 2025 10:29:38 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:8f5e:ff90:677:7d74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85e7sm61719615ad.11.2025.10.24.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:29:38 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Subject: [PATCH v2 0/2] checkpatch: add checks incorrectly initialized
 pointers with __free attr
Date: Fri, 24 Oct 2025 22:59:14 +0530
Message-Id: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGq3+2gC/5WNQQ6CMBBFr0K6tqZTg6gr7mFYDGVKJ0IhLTYq4
 e5WbmD+6v3Fe6uIFJiiuBWrCJQ48uQz6EMhjEPfk+Qus9BKl6A0SHRESRpH5jHjYpx8eva8MA7
 8oU7aQCRLc7raqiRQCCKb5kCWX3vl3mR2HJcpvPdogt/7nz+BzLvYVkFrzlhh3Y/Iw9FMo2i2b
 fsCM2iMA9YAAAA=
X-Change-ID: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=tkAGkZZm4VXBDBIYaN4VChrZKvpzE6+s6VHxe8EmXVs=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ+b69OE5hxadfN1B8RE+/t1/v38+M+v2mXV02b+ibwy
 RTbqltrGDpKWRjEuBhkxRRZGEWl/PQ2SU2IO5z0DWYOKxPIEAYuTgGYSN98RobrNh8nPlTt+yIv
 o7H05CzFCQ90xZUdSmK0pRZt61+9/ZYFI8PGVKNg1e3zBZY/XzH5WdJnhja9wN7oZ1abNCadFDc
 4ocEGAA==
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Badly initialized pointers with __free attr can
cause cleanup issues. So,

Adding checks for
- uninitialized pointers
- initialized pointers with NULL

Testing:
ran checkpatch.pl before and after the change on 
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers

---
Changes in v2:
- change cover letter and title to reflect new changes
- fix regex to handle multiple declarations in a single line case
- convert WARN to ERROR for uninitialized pointers
- add a new WARN for pointers initialized with NULL 
- NOTE: tried handling multiple declarations on a single line by splitting
        them and matching the parts with regex, but, it turned out to be 
	complex and overkill. Moreover, multi-line declarations pose a threat
- Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com

---
Ally Heev (2):
      checkpatch: add uninitialized pointer with __free attribute check
      add check for pointers with __free attribute initialized to NULL

 Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
 scripts/checkpatch.pl                  | 13 +++++++++++++
 2 files changed, 24 insertions(+)
---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


