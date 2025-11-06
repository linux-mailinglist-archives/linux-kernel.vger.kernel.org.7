Return-Path: <linux-kernel+bounces-888530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF94C3B11A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F41189AE24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472E340DA3;
	Thu,  6 Nov 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCH6GiVv"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348633C531
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433630; cv=none; b=gxhOELFrwbSe8IY1FnHgSjcW5DiBT8Mc5QBFOsStpn8AWJF+VBeM4fP6t8ZK5S03uQ+sa1SXIBvgZZPk+i80VvTBDs+iLsrs+DehT7A/54RsiqZD2Cv/hWK4Xm4I77rqve640NTfnVuxh8Sep9HtMRC/2P9h4Bsp+czSKjVDyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433630; c=relaxed/simple;
	bh=Q+gPCrBvqV9eKYawaaZc594PBuJnFIBv2mWZKk6piR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAxyceVyo05Zt0cKmg+YfcrlUp6CW+6meRW+ywT41kyM8bwhve0ikT13LY9zjg58pxiA+p1e3FyBh0tLNkHfRjtaRXGhYxr240JbmtKOeQ4xXFLxG2P85v7hE+UxZxXAxbhWHuvUJPKzQfqCP6eZf41Fx6VzmzoTI4lcI5URBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCH6GiVv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429bf011e6cso943932f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433626; x=1763038426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K34fjCYCGoSJdwCxfEsku+tPUzx/FlDGUOaZ5xDsmCE=;
        b=gCH6GiVveRDMs7EoevQ8mPsqJ7GoXyb7Wzlx3oNyF9R+WxBEHvZXnzB7QkdG5qG+4a
         PJMamgzZIM6+1CBE2P48CI6tGnlOGztEz/MC0pCChRh+SK4yCIFFB6J4pXyqGzUmS2Ix
         1lqX7n4vNdkcqm1FXrdKJ7W6VCLvypcb3hn6IxbORgHFKBUzR0XAkILT4D1Ys8F3EMGC
         i7rtN98eCRHHco2k5nb33pfJmC2i6F40OGI5m5/gC21Oe1Ji3AOcTZ85SaEsqOeyERYF
         d66+Q66n3m6GR/TGNjob0Pailh+lECMQLBxFO0tj7lyGVG/cAzii1u5ZDFXnsmh2O1Pu
         l47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433626; x=1763038426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K34fjCYCGoSJdwCxfEsku+tPUzx/FlDGUOaZ5xDsmCE=;
        b=BkkyCLgzZOSJ3/n3T7NpeifaqaO2J25X/VS6EnJjx3EXdfcZnRCIYmy7BSmFukAoAM
         lA0bGmoZAgEi9s7qdVRJ0ipPk+Gax2b8CqG1iRp5fEh7EiQ3theD+z+yGNHgXVTQ9WI+
         IN/Q+OnxlC37F0NVIpICNbUFssunFEXP4N7Xbuh6PsB8/5oxujB/NbU12r5FOi+BJGfU
         HxOOvEQmwD7eE+wL4B4Q/pM0WWDqn9kjFBn3SVXyLyuhE5/b0MOMvKFv7Reo8WjUOVgp
         roagPN7UHE1S9HuFoxRwKwzxAtcUraITkGGlc5Mv/kHGBKCT0rAQ+UoMU4Fz07iHPqW+
         3fwA==
X-Forwarded-Encrypted: i=1; AJvYcCWe/7T48VWs/QlJdN6flMZX1jDf3ifWfu35P+cw7ohiD9+RsIhaMSpmcpISTCcq9zwwy8fNf6IZ9qPYOVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinB5S/4DUzOX2YeS4jQSW5Pf3VfVf7Pbq0dNGbFpAWl0XevhD
	iFJ61gagfxCocgaGT8SXpWJ2ORP8ABMaA3fwyARAtGGE6wuNcqbUzhNqlI6a
X-Gm-Gg: ASbGncuxqH7jvhNhLPHBNn/1yZU6pw7V5srh7i62GyJdMgmdwLfNDPLE7VEZnL6MZO1
	UDbJ+uO8fVtROPKi71Qj8B0JWH3SiaBN43z9ZvbY8gR0EYZhQBkW6UEf3UEuBX+MbD9nE/7X1Jb
	IXY+E7Bj8oDrVYmEC1NpxzsqR4cUeLZa2SEgAEwyVrRpghFpsg5teZKBRcUWvgE4FmoUivvMIMp
	RteiGKBIE97hJH19bQ7nGRaN8vNf+fdtRP3QvFVNxKnHgnHpoc1SNN1kSXCwlQx/0nQu2xTWciC
	4OFMHApfnW5a3b+WZjb3vzcUPlcACktMpofzxpyWpVyhougMJ+SPzJj8r47AbpoAYOaCa/NyYYX
	C0d5DSYVZ/D0+b0DiDviWls4nv67xqZAYhk1lAhxPmHtvP1WfNggERpQhPHKrNGbmQzCHTjqBcP
	OdqKe/oxY24zQcRmRXw7A5GH0JfHxDz76TR4BUELG+zgf1PeNHwa4itsk=
X-Google-Smtp-Source: AGHT+IEsHuLNMGEHDB74IdUzyIrXs5wkTefXkfvvLRH9gq2+IppFGexW3BvrP1HGL9GdfsxYTxaF9Q==
X-Received: by 2002:a05:6000:64b:b0:429:dde3:6576 with SMTP id ffacd0b85a97d-429e32e6c08mr5782407f8f.16.1762433626184;
        Thu, 06 Nov 2025 04:53:46 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:45 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 17/17] bpf: Enable bcf for priv users
Date: Thu,  6 Nov 2025 13:52:55 +0100
Message-Id: <20251106125255.1969938-18-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable bcf when bcf_buf is provided and is_priv.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb672c9cc7cd..d48357bac9f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25961,6 +25961,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
+	env->bcf.available = is_priv && attr->bcf_buf_size;
 
 	bpf_get_btf_vmlinux();
 
-- 
2.34.1


