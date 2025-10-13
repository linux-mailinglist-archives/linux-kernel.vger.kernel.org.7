Return-Path: <linux-kernel+bounces-850232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE13BD24EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E32B4ECE15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73A2FDC37;
	Mon, 13 Oct 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQACJpuq"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8832FD7D3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347997; cv=none; b=uJyqI6SjUfk06qWhmn89JDXGgHJ9qWA3ocxOwPxOIWhyU3lfpUfJW4u0gbd9qYlQ1BuYWTWysGAa/dSRML1ycthlQpdm1RO/yQcxPx3kKcYKuw/457sA+9a2J6g6Ld4twN+8MF+EFT+Opaq9uQKkIIRQnLk6cPTz2zPdiHwkTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347997; c=relaxed/simple;
	bh=1+iLS6b/35Hb2nRBPY+kv26gXXxahMwbMhi2uq4fynU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEKqdPSapw/HaqsCPWk9M5GyHk8vPFOxgiCuprdx/B5iS9BwlM5gfiNeWMTJ/yRP8yIMF6MHbpCypvFuEqE/xm4cnk7TVpetJWaEDZjUIF57cKFpNKjRPesSA3AnYNZLycEGOYvvOZ+ketCASkNd6O92Rq92sAbeDiOvReUyCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQACJpuq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f605f22easo3410785b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760347995; x=1760952795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKlhmybHatxRpg5IBkl5HmNvsZrEn5pX6moYVoKC+FI=;
        b=OQACJpuqZ2URh/rlFM+BFPuIcgR5YwODyjA8t4Yw2I94V+VdIyY++3Tx5MkvcTxS1g
         GcPbho7aW1lIJPH+KBWgS9SaIIwdlsEHs2SGtXdHoVxxEbFxM4Bx1msW9X0PupZDogAC
         HIHCDv1EVGL/Y/viClg+QhxAstGueGJzWxLTEFzHhQOZXarnnMZDOwfi5+ebYZKklaUK
         w8OWMqunJGPEnnCRJgIuwO3lhBpViLazNzXqEoukTJYxXjbbm85FsYOFN7kMW8ZLRgA1
         9h5I7P4+HxsFBPmc7Pc+4mrvjWLLJPiltw/MUVff8q86eeIE+U3iCvdcn7u0wcFo6K/K
         5FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347995; x=1760952795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKlhmybHatxRpg5IBkl5HmNvsZrEn5pX6moYVoKC+FI=;
        b=lg8qPWEndDAlIKjQOB2zw/x6gQ3i+YOOdYgYRYUZSxs/YOx7e5dTsLMg9++oxnwofw
         6XUu61o4cPa4prXU7NsPQNV74kL+HPwkBpusnZYmhL09U7O0f5pL4i8KGrQuYR2TV/8g
         JlUDVNMrwiaPW3PDr7MMCWsqQ8Q4QCuSbHQdCVIQ+AqDmMEIKOprfxV6JANdXksu3ReM
         XVnAZN7Op5ns7WQaivDWiAXeGgO+N3oLWGBgoMyHb+i9yOeWBnd47z4lXWQQW1Ad3Qs3
         NAqH1POro5lkaUT0UgDhyO6VJgHwx1dttEJg8YJS5DWg0q1NQyZP/gfUlM/mSe7xTpBc
         aFmw==
X-Forwarded-Encrypted: i=1; AJvYcCVB32JUOjidSUzILGB0RNh511AwKZ4kpZ6Hxx32RVYyQRTxs/7YKECILQ46UARyzH4UA/lFGExnyNZEpcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4tAg6iMwpAQaH3F/Da8dlgdXTg33Ytq1mXWo3QzS8qUUNpcx
	Skv9EnqxDE9D+JAqX2EB1/LFZF95xHdED43cdb0kyMLgcR+7q33m1v9F
X-Gm-Gg: ASbGnctOBI8s7zn2QPCHAmDfH06aKtFV/vOahZf+uI/CZ4MXKHMVszbQyIi8X8Bef5I
	hrVJy8u1YaIOkX37D/H9rfyQpMF+F+gFUjEf0JZHJTuihgHxKYfJ091OPiChoW+9JviUwxVEsXe
	zntsgzYbGHviUOUW0ozK1Lkt0koWYJelqKV22H/2oURjbtxFMLM2cWb0LBAol4E3ZoTTd2y2oeO
	ictFWh8G+BdYOZRqJidEkDrdlFfEM7gcNk9WezW1Tim/L7KBsalTV8TU1m0cmEfW3QIfezFke/X
	UkWmSetRkwKMwdImqyX9KybI2aMeKRICzA8rI1aZat0IEk+d6DJ7YUeGH7Gv4hQ1ceJaZsYc8H9
	qmK+uMBIYmgpRCdrdFKj0r3jqIClpkE9BWPbeNGs76TDx2LbVafogPX/gSA4P8Zohm11ND4GK9w
	zEaapKO1MCF+u9GgdLBgEutw==
X-Google-Smtp-Source: AGHT+IH0wNeCmi6Nm3mbhxY1jYdf0pHFrePpYJ0QMmFlRk4paq72BgVsKzjHY7I++yEULkVs3KhVbg==
X-Received: by 2002:a17:903:9cb:b0:266:702a:616b with SMTP id d9443c01a7336-290273799bdmr251401225ad.18.1760347995071;
        Mon, 13 Oct 2025 02:33:15 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:abb9:ca1f:244b:3697])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm128568755ad.114.2025.10.13.02.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:33:14 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: =muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling huge_pmd_unshare()
Date: Mon, 13 Oct 2025 15:03:08 +0530
Message-ID: <20251013093308.4412-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

That makes a lot of sense - moving the assertions after the early return 
checks is cleaner since the locks are only needed when actual unsharing 
work happens.

Should I send a v5 with your suggested change?

Thanks,
Deepanshu

