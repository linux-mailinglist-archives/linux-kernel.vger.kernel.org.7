Return-Path: <linux-kernel+bounces-882218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B603C29E74
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B71188A0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358B27FB10;
	Mon,  3 Nov 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM9uaXTl"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4034D3BE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138964; cv=none; b=VcAJChGrYiwNINaB9Ld6hOuc4wi2QAM5eYmk8QTURIA6PSC3PL41JJP6L3Dqm5QGHXPFnW03y/kxieLebkm613qwy9X4r44BcoubSbEGZlwtx8uSC8tksywXRbdJ2pHt4OXzYZJtRwjuErf0+vDsGXLZlg5ztDGC2XLzfofLcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138964; c=relaxed/simple;
	bh=+n6+4nE3QxNSj3LhmiOGy3NDJYbLSK9GFP1yPyxnvMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfZrqOW9t6f3AMxShJOHUZuyfA33DZ9Zj/2bNWqUGdQ012S5QmI7zLf+Jl+XymQ0wwYFnuF6RN5/A9rZcsXV9XMxWrsKjUR56Iga7sy5Upfiekv/E6odahmXBxo6wQTPOxutSdzaZuKU7tUy8rk6wzvs40MHzumg/C6MY+gKsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM9uaXTl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89f07fee490so543251685a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762138962; x=1762743762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lVneWAcxAYuvydSEWTaX0/jj6CVEKTN4CESDRja7lcY=;
        b=KM9uaXTlrDt3k+HcRLuXgxOV5CET1GOdyHGS2KQm3DXMD04rTiZKWK9df1abQM0S2D
         qbr+tAaQ8WeD/BybPpUQ7ZTbjZpdXeP6lQ6N517cZ69qOllDo/J4y8ZHh7Vr7b5roj7J
         kOMlPPsxfMCJnptYJ4RVqJ2KjAeFrNBTYfrDPfoc4RNPdgUClfBZtZY3g1gxfvASwGve
         kK+JnYotfjNfkab7v32Y+aweBXfsScLu3pK9muhflWgqT2aNf9iewFko17B6RrP0osQ1
         xG/okFRFGcrbl1BuLshX9Qi9myr0BD/KdUMtWxj5bUsBUjX4o8g9dsYd+3PnlYW2+SmW
         Flhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762138962; x=1762743762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVneWAcxAYuvydSEWTaX0/jj6CVEKTN4CESDRja7lcY=;
        b=TnAlI8/tAeLrG6v23GLFPMTUGWfkzcR1LhLOL4uFSLMy0uQGd0hYE0YNz6+4970z1V
         MSZ93zy7rsU5m6JvV2KFBl9jHCQjEz2mQgmDXeBx+ndWI2vAj2h6eqxIVTtoLqddijVc
         oYmKr/azlvBpW2RmQFXGV6Z13DRxtmisvXXFfkFeOzJDM+xIEA5HCIQHFdRXTFuq5h6M
         o/vVWv0JDs1Jcyb8lLCNZc/vUHZ7VmpbBfmAtuzXfEQ6Yc5NPIHV0BNxNxu/hmwetZoN
         9VLDQxVPseu69smnEhrQ54NpVD/K+nyIJiP/IVXOYk2s7CGqKBcy6GD+s9czQtH4d87s
         TDZg==
X-Gm-Message-State: AOJu0YycXRrOEzzNMqqzvdFufF8e2wSFqLbToyPmeRLLLNI2Mevx/yfM
	Oeqlm1Ibu9Vet7dhn/ttdDn4Rb3O5A+cLcAL4e6XK96+ZhSfgmxrtsPW
X-Gm-Gg: ASbGncu69rUPnmdMxGspfMajJkI/RKjN5f//UJ+4wg4K2E7y8rQqmjUSLWhoO1d5JFA
	XNSRDN6kX1l6DVocFE84Yg6hIEtPXCJJ+5EOBI09UspLdwf0yaAAOB6ENVUkRwG10X0gNvTt3hQ
	3ndKJvwWwuRxfwiqYISeff3EOLD9C0QvvuMOWDYdjVsoBZPVLMCcA3MhrK2SLYKXY+Q7JVUyjR3
	HghGy17WoTjzsCrQUnwkQnGkp1yM3LTmI62bxNmFJO+v0hJLNITjPgUJE6YsupuBRJNCl9F4FSe
	b3HyKfLHHm2P/jH6HrxYjdm0SWRdy+6kqVbJFrH6CDSYO+PZwkBo3SfGcQvEQJa+HcHsywiQkNb
	u+nMq6dWDmP0FWyVTLNF6aPUk1BVec3UvtJuaFKX0Ovx7zSngQyxi2/uLdWGZWK3uC+eIAEHrlI
	1MlOm2hB2eqZs=
X-Google-Smtp-Source: AGHT+IGGeXxzdrJf3WBZprdJQL4BoPwcya2voHi92nYt51/9Z4IG3Yj5hi6Em4B2KfrTkq2T/EWYEg==
X-Received: by 2002:a05:620a:454e:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8ab9ade53aamr1428944885a.49.1762138962093;
        Sun, 02 Nov 2025 19:02:42 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed3528968csm48936171cf.21.2025.11.02.19.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:02:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5D6AD41C0600; Mon, 03 Nov 2025 10:02:38 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: pldmfw: Demote library overview section
Date: Mon,  3 Nov 2025 10:02:28 +0700
Message-ID: <20251103030228.23851-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=bagasdotme@gmail.com; h=from:subject; bh=+n6+4nE3QxNSj3LhmiOGy3NDJYbLSK9GFP1yPyxnvMM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkc0k4fvJ50+e2tLTBRve7VXXGGdeIZJbGcet2ol4/33 F/uaHOqo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOZ1M3wP+aH8etFO7azpEU8 3rFVbYkvc+zy28dYmtdOF/3ycL3dYhOG/2nnlh6Zb3ljYcDbc0aSbRuePnQSWXazyN0kQ/vS3zu u/3gA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

pldmfw library overview section is formatted as title heading (the
second title of index.rst), making it listed in driver-api toctree.

Demote the section.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/pldmfw/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/driver-api/pldmfw/index.rst b/Documentation/driver-api/pldmfw/index.rst
index fd871b83f34f3a..e59beca374c1fa 100644
--- a/Documentation/driver-api/pldmfw/index.rst
+++ b/Documentation/driver-api/pldmfw/index.rst
@@ -14,7 +14,6 @@ the PLDM for Firmware Update standard
    file-format
    driver-ops
 
-==================================
 Overview of the ``pldmfw`` library
 ==================================
 

base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980
-- 
An old man doll... just what I always wanted! - Clara


