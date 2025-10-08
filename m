Return-Path: <linux-kernel+bounces-844966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89720BC329D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDA2189C717
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652429B78F;
	Wed,  8 Oct 2025 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8DpNFMX"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129D17D2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759890224; cv=none; b=Rq2/DLS+zVMRPvqI3zLYjoyb+s3+pOazwLfyAvr45d4us27epNY5mNe+lql2f1H4zBfBUELCeIEQ2faqHy3A0rHxp0YufBa8QZqLJKW3GQhLqMzutcdtgRTr7vBIBaGB9SG/ni4GoyzOwTbxY7YJX+Sapgiz5tCrrvMMDpGhBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759890224; c=relaxed/simple;
	bh=DRN9nitf1yJ+G8Au1VIUdQ+gcpZ+EIxz6Tw5s2KhrxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbEpAFzajuWGykA+MyMKbGX1xcGLWflNp4bx7apiRaqm+W3sj5nISIiNaEu52lOVgowgPV5WeLftu1vYyAc8BwjU3PDK2EHz/PJi5QljHnaYahU8+uNumuCtcM//vnmHgfehzDvK+l47HpF5ciFr5gLl7QBx9kn7ry1UJkhZoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8DpNFMX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b60971c17acso6055667a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759890222; x=1760495022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRN9nitf1yJ+G8Au1VIUdQ+gcpZ+EIxz6Tw5s2KhrxI=;
        b=I8DpNFMXFNPiPMHmliI+lh3FRoJ9hc+J9thaTusBCuLyfyKZ4VhBiGgR2bIwqYBLxk
         TvJzQ//OKxD4GahO48bAopiUWADTmKOOfPCff/aUe534Jd1ltEnSfHYG4ZQ8LueT3yRW
         /HX+Sddd8lnv6apE7QtWAufCIoRtioD78U/KZ1D+BXspWRdoPmLyxCU2ykOysWDgMxQw
         d4DCb7cDE7q6t4r5e6m4/AEna0jmQaMB/t0l6cJ8gkGXDn9Bw9710IGpNF5M14Rfh4wf
         HVtIp/anj4WFG6jaRFEtvmjQQRV9/yRs1tMSh43kBMJEwvkAPOaETdZw0WPsk9bYrCH5
         2qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759890222; x=1760495022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRN9nitf1yJ+G8Au1VIUdQ+gcpZ+EIxz6Tw5s2KhrxI=;
        b=taRb7kg5h4x4SqVIFm8srzt7wY6tK16lGzkZBnirE3mUFmZoUdtc6Ho2sfurBvt384
         ls+IZ8oo9lN3IQZofnsVw/uMuhCIkPlUTpe6IOAM20u8MFcKF/o3X5bLwzpblUK7AeA7
         dzU6jqproCgjeaXxvkoa4zT1YP51GhZnPb3pJ02luIH06yf/6IJMRplWnDdMWLfK40yM
         3C0jjXrPfsLNsUlH8apXz6cBfs6KTtyNNowfp7ttyZIqSsx3SsTAr0g2TDWewAd2sjkP
         5nh3ehoRD2K9eIJRuJtXmWqxrZLsUv6NOZCstqGwfCFIb+yaURTUfImCLzakakxaWpb2
         YyDg==
X-Gm-Message-State: AOJu0YwAsqkeaE9cWtzMKb9v8lIfAOtkmogkJ45H278DDZ/8lfTTAdf1
	eNGLRyMeDVxxla4GUQXTj18UBqhEtCJxyJIsiIucC+4ONbUOmqUXIlJ+
X-Gm-Gg: ASbGncuYHjK5zxt1ROVsT2EO5iPwsmLim3P15BFkfTowgznJcBNZvvrHi28tQz71raC
	9twpFWH5uZ3+/D2OtMKnI8bbV109CPlmqK881gOitcuUNzEFjEu4Z3zqDqXucWexQS8UyplRWdl
	Ezxuh1Twk/zDbi9N/Wx+GcGKO02hQipxdKwZ1t95KYX708jtKZ0Mz7JWf1ki5N3N+AwWUPK6BFI
	Lw55MdaH4XWHkJP3IpOno8ckMAZD3cXbVAPhGbydWrtNzomsvh+jExphDzBfTpqzmCUIkhAd0f1
	6EGsNY94O4HhPrnMZmh8bIMl3Gty1VvxedRYj53PMfqyfzHZ9kkKN++aT4j3ghWwHoeanWegAYj
	QYLg9bx58kTXd/9BObD+2Re2ZVwhNdrFkfxstNNXUit+IH/4e4+ZVjimqUjs39cySFr5JSQvlLA
	WijlFNbMf25vrlKLm0bkn6FJE=
X-Google-Smtp-Source: AGHT+IH3e15vtMDCV49Ai7e7cyEyfFw0j50B9+a2xFS0obFMpwYcx7zLqLQ2taIrBYYdXBxAst8OAg==
X-Received: by 2002:a17:902:ce81:b0:266:f01a:98c4 with SMTP id d9443c01a7336-2902723e35cmr21410655ad.13.1759890222504;
        Tue, 07 Oct 2025 19:23:42 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87e7sm181731605ad.82.2025.10.07.19.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:23:41 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: suzhidao@xiaomi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/ext: Add tg->scx.idle which tracks the current state
Date: Wed,  8 Oct 2025 10:22:30 +0800
Message-ID: <20251008022313.632514-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
References: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: Add tg->scx.idle which tracks the current state

