Return-Path: <linux-kernel+bounces-889951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07398C3EE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C73B0DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBF30FF03;
	Fri,  7 Nov 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6dLF+4X"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB830F94B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503205; cv=none; b=MVjBxucPemmJO2xfCD/ki8SzSR5VtMbZVOcfqOcoS97OB628LcoreY6KwWic6oVnVxnvh+vZebPc6DpUcHxmQuVnEyyumqXBVuGi+1/lXzNkeat8+laBPPyxFVZXbF5SrsVnaM1UIEvZIV/897KReLRBiirI/P2fYFXS+daAXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503205; c=relaxed/simple;
	bh=0sXmLwNMlYc0PbllYPcwc9yuoEtGcI4ex2Sbk6FXq8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqquhVCmg9CPrjVVl2KK1lwpuDhUlhigyUgME7cY5IDLaqlWlemgHFZbF+ues4DtqQRQAu+1CkbEtE5Kbdbt1HsN1TJLtGgdef62FHhMT+8cUqWgj4OAyEC/sj+xUVMp3dE5SGw4tcGLMYW4bCdMuZYcSwboKY3Ock0Gs/UTFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6dLF+4X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so208912a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503202; x=1763108002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PabJINhtTz14DvOSYG0veNaIdLnYHWjqpt4UhSeU28c=;
        b=R6dLF+4X2CQJ6hVObynXUvpvM2YFmWaT06KkMzU4/XmJaAhsXV5GojsCfPCkEn9G+J
         3P3scbJZLsIUlL1wKELkVTwENNosOJmoSr9mffuEeEUDv289t3/VWGFEufzh18rOG3WK
         1zkFD4ffevyn1OEN5PGRjjC7+rQVElMoaNafcfqXZOLKb27S/JfHRXXwAoJrIdrzUeeT
         axl644jra5JDuNQswN/SY0nruy57hohN9rXP71a4e5Gl+AyQxRbdkInUUqygvfNOQB5Y
         TBAP7zd5s5fgQ0jFGwoAPID7okRS52xKZE/UZz3I4V5GDnPVqD68g1VrfLUJO8doCu5T
         O2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503202; x=1763108002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PabJINhtTz14DvOSYG0veNaIdLnYHWjqpt4UhSeU28c=;
        b=QXnDCB1UnRc/ZpcF1kbyxk20ygI27VWBJybtbYB/doxUnpOKKhAHSorN6Ms6tCA6HY
         EoVfoACssChFu25Gr35Noq0zIzs1zGEJY2ehRVYfxwDsqeZBGXPzK7oEfzI9IRO9C2Ho
         pkqatGiX9+K5avJIZXecB9MgdeLjtSk6V9emyqAtcqmAAys4kO85xsxFErFYefMBTpkE
         iaXDGm4z96MHwdHyW18JU2PRZaZUUK9FkQQDT645jCgvdIwR3g8M9kweSilaRNik9PyA
         +Pz9GrvfxDstlbdqoYid0VnK0W7xys7iiMPePF48Er19d1PWowr3LF2TE6/NgBl+udaA
         0ydQ==
X-Gm-Message-State: AOJu0YwF6+8bQK5kUeTSgisdDJfXpwoFof1mOky391zAEpHfVXBPaR9x
	udBXGI40vOADnKSrmo2P+GOfLeuuU6IDatNg9Ny28kfbDlORSscqcKwQ
X-Gm-Gg: ASbGnctEmOoZrBBUUrshNfh723zNQMoh3OD32vPEdu6yvidmS/yDqazDhcyuSHgQo9S
	ly5Pf/qn0hwCOintcGfRJgC1P2zQCHBl5xWjAHdnk43u1vu4/3Cl2v4PrH0IrpOwORYvjBZVJ0C
	mITwLd5R/wkU7nZYS3pBEh9RCYJ+CdEQ01qCU2pmZgTFgJPIZym+559eFAVDCJsPWlzqxECuwCT
	uu9IbvuFBiXBFnVmNyOXfreQzx7DOrmteUpDUaVzF3yvoyvX5kVFrhivSIhjAqQUZaKF1prbLlu
	VXRHHg/F0UESxGVWDXYkxn5zj2PegLxkGyXMq/F6XeBsScV4u6/VgNiLJ6sjaCZYOBGDfTiMT2Z
	2KACXE59BGOe+c+NeelVoT3PoymZCDeClDjvK9bX0UmcSO8NAv9gygN20i7ytAIuaD8aNTu2yW6
	EE
X-Google-Smtp-Source: AGHT+IH8lIVBGU6qZcWj9lXhl2uY6I1BfrQTXsj7jZaaMXy9BNwAH/WaMBWywYg8F8rsMUMO09NxnA==
X-Received: by 2002:a05:6402:5352:10b0:640:998e:4471 with SMTP id 4fb4d7f45d1cf-64146d18bb6mr550756a12.5.1762503202010;
        Fri, 07 Nov 2025 00:13:22 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862697sm3641613a12.25.2025.11.07.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:13:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 032C042439DF; Fri, 07 Nov 2025 15:13:12 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/2] Documentation: genpt: Don't use code block marker before iommu_amdv1.c include listing
Date: Fri,  7 Nov 2025 15:13:00 +0700
Message-ID: <20251107081300.13033-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107081300.13033-2-bagasdotme@gmail.com>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=bagasdotme@gmail.com; h=from:subject; bh=0sXmLwNMlYc0PbllYPcwc9yuoEtGcI4ex2Sbk6FXq8o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJm8K/RqNyVdu5D741ms3OR9ByJeGHXMYO4M15mjVd7zX frZn3lnO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRwL+MDL1NZW6RbP46j7Z9 +cT8asYt5y311mXrQ59Zzdka4nLS5wjD/7KTUmlc95YK67orqgrIZ8xnYhHx2dcg2Tb9/9Izd3k XsgMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warning when merging iommu tree:

Documentation/driver-api/generic_pt.rst:32: WARNING: Literal block expected; none found. [docutils]

This is because of duplicate double colon code block markers: one after
generic_pt/fmt/iommu_amdv1.c and the one in its preceding paragraph. The
resulting htmldocs, however, only marks the include listing (after the
former) up as it should be.

Drop the latter to fix the warning.

Fixes: ab0b572847ac ("genpt: Add Documentation/ files")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/generic_pt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
index 210d1229aa1c1f..7a9ca9f2878d4f 100644
--- a/Documentation/driver-api/generic_pt.rst
+++ b/Documentation/driver-api/generic_pt.rst
@@ -27,7 +27,7 @@ compiled into a per-format IOMMU operations kernel module.
 For this to work the .c file for each compilation unit will include both the
 format headers and the generic code for the implementation. For instance in an
 implementation compilation unit the headers would normally be included as
-follows::
+follows:
 
 generic_pt/fmt/iommu_amdv1.c::
 
-- 
An old man doll... just what I always wanted! - Clara


