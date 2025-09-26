Return-Path: <linux-kernel+bounces-834723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0EBBA55D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833D2387C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A629D28F;
	Fri, 26 Sep 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWKny/ht"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D412877D3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926770; cv=none; b=b867oAdXWZQ4/qXSGhJwpj0JroW9fnckqF3EekZOsjTtiGl3IdsdsQ0YRH+6AS13k+Jwa4oDmW6BdXz+nbGsCiAHZiE7RNAfgGAGv0lDLb9Ri5hHgMbl1DlY2g+7U4Yd3y995CwkCufnvf3JSmt1HdPcbsFp6IwIh2bag78S4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926770; c=relaxed/simple;
	bh=aVLAvDuzjvZUq4o1w0WdiuksjsM3bmOCj0ux9RfpkFc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=D+ssjnQYPPWEW6igA8TvWp87Z3pdcJwPeJFxO7v1//QcLQa8CenW2HBzUV3V/LyRf6MJ+ZSMmeRnJWk2whonvjGCjSufn+AzTx3my4L054EnWASqylIR6a43F1TZ/xAK6rqpKCcU9hk66RgFsj5cjl/bBDpjz+gk5QEO00Damy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWKny/ht; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634bc2d6137so2050628a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926767; x=1759531567; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0XcUmbDIm9A8aHJ2IMOdtvaZQ6t8E9f+KkDqK772Fo=;
        b=ZWKny/htVsoqKThzah9+H/u+WP8YCFrb2pjPVyf7/dUPkFajLRlMqoK/c5zwIDyNPa
         b1MlIPsARVIitkGP80665CUXy6iN0XMBnsbFy0ALRlTwGj5UfbeVxqBxQe/tdp/8TpVv
         OaUVt4fRl2OKgcF9hMzOvVB+fgborAELlqFqDjCTXgbNLwFlCt/TbXDWC+4qW085obDz
         GqObzWJzpBucKLGDZketQ3GhTXBHHAnxKG9b6m361ZM/xDYLpg2p6Vxqxp0kd1goeZRO
         k6fE+QIkiGr3n/eK7Q8BVZIFEIWBZTvLO27D2mzixTtmuKO1k2MkppS3AwvI3PkwVoYU
         snjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926767; x=1759531567;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0XcUmbDIm9A8aHJ2IMOdtvaZQ6t8E9f+KkDqK772Fo=;
        b=jLKU/GkTRIUpPLaegNwPJt2IK0mwxm8KWvf5fWFjRYNdJyCm26iRBit3PFBHLNB6oU
         mNDVwQVS5+BRCiUne3IxZI9sowBV0teAD890ZGZ8K+nWr6x0nCxON1vxz8/+8bZRvH/Y
         aa50MwsDO4EsC+fbDw9I+kJtU/yDRGPRdwL3kfC4gCFrxMqJ691LfXhe0VVUn64BiRjM
         0qzUhgpARyKReuzt5b+pV79SCXxHnOO9bTpUrk81XdiUlxXeeL78aobILIrhVuW1b+AL
         Cp8cIsb+zkylX/FfcGr27p26KBItkUfQGOW2lqmbaVyNncsRmi7fMwuUmYDAR1E+lqlI
         NzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNaqzjkTl7+miJg2vwlX9zmfNA/cvJMCpqrd8/xAPGmkdqVmraNs9MKR5uEhpGziNf4qJvkwr6QjmbkbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZDCYPAyi0T4ALAkZuaLdvSW9IUuXW+E/2AHxmZXW4rhjAIVC
	EzO3xMVyhT90eY6R8bmJx+Co6kB+xEiVp5Y6vXx1PCGz/MEyZ3v1EksScyZlxfNI7A==
X-Gm-Gg: ASbGncuZJo+KPUB5e/xi536Yenzi2dRX/XW0ZqblVao+jKhCmG6JDKnD6TvrwRVjjaZ
	b/scWx+k1wj0Ns7eGywK6/CKkcBXM+32YFCN6aaqqtZj5bhBUCQKGKJgnqr0MmJFtUSGOzj3CkB
	YjrVjUvDtgRgWe5DSSiqEPjBYGyijl4T/+vvSMpawRe4S1Ljpt5Z7jmXydOKoYKfu6WItf9cmqt
	hGQ6hTZOCA3LIMYSCOl1YxzLlTINxnTDwYF9bupRyUHOaPliLzlPJrtxktym7ksncGh3a2vF52i
	IQVFLkkWkficSXktBjszc1J1IbokD0NzdhKEwK9B9NmrArFxFRxiQU+E4B9RXudbcOM2DDLTv1U
	9gnJ64JXloKaqh/IMOf2xxWPl5jmzMwh719ulFtcwK8K5o7WtIfi24yDBlM6JmCoGLw9IaxaT2q
	+6S8LO8QWHsB82EsargQahLsBorCOxKJyAdmFOHcd9+tEqZsQ7R7FOwL1rF05GFbI=
X-Google-Smtp-Source: AGHT+IEgUt5ke5XNe6uNWf2k/utNyZVhDSWziVn5R9T8tXuQhiIvIALdk0ct3EdeGF/jA1gp8kFcMg==
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id a640c23a62f3a-b34b6449b22mr908248066b.5.1758926767146;
        Fri, 26 Sep 2025 15:46:07 -0700 (PDT)
Received: from smtpclient.apple (2001-1c00-3b81-9100-e596-dd7e-500a-9b8c.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b81:9100:e596:dd7e:500a:9b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7506sm443091466b.52.2025.09.26.15.46.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 15:46:06 -0700 (PDT)
From: Aniruddha Deb <aniruddha.deb.2002@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: [BUG] linux/arch/x86/events/intel/uncore_snbep.c: MCx Channel PCI
 devices are swapped around
Message-Id: <AB0DE99B-34C1-4BDC-B9C4-15E85BDBF5FA@gmail.com>
Date: Sat, 27 Sep 2025 00:46:03 +0200
Cc: linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: acme@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 namhyung@kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Hi perf subsystem maintainers,

The iMC PMC=E2=80=99s in the haswell-EP subsystem have their PCI device =
ID=E2=80=99s swapped around. According to page 109 of =
https://www.intel.com/content/www/us/en/content-details/671052/intel-xeon-=
processor-e5-and-e7-v3-family-uncore-performance-monitoring-reference-manu=
al.html, MC0 channel 0 and 1 map to 0x2fb4/5 and channel 2/3 map to =
0x2fb0/1 respectively. Have attached a small patch illustrating the =
same.

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3118,32 +3118,32 @@
 	{ /* MC0 Channel 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb4),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 0),
 	},
 	{ /* MC0 Channel 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb5),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 1),
 	},
 	{ /* MC0 Channel 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb4),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb0),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 2),
 	},
 	{ /* MC0 Channel 3 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb5),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fb1),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 3),
 	},
 	{ /* MC1 Channel 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd4),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 4),
 	},
 	{ /* MC1 Channel 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd5),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 5),
 	},
 	{ /* MC1 Channel 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd4),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd0),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 6),
 	},
 	{ /* MC1 Channel 3 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd5),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fd1),
 		.driver_data =3D =
UNCORE_PCI_DEV_DATA(HSWEP_PCI_UNCORE_IMC, 7),
 	},

I came across this when reading the perf subsystem code to see how =
offcore memory controllers are accessed, and where the addresses are =
defined. Haven=E2=80=99t had the chance to test it out on hardware yet, =
so please let me know if the intel document is wrong and the values =
entered are correct in practice.

Thanks,
Aniruddha.=

