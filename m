Return-Path: <linux-kernel+bounces-848967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BBFBCEEBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58C43BCEE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCF01C5F13;
	Sat, 11 Oct 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DW1r1+Mj"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502E1B6D08
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152509; cv=none; b=Z5cUa827jMD5vzQVIsXm5KCurDtPATkOlZ9wvcX3o5fEZvqf1JxcmWatie3N38+njYb48Rs6w7sG01vJ+1YiiSE1zeZZ2O2z0lnSsbTwLbjbvlNvpCNa/Yen+GoPs+Gg6R4oyXVqWFFb6WKykcsq89ivlBGB7owDNKMSNVcXyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152509; c=relaxed/simple;
	bh=VgRc1HSUo/GGyelxPOPx/dvYNds7xqzzw1DHBYUoj/c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lEorePH5OY5lEpFXWWvwjd2HHbiDsDYPcv9a3HzGQfvdQiGhATrdyFZH2UJEb2Zjc4qpb5jqpaoObLZ2mmcIX5CVD0509bpOWll60PIwukB7/Sbc2nDrOBU12KLn/G+bjaD5rdcHfw11mGQzE2G77fQp5VHD6Nscpp9rHi/TS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DW1r1+Mj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so2249876a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760152506; x=1760757306; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzkBY0PBFsLQsNCmiEa3AufeeUbE2KtfHbRsNCZScNU=;
        b=DW1r1+MjiSZC3z9+NF/b20AcpopYnvxhiuD6vq343LfYJRw2NTQ8kFqHZ+teGXQfpm
         ApQ8SE7wG6x1Dot0D4E9U7Rt7Uksa+1SWQsUQA02ojqzm2jw61+Y22nvSwsRRizet9ZI
         +VCuF40AEa4BzZURHd6L/o+5Mfp75CKr3x1Dsujej6b0FNqkly5L8bVKlPVWj7e+YJzS
         Fc/Of3FdX0HF3o18MLUjVjdhyFWbbcx8YuByOZx32JkIOTXE9G+rbKWhwk954/ez7pxB
         hE650vIKpYGYZr7N245H/GZZ3Y7yyz11QtbUH1VyA8NmUYWsghd1AQ6NLu/ED7VG4Yx8
         gekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760152506; x=1760757306;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzkBY0PBFsLQsNCmiEa3AufeeUbE2KtfHbRsNCZScNU=;
        b=AGbYKbA2Y4ukIebYcvR21zU6whCciAmhKbPKLkc86Q1phPylBZC5ZRroiP8nc79FLb
         6e1/rxF2LulPdLvDlS8hcfXGur+9979apizx1OntL7D0OTNV/XwgMS776KDf9btUUSri
         KQ0ppzLDmtHHiCf838zd3ekV4mI84nXAoeDOu9N4m4HUrbukZXpTiljzprnir/zbXYsU
         eS6q+RyhPJZUk8xVPbhDXuq4j+Yazu62C7iN0XDnP3sQZtvINMk5eoE862D8OWB3/lGU
         KHSQakqjghebG8CZoBvccDjaccIUv6UVFnf91J7ccIOK3ctLti9DuEF//yKJsPXDpca9
         S1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUi0/4iAdM3exZkpOIdXDzKsBDbRAumcATvkYpAtCopfAh8F1eZdksoGsJvtcm+uYJTvskA8KlbwWuyAvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCLN8y1pp2Y9vqhwUYWu8W+nXykWxMiby0+WReyQQOQWh7l54
	Uvk5OJN71Ku+pMKnc8MRCWHbXehZNS0oMuXStr3whr35K3eaV4LRFxUNcaz7AQlltuJ05GWC++E
	ZC9QW
X-Gm-Gg: ASbGncu8FjX+2Y3TNtPXWyDveqzxEkyuvZJTANiiV9UptEtl/Vt0K/WSI0Vo31KpBDW
	8D+1dhdYI5gbo0vNJfVPe/H118HJnK20tlQa4lFhyn9yu9AMXXMo72PEbBgNGa2A7U5fQPOBu3J
	/T09EStWO/HaKG9HkeCWF85KMlPo9OL7uhlLhm/XJd7ZlUYJfhPhHhUYi311bAIelph8AZ2oKYS
	R+J6/gCUH9FhfLBu8cNc525PCagIVfiR3hRPBwWN96Y1Dsl8a1nBy2Vz7AqD7zCcRrTpw1uduP1
	zeIawiOpbjbocLMqsI3wDGK5sCavjsT1bpZeXDig4TPJmpcniLXeVyanWOhGysdrNQwo+ZLGc51
	QAwr5lw+a1+0r5xhrvpNcFElUP3mjIE3XUpm7DLBkGDZVtDZaVM7gA83oFgZ451GYpczrw+M490
	S4t4RAHp8=
X-Google-Smtp-Source: AGHT+IHHjgXbpYOhl8Tft2FvsCqOzsuJfl2ZGri0jE7siTM5jH20pQ4uTxhaMN3qUY1IfRSVHqZPXQ==
X-Received: by 2002:a05:6a20:7348:b0:2c7:55a3:6168 with SMTP id adf61e73a8af0-32da83de308mr18596310637.30.1760152505897;
        Fri, 10 Oct 2025 20:15:05 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6792f508c6sm3496863a12.24.2025.10.10.20.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 20:15:05 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is
Date: Sat, 11 Oct 2025 11:14:47 +0800
Message-Id: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

To preserve PCIe performance, ACS is enabled only when
AMD IOMMU is not disabled.

[This text serves solely as the patch changelog.]

Thanks,
Jinhui

---
v1: https://lore.kernel.org/all/20250928075257.1542-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by Suravee):
 - Drop the amd_iommu_force_enable check; it's only used
   to skip a workaround in the same function.

Jinhui Guo (1):
  iommu/amd: Enable PCIe ACS only if AMD IOMMU is on

 drivers/iommu/amd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1


