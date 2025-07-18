Return-Path: <linux-kernel+bounces-736376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A37AB09C25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24865A3D65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488C219A9E;
	Fri, 18 Jul 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsSSbfl0"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B85215043
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822820; cv=none; b=WyrK5rAoEb0dFxYtRU2ynfU1OfZyGUkTmzm0mS07mRr7q9U8yckehtwNLUXx9oOP011HJF88CgJoNcavfPIWeBMBecgYMkdqgZY3Nw/IZHgtNovonmO6qfGjPxff3TNo5H0ajwMoaLhXvHLyqaXyeQaUvW7mmJ1/z2Kn0ouFpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822820; c=relaxed/simple;
	bh=XnntMU/9g1qIHQUyx4VOpPDXVeVre57QdmM2tkazN7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7PVyDKu/1zvAtn4/GTxVWFtg/1PXT82xRCfDBg/BaNer6YkopwEBuc4iP2j8/iij1XE56SRcUKfiQZkI10SIle09V6XeoVSdt3rRidxknVKZExH4J8Ua9WZ9UvA57x4WRIt7oJFVM0uZa9T+kFk2/JfteZwtsk3odAkPtUAF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsSSbfl0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so16649566d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752822818; x=1753427618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnntMU/9g1qIHQUyx4VOpPDXVeVre57QdmM2tkazN7c=;
        b=XsSSbfl053VVFId2mFPnVVw8F5mUPsPOgrVEleLGBgPA6zBZPddBANGYQtXTUu1Iq2
         vAGM/GZV4pySMLxch5rpUAQPA/BenvacCljVlfGkcaLkg3Xtkf+eEnboytWmV20HuMw+
         TYgOmhv2klkxOClxkPuBiU+c0YOoqp2W03+I51Nu7sNealNVrieuRI5VdNOd3w1inFYx
         DXOsDAD/BqhB4ZkexHbCfxTRI3AM8ljyhCL5mFGkFrOPlKO8fZnuS0dFCFqQrqSbPyZY
         5n/OMQf4ku3BILw4IR1iejMgYbQDo1sI8YTxnWJTsaDbZCOuLwza/2f5gU7y9QjiSF+c
         7DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752822818; x=1753427618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnntMU/9g1qIHQUyx4VOpPDXVeVre57QdmM2tkazN7c=;
        b=oaroMTntP/Jl8K2jYRx2AmDJjRHkqTyYS7SHXeKjzWQe4x8SGK9oOGmlQzCknAiYVl
         f8TgAp6i6Tp7RdHiF7g9vI/Ag81w+PYzaKaNwqcZFyDzHU5SAxyyf3+nGOMgw9cMzzQf
         9UBjaVwLrAWql1pJ7/tMdHe3j60Gve76XalRGih9C9whTzvBWDDrYhHL431cdXWPBKkP
         5Xfrcw7lDc1/Xt3xOB5dhqwveD88EvNxyScgBWZ4Kb3dFoAVNxCr+n7hazrzLslIWq5E
         dOv717zLPtd4cCyx34603kl20sAKd/Gyxr5gT9hOmGyv6OgTUU5FiJlptDR6EkArWzJw
         zD9A==
X-Forwarded-Encrypted: i=1; AJvYcCXiNwOM83r1020NWYlSHjWC0FYc9O/Ll10Ne/x1/Mvru0+HHLpWzZ7oqWC/1jPAf2kahw2JsolIlwsmoro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0fNufVCCLD9FUaGFdkbBG58wzOez1rxvdiAMiS88bPK9NpR9
	N1hLHC1Sr21wVSDsfUDD1YVI1NMB2CfTEPbJ1n4H0kFnOyJuLXA+PjWJ
X-Gm-Gg: ASbGncsrfF7KouwutzY+PG3rce/dBhEneOenH8B8Uw5Atb3Zyk7ZZwvrHbFxBX3mvpT
	xFkNSwaAyNUMAK/zgaQXIOxx4p7HnxIVpGO3aaykNwEADJQAEN9wT+LJIJRiE5qTCGgix34hh1u
	GczlBjuCDim9TUoOcgWPffrNU4vROqbQknAQLE4UvQUwLox2zgMicaqeXSfBqGDN9cczlECy4GT
	cHr5cuyFkyeSJNP7v3P2fhR4Pm4DFT0Qp3a4wWKW6paCboBXjyPD2yjaJ9sW1II6MWqc3GjhFC4
	ATW6jdC591wY5T+QM8O3/xL4E6RPp7ovsD3CYm9dESLoMrD0qTIFhwsPPf468K1p0QeF6tRhMq1
	T69IQt6HWp4TVFXME4A+osWvroSTbDHal+OBhDfaS3aR52a78cJY=
X-Google-Smtp-Source: AGHT+IFhkrR53gkL3P1emJDb/E/P+tL6SbS2YoE/IDUeCu6sTTfHt6LMTdvRIeYSmfCufo8sH6UZ0g==
X-Received: by 2002:a05:6214:3bc2:b0:6ff:16da:af20 with SMTP id 6a1803df08f44-704f6a57203mr124872746d6.14.1752822817693;
        Fri, 18 Jul 2025 00:13:37 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b760sm4397356d6.62.2025.07.18.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:13:37 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: vivek.balachandhar@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v4] staging: rtl8192u: Rename ChannelPlan to channel_plan
Date: Fri, 18 Jul 2025 07:13:22 +0000
Message-Id: <20250718071322.174671-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718015925.162713-1-vivek.balachandhar@gmail.com>
References: <20250718015925.162713-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks for the review and guidance.

Apologies for the earlier mistakes. I’ve addressed your comments in v5:
- Dropped unrelated changes to Makefile and init/main.c

v5 has been posted here:
https://lore.kernel.org/all/20250718025206.171361-1-vivek.balachandhar@gmail.com/ (cover letter)
https://lore.kernel.org/all/20250718025206.171361-2-vivek.balachandhar@gmail.com/ (actual patch)

Thanks again for your time and feedback!

Best regards,
Vivek BalachandharTN

