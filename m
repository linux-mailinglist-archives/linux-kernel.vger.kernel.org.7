Return-Path: <linux-kernel+bounces-829549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D3DB97518
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB97F4C7652
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0352302743;
	Tue, 23 Sep 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcTK6GYm"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700F22F75C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655149; cv=none; b=mVbwJ7sA5WIKMOR6Yg2WnP5UgesZtYmD/hCBA4+7suy2sJF7yof5+mOmdioKSmGyRR/vnjATosFIZc190bOLq5XGh9xHORoDb0UskGJaDuRBdtQgJMAlvO8zajbpeHMQPeGsbzRLRdyiApvCArRF/L04VHUxG4M112WCz5SmbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655149; c=relaxed/simple;
	bh=j68iQkt8LYLdP0pm2TDkZXC3Z0j2EiGpwyDL1OR3bT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWX5n3Wsx3uLzYiULQDOJUB7Ry97eZDYo/8uOmto/STWkCHY4YE948Th3T/JVxETzclLAH2cS3/MF39OoA9T3DqCVXHFuOw/xwkNsSUwL5R3uOx7+x+2CrxqojtDvANLqq1OFhJ3C4z/l1rFfFJI0oozSCsz9X2fxkVnxswgs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcTK6GYm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b551350adfaso4766460a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655147; x=1759259947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbcsb0sCYvY+w5FFqDnmrTgzyDe/+Ah4Gp2qKelA9Qo=;
        b=dcTK6GYmq6+0484szyuYKtkov96WuYlj/u7aSBIKaBD4cL6ZpI1NiXsi81xACHdoKO
         UkhHcbhjdoghOaNv7t5WwJrbzkMA/2eeOa5Dciqoj1ylWeEFRgdaYXhnNczWaadrNWa2
         AA7RZbjaFBkXX5RhqJHuW+QkCHOrqCnq2Xekq1hsvSs/RrYjmqyGG4TNDdHKTraYw6sc
         IDIgtfW/UI6vv4ugVmhkBkSH1kxYVYnXCzTo3rtbP0zm8uwrh/nQVIsxLUu+jdLj1Ckj
         pfBicBTrJyta9Dqaj8J+M1//iOk/ULj1StsfS90mhuymtKXk1fsk1ch0cr7W44L/obCe
         tpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655147; x=1759259947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbcsb0sCYvY+w5FFqDnmrTgzyDe/+Ah4Gp2qKelA9Qo=;
        b=r30t9MF41Ckayb94mnimUIadF9d2L7Jl11RpXPu7z3wgHQOizxHXwnvtiifwN9kVxk
         uXFoI0GYunDeM3P3rifImkP7SrRe7sgNGhZKLft5YleBn0J72uL2gZiVlFJXEfKFK06b
         lgT51h/uPZIfRCPxXgNWBwKG+XsZO1CYrRyqKrLOPUrp9w/KrshmTBPh4wB9hEa6jbda
         PG8mERZ+kdQJsYAtMFxX7K6FMY8Bi+hnyxn8GXO+8Klx6SjueopztZmXUsvbp7VSWoAH
         827gkcD/AUvBi0x0RCVV/5ngg3kT8Cl6uPG5OLqXNWX2xal6LvipNWaoF42tod/YhX3a
         VPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYzuq+FzKdOTx5zT7ZRiYFyTGvefuwajhJ/ZON0HP2Dnq9Q39eHuozgFwHhYBsTatW1R+n06IBC+LJtSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2EpeMAnENeUCsTPSOKoAFkwr2gAuomtfUnNUCQaE/h/wl0T0
	97Z44jIKUfc6a59SQqzKfL1lj1T3QrpM3dfhfJRXoVrOX/XTxJAJuSEf
X-Gm-Gg: ASbGncuXgleasL6HV75YAuFfsoX7V8d8RSavUa61153yP9psJ/XR780bJZzg5wqous2
	iXZmxMXbN8p+mejGboQzYUhVyzn+9Dlkk6IlT60a0QSTIDOeV0b1mDDcZWO9WFrDgo38m46SdXn
	dHg7GYxr0M5zLGMkP3QU6+r41rug4Iob7DQSb7ZE3emOCpxtT9Mk6m3i7HBtIK97vmwEZtnpT3+
	j4wpESfQUzP38JJopDAdjLO/rxSGxC74ZnZGcuXl/yVtTuEpIm8tQkUEJ8ivB/y0+gn2zG380Gm
	B2SGe2FfTcIAB/5IxkiqtraZ/JIvTrmfWADc/fL4HfzCmyst2gzZq/ZLL3PXWehDMELNuEJlakh
	M4vKCUKtLJR7YTHZh5tC6m3586TP+
X-Google-Smtp-Source: AGHT+IGqTmIgP7qTZknYhTvVrzzHpibNAC682mdtjrUwFehLQmjekC62tWj/TgAncaBjZCC9EqgTGg==
X-Received: by 2002:a17:90b:5109:b0:32e:a54a:be4a with SMTP id 98e67ed59e1d1-332a9515ca4mr4405139a91.2.1758655146795;
        Tue, 23 Sep 2025 12:19:06 -0700 (PDT)
Received: from itsmeut.. ([103.215.237.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607f0ddesm16995681a91.20.2025.09.23.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:19:06 -0700 (PDT)
From: Utkarsh Singh <utkarsh.singh.em@gmail.com>
To: agruenba@redhat.com
Cc: david.hunter.linux@gmail.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rpeterso@redhat.com,
	skhan@linuxfoundation.org,
	utkarsh.singh.em@gmail.com
Subject: Re: [PATCH v2] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
Date: Wed, 24 Sep 2025 00:48:57 +0530
Message-ID: <20250923191900.77568-1-utkarsh.singh.em@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHc6FU5C3n2wyO91gcDVLGr643d1Y5e4xPmM1d9rw18A=fod9g@mail.gmail.com>
References: <CAHc6FU5C3n2wyO91gcDVLGr643d1Y5e4xPmM1d9rw18A=fod9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>> Documentation/filesystems/sysfs.rst mentions that show() should only
>> use sysfs_emit() or sysfs_emit_at() when formatting values returned
>> to user space. This patch updates the GFS2 sysfs interface accordingly.
>>
>> It replaces uses of sprintf() and snprintf() in all *_show() functions
>> with sysfs_emit() to align with current kernel sysfs API best practices.
>
>I've applied that part. I'm not pushing this into the upcoming merge
>window anymore, though.
>
Am I correct in understanding that these changes have already been applied?
If so, could you please advise where I might track them to avoid any 
redundant work in the future?
>> It also updates the GFS2_SHOW_UINT macro to use sysfs_emit() instead
>> of snprintf().
>
>Huh, what's that?
>
Sorry for the confusion — that was meant to refer to the `TUNE_ATTR_2`
macro in fs/gfs2/sys.c, which defines the *_show functions for tuning
parameters.

Thanks,
Utkarsh 

