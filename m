Return-Path: <linux-kernel+bounces-796154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF1B3FCA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D25188C8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1C283FF1;
	Tue,  2 Sep 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGs1Jxi3"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E828466E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809326; cv=none; b=BWpSR0U/O/cldYYjOv/e8BIafNH7tIsGlilM4KafKRygmBRMXPxeaGwbfgrm1oX5JTMC4rfDrCndOdyc7pr9thNGIOeOr3jOkKWN2S4E4U7wbk60/q/9aEwNNvLVTu6yv8Wk/F8yz2PPdRwTNMcheG31eR7EP1dff5R3aIH0djU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809326; c=relaxed/simple;
	bh=Oy0+ZjgcUTHxI8IO6SmQY8/8YB65RaZy/XYvD1uhubU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1F7gZ5tQS4Af/4cGYHOOGzUvpHqSLqpxm0fZmYxEb7YI3CtLH9Z84PQ29G1m9KrxGiVtibmpifo1204MGX/xpcjACuDoyL3bOW0AUuBOYx2rduSuhJibCHJz0rClWT1txmnodQYIYN38+dntJFX2JoS2jvbBvdL8R4syYFD8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGs1Jxi3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77238a3101fso1978569b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756809324; x=1757414124; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oy0+ZjgcUTHxI8IO6SmQY8/8YB65RaZy/XYvD1uhubU=;
        b=LGs1Jxi3dBLQMHDh5vmstyv4CX7Fmpf8uNaFpjE9cHUd2fB1w9yDr4YxfRerz3HyEP
         CDW14/pFtNT9Oqum8fnUCjE/0jAltzxyPlEx1XMfrpCtpWahHYSCsQ40vGFdVZnXnRMa
         Y2RsY/Ei78CJ/u+2ECowiW23gS5//DawQK1WHn0Z+Ho1UAdMXnocFkyudOWLsJdW5pbJ
         dyDDWsGSuCa0AdqYO+jUjxx0Yr/MtSGjmOsHqMQRsZx5qW9a6baa/fRi9vd1DdknkQ5A
         lGmyq3eGhgg9RxhYsYhV2nmWeBkS18mj2apinHvpTsrFvIu9j0Kpli7m/hfAhuFmlcLV
         lp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809324; x=1757414124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy0+ZjgcUTHxI8IO6SmQY8/8YB65RaZy/XYvD1uhubU=;
        b=fTRn6eNgY7TrurOURTiS6iylWsnYOBIejPhn83qCXrHsD07/E5hx1N638ydT89WYC0
         fvoSLepfRfefGSlSdeSafIOKUwDUFQJqtW3qhI0dd9pvB6K38wYyGBMmRgqhpyoWZ1Cj
         dBCpD438WnKnKtHLwplDhp7KWlqYebLKmoW/gvQTP642YWvy4O/MNxesDot0zfuGeVuY
         /HQNDLL/FFjO68xc2BqA7OPZhdmR9SwzGWD88Us0OXDbRxzqZtfBQy8n7G9sxSPFpGjk
         yNvRdjlZaxCa+mrY6KvCqgtwMfrzgQI4zKbQaqDHQYRJyj1g4WkBIh47QLth2CU/eAv/
         2ZQg==
X-Gm-Message-State: AOJu0Yy3Uwx2odm6T/DKtidaF0DUxeG64m5m3Tdz9iW7+/ea73N944dA
	LJoQ9AFKDQmd2YcVA8FPUsU+BAfntmeOXkivXn/NLzx7tWs7v0lmB14W
X-Gm-Gg: ASbGncssLo7gPND83zUYK748/eZ5ldJicqXQsyzD7MQyu+3uiaDOELgH0XSlyOVfKr2
	X4FB+G6+xQucmxxY3yNL8Ki141CuA6X7GiV0zlq/g2qir67b2hgXTZLdtJ8HGedoKBFAbwuodbB
	T69JmsXf2mE3RjHV4tek/vkQKiPLloKZV0IkPECq5D58keLk0GwN8gCPdbg3CgDMdW1YC5/bJpg
	tfOh0AMt24yk5Bvpp+C0wXVANOxGzArdo7HYVC200m4IfmDCmGflsn2xGRhHXR2Kpc+9SVEQuEe
	W0K/uxh8nb/LlGl5U09Zl5Ed+0m1wn7QFL/syuC8JjjqDZPhaHWbDGCuyVUBKs8oEsrYe0jZctV
	B9kQMQLmfMhYFRfumVDbSPFhsDVN3gcxcTcDTJuA4ldgm/AuIgKvA25fU
X-Google-Smtp-Source: AGHT+IHBEIcoAXiQBDvntsTjV/I1iMaCm8Wm6ePBm+ak/qeK1Wqgqu0CzitAXYtbtdQW05BUkEvq7g==
X-Received: by 2002:a05:6a00:240c:b0:772:3aa4:226e with SMTP id d2e1a72fcca58-7723e33851amr11538796b3a.19.1756809324019;
        Tue, 02 Sep 2025 03:35:24 -0700 (PDT)
Received: from [10.0.2.15] (portal-nbc.netapp.com. [202.3.121.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a4e5sm13363163b3a.19.2025.09.02.03.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 03:35:23 -0700 (PDT)
Message-ID: <2841bd1b7910bd0e1b263b393152f2cb13dd3ae3.camel@gmail.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
From: Martin George <martinus.gpy@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 02 Sep 2025 16:05:19 +0530
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-02 at 13:52 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> The NVMe Base Specification 2.1 states that:
>=20
> """
> A host requests an explicit persistent connection ... by specifying a
> non-zero Keep Alive Timer value in the Connect command.
> """
>=20
> As such if we are starting a persistent connection to a discovery
> controller and the KATO is currently 0 we need to update KATO to a
> non
> zero value to avoid continuous timeouts on the target.
>=20
>=20

When would this ever happen? Won't nvme-cli & nvme/host/fabrics.c in
the kernel ensure a PDC (persistent discovery controller) would always
have the KATO either default set to NVMF_DEF_DISC_TMO (i.e. 30s) or any
positive int value & not zero?

Do you have a test log for the above scenario where the KATO ends up
being zero for a PDC?

-Martin

