Return-Path: <linux-kernel+bounces-884390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D15C30169
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3CF44F742F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2B26ED5F;
	Tue,  4 Nov 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8C3XyMb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F1A41
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246170; cv=none; b=bHP6SnWasZ1gK7PoMu4tpsGLuKlUyEPekG8RzSJ858uavGWL/HVLC+cqI1nCsWk91BjYuLM8KD0fd9eTJb3Hc8MqhEoQVRmI35gsj7pvv70B3maMQ2fCXp267nW1t/NYbJ69o8lbHAQ+xxf1fseTQ+uDyQ1rqqqxB7tgheJWEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246170; c=relaxed/simple;
	bh=bwGYumF3/kIIW+zzveEhCKzNJ0ATBCRDR2j8OQO/23Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhzmW261LiFxhVQSeLd0zPFg4In+cc88Ld0Mv1j3A4aw73zpXzwBI07lr/Aie8ctQqIjn70ovsWnb5BpVpvRB1UBniOO2y9gNcADrS51SQS8YqSnNBTWD1F5u+LYf+O/PJo/lkFQYuR/nlsZ7WWSiEExdx5EzogGLVgAnVHdEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8C3XyMb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2947d345949so46860295ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246168; x=1762850968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZzjlCCT3j9j2Nd7pQrTgnxvKhulGcz35Gruny6M5Bw=;
        b=B8C3XyMb9sztvNGcLQuH6oELUi82MwvYPXNmWWwVZIXfJq8n/xMbwV71TvTKuLCkJZ
         xhN1jiesHsMzW3f5vJ5e/b/BdlT36STvsi2Pz9VXlkWjzW28wHdkMaGfdW4prBvnhyDS
         MnBB0MWpzyg0WAbTKOcRL0HEqKKGGILWd1tYLmmM9mltkl2NNjAMKWQQu+5GQ4dZkI/v
         LFfZUOu3NcG6JQhKzcrj4R1hnhUnY1lN9PJLWHKdhJY97SOZQKbSJg/lRiPjkrecRkot
         Uqpm7EI7EdWWIfftAaBZjndccgCh+JhKr1Zy6PsTyIwKgLM4nLR67MZ8H00wsYwfKZIe
         Jqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246168; x=1762850968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZzjlCCT3j9j2Nd7pQrTgnxvKhulGcz35Gruny6M5Bw=;
        b=K/xuvswUVwPmi/5Sg2T1oelbso9elChHrZNRkbqUHn3crDmG2JuRJQ17hWJdUz7S72
         Ce+/6ITh5lspzqzSv5erQmcNWT1NYs83Mn/nxN1IuWjjFOcdDr3s2bVOrujEpQfdYGf5
         pGF5XEgOHIl9zddZjBkdu1zBzFVVRetUB0fZXdKobOmWbBGfWrAIPPKdkyDeKnuasldQ
         WZZ4aGCrtf+8kx1wdUQxmKX82bfDDLAbmSaYmsgkCoapaCiupATBuR+By5pQZEXPPiFG
         JPrxZKRDNV0/r3k0WnCqplMt+6UhLhZnOFxDtdDlkUO1vhRRFXG7fRarMza0ZUHeJf1H
         wLVw==
X-Forwarded-Encrypted: i=1; AJvYcCVsIm8ZFP5WVNLcuIJK3cCzxwx1R89V4EYyDgeXOnt2547SC0OGjUVSw9WNYmv5MBImd5y9Mb8wN6H3/TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSBgSIuByCE//OTWl/HSPwB/tmdZZMEhZyCcRV8ItKyTTaNGg
	fobck6HpNH9GUIRnW+aRtKQn76PbJ+kkSVjnSa/hMyq6xHxvlvJde72q
X-Gm-Gg: ASbGncuy0QfU2WKEgfqN0GSLzl+NTgaDkutziNDWax6soZylcP5EyBd0Vwhlgkdx3V6
	hgYgfbs5ketY7rTQz2ns/SYdv59nDbXBRMyCEdQKksw/hgVShOcevRY/RxNwxyEEqW1fOENWcZS
	gMBYmmeGvo6OJJCq6H1yMI52Gh6cU8atUGtrqzFspW0JBLbPBo1hVyzhK81zIds9Udvcxq7yygt
	4QZuxsIo4NW5k8bq8NGsdWjmQdlEusikR0YeyeQZOR8DwsCrrgvcpOVxfMbMxxOyassGKoLR4E9
	LkSZMGvEpwbfiUOBWE1u58oTC1/fDxajSnIuQrv9MxLDjOwCqc6GAXOe+oeX6+noRddcVoc4XRk
	4uIkOyUZAmmIirYJApt8Os4MIUJN+fMgge4nnYwQ02shLkoERLna5h9oPRd+10ZG0BLXi5ntJtz
	v+RsY8Qs1e1IUj7fAz6NNZuw==
X-Google-Smtp-Source: AGHT+IEjMIiSe0x3JjyWJftYAjRTnLk4yj1+5guJH64mFdGd5LprT3gQcg1E9FYpKQf1UnNjUVPGcA==
X-Received: by 2002:a17:902:e801:b0:295:7f3f:b943 with SMTP id d9443c01a7336-2957f3fd4d1mr114855785ad.28.1762246167913;
        Tue, 04 Nov 2025 00:49:27 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:600d:d663:3d9f:b9aa:53e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cc1sm3692393a91.18.2025.11.04.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:49:27 -0800 (PST)
From: Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: thomas.weissschuh@linutronix.de
Cc: Jason@zx2c4.com,
	agordeev@linux.ibm.com,
	andreas@gaisler.com,
	arnd@arndb.de,
	borntraeger@linux.ibm.com,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	christophe.leroy@csgroup.eu,
	davem@davemloft.net,
	glaubitz@physik.fu-berlin.de,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	jstultz@google.com,
	kernel@xen0n.name,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	luto@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	nagarathnam.muthusamy@oracle.com,
	nick.alcock@oracle.com,
	npiggin@gmail.com,
	sboyd@kernel.org,
	shuah@kernel.org,
	sln@onemain.com,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	tsbogend@alpha.franken.de,
	tytso@mit.edu,
	vincenzo.frascino@arm.com,
	will@kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [tip: timers/vdso] vdso/datastore: Allocate data pages dynamically
Date: Tue,  4 Nov 2025 08:49:11 +0000
Message-ID: <20251104084911.6961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit breaks boot on Renesas arm64 RZ/V2H and RZ/V2N platforms.

The boot process doesn't complete anymore with no obvious error logs to
indicate the cause of the failure.

Reverting the following two commits fixes the boot issue:
  10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically")
  6a011a228293 ("vdso/datastore: Map pages through struct page")

Cheers,
Prabhakar

