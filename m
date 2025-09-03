Return-Path: <linux-kernel+bounces-797594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEC2B4124E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B043207A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D5221721;
	Wed,  3 Sep 2025 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Ks2cjC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098D1F948
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866500; cv=none; b=RQSCj8xkpG6TrnEcn5BVFFwMftgzr4wf0Lllt43HQ/u/5RvJb3RRDC0ij32Ipu/ilFEjCw1PV7SszE0XE3qpLOwOpIZhJDrxAKKz77a0PI8q3aFACVTT1LeG+XVvvtsIm+Rvyrh8p00b+NiVpvzs3KQmYJAD4tF96DTdEnvi7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866500; c=relaxed/simple;
	bh=w632ilYPA2n+P2XmlWidLkI0dfcbmCHlhpvh3mQsJtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzOawLI5G8NZts4+DET+iYUzNwF+hTp7tm8h7afw2n/sraaX6Pfb9ISbRLy6d5ptWwpEYGvAT4vXEMCopjl9ybgisFoBpBzf6iRib2a+rvcU/mL9V1odNztVJNsg3UWo+8K4Y597m1JZh6lYWyrhauNCHnRh7nGx9wde8hOA/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/Ks2cjC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77256200f1bso2179723b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756866497; x=1757471297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lblPTgYeGtHNKfvL2n8eI3SsVmG/1mWE9ZXzzIlkWfo=;
        b=k/Ks2cjCllUCO0lzYRHdSxrUUIOWewzooVr7cVF9r6LrEtvt0QvjkL9A21ZhPi7Pi6
         9t63W6WihUnr8Qbz7B1epoY02OayD6TiVVVl+ZjWKs4LHUuNJ8z5D2fZV0OdbyT/+9j4
         uee4w3vrDp4VCnFsWQgsegMeq1AYDCbY9Vnhvdjr72z0pgvGsCo4GxzYpp3UJa2siysN
         wR/Y+hdxj8/n6eA6JI+PITguYTNStdhOAG9g53Dchbo0JyX9NVTiyvyyfikCIL7eP8Sc
         ff42STbtaI967ZKl2eq9zVaG7/qV3ShznJIYfZKuWmfHD8nFhinDPx1gKSooLWnO/oDb
         fTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756866497; x=1757471297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lblPTgYeGtHNKfvL2n8eI3SsVmG/1mWE9ZXzzIlkWfo=;
        b=k5NEJexoyM6jzeg28Ef1aBpDIVI3RQNxST2WUmV7Wuqx8PZqzZ4+o95WuaBk/t22Vn
         iBChAwcTm2v3b7KzfOYnAoUFIN8iAGKAYICH0I8b33NrF5Zz0EVHqCjBMeGEJOFSw9wo
         W+VsykboTHCyctTpAd9G0f7HZaociGQ5sjB58a7Fppx/US72Zz9rV5ZD8zLmP/g/RdCH
         hAIqGn+fNVyb6fb1Fr8kTsFmh2xJL558w4FLEgGn7G4YMcKEqBecI+QLQHnYSTsUzihU
         gVAlxQ0GCAnzy3Wi/050L+Svix6NTYrJY0447n9jRq5QCn/d1ZLEXSCrup6bh3v7I7rs
         U96g==
X-Gm-Message-State: AOJu0Yy4yaKEo4KmxlUgVAliPojDrXQL0YpVKDebu6kXkIrzjaveUbbL
	PqyJpf0aJQzXJYJf2V99NW9xjKXsteaVkLVGser6p6Pxgg1z70HAPVkHVSxXAUijOFE=
X-Gm-Gg: ASbGncswrecSxt9f8dHKFifKgq/OWMAO14QVchu4e+kIV9jpQ5y3OxK8gnodpd769eT
	5PNKAWJ7EdYizjjLQiAiCxXuazywNk4OZQqIhvyUHHxxobRVZJxU9BuwKsJQu7PGuXWpv1vSMZq
	akV/N5WiNEZYCAkI1EPTO47WC3lulBrFXXpkKQ9X/R5lr+9FhuZYDqut+eCxai0Sukz6F8wNHaC
	rRSGqumDm6h05kNIh80qCbNXRm+TwZLLbix+DU7NXU30x3zUi5e1Lmfrye/zDcGdJTI30Vg0caM
	p/mPmfaHVVDnp0eEIEVaOG4cp6XME/lQQpwj2WF9RSi1g2e4N/165Fuw/iSNAZ/wrVeLKGJw27X
	/uUlW+2LKw1k1R8NQPuSBVfBPnsfI0X0R
X-Google-Smtp-Source: AGHT+IE42RwQvXyPWDBN+hqUx2NOehVNn+CUJKgQ553VY7ewX3Z/PmGBO9TJRJkDg/JwSlG/TCAkUg==
X-Received: by 2002:a05:6a20:5483:b0:243:ac37:821 with SMTP id adf61e73a8af0-243d6f4243emr18708767637.48.1756866497153;
        Tue, 02 Sep 2025 19:28:17 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bbe10sm15049217b3a.56.2025.09.02.19.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 19:28:16 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and fat_mirror_bhs()
Date: Wed,  3 Sep 2025 10:28:15 +0800
Message-ID: <20250903022815.109-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <874itk20j2.fsf@mail.parknet.co.jp>
References: <874itk20j2.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

OGAWA Hirofumi wrote:
> Sync mount doesn't try to keep all of consistency. It is trying to keep
> sync the minimum blocks for consistency. The primary should be always
> consistent, however this doesn't care much about mirror FAT.

Thanks a lot for your explanation. I understand your point and you are
right.I just noticed that in fat_mirror_bhs(), the buffer head "c_bh" actually
represents the mirror FAT blocks, and the code does:

    if (sb->s_flags & SB_SYNCHRONOUS)
        err = sync_dirty_buffer(c_bh);

So on -o sync mounts the mirror FAT blocks are also forced to disk
immediately.

Thanks.

