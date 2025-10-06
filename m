Return-Path: <linux-kernel+bounces-842678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652D4BBD47D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016BE3A5FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E4258EC1;
	Mon,  6 Oct 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl9+sAGD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF2347DD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737290; cv=none; b=fg6cBdyRQGZU4gDZs5KCkSF9Tmfrjj+9+PChwXrdM0fhW1DzgocH499Y10lPv4xeXI6mMLGJYhaTS+9MEF4NWEJL63pu0srKp+kl54fFUbF9NEstJ4qNI040ohq+ETOx1diUsUPt6RisvVvxd8NwmT+V5//lem8L6Jkia6nzAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737290; c=relaxed/simple;
	bh=NV9odVNENStyxZ7qLDwj7Wax6ioI4vbGv9QWrXdlsOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3bMj/uFA0wdT93fClSGaajqJ8F7edVz2v8jf3nE+kXTZvhIeUoGf0LiA2VYoqb+BQcaGkel2NNGxWLET2+HyN48Jpx+j/hA11zGz1sP6I4xlpFT27T7z1SpZvmKRpi5XtE1vIAFzBpxeEFDounoYHZ929lesfC6eaw/81x4uEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl9+sAGD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so65236705ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759737289; x=1760342089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NV9odVNENStyxZ7qLDwj7Wax6ioI4vbGv9QWrXdlsOc=;
        b=Pl9+sAGDK2tOFMmgVuLJ+82FTZiZ5OpWDt8k2c/55Nf+Y1dKiIBpNJGdLoxkR7JoCs
         TZc1WE6CpyF8oxsH0zoP2Cyjwvvrcus00Li2p0zawHl2zCGN6mzwz1qZAbHiCp8cU6dG
         PSTyN5E5hnpxKG9j+K18a9jWGxz+0yuF4K7K8rfToEIoQeeS/d06U0Fb8k8WPehpWzt7
         x1YWvPqyT5aR/cO/dpPgPH0SHu3wjwdeH86dqKXiz8sH8+3Jps9MTUHIsHGWpQTlXXd3
         p6j6STVeWzc3FlbA6wxIymUNiufCW6fi3RhhVBc2GGbuMU4T+gVXMhBsSfaiQK8lN08v
         7epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759737289; x=1760342089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NV9odVNENStyxZ7qLDwj7Wax6ioI4vbGv9QWrXdlsOc=;
        b=agSEa9V65IOmH3e6RMLafeYuNuRW2F3Tyunt7TsF6OAfCX/LNXIhmz19ZiInVbdeRZ
         7JmUCyUxNTOeBpv3MrO6J8vvypITxbsbC+kMWnBkBBIJypjXYJbDz6OxMrHl+xNIF2MM
         Tettnnka4NzeSo/MN7zPquv+QHXg3bcAmJDNvDD5vYngtU5cOYTm+b0cLZ7lxuERoBAJ
         R/aQqFaaE/BMFHlnbSSDnz5mb0INI029NuSAuXDjOxhsfM9rwHIGvNqZAjO9JrWYDthF
         spekkZlcN6iV6pBQr877YRlvAwUVN68XO69ojiLIzb/cpmRxU+Jni7N/eURAr9lsOrR9
         N7nA==
X-Forwarded-Encrypted: i=1; AJvYcCXJt//8KcBcsdm08WHQoP+eFhJIL63OoW+T4FUaVphMssGvu7mmXKMKoo+3vdYegkZZSshbBO8PPQFBMNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPIrbjaJkuAkkQgg6u6P7ASQFORqzPjoiAydwpuaBR6blbKOc
	qk8dYSQEaAEF2lZ4wCO6s4kjmeMKS1gnN1OVhx1G9edLRoig9LyG2mtAUlpCxMBDKHM=
X-Gm-Gg: ASbGncsJ5S6RgwitcknXl4/bGnWicMVAqPBZRRfj+o3hHyMKN95f6DhEuDIji1NeRdE
	UOsSk7TWlaUVaVvDwWFWvyuwRQ6sF3fC26x+zLtY1dT8CavcPdiIkANu9HSK/35yN0efEZZwX6G
	wCrz4ZiWxnOsgAeCzfMtsGBDzSEtNfMTyHJKPoR/wskosRLGKOoU/mo2O2WJFc3zbX/+JA5z/AF
	1RQtUthKocWW3hGOxoc0FyXkqUDTi48pSUKv+xSolt9STSo+4MOGgyMN77g21EHApfCwhLOSKoB
	Xue2ISJ5hudEaO0bMKVYIFfc5lliiSAhPlQdY2ot/KyT2JQUK5XYi5+lRQBa1WOlqu4iFq7pwVC
	DS8Ocw7u7JAGazVR/Tg+1oTKg3MV1NTj6HuCxpudtU1SUZZyT7GaZLX/E5BnuSB3WPHFBDxhh/d
	5gOyDUasr72uDK3RVHBpMucKXstkTIrdVRaGzvpA==
X-Google-Smtp-Source: AGHT+IHru+Vra/1nFYTR3oq1XBmM931fRClgQ3HO7MJwzWrhDgBX9rVkYzz59sy4NX2Ta5aYjCDBqA==
X-Received: by 2002:a17:903:1b03:b0:269:d978:7ec0 with SMTP id d9443c01a7336-28e9a62ffb0mr153066685ad.28.1759737288688;
        Mon, 06 Oct 2025 00:54:48 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:87f7:8f89:cdb3:c13:8077:eea1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1260cfsm123706915ad.48.2025.10.06.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:54:47 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	broonie@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: skip PMD unsharing when shareable lock unavailable
Date: Mon,  6 Oct 2025 13:24:36 +0530
Message-ID: <20251006075436.8417-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies for confusion. Please disregard this patch . As, it is creating a lot of confusion.
I will create patch v4 with proper commit message and previous link


Deepanshu

