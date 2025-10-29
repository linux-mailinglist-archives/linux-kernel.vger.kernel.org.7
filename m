Return-Path: <linux-kernel+bounces-875137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F7AC184B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9DB04EF2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B522D0C82;
	Wed, 29 Oct 2025 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCSzuSN6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DF213E6A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715818; cv=none; b=Pp0vkpLVcIiRwjKlLQicgzQNMf2pyrx6BGPBZVWHFix73vHFGn5rOR2QU0KuNgfJciaDt5nIUZjbfGYLefIqK/z1DOpzZM9Lu6xOkE0a0p4Jrl5BY/fWkAg2+HupUiDZX//yzV1rmSLTuSD3KUI9d9A5mXVS+Nln7RNUqDni8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715818; c=relaxed/simple;
	bh=KQDf+j6lWSbdmJagka2ZggVCUrfKneNyC6Ve+TcVxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KxQ44WBhEsTtAkArTgl4kIovfuNGgpa1LfH4EsfpqWN/G6L8oVy1SuXLZccjKhm1XHDAyZx4cz6GQ9WzGX7cuNx71HlRTPCP4rD1ANBQC4qR5W77mVV2Q6H/gdeO1uZdqf36TRX7q4idISip5WayPlNh7N8rIQXBrPMtpbWY5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCSzuSN6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4285169c005so3221471f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761715815; x=1762320615; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYokdTDrhX36UcN1b58PWjPF3nJOxVfqj7lGD2QXmPw=;
        b=yCSzuSN6iYfTHHsfXgxxbSE91faHCXzOqdq6F1IsZgXJTI6O72tklazw/1/gIR1W+h
         ELIkWIY1cLzGj1MUcaSmvJWnIaXUkM1jWIy0H8GkXrCz8rIWUp/wnVbZESo/jK29j3sI
         I4OI5MeutIsaFucBEOF6kDWw2H8wiVFNt0TK9mxFMeWVobBqhOP0OztIdpmybS+NKc+G
         KgiF0UQyTxh5zVb0EIt4AGNtkX0Ombf4QLlEdXlvh9LBnfg3njwooXdPJXsg9JcydqAA
         KrRs4VBAEIzoA/LNukxn4F4O9+5obvIuVh8K724G0aTZlFytYkgQbiBrQogxu7Jb6k+k
         7jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761715815; x=1762320615;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYokdTDrhX36UcN1b58PWjPF3nJOxVfqj7lGD2QXmPw=;
        b=Z1116QhQvrf0rq2g3lNd0ssLV7VX7N3u6JL53Lw23orBhxkI5H0u2azNdu+xjlaff/
         kS/yTOkpQtuGpUCGcs1rAjiIb3bsTulkhH7R8PSNSN/rwgg5VlYTsRd0TxpZylQw79bv
         pPhnvfhWJ802SHCRPsWRIAaazIUPEtxy6ozIoOq/8uDAY43BkcDxTxuShbGj/Ewecmjh
         Juf0bMKZ1IW4Lye6u3CS+LwvmSkabUEfyMtE/24ZYa+BM8pxne5rhQAYG3+gcmYDA0p4
         PDDQrL7jfrXO4zY5ZGCDhMQ+aMWbowsolZYlqN5gbZK73a7rwao5bm01AlEh9I24RziZ
         hJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFeEv+xEMMQGqefqIUD1K+sVWLqoRiy834yzriAYUWhD8eAtmqT3GFR4pGax+cLsnSJpz9YTrwtdJRnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWaIyc6k/QdBdZfyAvzvsooofWvAmsKet9GlSjWxWyW3q6XYd
	hK9jZ3mLO48uGLsBwy3s4xU5xYSbMaIfdX3GIyH2paG58AAyNLqHbINm4sJhO7Z+GG8=
X-Gm-Gg: ASbGncsKoBfNgP6xv2CdZ2ajRTxluu+WgiR8DLyJPXPAjW4wKVc8kvBDIy24dw7guud
	lowpdiNfVrp7BTQjNV2p7djArQNxuML7kGrKGfUlPG+h/6Xo4qGAZc8tAiKoQtPoX4/ZWclczkh
	H8KU67GNClr+KNk779Ck792ParVXh0WJI7L5d3Fni3xj+UCIkuEnq7Ue0JD8AdczYQeUaEirTlT
	laBfI9CbP+HOnyK6Xvx64N2h6jJM/i8emcRV2qTyj4y9vUnCLnTFNfMs2bfzwnLAO38FZhWUr99
	2JqZ7SO+dPKK+YOZuAylCUeT1HKzkOtUx+VDISsodo28K/QNDt2qlhEO6fG6JvOFc7X+ykYwSHP
	4isCDc2gtP41NJ2tnT02e1NFE+OuiRzFj2BM1UvbU1zA8bEoChb7iLXFpg4u/MzPGSe+SgbK/g2
	1UdqgdgQ==
X-Google-Smtp-Source: AGHT+IHfC6E3lLu6ybmmfp1SQT7iGC+X39jKfB/plKPnN7tDBkq5CsrdtgMBZl4VfAAcWqEotczZdg==
X-Received: by 2002:a05:6000:2403:b0:429:978f:16ef with SMTP id ffacd0b85a97d-429aefb9b5amr853947f8f.30.1761715814562;
        Tue, 28 Oct 2025 22:30:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952df5c9sm24207547f8f.41.2025.10.28.22.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 22:30:14 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:30:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Frank Li <Frank.Li@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] accel: ethosu: Fix shift overflow in cmd_to_addr()
Message-ID: <aQGmY64tWcwOGFP4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "((cmd[0] & 0xff0000) << 16)" shift is zero.  This was intended
to be (((u64)cmd[0] & 0xff0000) << 16).  Move the cast to the correct
location.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 473b5f5d7514..7b073116314b 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -154,7 +154,7 @@ static void cmd_state_init(struct cmd_state *st)
 
 static u64 cmd_to_addr(u32 *cmd)
 {
-	return ((u64)((cmd[0] & 0xff0000) << 16)) | cmd[1];
+	return (((u64)cmd[0] & 0xff0000) << 16) | cmd[1];
 }
 
 static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
-- 
2.51.0


