Return-Path: <linux-kernel+bounces-881602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFDBC28898
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3086B3BA83D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 23:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A51E1DE7;
	Sat,  1 Nov 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im+5SDmF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB41FECBA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762040669; cv=none; b=mRMl9eO4O2FLTAAoOWdV2tHWe4h8l3kYRfG8xU+n6lfFJZekrAALg1D/z5YpRyBHVbLxOKMxS/zqgRTyVLfTTd3KspiKkerOiz5IpjROLypptiVIpFwJhetcj4IJ7Wae6Yq3rJ+OEQ2y8LF1wIVAfz/dtAWWKkKsl48HWC5T5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762040669; c=relaxed/simple;
	bh=jh7KR1Uq6F54HgOUIevcql72dp2/doXnUhOqdIkZoG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQN7Z+jPHrYs3b6YATdf6D4kZLcpfmxqotp5X9JuQaMngb9voI6RAp913eUUPsyZtHfB8i9qqmWH1BGbO1+izvcp8Jqm5R2U0sXr3/x1Eb7kP9Oqw1dLdG25ZNVkwo7qGzn0KKoesGK3w0mwGVrEnmGTkdDY09t/IMHnnSSdKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im+5SDmF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2958db8ae4fso1396625ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762040667; x=1762645467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5xrL6w1s6Y/SwQgHOGtWpqSk58YCr4boule2VrLo7o=;
        b=im+5SDmF5tPZ4a5UnxL2LVPvU9FUg4lX/xrf/PJ4CD3ZPI/ZL+w0La28uu8ZNT+yI9
         buAhJ89vnkuNU3Kl5967D6j06vFe51WJaYyDYROXZyr0e9dEKuKjE+hn/T8mkOXe6t6R
         hvUELjTRG8fo184kg1ubxi4ed+FIT53SFi4TQFEa0OS+G9O6ZabD9rmF1bR0jRhDuzMQ
         kcDpX2jhbTEIXwLMRY0/64eyrqROhMEMNFGtEN987Sc2vcVAVhbR8J59Y++yl69XJWzB
         DGgpQAgpjA24dENnZv0Pgj3W6TUMF3ITbwNNGKfi/XNFRHT5apHuogucAmX32UGIeTlr
         DbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762040667; x=1762645467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5xrL6w1s6Y/SwQgHOGtWpqSk58YCr4boule2VrLo7o=;
        b=RhW6OlURsrj6LaA8pnoTjJoSUHxtSpejlLBWkPhQ66mO2I0jSqZBTzUJ/LLLwc8aM8
         8N7/AMJf2pgQOobpdpXCvB21MGRrxD8/RRz+lKMncAMpzNg5xr9vjZ4R6i0WK5ptAkLW
         OsJEV24MnLgOzXSy09wOrKB0UJ6sOkYlA0MKpsG8ZqI7H8ZsfBntugZExvRa3nT66sjU
         lMIFzcefiBFNad65iM7+cIv43miLdCerd5WZpz2r8f0f14U1iiRESFnqGoGaLisIPSLV
         6UJj1acyWRLE3ZPGgjMBO9uFZwy/tj/Z81KQul5Je2E7XFnW89txFYt7D/Q0Csys86NV
         QKgA==
X-Forwarded-Encrypted: i=1; AJvYcCU1g8ReFhrtW43v8n2Yo8FyTSixT6ObN/6955Utj9kCsxdLhsHAfzMTo5D/eJ2P/jvZI1CQ+lesPRtePNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10aTE9vrCOuNhade683d3zOYTyjhxAl8faIyqP7eIezKXFHmV
	JHXm1SQj7yUeCLibrv3pOyP7nSxa/kwA6jsbr3peawK9BVpGRG2yAvpM
X-Gm-Gg: ASbGncu/b35l7IfsPjLvaFnmWywV6NAMD7QNyTXWEpLnVE9EiyU3h+muUsFNpQ0T7nQ
	iXxAiduTFh/7O+b8aUrOCKpZxzEPwytduI3TKt0RRJ4GukjFm+O5enyi0NkNZi0Q4qEu0+r3pSz
	sMOB+aav1KU87EIVo8vV+Ea1Ywy9PMPNPIj7TJZaSLBma8F111WldQ4h6gHWSGJNfaw3Zf0h8o6
	y8h22jtTJi6F7dU60Xf6hJCnfSOilXDoeMmt+AWj7huEWJjiPlij5e22TO3vXBZoXyNHCXZfjc5
	W415mBFCYxpJ1WRSiNCU1nfZKvZ7tcltpN4FD1uz2FWciVDIuyxiF3WTBk8WsFfkI4I2rJ1oAkf
	SX++LBxxNe4i41StRDKOxHn6UNLJ+f6SumrQvYBnVjwsjsVsxb6xgXpj8TAmCEFZAhp6Z3eLOXl
	DuhaO/Wkl3gQ==
X-Google-Smtp-Source: AGHT+IHes7gAPMGnU9C8dtef1adr+TMQgs0cEQ/JgUMpaIjuvVBJgyDHwEuzKah+vpeRkyOHYuQGpw==
X-Received: by 2002:a17:902:c942:b0:295:7f1f:a80a with SMTP id d9443c01a7336-2957f1fb69dmr17823945ad.27.1762040666931;
        Sat, 01 Nov 2025 16:44:26 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340b070ec06sm4370384a91.3.2025.11.01.16.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 16:44:26 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	rabenda.cn@gmail.com,
	krzk+dt@kernel.org,
	mani@kernel.org,
	liujingqi@lanxincomputing.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	Chen Wang <unicornxw@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 0/4] Add PCIe support in DTS for Sophgo SG2042 SoC
Date: Sun,  2 Nov 2025 07:44:12 +0800
Message-ID: <176204064246.157916.1254578946904175496.b4-ty@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1760929111.git.unicorn_wang@outlook.com>
References: <cover.1760929111.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 11:32:55 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> This new patch set is a continuation of the previous patchset
> "[PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC" [1].
> 
> The drivers and bindings have already been merged into the kernel
> mainline, and this patchset will focus on submitting the remaining
> DTS changes into the mainline.
> 
> [...]

Applied to dt/riscv, thanks!

[1/4] riscv: sophgo: dts: add PCIe controllers for SG2042
      https://github.com/sophgo/linux/commit/4e27aca4881ace1e9a812fc2c88b33dd84e29993
[2/4] riscv: sophgo: dts: enable PCIe for PioneerBox
      https://github.com/sophgo/linux/commit/b85ad0d06a19de95d41f91162389a1bbb461a405
[3/4] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
      https://github.com/sophgo/linux/commit/c6c215099e89b1eb71ed6592163ae5b530f4538e
[4/4] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0
      https://github.com/sophgo/linux/commit/579d6526aa43a155c8685a88ef8350a8c29afa47

Thanks,
Inochi


