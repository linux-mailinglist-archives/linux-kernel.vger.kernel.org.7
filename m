Return-Path: <linux-kernel+bounces-875278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2F4C1894C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B02F18977AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189BF30C619;
	Wed, 29 Oct 2025 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j29ntzDM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668C2ED846
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721333; cv=none; b=pfI9MsQAQ8gOCXDX+V7zEW8lB94487GC/rpixI3TULGHd27MmmThPoKx+vXkCCOPN1XD/GUg4jJJfVEnaS9V2VEiRQFqHcxC/nVlsJWJF3nIr/sEgllFt8cl4FaH5RmLJ91+7ihKGsIlauhQiQ7NfRpvlKBxCfleMEugHqGMpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721333; c=relaxed/simple;
	bh=bOMMbexI6aDIrNtf5vFEnbq7xQbKAIAvzY9lE5k/XRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI40E7IbcpC6c5xdGczifpJ4H1tgWaxSWz0Hnxf41PF+IOvqPrEUX2JHBExYgB7B+21u9oYfukShXy+9qjpyYxYn/ncqdq6om6mmehupwN/dc6oMONd8OlScx+ndqFR9DPyEp2DTrbceauVYu3/RMWsCqWnoOEK7S/AJTP+mx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j29ntzDM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d83bf1077so424227066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721330; x=1762326130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJozr33q7O27eAQclKBlJRIBGxacAxdnJElnx38SopM=;
        b=j29ntzDMrMILNznyMnLaFNonyxUQlkI17x0SAIP+O3S3kkRi6A5wz4D8Sh4N6ipdP5
         bXNJXLez1aVZ9szkbqccEd65LzvkN8QJFNy29rRUEaRL2S1fTqWSrAlNnLNLkx5AG+rk
         Yh9Xg2JEralnbPrlvuVekssLc4/FLAxJBPNLj8K6NLZqJKv2mvsshXtIC+HRo+Hm5EH6
         inOLl3GfFrmR/sEI7AD1KVrW29YDyiHfIUtSQkHRoG3gBQlu9w/RSkS3mLAG0SV4P7ol
         q4O2r8FzF55Z4oFF63Pw/GV2F1psb4ALwL+c6Mqu8zS+Kcmixkt3E349qPGnB8v/pk/T
         rciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721330; x=1762326130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJozr33q7O27eAQclKBlJRIBGxacAxdnJElnx38SopM=;
        b=hoq7hPMnV495SgFwWVWi8whcbc3/9O3XuODuvPREJ2zM0UhDdsDhAXoBGoPjFGAd8V
         SJ4E+ol7Pd5Co4GUbqR0mExsF/8c5LvDYKkKl1Vk/wvTlLUWRsvaoAlZC2nOVzcVq1vq
         nNLotMW6w71YR5dNq1mcPNSCL5mEWJK0MmxAVKcCO4b7ieEb5DoPaPcoCaRB62pM2BoD
         EhOFts2QMCJiApXdqz1rYGdaAfkhUwuC46IWN/2wEgAju02v+3Px7t3TfsNBvqmCb9Iz
         5ptQ+EnvewOdLJSej6WOHSMRhGGkxXkCEaopE3L2UciBsEhLj6T5YhqjkUOanZQJD76k
         Yjug==
X-Forwarded-Encrypted: i=1; AJvYcCU9CrbkHd01hNxIZmxKgePvo6BVV7of5waHNjW3VFGmSPwaJ1TGofyePYaUQWv227+lGgomGWAmFZLVqvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXm+kwYbB9szFpecNaKK77vwKdEr43FIB4lkoiYFt4XTTHseg5
	+RwemdlgvXhuQzhEeCbCPiRepFWPndWBtTf5XcIMx8FolrAG4KdwdcvK
X-Gm-Gg: ASbGncsJA2Pd4ItH4iPv2DP5pyTG1UyFJYy9auV5YN7EWCPhlpIV1SDxjrA+ZBAef51
	+e6qb0D/Jv2moLyId7q51h7ATHiFNIUVqyhZ2/Ua8mc10YlaB9zudkpHpN+MdGxTIGrqpI6nq2Z
	J4Hl7HR3JWwBS661ab9geGTXJpawRJlvrMHNb2d42Hs0HAR/cJ6a0j/7sxuIC0xqqovcTnwW7Ab
	LdhuWymy6qIhcvOz0s6BbFceiH/oGUMi34pXKzSAmO4mLMPHvAeJfdgyo7bqHQWmGM0nIXXwQXJ
	HLEonOa+sU0QF/5MdOOCLePwYJISGdv5eLovP1BTkBEasyoWlIp4piqYruCOdbN9hcrp4685sX/
	/tLqS6W25usBAPRWW5rfP9G+EmhigOZhzTQ3nq+eeyQTxjzyH9p70evJd3GHQLmyB1gL7lxlm1t
	tz
X-Google-Smtp-Source: AGHT+IGTI1ZIZClWng4yye7JAJ7wCJzANK4Z/hes/dqfq35lpCLXUzEK0uKqA6TU/xduUI8nwCqpug==
X-Received: by 2002:a17:907:971b:b0:b0d:ee43:d762 with SMTP id a640c23a62f3a-b703d2cdeadmr175477166b.4.1761721329730;
        Wed, 29 Oct 2025 00:02:09 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853386d8sm1318508566b.18.2025.10.29.00.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:02:09 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jannh@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@yhndnzj.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v3 11/70] ns: add active reference count
Date: Wed, 29 Oct 2025 10:02:01 +0300
Message-ID: <20251029070201.2327405-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> Currently namespace file handles allow much broader access to namespaces
> than what is currently possible via (1)-(4). The reason is that

There is no any (4) here.


> On current kernels a namespace is visible to userspace in the
> following cases:
[...]
> (3) The namespace is a hierarchical namespace type and is the parent of
>     a single or multiple child namespaces.
[...]
> To handle this nicely we introduce an active reference count which
> tracks (1)-(3). This is easy to do as all of these things are already
[...]
> + * Inactive -> Active:
> + *   When walking a hierarchical namespace tree upwards and reopening
> + *   parent namespaces via NS_GET_PARENT that only exist because they
> + *   are a parent of an actively used namespace it is possible to
> + *   necrobump an inactive namespace back to the active state.

These quoted parts contradict to each other. You say "we introduce an
active reference count which tracks (1)-(3)", and (3) says "The namespace
is a hierarchical namespace type and is the parent of a single or multiple
child namespaces". I. e. active reference will count such parents. But then
in code you say:

> + * Inactive -> Active:
> + *   When walking a hierarchical namespace tree upwards and reopening
> + *   parent namespaces via NS_GET_PARENT that only exist because they
> + *   are a parent of an actively used namespace it is possible to
> + *   necrobump an inactive namespace back to the active state.

I. e. now you say that such parents are inactive and can become active.




-- 
Askar Safin

