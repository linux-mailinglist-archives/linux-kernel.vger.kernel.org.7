Return-Path: <linux-kernel+bounces-837097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E36BAB5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EAD3B8456
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E35222560;
	Tue, 30 Sep 2025 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqh1Spw4"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE51A8F84
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206753; cv=none; b=qrcF7tLfElsih12meWdKjVdcIIL0NH5VWHvTYRcunFfvAx60iDmAYhGV6kELT6nxFGU4DNbX/niav9gF3iUyCTm8AlQsrqUg4VSNvmFN7chIiNrmkIzzuvsGjskJxD4tSMUTDLkc/cuQcVCc+4MkdA9o9SqAKm1UtYMA8nr34Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206753; c=relaxed/simple;
	bh=nLjWEJD97PeloJrzZfbJeqrPhzT3J7eGfmtUB+dVTA4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JxZoq2bVA42I3MABHIuWPupNCt3gRlYqkJbEv8e4L3UWc9xw43jgp9x3v2gQ4WgB6YQtj75ixXIXyMy4mdJ4dD7g90AmeY/eR6xAM/GhIEDB+Ei0v4ybiiq8w9eNs53jWzAL91aj0vzXYA+sKo0ywJYtqbONgmk8fdzZzujUsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqh1Spw4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-791875a9071so52907996d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759206750; x=1759811550; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WgZ47FHYrkPs9ome0mL+EFV01cLMrq/ww7wFzIArpC8=;
        b=nqh1Spw4hzpc/qfhCVtuuu0hTN6DoU5cRheTdb+s6X9uwdHHLzNGJI1t866J7yA5f0
         y+hHQk/IlWZfpGFiiyZhLrhA+SEFYg9qqD7P8whzKTyKb0wqqg22Ozp1BeGjuWEtUgx4
         CTCMeE5XgKpn9H7Bh1sXMNw5ur/yz+TDY57hdRRk3+HNIzqNnCcrUfqfz8gmJAo0WL2I
         l6MpiU2jmMRCWqDdTQUy3ITQpJ5YI27n7PIRqhcezvO9WcUM5HGE0fi9BXOr8TOaud4y
         PvF3d6/RQKqDEthMGpuFrGFUGs3pSzUExcnlPpmaAAsl726x3UHCg+6JidWf0X6mQVAD
         jYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206750; x=1759811550;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgZ47FHYrkPs9ome0mL+EFV01cLMrq/ww7wFzIArpC8=;
        b=niPoYHbuXsHAtw3hOt5re/aqXo+Fz2PXPEOwIfOzueppMfZ1TXoFxWwnjab4dhrJwE
         JdzitvuBagWuyZH3fucZemHBKKa0dQ/8TUfRX7a/Zb/rNkUDzbBkm15+dZIXAiy2Ib0O
         Kw882LNvzfYPBtrQKh/56ElOvck/G25505RhJRX/die2vgCWclUwqoDi/5BAQFgLKdLf
         lDbhONYu6xIPq3Sgm+/Q3t4T8qhCYyM4ABvYPDrIJSKSJ3KC+sPjXHn+9PqRb5PnswpX
         oW/ZOApGfL34MU+rlrtwwD4pEwT6rMBd2TLBoWo930kaYs68FjJdzue1RlZ7OTi8AiPc
         idjw==
X-Gm-Message-State: AOJu0YxlvDbiJ7h27b0GoLshaf1XdqArwhs30lzNE+vKDOaSt5bEaJzl
	7Hti06P25g0CPZXeW50Ae/2GUC1AdnBnv4XI1Ayf3rayOymWCI5UbrcjlvqVPtbEKkG7DPrLOhy
	upyFVNABj9C/dVZOw13Vc+ScnrB8v5qrcufUJ
X-Gm-Gg: ASbGncuRe35py7z67BsrIAt/xXgedsRPr8PFPD30ichQftbLgXPSvERjawGU7dIrGBL
	qTamONE3Fiyc1FYg36cXptculmqyAvQXyDAEZgRDyK+siPC9BI4O2n+40zXYRXXmRoL05qNI8/v
	b/Exk1bD080pv2AGyhUfHPjFgtawFQtLvtUJXa0IMvOzaxGaHLXTVCOyPFPkSqGXfJy7yQ7zEjO
	YTh4HOP5NmBkfCEHEWJ24/+8cs5P6Fs3/y0xe5uNWnETwXW4wXZtHEeg2wjGUonYzb4dRpyzo+4
	PGBOdosOcG7213dY+rKTAaM1v/aasf/wur5Cb7s8eKZqWogwENTL6jIuZSpHVOvEcjobGIMWo2q
	wX/gH6YrhEw==
X-Google-Smtp-Source: AGHT+IGMz1DsumvabSJN7g3G6NuGNXDLPHMRCenwL/bJSrjzDPUdNbMjQlYpKzbFt7lGKC+ddNDBNKQBXd4rn/wDX90=
X-Received: by 2002:a05:6214:d8c:b0:78e:8e52:e5fd with SMTP id
 6a1803df08f44-7fc2cb84f27mr266433626d6.29.1759206750476; Mon, 29 Sep 2025
 21:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 29 Sep 2025 23:32:17 -0500
X-Gm-Features: AS18NWArqFoBFHwZLdeyPwDx1kX-6fwlwOon1nM8Yl95ydrDCS3v-rbRgzWW4sc
Message-ID: <CAH2r5ms6vsZ7VrL2DSLXPcWOS-wcp_h5rx6qBMfb9HFcS=7eYQ@mail.gmail.com>
Subject: [PATCH][SMB3 CLIENT] fix bug with newly created files in cached dir
To: LKML <linux-kernel@vger.kernel.org>, Bharath S M <bharathsm@microsoft.com>
Content-Type: multipart/mixed; boundary="00000000000072fc9a063ffd3d8b"

--00000000000072fc9a063ffd3d8b
Content-Type: text/plain; charset="UTF-8"

Any updates/feedback/reviews on this fix from Bharath for generic/637?

commit b10a51be25c2df37579ac5d39a4e9be47773b42c (HEAD -> for-next,
origin/for-next)
Author: Bharath SM <bharathsm@microsoft.com>
Date:   Fri Sep 26 10:13:50 2025 -0500

    smb client: fix bug with newly created file in cached dir

    Test generic/637 spotted a problem with create of a new file in a
    cached directory (by the same client) could cause cases where the
    new file does not show up properly in ls on that client until the
    lease times out.

    Fixes: 037e1bae588e ("smb: client: use ParentLeaseKey in cifs_do_create")
    Cc: stable@vger.kernel.org
    Signed-off-by: Bharath SM <bharathsm@microsoft.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index bc145436eba4..a233a5fe377b 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -329,6 +329,7 @@ static int cifs_do_create(struct inode *inode,
struct dentry *direntry, unsigned
                                               parent_cfid->fid.lease_key,
                                               SMB2_LEASE_KEY_SIZE);
                                        parent_cfid->dirents.is_valid = false;
+                                       parent_cfid->dirents.is_failed = true;
                                }
                                break;
                        }


-- 
Thanks,

Steve

--00000000000072fc9a063ffd3d8b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0016-smb-client-fix-bug-with-newly-created-file-in-cached.patch"
Content-Disposition: attachment; 
	filename="0016-smb-client-fix-bug-with-newly-created-file-in-cached.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mg629blw0>
X-Attachment-Id: f_mg629blw0

RnJvbSBiMTBhNTFiZTI1YzJkZjM3NTc5YWM1ZDM5YTRlOWJlNDc3NzNiNDJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCaGFyYXRoIFNNIDxiaGFyYXRoc21AbWljcm9zb2Z0LmNvbT4K
RGF0ZTogRnJpLCAyNiBTZXAgMjAyNSAxMDoxMzo1MCAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggMTYv
MTZdIHNtYiBjbGllbnQ6IGZpeCBidWcgd2l0aCBuZXdseSBjcmVhdGVkIGZpbGUgaW4gY2FjaGVk
CiBkaXIKClRlc3QgZ2VuZXJpYy82Mzcgc3BvdHRlZCBhIHByb2JsZW0gd2l0aCBjcmVhdGUgb2Yg
YSBuZXcgZmlsZSBpbiBhCmNhY2hlZCBkaXJlY3RvcnkgKGJ5IHRoZSBzYW1lIGNsaWVudCkgY291
bGQgY2F1c2UgY2FzZXMgd2hlcmUgdGhlCm5ldyBmaWxlIGRvZXMgbm90IHNob3cgdXAgcHJvcGVy
bHkgaW4gbHMgb24gdGhhdCBjbGllbnQgdW50aWwgdGhlCmxlYXNlIHRpbWVzIG91dC4KCkZpeGVz
OiAwMzdlMWJhZTU4OGUgKCJzbWI6IGNsaWVudDogdXNlIFBhcmVudExlYXNlS2V5IGluIGNpZnNf
ZG9fY3JlYXRlIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQmhh
cmF0aCBTTSA8YmhhcmF0aHNtQG1pY3Jvc29mdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZy
ZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY2xpZW50L2Rpci5jIHwg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9mcy9zbWIv
Y2xpZW50L2Rpci5jIGIvZnMvc21iL2NsaWVudC9kaXIuYwppbmRleCBiYzE0NTQzNmViYTQuLmEy
MzNhNWZlMzc3YiAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9kaXIuYworKysgYi9mcy9zbWIv
Y2xpZW50L2Rpci5jCkBAIC0zMjksNiArMzI5LDcgQEAgc3RhdGljIGludCBjaWZzX2RvX2NyZWF0
ZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZGVudHJ5ICpkaXJlbnRyeSwgdW5zaWduZWQK
IAkJCQkJICAgICAgIHBhcmVudF9jZmlkLT5maWQubGVhc2Vfa2V5LAogCQkJCQkgICAgICAgU01C
Ml9MRUFTRV9LRVlfU0laRSk7CiAJCQkJCXBhcmVudF9jZmlkLT5kaXJlbnRzLmlzX3ZhbGlkID0g
ZmFsc2U7CisJCQkJCXBhcmVudF9jZmlkLT5kaXJlbnRzLmlzX2ZhaWxlZCA9IHRydWU7CiAJCQkJ
fQogCQkJCWJyZWFrOwogCQkJfQotLSAKMi40OC4xCgo=
--00000000000072fc9a063ffd3d8b--

