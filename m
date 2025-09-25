Return-Path: <linux-kernel+bounces-831764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B719B9D833
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1667B7CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CBD2E8B75;
	Thu, 25 Sep 2025 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyK1vMzp"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC426E146
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780131; cv=none; b=GjCQDTe2R6Qojok+g/JQv97ih4pLq4mmi31AFBZ71yfxafqVC0++r90bQpne5O19H9vUKaCX11l5zHqdw0ky8+fRbqeoqS6LxecGH3on/B0mLes8HRnMN0d8oWOELVPDoMFDXWYGmurVd7YZ8/y3M9rKpgtC0iM+ogXMez7KUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780131; c=relaxed/simple;
	bh=XlDTU9cabYuuxQxafZIKIPtRVQZSY1fOoKVSyjkTGGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teJsEoCK0vG9Da0NT+mblFJC9SyNsoBZeWgsTkeGLCy1PllRI4gPOIi2ZMe/nmSSTfwYdvEzrD7OQFuzVdPh3AoC/gbbingPH/ButV5hc6ZkUNrDuj4xfPWY4eWQbtmA8JtlOl5rSjMBzC1TuACxMZ1TEhtMbOrd9Uwv76aamTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyK1vMzp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77dedf198d4so828384b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758780129; x=1759384929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw6r/w0TQoLUu4aRi3OyGDu4XdJg1UR/ogba8tN6Kc0=;
        b=kyK1vMzpR5+F4U74ZF03o705JskvwfuFqa2y0x8rqXMzmmd1tThI2eSxll/dQCoYSV
         ud54eHb978mu6sobRXFYgmRhvWkP0UnVB7zwSvI59LMvgl4Ai7FRL8UwGnSED3rbnkiq
         pzjIJV8MilwgKfbEfcbWJPYwbIs1W2qSP9vRqeS1IT+PBNgVPYauN/FtLMcGNPVtUzEm
         Wdo8PcxgeI9YBT2+uEYU9Qo7nozGHXtSIPpM1L+x5531dbnmPVsXcHMr5l75aVWmVUfK
         tx0k96+9esTm1aseA96l9IVeynJnPrGI8stIlJMT+V8jWijD4x85nZtSR2l7thxTgSQU
         bktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780129; x=1759384929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw6r/w0TQoLUu4aRi3OyGDu4XdJg1UR/ogba8tN6Kc0=;
        b=Cr5GrRMezX6Ph8/emi496RHg29PKprjeT/1DgAVKmxWi/E9YKzGbqxNN/nocRSHAYH
         Mp4CwnW4716Twn5YjvFVIYBnCTCb19r4oJ0GlREa5/js4ZVncvuljNFh2KkzDM6lCsE2
         iO/xj6JVZkltfrqxGiRyhrTI81TrbZLle0AaaxWeKguWNbstR14M1YKovZpKrYHTJx2W
         Um5dxgwh9nUVCNKLPeGUYwOvYtiGQ3D43PRhLkTIU771l6RA/R5hgDTQZDIZoFJyXF1o
         ylMckSGQIDiBl83vku8QlAkD20s1Azujz62NLN+1M7vaACwd/PDV/L4tkuUdtk9W9o0U
         tc1w==
X-Forwarded-Encrypted: i=1; AJvYcCV8+4eBocJrr22G/nJrvPBPvcoWKDTBrpwnBL6cEt+dvxu2NAYLHbAcp+bzMJbkOPEG6DkBb+rPm+2Il/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymc00unr/ky6oXpAeEWrgsW//Jxse6JMRj7WZ6w+fd2UfqktBl
	a8+Hw1f9Eqoay1Ztd6leeraXsgUEXrX8OiXKsGEggcGfLcGH4Z0M36cm
X-Gm-Gg: ASbGncv4nCFmDq8GhRrZIcqVMRTmkwQiHx3mvtzz0cqmNCWsK/GHxykavpTz95A/Fln
	aVr7Qi8BRHqfRt+MTy+5ylTMCRX+aEJcSrOVxsls6nSDhshtahFqtZ+ZamkyDBSjFgygjFYTT3i
	+2MvOB0CgPcr5AYpMFvs1DgYBzVgj4lWCy9RyLgbJ8dAiIn5fyqToQruF6zsZV5pPh7FBPn0UMy
	B6kaVpWfwpsxvNMQnczqcDMSLGZY0Zh3mSQTXRu19zSUW/d7lYcFzpeVK5wjhigclK1ilx5r+Yu
	No9D9B5lm6OHyYljECgF0OYAgW4IeU3RHRSPvpBJRkdb/A0cTkqLrOURD4S3kVGHciiOl/fzem7
	uN+4Nmk1rXnF9wbRWev1yZkjFc6jB/CeQz+aZQC8=
X-Google-Smtp-Source: AGHT+IGxtpO8fYqBJ4Up101RNQSuSSRj8mAjj4mT1f+xp6lmruNG+NZqgd7e02/Tdm7NWnRO27FsQg==
X-Received: by 2002:a05:6a20:7349:b0:262:1ae0:1994 with SMTP id adf61e73a8af0-2e7d83ba73amr3173114637.42.1758780129245;
        Wed, 24 Sep 2025 23:02:09 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238b19dsm916334b3a.10.2025.09.24.23.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:02:08 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	michal.pecio@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	skhan@linuxfoundation.org,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com,
	viswanathiyyappan@gmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
Date: Thu, 25 Sep 2025 11:29:46 +0530
Message-ID: <20250925055946.189027-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923163727.5e97abdb@kernel.org>
References: <20250923163727.5e97abdb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

I found the topic very interesting. So I looked into the existing drivers and almost all of them seem to be using `usb_submit_urb`s except `lan78xx` and `smsc75xx`, which have a work item to do the configuration. But I see no synchronization between their work and the data that is used to do the configuration (which can involve multiple requests to the device). Is there any synchronization that I am missing here? 

Thanks,
Deepak Sharma

