Return-Path: <linux-kernel+bounces-829851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42934B980C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A012A3BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621F226CFE;
	Wed, 24 Sep 2025 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiJlzNFd"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4F221290
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679607; cv=none; b=U4L4nkhyzqb7nN+HDpO5lhG6USw19tiJHLLmy7sKyP5nKDSh1zYzM8gPlw1nfeHBqpDFPv+tmkonT907NkiBj6DKU+P/vng/dyaZg2t79w+KfWMFvSNxxt2RVLpRQlf5P/sM2CCBu8Olj1rdppk3pheJHQooB+9cp2tCFeVllAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679607; c=relaxed/simple;
	bh=SJbHWlbvJA/01zIZ7Y6v2IHBI9WiHdTgUa7T2tMLDKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft4FitmEwU+8kyC9t/Ebcan4BoWOKN/g00k2R5NnRR0fA3Az7z7Tenb1hVUm6Djhn+I7tdnFxqKkftouj4zTmS3+gxC0+/qk8aVb6h2Fq3mfacMAkWpzTreGogjDWRtv7Z9ucUEsats1l2FS/b43ntFfdKPEnM4H5FxCPZ7bDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiJlzNFd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f3405c38aso2631407b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679605; x=1759284405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwTsINYgLAubnrIc+zvaDxzMOPdaYgdoD6PMu3OyE78=;
        b=iiJlzNFd2QsQmb/jor3WwzljFOU87pfqPEsmInV/maWE06nzxORVxnpD/tKKE8cj8T
         2azvzeax6Z/E+r6Le8SvUF51WznvOTSXPKAtxXX5rdGfIw5zfeSmIjqf+iJ4NyfEu8sk
         OUqTJa0fv2UxK0PFNGcqdNM8dZpg9F/nSdYJscQrPbXAfswyhjiCeOyf2OIJpTe+M4Om
         hrK31jY55ejDqgnimzMJZVfNlj6i+Toz5OO5Nwm54pmo17I1LZ3GEWiPLAUDlG0Yth16
         CGYxiJVuRMSK5jlBjw1BL6qeqBo7duJgpaNJRCatrRkmk7ueyVfhVSuFapNfxUkoUw2Z
         1L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679605; x=1759284405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwTsINYgLAubnrIc+zvaDxzMOPdaYgdoD6PMu3OyE78=;
        b=SSCZ6vBISHPy8S0cuLRustmuFJDJJ7NSlqa206z5xPt8MP4grIxQ1l2OOubCA0nhBn
         b+YGrPlPfBNkbvGMXfhleoY9kLtXbAfdjG2sAbkUSuxql35jYpk3sxb+0y06Gstg4S9b
         hsAfxBjir6QLBsVgU2m/XHYpDWZbxfPL56/UAF3ApSzPz/bbQ6Zh6hibUG2nceIJlHGi
         MrGn8DoPAE58XlfnICV3vwOmtst/rbkQYpTUsnIc5XNEMM3kNqr5DfQDeM+/NWRqj7uS
         DhMy3V2qedSImivhrcs6bivkNGg0B02zgjsBfaWfUGAhcDpW4aKYUNWRT1PTDtI6EXB4
         Z79g==
X-Gm-Message-State: AOJu0YwD13O71UErZtxCtyZOkuyLQvqGTSpvxWJUAHm8VC1jKfY9+Olp
	HMlmAEGhz3C4gGlgLh56MyywceiqzfnQhLgjU/yLX1+Gx0wJgy+gb1oF
X-Gm-Gg: ASbGncsbVDCVu6FwzvLRNVy4OXSQKj1TFejw22UrP8TmQ/m6mK693XJOFMDQ/cmSWEz
	se8wA0c7uDsrXK0kHYcsE5GFPwjjmk3K9nFqCMndYtAfAAoMnTdcjjt6dWTH28d8reXBTmppVQ5
	x7QCsBcE54sZ/qEhKIOK0a2GwnuQSa1Z4xqrCPNFRaNo/H9M7WN7Nd9KlHUyynZxUBgo2e8tZNt
	GjjQLjt6KcKcEEwtgqAJFdpl6RFNxiG0tkakUhl3ZehIjingyjq6rqPn78gMg0tVP+V2H0ahynM
	kLHMe+M3PBLZxudkGu7ORIfryq8JYnM6KPFULf4JUtEfOZKEiZBzBIlEdj3KVcZJRGGejXCgm2j
	CLAMFOwaMEtfZQrAFxvJJ5zWBC4OOPp01
X-Google-Smtp-Source: AGHT+IGkf78YC2sKEM7cbsmrqX1hFpvzRBYNzQq7EPVRv+Rq2UBgzLYX+YUWp3EP4vlgaXWZwiW4JQ==
X-Received: by 2002:a05:6a20:3c90:b0:23d:ab68:1b7c with SMTP id adf61e73a8af0-2cff9a39f41mr6933117637.46.1758679605150;
        Tue, 23 Sep 2025 19:06:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dbc8e7cc4sm15316561b3a.29.2025.09.23.19.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:06:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7AD49424C03C; Wed, 24 Sep 2025 09:06:39 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2 1/3] net: dns_resolver: Use reST bullet list for features list
Date: Wed, 24 Sep 2025 09:06:23 +0700
Message-ID: <20250924020626.17073-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924020626.17073-1-bagasdotme@gmail.com>
References: <20250924020626.17073-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=bagasdotme@gmail.com; h=from:subject; bh=SJbHWlbvJA/01zIZ7Y6v2IHBI9WiHdTgUa7T2tMLDKg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmXA9N6vq/JfJ2+ySTG72ZEsG6Q87+q2xOCluT8TX5nc eMiq7BLRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACby/xvDf8+9L7eVcr/33af5 TGhFt+LhmKVCCvtSrnu/erI2ff7huD+MDLf2rblYmXD1TNSJVTK7H31rWuMmlHZli9q7N6L7F/k KmzEBAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Features overview list uses an asterisk in parentheses (``(*)``)
as bullet list marker, which isn't supported by Sphinx as proper
bullet. Replace it with just asterisk.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index c0364f7070af84..5cec37bedf9950 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -25,11 +25,11 @@ These routines must be supported by userspace tools dns.upcall, cifs.upcall and
 request-key.  It is under development and does not yet provide the full feature
 set.  The features it does support include:
 
- (*) Implements the dns_resolver key_type to contact userspace.
+ * Implements the dns_resolver key_type to contact userspace.
 
 It does not yet support the following AFS features:
 
- (*) Dns query support for AFSDB resource record.
+ * DNS query support for AFSDB resource record.
 
 This code is extracted from the CIFS filesystem.
 
-- 
An old man doll... just what I always wanted! - Clara


