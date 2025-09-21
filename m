Return-Path: <linux-kernel+bounces-825968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F56BB8D3B5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2957B4AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8254791;
	Sun, 21 Sep 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhjV7ttH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFC548EE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758422598; cv=none; b=corCTiAwDzUQ62y6OlmHJnjLnVoANkVp+XjZ/SbIq/N7/77VWIhhFuWf/s3c464SSbVhYhHjaZe62do28xYQTqM3hMLIm4lvhSCNlDgMK2hMWx7q9YHApeYayPJOI9WwicKrJWHm1b+xD1v1D57oJe3FpME6NCOx/dYybzdQBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758422598; c=relaxed/simple;
	bh=IOLNp7bbvWfurHuoNIdJ0OXo/N5Q2rG8Kwy2TSpxEww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiLbQt3FZ9A+6G3LygsMXS2cyu2yU0UuovLEJkTzflMopqqSGH8VJQciL8HSQ80X6LvtHOn4yc7WhpG3cC+SjRVmKIe0kQbveBLwaKGnDw/FdO5iWVRH2HKCQnUw4uyGPfiMWiawdSmqnFNiWSvruz+yF6+VpiBb6PjvIsoDWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhjV7ttH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07e081d852so661780966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758422595; x=1759027395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuEJ7Kuw6nXBxfCflCZImXovS/FAgf8BObIoPTsH704=;
        b=fhjV7ttHOrlrbrtH01IvFX7CntG4DvBxipSKCbmNFeb1/wcuzEdqikiTbDNnHRKrQr
         nkEaMVH6M1jJ7nga/pW82uwiN7qAy0GJBMMM12DIPMmNjFXTlbGaB1gDy9ahuI68viWu
         nr5MAtJG516HckWQMgtqdOT2iJ7bwsU26y1HG41lMrtdJ44J0snLpW/2ehfPfiimpGAf
         hxnmP7OSoD57TWz9oaiMcV+vNTfZgPHM3PXaer3u2Oh8k/qGgzephwKWiCZ0lrdipz9R
         qgcJ306bkLKYp7nUyNTKBEj8FXvK4EE1Z+WGxpWC3pPjRi0vmo9pPAPbN9pY8un4J6/8
         kFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758422595; x=1759027395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuEJ7Kuw6nXBxfCflCZImXovS/FAgf8BObIoPTsH704=;
        b=UZR5GMRsOD787TuwPAvFqAx16Y1az1zW1jW8ATSr26Pl4RMLH3Kno5MjhvegNYGTiu
         4tedxyngiBfcnroAZ63sTCxbdjonqejmIDzbsBcpKQk3haaGKuDaKVJo213DfdH6r6LY
         V0crAzDaxUCGVSy/NlfzZcoGDnUR7K8Tl6Tq27oPz0n88gq8W56vNrlXHbHO2rgr2r+p
         7y1qjlKh3goDbnoh5ytsAjni/OHYxOMCuGzjlOpwyAsNfQ9P5QG/2H1jk8/bVhWxrUxG
         rOAG/3qoD9NXl7GXhLQsNqkkDLbHwWQGzztdnN44cBD33P9hiv+MVrDWu0CtqRY1UtR2
         Z4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXDmQ6tHk4qRd03ncvxjCa5/0jhh7tykaiJ1Uu4TF2i4Iyvz5nm2eV82DmeVxjGDoO5yrUxlSX6dZ+hhxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcnnc3qQr88jWBAho+HGc0/bQrwgLkz9zsZ3pqPhWP818+V5Ad
	kIHAcgcFp7SMioGT2g1y4yVWbDj3DUA8vGBnwboAVpsQZzq2jErUxdU+
X-Gm-Gg: ASbGncsFF+dr256U2pOK6XBqGNp3242UvwShs3gFoPBl6uOUQW3bqsZIWGF2LAMrP+B
	2VsYDjXvuqZ5eYD51JkFswcIP1rE/b+7StGGzSlL8u19MbMWzCnXr/rbp2+5fe5DRKO04SbcT6B
	awfhcObAZYnNgMFQQ9TuKUJNuirEaBat+Q61MGM+qPgWteTx3UeuVBPmFdhgM+6A3ZD5qSeajfW
	dYC7rmtJUdhSRiKQp998ZkgumzpRLL1JUFQYEl6xMKmTEUMRnYrAOmX/CgroDjnZuTwecgX5CBX
	Sp9LHRCSbYqwSfbRTa5xv53HqQgDJYKUCiZW9vl1kbzlF1m7FbgrfeWTzsBvT7gRT9hSRpc63kF
	1Ujj65mCcDZpyPpgGtHU=
X-Google-Smtp-Source: AGHT+IEnp3bNDrsmT04jwsuiPJbBPOdlnvUNGeBA+GfxOGwI+dq26By1MGxiqYL9UlRIJoqPtfeHuA==
X-Received: by 2002:a17:907:96a4:b0:b04:830f:822d with SMTP id a640c23a62f3a-b24f568a6cdmr856877566b.63.1758422595233;
        Sat, 20 Sep 2025 19:43:15 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b28be3fa38bsm224619366b.46.2025.09.20.19.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 19:43:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
Date: Sun, 21 Sep 2025 05:43:10 +0300
Message-ID: <20250921024310.80511-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aleksa, thank you! Don't give up. We all need these manpages.

I see you didn't address some my previous notes.

* move_mount(2) still says "Mount objects cannot be attached beneath the filesystem root".
I suggest saying "root directory" or "root" or "root directory of the process" or just "/"
instead. But you may keep this phrase as is, of course.

* Docs for FSPICK_NO_AUTOMOUNT in fspick(2) are still wrong. They say that FSPICK_NO_AUTOMOUNT
affects all components of path. Similar thing applies to mount_setattr(2) and move_mount(2)

* open_tree(2) still says:
> If flags does not contain OPEN_TREE_CLONE, open_tree() returns a file descriptor
> that is exactly equivalent to one produced by openat(2) when called with the same dirfd and path.

This is not true if automounts are involved. I suggest adding "modulo automounts". But you may
keep everything, of course.

-- 
Askar Safin

