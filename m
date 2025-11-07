Return-Path: <linux-kernel+bounces-889950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A530C3EE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1493188A839
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6030F94F;
	Fri,  7 Nov 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNf5qHPr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5E30F93A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503204; cv=none; b=C797/7SZNq8S3kN0wjaT1xAznfwjsfZamIQHdYuU+E0W0pfKeoUdobOr57WZhEVt2FZF0ENswJXB9+P+USq2dT6lReNaKCERDbcD9fXjuIV1oY3LDFTHIr2/DcBlsSqNPNh66v8bs712opFR6VEBSnu9pG4WW50KnRzV0lFijTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503204; c=relaxed/simple;
	bh=l70ZHuFXGxCuiZ9UWHRnDufmsHg5/+S7082Atj+1UWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRRmB5IQ/TwBG3TgjLMQTRAJgVVCOwiOiKF1KukR7gqcfs8ce1VxiZvHkTsmts1luCLeG+EA0BbGIYdQ+eZCabd4VoDTP7uEs4/rnvwcD6+V7tRr5yS4Qq3/7DivJCJ9046i7yhB73ZvJI1Ohs0HY4zkuJz5WYsgUKQb9cwgBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNf5qHPr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so992069a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503201; x=1763108001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/S84Bq0H+5Q5GEwboYARmckBLSU9dA4Cuq2qpko4lg=;
        b=lNf5qHPriYstzhQF7q0ACqxkb9UzdxXEov6xxYtdp1nkHrorl8NZ6sM7FaYVp2sdeN
         Q/rYhVkrmV6NcjaFrHUXgqkIBj4fYcXaA3qcucCBVU31j1hmIwUxR2JlOP9gJiItVIWz
         CNiwQvVyE7/d4+2suH6fGGwVpz2ON68XiJWeKGEcifRcwRyOGvhoqdq9aFourgvSbltR
         FUONSqOFVBpwop2bGMrBKqk4ImNmVjlRnvmKvqIXxmtMn2Mzm1AIWaYBhR3723fYrUS1
         GU4C6xsPO8Ov9WJuTE7uAjgoPdhZx/M7kHLAT9pF35A/h3xZMuQYoQx5TbqCsF926gBm
         EVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503201; x=1763108001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/S84Bq0H+5Q5GEwboYARmckBLSU9dA4Cuq2qpko4lg=;
        b=gS2CatamM+mmK0gcFsjdlpwN1Cvey9NOUZQkkouoVZK+xvgM13lLLWdX/AFZW1dRuO
         E6XEG432OeISBwFRNi+N1UgiorO/+tFrV/21/+yySC4aag5OsJ+UlQh+o/vRdFtbFfot
         /2flp0s41jAu31XLo2WkBuPhcS8jlLwfOm278ukg+Lzsxr56vH2h8WdyuBTExVsN/Nzd
         doI1Ua97zExuHthMh0I3mIq6Zjk3GEBmeGn+NX0B/KtEJ+xnQv+SJWJaW932Oz56lOdj
         dEjHS5fKwQstffmeGufoEUsxc4qau5inP5n9PSSiMTnRQZD4GBGVZjit6TeDBIdA8xPu
         FIOg==
X-Gm-Message-State: AOJu0YwjuVpqeGIBaLH+j/bKS07k4//YD2HDlCdUL+e7FvVkC9oucQPS
	aaxhSUVqanyN6Icc7uN+60kiWpgZIFKAY67nXWK2ChuXtaRLhuecL/xa
X-Gm-Gg: ASbGncvfCMprcJ66OoCQ/s5FtCHh+qa54AojNFnLIQ1FNNqESlRfFMSVkj7fV9BrQSL
	3yhnxkkWjV9+WGzc0jqf22KyurDR+Lpz1v0KZR9KdhxLGfpmLLm4Jfy5h8sYd6yc8HhpjMx14yO
	XJvLy6XRhOxoRCDy6nTK82DtVgZaE1bSRsMgmjp9PusH7e1kne/s3GMRJqlrtHfHgPrx/pVp4n1
	1f23aIYPBDJBqQ4sYLQ9veVM3iOFwmDmgwwH6SmJ6uoFcjLT1F8uabVxjnws4N3kbW2greabIR5
	MCcUni9hWe2na2y92Ni9r4MRG6dBkDD4N7QTAfUXKkMTW427vW+mM8Rat2wxar6m1vrzGUTxOng
	BCOYzD11tfH6ELCm71j5VDxAfvfNOM2jDo53/KMZQYhkKxUlXtXCLIvg54/J5xE2CGRrvB3P9CS
	4EiB1NMsCW54w=
X-Google-Smtp-Source: AGHT+IGeKtv44GcSyZP8wA09Y2J6Plyg1nStPrUzCk/QO5GDH6nrlZ7OMpI0TvErsPPE6Q92rFcohw==
X-Received: by 2002:a17:907:3d45:b0:b70:e15b:286a with SMTP id a640c23a62f3a-b72c0d9438emr243107866b.57.1762503201240;
        Fri, 07 Nov 2025 00:13:21 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbda2sm177442166b.28.2025.11.07.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:13:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 41826424DA71; Fri, 07 Nov 2025 15:13:12 +0700 (WIB)
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/2] iommupt: Describe @bitnr parameter
Date: Fri,  7 Nov 2025 15:13:01 +0700
Message-ID: <20251107081300.13033-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107081300.13033-2-bagasdotme@gmail.com>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=bagasdotme@gmail.com; h=from:subject; bh=l70ZHuFXGxCuiZ9UWHRnDufmsHg5/+S7082Atj+1UWA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJm8K/Q0zOYGTDgr9jri977z+QzvRDbO6GgTcj+x49BOS S0H9z8VHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiI13lGhk6LMFHd7FuyC1Id DvPLM+1jsX2t9/75qszetQw2Nvs8NjP8jyxeuf3fy8Vh786WbToquy7djy97wZXeWOOsmF2Opiv OcQIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings when making htmldocs:

WARNING: ./drivers/iommu/generic_pt/pt_common.h:361 function parameter 'bitnr' not described in 'pt_test_sw_bit_acquire'
WARNING: ./drivers/iommu/generic_pt/pt_common.h:371 function parameter 'bitnr' not described in 'pt_set_sw_bit_release'

Describe @bitnr to squash them.

Fixes: bcc64b57b48e ("iommupt: Add basic support for SW bits in the page table")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/generic_pt/pt_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
index b5628f47e0db40..3b4e371089140a 100644
--- a/drivers/iommu/generic_pt/pt_common.h
+++ b/drivers/iommu/generic_pt/pt_common.h
@@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
 /**
  * pt_test_sw_bit_acquire() - Read a software bit in an item
  * @pts: Entry to set
+ * @bitnr: Bit to read
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a test bit and acquire operation.
@@ -364,6 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 /**
  * pt_set_sw_bit_release() - Set a software bit in an item
  * @pts: Entry to set
+ * @bitnr: Bit to read
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a set bit and release operation.
-- 
An old man doll... just what I always wanted! - Clara


