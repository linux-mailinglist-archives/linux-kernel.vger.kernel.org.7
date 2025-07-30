Return-Path: <linux-kernel+bounces-751247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F1B166DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A14624B97
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B32DC358;
	Wed, 30 Jul 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds9doM65"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E12E2EEA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903522; cv=none; b=XjqNsfTxeSEv5N+vrWg1T8aokigkWDiMbDihK6uwGDftieHqXadJazjruB41HLZlb0fJDNYulQN2g5GHI/2HxLyqMQaEADcCMS7MkQF221aTHeMUDyh+KOCswY2vbhO0V41XYTny3KbRdCKo4ohagFqP3c/40NytY80KfvKHYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903522; c=relaxed/simple;
	bh=rwq0k0RYZQX7GCPfsRHZ5S6owb8YHw7Jqnkl6ApF/Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA5+LwDLTkMLnbojunY4CnDOo+6Xv7/QiAZOMwwsPbwivOeptRFm+2cOBHfd1h78e3qLONPgfKEDaD88O6lpDSPJI3TGqrxm432rRGSTKeAU+Bz7QYVSMGA+1PaBuxQCN0wiLuhEB+HirQIDFzQqYjKY8CtGLvDoOyGXf5LiWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ds9doM65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEfzs12KwG9m5a8L/OU1+VFjO5dA7Lh78TnbObJb7DY=;
	b=ds9doM65UAPF4qc+wl6XhUjlrgV12Qv/F9FNBW41TO9MkFphUuUQUQSLgaYWsd2CnkfXBz
	L7X8N7d3GtkibsG74COhbhPlWM9kd7HfKxbeAeW2D8aLRyoyoFz57/Cra23C5PbHuajSZS
	eVcK0cPx/dWsVtcRDJEqD/AkZmGetcE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-xqj8XG0AMSeaaOMJVdtw4Q-1; Wed, 30 Jul 2025 15:25:18 -0400
X-MC-Unique: xqj8XG0AMSeaaOMJVdtw4Q-1
X-Mimecast-MFC-AGG-ID: xqj8XG0AMSeaaOMJVdtw4Q_1753903517
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c467931c1so19781939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903517; x=1754508317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEfzs12KwG9m5a8L/OU1+VFjO5dA7Lh78TnbObJb7DY=;
        b=rOy1BtKts3O/Ka9xiY44ZkyYPqhlejnEEBWLGATKWDDm26dxCw78bablGqshsWoSw/
         qnVm3SARMA4YcCZVZSjN5FNNlXea5GN2PXY3nR6EjI/Pxf4oWgVJEI/1fuB+ycPsyDqu
         ZSiXu26OAS+dlRk40fjjVe34ZWKAPskMdH2DW7/wJxH7G/rXZo4mxrc5ebYNfk1wT9xE
         oFoB47uzbuadqG91W8O/vFtwWJx51MvcV051wHWELZbHkoC2NSTdPYaOAfZTAGJUdVfc
         dBdfHI4Yu2FWeTKUJ3hFlJBPE6L7A0N+qM6EPOByYVmH2rTOu1QClZyvcBpRTZ9iCuAf
         g8+g==
X-Forwarded-Encrypted: i=1; AJvYcCXVO9sXffLcsYIBHst8gbqY+VyBKABmqVLrzvdhlPnHk019jn6dJQHnzeFqDpFvTp56E6I2Yg1TCFDTZYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8RyeBfCY52+F9PF86xLDg+4ZeNH5aO0NyYJm9tFzlcuqFOW2
	c+9Dms8Jo2QVn+ZCIhS1Tr4zoAHlkKA0wvaneqFY/2Fr7DXk/r+2eSsLyK2GtGUA/6Tjbqc3qU+
	/FaYKpKHG4YgziqfoVFahOeBHuZGZxLJEdz5r24fT3aJBrOC23ZO+CmgOZn6J8gc4vV8OHCJyqt
	9zoaQ=
X-Gm-Gg: ASbGncvjYsC3QLaFGaujrHG1KygdtPgrTWDnyyjtpn2YVBCHQCevYb2FMusAQsoFO3f
	mKNLveN7iGBon/yd7I1El7TMXJWxWunq/Wr7VrC3+U6KiNcfb99Hk0IYmS0hE9eOe05PUrj6CF1
	IqozIRtA6dIDCusiGANyLLdn23g3eLND96P2kKJciXf1PG0KWnvTZGUPx/WR3DB7t6ifD9G5P9M
	gchcDzYqwKbzaynVMtxC3dyojYFtEp+wj+qX/k9IDfpQ/GTUiZLoMBJsT6JohUzGoXLhjnf+59R
	OdVaf63nqrU4iYF88fUPsiZuHwGK+2O6rviuC0Jq0S+x
X-Received: by 2002:a05:6602:a00c:b0:875:bc13:3c26 with SMTP id ca18e2360f4ac-881377137e3mr868053739f.4.1753903517275;
        Wed, 30 Jul 2025 12:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSI5R0bI3u3DKzzNn3KOYViNQi9Qe6fU6AJs0MUhFISdXELzv3d0ZVqXPrG24JPPMCaPtNw==
X-Received: by 2002:a05:6602:a00c:b0:875:bc13:3c26 with SMTP id ca18e2360f4ac-881377137e3mr868049039f.4.1753903516975;
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Wed, 30 Jul 2025 14:18:52 -0500
Message-ID: <20250730192511.2161333-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730192511.2161333-1-sandeen@redhat.com>
References: <20250730192511.2161333-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

296b67059 removed fsparam_u32hex because there were no callers
(yet) and it didn't build due to using the nonexistent symbol
fs_param_is_u32_hex.

fs/9p will need this parser, so add it back with the appropriate
fix (use fs_param_is_u32).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/linux/fs_parser.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5a0e897cae80..5e8a3b546033 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -120,6 +120,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
+#define fsparam_u32hex(NAME, OPT) \
+			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
-- 
2.50.0


