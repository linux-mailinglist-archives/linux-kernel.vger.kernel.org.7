Return-Path: <linux-kernel+bounces-783861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D9B33394
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D6C4204A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7371D6DB5;
	Mon, 25 Aug 2025 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5THhd2R"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17D1CD215
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085667; cv=none; b=de9QSA+lnFXQO5RwT3Ca1Vecon3NG726DgUprBXylIbBESryjGybWFHGQpjo+XDRwn8Oc97wS15GBod6FBc5nQY+Yz7oMEv7YuvP0W1nFch679NtzvurT3KTY2OkfSgcfxTIPYq0+KCTJvFD8aC6RwqC/e7Xn/sAftjSSchwaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085667; c=relaxed/simple;
	bh=jQXSyBiskAHIGVFWniLDzKdgSm0iDUCkPZHvcemFJtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8Q20fyR3ORf1iTVsHWEEx3e8rDr9wMHQ1/LpYEyKytmSZRxihUraD0u6MolnGFGgd7e9XTXjVzi9Jomyjyq5MKPBAOVyMhooYdUBg6OHJC8GtmuTCSpBQHFasAWFJbyU7kbpZHwtQdqM/jqQd2+QaYnZJoEvbk3YKbSQDZCWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5THhd2R; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2468e7c7b30so12205275ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756085665; x=1756690465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ruxANvCNocw1N+b5yop4AxWitum7HXSiuMUa0R3Qfc=;
        b=l5THhd2Rvq1jvjnxTzGdjuM6ekFbfD6WqixhIGzevrxK3S6WQrInC9XhjWoxIxPxDS
         IqPSB1UNRFjnhQrI0Nu01DAUvqEwVghAO2nYs81CeLCuFTTd1SDdwL3qOkLQzaE3luDv
         GCNIxCEyX0p0jF9WOkouJNnWlHTC1NMZEdMfj4Kb6uaFcaX6GVQD6GmA4n6azpvLkURi
         6ODy8sloUZLXzX7B+WEqR6pb3CBQEC+m/RxxSXXjA06My7vGs5Eq2mHWXoqsmlKw/JO3
         8gjGNuK6/n7ZrAeRnF3upiRt5/lIAj3GTu/ovEWdWowBeuMC2TKO2owVKokYjejaF5Xs
         gj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756085665; x=1756690465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ruxANvCNocw1N+b5yop4AxWitum7HXSiuMUa0R3Qfc=;
        b=uBXkyfaKaDPTfMMiENTzC7Qceqny0HVG1DWnZklvjSJHemsPdSr209LEhTkbNm+Tog
         0+J1z5gs82gaZHFd30cYT7oZBbX7IaqpX/6lhU+JMte9W8JHPYx9grg2vuhadjjLAmA/
         q9U0NTIaememYj7fU6lYQZFn5PU6QfIKZUkV4yaA2NU9J6oUgExl6sZgXLby5B88/ypq
         xC2FFHZOuqTskF8gMzj2UqPnFa+IJcFlNwKP4StZrL9yjxSkPHUQpwDuhstQ1cBsmg+5
         WleKPv8i5KehNs3k31LN7jwFAywF2775LhlKQcTALcuQltrZG3esqJVxR5LtFRX6flX4
         ryzw==
X-Forwarded-Encrypted: i=1; AJvYcCW15VXmkwtCmHyTY2lSrSW9fERMszkWaL1A/lKYohf2gnwl7zM2C5Ej+LyYUfF+IjiBjrH/JruFdFiTB94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Bkiwhvv8cjpEjIQiCZyMb9dLLufs7VL/WFiTie8LJQYSdNi1
	Ok/nMiThaufP1bBroIHoJy2RhijMX2zOClC5yydL9YPEz5zqCfBcVlwV
X-Gm-Gg: ASbGncv85XO4UUmjNLVvBDtchTpqb9FpZw9FW5fovd2tEaW96vV+QpSqzJ8wyCirfHE
	27/4mwcDrcTpfEIp4y5K0mkYFRZnWuan7mBt7ImkhYq1aDV1lMvmiU2ojgA+WriRiAveM6HZU7O
	E8eCdQdupBypwuAJDt1qXkQqueaI/yd/+234Za8OKmXhOF7xBs+QVLxOY4+zdbdSZx4L2ITqQhM
	OUyX1UbiHR/5z1TMz9wmOXSWOehjDYiwjhFvHCbIzr1NKOJ9Nz+yDQKRDNKh6t3t4YPD4VeEs8n
	/GTKn6SRiCJyr9TeXwbMl7LhS5/BW5RNaYOzMnA25oZ1lGvb1uXKLfV2PgV/1CVijLbYavMAWCx
	NWwUWNBwRRaA9GBjvj/GGCW8eof1vNO9cNdnUrUJ9Hte6nBdDDDCO7laejcD2vuA=
X-Google-Smtp-Source: AGHT+IGKOMZYl0RBxqjG9OkcEUaYyVXjoKwhdUdnGkOmzEDzDDuznhxZ65Ay5hqrJSncjK/q9K8gyA==
X-Received: by 2002:a17:902:ce01:b0:245:f2c2:650b with SMTP id d9443c01a7336-2462ef1d1bamr131430785ad.30.1756085665123;
        Sun, 24 Aug 2025 18:34:25 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880a99sm52425995ad.121.2025.08.24.18.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:34:24 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] mm/slub: Fix debugfs stack trace sorting and simplify sort call
Date: Mon, 25 Aug 2025 09:34:17 +0800
Message-Id: <20250825013419.240278-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the comparison function used for sorting stack trace locations in
the slub debugfs interface. The original implementation violated the
antisymmetry property required by sort(), which could lead to
unreliable ordering of the output. The patches correct the comparison
function to return 0 when counts are equal and replace the unnecessary
use of sort_r() with the simpler sort().

Kuan-Wei Chiu (2):
  mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal
  mm/slub: Replace sort_r() with sort() for debugfs stack trace sorting

 mm/slub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.34.1


