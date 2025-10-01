Return-Path: <linux-kernel+bounces-839381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC6BB1842
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9CDE4E1B37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067502D5C95;
	Wed,  1 Oct 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReP/Bp1P"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107992D593A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343849; cv=none; b=bmF4U5LwkhPAGZLq0Iau3WlNslRoidqgCDxtmvp+pXsljaffwpHN+PrxW68DasgmB8WnN0XbmylWvt6oFHGmfZrqUTDwOs9JbhkYCd/BWunXLF+DseYeRsq8HuA1a0YgafMK1/wU+E4Mr3WsqB5yubKY1rBAZS2pG/YZDnf0AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343849; c=relaxed/simple;
	bh=+5IkJFQ7HOAN9t0e0c8Z504rwCoejlXiTWiCk6Ioxww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDrnvMsXykx5hMhLv5+mw7RxLuNHC4R54it2q4NR+frbd52GoRPBczzvIguJOxyhRGeBWEh32hKXHr+xan1nhpJhMcmGCcM3A2CtYc/HTZMJxl+pbiq39VF3otUljE5TwEeP1o/TxRHfTxI0UKCveadLPOWbWDSy9xIqooLFvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReP/Bp1P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so86827b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759343847; x=1759948647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+5IkJFQ7HOAN9t0e0c8Z504rwCoejlXiTWiCk6Ioxww=;
        b=ReP/Bp1PeQYK1sLr8cNLWwHj1m8fKLNNR1EMEYnC4lRnozdFkyyZo+xC39CMv6bqDU
         wsdK6ZqBaBYWT7ajwduGlxoV1zCIcUUU2JtVhTLmdVFmPbt3LEGEd4KMV0j1k5pBGRM6
         CcAmrSGlWUwMBjjPhLKMcNmFFHr2oq9WEcV9gDRe0G7o+5BsBPrUNJfzygidPlBa+qZc
         x+2fgCwLCJ2D8xfUjv8m3bizOCPEitRPXQcOV3uKT9Ds28Iyq4ovKick5zDyXvOcfvw8
         QXrKTXuSXLh0+0L3CCmWKVvL69vQ8Y1OLi+9JIMmP9bFHMDCk3Oq1bm9Dy5/X+FJrNsO
         KBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343847; x=1759948647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5IkJFQ7HOAN9t0e0c8Z504rwCoejlXiTWiCk6Ioxww=;
        b=NT6UQRctNnD9hK/kxSU7tkS9fGMPJDRgw4sKAThLXjf/ZCs0o6zRy+eOlvy4al20Bz
         q6eUc23g7W9sfrIqcRawlx7TG6H2ekJ6jqy0+XyD21dw4jfxp36QR9XK+P/dkF+2Hq+t
         ViyizInEAQfjLuZY7hnmvnDC5xdiB/4rskfq/si2YgPAVJVF/1grs/oh+L7ZqJN5USgv
         KhI5zBjZFmvZlyeEOjBvUYxB2OkjIuLDU757Go7rRCAdbQGZatFvizNYZvNAGR07LPDR
         M4vA+30l7uP3/7sMMMhz8NNa4DkeGR6wa80nfwOG29K/hY5IhwXN+79lqytKyk7cZVZF
         Akug==
X-Forwarded-Encrypted: i=1; AJvYcCXnfIIhPI5tYSk8Nq8W1L83OLo9BcqYzEIlw26FXOEwl6973kgDOSqm1jJA3a4R70eC7mocaeCSCvMwDEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HUAF0SaPQ5mon+kMmhOL5yaH4OBiAs4KKZZMuJitmsEQhx1J
	NFjvaZdcBjm1r4iBHa43WZe+y3oMyiH4TagiMmmZ4lAtwKtdckP0W5X0
X-Gm-Gg: ASbGncv4845mgeM/a/vt1/WBjVZxS19izpCj7ltdlsbvygf/v6pUTh9fDx3DaYa7K4k
	vgV0o2+XUCfcANItZIjadaIt48YDKJyhSzOjmN6DAZ5YQDjxzepn6e7vRW6j/qTTU1qhcHseXYQ
	TOW533o74JFX9XmBtEWcNPWyz8U4gpUIYut33gJtNKTaSvaczrhGut6IhUbB5BAUrGp35McWNHv
	/uhjKOuoZ7FiPgmLCLo8Hfvw2STz+kYbKDYGMIUyDYkeNScteY0CpJLRBwkFqn2Z9TThmwQ2pB9
	reB+/0/pHiez2aC0fMhfaOVh0YDyZy+wPyXzkORBACEvca/qayjgXLhRBSQIuKbQKAbqP6yacBf
	9ck1vIw61efRXReHXq1aZOk8e57sRXjnNdSQybkK9ZPOOrFWXYDNFsk/IhxFTHLNdxYLT8zsTRZ
	MxcJvNtg==
X-Google-Smtp-Source: AGHT+IHwGIweaktnau5NNmxNvpzDHY9rRZNzCTIssDNODC6+bmeuAJHCv3egmKb0AfhtHgEMmo2j6A==
X-Received: by 2002:a05:6a21:4e8a:b0:2b9:5bdc:8e28 with SMTP id adf61e73a8af0-32a24dc771bmr847091637.15.1759343847383;
        Wed, 01 Oct 2025 11:37:27 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f3b041sm177268a12.24.2025.10.01.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:37:27 -0700 (PDT)
Message-ID: <5ddd7fb4f2282fe697f1e7617206424b828d269c.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add test for BPF_NEG alu on
 CONST_PTR_TO_MAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:37:25 -0700
In-Reply-To: <20251001095613.267475-3-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
	 <20251001095613.267475-3-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> From: KaFai Wan <kafai.wan@linux.dev>
>=20
> Add a test case for BPF_NEG operation on CONST_PTR_TO_MAP. Tests if
> BPF_NEG operation on map_ptr is rejected in unprivileged mode and is a
> scalar value and do not trigger Oops in privileged mode.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Can confirm, the test reproduces original issue,
patch #1 fixes it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

