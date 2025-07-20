Return-Path: <linux-kernel+bounces-738165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA3B0B55A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDDD16DFED
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD31E9B12;
	Sun, 20 Jul 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRzeK993"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D357BA36
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009431; cv=none; b=trlyGSTBKEuqtw6SMaKDut/ajeCT857nHPj1Z1pyr43rAa5RthyYGYHzy437xWx0yKzgx6V/8YowVuyDv8wFg/LLv7U62kGKW82C6bNLj8DIZFQyLy8L4rmbzlroUZHLk903nDkzlSCeqKC2NhxXeWM+9/RDdyboa5K0ZYdCSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009431; c=relaxed/simple;
	bh=vOSsA7nfB9dWCWzxz/mt9HohHzA22K8Mk0dwOmhG+Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGpNKo6YI1M+UadlAK4yejsJfClySGOY6PoeZjmuw4k8iNbgbBlDXmxc9EVb+kIy8R+XthV5gOBGiQykpQH9+kIxOtPblRZl8HEsdGbWyyTLRdII/dfYW6UxajY8FOfVf9GS20xaTKJvXgEVoowW0RXRCpwwbn9c7cqaEMnCCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRzeK993; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso2706133a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753009429; x=1753614229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgFo58j83Q5d0TQPU/2HhoXFQl2twyXhmad6pi3wLU0=;
        b=cRzeK993rTs2ADP88zmi1H9WMrDhhaKGOBiczSStPYefCAWGV5o8SsnxqdB8w7bHT3
         q6bNOjfLgH+MtGdjYQOPnjgjoMeEAKCxTv0liH8Mt2eClaO9mzUbSiAjurn7CkDvxj9R
         OPg+Q1rMNRWy/mQaUKEe3givVqzev8VKwrl/AxmdDLnseqn4RX7ZuNPwVczkKr/ax9zY
         GbnHikFGQEOIdQ/qUXix78iBxlAEXszd/41kX83M/IzjG1vBy/tZB1Ew0HXqtUAoiSuJ
         nR/rZm4WdRW8/rQ1if10+GldNZdRA1wcSStwE/xaRggr05mlPKGQS8YRNqEYBNTQ//Qs
         AJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753009429; x=1753614229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgFo58j83Q5d0TQPU/2HhoXFQl2twyXhmad6pi3wLU0=;
        b=weMdwVk8jWRdnnEHzeVH+uKPIOhvv4wcrp3Ox2saePmM80/A1QiuMTf9KKhlr4e9IE
         VU21Sqoiurn/3uoddmGwYGasyiBmp2jJBBnMCYvJLw7dVlRUeRi9+KIOp13O2zuF3EAf
         OkxnQpZz6yHqv5Rd355ms7Y9vBLfFDyacABVzGFO4w9B4nL30eID63I3SxdPlIdcfbV5
         /hzx87ZYQMWEipA9OXt4zQWgb/hkbtCb0/qZipT90JP+y6ZmRpLkDYZgPwzB1+9hhFLg
         vnR89GtI5gDmUS+haHJxWzxKwSv6Mo1qWrrZ13YYNiVEHl+Xk6cOCpUpWWVqK7Be5jR4
         ms+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtKve1b/+dgTqG4J3c95OfaZcE7FFapCSckJFm4C8ykvy/tWLY8hH8IUFQGR1LENGdaSh9DLTGNLAuEW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7gQJwLAeg37WYOl2AxC5aV//YWe/EpHP13juuBAtVtEPdUew
	9nbcmhPCApEIz23mKVShDLLTEqxZScmyrrF6GeTACY8h8yYX5opR5ZPV
X-Gm-Gg: ASbGnctrSSZ1M4n2QnUgqg7zKsZQOUmbr2hGFEAfPuyI8EIAwTRAS5Vfrf0jZ8JvHkR
	+GKgQrYNkniV3cbuHqEDGBM5IPMZ4bNAFn/xQxWij6/N2Yd2KVkysp5xcy8p4WFLicDNy5MUcHs
	aKViUSw3kgNGKXXZfiRzhLgzoI0GenWq9ZvOQ3VO24TiTmbYcTsNcw5wTNfHQdhWeq57dEfth+p
	rYKckUJ84sGDl9oMouk2op0Pl2YDLNfN7nwcXOOz1bEajJp0USmPx2RZSFL28mVWwhXkmwD6aex
	dzQ8ur+W/veCsjYBX2NuetklLdTDSLg9nKPDgQn8TJcoKqktIM8oy2dR7x8xgLbjXVBN0jt+gJs
	7VazZ+gwYnIUGXdolfb6j3dVXh8XIFXFoAU88Bss/mP5M
X-Google-Smtp-Source: AGHT+IEC3T7iNUKHh/b+UR7rWVYIwnDvMTUwpMJP4BY7TKtHRc9feX+bFnmUmknDcX9u8JCffNGoWQ==
X-Received: by 2002:a17:902:ccc3:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-23e24e129d1mr282228145ad.0.1753009429279;
        Sun, 20 Jul 2025 04:03:49 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b490fsm40333045ad.112.2025.07.20.04.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 04:03:48 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david.laight.linux@gmail.com,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Sun, 20 Jul 2025 19:03:37 +0800
Message-ID: <20250720110337.55384-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f0503a61-f605-468e-ae15-c4934faea632@lucifer.local>
References: <f0503a61-f605-468e-ae15-c4934faea632@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Wang - do not do anything like this, please!


> Let's all have some empathy for this being one of Wang's first patches. I
> appreciate this patch and it's a strict improvement on the past situation
> AFAIC.

> Cheers, Lorenzo

Hi Lorenzo,
Thank you so much for your kind words and support. I truly appreciate 
you stepping in to provide clarity and encouragement.

This discussion has been a great learning experience. It's support like yours 
that makes me feel so welcome and passionate about contributing to the kernel.

Please rest assured, I will follow the correct guidance. I am working on the 
updated process_madv patch now.

Thank you again for everything.
Best regards,
Wang Lian

