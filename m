Return-Path: <linux-kernel+bounces-842170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C89BB9226
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 23:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B0A74E3BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F0212566;
	Sat,  4 Oct 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/O6fbgg"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEC8634F
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759614844; cv=none; b=kYAc22vvc9Z9ugakPheP59cnARtMd8TRwVigthpP/cqzv2zYwq6zvFyJURGJfSL5YBWpW6ovbLYWDX9h9yNRgW1BY0KeEz5YVKOYWl/A4lGSvBE/TrmfPqog4pKMb0iqBMf+S66RdRy+22RG6MJWvLtgMq4z0IgRHPBJOdK7UZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759614844; c=relaxed/simple;
	bh=zxexh+35U9GNnXwegDKxlL+r3KbSOGfCjGc+Jsh1tjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdpnYJeDq25lmHUGA5c2pQ9aqlHmvvrBDgNggV/Yf7W7j7STJVH+ZLVRT1DHlp1Z0HrnKzUaZ491+vMhy60fJiX4e5Jm+5P1BtDRAOybTnYbYx8NI3sZcMYxYR1OQE1+kD70Wq4ZKG9sy3JZtFHTX8vi3DgvpW6qn40IkrF1P/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/O6fbgg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f605f22easo3123621b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759614842; x=1760219642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxexh+35U9GNnXwegDKxlL+r3KbSOGfCjGc+Jsh1tjg=;
        b=L/O6fbggEOBKAdmDLNgs9qn715Frujk2dIFfuqQ2t1o2jHE72ET+E1BuHD5sJXDoLa
         hNDhhwGkzMqmK4UZS7KIVzDoZ1Z6bXqAWH+5RXdCyNjEJsEABkAz6KLOZtQzqzv2kPlC
         ygTNUDSDVHY4Nevb9P3cXTSFyb6w3Hk4SW/p7g4FRA5nrL6Z9n3m/HvpDOnA8E6N6bRF
         zwKz7CM2GAl0MOBmcBrxjbdr+fYuFLRFDz2e6Jwh8+lJ/OqQnjFBV41gPdFRuaDoPiDh
         0bt2clb1oIr5cMNqzcJFZcjMAZFANuV5v8oQtYeZXbtomYM5EB1X3ZbMF40iP+YW2e+l
         mrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759614842; x=1760219642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxexh+35U9GNnXwegDKxlL+r3KbSOGfCjGc+Jsh1tjg=;
        b=EL6101uzYG+lC0Pt9+zU+4gLTY8VswhTBkm6ItrNkahm9zKFpO5UNrZQwWJf4tpbOy
         sWrwS2djwVjoyTnPXtEAJQpzN/zNElZr4gkRJ5MGSeFPoMZQuqjCutszTXeXtcrR+Jlc
         Elu/M4JNjF54KBJ0n+NNW3KMCEeUWdj5mYdomDrfJjzSGaPpFx7d2rocv3+Bp+Ix9JEW
         wFHs8OTiqw0+hxxdXPAjv2QxRufoKZrnKVkhOGmIOD42B30N+0HOvVcU1DuyoAqDFGG5
         AKSjm+8uyhYDNmF2FrunJ/4z1ZWkm1wyMNfUey5tAmBMJvzdn1uvJlF9jYZ6DFf6VLYe
         RjOg==
X-Forwarded-Encrypted: i=1; AJvYcCWeFboBhDtAFSwOkFUzhZkQJq94demQG8BIIzYMSM1EA9nJAIfxOu6OHPRCgqBral8jAIm5w6tsAK+FAjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1umomT5HhXLjCts1Ikr+vnxYu1srsdPSbui5XwMD0SypM6/E
	BvDUUyryu0AyONIDSKHLktxwjR6Ot+UHzOvrHFIQVNuohfjkt3gs7emv
X-Gm-Gg: ASbGncuqdyFuTtSjFVqAUyymJg4Q0xsWCE6itTFBvT7NTrpak9jGQj88zquk2wsHrdc
	00RNkfXQSvQ0+HTPs4fDI/KdpxFF9SQkYrUFuhWu9L5LS7OwsFgGMsWm9D2htJBX6sVpZWhIlqC
	ls5K73cItudODmd2IlH/H5fa6O4RI8W05LYIuZL4Lo7Aa4NbPv8Z08NC0iJRkr7RRxntSAyGbSC
	XZZjVSIX4xNnwE5+lkhpenlpAAkU+PR3nbrTxNRx/H7BHRIu3sitH6FVnvY8+db7FpSBXHM4Pl9
	VbD7jwy1CEUtI+1RUMV7OOkk4SZMzZXLQX9ltbv602LnH2QVOBwQgvTHDvv1WLPNCrCcNxkF0co
	oBn/gUwPIYGiJixqpPbi6LagzzTkT6NIHSiMa+OyXeNf1OdOp
X-Google-Smtp-Source: AGHT+IGH6bEyRisGqf588P5SSFQ2lwrqlRVRpXO2MJSLdK+MPp12z2YHX0o2DMnsxyRvlRE0E8ybvg==
X-Received: by 2002:a05:6a00:23c1:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-78c98dbf293mr9167334b3a.18.1759614842099;
        Sat, 04 Oct 2025 14:54:02 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020745d4sm8340722b3a.72.2025.10.04.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 14:54:01 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: mirq-linux@rere.qmqm.pl
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	madhurkumar004@gmail.com
Subject: Re: [PATCH] misc: cb710: Replace deprecated PCI functions
Date: Sun,  5 Oct 2025 03:23:04 +0530
Message-ID: <20251004215357.1839791-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aM7Vab4TWill5vev@qmqm.qmqm.pl>
References: <aM7Vab4TWill5vev@qmqm.qmqm.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Sep 20, 2025 at 18:25:13 +0200, Michał Mirosław wrote:
> Acked-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Thanks for the Ack!

Has this patch been applied or queued somewhere? Any feedback on the change?

Thanks,
Madhur Kumar

