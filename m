Return-Path: <linux-kernel+bounces-735630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863DB091E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CFD1C46A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D32FCE29;
	Thu, 17 Jul 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMJlWvv2"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F92FCE05;
	Thu, 17 Jul 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769793; cv=none; b=eFhr9KXLnvNaswpq8KwTYGvZX+Lh/6xqYBnLRN7FP8ED0YqMuPxHpAqr8QWG9bQRgjlljUteJgjX2WHlCFugseTgQyEf0R6ylcz2mQuj6sKgdaud04eRRpL/Q96IO/JbNWufzTlqlUb47vSA3xtBRKaYDtrcG7rVJ3xiBgJliJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769793; c=relaxed/simple;
	bh=APhv1ohooqunwbt1ilpE0uWE0XDIAzeQB7Zkt/Wf6RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6VNbOU/Az03CU/g7ut/SRfVqjw4s3TcwdepbZhrE0wrDvLUfhjvrw4bzPzkAydhB5+phFUpHUz8I0HnwREBbcHamB0+BVn7zXUeJglvHo6BRfNg5opsShNgpcfGFFCParYuRzNEUCt1A1UP9Shbr8SKPXnmkAVP6FG5uxlUwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMJlWvv2; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-611f48c6e30so570618eaf.0;
        Thu, 17 Jul 2025 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752769791; x=1753374591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ua9f7sAcXdU92kQoep+0V7OjMGT5TY4UeJF4Gmds1o=;
        b=kMJlWvv2btEp3SgfooktxVLSnam90nLPx0WiPrO4ONa3fOQOC9X3QeCiQPqKHX/eh0
         ftCSwe7u/O5SstdFdRTHklHaaz5xgGBRHIFU0Sq2tb5JiRea/9Phq38xtyo2BQ34NsIm
         GZz7E32DuZicTTPS3zZGQypvxjHdKVCKmLGrpYx1hI0nsCYAnD7LFXCIMgN5tNVSGbWg
         hyqBqGXY9dMzXzUxVdDd+L2+7VeBz5y868BLV6ZE6yUpRVFXgZVFh3sDi84wFjUB2QE7
         2g2mgStvKBKFscm6YiTHITTzjtM5saEzcuR1MSjFe8eL8qvJsP0ppHZcAybFw7ciI5IB
         LrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769791; x=1753374591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ua9f7sAcXdU92kQoep+0V7OjMGT5TY4UeJF4Gmds1o=;
        b=JwPyFLP7n8YFfGPU2RMe8y/0Q9kYoCXQtoPnQOqJwt0LwSytBh/fagtRJ1sEyWbT5j
         pB/noO6Nuwu/KlF+iNgnsz/j4wLonTaSrFjoIbK6eUXRRMCxZz/Q8a2D0+2V1hLB7W38
         R94168NmCNhboB6LjxknAydtBDSCwKEmO8AsilM3OdJyz8xA+FvgVXcjxzzjJgMHDMbf
         VJT9BJ2s+qTDoljZM5+9PfH8NlsTVdOoe/Nojr5JXIrtzLKKcIu55Ybq6iC1SS2SbDZV
         tC0HOJ0leVISddXN10FJbwjB7b/sQYlaFoC/eAYZygZ/jma/I7opOEFe/jkfvxc9o/iC
         4SiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4W43RR+m6D0N/etgY0IBjQTsOLfXHq8vWVJnBmip5xSwXKpD+reGZZRok8UY7kgYJLR4R0mWZq8NWbb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfmg39G6CMWkDczkqLnjI/D5kL1j+W1c0fACGmxaHbPz/5q7o
	7/PqBTfLfum+/X6V2wdvL5nhtob/8KafvN4zivPB5L6mOhuLTSOvyC+JOG6PyZOY
X-Gm-Gg: ASbGnctOTpMP80b40wp3W+760dBIcy840CJl/w5fFrqzdURXo5jFg53a0qhK3wO1Elq
	Bk4+qSX+RqPkpmpQBRvXf7Tb/hmIiKrcEGSzk9HKkCkhBPMwHEpJB3didHhxgatHG4nGG+RZX+z
	6fMd0wUirz6TuphDHupHrk978kivxXsjtofTt/ZOE7ZYd770nIqp+4HPBoJMFzzCbXOP9nXLNhT
	WD8Cx+3xJeUCKGY0Nq3vczvQqYsmE/p937qmngLhHWbc6USixo3ke8DQROeN6UmWRLFGIoQ573q
	3cbIpGRYDCrTKwWXXfwYdQk030JvYZjJ4tEIfVTXg1FZqm4i2ezgDW1prQIr4WATAd2Ufe3giAg
	nZLBNAGq2LOwUv0Pm1b0xcja6ctkTBm0usrjNq6C1N4w/lBdTw0ld
X-Google-Smtp-Source: AGHT+IG6usb5+O6R8me7aVnWKbhvkdAP83e12EMhLiK/66uff/hRzZY/MEYTTNwywqlNiwHTFybaiQ==
X-Received: by 2002:a05:6820:518c:b0:615:83d3:7269 with SMTP id 006d021491bc7-615ada1031amr1530004eaf.8.1752769790899;
        Thu, 17 Jul 2025 09:29:50 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f122edsm2870462eaf.27.2025.07.17.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:29:50 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add patch-validator to dev-tools
Date: Thu, 17 Jul 2025 12:29:48 -0400
Message-Id: <20250717162948.23078-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <87wmjy92r6.fsf@trenco.lwn.net>
References: <87wmjy92r6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 at 09:38:00AM -0600, Jonathan Corbet wrote:
> Interesting ... overall, we don't generally have detailed documentation
> for out-of-tree utilities, though there isn't necessarily any reason why
> we couldn't.  But I'm curious as to why you haven't submitted the tool
> itself?

That's a great question! I kept it external for a few reasons:

First, I'm still pretty new to kernel development and wanted the freedom
to iterate quickly as I learn what checks are actually useful. Being 
external means I can push updates immediately when someone points out
a new common mistake (like Greg just did with the date check!).

Second, I wrote everything in bash for simplicity, which probably isn't
the best fit for the kernel's scripts/ directory. Plus, as Greg mentioned
in his reply, many of these checks really belong in checkpatch.pl rather
than a separate tool.

So my plan now is to work on patches for checkpatch.pl to add the most
useful checks there (where they belong), while keeping the workflow 
helpers as an external toolkit.

Given this direction, would you prefer I withdraw this documentation 
patch? I'm happy either way - just thought it might help other newcomers
in the meantime, but I totally understand if you'd rather wait until
the checks are properly integrated into checkpatch.pl.

Thanks for reviewing this!

Thanks,
Ignacio

