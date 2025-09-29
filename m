Return-Path: <linux-kernel+bounces-836559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008FBAA048
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D361C4337
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5030CB28;
	Mon, 29 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig8KDxvO"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1653074AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163511; cv=none; b=ov6QnR5qaadmIAJCs7mMQYckpvxrqFFet2elXBI0atdViU87Hk/1f0XxafdxCE3GAATxZq4SqqbOVQ4MWMRHlP4E4Iq4g3SOwUL+qiihEeV2ZmLgfF+xgAYeEZu8Dy3gohYrKxcc0r7/8sB+Gk8RUkKJE3enD9HCBtCtALZrnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163511; c=relaxed/simple;
	bh=nTErp6MjM2H9FJt5b0VdfDXyFtxk1zguj9gOTg/Op1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vj78WFPqW3BL8cTCYBFykucp5fClvMi0KbIaASpDTFJVqHn2g96yBCEX4gscBq4RWOJidQPdnWGAkyh3an74ILw7AoS83+M1TpUSQ4ipofLd5jgNwCVspJOUmZ4NGzDdJxdnPTjDayPoBLzqDeY9zOHxcjPQG4qE86xs7pOG+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig8KDxvO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so428978a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759163509; x=1759768309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lka4+ZyxLfYllS696TYLXMts9dTS83swxEi3cmvk4F4=;
        b=ig8KDxvOg2N8ygrGO+MRxh/HOl/sue8Haw+ylPPuB564h0nVSAKa/bjPrWHhmt3Cdv
         ZDTdp+QyLn/lykIBpJI8m43f7p9M98JyyboaHFGYLXSnsP45JCmAIPFv/QTMSJZIqU0k
         CITqCeurdTd/d4Ap/ArWbYIXhmD83GU6JPvRsx4bNWC8PGkxIAYApmH01ybIM2303SJ+
         5njQ8AbGw9ry2Q82uy76+b/9OEfIvOIiHQ0WKhM2UPBB9VDBrMLd061fSreNT7eE0VHs
         lDHX2Bjnd6ZRRQWN42EEhI+AyaSBxKraXS+96NBtvIOAc2tY3TC/dFD2SCwr0XJUSOdC
         GAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759163509; x=1759768309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lka4+ZyxLfYllS696TYLXMts9dTS83swxEi3cmvk4F4=;
        b=ni2knfIEQx1fcYwNPCXCCdrUpVArdH3114d3mioGrfZD+sqVIXos36mh+9N6lDWIru
         cBSpQuZiKHZ8saif8ptg2uiI1UV6coVMojEBwQXEutvToi5Fs8EbuKmCJi69NUnM8cs6
         gCquLIH9JRU+rBpmqCDpodyqTaWyIUMFpwodu7DbWw0Bu2dRo4YsdxjJ9NSNMLg2hx2n
         CyxJr1UzG0kkQ3Z0kMV2swYaLHfLz1BsR5HC6rQIiynEkD2SF+iiXbFvPJCzj0shOByh
         N+yZwNId/PNGkEHnT30vT+G0l2tAq1cKsAZ+LebbPWRS72K6MbgEcQ7MeWWJ9dUvRo18
         GgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlUR5kTO7PlnQgDJbZDWBa41+5yOGMSll1a/rbsjE1FTvNuaAFEFXwhhLeOL7RsZ3ResdEUpIN+HKTB/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhA9uRoODN9vWTK98hmnlSSKc9eShul3WwbhM0hOOCXMSaqKpd
	9EWyUOli5xUYnh352TmYPeTqOewWM9jOjmPlwSoqk0Qjmufd7+8MPEyu
X-Gm-Gg: ASbGncs3kXbQVSG3cApyO1kiY005K0tW/1Agc0Z/uq3ZcdRjw1+LqhMjZ1DcC+j5g0o
	p614WO2OsvABeSt4XJi1qv/hiDxQH81CEkQseqY4UHWmuu7v0uolDtECvYWDpMk2j17RsvhTLki
	2NlmtUcr4AFiJRcpF6uNTpj3+tbw17ou2Jv8DM6M4pwSebX7Qsz6E9DTs5feazWBCunlJwKfjdS
	ZYSOmbW45YV8OAfXAmYzSJ83PdOBRx8XYgjjYqAblx3AzuTjQsAK+VRuzNLfbSf4bPrwkhN+ano
	XMrkO+kczFu1L9iShGXNEqnURgi8KUkI9rlYNhdxpeDd3RIea0VBMaqVuoFkoTdc7KDzA9sbwtl
	MbWBbyuKyHReatdbjQt3dpiSiU4zJtLXsrwIDo87OA6kJTbZjv9f0
X-Google-Smtp-Source: AGHT+IEZeT16n1Qx68AceriYoS2m5DQH3UD7/ggp2pq32iz566aW/AJGDTJkg6J0/p2eGeMqMpos2Q==
X-Received: by 2002:a17:90b:350c:b0:330:6c04:a72b with SMTP id 98e67ed59e1d1-3342a2498f2mr18362711a91.3.1759163508737;
        Mon, 29 Sep 2025 09:31:48 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90327sm17674419a91.3.2025.09.29.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:31:48 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Date: Mon, 29 Sep 2025 22:01:38 +0530
Message-ID: <20250929163140.122383-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tcp_port_share test binary to .gitignore to avoid
accidentally staging the build artifact.

Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
a socket")
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 3d4b4a53dfda..439101b518ee 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -52,6 +52,7 @@ tap
 tcp_fastopen_backup_key
 tcp_inq
 tcp_mmap
+tcp_port_share
 tfo
 timestamping
 tls
-- 
2.43.0


